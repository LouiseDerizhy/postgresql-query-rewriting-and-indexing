#!/usr/bin/env python3
"""
validate.py - G1 Lapis 2: pembandingan SQL original (O) vs rewritten (R).

Membaca berkas SQL yang dibekukan (bukan salinan teks), menjalankan O dan R
dalam SATU sesi psql, lalu memeriksa:
  1. jumlah baris O = R
  2. EXCEPT ALL dua arah = 0
  3. nama dan tipe kolom sama
  4. keluaran CSV berheader identik (urutan baris dan nilai eksak) -> hash SHA-256
Semua perubahan data (opsi --empty) dibatalkan dengan ROLLBACK.

Contoh:
  python validate.py --db tpch_sf01 --query Q2 Q17 Q20 --set 1 2 3 --user postgres
  python validate.py --db tpch_mini --set 1 --user postgres
  python validate.py --db tpch_mini --set 1 --empty --user postgres
  python validate.py --db tpch_sf01 --dry-run          (hanya membuat skrip psql)

Kata sandi: pakai variabel lingkungan PGPASSWORD atau berkas pgpass.conf.
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

# Set 1 = nilai pada berkas beku (parameter validasi TPC-H 3.0.1).
# Set 2 dan 3 = parameter tambahan KHUSUS G1 (bukan untuk pengukuran).
PARAMS = {
    1: {
        "Q2": ("15", "BRASS", "EUROPE"),
        "Q17": ("Brand#23", "MED BOX"),
        "Q20": ("forest", "1994-01-01", "CANADA"),
    },
    2: {
        "Q2": ("10", "STEEL", "ASIA"),
        "Q17": ("Brand#12", "SM CASE"),
        "Q20": ("azure", "1995-01-01", "FRANCE"),
    },
    3: {
        "Q2": ("30", "COPPER", "AMERICA"),
        "Q17": ("Brand#45", "LG PACK"),
        "Q20": ("khaki", "1996-01-01", "JAPAN"),
    },
}


def token_pairs(q, p_from, p_to):
    """Pasangan (teks lama, teks baru) untuk mengganti nilai parameter."""
    if q == "Q2":
        (s0, t0, r0), (s1, t1, r1) = p_from, p_to
        return [
            (f"p_size = {s0}", f"p_size = {s1}"),
            (f"'%{t0}'", f"'%{t1}'"),
            (f"'{r0}'", f"'{r1}'"),
        ]
    if q == "Q17":
        (b0, c0), (b1, c1) = p_from, p_to
        return [(f"'{b0}'", f"'{b1}'"), (f"'{c0}'", f"'{c1}'")]
    if q == "Q20":
        (k0, d0, n0), (k1, d1, n1) = p_from, p_to
        return [
            (f"'{k0}%'", f"'{k1}%'"),
            (f"DATE '{d0}'", f"DATE '{d1}'"),
            (f"'{n0}'", f"'{n1}'"),
        ]
    raise ValueError(q)


def apply_set(q, sql, set_id, label):
    if q == "Q20" and "INTERVAL '1 year'" not in sql:
        sys.exit(
            f"[{label}] Q20 harus memakai DATE '1994-01-01' + INTERVAL '1 year' "
            f"(bukan literal tanggal akhir); samakan O dan R."
        )
    if set_id == 1:
        return sql
    for old, new in token_pairs(q, PARAMS[1][q], PARAMS[set_id][q]):
        if old not in sql:
            sys.exit(
                f"[{label}] token '{old}' tidak ditemukan; berkas beku berbeda "
                f"dari format yang diasumsikan. Periksa teks SQL."
            )
        sql = sql.replace(old, new)
    return sql


def find_file(directory, q, kind):
    """Cari {q}_{kind}.sql tanpa membedakan huruf besar/kecil (mis. q20_original.sql)."""
    want = f"{q}_{kind}.sql".lower()
    for f in pathlib.Path(directory).iterdir():
        if f.name.lower() == want:
            return f
    sys.exit(f"Berkas {q}_{kind}.sql tidak ada di {directory}")


def strip_sql(sql):
    return sql.strip().rstrip(";").strip()


def build_script(o_sql, r_sql, o_csv, r_csv, empty, timeout_min):
    L = ["\\set ON_ERROR_STOP on"]
    if timeout_min:
        L.append(f"SET statement_timeout = '{timeout_min}min';")
    L.append("BEGIN;")
    if empty:
        L += ["DELETE FROM lineitem;", "DELETE FROM partsupp;"]
    L.append(f"CREATE TEMP TABLE _o AS (\n{o_sql}\n);")
    L.append(f"CREATE TEMP TABLE _r AS (\n{r_sql}\n);")
    L.append(f"\\copy (SELECT * FROM _o) TO '{o_csv}' WITH (FORMAT csv, HEADER)")
    L.append(f"\\copy (SELECT * FROM _r) TO '{r_csv}' WITH (FORMAT csv, HEADER)")
    cols = (
        "SELECT attname || ':' || format_type(atttypid, atttypmod) FROM pg_attribute "
        "WHERE attrelid = '{t}'::regclass AND attnum > 0 AND NOT attisdropped "
        "ORDER BY attnum;"
    )
    L += [
        "\\echo @@ROWS_O",
        "SELECT count(*) FROM _o;",
        "\\echo @@ROWS_R",
        "SELECT count(*) FROM _r;",
        "\\echo @@DIFF_OR",
        "SELECT count(*) FROM (SELECT * FROM _o EXCEPT ALL SELECT * FROM _r) d;",
        "\\echo @@DIFF_RO",
        "SELECT count(*) FROM (SELECT * FROM _r EXCEPT ALL SELECT * FROM _o) d;",
        "\\echo @@COLS_O",
        cols.format(t="_o"),
        "\\echo @@COLS_R",
        cols.format(t="_r"),
        "\\echo @@END",
        "ROLLBACK;",
    ]
    return "\n".join(L) + "\n"


def parse(out):
    sec, cur = {}, None
    for line in out.splitlines():
        if line.startswith("@@"):
            cur = line[2:].strip()
            sec[cur] = []
            if cur == "END":
                break
        elif cur:
            sec[cur].append(line.strip())
    return sec


def sha(path):
    return hashlib.sha256(pathlib.Path(path).read_bytes()).hexdigest()


def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    ap.add_argument("--db", required=True)
    ap.add_argument(
        "--query", nargs="+", default=["Q2", "Q17", "Q20"], choices=["Q2", "Q17", "Q20"]
    )
    ap.add_argument(
        "--set", nargs="+", type=int, default=[1], choices=[1, 2, 3], dest="sets"
    )
    ap.add_argument("--odir", default="./sql/queries/original")
    ap.add_argument("--rdir", default="./sql/queries/rewritten")
    ap.add_argument("--out", default="logs/g1")
    ap.add_argument("--host")
    ap.add_argument("--port")
    ap.add_argument("--user")
    ap.add_argument("--psql", default="psql")
    ap.add_argument(
        "--empty",
        action="store_true",
        help="uji hasil kosong: hapus lineitem dan partsupp di dalam transaksi lalu ROLLBACK",
    )
    ap.add_argument(
        "--timeout-min",
        type=int,
        default=0,
        help="statement_timeout (menit); 0 = tanpa batas",
    )
    ap.add_argument(
        "--note",
        default="",
        help="catatan konfigurasi, mis. 'I0' atau 'I0 + ix1_lineitem_partkey (sementara)'",
    )
    ap.add_argument(
        "--dry-run",
        action="store_true",
        help="hanya tulis skrip psql, tidak dijalankan",
    )
    a = ap.parse_args()

    out = pathlib.Path(a.out)
    (out / "csv").mkdir(parents=True, exist_ok=True)
    log_path = out / "g1_layer2_log.jsonl"
    results = []
    env = dict(os.environ, PGCLIENTENCODING="UTF8")

    for q in a.query:
        of, rf = find_file(a.odir, q, "original"), find_file(a.rdir, q, "rewritten")
        o_raw, r_raw = of.read_text(encoding="utf-8"), rf.read_text(encoding="utf-8")
        for s in a.sets:
            tag = f"{a.db}_{q}_set{s}" + ("_empty" if a.empty else "")
            o_sql = strip_sql(apply_set(q, o_raw, s, f"{q} O set{s}"))
            r_sql = strip_sql(apply_set(q, r_raw, s, f"{q} R set{s}"))
            o_csv = (out / "csv" / f"{tag}_O.csv").resolve().as_posix()
            r_csv = (out / "csv" / f"{tag}_R.csv").resolve().as_posix()
            script = build_script(o_sql, r_sql, o_csv, r_csv, a.empty, a.timeout_min)
            sp = out / f"{tag}.psql"
            sp.write_text(script, encoding="utf-8")
            if a.dry_run:
                print(f"[dry-run] {sp}")
                continue

            cmd = [
                a.psql,
                "-X",
                "-q",
                "-A",
                "-t",
                "-d",
                a.db,
                "-v",
                "ON_ERROR_STOP=1",
                "-f",
                str(sp),
            ]
            for flag, val in (("-h", a.host), ("-p", a.port), ("-U", a.user)):
                if val:
                    cmd += [flag, val]
            t0 = time.time()
            r = subprocess.run(
                cmd, capture_output=True, text=True, encoding="utf-8", env=env
            )
            secs = round(time.time() - t0, 1)
            if r.returncode != 0:
                sys.exit(f"psql gagal untuk {tag}:\n{r.stderr}")
            sec = parse(r.stdout)
            rec = {
                "timestamp": datetime.datetime.now().isoformat(timespec="seconds"),
                "db": a.db,
                "query": q,
                "param_set": s,
                "empty_test": a.empty,
                "note": a.note,
                "rows_O": int(sec["ROWS_O"][0]),
                "rows_R": int(sec["ROWS_R"][0]),
                "O_minus_R": int(sec["DIFF_OR"][0]),
                "R_minus_O": int(sec["DIFF_RO"][0]),
                "columns_equal": sec["COLS_O"] == sec["COLS_R"],
                "columns": sec["COLS_O"],
                "csv_sha256_O": sha(o_csv),
                "csv_sha256_R": sha(r_csv),
                "sql_sha256_O": hashlib.sha256(of.read_bytes()).hexdigest(),
                "sql_sha256_R": hashlib.sha256(rf.read_bytes()).hexdigest(),
                "elapsed_s": secs,
            }
            rec["csv_equal"] = rec["csv_sha256_O"] == rec["csv_sha256_R"]
            rec["status"] = (
                "PASS"
                if (
                    rec["rows_O"] == rec["rows_R"]
                    and rec["O_minus_R"] == 0
                    and rec["R_minus_O"] == 0
                    and rec["columns_equal"]
                    and rec["csv_equal"]
                )
                else "FAIL"
            )
            rec["warning"] = (
                "hasil kosong pada uji non-kosong: uji lemah"
                if (rec["rows_O"] == 0 and not a.empty)
                else ""
            )
            results.append(rec)
            with open(log_path, "a", encoding="utf-8") as f:
                f.write(json.dumps(rec, ensure_ascii=False) + "\n")

    if a.dry_run:
        return
    print(
        f"\n{'db':12} {'Q':4} {'set':3} {'rowsO':>6} {'rowsR':>6} {'O-R':>4} {'R-O':>4} {'kolom':>6} {'csv':>5} {'detik':>8}  status"
    )
    for x in results:
        print(
            f"{x['db']:12} {x['query']:4} {x['param_set']:<3} {x['rows_O']:>6} {x['rows_R']:>6} "
            f"{x['O_minus_R']:>4} {x['R_minus_O']:>4} {x['columns_equal']!s:>6} "
            f"{x['csv_equal']!s:>5} {x['elapsed_s']:>8}  {x['status']} {x['warning']}"
        )
    print(f"\nLog: {log_path}")
    sys.exit(0 if all(x["status"] == "PASS" for x in results) else 1)


if __name__ == "__main__":
    main()
