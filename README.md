# PostgreSQL Query Rewriting and Indexing

Repositori artefak penelitian tesis S2 Teknologi Informasi, Universitas Mikroskil:

**Evaluasi Eksperimental Strategi Indexing dan SQL Query Rewriting terhadap Performa Query PostgreSQL untuk Mendukung Pengelolaan Basis Data**

Repositori ini berisi skrip, berkas SQL beku, DDL, bukti verifikasi, *manifest hash*, dan (kelak) data mentah hasil pengukuran, agar prosedur eksperimen dapat ditelusuri dan direplikasi. Naskah tesis tidak disimpan di sini.

## Ringkasan penelitian

Penelitian mengukur pengaruh *SQL query rewriting* (korelasi *subquery* ke JOIN dengan tabel turunan), strategi *indexing*, dan interaksi keduanya terhadap *execution time* query PostgreSQL.

| Aspek | Nilai |
|---|---|
| DBMS | PostgreSQL 18.6 |
| Benchmark | TPC-H 3.0.1 (skema 8 tabel, data dari dbgen) |
| Query | Q2, Q17, Q20, satu set parameter validasi bawaan spesifikasi |
| Skala | SF1 dan SF10 (SF0.1 hanya untuk validasi ekuivalensi) |
| Bentuk SQL | O (original) dan R (rewritten); R sah hanya bila hasilnya ekuivalen dengan O |
| Level indeks | I0 (PK saja), I1 (I0 + indeks kolom tunggal FK/korelasi), I2 (I1 + indeks komposit atau *covering*); B-tree, kumulatif |
| Matriks | 2 bentuk × 3 level × 2 skala × 3 query = 36 kondisi |
| Metrik utama | *Execution time* (median dari eksekusi terukur) |
| Indikator pendukung | *Planning time*, *execution plan*, *buffer statistics* |
| Lingkungan | Satu laptop: Intel Core i5-10300H, RAM 8 GB, SSD NVMe, Windows 10 Home SL 22H2 |

**Batas klaim.** Hasil dilaporkan sebagai **beban kerja turunan TPC-H**, bukan hasil TPC-H resmi: bentuk R dan indeks I2 melampaui aturan spesifikasi. Kesimpulan hanya berlaku pada konfigurasi yang diuji dan tidak digeneralisasi ke DBMS, *query*, atau perangkat keras lain.

## Status gerbang prosedur

| Gerbang | Isi | Status | Tag Git |
|---|---|---|---|
| G0 | Lingkungan dan data siap | Lulus | `G0` |
| G1 | Ekuivalensi SQL (tiga lapis) lulus | ⚠ perbarui | ⚠ |
| G2 | Desain indeks dikunci | Belum | |
| G3 | Pilot lulus dan protokol dikunci | Belum | |
| G4 | Eksperimen utama (SF1 lalu SF10; I0, I1, I2, cek ulang I0) | Belum | |
| G5 | Analisis | Belum | |

Eksperimen utama (G4) tidak berjalan sebelum G1 lulus. Perubahan setelah G2 (himpunan indeks, bentuk R, parameter *query*) atau setelah G3 (konfigurasi server, nilai protokol, pita variasi) dicatat sebagai penyimpangan protokol.

## Struktur folder

```
thesis\
  README.md
  environment.txt          versi perangkat lunak dan perangkat keras
  MANIFEST_sha256.csv      hash SHA-256 berkas di documentation\ dan sql\
  dataset\                 berkas .tbl hasil dbgen (TIDAK diunggah)
  tools\                   README.md saja; TPC-H dbgen tidak diunggah
  notes\                   catatan kerja (tidak diunggah)
  script\
    run_g1.ps1             G1 lapis 1 dan 2 (mini, SF0.1, SF1)
    validate.py            pembanding O vs R (EXCEPT ALL dua arah, CSV berhash)
  sql\
    schema\                DDL tabel dan PK
    constraints\           DDL FK (ditambahkan setelah data dimuat)
    load\                  pemuatan data per skala (SF0.1, SF1, SF10)
    config\                alter_configuration.sql (parameter server)
    maintenance\           analyze.sql
    indexes\               create_indexes_I1.sql, create_indexes_I2.sql, reset_to_I0.sql, index_cost.sql
    queries\original\      Q2, Q17, Q20 (bentuk O, dibekukan)
    queries\rewritten\     Q2, Q17, Q20 (bentuk R, dibekukan)
    validation\            validasi constraint, jumlah baris, indeks, encoding
      mini\                tpch_mini_setup.sql (DB mini untuk kasus batas)
      legacy\              skrip validasi lama (tidak dipakai)
  logs\                    keluaran mesin per gerbang
    g0\  g1\  g2\  g3\  g4\
  documentation\
    data-generation\       evidence\, logs\, manifest\ (hash .tbl dan biner dbgen)
    database-validation\   evidence\{g0, screenshots}, reports\
    query-validation\      archive_cte_version\ (laporan lama, tidak dikutip)
```

