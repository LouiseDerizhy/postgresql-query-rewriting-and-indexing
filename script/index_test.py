#!/usr/bin/env python3
"""
index_test.py - G2 langkah 17: uji skrip indeks I1, I2, dan pengembalian ke I0.

Alur (satu basis data, mis. tpch_sf1):
  1. Keadaan awal harus I0 (8 indeks PK, 8 indeks pk_*, sesuai Tabel B.1).
  2. Jalankan B.2 (I1)  -> harus 13 indeks, definisi sama dengan Tabel B.1.
  3. Jalankan B.3 (I2)  -> harus 17 indeks, definisi sama dengan Tabel B.1.
  4. Jalankan B.4 (reset) -> harus kembali 8 indeks, daftar identik dengan keadaan awal.
  5. VACUUM (ANALYZE) agar basis data kembali ke keadaan baseline (Asumsi A3).
Pada tiap tahap: daftar indeks dari pg_indexes dibandingkan dengan daftar harapan
(selisih dua arah harus NOL baris). Waktu pembuatan dan ukuran indeks dicatat
sebagai UJI (bukan data pengukuran G4).

Contoh (dari akar repositori):
  python script\\index_test.py --db tpch_sf1 --user postgres
  python script\\index_test.py --db tpch_sf1 --user postgres --dry-run   (hanya cek berkas dan keadaan awal)

Kata sandi: PGPASSWORD atau pgpass.conf.
"""

import argparse
import datetime
import hashlib
import json
import os
import pathlib
import subprocess
import sys
import time

PK = {
    "pk_region": "CREATE UNIQUE INDEX pk_region ON public.region USING btree (r_regionkey)",
    "pk_nation": "CREATE UNIQUE INDEX pk_nation ON public.nation USING btree (n_nationkey)",
    "pk_part": "CREATE UNIQUE INDEX pk_part ON public.part USING btree (p_partkey)",
    "pk_supplier": "CREATE UNIQUE INDEX pk_supplier ON public.supplier USING btree (s_suppkey)",
    "pk_partsupp": "CREATE UNIQUE INDEX pk_partsupp ON public.partsupp USING btree (ps_partkey, ps_suppkey)",
    "pk_customer": "CREATE UNIQUE INDEX pk_customer ON public.customer USING btree (c_custkey)",
    "pk_orders": "CREATE UNIQUE INDEX pk_orders ON public.orders USING btree (o_orderkey)",
    "pk_lineitem": "CREATE UNIQUE INDEX pk_lineitem ON public.lineitem USING btree (l_orderkey, l_linenumber)",
}
I1 = {
    "ix1_nation_regionkey": "CREATE INDEX ix1_nation_regionkey ON public.nation USING btree (n_regionkey)",
    "ix1_supplier_nationkey": "CREATE INDEX ix1_supplier_nationkey ON public.supplier USING btree (s_nationkey)",
    "ix1_partsupp_suppkey": "CREATE INDEX ix1_partsupp_suppkey ON public.partsupp USING btree (ps_suppkey)",
    "ix1_lineitem_partkey": "CREATE INDEX ix1_lineitem_partkey ON public.lineitem USING btree (l_partkey)",
    "ix1_lineitem_suppkey": "CREATE INDEX ix1_lineitem_suppkey ON public.lineitem USING btree (l_suppkey)",
}
I2 = {
    "ix2_lineitem_ps_cover": "CREATE INDEX ix2_lineitem_ps_cover ON public.lineitem USING btree (l_partkey, l_suppkey, l_shipdate) INCLUDE (l_quantity, l_extendedprice)",
    "ix2_part_brand_container": "CREATE INDEX ix2_part_brand_container ON public.part USING btree (p_brand, p_container) INCLUDE (p_partkey)",
    "ix2_part_size": "CREATE INDEX ix2_part_size ON public.part USING btree (p_size) INCLUDE (p_partkey, p_type, p_mfgr)",
    "ix2_partsupp_cover": "CREATE INDEX ix2_partsupp_cover ON public.partsupp USING btree (ps_partkey) INCLUDE (ps_suppkey, ps_supplycost, ps_availqty)",
}


def sha(p):
    return hashlib.sha256(pathlib.Path(p).read_bytes()).hexdigest()


class Pg:
    def __init__(self, a):
        self.base = [
            a.psql,
            "-X",
            "-q",
            "-A",
            "-t",
            "-d",
            a.db,
            "-v",
            "ON_ERROR_STOP=1",
        ]
        for flag, val in (("-h", a.host), ("-p", a.port), ("-U", a.user)):
            if val:
                self.base += [flag, val]
        self.env = dict(os.environ, PGCLIENTENCODING="UTF8")

    def run(self, *extra):
        r = subprocess.run(
            self.base + list(extra),
            capture_output=True,
            text=True,
            encoding="utf-8",
            env=self.env,
        )
        if r.returncode != 0:
            sys.exit(f"psql gagal: {' '.join(extra)}\n{r.stderr}")
        return r.stdout

    def indexes(self):
        out = self.run(
            "-F",
            "|",
            "-c",
            "SELECT indexname, indexdef FROM pg_indexes WHERE schemaname='public' "
            "AND tablename IN ('region','nation','part','supplier','partsupp','customer','orders','lineitem') "
            "ORDER BY indexname;",
        )
        d = {}
        for line in out.splitlines():
            if line.strip():
                n, df = line.split("|", 1)
                d[n] = df.strip()
        return d

    def sizes(self, names):
        if not names:
            return {}
        q = ", ".join(f"('{n}')" for n in names)
        out = self.run(
            "-F",
            "|",
            "-c",
            f"SELECT n, pg_relation_size(format('public.%I', n)::regclass) FROM (VALUES {q}) v(n);",
        )
        return {
            l.split("|")[0]: int(l.split("|")[1]) for l in out.splitlines() if l.strip()
        }


