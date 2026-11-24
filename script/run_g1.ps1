# script\run_g1.ps1
# G1 Lapis 1 dan 2. Dapat dijalankan dari folder mana pun; skrip pindah ke akar repositori.
#   .\script\run_g1.ps1 -Step mini     # DB mini (lapis 1)
#   .\script\run_g1.ps1 -Step sf01     # SF0.1 dengan parameter set 1, 2, 3 (lapis 2)
#   .\script\run_g1.ps1 -Step sf1      # SF1 (lapis 2 dan bahan lapis 3); butuh tpch_sf1_eq (lihat catatan)
#   .\script\run_g1.ps1 -Step all      # mini + sf01 + sf1
#
# KATA SANDI: jangan ditulis di berkas ini. Pakai %APPDATA%\postgresql\pgpass.conf:
#   localhost:5432:*:postgres:<kata sandi>
# atau isi $env:PGPASSWORD pada sesi PowerShell sebelum menjalankan skrip.
#
# CATATAN tpch_sf1_eq (dibuat manual sebelum -Step sf1, lihat panduan):
#   CREATE DATABASE tpch_sf1_eq TEMPLATE tpch_sf1 STRATEGY file_copy;
#   \c tpch_sf1_eq
#   CREATE INDEX ix1_lineitem_partkey ON public.lineitem USING btree (l_partkey);
#   VACUUM (ANALYZE);

param([ValidateSet("mini", "sf01", "sf1", "all")][string]$Step = "all")

$ErrorActionPreference = "Stop"
Set-Location C:\Coding\thesis
$env:Path += ";C:\Program Files\PostgreSQL\18\bin"

New-Item -ItemType Directory -Force logs\g1\mini, logs\g1\sf01, logs\g1\sf1 | Out-Null
Start-Transcript -Path ("logs\g1\transcript_{0}_{1:yyyyMMdd_HHmmss}.txt" -f $Step, (Get-Date))

function Run-Validate($argsList) {
    python script\validate.py @argsList
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "validate.py selesai dengan kode $LASTEXITCODE (ada FAIL atau galat)"
    }
}

if ($Step -in "mini", "all") {
    psql -U postgres -d postgres -f sql\validation\mini\tpch_mini_setup.sql 2>&1 | Tee-Object logs\g1\mini\setup.log
    Run-Validate "--db", "tpch_mini", "--set", "1", "--user", "postgres", "--note", "mini", "--out", "logs\g1\mini"
    Run-Validate "--db", "tpch_mini", "--set", "1", "--empty", "--user", "postgres", "--note", "mini, hasil kosong", "--out", "logs\g1\mini"
}

if ($Step -in "sf01", "all") {
    Run-Validate "--db", "tpch_sf01", "--query", "Q2", "Q17", "Q20", "--set", "1", "2", "3", "--user", "postgres", "--note", "I0; set 1 = validasi spesifikasi, set 2 dan 3 = tambahan G1", "--out", "logs\g1\sf01"
}

if ($Step -in "sf1", "all") {
    Run-Validate "--db", "tpch_sf1", "--query", "Q2", "--set", "1", "--user", "postgres", "--note", "I0", "--out", "logs\g1\sf1"
    Run-Validate "--db", "tpch_sf1_eq", "--query", "Q17", "Q20", "--set", "1", "--user", "postgres", "--note", "I0 + ix1_lineitem_partkey (sementara)", "--timeout-min", "30", "--out", "logs\g1\sf1"
}

Stop-Transcript