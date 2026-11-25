#!/usr/bin/env python3
"""
freeze_queries.py - G1 langkah 10: periksa / tulis 6 berkas SQL beku (O dan R).

  python script\\freeze_queries.py            -> HANYA memeriksa berkas yang ada (tidak menulis)
  python script\\freeze_queries.py --write    -> menulis 6 berkas (UTF-8 tanpa BOM, akhir baris LF)
  python script\\freeze_queries.py --hash     -> menulis sql\\queries\\SQL_SHA256.csv

Pemeriksaan: ada/tidak, BOM, CRLF, CTE (WITH), ekspresi tanggal Q20, kesamaan teks
dengan versi dalam skrip ini (spasi diabaikan). Dijalankan dari akar repositori.
"""

import argparse
import csv
import datetime
import hashlib
import pathlib
import re
import sys

SQL = {}

SQL[("Q2", "original")] = """SELECT
    s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part, supplier, partsupp, nation, region
WHERE p_partkey = ps_partkey
  AND s_suppkey = ps_suppkey
  AND p_size = 15
  AND p_type LIKE '%BRASS'
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = 'EUROPE'
  AND ps_supplycost = (
      SELECT MIN(ps_supplycost)
      FROM partsupp, supplier, nation, region
      WHERE p_partkey = ps_partkey
        AND s_suppkey = ps_suppkey
        AND s_nationkey = n_nationkey
        AND n_regionkey = r_regionkey
        AND r_name = 'EUROPE'
  )
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey
LIMIT 100;
"""

SQL[
    ("Q2", "rewritten")
] = """SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part
JOIN partsupp ON p_partkey = ps_partkey
JOIN supplier ON s_suppkey = ps_suppkey
JOIN nation   ON s_nationkey = n_nationkey
JOIN region   ON n_regionkey = r_regionkey
JOIN (
    SELECT ps_partkey AS m_partkey, MIN(ps_supplycost) AS min_supplycost
    FROM partsupp
    JOIN supplier ON s_suppkey = ps_suppkey
    JOIN nation   ON s_nationkey = n_nationkey
    JOIN region   ON n_regionkey = r_regionkey
    WHERE r_name = 'EUROPE'
    GROUP BY ps_partkey
) AS msc ON msc.m_partkey = p_partkey AND ps_supplycost = msc.min_supplycost
WHERE p_size = 15 AND p_type LIKE '%BRASS' AND r_name = 'EUROPE'
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey
LIMIT 100;
"""

SQL[("Q17", "original")] = """SELECT SUM(l_extendedprice) / 7.0 AS avg_yearly
FROM lineitem, part
WHERE p_partkey = l_partkey
  AND p_brand = 'Brand#23'
  AND p_container = 'MED BOX'
  AND l_quantity < (
      SELECT 0.2 * AVG(l_quantity)
      FROM lineitem
      WHERE l_partkey = p_partkey
  );
"""

SQL[("Q17", "rewritten")] = """SELECT SUM(l.l_extendedprice) / 7.0 AS avg_yearly
FROM part p
JOIN lineitem l ON p.p_partkey = l.l_partkey
JOIN (
    SELECT l_partkey, AVG(l_quantity) AS avg_quantity
    FROM lineitem
    GROUP BY l_partkey
) aq ON aq.l_partkey = p.p_partkey
WHERE p.p_brand = 'Brand#23' AND p.p_container = 'MED BOX'
  AND l.l_quantity < 0.2 * aq.avg_quantity;
"""

SQL[("Q20", "original")] = """SELECT s_name, s_address
FROM supplier, nation
WHERE s_suppkey IN (
      SELECT ps_suppkey
      FROM partsupp
      WHERE ps_partkey IN (
            SELECT p_partkey
            FROM part
            WHERE p_name LIKE 'forest%'
      )
        AND ps_availqty > (
            SELECT 0.5 * SUM(l_quantity)
            FROM lineitem
            WHERE l_partkey = ps_partkey
              AND l_suppkey = ps_suppkey
              AND l_shipdate >= DATE '1994-01-01'
              AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'
      )
  )
  AND s_nationkey = n_nationkey
  AND n_name = 'CANADA'
ORDER BY s_name;
"""