def diff(expected, actual):
    missing = sorted(set(expected) - set(actual))
    extra = sorted(set(actual) - set(expected))
    wrong = sorted(n for n in expected if n in actual and expected[n] != actual[n])
    return missing, extra, wrong


def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    ap.add_argument("--db", required=True)
    ap.add_argument("--host")
    ap.add_argument("--port")
    ap.add_argument("--user")
    ap.add_argument("--psql", default="psql")
    ap.add_argument("--i1", default="sql/indexes/create_indexes_I1.sql")
    ap.add_argument("--i2", default="sql/indexes/create_indexes_I2.sql")
    ap.add_argument("--reset", default="sql/indexes/reset_index.sql")
    ap.add_argument("--out", default="logs/g2")
    ap.add_argument("--no-vacuum", action="store_true")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()

    files = {
        "I1": pathlib.Path(a.i1),
        "I2": pathlib.Path(a.i2),
        "reset": pathlib.Path(a.reset),
    }
    for k, p in files.items():
        if not p.exists():
            sys.exit(f"Berkas {k} tidak ada: {p}  (gunakan --i1/--i2/--reset)")
    out = pathlib.Path(a.out)
    out.mkdir(parents=True, exist_ok=True)
    pg = Pg(a)

    stages = [("I0 awal", dict(PK), None)]
    I1all = {**PK, **I1}
    I2all = {**I1all, **I2}
    stages += [
        ("I1", I1all, "I1"),
        ("I2", I2all, "I2"),
        ("Reset ke I0", dict(PK), "reset"),
    ]

    rows, initial, ok_all = [], None, True
    for label, expected, key in stages:
        secs = None
        if key:
            if a.dry_run:
                print(f"[dry-run] akan menjalankan {files[key]}")
                continue
            t0 = time.time()
            pg.run("-f", str(files[key]))
            secs = round(time.time() - t0, 2)
        elif a.dry_run:
            pass
        actual = pg.indexes()
        if initial is None:
            initial = dict(actual)
        missing, extra, wrong = diff(expected, actual)
        extra_vs_initial = []
        if label.startswith("Reset"):
            m2, e2, w2 = diff(initial, actual)
            extra_vs_initial = m2 + e2 + w2
        ix_names = [n for n in actual if n.startswith("ix")]
        sz = pg.sizes(ix_names)
        ok = not (missing or extra or wrong or extra_vs_initial)
        ok_all &= ok
        if label == "I0 awal" and not ok and not a.dry_run:
            sys.exit(
                f"Keadaan awal bukan I0 (hilang={missing}, berlebih={extra}, definisi beda={wrong}). "
                f"Jalankan skrip reset (B.4) dulu, lalu ulangi. Tidak ada perubahan dibuat."
            )
        rec = {
            "timestamp": datetime.datetime.now().isoformat(timespec="seconds"),
            "db": a.db,
            "tahap": label,
            "diharapkan": len(expected),
            "aktual": len(actual),
            "hilang": missing,
            "berlebih": extra,
            "definisi_beda": wrong,
            "beda_dari_awal": extra_vs_initial,
            "detik_pembuatan": secs,
            "ukuran_indeks_tambahan_byte": sum(sz.values()),
            "ukuran_per_indeks": sz,
            "sha256_skrip": sha(files[key]) if key else None,
            "status": "LULUS" if ok else "GAGAL",
        }
        rows.append(rec)
        safe = label.replace(" ", "_")
        (out / f"indexes_{a.db}_{safe}.csv").write_text(
            "indexname,indexdef\n"
            + "\n".join(f'{n},"{d}"' for n, d in sorted(actual.items()))
            + "\n",
            encoding="utf-8",
        )
        with open(out / "g2_index_test.jsonl", "a", encoding="utf-8") as f:
            f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        if a.dry_run:
            break

    if not a.dry_run and not a.no_vacuum and ok_all:
        pg.run("-c", "VACUUM (ANALYZE);")
        print("VACUUM (ANALYZE) dijalankan.")

    print(
        f"\n{'tahap':14} {'harap':>5} {'aktual':>6} {'hilang':>6} {'lebih':>5} {'beda':>5} {'detik':>8} {'ukuran idx tambahan (MB)':>26}  status"
    )
    for r in rows:
        print(
            f"{r['tahap']:14} {r['diharapkan']:>5} {r['aktual']:>6} {len(r['hilang']):>6} {len(r['berlebih']):>5} "
            f"{len(r['definisi_beda']) + len(r['beda_dari_awal']):>5} {r['detik_pembuatan'] or '-'!s:>8} "
            f"{r['ukuran_indeks_tambahan_byte'] / 1048576:>26.1f}  {r['status']}"
        )
    print(f"\nLog: {out / 'g2_index_test.jsonl'}")
    sys.exit(0 if ok_all else 1)


if __name__ == "__main__":
    main()