Aturan pembagian: `logs\` berisi keluaran mentah mesin (CSV, `.jsonl`, skrip `.psql`, *transcript*); `documentation\` berisi bukti naratif dan laporan yang dirujuk lampiran tesis.

## Persyaratan

| Perangkat lunak | Versi |
|---|---|
| PostgreSQL | 18.6 (`SELECT version()` dicatat pada log G0) |
| Python | 3.10.1 |
| Git | 2.34.1.windows.1 |
| PowerShell | 5.1.19041.6456 |
| TPC-H Tools (dbgen/qgen) | paket 3.0.1; versi internal dbgen 3.0.0 *build* 0 |
| HWiNFO | 8.60-6120 (log suhu dan frekuensi CPU, interval 1 detik) |

Kata sandi PostgreSQL **tidak** disimpan di repositori. Gunakan `%APPDATA%\postgresql\pgpass.conf` atau variabel lingkungan `PGPASSWORD` pada sesi.

## Cara mereplikasi

Semua perintah dijalankan dari akar repositori dengan `psql` di `PATH`.

**1. Data (G0).** Bangkitkan data dengan dbgen (perintah dan *hash* tercatat pada `documentation\data-generation\`), lalu:

```powershell
psql -U postgres -d <db> -f sql\schema\tpch_schema.sql
psql -U postgres -d <db> -f sql\load\load_sf1.sql        # atau load_sf01 / load_sf10
psql -U postgres -d <db> -f sql\constraints\tpch_constraints.sql
psql -U postgres -d <db> -f sql\maintenance\analyze.sql
```

Berkas `.tbl` tidak diunggah (ukuran `lineitem` SF10 sekitar 7,8 GB). Verifikasi hasil pembangkitan dengan *hash* pada `documentation\data-generation\manifest\tbl_sha256_*.csv`.

**2. Konfigurasi server.** Nilai efektif disimpan pada `documentation\database-validation\evidence\g0\pg_settings_G0.csv`; skrip perubahan pada `sql\config\alter_configuration.sql`. `statement_timeout` 60 menit dipasang per sesi pengukuran (server tetap 0), dan `autovacuum` dimatikan mulai pilot.

**3. Validasi ekuivalensi (G1).**

```powershell
.\script\run_g1.ps1 -Step mini    # lapis 1: data mini
.\script\run_g1.ps1 -Step sf01    # lapis 2: SF0.1, tiga set parameter
.\script\run_g1.ps1 -Step sf1     # lapis 2 dan 3: SF1 (Q17 dan Q20 pada salinan dengan indeks sementara)
```

Pemanggilan langsung:

```powershell
python script\validate.py --db tpch_sf01 --query Q2 Q17 Q20 --set 1 2 3 --user postgres --note "I0" --out logs\g1\sf01
```

Luaran per eksekusi: `g1_layer2_log.jsonl`, CSV hasil O dan R, skrip `.psql`, dan *transcript* PowerShell.

**4. Indeks dan pengukuran (G2–G4).** Skrip pelaksana, pilot, dan analisis akan ditambahkan pada `script\` setelah G2 terkunci

## Penyimpanan data mentah dan integritas

- Setiap percobaan eksekusi (valid, gagal teknis, atau tersensor) menghasilkan berkas `K##_run_n` pada `logs\g4\raw\` beserta berkas *plan* dan log lingkungan.
- `MANIFEST_sha256.csv` dan `documentation\data-generation\manifest\` memuat *hash* SHA-256 seluruh berkas bukti.
- Penguncian ditandai *tag* Git `G0` sampai `G4`; berkas mentah tidak diubah dan semua tabel hasil dibangkitkan ulang dari berkas tersebut oleh skrip.
- Kondisi yang mencapai `statement_timeout` dilaporkan sebagai data tersensor (batas bawah), bukan sebagai angka.

## Catatan lisensi dan data

- Data bersifat sintetis (dbgen); tidak ada partisipan manusia dan tidak ada data pribadi.
- Biner dan kode sumber TPC-H dbgen **tidak** disertakan. Unduh dari TPC sesuai ketentuan lisensinya dan cocokkan *hash* biner dengan `documentation\data-generation\manifest\dbgen-manifest.txt`.

## Kontak

Louise Derizhy - louise.derizhy@gmai.com