SQL[("Q20", "rewritten")] = """SELECT s.s_name, s.s_address
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN (
    SELECT DISTINCT ps.ps_suppkey
    FROM partsupp ps
    JOIN part p ON p.p_partkey = ps.ps_partkey
    JOIN (
        SELECT l_partkey, l_suppkey, SUM(l_quantity) AS total_quantity
        FROM lineitem
        WHERE l_shipdate >= DATE '1994-01-01'
          AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'
        GROUP BY l_partkey, l_suppkey
    ) lq ON lq.l_partkey = ps.ps_partkey AND lq.l_suppkey = ps.ps_suppkey
    WHERE p.p_name LIKE 'forest%'
      AND ps.ps_availqty > 0.5 * lq.total_quantity
) qs ON qs.ps_suppkey = s.s_suppkey
WHERE n.n_name = 'CANADA'
ORDER BY s.s_name;
"""


def norm(t):
    return "\n".join(l.rstrip() for l in t.replace("\r\n", "\n").split("\n")).strip()


def squash(t):
    return re.sub(r"\s+", " ", t).strip()


def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    ap.add_argument("--root", default="sql/queries")
    ap.add_argument("--write", action="store_true", help="tulis 6 berkas (menimpa)")
    ap.add_argument("--hash", action="store_true", help="tulis SQL_SHA256.csv")
    a = ap.parse_args()
    root = pathlib.Path(a.root)
    problems = 0
    rows = []

    for (q, kind), text in SQL.items():
        d = root / kind
        d.mkdir(parents=True, exist_ok=True)
        p = d / f"{q}_{kind}.sql"
        if a.write:
            p.write_bytes(text.encode("utf-8"))  # UTF-8 tanpa BOM, LF
            print(f"[tulis] {p}")
        if not p.exists():
            # cari nama berbeda huruf besar/kecil
            alt = [f for f in d.iterdir() if f.name.lower() == p.name.lower()]
            print(
                f"[HILANG] {p}" + (f"  (ada: {alt[0].name}; ganti nama)" if alt else "")
            )
            problems += 1
            continue
        raw = p.read_bytes()
        s = raw.decode("utf-8", errors="replace")
        flags = []
        if raw.startswith(b"\xef\xbb\xbf"):
            flags.append("BOM")
        if raw.startswith(b"\xff\xfe") or raw.startswith(b"\xfe\xff"):
            flags.append("UTF-16")
        if b"\r\n" in raw:
            flags.append("CRLF")
        if re.search(r"(?im)^\s*WITH\b", s):
            flags.append("CTE(WITH)")
        if q == "Q20" and "INTERVAL '1 year'" not in s:
            flags.append("TANGGAL-Q20")
        if squash(s) != squash(text):
            flags.append("TEKS-BERBEDA")
        status = "OK" if not flags else "PERIKSA: " + ", ".join(flags)
        if flags:
            problems += 1
        h = hashlib.sha256(raw).hexdigest()
        rows.append((str(p).replace("\\", "/"), len(raw), h))
        print(f"[{status}] {p}  {h[:16]}")

    if a.hash and rows:
        out = root / "SQL_SHA256.csv"
        with open(out, "w", newline="", encoding="utf-8") as f:
            w = csv.writer(f)
            w.writerow(["path", "bytes", "sha256", "dicatat"])
            for r in rows:
                w.writerow([*r, datetime.datetime.now().isoformat(timespec="seconds")])
        print(f"[hash] {out}")
    print(
        "\nSelesai."
        + (" Ada butir yang perlu diperiksa." if problems else " Semua OK.")
    )
    sys.exit(1 if problems else 0)


if __name__ == "__main__":
    main()
