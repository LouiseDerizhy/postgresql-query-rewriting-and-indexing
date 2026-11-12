**EVALUASI EKSPERIMENTAL STRATEGI INDEXING DAN SQL QUERY REWRITING TERHADAP PERFORMA QUERY POSTGRESQL UNTUK MENDUKUNG PENGELOLAAN BASIS DATA**

**TESIS**

**PROGRAM STUDI S-2 TEKNOLOGI INFORMASI**

**FAKULTAS INFORMATIKA**

**UNIVERSITAS MIKROSKIL**

**MEDAN**

**2026**

**DAFTAR ISI**

[DAFTAR SINGKATAN DAN NOTASI 5](#daftar-gambar)

[BAB I PENDAHULUAN 6](#bab-ipendahuluan)

[1.1 Latar Belakang 6](#11-latar-belakang)

[1.2 Rumusan Masalah 8](#12-rumusan-masalah)

[1.3 Tujuan 8](#13-tujuan)

[1.4 Manfaat 9](#14-manfaat)

[1.5 Ruang Lingkup 9](#15-ruang-lingkup)

[BAB II KAJIAN LITERATUR 11](#bab-iikajian-literatur)

[2.1 State of the Art 11](#21-state-of-the-art)

[2.1.1 Penelitian tentang Optimasi Query dan Pemilihan Execution Plan 11](#211-penelitian-tentang-optimasi-query-dan-pemilihan-execution-plan)

[2.1.2 Penelitian tentang SQL Query Rewriting dan Query Decorrelation 12](#212-penelitian-tentang-sql-query-rewriting-dan-query-decorrelation)

[2.1.3 Penelitian tentang Indexing dan Strategi Akses Data 13](#213-penelitian-tentang-indexing-dan-strategi-akses-data)

[2.1.4 Penelitian tentang Evaluasi Performa dan Eksperimen Optimasi Query 15](#214-penelitian-tentang-evaluasi-performa-dan-eksperimen-optimasi-query)

[2.2 Sintesis Kritis dan Kesenjangan Penelitian 16](#22-sintesis-kritis-dan-kesenjangan-penelitian)

[2.2.1 Perbandingan Temuan dan Metode Penelitian Terdahulu 16](#221-perbandingan-temuan-dan-metode-penelitian-terdahulu)

[2.2.2 Keterbatasan yang Didukung Sumber 18](#222-keterbatasan-yang-didukung-sumber)

[2.2.3 Celah Penelitian dan Dasar Penelitian 18](#223-celah-penelitian-dan-dasar-penelitian)

[2.3 Tinjauan Objek, Konteks, dan Arsitektur Penelitian 19](#23-tinjauan-objek-konteks-dan-arsitektur-penelitian)

[2.3.1 PostgreSQL 18.6 19](#231-postgresql-186)

[2.3.2 Benchmark TPC-H 20](#232-benchmark-tpc-h)

[2.3.3 Query TPC-H Q2, Q17, dan Q20 21](#233-query-tpc-h-q2-q17-dan-q20)

[2.3.4 Skala Dataset SF1 dan SF10 22](#234-skala-dataset-sf1-dan-sf10)

[2.3.5 Arsitektur dan Lingkungan Teknis Penelitian 23](#235-arsitektur-dan-lingkungan-teknis-penelitian)

[2.4 Landasan Teoretis dan Kerangka Konseptual 23](#24-landasan-teoretis-dan-kerangka-konseptual)

[2.4.1 Pemrosesan dan Optimasi Query sebagai Dasar Pengamatan Kinerja 23](#241-pemrosesan-dan-optimasi-query-sebagai-dasar-pengamatan-kinerja)

[2.4.2 SQL Query Rewriting dan Decorrelation 24](#242-sql-query-rewriting-dan-decorrelation)

[2.4.3 Indexing dan Strategi Data Akses 26](#243-indexing-dan-strategi-data-akses)

[2.4.4 Hubungan antara Rewriting, Indexing, Execution Plan, dan Performa 26](#244-hubungan-antara-rewriting-indexing-execution-plan-dan-performa)

[2.4.5 Kerangka Konseptual Penelitian 27](#245-kerangka-konseptual-penelitian)

[2.5 Operasionalisasi Konstruk dan Parameter Penelitian 28](#25-operasionalisasi-konstruk-dan-parameter-penelitian)

[2.5.1 Faktor Eksperimen dan Kondisi Penelitian 28](#251-faktor-eksperimen-dan-kondisi-penelitian)

[2.5.2 Indikator Performa dan Sumber Pengukuran 29](#252-indikator-performa-dan-sumber-pengukuran)

[2.5.3 Indikator Turunan 31](#253-indikator-turunan)

[2.5.4 Variabel Kontrol dan Batas Operasional 32](#254-variabel-kontrol-dan-batas-operasional)

[2.6 Posisi Penelitian dan Pernyataan Kebaruan 32](#26-posisi-penelitian-dan-pernyataan-kebaruan)

[2.6.1 Posisi Penelitian di antara Studi Terdahulu 32](#261-posisi-penelitian-di-antara-studi-terdahulu)

[2.6.2 Kontribusi Empiris yang Dituju 33](#262-kontribusi-empiris-yang-dituju)

[2.6.3 Pernyataan Kebaruan dan Batasnya 34](#263-pernyataan-kebaruan-dan-batasnya)

[2.6.4 Batas Generalisasi Hasil 35](#264-batas-generalisasi-hasil)

[BAB III METODOLOGI PENELITIAN 37](#bab-iiimetodologi-penelitian)

[3.1 Analisis Masalah dan Formulasi 37](#31-analisis-masalah-dan-formulasi)

[3.1.1 Alur Input-Proses-Output 37](#311-alur-input-proses-output)

[3.1.2 Ringkasan Kesenjangan 38](#312-ringkasan-kesenjangan)

[3.1.3 Asumsi 38](#313-asumsi)

[3.1.4 Skenario dan Struktur Kondisi Eksperimen 39](#314-skenario-dan-struktur-kondisi-eksperimen)

[3.1.5 Unit Analisis 39](#315-unit-analisis)

[3.1.6 Pemetaan Rumusan Masalah ke Keluaran 39](#316-pemetaan-rumusan-masalah-ke-keluaran)

[3.2 Research Design 40](#32-research-design)

[3.2.1 Pendekatan Eksperimen 40](#321-pendekatan-eksperimen)

[3.2.2 Desain Faktorial Penuh Terblok 40](#322-desain-faktorial-penuh-terblok)

[3.2.3 Variabel Penelitian 42](#323-variabel-penelitian)

[3.2.4 Batas Inferensi 43](#324-batas-inferensi)

[3.3 Data, Sampling, dan Partisipan 43](#33-data-sampling-dan-partisipan)

[3.3.1 Partisipan dan Sumber Data 43](#331-partisipan-dan-sumber-data)

[3.3.2 Populasi, Sampel, dan Justifikasi 44](#332-populasi-sampel-dan-justifikasi)

[3.3.3 Pembangkitan, Pemuatan, dan Verifikasi Data 44](#333-pembangkitan-pemuatan-dan-verifikasi-data)

[3.3.4 Parameter _Query_ serta Inklusi dan Eksklusi 45](#334-parameter-query-serta-inklusi-dan-eksklusi)

[3.4 Instrumentasi dan Lingkungan Penelitian 47](#34-instrumentasi-dan-lingkungan-penelitian)

[3.4.1 Perangkat Keras dan Sistem Operasi 47](#341-perangkat-keras-dan-sistem-operasi)

[3.4.2 Perangkat Lunak 47](#342-perangkat-lunak)

[3.4.3 Konfigurasi Server 48](#343-konfigurasi-server)

[3.4.4 Instrumen Ukur 49](#344-instrumen-ukur)

[3.4.5 Kontrol Lingkungan 50](#345-kontrol-lingkungan)

[3.4.6 Struktur Repositori 51](#346-struktur-repositori)

[3.5 Kerangka dan Arsitektur Eksperimen 51](#35-kerangka-dan-arsitektur-eksperimen)

[3.5.1 Arsitektur Kerangka 52](#351-arsitektur-kerangka)

[3.5.2 Rasional Teoritis 53](#352-rasional-teoritis)

[3.5.3 Rancangan Level Indeks 53](#353-rancangan-level-indeks)

[3.5.4 Rancangan Bentuk R 55](#354-rancangan-bentuk-r)

[3.5.5 Kriteria Kesetaraan Hasil 56](#355-kriteria-kesetaraan-hasil)

[3.6 Prosedur Eksperimen dan Validasi 57](#36-prosedur-eksperimen-dan-validasi)

[3.6.1 Baseline, Perlakuan, dan Pembanding 57](#361-baseline-perlakuan-dan-pembanding)

[3.6.2 Gerbang Prosedur 57](#362-gerbang-prosedur)

[3.6.3 Validasi Ekuivalensi SQL 59](#363-validasi-ekuivalensi-sql)

[3.6.4 Protokol per Kondisi 59](#364-protokol-per-kondisi)

[3.6.5 Urutan dan Pergantian Level 61](#365-urutan-dan-pergantian-level)

[3.6.6 Pilot 62](#366-pilot)

[3.6.7 Penyimpangan Protokol 63](#367-penyimpangan-protokol)

[3.6.8 Penyimpanan Data Mentah 63](#368-penyimpanan-data-mentah)

[3.7 Analisis dan Evaluasi Data 64](#37-analisis-dan-evaluasi-data)

[3.7.1 Pendekatan Analisis 64](#371-pendekatan-analisis)

[3.7.2 Ringkasan per Kondisi 64](#372-ringkasan-per-kondisi)

[3.7.3 Indikator Turunan dan Skala Logaritmik 64](#373-indikator-turunan-dan-skala-logaritmik)

[3.7.4 Pita Variasi dan Klasifikasi Perubahan 65](#374-pita-variasi-dan-klasifikasi-perubahan)

[3.7.5 Data Tersensor 67](#375-data-tersensor)

[3.7.6 Plan dan Buffer 68](#376-plan-dan-buffer)

[3.7.7 Analisis Manfaat dan Biaya Indeks 68](#377-analisis-manfaat-dan-biaya-indeks)

[3.8 Validitas, Reliabilitas, dan Ancaman terhadap Validitas 69](#38-validitas-reliabilitas-dan-ancaman-terhadap-validitas)

[3.8.1 Validitas Konstruk 69](#381-validitas-konstruk)

[3.8.2 Validitas Internal dan Bias 70](#382-validitas-internal-dan-bias)

[3.8.3 Validitas Eksternal 71](#383-validitas-eksternal)

[3.8.4 Reliabilitas dan Reproduktibilitas 71](#384-reliabilitas-dan-reproduktibilitas)

[3.8.5 Keterbatasan 72](#385-keterbatasan)

[3.9 Tahapan Penelitian 72](#39-tahapan-penelitian)

[3.9.1 Tahapan 72](#391-tahapan)

[3.9.2 Estimasi Waktu Eksperimen Utama 72](#392-estimasi-waktu-eksperimen-utama)

[DAFTAR PUSTAKA 74](#daftar-pustaka)

# DAFTAR GAMBAR

# DAFTAR SINGKATAN DAN NOTASI

| **Simbol**                                                                        | **Arti**                                                            |
| --------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| DBMS, SQL, SF, PK, FK, DDL, CTE, LLM, JOB                                         | Sesuai pada kemunculan pertama                                      |
| TPC-H                                                                             | Benchmark decision support dari TPC                                 |
| RM                                                                                | Rumusan masalah                                                     |
| O, R                                                                              | Bentuk SQL asli dan hasil rewriting                                 |
| I0, I1, I2                                                                        | Level indeks (kumulatif)                                            |
| G0–G5                                                                             | Gerbang prosedur (Subbab 3.6.2)                                     |
| K01–K36                                                                           | Kode kondisi eksperimen                                             |
| q, f, ℓ, s                                                                        | Query (Q2, Q17, Q20), bentuk SQL, level indeks (ℓ ∈ {0,1,2}), skala |
| T(q, f, ℓ, s)                                                                     | Median execution time suatu kondisi                                 |
| n, τ                                                                              | Jumlah eksekusi terukur; nilai statement_timeout                    |
| ρ, δ<sub>s</sub>, θ                                                               | Rentang relatif; pita variasi skala s; ambang klasifikasi           |
| r                                                                                 | Rasio generik dua median T                                          |
| R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>, C<sub>int</sub>, C<sub>sf</sub> | Indikator turunan (Tabel 2.8)                                       |

# BAB I

PENDAHULUAN

# 1.1 Latar Belakang

Pemrosesan _query_ yang efisien merupakan fungsi inti sistem manajemen basis data \[1\]. Pada _database management system_ (DBMS) relasional, _query optimizer_ memilih _execution plan_ untuk _query_ SQL yang bersifat deklaratif berdasarkan _plan enumeration_, _cost model_, dan statistik data, sehingga kualitas _plan_ bergantung pada kualitas estimasi yang digunakan \[2\]. Oleh karena itu, pengaruh perubahan bentuk _query_ atau indeks yang tersedia terhadap _execution plan_ dan _execution time_ tidak dapat diasumsikan dan perlu diamati melalui pengukuran \[2\], \[3\].

Dua mekanisme yang dapat dikendalikan pengelola basis data adalah _query rewriting_ dan _indexing_. _Query rewriting_ mengubah representasi _query_ menjadi bentuk lain yang mempertahankan hasil yang disyaratkan, dan masih menjadi bidang penelitian aktif dengan manfaat pada sebagian, bukan seluruh, _query_ \[4\]. _Indexing_ memengaruhi metode akses data yang tersedia bagi _optimizer_, dan studi pada PostgreSQL melaporkan bahwa efektivitasnya berbeda menurut karakteristik _query_ dan skala data \[3\], \[5\].

Salah satu bentuk _query_ yang berkaitan erat dengan _rewriting_ adalah _correlated subquery_, yaitu _subquery_ yang merujuk nilai dari _query_ luar sehingga evaluasinya bergantung pada baris _query_ luar. Bila korelasi dipertahankan melalui _dependent join_, biaya eksekusi dapat meningkat tajam pada kondisi tertentu, sehingga _optimizer_ berupaya melakukan _unnesting_ atau _decorrelation_ \[6\]. Kossmann et al. merangkum bahwa _correlated subquery_ pada kondisi tertentu dapat ditransformasikan menjadi _join_ biasa sehingga teknik optimasi _join_ dapat diterapkan \[1\]. Bruno et al. menambahkan bahwa _correlated subquery_ dapat dievaluasi secara _tuple-at-a-time_, sedangkan _decorrelation_ umumnya menghasilkan eksekusi yang lebih bersifat _set-oriented_ \[7\]. Meskipun demikian, manfaat transformasi tidak muncul seragam pada seluruh _query_ \[4\].

Bukti yang ada berasal dari konteks yang berbeda. Neumann melaporkan bahwa sebuah _query_ bersarang pada skema dan data TPC-H pada _scale factor_ 1 (SF1) memerlukan lebih dari 25 menit pada PostgreSQL 16 dan 1,3 detik setelah di-_unnest_, tetapi algoritmanya diimplementasikan pada sistem Umbra dan contoh pada PostgreSQL hanya satu _query_ buatan, bukan _query_ standar TPC-H \[6\]. Bruno et al. mengevaluasi _decorrelation_ pada Microsoft Fabric Data Warehouse dengan beban kerja berbasis TPC-DS \[7\]. Studi _indexing_ pada PostgreSQL memvariasikan indeks atau konfigurasinya, tetapi memperlakukan bentuk _query_ sebagai masukan tetap \[3\], \[5\]. Perbedaan DBMS, _workload_, dan skala tersebut menunjukkan bahwa hasil suatu teknik tidak dapat dipindahkan begitu saja ke PostgreSQL.

Telaah literatur pada Subbab 2.2 menghasilkan tiga kesenjangan. Pertama, studi _rewriting_ dan _decorrelation_ mengevaluasi mekanisme pada sistem atau _workload_ lain tanpa memvariasikan strategi _indexing_ sebagai faktor, sedangkan studi _indexing_ memperlakukan bentuk SQL sebagai tetap \[3\], \[5\], \[6\], \[7\]. Bukti pembanding terdekat berupa _preprint_ yang menguji indeks dan bentuk _query_ pada eksperimen terpisah dengan skema sintetis(Subbab 2.2.1). Dengan demikian, pada sumber yang ditelaah, bukti empiris tentang interaksi keduanya pada _query_ yang sama di PostgreSQL masih terbatas. Kedua, pada sumber yang ditelaah belum ditemukan perbandingan terkontrol antara _correlated subquery_ dan bentuk hasil _rewriting_\-nya pada TPC-H Q2, Q17, dan Q20 di PostgreSQL 18.6 dengan variasi SF1 dan SF10. Ketiga, pada kombinasi tersebut belum ditemukan analisis yang menjelaskan perubahan _execution time_ melalui _execution plan_, _planning time_, dan _buffer statistics_. Ketiga pernyataan ini dibatasi pada literatur yang ditelaah dan tidak mengklaim bahwa tidak ada studi serupa.

Berdasarkan kesenjangan tersebut, penelitian ini tidak membandingkan _query rewriting_ dan _indexing_ sebagai dua teknik yang berdiri sendiri, tetapi menguji pengaruh keduanya secara bersama-sama. Alasannya, eksekusi _tuple-at-a-time_ pada _correlated subquery_ umumnya lambat kecuali tersedia strategi indeks yang mendukungnya \[7\], sehingga manfaat _rewriting_ dapat bergantung pada indeks yang tersedia, dan nilai suatu indeks dapat bergantung pada bentuk _query_. Setiap _query_ karenanya dijalankan dalam bentuk asli (O) dan bentuk hasil _rewriting_ (R) pada tiga level _indexing_ (I0, I1, I2) dan dua skala (SF1 dan SF10), sehingga interaksi keduanya diukur secara eksplisit. PostgreSQL 18.6, rilis perawatan seri 18 tertanggal 13 Agustus 2026 yang tersedia dan stabil saat lingkungan eksperimen disiapkan, dipilih karena bukti pembanding dilaporkan pada versi yang lebih lama, dan versi minornya dipatok karena rilis perawatan memuat perbaikan _planner_ yang dapat mengubah _plan_. TPC-H dipakai karena merupakan _benchmark decision support_ dengan skema dan _query_ terstruktur sehingga kondisi eksperimen dapat dikendalikan dan direproduksi. _Execution time_ menjadi metrik utama, sedangkan _planning time_, _execution plan_, dan _buffer statistics_ menjadi indikator pendukung. Keluaran penelitian berupa informasi empiris pendukung keputusan optimasi dan pengelolaan basis data PostgreSQL, bukan kerangka keputusan formal.

# 1.2 Rumusan Masalah

Permasalahan utama penelitian ini adalah belum tersedianya bukti empiris terkontrol mengenai bagaimana perubahan bentuk _correlated subquery_ menjadi JOIN dan penerapan strategi _indexing_, baik secara terpisah maupun bersama-sama, memengaruhi performa _query_ PostgreSQL pada _query_ dan skala data yang berbeda. Tanpa bukti tersebut, keputusan optimasi, yaitu apakah _query_ ditulis ulang, indeks ditambahkan, atau keduanya, cenderung diambil berdasarkan asumsi, padahal manfaat transformasi _query_ dan indeks bergantung pada karakteristik _query_, data, dan sistem. Berdasarkan permasalahan tersebut, rumusan masalah penelitian ini adalah:

1. Bagaimana pengaruh SQL _query rewriting_ dari _correlated subquery_ menjadi JOIN terhadap _execution time query_ PostgreSQL 18.6 pada TPC-H Query 2, Query 17, dan Query 20 pada berbagai strategi _indexing_ dan pada skala _dataset_ SF1 dan SF10?
2. Bagaimana pengaruh strategi _indexing_ terhadap _execution time_ _query_ PostgreSQL 18.6 pada _query_ dan skala _dataset_ tersebut, serta bagaimana interaksinya dengan SQL _query rewriting_?
3. Pada kondisi apa (kombinasi _query_, level indeks, dan skala data) penerapan SQL _query rewriting_ dan strategi _indexing_, baik secara terpisah maupun bersama, mengubah _execution time_ secara melampaui variasi pengukuran, baik sebagai perbaikan maupun penurunan, dibandingkan _baseline_ (bentuk asli, O, pada level indeks hanya _primary key_, I0), dan berapa biaya ruang penyimpanan serta waktu pembuatan indeks yang menyertainya?

# 1.3 Tujuan

Tujuan penelitian ini adalah:

1. Mengevaluasi pengaruh SQL _query rewriting_ dari _correlated subquery_ menjadi JOIN terhadap _execution time_ _query_ PostgreSQL 18.6 pada TPC-H Query 2, Query 17, dan Query 20 pada berbagai strategi _indexing_ dan skala _dataset_ SF1 dan SF10, yang dinyatakan sebagai rasio _execution time_ bentuk O terhadap bentuk R pada setiap kondisi.
2. Menganalisis pengaruh strategi _indexing_ terhadap _execution time_ pada _query_ dan skala _dataset_ yang sama serta interaksinya dengan SQL _query rewriting_, dengan _planning time_, _execution plan_, dan _buffer statistics_ sebagai indikator pendukung. Pengaruh _indexing_ dinyatakan sebagai rasio _execution time_ terhadap level I0, dan interaksi dinyatakan sebagai perbedaan efek _rewriting_ antarlevel indeks (kontras interaksi).
3. Mengidentifikasi kondisi (kombinasi _query_, level indeks, dan skala data) ketika SQL _query rewriting_ dan strategi _indexing_, secara terpisah maupun bersama, mengubah _execution time_ melampaui variasi pengukuran dibandingkan _baseline_ (bentuk O dengan I0), baik sebagai perbaikan maupun penurunan, serta menentukan biaya ruang penyimpanan dan waktu pembuatan indeks yang menyertainya, sebagai informasi pendukung pengambilan keputusan optimasi dan pengelolaan basis data PostgreSQL pada konfigurasi yang diuji. Ukuran indeks diukur dari katalog PostgreSQL dan waktu pembuatan indeks dicatat dari durasi pembuatannya di sisi klien.

# 1.4 Manfaat

Penelitian ini diharapkan memberikan manfaat sebagai berikut:

1. Bagi pengembangan ilmu pengetahuan, penelitian ini memberikan bukti empiris terkontrol mengenai pengaruh SQL _query rewriting_, strategi _indexing_, dan interaksinya terhadap performa _query_ PostgreSQL 18.6, beserta penjelasannya melalui _execution plan_, _planning time_, dan _buffer statistics_.
2. Bagi praktisi dan pengembang sistem basis data, hasil penelitian memberikan informasi mengenai kondisi ketika _rewriting_ dan _indexing_ mengubah _execution time_ melampaui variasi pengukuran, baik sebagai perbaikan maupun penurunan, beserta biaya ruang penyimpanan dan waktu pembuatan indeks yang menyertainya, pada konfigurasi yang diuji, sebagai bahan pertimbangan dan bukan rekomendasi yang berlaku umum.
3. Bagi penelitian selanjutnya, rancangan eksperimen dan hasil evaluasi dapat menjadi dasar untuk penelitian dengan _query_, DBMS, strategi _indexing_, atau skala dataset yang berbeda.

# 1.5 Ruang Lingkup

Ruang lingkup penelitian ini dibatasi pada evaluasi performa _query_ pada PostgreSQL 18.6 menggunakan skema dan _query_ acuan TPC-H dengan _dataset_ pada _scale factor_ SF1 dan SF10. _Query_ yang dievaluasi adalah TPC-H Query 2, Query 17, dan Query 20 karena memiliki karakteristik _correlated subquery_ yang relevan untuk evaluasi transformasi _decorrelation_, dan digunakan sebagai bagian dari beban kerja turunan TPC-H sesuai kebutuhan penelitian. Penelitian membandingkan bentuk SQL asli dengan bentuk hasil _query rewriting_ yang menulis ulang _correlated subquery_ menjadi JOIN dengan _derived table_ teragregasi pada atribut korelasi, dirancang mempertahankan semantik, dan dinyatakan sah hanya bila hasilnya terbukti ekuivalen dengan bentuk asli (Subbab 3.6.3). Penelitian juga mengevaluasi pengaruh strategi _indexing_ dan interaksinya dengan _query rewriting_. Kolom indeks ditetapkan a priori berdasarkan atribut korelasi, filter, dan _foreign key_ pada _query_ serta kajian literatur, dan dikunci sebelum pilot (Subbab 3.5.3). Performa dievaluasi terutama berdasarkan _execution time_, sedangkan _execution plan_, _planning time_, dan _buffer statistics_ digunakan sebagai indikator pendukung.

Bentuk asli (O) adalah teks _query_ spesifikasi TPC-H dengan parameter validasi bawaan, tanpa perubahan struktur. Strategi _indexing_ dioperasionalkan dalam tiga level kumulatif B-tree di tingkat basis data: I0 berisi indeks _primary key_ saja; I1 adalah I0 ditambah indeks kolom tunggal pada kolom _foreign key_ dan kolom korelasi; I2 adalah I1 ditambah indeks komposit atau _covering_ yang ditargetkan pada pola _subquery_ (Subbab 2.5.1 dan 3.5.3). Setiap _query_ dijalankan dalam bentuk O dan R pada ketiga level dan kedua skala, sehingga terdapat 36 kondisi dengan O pada I0 sebagai _baseline_. _Execution time_ suatu kondisi adalah median dari beberapa eksekusi terukur setelah satu _warm-up_ pada kondisi _warm cache_, dengan urutan eksekusi diacak terbatas di dalam blok dan pemeriksaan ulang I0 di akhir untuk mendeteksi pergeseran kondisi (Subbab 3.6). Perubahan dinyatakan melampaui variasi pengukuran bila rasio median _execution time_ berada di luar pita variasi yang diamati pada pilot untuk skala yang bersangkutan (Subbab 3.7.4). Ini kriteria praktis, bukan uji signifikansi statistik.

Penelitian dilakukan dalam lingkungan eksperimen yang dikendalikan. Hasil dilaporkan sebagai beban kerja turunan TPC-H, bukan hasil TPC-H resmi, karena bentuk R dan level I2 melampaui aturan spesifikasi (Subbab 2.3.2). Hasil dibatasi pada konfigurasi PostgreSQL 18.6, _query_, skala _dataset_, strategi indeks, serta lingkungan perangkat keras dan perangkat lunak yang diuji, sehingga tidak dimaksudkan untuk digeneralisasikan secara langsung pada DBMS, _workload_, atau konfigurasi sistem yang berbeda. Penelitian menghasilkan informasi empiris pendukung keputusan optimasi dan pengelolaan basis data PostgreSQL, tanpa merumuskan kerangka keputusan formal.

# BAB II

KAJIAN LITERATUR

# 2.1 State of the Art

Penelitian mengenai optimasi _query_ basis data berkembang dari pendekatan yang berfokus pada pemilihan _execution plan_ menuju kajian yang juga mempertimbangkan ketepatan estimasi biaya, transformasi struktur SQL, strategi akses data, serta karakteristik beban kerja. Meskipun sistem manajemen basis data relasional telah memiliki _query optimizer_ untuk memilih _execution plan_, rencana yang dipilih tidak selalu menghasilkan kinerja terbaik. Salah satu penyebabnya adalah ketidakakuratan estimasi kardinalitas, yaitu perkiraan jumlah baris yang dihasilkan oleh suatu operasi dalam _execution plan_ \[2\], \[8\]. Perkembangan penelitian juga menunjukkan bahwa kinerja _query_ tidak hanya dipengaruhi oleh kemampuan _optimizer_, tetapi dapat dipengaruhi oleh bentuk _query_ yang diberikan serta indeks yang tersedia bagi sistem \[3\], \[5\], \[7\].

Dalam konteks tersebut, perkembangan penelitian yang relevan dengan penelitian ini dibahas melalui empat tema, yaitu optimasi _query_ dan pemilihan _execution plan_, SQL _query_ _rewriting_ dan _query decorrelation_, strategi _indexing_ dan akses data, serta evaluasi eksperimental kinerja _query_. Pembahasan difokuskan pada pendekatan yang telah diteliti, temuan utamanya, dan relevansinya terhadap evaluasi eksperimental pada PostgreSQL.

# 2.1.1 Penelitian tentang Optimasi Query dan Pemilihan Execution Plan

_Query optimizer_ merupakan komponen DBMS yang menentukan strategi eksekusi untuk menjalankan _query_ SQL. Strategi tersebut dapat melibatkan pemilihan metode pemindaian tabel, urutan penggabungan tabel, dan algoritma _join_. PostgreSQL menyediakan perintah EXPLAIN untuk menampilkan _execution plan_ yang dipilih oleh _planner_, termasuk perkiraan biaya dan metode akses data yang digunakan \[9\].

Salah satu penelitian penting dalam evaluasi kualitas _optimizer_ dilakukan oleh Leis et al. yang memperkenalkan Join Order Benchmark (JOB) untuk menguji kualitas _optimizer_ menggunakan _query_ dengan banyak operasi _join_. Hasilnya menunjukkan bahwa kesalahan estimasi kardinalitas dapat menjadi penyebab utama pemilihan _execution plan_ yang buruk. Dengan demikian, pemilihan _execution plan_ tidak hanya bergantung pada kemampuan sistem mengevaluasi berbagai alternatif, tetapi juga pada kualitas estimasi yang digunakan selama proses optimasi \[2\].

Satu dekade kemudian, Leis et al. meninjau kembali kualitas _optimizer_ tersebut dalam _Still Asking: How Good Are Query Optimizers, Really_?. Kajian ini menunjukkan bahwa persoalan estimasi kardinalitas masih relevan meskipun penelitian optimasi _query_ telah berkembang, termasuk melalui pendekatan _learned_ dan berbasis kecerdasan buatan. Temuan tersebut menegaskan bahwa peningkatan kemampuan _optimizer_ merupakan persoalan yang berkelanjutan dan bahwa kualitas _execution plan_ tetap perlu dinilai melalui pengujian empiris \[8\].

Pendekatan lain ditunjukkan oleh Woltmann et al. melalui FASTgres, yaitu pendekatan berbasis pembelajaran mesin untuk memprediksi kombinasi _optimizer hints_ yang sesuai dengan konteks _query_. Penelitian tersebut mengevaluasi pendekatannya pada beberapa _benchmark_ dan dua versi PostgreSQL. Hasil evaluasi menunjukkan bahwa pengarahan _optimizer_ melalui _hints_ dapat mengurangi _execution time_ _benchmark_ secara nyata dalam konfigurasi yang diuji, dengan penurunan hingga faktor 3,25 kali pada evaluasi _end-to-end_ mereka \[10\]. Namun, FASTgres tidak melakukan transformasi struktur SQL sebagai fokus utamanya. Oleh karena itu, penelitian ini lebih tepat ditempatkan sebagai bukti bahwa _execution plan_ yang dipilih _optimizer_ dapat dipengaruhi oleh strategi optimasi tambahan, bukan sebagai bukti langsung efektivitas _query rewriting_.

# 2.1.2 Penelitian tentang SQL Query Rewriting dan Query Decorrelation

SQL _query rewriting_ merupakan pendekatan optimasi yang mengubah representasi atau struktur _query_ dengan tetap mempertahankan hasil yang disyaratkan secara semantik. Tujuannya adalah memperoleh bentuk _query_ yang memberi peluang bagi DBMS untuk menghasilkan _execution plan_ yang lebih efisien. Namun, perubahan sintaks SQL tidak secara otomatis menjamin penurunan _execution time_ karena hasil akhirnya tetap bergantung pada karakteristik _query_ dan keputusan _optimizer_ \[6\], \[11\].

Salah satu fokus penelitian _query rewriting_ adalah penanganan _correlated subquery_. _Subquery_ berkorelasi merujuk pada nilai atau kolom dari _query_ luar sehingga evaluasinya memiliki ketergantungan terhadap baris pada tingkat luar. Dalam strategi eksekusi tertentu, kondisi tersebut dapat menyebabkan operasi pada bagian dalam dijalankan berulang kali untuk baris-baris dari _query_ luar. Bruno et al. menjelaskan bahwa pola eksekusi _tuple-at-a-time_ untuk _subquery_ berkorelasi umumnya dapat menjadi lambat, kecuali ketika tersedia strategi indeks khusus yang mendukung evaluasinya. _Query decorrelation_ menghilangkan ketergantungan tersebut sehingga membuka peluang untuk menggunakan pemrosesan berbasis himpunan (_set-oriented execution_) \[7\].

Penelitian mengenai transformasi _subquery_ telah berkembang dari aturan transformasi tertentu menuju mekanisme _decorrelation_ yang menangani bentuk _query_ yang lebih kompleks. Galindo-Legaria dan Joshi membahas optimasi _subquery_ dan agregasi melalui sejumlah teknik yang saling melengkapi, termasuk penghilangan korelasi dan pemrosesan _outer join_ serta GROUP BY \[11\]. Penelitian tersebut memperlihatkan bahwa transformasi _subquery_ bukan sekadar penggantian sintaks, melainkan bagian dari proses pencarian strategi eksekusi yang lebih beragam.

Neumann kemudian membahas peningkatan proses _unnesting_ untuk _query_ kompleks, termasuk struktur bersarang yang dalam dan konstruksi SQL yang lebih rumit. Penelitian ini mengangkat keterbatasan teknik _decorrelation_ yang telah ada, yang dalam situasi tertentu dapat menghasilkan rencana yang kurang optimal atau kesulitan menangani bentuk _query_ tertentu \[6\]. Sementara itu, Bruno et al. mengembangkan kerangka _decorrelation_ untuk Microsoft Fabric Data Warehouse dan mengevaluasinya menggunakan _benchmark_ analitis berbasis TPC-DS \[7\]. Kedua penelitian ini memperlihatkan pentingnya kemampuan transformasi menangani beragam struktur _query_, tetapi hasil implementasi pada sistem lain tidak dapat langsung dianggap berlaku dengan besaran yang sama pada PostgreSQL.

Arah lain terlihat pada penelitian Dharwada et al. melalui LITHE, sebuah pendekatan _query rewriting_ yang memanfaatkan _large language models_ (LLM). Penelitian ini menggabungkan strategi _prompting_, aturan yang mempertimbangkan konteks basis data, serta pemeriksaan statistik dan logika untuk mengurangi kesalahan transformasi. Pada evaluasi yang dilaporkan, LITHE menghasilkan transformasi yang memberikan _speedup_ lebih dari 1,5 kali pada sekitar dua pertiga _query_ dalam rangkaian TPC-DS yang diuji \[4\]. Temuan tersebut menunjukkan potensi pendekatan _rewriting_ untuk meningkatkan kinerja, tetapi juga memperlihatkan bahwa keberhasilannya tidak dapat diasumsikan untuk seluruh _query_. Selain itu, pendekatan berbasis LLM berbeda dari eksperimen penelitian ini yang berfokus pada transformasi SQL yang dirancang dan diuji secara eksplisit.

# 2.1.3 Penelitian tentang Indexing dan Strategi Akses Data

Indeks merupakan struktur tambahan yang membantu DBMS menemukan baris yang memenuhi kondisi _query_ tanpa harus selalu memindai seluruh tabel. Meskipun demikian, indeks juga membutuhkan ruang penyimpanan dan menambah pekerjaan pemeliharaan ketika data berubah. Oleh karena itu, manfaat indeks perlu dinilai berdasarkan pola _query_, karakteristik data, dan biaya yang menyertainya, bukan semata-mata berdasarkan keberadaan indeks \[12\].

Dokumentasi PostgreSQL menjelaskan beberapa strategi indeks, termasuk B-tree, Hash, GiST, SP-GiST, GIN, dan BRIN. Setiap jenis memiliki karakteristik serta kondisi penggunaan yang berbeda \[12\]. Untuk indeks multikolom, efektivitasnya juga dipengaruhi oleh susunan kolom. Sebagai contoh, indeks B-tree multikolom umumnya paling efektif ketika kondisi _query_ membatasi kolom-kolom yang berada di bagian paling kiri indeks \[13\]. Artinya, indeks yang secara struktural sesuai dengan satu pola _query_ belum tentu sama efektifnya untuk pola _query_ lain.

PostgreSQL juga dapat menggabungkan beberapa indeks melalui pemindaian berbasis _bitmap_. Strategi tersebut memungkinkan kondisi tertentu dipenuhi dengan mengombinasikan hasil dari indeks yang berbeda, tetapi tidak selalu lebih efisien dibandingkan penggunaan satu indeks yang sesuai atau pemindaian tabel secara langsung \[14\]. Selain itu, _index-only scan_ dapat mengurangi kebutuhan akses ke tabel apabila semua kolom yang diperlukan tersedia dalam indeks dan kondisi visibilitas baris mendukung pemanfaatannya. Namun, kemungkinan menggunakan strategi tersebut tidak selalu berarti strategi itu akan memberikan keuntungan kinerja pada setiap eksekusi \[15\].

Penelitian Schlosser et al. memperluas pembahasan indeks dari manfaat indeks tunggal ke persoalan pemilihan konfigurasi indeks untuk beragam skenario _workload_. Penelitian tersebut mempertimbangkan bahwa keuntungan suatu indeks dipengaruhi oleh indeks lain yang dipasang, kebutuhan memori, perubahan komposisi beban kerja, dan biaya konfigurasi ulang. Evaluasinya mencakup _workload_ sintetis serta _benchmark_ TPC-H dan TPC-DS \[16\]. Pendekatan ini memperkuat pandangan bahwa pemilihan indeks merupakan persoalan optimasi yang bergantung pada konteks, bukan sekadar mencari indeks yang paling cepat pada satu _query_.

Penelitian Ramdhani dan Widodo secara khusus membandingkan indeks B-tree dan Hash pada PostgreSQL dengan menggunakan _dataset benchmark_ TPC-H pada beberapa _scale factor_, yaitu SF0.1, SF1, dan SF10. Penelitian tersebut mengevaluasi kinerja _query_ serta pengaruh indeks terhadap keputusan _query planner_ \[3\]. Karena informasi yang dapat diverifikasi pada sumber yang tersedia belum cukup untuk memastikan seluruh hasil komparatifnya, penelitian ini digunakan sebagai bukti relevansi pendekatan eksperimen indeks pada PostgreSQL, bukan sebagai dasar untuk menyatakan bahwa salah satu jenis indeks selalu lebih unggul.

Hamadou et al. juga melaporkan eksperimen perbandingan indeks sederhana, komposit, dan teks pada PostgreSQL menggunakan _dataset_ sintetis berisi 500.000 catatan. Pengujian mencakup operasi pengambilan data, pembaruan, dan penghapusan, dengan _execution time_ dan beberapa ukuran sumber daya sebagai metrik evaluasi \[5\]. Penelitian ini memperluas cakupan evaluasi indeks ke lebih dari satu jenis operasi. Namun, karakteristik _dataset_ sintetis, jenis _query_, konfigurasi perangkat keras, serta prosedur eksperimen perlu dipertimbangkan sebelum hasilnya dibandingkan atau digeneralisasikan ke _workload_ analitis seperti TPC-H.

# 2.1.4 Penelitian tentang Evaluasi Performa dan Eksperimen Optimasi Query

Evaluasi kinerja _query_ membutuhkan metode pengujian yang memungkinkan hasil dari beberapa konfigurasi dibandingkan secara terukur. Dalam penelitian basis data, _benchmark_ digunakan untuk menyediakan struktur data dan pola _query_ yang relatif terstandar sehingga pendekatan optimasi dapat diuji pada beban kerja yang telah ditentukan. Tiga benchmark yang banyak digunakan dalam penelitian analitis adalah Join Order Benchmark (JOB), TPC-H, dan TPC-DS, meskipun tujuan dan karakteristik masing-masing berbeda \[2\], \[7\], \[16\], \[17\].

JOB digunakan oleh Leis et al. untuk mengevaluasi kualitas pemilihan _execution plan_ pada _query_ dengan banyak operasi join \[2\]. _Benchmark_ tersebut membantu menguji kemampuan _optimizer_ dalam menghadapi kompleksitas estimasi dan pemilihan urutan _join_. Sementara itu, penelitian Schlosser et al. menggunakan TPC-H dan TPC-DS sebagai bagian dari evaluasi pemilihan indeks pada berbagai skenario _workload_ \[16\]. Penggunaan _benchmark_ dalam kedua penelitian tersebut memperlihatkan bahwa pengujian optimasi perlu mempertimbangkan karakteristik beban kerja dan tidak cukup hanya menggunakan satu _query_ sederhana.

TPC-H merupakan _benchmark_ untuk mengevaluasi kinerja sistem dalam menjalankan _query_ analitis dan mendukung pengambilan keputusan. Spesifikasi resmi TPC mencantumkan TPC-H versi 3.0.1 sebagai versi spesifikasi yang tersedia \[17\]. Penggunaan _scale factor_ memungkinkan ukuran _dataset_ dibedakan untuk mempelajari bagaimana perubahan volume data berkaitan dengan kinerja _query_. Akan tetapi, hasil pengujian pada satu _scale factor_ tidak otomatis dapat digeneralisasikan ke ukuran _dataset_ yang lain, sehingga pengujian pada lebih dari satu skala dapat memberikan gambaran yang lebih lengkap mengenai perilaku sistem.

Penelitian mengenai indeks juga menunjukkan pentingnya mengevaluasi lebih dari satu aspek kinerja. Hamadou et al., misalnya, mengukur _execution time_ dan sejumlah indikator sumber daya saat menguji strategi indeks pada operasi pengambilan, pembaruan, dan penghapusan data \[5\]. Schlosser et al. menekankan bahwa pemilihan indeks juga perlu mempertimbangkan konsumsi memori dan perilaku indeks dalam beragam skenario _workload_ \[16\]. Temuan tersebut menunjukkan bahwa pemilihan metrik harus disesuaikan dengan tujuan penelitian. Untuk eksperimen yang fokus pada kinerja _query_ analitis, _execution time_ dapat menjadi metrik utama, sedangkan informasi _execution plan_ dan penggunaan _buffer statistics_ dapat membantu menjelaskan hasil yang diperoleh.

Perbandingan eksperimental juga memerlukan pengendalian kondisi pengujian. Perbedaan hasil dapat dipengaruhi oleh ukuran _dataset_, konfigurasi indeks, bentuk _query_, keadaan _cache_, statistik tabel, dan kondisi sistem ketika pengujian dilakukan. Oleh sebab itu, perbandingan yang valid perlu menjaga faktor-faktor yang tidak sedang diuji tetap konsisten sejauh memungkinkan. Dokumentasi PostgreSQL juga mengingatkan bahwa EXPLAIN ANALYZE memiliki _overhead_ pengukuran, sehingga hasil waktunya perlu ditafsirkan dengan mempertimbangkan metode pengukuran yang digunakan \[9\].

# 2.2 Sintesis Kritis dan Kesenjangan Penelitian

Penelitian yang telah ditinjau sebelumnya dibandingkan menggunakan lima dimensi: faktor yang dimanipulasi, DBMS atau sistem yang digunakan, _benchmark_ dan skala data, bentuk pelaporan hasil, serta batas generalisasi. Pembandingan ini dipakai untuk menentukan apa yang sudah dapat dipertanggungjawabkan oleh literatur dan apa yang masih terbuka bagi penelitian ini.

# 2.2.1 Perbandingan Temuan dan Metode Penelitian Terdahulu

Tabel 2.1 Perbandingan Penelitian Terdahulu

| **Sumber**              | **Objek dan metode rewriting / indeks**                        | **DBMS**                                     | **Benchmark dan skala**                      | **Metrik dan pelaporan**                                       | **Keterbatasan terhadap penelitian ini**                         |
| ----------------------- | -------------------------------------------------------------- | -------------------------------------------- | -------------------------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------------- |
| Neumann \[6\]           | Algoritma unnesting di optimizer; indeks bukan faktor          | Umbra; PostgreSQL 16 untuk satu query contoh | TPC-H SF1 (contoh buatan)                    | Waktu eksekusi (>25 menit vs 1,3 detik pada contoh)            | Mekanisme di dalam engine; contoh PostgreSQL bukan query standar |
| Bruno et al. \[7\]      | Decorrelation terintegrasi di optimizer                        | Fabric DW                                    | TPC-DS                                       | _Query latency, execution time, compilation time, cardinality_ | DBMS dan workload berbeda                                        |
| Dharwada et al. \[4\]   | Rewriting oleh LLM                                             | PostgreSQL                                   | TPC-DS                                       | Speedup >1,5× pada sekitar dua pertiga query                   | Keputusan oleh model; keberhasilan tidak seragam                 |
| Li et al. \[18\]        | LLM merekomendasikan aturan rewrite                            | Tidak disebutkan secara eksplisit            | TPC-H, IMDB, DSB                             | _Query execution time, rewrite latency_                        | Ekuivalensi dijamin aturan, bukan diverifikasi manual            |
| Ramdhani & Widodo \[3\] | Jenis indeks B-tree vs Hash; bentuk query tetap                | PostgreSQL                                   | TPC-H SF0.1, SF1, SF10                       | Kinerja query, keputusan planner                               | Hasil komparatif belum terverifikasi penuh                       |
| Hamadou et al. \[5\]    | Indeks sederhana, komposit, teks                               | PostgreSQL                                   | Sintetis 500.000 catatan                     | Waktu eksekusi, ukuran sumber daya                             | Dataset sintetis; baca, ubah, hapus                              |
| Schlosser et al. \[16\] | Pemilihan konfigurasi indeks                                   | PostgreSQL                                   | Sintetis, TPC-H, TPC-DS                      | Memori, biaya konfigurasi ulang                                | Bentuk SQL tetap                                                 |
| Zhou et al. \[19\]      | 17 index advisor                                               | Beberapa sistem                              | 11 dataset                                   | Durasi, _query latency_, biaya _workload_                      | Workload tetap; bentuk SQL tetap                                 |
| Agrawal et al. \[20\]   | Indeks dan bentuk query (3 formulasi) pada eksperimen terpisah | PostgreSQL 13.20, MySQL, MariaDB, DuckDB     | TPC-H dan skema sintetis (10⁵ dan 10⁷ baris) | Waktu performa                                                 | Preprint; bukan Q2/Q17/Q20; snapshot                             |

Secara lintas dimensi, studi _rewriting_ menguji mekanisme (di dalam _engine_ atau oleh model), sedangkan studi indeks menguji jenis atau konfigurasi, dan keduanya memperlakukan faktor lain sebagai tetap \[3\], \[5\], \[16\], \[19\]. Pada PostgreSQL, bukti berasal dari \[3\], \[5\], \[20\] dan satu contoh \[6\], pada versi yang berbeda dari 18.6. _Benchmark_ TPC-H dipakai oleh \[3\], \[16\], \[18\], \[20\], tetapi pada sumber yang ditelaah tidak ditemukan yang membandingkan pasangan O dan R untuk Q2, Q17, dan Q20 dengan indeks sebagai faktor. Metrik utama bervariasi dan tidak ada yang menjelaskan perubahan waktu melalui _plan_ dan _buffer statistics_ pada kombinasi tersebut.

# 2.2.2 Keterbatasan yang Didukung Sumber

Berdasarkan perbandingan di atas, terdapat empat keterbatasan yang didukung sumber.

1. Lingkungan evaluasi yang beragam

Bukti _rewriting_ dan _decorrelation_ berasal dari lingkungan dan _workload_ yang berbeda, seperti Fabric Data Warehouse dengan TPC-DS dan TPC-DS pada pendekatan LLM \[4\], \[7\]. Hasilnya tidak dapat dipindahkan begitu saja ke PostgreSQL \[6\], \[7\].

2. Indexing diteliti dengan bentuk query tetap

Studi indeks pada \[3\], \[5\], \[16\], dan \[19\] memvariasikan indeks atau konfigurasinya tanpa memperlakukan bentuk SQL sebagai faktor. Studi \[5\] juga memakai data sintetis, sehingga hasilnya perlu ditafsirkan hati-hati untuk _workload_ analitis seperti TPC-H.

3. Bukti pembanding terdekat bersifat terbatas

Studi \[20\] adalah _preprint_, memakai PostgreSQL 13.20, dan menguji _correlated_ _subquery_ pada skema sintetis, bukan pada _query_ TPC-H. Pengujian indeks dan pengujian bentuk _query_ dilaporkan pada bagian terpisah, dan penulisnya menyebut hasilnya sebagai _snapshot_ pada versi, data, dan perangkat keras tertentu \[20\].

4. Keterkaitan dengan execution plan belum menjadi sorotan.

Pada sumber yang ditelaah, penulis tidak menemukan analisis yang menghubungkan perubahan execution time dengan perubahan _execution_ plan dan aktivitas _buffer_ pada kombinasi _rewriting_ dan _indexing_. Dokumentasi PostgreSQL menyediakan EXPLAIN ANALYZE dengan opsi BUFFERS untuk analisis seperti itu \[9\].

# 2.2.3 Celah Penelitian dan Dasar Penelitian

Dari sintesis tersebut diidentifikasi tiga celah yang dibatasi pada sumber yang ditelaah:

1. Celah 1 (faktor kombinasi)

_Rewriting_ dan _indexing_ diteliti secara terpisah \[3\], \[4\], \[5\], \[6\], \[7\], \[16\], \[18\], \[19\], atau pada eksperimen yang tidak dirancang sebagai interaksi \[20\]. Bukti empiris tentang interaksi keduanya pada _query_ yang sama, pada PostgreSQL dan pada tingkat penulisan SQL, masih terbatas. Celah ini mendasari RM1 dan RM2.

2. Celah 2 (kondisi PostgreSQL, TPC-H, dan skala)

Pada sumber yang ditelaah belum ditemukan perbandingan terkontrol bentuk asli dan bentuk hasil _rewriting_ untuk TPC-H Q2, Q17, dan Q20 pada PostgreSQL 18.6 dengan variasi skala SF1 dan SF10. Celah ini mendasari RM1.

3. Celah 3 (penjelasan mekanisme)

Perubahan _execution time_ belum dijelaskan melalui _execution plan_, _planning_ _time_, dan _buffer_ pada kombinasi tersebut pada PostgreSQL. Celah ini mendasari seluruh rumusan masalah melalui indikator pendukung yang menjelaskan perubahan _execution time_, dan secara khusus mendukung RM3.

Pernyataan celah ini dibatasi pada literatur yang ditelaah dan tidak mengklaim bahwa tidak ada studi lain. Penelitian ini tidak menawarkan teknik _rewriting_ atau _indexing_ baru. Kontribusinya berupa bukti empiris terkontrol, dan kolom indeks eksperimen ditetapkan a priori pada Bab III. Penelusuran lanjutan pada Subbab 2.6 tidak mengubah ketiga celah tersebut.

# 2.3 Tinjauan Objek, Konteks, dan Arsitektur Penelitian

Subbab ini menguraikan objek penelitian dan konteks teknis tempat eksperimen dilakukan, yaitu PostgreSQL 18.6, _benchmark_ TPC-H, tiga _query_ yang dipilih, dan dua skala _dataset_. Uraiannya bersifat deskriptif. Prosedur, parameter, dan konfigurasi eksperimen dijabarkan pada Bab III.

# 2.3.1 PostgreSQL 18.6

PostgreSQL 18 dirilis pada 25 September 2025 \[21\]. Penelitian ini memakai versi perawatan 18.6 yang dirilis pada 13 Agustus 2026 \[22\]. Satu versi minor dipatok dan tidak diperbarui selama eksperimen karena catatan rilis perawatan memuat perbaikan yang menyentuh _planner_ dan eksekusi _join_, antara lain pemeriksaan _nullability_ pada ekspresi IN berisi _array_ dan masalah kinerja _hash join_ pada banyak kunci dengan nilai NULL \[22\], sehingga perilaku _plan_ dapat berbeda antarversi minor. Studi pembanding juga memakai versi lain, misalnya PostgreSQL 13.20 pada penelitian Agrawal et al. \[20\].

Tiga aspek PostgreSQL yang relevan dengan penelitian ini sebagai berikut.

1. Perencanaan Query

_Planner_ membangkitkan rencana pemindaian untuk setiap relasi, dengan rencana yang mungkin ditentukan oleh indeks yang tersedia. _Planner_ kemudian mempertimbangkan strategi dan urutan _join_ serta memilih rencana yang diperkirakan paling cepat \[23\]. Dalam rumusan ini, indeks dan susunan _query_ sama-sama memengaruhi ruang pilihan _planner_. Hubungan itu dikembangkan pada Subbab 2.4.

2. Penanganan Subquery

Pada kode sumber _planner_, _subquery_ dalam ekspresi diubah menjadi SubPlan atau InitPlan. _Subquery_ tanpa parameter dari _query_ luar dapat dihitung sekali sebagai InitPlan, sedangkan yang menerima parameter dari _query_ luar tetap menjadi SubPlan \[24\]. _Subquery_ berbentuk ANY atau EXISTS dapat dinaikkan menjadi _semi-join_ atau _anti-join_ \[25\]. Dokumentasi sistem turunan PostgreSQL menyatakan bahwa subquery skalar berkorelasi dengan agregat tetap berupa SubPlan atau InitPlan pada PostgreSQL asli \[26\]. Sumber \[24\] adalah kode cabang pengembangan utama, bukan cabang 18.6 dan \[25\], \[26\] adalah dokumentasi vendor, bukan dokumentasi resmi PostgreSQL 18.6. Penjelasan ini bersumber dari kode dan dokumentasi, sehingga bentuk plan aktual Q2, Q17, dan Q20 pada versi 18.6 harus dikonfirmasi melalui EXPLAIN pada tahap eksperimen, bukan diasumsikan.

3. Pengamatan Eksekusi

EXPLAIN ANALYZE menjalankan _query_ dan menampilkan informasi aktual, sedangkan opsi BUFFERS menampilkan aktivitas _buffer_ \[9\]. Sejak PostgreSQL 18, EXPLAIN ANALYZE menampilkan jumlah _buffer_ secara otomatis serta jumlah _index_ _lookup_ pada _index scan_ \[21\].

Versi 18 juga membawa _subsistem asynchronous_ I/O dan _skip_ _scan_ pada indeks B-tree multikolom, yang mempercepat _query_ yang tidak memiliki kondisi "=" pada kolom awal indeks \[21\]. Panduan susunan kolom indeks multikolom perlu dibaca bersama kemampuan _skip_ _scan_ ini \[13\]. Fitur-fitur tersebut mengikat generalisasi hasil pada versi 18. Apakah fitur itu berpengaruh pada Q2, Q17, dan Q20 harus diamati dari plan, tidak diasumsikan.

# 2.3.2 Benchmark TPC-H

TPC-H adalah _benchmark decision support_ yang terdiri atas _query_ bisnis ad hoc dan modifikasi data bersamaan, dirancang untuk memeriksa volume data besar dan _query_ berkompleksitas tinggi \[17\]. Skemanya terdiri atas delapan tabel (PART, SUPPLIER, PARTSUPP, CUSTOMER, ORDERS, LINEITEM, NATION, REGION) dengan relasi _one-to-many_ \[17\]. Versi 3.0.1 (revisi 28 April 2022) tercatat sebagai versi berlaku pada halaman spesifikasi TPC per 5 November 2026 \[17\].

Spesifikasi membuat _constraint primary key_ (PK) dan _foreign key_ (FK) bersifat opsional \[17\]. Penelitian ini mendefinisikan _constraint primary key_ dan _foreign key_ pada skema dasar serta _foreign key_ ditambahkan setelah pemuatan data. Indeks yang terbentuk dari _constraint_ diverifikasi melalui katalog sistem.

Ada dua batas kepatuhan yang memengaruhi status hasil penelitian ini:

1\. Struktur bantu seperti indeks hanya boleh dibuat pada kolom _primary_ _key_, _foreign key_, atau bertipe _date_, dan modifikasi _query_ dibatasi pada modifikasi minor atau varian yang disetujui \[17\].

2\. Penelitian ini menulis ulang _query_ dan dapat memakai indeks di luar kolom-kolom itu, sehingga hasilnya dilaporkan sebagai evaluasi pada beban kerja turunan TPC-H, bukan sebagai hasil TPC-H resmi.

Spesifikasi juga menyatakan bahwa perbandingan hasil antar ukuran basis data dapat menyesatkan dan ekstrapolasi ke lingkungan lain tidak dianjurkan \[17\].

# 2.3.3 Query TPC-H Q2, Q17, dan Q20

Tabel 2.2 Karakteristik Query yang Dievaluasi \[17\]

| **Query** | **Nama pada Spesifikasi**      | **Tabel pada Query Luar**                                  | **Subquery berkorelasi**                                                   | **Atribut Korelasi**      |
| --------- | ------------------------------ | ---------------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------- |
| Q2        | _Minimum Cost Supplier_        | part, supplier, partsupp, nation, region                   | Skalar, min(ps_supplycost) pada partsupp, supplier, nation, region         | p_partkey                 |
| Q17       | _Small Quantity Order Revenue_ | lineitem, part                                             | Skalar, 0,2 × avg(l_quantity) pada lineitem                                | l_partkey = p_partkey     |
| Q20       | _Potential Part Promotion_     | supplier, nation, dengan IN bersarang ke partsupp dan part | Skalar, 0,5 × sum(l_quantity) pada lineitem, rentang l_shipdate satu tahun | ps_partkey dan ps_suppkey |

Ketiga query dipilih secara purposif berdasarkan tiga kriteria teknis: (1) memuat correlated subquery skalar dengan fungsi agregat, bentuk yang dibahas pada literatur decorrelation dan penghilangan korelasi dengan agregasi \[6\], \[7\], \[11\]; (2) mewakili variasi struktur korelasi, yaitu satu atribut dengan agregat min pada gabungan beberapa tabel (Q2), satu atribut dengan agregat avg pada tabel terbesar (Q17), dan dua atribut dengan agregat sum, rentang tanggal, serta IN bersarang (Q20); dan (3) mengakses kombinasi tabel yang berbeda sehingga indeks dapat dirancang pada kolom korelasi, filter, dan foreign key. Q17 dan Q20 menjalankan subquery pada lineitem, tabel terbesar, sehingga relevan untuk mengamati pengaruh skala. TPC-H memuat bentuk berkorelasi lain, misalnya EXISTS pada Q4, yang tidak dipilih karena diduga dapat dinaikkan menjadi semi-join oleh planner \[25\]. Pemilihan ini bersifat kasus uji, bukan sampel acak populasi query, sehingga hasil tidak mewakili seluruh query berkorelasi.

# 2.3.4 Skala Dataset SF1 dan SF10

Tabel 2.3 Kardinalitas Tabel TPC-H pada SF1 dan SF10 \[17\]

| **Tabel** | **Kardinalitas**             | **SF1**   | **SF10**   |
| --------- | ---------------------------- | --------- | ---------- |
| PART      | SF × 200.000                 | 200.000   | 2.000.000  |
| SUPPLIER  | SF × 10.000                  | 10.000    | 100.000    |
| PARTSUPP  | SF × 800.000                 | 800.000   | 8.000.000  |
| CUSTOMER  | SF × 150.000                 | 150.000   | 1.500.000  |
| ORDERS    | SF × 1.500.000               | 1.500.000 | 15.000.000 |
| LINEITEM  | Mengacu pada TPC-H _Table_ 4 | 6.001.215 | 59.986.052 |
| NATION    | tetap                        | 25        | 25         |
| REGION    | tetap                        | 5         | 5          |

Kardinalitas LINEITEM tidak merupakan kelipatan tepat dari _scale factor_ karena jumlah lineitem dalam setiap pesanan dibangkitkan secara acak dengan rata-rata empat. Oleh karena itu, jumlah baris LINEITEM mengacu pada angka spesifik yang ditetapkan dalam TPC-H klausa 4.2.5.2 \[17\].

Spesifikasi menyebut basis data minimum berisi hampir sepuluh juta baris dengan kapasitas mentah sekitar 1 _gigabyte_ \[17\]. SF10 memperbesar sebagian besar tabel sepuluh kali lipat, kecuali NATION dan REGION. Dua skala dipakai untuk mengamati apakah arah dan besar pengaruh _rewriting_ dan _indexing_ bertahan saat volume data naik. Perbandingan antar-SF dilakukan pada pasangan _query_, bentuk SQL, dan konfigurasi yang sama, bukan sebagai peringkat kinerja, sejalan dengan peringatan spesifikasi \[17\]. Ukuran fisik basis data di PostgreSQL, termasuk indeks, diukur dan dilaporkan prosedurnya di Bab III dan hasilnya di Bab IV.

# 2.3.5 Arsitektur dan Lingkungan Teknis Penelitian

Gambar 2.1 Alur Komponen Penelitian Secara Konseptual

Rincian perangkat keras, sistem operasi, dan parameter server ditetapkan sebagai faktor dan variabel penelitian pada Subbab 3.4. Sementara itu, jumlah pengulangan, penanganan _cache_, kondisi indeks eksperimen, serta metode pengukuran waktu dan prosedur pelaksanaannya dijelaskan pada Bab III.

# 2.4 Landasan Teoretis dan Kerangka Konseptual

# 2.4.1 Pemrosesan dan Optimasi Query sebagai Dasar Pengamatan Kinerja

_Query_ SQL bersifat deklaratif. DBMS menerjemahkannya menjadi _execution plan_ melalui tahapan transformasi dan perencanaan sebelum dieksekusi, dan teknik optimasi dapat dikelompokkan menurut tahapan tersebut \[1\]. Pada PostgreSQL, _planner_ memilih rencana yang diperkirakan paling cepat dari rencana-rencana yang mungkin \[23\]. Keputusan itu bergantung pada estimasi, terutama estimasi kardinalitas, sehingga kualitas estimasi memengaruhi kualitas rencana \[2\], \[8\].

Perintah EXPLAIN menampilkan biaya dan jumlah baris estimasi untuk setiap node plan. Dengan ANALYZE, ditampilkan pula waktu dan jumlah baris aktual serta jumlah eksekusi _node_ (_loops_) \[9\], \[27\]. Nilai aktual pada _node_ yang berjalan berulang, seperti sisi dalam suatu _loop_ atau _subquery_ berkorelasi, dilaporkan per eksekusi dan perlu dikalikan jumlah loops untuk memperoleh kontribusi totalnya \[27\].

Implikasinya bagi penelitian ini ada dua:

1. _Execution time_ adalah keluaran dari rencana yang dipilih dan data yang diproses. Karena itu perubahan waktu dibaca bersama perubahan plan dan aktivitas _buffer_.
2. Selisih antara estimasi dan aktual menjadi indikator kapan keputusan _planner_ perlu ditelaah lebih lanjut \[2\], \[8\], \[9\].

# 2.4.2 SQL Query Rewriting dan Decorrelation

Tiga konsep perlu dibedakan. _Correlated subquery_ adalah bentuk _query_, yaitu _subquery_ yang merujuk kolom dari _query_ luar. _Query rewriting_ adalah tindakan mengubah teks atau representasi _query_ menjadi bentuk lain yang hasilnya setara; dapat dilakukan pengguna pada teks SQL atau sistem pada representasi internal. _Decorrelation_ (_unnesting_) adalah jenis _rewriting_ yang menghilangkan korelasi sehingga sisi dalam tidak lagi bergantung pada baris _query_ luar; dapat dilakukan _optimizer_ secara otomatis \[6\], \[7\] atau ditulis eksplisit oleh pengguna. Penelitian ini menguji kasus terakhir: R adalah _decorrelation_ yang ditulis eksplisit pada tingkat SQL, bukan algoritma di dalam _optimizer_ PostgreSQL, dan penelitian ini tidak mengusulkan atau memodifikasi algoritma _decorrelation_.

Pada _subquery_ berkorelasi, evaluasi sisi dalam bergantung pada nilai dari _query_ luar. Evaluasi dapat berbentuk _tuple-at-a-time_, sedangkan _decorrelation_ menghilangkan ketergantungan itu dan membuka eksekusi yang berorientasi himpunan \[6\], \[7\]. Penelitian ini menelaah _rewriting_ yang ditulis eksplisit pada tingkat SQL. Yang diuji adalah apakah bentuk SQL yang berbeda mengarahkan _planner_ ke rencana yang berbeda, bukan kualitas algoritma _decorrelation_ di dalam _optimizer_ \[6\], \[7\].

Satu pola umum untuk _subquery_ skalar berkorelasi dengan agregat adalah menyatakannya sebagai _join_ dengan _subquery_ teragregasi yang dikelompokkan menurut atribut korelasi. Pembahasan penghilangan korelasi dengan GROUP BY dan _outer join_ tersedia pada penelitian \[11\], dan bentuk _correlated subquery_, tabel sementara, serta klausa WITH pernah dibandingkan pada penelitian \[20\]. Bila bentuk berbasis _common table expression_ (CTE) dipakai, kode sumber _planner_ menunjukkan bahwa CTE dapat di-_inline_ atau dimaterialisasi tergantung jumlah rujukan dan opsi yang diberikan \[24\]. Bentuk final untuk tiap _query_ ditetapkan pada Bab III.

Kesetaraan semantik tidak cukup diandalkan pada intuisi. Neumann menyajikan formalisasi ketepatan algoritma _unnesting_ dengan mendefinisikan semantik operator secara formal \[28\]. Untuk penelitian ini, kesetaraan dipahami pada dua tingkat:

1. Kesetaraan rancangan, yaitu analisis semantik SQL atas bentuk hasil _rewriting_.
2. Kesetaraan hasil, yaitu pembandingan keluaran bentuk asli dan bentuk hasil _rewriting_. Spesifikasi TPC-H menyediakan keluaran validasi untuk parameter bawaan pada basis data kualifikasi beserta aturan presisi perbandingan \[17\].

Tabel 2.4 Titik Rawan Kesetaraan Semantik Per Query

| **Query** | **Titik yang perlu diperiksa**                                                                                                                                                                                                                                                                          |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q2        | Agregat min pada himpunan kosong menghasilkan NULL sehingga perbandingan menolak baris. Pasangan dengan biaya minimum yang seri harus tetap seluruhnya terbawa. Cakupan region pada _subquery_ dan pembatasan 100 baris harus tetap sama.                                                               |
| Q17       | Agregat _avg_ pada himpunan kosong menghasilkan NULL sehingga perbandingan menolak baris. Pengelompokan menurut atribut korelasi harus menghasilkan satu baris per kunci agar tidak terjadi penggandaan.                                                                                                |
| Q20       | Agregat sum pada himpunan kosong menghasilkan NULL sehingga perbandingan menolak baris. IN bersarang yang diubah menjadi _join_ biasa dapat menggandakan baris pemasok bila satu pemasok memenuhi syarat melalui lebih dari satu baris partsupp, sehingga diperlukan semi-join atau eliminasi duplikat. |

Pada kasus umum, agregat tanpa GROUP BY menuntut keluaran satu baris pada input kosong sehingga _unnesting_ memerlukan _outer join_ atau _group join_, dan aturan transformasi awal pernah memuat kesalahan _count bug_ \[6\]. Pada Q2, Q17, dan Q20, perbandingan terhadap hasil agregat menolak NULL, tetapi perilaku NULL saja tidak cukup untuk menyimpulkan kesetaraan. Q20 memuat IN bersarang yang dapat menggandakan baris bila diubah menjadi _join_ biasa (Tabel 2.4), dan Q2 memuat pembatasan 100 baris dengan pasangan biaya seri.

Setiap titik rawan pada Tabel 2.4 dijadikan kasus uji pada data mini, dan keluaran O dan R dibandingkan menurut kriteria pada Subbab 3.5.5 (jumlah baris, selisih EXCEPT ALL nol pada dua arah, urutan baris, dan nilai NUMERIC eksak). Bentuk R memakai nilai parameter validasi bawaan yang sama dengan O (Tabel 3.7). Yang berubah hanya struktur SQL, bukan nilai parameter, dan kesetaraan dinyatakan terpenuhi hanya setelah seluruh pemeriksaan lulus. Sampai G1 lulus (Subbab 3.6.3), R berstatus sementara.

# 2.4.3 Indexing dan Strategi Data Akses

Indeks memengaruhi rencana karena _planner_ mempertimbangkan rencana pemindaian untuk setiap relasi sesuai indeks yang tersedia \[23\]. Pilihan akses mencakup jenis indeks, efektivitas indeks multikolom yang bergantung pada susunan kolom, penggabungan indeks melalui _bitmap_, dan _index-only_ scan \[12\], \[13\], \[14\], \[15\]. PostgreSQL 18 menambah _skip scan_ pada indeks B-tree multikolom \[21\]. Manfaat indeks bergantung pada pola _query_ dan indeks lain yang terpasang, serta membawa biaya ruang dan pemeliharaan \[12\], \[16\], \[19\].

Bagi _subquery_ berkorelasi, relevansinya terletak pada evaluasi berulang. Bruno et al. menyatakan bahwa eksekusi _tuple-at-a-time_ umumnya lambat kecuali tersedia strategi indeks yang mendukung evaluasinya \[7\]. Ini menimbulkan pertanyaan konseptual yang diuji penelitian ini. Pertama, apakah indeks mengubah biaya evaluasi berulang pada bentuk asli. Kedua, apakah peran indeks pada bentuk hasil _rewriting_ berbeda karena akses terjadi pada himpunan, bukan per baris. Kedua pertanyaan itu tidak diasumsikan jawabannya.

Jenis indeks dibatasi pada B-tree. Kolom indeks ditetapkan a priori berdasarkan atribut korelasi, filter, dan _foreign key_ pada Tabel 2.2 serta aturan pada Subbab 2.5.1, dan dikunci sebelum pilot. Ketentuan TPC-H tentang kolom yang boleh diindeks menjadi pertimbangan status hasil.

# 2.4.4 Hubungan antara Rewriting, Indexing, Execution Plan, dan Performa

Bentuk SQL memengaruhi struktur plan, yaitu apakah _subquery_ tetap berupa _subplan_ atau menjadi _join_ serta algoritma _join_ yang dipakai. Indeks memengaruhi metode akses data pada plan. Plan bersama data yang diproses kemudian menentukan _execution time_, waktu perencanaan, dan aktivitas _buffer_. Skala data dapat memoderasi seluruh rantai itu. Arah pengaruh tidak diasumsikan, karena studi terdahulu menunjukkan bahwa manfaat _rewriting_ tidak dapat diandaikan untuk semua _query_ dan manfaat indeks bergantung pada konteks \[4\], \[16\], \[20\].

Tabel 2.5 Relasi Konseptual

| **Relasi** | **Rumusan Konseptual**                                        | **Dasar**                              | **Terkait**       |
| ---------- | ------------------------------------------------------------- | -------------------------------------- | ----------------- |
| R1         | Bentuk SQL → struktur _plan_                                  | \[6\], \[7\], \[24\]                   | RM1               |
| R2         | Strategi _indexing_ → metode akses pada _plan_                | \[12\], \[13\], \[14\], \[15\], \[23\] | RM2               |
| R3         | _Plan_ dan data → _execution time_, _planning time_, _buffer_ | \[2\], \[8\], \[9\]                    | RM1, RM2, dan RM3 |
| R4         | Interaksi bentuk SQL × strategi _indexing_                    | \[7\], \[16\]; Celah pada Subbab 2.2   | RM2               |
| R5         | Skala data memoderasi R1–R4                                   | Bab I; \[17\]                          | RM1, RM2, dan RM3 |

# 2.4.5 Kerangka Konseptual Penelitian

Kerangka konseptual pada Gambar 2.2 memetakan peran setiap variabel.

Gambar 2.2 Kerangka Konseptual Penelitian

Kerangka ini menjawab rumusan masalah sebagai berikut:

1. RM1 ditelaah melalui R1 dan R3 pada setiap kondisi indeks dan skala.
2. RM2 ditelaah melalui R2 dan R4.
3. RM3 ditelaah dengan mengidentifikasi kondisi yang perubahan _execution time_\-nya melampaui variasi pengukuran terhadap _baseline_ (O–I0), bersama biaya indeks, berdasarkan R1–R5.

_Planning time_, _execution plan_, dan _buffer statistics_ berperan sebagai indikator pendukung yang diamati, bukan variabel yang dimanipulasi. Definisi operasional, satuan, dan sumber pengukuran dijabarkan pada Subbab 2.5.

# 2.5 Operasionalisasi Konstruk dan Parameter Penelitian

Subbab ini memuat definisi faktor dan indikator. Protokol pelaksanaan dijabarkan pada Bab III.

# 2.5.1 Faktor Eksperimen dan Kondisi Penelitian

Penelitian memiliki tiga faktor eksperimen (bentuk SQL, strategi _indexing_, dan skala _dataset_) dan satu blok (_query_). Seluruh kombinasi level faktor pada setiap _query_ membentuk matriks eksperimen yang dirinci pada Subbab 3.2.

Tabel 2.6 Definisi Operasional Faktor dan Kondisi Pengujian

| **Konstruk**        | **Peran**          | **Definisi Operasional**                                                                                                                                                                                                                                                                                                                                                                                                         | **Level**    | **Sumber Verifikasi**                         | **Skala** |
| ------------------- | ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | --------------------------------------------- | --------- |
| Bentuk SQL          | Faktor             | O: teks _query_ spesifikasi TPC-H dengan parameter validasi bawaan \[17\], tanpa perubahan struktur; R: bentuk SQL hasil transformasi eksplisit _correlated subquery_ menjadi JOIN dengan _subquery_ teragregasi pada atribut korelasi; bentuk final per _query_ ditetapkan pada Bab III dan sah hanya bila hasilnya setara dengan O. Pada Q20, IN bersarang dipertahankan sebagai semantik _semijoin_ tanpa menggandakan baris. | O, R         | Berkas SQL tersimpan; status kesetaraan hasil | Nominal   |
| Strategi _Indexing_ | Faktor             | I0: hanya indeks _primary key_ (_foreign key_ didefinisikan tanpa indeks tambahan). I1: I0 + indeks B-tree kolom tunggal pada kolom FK dan kolom korelasi (Tabel 2.2). I2: I1 + indeks B-tree komposit atau _covering_ yang ditargetkan pada pola _subquery_ \[13\], \[15\]. Level berlaku di tingkat basis data.                                                                                                                | I0, I1, I2   | Katalog sistem; log pembuatan indeks          | Nominal   |
| Skala _Dataset_     | Faktor / Moderator | Faktor skala dbgen                                                                                                                                                                                                                                                                                                                                                                                                               | SF1, SF10    | Jumlah baris vs Tabel 2.3 \[17\]              | Nominal   |
| Query               | Blok               | Q2, Q17, Q20 dengan satu set parameter validasi bawaan \[17\]                                                                                                                                                                                                                                                                                                                                                                    | Q2, Q17, Q20 | Spesifikasi \[17\]                            | Nominal   |

Level bersifat kumulatif (I0 ⊂ I1 ⊂ I2) dan berlaku di tingkat basis data: himpunan indeks yang sama tersedia bagi ketiga _query_ pada level yang sama, sehingga perbedaan antarlevel hanya berasal dari indeks yang ditambahkan. Himpunan indeks dibentuk dengan aturan mekanis berikut, tanpa melihat hasil pengukuran: (1) hanya tabel yang diakses Q2, Q17, dan Q20 yang diberi indeks tambahan; (2) I1 hanya memuat indeks kolom tunggal pada kolom _foreign key_ atau kolom korelasi (Tabel 2.2) yang bukan kolom awal indeks I0, sehingga, misalnya, ps_partkey tidak diindeks ulang karena sudah menjadi kolom awal _primary key_ partsupp; (3) I2 hanya memuat indeks komposit atau _covering_ yang kunci kolomnya tidak identik dengan indeks pada level sebelumnya, dan tumpang tindih awalan kolom, bila ada, disengaja dan dilaporkan. Inventaris berjumlah 8 indeks pada I0, 13 pada I1, dan 18 pada I2 (dikunci pada G2), dengan rincian per indeks pada Tabel 3.14 dan Lampiran B.

Level I0 menegaskan bahwa "tanpa indeks eksperimen" tidak sama dengan "tanpa indeks sama sekali". Level I2 melampaui batas indeks yang dibolehkan spesifikasi \[17\], sehingga hasilnya dilaporkan sebagai beban kerja turunan TPC-H.

# 2.5.2 Indikator Performa dan Sumber Pengukuran

_Execution time_, _planning time_, dan _buffer statistics_ diperoleh dari keluaran EXPLAIN ANALYZE, dan fitur _execution plan_ dari keluaran EXPLAIN berformat JSON \[9\]. Opsi, urutan, dan prosedur pengukuran dijabarkan pada Subbab 3.6.

Tabel 2.7 Indikator Performa dan Sumber Pengukuran

| **Indikator**          | **Interpretasi**                                                                                                                                                               | **Peran**      | **Definisi Operasional**                                                                                                                                                                                                                                                                                                            | **Sumber**                                   | **Satuan dan Skala**               |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | ---------------------------------- |
| Execution time         | Lebih kecil berarti lebih cepat. Dibandingkan hanya sebagai rasio median. Tidak termasuk waktu pengiriman hasil ke klien \[9\].                                                | Keluaran utama | Total waktu eksekusi _statement_ (_execution time_); median dari eksekusi terukur, dengan rentang minimum–maksimum                                                                                                                                                                                                                  | Field "Execution Time" \[9\]                 | ms, rasio                          |
| Planning time          | Waktu perencanaan satu eksekusi. Dibaca terpisah dari execution time karena komponennya berbeda.                                                                               | Pendukung      | Waktu perencanaan satu eksekusi; median                                                                                                                                                                                                                                                                                             | _Field_ "_Planning Time_" \[9\]              | ms, rasio                          |
| Execution plan         | Penjelas struktur, bukan pengukuran waktu. Dibaca sebagai asosiasi. Rasio estimasi/aktual (dikalikan loops) jauh dari 1 menandai estimasi planner meleset \[2\], \[8\], \[9\]. | Pendukung      | Fitur dari eksekusi terpisah (_timing_ menyala, FORMAT JSON): jenis _node scan_ \[12\], \[13\], \[14\], \[15\], jenis _join_, keberadaan _SubPlan_ dan _loops_, _node_ paralel, indeks yang dipakai, jumlah _index_ _searches_ (PG18) \[21\], serta rasio baris estimasi terhadap aktual dengan memperhitungkan loops \[9\], \[27\] | EXPLAIN \[9\]                                | Nominal, rasio (estimasi / aktual) |
| Buffer statistics      | Shared hit tinggi berarti data dilayani buffer PostgreSQL. Blok "read" bukan I/O fisik karena cache OS \[9\]. Blok temp > 0 mengindikasikan spill.                             | Pendukung      | Blok _shared hit_, _read, dirtied_, _written;_ blok temp read/written (indikasi _spill_); waktu I/O hanya bila track_io_timing aktif \[9\]                                                                                                                                                                                          | Opsi BUFFERS \[9\]                           | Blok (rasio)                       |
| Ukuran indeks          | Lebih besar berarti biaya ruang lebih tinggi. Dilaporkan sebagai selisih terhadap I0 per level dan skala, bukan per query.                                                     | Tambahan       | Total dan selisih terhadap I0, diukur setelah indeks dibuat                                                                                                                                                                                                                                                                         | pg_indexes_size \[29\]                       | MB (rasio)                         |
| Waktu pembuatan indeks | Pengukuran tunggal, dilaporkan apa adanya, tidak dibandingkan dengan δ<sub>s</sub>.                                                                                            | Tambahan       | Durasi CREATE INDEX, diukur sisi klien dan dicatat apa adanya                                                                                                                                                                                                                                                                       | Pencatatan sisi klien                        | Detik (rasio)                      |
| Kesetaraan hasil       | R tidak setara berarti kondisi dengan R tidak dijalankan (A4).                                                                                                                 | Verifikasi     | Hasil bentuk O dan R dibandingkan pada setiap kondisi menurut kriteria pada Subbab 3.5.5                                                                                                                                                                                                                                            | Pembandingan keluaran; nilai validasi \[17\] | Setara / Tidak Setara              |
| Status penyelesaian    | Tersensor berarti batas T ≥ τ, bukan nilai terukur.                                                                                                                            | Status         | Eksekusi selesai atau dihentikan batas waktu (statement_timeout, nilai awal 60 menit)                                                                                                                                                                                                                                               | Log Eksekusi                                 | Selesai / Tersensor                |

Alasan memasukkan ukuran dan waktu pembuatan indeks: manfaat indeks perlu dinilai bersama biaya ruang penyimpanan dan pemeliharaannya, dan pemilihan indeks mempertimbangkan konsumsi memori \[12\], \[16\]. Satu catatan untuk _buffer_: blok "_read_" berarti tidak ditemukan di _cache buffer_ PostgreSQL, tetapi pada sistem dengan cache sistem operasi hal itu tidak dapat langsung dibaca sebagai pembacaan fisik dari disk \[9\].

# 2.5.3 Indikator Turunan

Waktu antar-_query_ berbeda orde besaran, sehingga perbandingan dinyatakan sebagai rasio terhadap median _execution time_ (T). Rasio dipilih karena mengungkap efek relatif tanpa mengasumsikan arah, dan analisis statistik pada skala logaritmik diputuskan di Bab III. Notasi: q ∈ {Q2, Q17, Q20}; f ∈ {O, R}; ℓ ∈ {0, 1, 2} untuk level Iℓ; s ∈ {SF1, SF10}; T(q, f, ℓ, s) adalah median _execution time_ kondisi tersebut.

Tabel 2.8 Indikator Turunan

| **Indikator**                | **Rumus**                                     | **Domain**                | **Interpretasi (rasio dan log₂)**                                                                                                                         |
| ---------------------------- | --------------------------------------------- | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| R<sub>rw</sub>(q, ℓ, s)      | T(q,O,ℓ,s) / T(q,R,ℓ,s)                       | ℓ ∈ {0,1,2} (18 nilai)    | log₂ > 0: R lebih cepat; = 0: sama; < 0: R lebih lambat; ±1 berarti dua kali lebih cepat atau lebih lambat                                                |
| R<sub>ix</sub>(q, f, ℓ, s)   | T(q,f,0,s) / T(q,f,ℓ,s)                       | ℓ ∈ {1,2} (24 nilai)      | log₂ > 0: Iℓ lebih cepat dari I0                                                                                                                          |
| R<sub>base</sub>(q, f, ℓ, s) | T(q,O,0,s) / T(q,f,ℓ,s)                       | (f,ℓ) ≠ (O,0) (30 nilai)  | log₂ > 0: kondisi lebih cepat dari baseline                                                                                                               |
| C<sub>int</sub>(q, ℓ, s)     | R<sub>rw</sub>(q,ℓ,s) / R<sub>rw</sub>(q,0,s) | ℓ ∈ {1,2} saja (12 nilai) | log₂ = 0: efek rewriting sama dengan di I0; > 0: efek rewriting bergeser ke arah R lebih cepat pada Iℓ dibanding I0; < 0: bergeser ke arah R lebih lambat |
| C<sub>sf</sub>(X)            | X(·, SF10) / X(·, SF1)                        | argumen lain identik      | log₂ = 0: efek relatif sama pada SF10 dan SF1                                                                                                             |

C<sub>sf</sub><sup>rw</sup>(q, ℓ) = R<sub>rw</sub>(q, ℓ, SF10) / R<sub>rw</sub>(q, ℓ, SF1) (9 nilai); C<sub>sf</sub><sup>ix</sup>(q, f, ℓ) = R<sub>ix</sub>(q, f, ℓ, SF10) / R<sub>ix</sub>(q, f, ℓ, SF1) (12 nilai); C<sub>sf</sub><sup>int</sup>(q, ℓ) = C<sub>int</sub>(q, ℓ, SF10) / C<sub>int</sub>(q, ℓ, SF1) (6 nilai).

Skala analisis dan penanganan data tersensor dijabarkan pada Subbab 3.7. _Trade-off_ RM3 dilaporkan dengan menyandingkan R<sub>ix</sub> dengan ukuran dan waktu pembuatan indeks, tanpa skor gabungan, agar tidak menimbulkan bobot yang arbitrer.

# 2.5.4 Variabel Kontrol dan Batas Operasional

Variabel yang dikendalikan agar perbedaan hasil hanya berasal dari faktor eksperimen meliputi versi DBMS (PostgreSQL 18.6 \[22\] ), lingkungan perangkat keras dan sistem operasi, data dan parameter query, statistik tabel, konfigurasi server, kondisi _cache_, dan konkurensi. Nilai dan prosedur pengendaliannya dijabarkan pada Subbab 3.4 dan 3.6, sedangkan keterbatasan yang menyertainya dirangkum pada Subbab 2.6.4.

# 2.6 Posisi Penelitian dan Pernyataan Kebaruan

# 2.6.1 Posisi Penelitian di antara Studi Terdahulu

Posisi penelitian ini ditentukan pada dua sumbu. Sumbu pertama adalah tingkat intervensi, yaitu apakah perbaikan dilakukan di dalam _engine_ atau _optimizer_, atau pada penulisan SQL oleh pengguna. Sumbu kedua adalah faktor yang dimanipulasi dalam eksperimen. Selain studi pada Tabel 2.1, penelusuran lanjutan menemukan dua studi yang menyentuh query TPC-H berkorelasi: Fent et al. \[30\] dan Dreseler et al. \[31\].

Fent et al. mengembangkan perencanaan dan eksekusi _groupjoin_ dan agregat bersarang pada sistem riset Umbra. Pada TPC-H, _unnesting_ Q2 dan Q20 melalui _groupjoin_ menghasilkan percepatan masing-masing 67% dan 35%, dan rencana Q2 memakai _index_ _join_ sehingga pemindaian penuh partsupp dapat dihindari \[30\]. Studi tersebut juga melaporkan percepatan 6 kali pada Q17 di SF10 saat indeks dipakai dalam _groupjoin_ \[30\]. Dreseler et al. mengkuantifikasi dampak sebelas optimasi plan pada TPC-H di sistem Hyrise dan menemukan bahwa pemipihan _subquery_ serta penempatan predikat berdampak terbesar, dengan Q2, Q17, dan Q21 sangat dipengaruhi pemilihan plan \[31\].

Tabel 2.9 Posisi Penelitian Terdahulu

| **Sumber**                                                                                 | **Tingkat Intervensi**                                         | **Faktor yang Dimanipulasi**                         | **Sistem dan Data**                                                           | **Perbedaan dengan Penelitian Ini**                                     |
| ------------------------------------------------------------------------------------------ | -------------------------------------------------------------- | ---------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Neumann \[6\]; Bruno et al. \[7\]                                                          | Mekanisme _decorrelation_ di _optimizer_                       | Algoritma _unnesting_                                | Umbra, dengan satu _query_ contoh pada PostgreSQL 16; Fabric DW dengan TPC-DS | Penelitian ini menguji penulisan ulang SQL, bukan mekanisme _optimizer_ |
| Dharwada et al. \[4\]; Li et al. \[18\]                                                    | _Rewriting_ otomatis (LLM atau aturan)                         | Bentuk _query_ hasil model                           | TPC-DS; TPC-H, IMDB, DSB                                                      | Bentuk _rewriting_ dirancang dan diverifikasi eksplisit                 |
| Fent et al. \[30\]                                                                         | Di dalam _engine_ (_groupjoin_, estimasi, _index_ _groupjoin_) | Teknik perencanaan dan eksekusi                      | Umbra; TPC-H dan TPC-DS                                                       | PostgreSQL 18.6; tingkat SQL; indeks sebagai faktor tiga level          |
| Dreseler et al. \[31\]                                                                     | _Optimasi plan_ pada sistem riset                              | Optimasi _choke_ _point_                             | Hyrise; TPC-H                                                                 | PostgreSQL; fokus tiga query; indeks dan interaksi diukur               |
| Ramdhani & Widodo \[3\]; Hamadou et al. \[5\]; Schlosser et al. \[16\]; Zhou et al. \[19\] | Konfigurasi indeks                                             | Jenis atau konfigurasi indeks                        | PostgreSQL dan sistem lain; TPC-H, data sintetis                              | Bentuk SQL ikut dimanipulasi                                            |
| Agrawal et al. \[20\]                                                                      | Tuning multi-lapis                                             | Indeks dan bentuk _query_ (eksperimen terpisah)      | PostgreSQL 13.20 dan tiga DBMS lain; skema sintetis                           | Q2, Q17, Q20 pada TPC-H; interaksi diukur eksplisit                     |
| Penelitian ini                                                                             | Penulisan SQL oleh pengguna dan strategi indeks                | Bentuk SQL (2) × strategi _indexing_ (3) × skala (2) | PostgreSQL 18.6; TPC-H Q2, Q17, Q20                                           |                                                                         |

Posisi penelitian ini adalah evaluasi empiris tingkat pengguna. Fokusnya adalah apa yang dapat dilakukan pengelola basis data PostgreSQL dengan menulis ulang _query_ dan menambah indeks, bukan teknik baru di dalam _optimizer_.

# 2.6.2 Kontribusi Empiris yang Dituju

Penelitian ini bertujuan memberikan empat kontribusi empiris:

1. Perbandingan terkontrol bentuk asli dan bentuk hasil _rewriting_ TPC-H Q2, Q17, dan Q20 pada PostgreSQL 18.6, pada skala SF1 dan SF10.
2. Pengaruh tiga level strategi _indexing_ terhadap _execution time_, serta interaksinya dengan _rewriting_ yang diukur melalui kontras interaksi.
3. Penjelasan perubahan kinerja melalui indikator pendukung (_execution plan_, _planning_ _time_, dan _buffer statistics_), sehingga hasil tidak hanya berupa angka waktu.
4. Informasi _trade-off_, yaitu manfaat performa bersama ukuran dan waktu pembuatan indeks, sebagai informasi pendukung keputusan optimasi.

# 2.6.3 Pernyataan Kebaruan dan Batasnya

Kebaruan penelitian ini adalah kebaruan kombinasi, yaitu pembeda yang muncul ketika elemen yang sudah mapan diuji bersama dalam satu rancangan terkontrol. Penilaiannya mengikuti empat langkah berikut.

Konsep**.** Elemen yang diuji, yaitu _decorrelation_, strategi _indexing_, dan TPC-H, sudah mapan \[6\], \[7\], \[12\], \[17\]. Yang dinilai kebaruannya adalah kombinasi (a) sampai (e) pada alinea sebelumnya.

Dasar teori. Menurut kerangka konseptual (Subbab 2.4.4), bentuk SQL memengaruhi struktur _plan_ (R1), strategi _indexing_ memengaruhi metode akses pada _plan_ (R2), dan keduanya dapat saling memengaruhi (R4). Bruno et al. menyatakan bahwa eksekusi _tuple-at-a-time_ pada _correlated subquery_ umumnya lambat kecuali tersedia strategi indeks yang mendukungnya \[7\]. Karena itu efek _rewriting_ dan efek _indexing_ tidak dapat dinilai terpisah, dan interaksinya hanya dapat diamati bila kedua faktor dimanipulasi bersama pada _query_ yang sama.

Prinsip penilaian. Studi terdekat dibandingkan pada dimensi (a) sampai (e) (Tabel 2.9). Studi yang hanya memanipulasi bentuk _query_ atau mekanisme _decorrelation_ \[4\], \[6\], \[7\], \[18\] atau hanya memanipulasi indeks \[3\], \[5\], \[16\], \[19\] tidak memenuhi (c). Studi terdekat bekerja pada sistem berbeda (Umbra \[30\], Hyrise \[31\], PostgreSQL 13.20 \[20\]), dan hanya \[20\] membandingkan formulasi SQL pada PostgreSQL, tetapi pada skema sintetis dan dengan indeks diuji pada eksperimen terpisah. Kebaruan dinyatakan bila pada sumber yang ditelaah tidak ada studi yang memenuhi seluruh dimensi secara bersamaan. Pernyataan ini dibatasi pada sumber yang ditelaah dan prosedur penelusuran pada Tabel 2.10.

Relevansi. Dimensi (b) menjawab RM1, dimensi (c) menjawab RM2, dan dimensi (d) memungkinkan konsistensi efek lintas skala dinilai pada RM1 sampai RM3. Dimensi (e) menjelaskan perubahan _execution time_ melalui _execution plan_, _planning time_, dan _buffer statistics_ (Celah 3, Subbab 2.2.3), dan secara khusus mendukung RM3. Dimensi (a) menetapkan batas generalisasi (Subbab 2.6.4). Penelusuran literatur yang dirangkum pada Tabel 2.10 dilakukan untuk memeriksa apakah ada studi yang memenuhi kombinasi (a) sampai (e) secara bersamaan. Ketiadaan temuan pada penelusuran tersebut tidak dibaca sebagai bukti bahwa studi demikian tidak ada, karena cakupan basis data, kata kunci, dan rentang waktu terbatas. Mesin pencari web umum hanya dipakai sebagai pelengkap untuk menemukan \[30\], \[31\], dan sumber non-ilmiah seperti blog tidak dipakai sebagai dasar klaim.

Tabel 2.10 Ringkasan Penelusuran Literatur untuk Verifikasi Kesenjangan

| **No** | **Kueri (Ringkas)**                                                        | **Sumber Penelusuran**    | **Temuan Relevan**                                           | **Tindak Lanjut**                   |
| ------ | -------------------------------------------------------------------------- | ------------------------- | ------------------------------------------------------------ | ----------------------------------- |
| 1      | correlated subquery rewriting + index interaction, PostgreSQL, TPC-H       | Mesin web umum (Okt 2026) | \[20\] (eksperimen _preprint_ terpisah)                      | Dipakai sebagai pembanding terdekat |
| 2      | PostgreSQL TPC-H Q17 Q20 correlated subquery rewrite JOIN index evaluation | Mesin web umum (Okt 2026) | \[30\], \[31\]; selebihnya GitHub dan blog (tidak bersitasi) | Ditelaah, tidak mengubah celah      |
| 3      | indexing + SQL query rewriting combined, PostgreSQL, subquery to join      | Mesin web umum (Okt 2026) | Tidak ada studi bersitasi; hanya blog praktisi               | Tidak ada                           |
| 4      | optimasi query PostgreSQL subquery vs JOIN indeks (bahasa Indonesia)       | Mesin web umum (Okt 2026) | Tidak ditemukan artikel ilmiah                               | Tidak ada                           |

Klaim di atas bukan klaim "pertama" yang mutlak. Ia berlaku pada sumber yang ditelaah hingga Oktober 2026, dan dapat berubah bila studi yang memenuhi kombinasi tersebut ditemukan kemudian.

# 2.6.4 Batas Generalisasi Hasil

Hasil penelitian ini tidak digeneralisasi di luar batas berikut:

1. DBMS dan versi: hanya PostgreSQL 18.6. Fitur seri 18 seperti _skip scan_ dan _asynchronous_ I/O dapat memengaruhi hasil \[21\].
2. _Workload_: hanya beban kerja turunan TPC-H yang terdiri atas Q2, Q17, dan Q20 dengan satu set nilai parameter validasi TPC-H 3.0.1 untuk setiap _query_. Hasil tidak mewakili seluruh _query_ berkorelasi maupun variasi parameter lainnya.
3. Lingkungan: satu mesin dengan RAM 8 GB. Pada SF10 data melebihi memori, sehingga perbedaan SF1 dan SF10 mencerminkan perubahan volume sekaligus tekanan memori.
4. Indeks: hanya B-tree. Level I2 berada di luar batas indeks spesifikasi TPC-H, sehingga hasilnya merupakan beban kerja turunan TPC-H \[17\].
5. Tingkat intervensi: hasil _rewriting_ di tingkat SQL tidak dapat dibaca sebagai efektivitas algoritma _decorrelation_ di dalam _optimizer_ \[6\], \[7\], \[30\].
6. Sistem lain: besaran percepatan pada Umbra atau Hyrise tidak dapat dipindahkan ke PostgreSQL. Fent et al. melaporkan Umbra sekitar 101 kali lebih cepat daripada PostgreSQL pada TPC-H, dan lingkungan ujinya jauh berbeda dengan mesin penelitian ini \[30\].

# BAB III

METODOLOGI PENELITIAN

# 3.1 Analisis Masalah dan Formulasi

# 3.1.1 Alur Input-Proses-Output

Penelitian ini memperlakukan eksekusi _query_ sebagai proses yang diamati di bawah kondisi terkontrol. _Input_ terdiri atas tiga faktor dan satu blok (_query_): bentuk SQL (O dan R), level indeks (I0, I1, I2), skala data (SF1 dan SF10), dan query (Q2, Q17, Q20). Seluruhnya dijalankan pada basis data turunan TPC-H \[17\] di PostgreSQL 18.6 \[21\], \[22\] dengan konfigurasi lingkungan yang sama. Proses adalah eksekusi tiap kondisi menurut protokol yang diuraikan pada Subbab 3.6, setelah ekuivalensi bentuk R terbukti. _Output_ berupa _execution time_ sebagai metrik utama; _planning time,_ _execution plan_, dan _buffer_ _statistics_ sebagai indikator pendukung; ukuran indeks dan waktu pembuatan indeks sebagai ukuran biaya; serta indikator turunan R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>, C<sub>int</sub>, dan C<sub>sf</sub> yang didefinisikan pada Subbab 2.5. Tidak ada skor gabungan. Ringkasannya disajikan pada Gambar 3.1 dan Tabel 3.1.

Tabel 3.1 Ringkasan input–proses–output

| **Komponen**        | **Isi**                                                                                                                                                                                |
| ------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| _Input_ (faktor)    | Bentuk SQL {O, R}; level indeks {I0, I1, I2}; skala {SF1, SF10}; query {Q2, Q17, Q20}                                                                                                  |
| _Input_ (dikontrol) | Versi DBMS, data dan _seed_, parameter _query_, konfigurasi server, perangkat keras, status _cache_                                                                                    |
| Proses              | Validasi ekuivalen O/R → penguncian desain indeks → eksekusi 36 kondisi → pengumpulan data mentah                                                                                      |
| _Output_            | Execution time; planning time; execution plan; buffer statistics; ukuran dan waktu pembuatan indeks; R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>, C<sub>int</sub>, C<sub>sf</sub> |

Gambar 3.1 Alur input–proses–output penelitian

# 3.1.2 Ringkasan Kesenjangan

Berdasarkan penelusuran literatur yang dilakukan (Subbab 2.2), pengaruh _rewriting_ dan pengaruh strategi _indexing_ umumnya ditinjau secara terpisah, sedangkan interaksi keduanya pada _query_ berkorelasi di PostgreSQL 18.6 belum diuji secara terkontrol pada konfigurasi yang terdokumentasi dapat direproduksi. Pernyataan ini terbatas pada sumber yang ditelusuri dan tidak dimaksudkan sebagai klaim bahwa tidak ada studi lain. Dari kesenjangan tersebut, masalah yang dirumuskan adalah pada kondisi apa _rewriting_, _indexing_, atau keduanya mengubah _execution time_ melampaui variasi pengukuran, dan berapa biaya yang menyertainya, tanpa mengasumsikan bahwa salah satunya selalu menguntungkan.

# 3.1.3 Asumsi

Asumsi berikut menjadi batas berlakunya kesimpulan. Dampaknya terhadap validitas dibahas pada Subbab 3.8.

Tabel 3.2 Asumsi Penelitian

| **Kode** | **Asumsi**                                                                                               | **Konsekuensi**                                                |
| -------- | -------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| A1       | Satu set nilai parameter validasi TPC-H 3.0.1 cukup sebagai titik pengamatan untuk setiap _query_ \[17\] | Kesimpulan tidak diperluas ke parameter lain                   |
| A2       | Kondisi _warm cache_ dengan satu sesi tanpa konkurensi                                                   | Tidak mewakili beban multipengguna atau _cold start_           |
| A3       | Statistik _planner_ dimutakhirkan setelah pemuatan data dan setiap perubahan level indeks                | Prosedur pembaruan ditetapkan pada Subbab 3.6                  |
| A4       | R sah hanya bila hasilnya ekuivalen dengan O                                                             | Kondisi dengan R yang belum lulus validasi tidak dijalankan    |
| A5       | Lingkungan satu mesin cukup stabil selama pengukuran                                                     | Variasi diperiksa pada pilot                                   |
| A6       | Perbedaan SF1 dan SF10 mencampur pengaruh volume dan tekanan memori (SF10 melebihi RAM)                  | C<sub>sf</sub> tidak ditafsirkan sebagai pengaruh volume murni |

# 3.1.4 Skenario dan Struktur Kondisi Eksperimen

Skenario penelitian adalah situasi seorang pengelola basis data yang menghadapi query berkorelasi lambat dan dapat memilih menulis ulang _query_, menambah indeks, atau keduanya. Setiap skenario dioperasionalkan sebagai satu kombinasi bentuk SQL, level indeks, skala, dan _query_, sehingga terdapat 2 × 3 × 2 × 3 = 36 kondisi. Level indeks bersifat kumulatif (I0 ⊂ I1 ⊂ I2), sehingga perbedaan antar level hanya berasal dari indeks yang ditambahkan. Rincian matriks dan desainnya ada pada Subbab 3.2.

# 3.1.5 Unit Analisis

Unit analisis adalah kondisi eksperimen, yaitu satu kombinasi (_query_, bentuk SQL, level indeks, skala). Unit observasi adalah satu eksekusi terukur; nilai wakil suatu kondisi diringkas dari pengulangannya menurut Subbab 3.7. Indikator turunan dihitung pada pasangan kondisi yang hanya berbeda pada satu faktor (misalnya O dan R pada _query_, level indeks, dan skala yang sama untuk R<sub>rw</sub>), sedangkan C<sub>int</sub> membandingkan efek _rewriting_ antar level indeks.

# 3.1.6 Pemetaan Rumusan Masalah ke Keluaran

Tabel 3.3 Pemetaan Rumusan Masalah ke Keluaran

| **Rumusan Masalah**                                           | **Tujuan** | **Keluaran**                                                                                   | **Dibahas pada** |
| ------------------------------------------------------------- | ---------- | ---------------------------------------------------------------------------------------------- | ---------------- |
| RM1 (Pengaruh _Rewriting_)                                    | Tujuan 1   | C<sub>sf</sub> atas R<sub>rw</sub> per query, level indeks, dan skala                          | 3.6, 3.7         |
| RM2 (pengaruh _indexing_ dan interaksi)                       | Tujuan 2   | C<sub>sf</sub> atas R<sub>ix</sub> dan C<sub>int</sub>                                         | 3.6, 3.7         |
| RM3 (perubahan melampaui variasi pengukuran dan biaya indeks) | Tujuan 3   | R<sub>base</sub> per kondisi; tabel kondisi manfaat dan biaya indeks (ukuran, waktu pembuatan) | 3.7              |

Batas variasi pengukuran ditetapkan dari pilot sebelum eksperimen utama menurut prosedur pada Subbab 3.6, dan aturan klasifikasinya diuraikan pada Subbab 3.7.

# 3.2 Research Design

# 3.2.1 Pendekatan Eksperimen

Penelitian ini menggunakan pendekatan eksperimen terkontrol kuantitatif. RM1–RM3 menanyakan perubahan _execution time_ akibat manipulasi bentuk SQL dan level indeks. Pertanyaan seperti ini hanya dapat dijawab bila faktor dimanipulasi secara sengaja sementara variabel lain ditahan tetap \[32\]. Objek eksperimen adalah PostgreSQL 18.6 \[21\], \[22\] dengan beban kerja turunan TPC-H \[17\]. Eksperimen dijalankan pada satu lingkungan tanpa partisipan manusia.

Rancangan ini juga memperhitungkan jebakan umum pengujian performa basis data. Studi \[33\] menguraikan jebakan yang dapat menimbulkan perbedaan performa semu, antara lain pada konfigurasi sistem dan pemeriksaan kebenaran hasil. Tinjauan sistematis \[34\] menyimpulkan bahwa pengujian performa DBMS umumnya dilaporkan dengan rincian yang tidak memadai untuk replikasi. Rancangan ini karena itu memuat pemeriksaan ekuivalensi hasil sebelum pengukuran (Subbab 3.6), konfigurasi dan _data definition language_ (DDL) yang terdokumentasi (Subbab 3.4, Lampiran A dan B), serta pelaporan data mentah dan _hash_ pada repository penelitian (Subbab 3.4.6).

# 3.2.2 Desain Faktorial Penuh Terblok

Rancangan penelitian adalah faktorial penuh atas tiga faktor, yaitu bentuk SQL (F, 2 level), (L, 3 level), dan skala data (S, 2 level), dengan _query_ (Q, 3 blok) sebagai blok. Jumlah kondisi eksperimen adalah N = |F| × |L| × |S| × |Q| = 2 × 3 × 2 × 3 = 36.

Faktorial penuh dipilih agar seluruh pengaruh utama dan interaksi, termasuk interaksi _rewriting_–indeks (C<sub>int</sub>) dan konsistensi antar skala (C<sub>sf</sub>), dapat diperoleh tanpa tercampur dengan pengaruh lain. Jumlah kondisi yang kecil membuat rancangan faktorial fraksional tidak diperlukan \[32\].

_Query_ diperlakukan sebagai blok, bukan faktor. Q2, Q17, dan Q20 dipilih karena memuat _correlated subquery_ dengan bentuk berbeda (Subbab 2.3), bukan sebagai sampel acak dari populasi _query_. Pengaruh faktor karenanya dianalisis di dalam setiap blok _query_ dan tidak dirata-ratakan lintas _query_. Perbedaan antar-_query_ dilaporkan secara deskriptif.

Level indeks bersifat kumulatif (I0 ⊂ I1 ⊂ I2; Subbab 2.5.1), sehingga perbedaan antarlevel menggambarkan penambahan indeks, bukan pergantian himpunan indeks. SF1 dan SF10 adalah dua basis data terpisah. Perbedaan keduanya mencampur pengaruh volume dan tekanan memori (A6, Tabel 3.2), sehingga C<sub>sf</sub> tidak ditafsirkan sebagai pengaruh volume murni.

Setiap kondisi diberi kode K01–K36 dengan aturan K = 12(q − 1) + 6(s − 1) + 3(f − 1) + j; q, s, f, dan j berturut-turut menyatakan nomor urut (mulai dari 1) _query_ (Q2, Q17, Q20), skala (SF1, SF10), bentuk SQL (O, R), dan level indeks (I0, I1, I2; j = ℓ + 1). Kondisi _baseline_ pada setiap blok _query_ dan skala adalah O–I0. Matriks lengkap disajikan pada Tabel 3.4 dan Gambar 3.2.

Tabel 3.4 Matriks 36 Kondisi Eksperimen

| **Bentuk-Level** | **Q2 SF1** | **Q2 SF10** | **Q17 SF1** | **Q17 SF10** | **Q20 SF1** | **Q20 SF10** |
| ---------------- | ---------- | ----------- | ----------- | ------------ | ----------- | ------------ |
| O–I0             | K01        | K07         | K13         | K19          | K25         | K31          |
| O–I1             | K02        | K08         | K14         | K20          | K26         | K32          |
| O–I2             | K03        | K09         | K15         | K21          | K27         | K33          |
| R–I0             | K04        | K10         | K16         | K22          | K28         | K34          |
| R–I1             | K05        | K11         | K17         | K23          | K29         | K35          |
| R–I2             | K06        | K12         | K18         | K24          | K30         | K36          |

Gambar 3.2 Diagram Matriks 36 Kondisi Eksperimen

Setiap kondisi diukur berulang agar variasi pengukuran dapat diperkirakan. Dengan nilai awal protokol (1 _warm-up_ dan 5 eksekusi terukur), total pengamatan terukur paling banyak 36 × 5 = 180, dan lebih sedikit bila kondisi yang lambat memakai 3 atau 1 eksekusi. Nilai final ditetapkan pada G3 (Subbab 3.6).

Prinsip randomisasi \[32\] tidak dapat diterapkan penuh, karena pergantian level indeks berarti membuat indeks pada basis data yang sama dan skala dijalankan berurutan. Eksekusi karenanya diblokir menurut skala dan level (SF1 lalu SF10; I0, I1, I2), dengan pemeriksaan ulang I0 di akhir untuk mendeteksi pergeseran kondisi lingkungan. Urutan bentuk SQL dan _query_ di dalam satu level ditetapkan pada Subbab 3.6. Keterbatasan randomisasi dibahas pada Subbab 3.8.

Konsekuensi desain ini ada tiga. Pertama, setiap blok _query_ memuat 2 × 3 × 2 = 12 kondisi yang dianalisis sendiri-sendiri, sehingga R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>, C<sub>int</sub>, dan C<sub>sf</sub> dihitung di dalam blok dan tidak digabung lintas _query_. Kedua, tidak ada rata-rata atau pengujian lintas _query_, sehingga tidak ada klaim tentang populasi _query_ TPC-H. Ketiga, perbedaan antar-_query_ hanya dilaporkan deskriptif, bukan sebagai efek faktor.

# 3.2.3 Variabel Penelitian

Tabel 3.5 Faktor, Level, dan Variabel Respons

| **Kelompok**          | **Variabel**                                                                                                          | **Level / nilai**                      | **Definisi** |
| --------------------- | --------------------------------------------------------------------------------------------------------------------- | -------------------------------------- | ------------ |
| Faktor                | Bentuk SQL                                                                                                            | O, R                                   | Tabel 2.6    |
| Faktor                | Level indeks                                                                                                          | I0, I1, I2                             | Tabel 2.6    |
| Faktor                | Skala data                                                                                                            | SF1, SF10                              | Tabel 2.6    |
| Blok                  | Query                                                                                                                 | Q2, Q17, Q20                           | Tabel 2.6    |
| Respons utama         | Execution time                                                                                                        | Median dan rentang eksekusi terukur    | Tabel 2.7    |
| Respons pendukung     | Planning time, execution plan, buffer statistics                                                                      | Per kondisi                            | Tabel 2.7    |
| Respons tambahan      | Ukuran indeks, waktu pembuatan indeks                                                                                 | Per level indeks dan skala             | Tabel 2.7    |
| Respons turunan       | R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>, C<sub>int</sub>, C<sub>sf</sub>                                     | Rasio antar-kondisi                    | Tabel 2.8    |
| Verifikasi dan status | Kesetaraan hasil; status penyelesaian                                                                                 | Setara/tidak setara; selesai/tersensor | Tabel 2.7    |
| Variabel kontrol      | Versi DBMS, data dan parameter query, statistik tabel, konfigurasi server, kondisi cache, konkurensi, perangkat keras | Nilai pada Subbab 3.4                  | Subbab 2.5.4 |

Biaya indeks adalah atribut level indeks dan skala, bukan atribut kondisi, karena himpunan indeks dibuat pada tingkat basis data dan dipakai bersama oleh ketiga _query_. Biaya itu dilaporkan per level dan skala, dan tidak dialokasikan ke satu _query_ tertentu.

Indikator turunan dihitung pada pasangan kondisi yang hanya berbeda pada satu faktor (Tabel 3.6). Pasangan R<sub>base</sub> membandingkan setiap kondisi dengan _baseline_ O–I0 pada _query_ dan skala yang sama.

Tabel 3.6 Struktur Perbandingan Indikator Turunan

| **Indikator**    | **Pasangan yang dibandingkan**                                                      | **Jumlah pasangan** |
| ---------------- | ----------------------------------------------------------------------------------- | ------------------- |
| R<sub>rw</sub>   | O vs R pada query, level, dan skala yang sama                                       | 18                  |
| R<sub>ix</sub>   | I0 vs Iℓ (ℓ ∈ {1, 2}) pada query, bentuk, dan skala yang sama                       | 24                  |
| R<sub>base</sub> | O–I0 vs setiap kondisi lain pada query dan skala yang sama                          | 30                  |
| C<sub>int</sub>  | R<sub>rw</sub> pada Ik (I1, I2) vs R<sub>rw</sub> pada I0                           | 12                  |
| C<sub>sf</sub>   | Indikator pada SF10 vs SF1 (9 R<sub>rw</sub>, 12 R<sub>ix</sub>, 6 C<sub>int</sub>) | 27                  |

# 3.2.4 Batas Inferensi

Kesimpulan penelitian hanya berlaku pada konfigurasi yang diuji, yaitu PostgreSQL 18.6, satu mesin, beban kerja turunan TPC-H, tiga _query_ (Q2, Q17, dan Q20), satu set parameter validasi TPC-H 3.0.1 untuk setiap _query_, kondisi _warm cache_, dan satu sesi tanpa konkurensi (A1, A2, A5 pada Tabel 3.2). Hasil tidak digeneralisasi ke _query_, DBMS, atau beban kerja lain. Bentuk R menulis ulang _query_ melampaui modifikasi minor dan level I2 melampaui batas indeks spesifikasi TPC-H \[17\], sehingga hasilnya dilaporkan sebagai beban kerja turunan TPC-H, bukan hasil TPC-H resmi. Penelitian ini tidak merumuskan hipotesis statistik. Klasifikasi perubahan _execution time_ sebagai melampaui atau tidak melampaui variasi pengukuran memakai pita variasi dari pilot (Subbab 3.6 dan 3.7). Hasil negatif, tidak konsisten, atau berupa _trade-off_ diperlakukan sebagai temuan yang sah.

# 3.3 Data, Sampling, dan Partisipan

# 3.3.1 Partisipan dan Sumber Data

Penelitian ini tidak melibatkan partisipan manusia dan tidak memakai data pribadi maupun data operasional. Seluruh data bersifat sintetis dan dibangkitkan oleh dbgen versi 3.0.1 dari paket TPC-H \[17\] tanpa modifikasi kode sumber. Hasil dilaporkan sebagai beban kerja turunan TPC-H, bukan hasil TPC-H resmi, karena bentuk R menulis ulang _query_ melampaui modifikasi minor yang dibolehkan spesifikasi, level indeks I2 melampaui batas pembuatan indeks pada spesifikasi (klausa 1.5.7), dan pengujian lain pada spesifikasi, seperti fungsi _refresh_, tidak dijalankan \[17\].

# 3.3.2 Populasi, Sampel, dan Justifikasi

Populasi penelitian adalah ruang beban kerja turunan TPC-H, yaitu 22 _query_ pada skema delapan tabel di berbagai skala \[17\]. Sampelnya adalah tiga _query_ (Q2, Q17, Q20) dan dua skala (SF1, SF10) yang dipilih secara purposif menurut kriteria pada Subbab 2.3, bukan secara acak. Dengan jumlah kondisi yang tetap (36; Tabel 3.4), penelitian ini tidak mengestimasi parameter populasi, sehingga ukuran sampel dan _power analysis_ tidak dihitung. Dasar lainnya adalah bahwa penelitian ini tidak merumuskan hipotesis statistik (Subbab 3.2.4).

Kecukupan data ditentukan oleh jumlah pengulangan per kondisi, karena replikasi diperlukan untuk memperkirakan variasi pengukuran \[32\]. Nilai awalnya adalah 1 eksekusi _warm-up_ dan 5 eksekusi terukur, dengan 3 eksekusi bila waktu melebihi 10 menit dan 1 bila tersensor. Pilot memvalidasi nilai ini pada G3. Bila pilot menunjukkan variasi yang terlalu lebar untuk menetapkan batas variasi pengukuran, sumber variasi ditelusuri (Subbab 3.6.6); penambahan pengulangan hanya menstabilkan median dan diputuskan sebelum G3. Setelah G3, perubahan dicatat sebagai penyimpangan protokol (Subbab 3.6).

# 3.3.3 Pembangkitan, Pemuatan, dan Verifikasi Data

Data dibangkitkan sekali untuk setiap skala dan dipakai oleh seluruh kondisi pada skala tersebut. Basis data tidak dibangkitkan ulang antarkondisi. Yang berubah hanya himpunan indeks (Subbab 3.2.2). Prosedurnya sebagai berikut (Gambar 3.3).

Gambar 3.3 Alur Pembangkitan, Pemuatan, dan Verifikasi Data

1. dbgen dijalankan untuk SF1 dan SF10 dengan perintah dan parameter yang dicatat pada berkas log bersama versi alat, menghasilkan berkas _.tbl_ untuk delapan tabel. Determinisme pembangkitan diperiksa dengan membangkitkan ulang SF1 dan membandingkan hash SHA-256 kedua keluaran.
2. _Hash_ setiap berkas keluaran dicatat dengan SHA-256 pada manifest repository (Subbab 3.4.6).
3. Skema dan _primary key_ dibuat (Lampiran A, berkas A1).
4. Data dimuat ke basis data terpisah per skala (skrip pemuatan pada repositori, Subbab 3.4.6).
5. _Foreign key_ ditambahkan setelah pemuatan. Karena spesifikasi mensyaratkan bahwa bila satu FK didefinisikan maka seluruh FK yang tercantum harus didefinisikan \[17\], jumlahnya sepuluh (klausa 1.4.2.3; Lampiran A, berkas A2).
6. Statistik _planner_ diperbarui dengan VACUUM (ANALYZE) (Lampiran A, berkas A3). Prosedur final pada Subbab 3.6.
7. Verifikasi dan bukti: (a) jumlah baris setiap tabel (SELECT count(\*)) dibandingkan Tabel 2.3 dan disimpan sebagai log; (b) sepuluh FK diperiksa melalui katalog pg_constraint dan dicatat; (c) I0 diperiksa melalui pg_indexes dengan hasil tepat 8 indeks dan daftarnya disimpan; (d) hash berkas data tercatat pada _manifest_; (e) parameter _query_ tersimpan pada berkas parameter yang berhash.

Kriteria lulus verifikasi adalah jumlah baris yang tepat sesuai skala, mengikuti klausa 1.5.3 \[17\] (Tabel 2.3). Jumlah baris LINEITEM bukan kelipatan tepat dari SF sehingga nilai tepatnya diambil dari spesifikasi dan hasil pembangkitan. Basis data baru dipakai setelah lulus verifikasi (G0).

# 3.3.4 Parameter _Query_ serta Inklusi dan Eksklusi

Setiap _query_ dijalankan menggunakan satu set nilai parameter validasi yang ditetapkan dalam spesifikasi TPC-H 3.0.1 (Tabel 3.7). Nilai tersebut dipilih agar hasil eksekusi bentuk SQL asli dapat dicocokkan dengan keluaran validasi yang disediakan spesifikasi pada basis data kualifikasi. Penggunaan satu set parameter yang tetap juga menghindari pemilihan parameter berdasarkan hasil performa eksperimen. Nilai parameter yang sama diterapkan pada bentuk SQL asli (O) dan bentuk hasil _rewriting_ (R), serta dipertahankan pada skala SF1 dan SF10. Parameter yang dibangkitkan secara acak oleh QGEN tidak digunakan dalam eksperimen utama. Dengan demikian, parameter _query_ diperlakukan sebagai variabel kontrol yang nilainya ditetapkan sebelum validasi dan tidak diubah selama eksperimen.

Tabel 3.7 Nilai Parameter Validasi TPC-H 3.0.1 \[17\]

| **Query** | **Parameter**       | **Nilai**                  | **Klausa** |
| --------- | ------------------- | -------------------------- | ---------- |
| Q2        | SIZE; TYPE; REGION  | 15; BRASS; EUROPE          | 2.4.2.4    |
| Q17       | BRAND; CONTAINER    | Brand#23; MED BOX          | 2.4.17.4   |
| Q20       | COLOR; DATE; NATION | forest; 1994-01-01; CANADA | 2.4.20.4   |

Definisi fungsional Q2, Q17, dan Q20 pada spesifikasi TPC-H 3.0.1 digunakan sebagai acuan penyusunan bentuk SQL asli (O). Definisi tersebut diimplementasikan dalam sintaks yang dapat dieksekusi oleh PostgreSQL 18.6 tanpa mengubah fungsi dan hasil yang disyaratkan. Bentuk SQL hasil _rewriting_ (R) kemudian disusun melalui transformasi terhadap bentuk O dengan mempertahankan kesetaraan semantik. Setiap _query_ memiliki sepasang berkas SQL, yaitu bentuk O dan R, sehingga keseluruhan terdapat enam berkas SQL yang disimpan dalam repositori penelitian. Nilai parameter disediakan secara konsisten melalui konfigurasi yang sama untuk kedua bentuk _query_. Seluruh berkas SQL dan konfigurasi parameter dibekukan sebelum pelaksanaan pilot dan eksperimen utama. Rincian validasi kesetaraan kedua bentuk _query_ dijelaskan pada Subbab 3.6.3.

Kriteria inklusi dan eksklusi disajikan pada Tabel 3.8. Nilai ekstrem tanpa gangguan teknis tidak dibuang, dan kondisi yang buruk tidak dikeluarkan dari analisis.

Tabel 3.8 Kriteria Inklusi dan Eksklusi

| **Kategori**                        | **Kriteria**                                   | **Perlakuan**                                       |
| ----------------------------------- | ---------------------------------------------- | --------------------------------------------------- |
| Eksekusi terukur normal             | Selesai sebelum timeout; hasil O/R lulus G1    | Dipakai dalam analisis                              |
| Eksekusi tersensor                  | Mencapai timeout (nilai awal 60 menit)         | Dilaporkan sebagai batas bawah, bukan angka         |
| Eksekusi gagal teknis               | Galat DBMS atau gangguan lingkungan terdeteksi | Dicatat, tidak dihitung, dan diulang                |
| Nilai ekstrem tanpa gangguan teknis | Tidak ada indikasi gangguan                    | Tetap dipakai; ringkasan memakai median dan rentang |

# 3.4 Instrumentasi dan Lingkungan Penelitian

# 3.4.1 Perangkat Keras dan Sistem Operasi

Seluruh eksperimen dijalankan pada satu laptop tanpa mesin lain.

Tabel 3.9 Spesifikasi Perangkat Keras dan Sistem Operasi

| **Komponen**   | **Spesifikasi**                                                                              |
| -------------- | -------------------------------------------------------------------------------------------- |
| Prosesor       | Intel Core i5-10300H; 4 inti, 8 thread; frekuensi dasar 2,5 GHz, turbo hingga 4,5 GHz \[35\] |
| Memori         | 8 GB (7,84 GB dapat digunakan)                                                               |
| Penyimpanan    | SSD 477 GB KINGSTON OM8PCP3512F-AB; antarmuka NVMe                                           |
| Sistem operasi | Windows 10 Home Single Language, versi 22H2                                                  |

# 3.4.2 Perangkat Lunak

Tabel 3.10 Perangkat Lunak

| **Perangkat lunak**                  | **Versi**                                                                                                                      | **Fungsi**                                  |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------- |
| PostgreSQL                           | 18.6 \[21\], \[22\]; versi terpasang diverifikasi dengan SELECT version() dan SHOW server_version pada G0 dan dicatat pada log | DBMS objek penelitian                       |
| psql                                 | Bawaan paket PostgreSQL 18.6; keluaran psql --version dicatat                                                                  | Klien eksekusi query dan DDL                |
| dbgen dan qgen                       | 3.0.1 \[17\]                                                                                                                   | Pembangkit data dan teks query (Subbab 3.3) |
| Bahasa skrip                         | Python 3.10.1                                                                                                                  | Orkestrasi eksekusi dan pengumpulan data    |
| Git                                  | 2.34.1.windows.1                                                                                                               | Pengendali versi skrip dan data mentah      |
| Alat pemantau suhu dan frekuensi CPU | HWiNFO dengan log CSV interval 1 detik                                                                                         | Deteksi thermal throttling                  |

Gambar 3.4 Lapisan Lingkungan Eksperimen

# 3.4.3 Konfigurasi Server

Prinsip konfigurasi:

1. Satu konfigurasi dipakai untuk seluruh 36 kondisi, tanpa _tuning_ per kondisi
2. Parameter yang memengaruhi pemilihan _plan_ dipertahankan bawaan, kecuali ukuran memori yang menyesuaikan perangkat keras serta jit dan autovacuum yang dinonaktifkan untuk pengendalian pengukuran.
3. Konfigurasi dikunci pada G3, dan perubahan sesudahnya dicatat sebagai penyimpangan protokol (Subbab 3.6).

Nilai efektif seluruh parameter dicatat melalui SHOW ALL dan opsi SETTINGS pada EXPLAIN. Basis data dibuat dengan _encoding_ UTF8 dan kolasi C.

Tabel 3.11 Parameter Server

| **Parameter**                   | **Nilai**                                           | **Dasar**                                                                                                                                                                             |
| ------------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| shared_buffers                  | 2 GB                                                | Sekitar 25% memori, titik awal yang disarankan dokumentasi untuk server khusus; bawaan 128 MB \[36\]                                                                                  |
| work_mem                        | 64 MB                                               | Bawaan 4 MB; penggunaan total dapat beberapa kali nilai ini karena dipakai per operasi dan per proses \[36\]                                                                          |
| hash_mem_multiplier             | Bawaan (2,0)                                        | Operasi hash memakai work_mem dikali pengali ini \[36\]                                                                                                                               |
| maintenance_work_mem            | 1 GB                                                | Dipakai CREATE INDEX, VACUUM, dan ADD FOREIGN KEY \[36\]; sama untuk semua level agar waktu pembuatan indeks sebanding                                                                |
| effective_cache_size            | 4 GB                                                | Estimasi cache yang tersedia bagi planner, sekitar setengah memori                                                                                                                    |
| max_parallel_workers_per_gather | Bawaan (2)                                          | Dipertahankan bawaan agar eksekusi paralel tidak diubah; nilai efektif dikonfirmasi dengan SHOW pada G0, dan perubahan sesudah G3 dicatat sebagai penyimpangan protokol (Subbab 3.6). |
| random_page_cost                | Bawaan (4,0)                                        | Parameter planner; sensitivitasnya dibahas sebagai keterbatasan (Subbab 3.8)                                                                                                          |
| jit                             | off                                                 | Menghindari diskontinuitas akibat kompilasi yang dipicu oleh ambang biaya yang berubah antarlevel indeks                                                                              |
| io_method, io_workers           | Bawaan PostgreSQL 18: worker, 3 \[36\]              | io_uring bergantung pada Linux sehingga tidak tersedia di Windows                                                                                                                     |
| effective_io_concurrency        | Bawaan PostgreSQL 18                                | Nilai diverifikasi dengan SHOW pada G0                                                                                                                                                |
| autovacuum                      | off selama G4                                       | Beban kerja hanya-baca; statistik diperbarui manual (Lampiran A, A3)                                                                                                                  |
| statement_timeout               | 60 menit                                            | Batas eksekusi; pembatalan dicatat sebagai data tersensor                                                                                                                             |
| track_io_timing                 | off pada eksekusi waktu; on pada satu eksekusi plan | Pengukuran waktu I/O hanya tersedia bila diaktifkan \[9\]                                                                                                                             |

# 3.4.4 Instrumen Ukur

Tabel 3.12 Instrumen dan Indikator yang Diukur

| **Indikator**               | **Instrumen**                                                                                       | **Keterangan**                                                                                                                                                |
| --------------------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Execution time              | EXPLAIN (ANALYZE, BUFFERS, TIMING OFF)                                                              | Waktu seluruh pernyataan tetap diukur walau pengukuran per simpul dimatikan \[9\]; hasil tidak dikirim ke klien sehingga waktu transmisi tidak termasuk \[9\] |
| Planning time               | Bidang Planning Time pada keluaran yang sama                                                        | Ringkasan disertakan secara bawaan bersama ANALYZE \[9\]                                                                                                      |
| Execution plan              | EXPLAIN (ANALYZE, BUFFERS, SETTINGS, FORMAT JSON) pada satu eksekusi terpisah dengan timing menyala | Pengukuran waktu per simpul dapat menambah beban pembacaan jam sistem \[9\], \[27\], sehingga tidak dipakai untuk waktu utama                                 |
| Buffer statistics           | Opsi BUFFERS                                                                                        | PostgreSQL 18 menyertakannya bersama ANALYZE secara bawaan \[9\]; tetap ditulis eksplisit pada skrip                                                          |
| Ukuran indeks               | pg_relation_size, pg_indexes_size \[29\]                                                            | Dilaporkan per level dan skala (Lampiran B)                                                                                                                   |
| Waktu pembuatan indeks      | \\timing pada psql                                                                                  | Per berkas B1 dan B2 untuk setiap skala                                                                                                                       |
| Integritas dan kardinalitas | Lampiran A, berkas A3                                                                               | Subbab 3.3                                                                                                                                                    |
| Kesetaraan hasil            | EXCEPT ALL dua arah                                                                                 | Lampiran C                                                                                                                                                    |
| Kondisi termal              | Alat pemantau suhu dan frekuensi                                                                    | Subbab 3.4.5                                                                                                                                                  |

# 3.4.5 Kontrol Lingkungan

Tabel 3.13 Variabel Kontrol dan Cara Pengendaliannya

| **Variabel**             | **Nilai dan cara kontrol**                                                                                                                                 |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Versi DBMS               | PostgreSQL 18.6, tidak diperbarui selama eksperimen                                                                                                        |
| Data dan parameter query | Hash berkas data dan satu set parameter validasi (Subbab 3.3)                                                                                              |
| Statistik tabel          | VACUUM (ANALYZE) setelah pemuatan dan setiap pergantian level indeks (Subbab 3.6)                                                                          |
| Konfigurasi server       | Tabel 3.11, dikunci pada G3                                                                                                                                |
| Kondisi cache            | Warm cache dengan satu eksekusi warm-up; aturan restart layanan antarlevel dan antarskala (Subbab 3.6)                                                     |
| Konkurensi               | Satu sesi; tidak ada koneksi lain                                                                                                                          |
| Daya dan OS              | Adaptor AC terpasang; paket daya performa tinggi; mode tidur dan hibernasi nonaktif; pembaruan Windows ditunda selama G4                                   |
| Proses latar             | Aplikasi lain ditutup; pengecualian pemindaian antivirus pada direktori data dicatat sebagai perlakuan                                                     |
| Termal                   | Laptop pada permukaan datar dengan ventilasi baik; suhu dan frekuensi CPU dipantau; eksekusi dengan indikasi throttling diulang (kriteria pada Subbab 3.6) |
| Ruang disk               | Ruang kosong minimum ditetapkan sebelum G0, karena SF10 melebihi memori dan menambah ukuran indeks                                                         |

# 3.4.6 Struktur Repositori

Gambar 3.5 Struktur Repository

Gambar 3.5 merupakan struktur repository yang akan digunakan. Repositori memuat skrip, manifest _hash_, dan data mentah, serta tautannya dicantumkan pada naskah akhir. Platfom penyimpanan adalah Github.

# 3.5 Kerangka dan Arsitektur Eksperimen

Subbab ini menguraikan kerangka eksperimen yang diusulkan beserta rasionalnya. Kerangka ini bukan algoritma optimasi, sistem rekomendasi, atau kerangka keputusan baru. Kontribusinya berupa rancangan perlakuan dan arsitektur eksekusi yang terkontrol, sehingga pengaruh _rewriting_, _indexing_, dan interaksinya dapat diamati secara terpisah dan direplikasi.

# 3.5.1 Arsitektur Kerangka

Kerangka terdiri atas enam komponen yang dihubungkan secara berurutan (Gambar 3.6). Tiap komponen diikat oleh gerbang prosedur (Subbab 3.6).

1. Data: dbgen 3.0.1 menghasilkan data sintetis, dimuat ke satu basis data per skala (SF1 dan SF10); Subbab 3.3, G0.
2. Pembentuk level indeks: membuat himpunan indeks secara kumulatif I0 → I1 → I2 pada basis data yang sama (Lampiran B), dan mengukur ukuran serta waktu pembuatan indeks.
3. Bentuk SQL: pasangan O dan R untuk Q2, Q17, dan Q20 (Lampiran C).
4. Pemeriksa ekuivalensi: membandingkan hasil O dan R sebelum R diizinkan masuk ke eksperimen (G1).
5. Pelaksana: menjalankan setiap kondisi menurut protokol dan lingkungan terkunci (Subbab 3.4 dan 3.6; G3 dan G4).
6. Penyimpan data mentah: menyimpan keluaran EXPLAIN, ukuran indeks, waktu pembuatan indeks, dan _hash_ (repositori; Subbab 3.4.6), yang kemudian dianalisis (Subbab 3.7; G5).

Pemisahan ini disengaja. Level indeks dibentuk di tingkat basis data, bentuk SQL dibekukan sebagai berkas, dan pelaksana hanya mengeksekusi pasangan (bentuk, level) tanpa mengubah keduanya, sehingga setiap perbedaan hasil dapat ditelusuri ke satu faktor.

Gambar 3.6 Arsitektur Kerangka Eksperimen

# 3.5.2 Rasional Teoritis

Rasional kerangka mengikuti relasi konseptual pada Subbab 2.4.4 yaitu bentuk SQL memengaruhi struktur _plan_, strategi _indexing_ memengaruhi metode akses pada _plan_, dan _plan_ bersama data menentukan _execution time_, _planning time_, dan _buffer statistics_. Arah pengaruh tidak diasumsikan. Kerangka dirancang agar tiap faktor dimanipulasi sendiri-sendiri. R mengubah apa yang diminta kepada _planner_, level indeks mengubah akses yang tersedia baginya, dan skala mengubah volume data. Rancangan faktorial penuh (Subbab 3.2.2) memungkinkan interaksi antar-faktor diperoleh.

Tiga prinsip menjaga kerangka tetap objektif:

1. A priori dan mekanis. Himpunan indeks dan bentuk R ditetapkan dengan aturan eksplisit dan dikunci sebelum pilot, sehingga kondisi tidak dipilih karena hasilnya.
2. Representatif tetapi minimal. Indeks hanya menyasar atribut korelasi, filter, dan _foreign_ _key_ pada Tabel 2.2, dan R hanya mengubah bentuk tanpa penalaan manual.
3. Isolasi. Setiap perbandingan indikator turunan hanya berbeda pada satu faktor (Tabel 3.6).

# 3.5.3 Rancangan Level Indeks

Level I0 hanya berisi indeks _primary key_ (8 indeks). Level I1 dan I2 dibentuk menurut aturan berikut: hanya tabel yang diakses ketiga _query_; kolom FK atau korelasi untuk I1; kolom yang sudah menjadi kolom awal indeks I0 tidak diindeks lagi; dan I2 berupa indeks komposit atau _covering_ yang kunci kolomnya tidak identik dengan indeks yang sudah ada. Seluruh indeks bertipe B-tree.

I1 hanya memuat indeks B-tree pada kolom foreign key tunggal sehingga memenuhi batas pembuatan struktur bantu dalam Klausa 1.5.7 spesifikasi TPC-H. Sebaliknya, indeks tambahan pada I2 berada di luar batas tersebut. Pelanggaran terjadi karena beberapa indeks menggunakan kolom yang bukan _primary key_, _foreign key_, atau bertipe tanggal sebagai kolom kunci, menggabungkan kelompok kolom yang berbeda dalam satu instruksi pembuatan indeks, serta menyertakan kolom tambahan melalui INCLUDE yang tidak termasuk kolom yang diizinkan untuk dimaterialisasi. Oleh karena itu, I2 diperlakukan sebagai konfigurasi indeks eksperimental di luar batas indeks TPC-H. Hasil pengujian pada konfigurasi tersebut dilaporkan sebagai evaluasi beban kerja turunan TPC-H, bukan sebagai hasil TPC-H resmi. Status beban kerja turunan TPC-H berlaku bagi seluruh hasil penelitian, bukan hanya pada I2, karena bentuk R juga melampaui modifikasi minor _query_.

Tabel 3.14 Indeks Tambahan per Level

| **Indeks**               | **Level** | **Kolom**                                                                         | **Query**    | **Rasional**                                                                               |
| ------------------------ | --------- | --------------------------------------------------------------------------------- | ------------ | ------------------------------------------------------------------------------------------ |
| region                   | I0        | r_regionkey                                                                       | Q2, Q17, Q20 | PK                                                                                         |
| nation                   | I0        | n_nationkey                                                                       | Q2, Q17, Q20 | PK                                                                                         |
| part                     | I0        | p_partkey                                                                         | Q2, Q17, Q20 | PK                                                                                         |
| supplier                 | I0        | s_suppkey                                                                         | Q2, Q17, Q20 | PK                                                                                         |
| partsupp                 | I0        | ps_partkey, ps_suppkey                                                            | Q2, Q17, Q20 | PK gabungan                                                                                |
| customer                 | I0        | c_custkey                                                                         | Q2, Q17, Q20 | PK                                                                                         |
| orders                   | I0        | o_orderkey                                                                        | Q2, Q17, Q20 | PK                                                                                         |
| lineitem                 | I0        | l_orderkey, l_linenumber                                                          | Q2, Q17, Q20 | PK gabungan                                                                                |
| ix1_nation_regionkey     | I1        | nation (n_regionkey)                                                              | Q2           | FK; join nation–region                                                                     |
| ix1_supplier_nationkey   | I1        | supplier (s_nationkey)                                                            | Q2, Q20      | FK; join supplier–nation                                                                   |
| ix1_partsupp_suppkey     | I1        | partsupp (ps_suppkey)                                                             | Q2, Q20      | FK; bukan kolom awal PK partsupp                                                           |
| ix1_lineitem_partkey     | I1        | lineitem (l_partkey)                                                              | Q17, Q20     | FK dan kolom korelasi                                                                      |
| ix1_lineitem_suppkey     | I1        | lineitem (l_suppkey)                                                              | Q20          | FK dan kolom korelasi                                                                      |
| ix2_lineitem_ps_cover    | I2        | lineitem (l_partkey, l_suppkey, l_shipdate) INCLUDE (l_quantity, l_extendedprice) | Q17, Q20     | Kesamaan dan rentang pada subquery serta kolom agregat                                     |
| ix2_part_brand_container | I2        | part (p_brand, p_container) INCLUDE (p_partkey)                                   | Q17          | Filter query luar                                                                          |
| ix2_part_size            | I2        | part (p_size) INCLUDE (p_partkey, p_type, p_mfgr)                                 | Q2           | Filter ukuran; p_type disertakan karena LIKE berawalan wildcard tidak memakai B-tree       |
| ix2_part_name_prefix     | I2        | part (p_name varchar_pattern_ops) INCLUDE (p_partkey)                             | Q20          | LIKE berawalan; operator class pola dipertahankan agar indeks tidak bergantung pada kolasi |
| ix2_partsupp_cover       | I2        | partsupp (ps_partkey) INCLUDE (ps_suppkey, ps_supplycost, ps_availqty)            | Q2, Q20      | Kolom subquery; kunci tidak identik dengan PK                                              |

Total indeks: I0 = 8, I1 = 13, I2 = 18. Tumpang tindih awalan antara ix1_lineitem_partkey dan ix2_lineitem_ps_cover, serta antara PK partsupp dan ix2_partsupp_cover, merupakan konsekuensi level kumulatif. Keduanya disengaja dan dilaporkan, bersama ukuran seluruh indeks.

# 3.5.4 Rancangan Bentuk R

R adalah _decorrelation_ mekanis: subquery skalar berkorelasi dengan agregat diganti dengan tabel turunan (_derived table_) yang dikelompokkan menurut atribut korelasi, lalu di-JOIN-kan ke _query_ luar. Pola ini dibahas pada penelitian tentang penghilangan korelasi dengan GROUP BY dan JOIN \[11\] dan pada mekanisme _decorrelation_ di dalam _optimizer_ \[6\], \[30\]. Penelitian ini menguji penulisan eksplisit pada tingkat SQL, bukan mekanisme _optimizer_ itu. Karena menulis ulang struktur _query_, R melampaui modifikasi minor yang dibolehkan spesifikasi \[17\].

Beberapa keputusan rancangan R:

1. Tabel turunan, bukan CTE. CTE dapat di-_inline_ atau dimaterialisasi tergantung jumlah rujukan dan opsi \[24\], yang menambah satu sumber variasi.
2. Tanpa penyaringan di dalam tabel turunan. Predikat tidak disalin ke dalam tabel turunan agar R tetap berupa perubahan bentuk, bukan penalaan manual. Varian dengan penyaringan tidak termasuk 36 kondisi.
3. Perbaikan tidak diasumsikan. Tabel turunan pada R dapat mengagregasi seluruh tabel. Dampaknya terhadap _execution time_ diukur, bukan diandaikan.

Tabel 3.15 Rancangan Bentuk R per Query

| **Query** | **Subquery berkorelasi**                                  | **Transformasi pada R**                                                                                                          | **Titik rawan (Tabel 2.4)**                                 |
| --------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| Q2        | MIN(ps_supplycost) berkorelasi pada p_partkey             | Tabel turunan MIN per ps_partkey (wilayah target), di-JOIN pada kunci dan biaya                                                  | Biaya minimum seri tetap terbawa; pembatasan 100 baris sama |
| Q17       | AVG(l_quantity) berkorelasi pada l_partkey                | Tabel turunan 0,2 × AVG per l_partkey, di-JOIN pada p_partkey                                                                    | Satu baris per kunci agar tidak menggandakan                |
| Q20       | SUM(l_quantity) berkorelasi pada (ps_partkey, ps_suppkey) | Tabel turunan 0,5 × SUM per pasangan pada rentang tanggal; kedua IN terluar tidak berkorelasi dan dipertahankan sebagai semijoin | Perubahan IN menjadi JOIN biasa menggandakan pemasok        |

# 3.5.5 Kriteria Kesetaraan Hasil

R sah hanya bila memenuhi seluruh kriteria berikut pada setiap set parameter yang diuji:

1. Jumlah baris O dan R sama.
2. Selisih EXCEPT ALL bernilai nol pada kedua arah.
3. Nama dan tipe kolom sama.
4. Urutan baris sama pada Q2 dan Q20, yang memiliki ORDER BY.
5. Nilai NUMERIC dibandingkan secara eksak.
6. Keluaran O dan R pada parameter validasi cocok dengan keluaran validasi spesifikasi menurut aturan presisi klausa 2.1.3.5 \[17\].

Kegagalan pada satu kriteria membatalkan R untuk _query_ tersebut sampai direvisi, dan revisi mengulang seluruh pemeriksaan. Prosedur tiga lapisnya diuraikan pada Subbab 3.6, dan perubahan bentuk R sesudah G2 dicatat sebagai penyimpangan protokol.

# 3.6 Prosedur Eksperimen dan Validasi

# 3.6.1 Baseline, Perlakuan, dan Pembanding

_Baseline_ penelitian adalah bentuk O pada level I0. Perlakuan terdiri atas _rewriting_ (R), _indexing_ (I1 dan I2), dan gabungan keduanya. Setiap perlakuan dibandingkan dengan _baseline_ pada _query_ dan skala yang sama (R<sub>base</sub>) serta dengan kondisi yang hanya berbeda pada satu faktor (Tabel 3.6).

Tabel 3.16 Peran Kondisi Eksperimen

| **Peran**                | **Kondisi (bentuk–level)** | **Indikator utama**               |
| ------------------------ | -------------------------- | --------------------------------- |
| Baseline                 | O–I0                       | Pembanding semua kondisi lain     |
| Perlakuan rewriting saja | R–I0                       | R<sub>rw</sub>                    |
| Perlakuan indexing saja  | O–I1, O–I2                 | R<sub>ix</sub>                    |
| Perlakuan gabungan       | R–I1, R–I2                 | R<sub>base</sub>, C<sub>int</sub> |

# 3.6.2 Gerbang Prosedur

Prosedur dibagi menjadi enam gerbang berurutan. Eksperimen utama (G4) hanya dapat dilaksanakan setelah seluruh gerbang sebelumnya, yaitu G0 sampai G3, dinyatakan lulus. Perubahan terhadap himpunan indeks, bentuk R, atau parameter _query_ setelah G2 dinyatakan lulus dicatat sebagai penyimpangan protokol. Perubahan terhadap konfigurasi server dan parameter prosedural setelah G3 dinyatakan lulus juga dicatat sebagai penyimpangan protokol (Subbab 3.6.7).

Gambar 3.7 Alur Gerbang Prosedur Eksperimen

Tabel 3.17 Kriteria Lulus per Gerbang

| **Gerbang**                      | **Kriteria lulus**                                                                                                                                                                                                                                                                                                                                                                                   | **Yang dikunci**                                               |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| G0 Lingkungan dan data siap      | PostgreSQL 18.6 berjalan (diverifikasi SELECT version()) dengan konfigurasi Tabel 3.11 dan hasil SHOW ALL tersimpan; basis data UTF8 berkolasi C; jumlah baris sesuai Tabel 2.3; 10 FK; I0 = 8 indeks (Lampiran A, A3); hash berkas data tersimpan; versi alat tercatat; ruang disk kosong ≥ X GB (X dihitung dari ukuran basis data SF10, ukuran indeks I2, berkas dbgen, dan margin; Subbab 3.4.5) | –                                                              |
| G1 Ekuivalensi SQL lulus         | Tiga lapis validasi lulus untuk Q2, Q17, dan Q20 (Subbab 3.6.3)                                                                                                                                                                                                                                                                                                                                      | R sementara                                                    |
| G2 Desain indeks dikunci         | Lampiran B diuji pada basis data mini atau SF1: jumlah indeks 13 dan 18, kueri kunci identik nol baris, B3 mengembalikan 8 indeks; himpunan indeks (Tabel 3.14) dan teks R dibekukan                                                                                                                                                                                                                 | Himpunan indeks, bentuk R, parameter query                     |
| G3 Pilot lulus, protokol dikunci | Seluruh kriteria pilot terpenuhi (Subbab 3.6.6)                                                                                                                                                                                                                                                                                                                                                      | Tabel 3.18, δ<sub>s</sub>, konfigurasi server, urutan eksekusi |
| G4 Eksperimen utama              | Seluruh 36 kondisi eksperimen utama memiliki status akhir (selesai atau tersensor); data mentah dan log lingkungan tersimpan serta memiliki hash; pemeriksaan ulang I0 telah dilaksanakan sesuai protokol; dan seluruh penyimpangan protokol tercatat.                                                                                                                                               | Data mentah                                                    |
| G5 Analisis                      | Tabel hasil dibangkitkan ulang dari data mentah dengan skrip; klasifikasi dan analisis penjelas selesai (Subbab 3.7)                                                                                                                                                                                                                                                                                 | –                                                              |

# 3.6.3 Validasi Ekuivalensi SQL

Validasi memakai tiga lapis dan selesai sebelum pilot. Kriteria kesetaraan mengikuti Subbab 3.5.5.

Lapis 1, kasus batas pada data mini. Satu basis data kecil terpisah memuat data buatan yang wajib mencakup: biaya minimum yang seri (Q2); part tanpa pemasok di wilayah target (Q2); part tanpa lineitem (Q17); pasangan partsupp tanpa lineitem pada rentang tanggal (Q20); pemasok yang lolos melalui lebih dari satu pasangan partsupp (Q20); dan hasil kosong. Basis data ini tersimpan pada repositori.

Lapis 2, pembandingan O dan R. Keluaran O dan R dibandingkan menggunakan EXCEPT ALL dua arah (Lampiran C, C4) dengan menggunakan nilai parameter validasi TPC-H 3.0.1 pada SF1 dengan konfigurasi I0. Pembandingan dilakukan untuk memastikan bahwa kedua bentuk _query_ menghasilkan _multiset_ keluaran yang sama, termasuk jumlah kemunculan setiap baris. Kasus-kasus batas yang tidak selalu terwakili oleh data TPC-H diuji secara terpisah menggunakan basis data mini pada lapis pertama. Pada SF10, pembandingan O dan R menggunakan EXCEPT ALL dua arah dilakukan apabila kedua bentuk _query_ selesai dieksekusi. Apabila salah satu bentuk _query_ tersensor, pembandingan empiris pada SF10 tidak dapat dilakukan. Dalam kondisi tersebut, kesetaraan semantik didukung oleh hasil validasi pada data mini dan SF1, dengan asumsi bahwa kesetaraan semantik tidak bergantung pada skala data. Kondisi yang tidak dapat dibandingkan secara langsung pada SF10 dicatat sebagai keterbatasan validasi.

Lapis 3, pencocokan dengan keluaran validasi. Keluaran O dan R pada parameter validasi dicocokkan dengan keluaran validasi spesifikasi TPC-H menggunakan aturan presisi pada klausa 2.1.3.5 \[17\]. Pencocokan ini dilakukan pada SF1, yaitu skala yang memiliki keluaran validasi acuan dalam spesifikasi. Pembandingan O dan R menggunakan EXCEPT ALL dua arah pada lapis kedua tetap dilakukan secara eksak.

Bila satu lapis gagal, R untuk _query_ itu direvisi dan seluruh lapis diulang sebelum G2.

# 3.6.4 Protokol per Kondisi

Setiap kondisi dijalankan menurut Tabel 3.18. Jumlah eksekusi terukur n bergantung pada durasi _warm-up_: n = 5 bila ≤ 10 menit, n = 3 bila lebih dari 10 menit tetapi di bawah τ, dan bila _warm-up_ mencapai τ (nilai statement_timeout; nilai awal 60 menit) kondisi dinyatakan tersensor, dengan _warm-up_ itu sebagai satu-satunya observasi (T ≥ τ). Eksekusi _plan_ dilakukan sesudah semua eksekusi terukur agar tidak memengaruhi kondisi _cache_ pengukuran.

Tabel 3.18 Protokol per Kondisi

| **Langkah**               | **Tindakan**                                                                                                                                                                                                                                                                                                                                    | **Nilai**        |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| 1\. Persiapan blok        | Verifikasi level indeks (Lampiran B, B4); VACUUM (ANALYZE); restart layanan PostgreSQL pada awal setiap blok skala dan level                                                                                                                                                                                                                    | Per blok         |
| 2\. Warm-up               | Satu eksekusi EXPLAIN (ANALYZE, BUFFERS, TIMING OFF) dilakukan sebagai _warm-up_. Nilai _execution time_ dari tahap ini tidak digunakan dalam perhitungan median. Durasi _warm-up_ digunakan untuk menentukan jumlah eksekusi terukur atau status tersensor sesuai aturan yang ditetapkan.                                                      | 1 kali           |
| 3\. Eksekusi terukur      | n eksekusi berurutan dengan opsi yang sama; statement_timeout = τ aktif sejak warm-up hingga pengukuran yang relevan; catat Execution Time, Planning Time, dan buffer statistics                                                                                                                                                                | n = 5 atau 3     |
| 4\. Eksekusi plan         | Untuk kondisi yang selesai, dilakukan satu eksekusi EXPLAIN (ANALYZE, BUFFERS, SETTINGS, FORMAT JSON) dengan pengukuran waktu per simpul aktif dan track_io_timing aktif. Untuk kondisi yang tersensor, struktur plan diperoleh menggunakan EXPLAIN (SETTINGS, FORMAT JSON) tanpa ANALYZE, sehingga tidak menghasilkan pengukuran waktu aktual. | 1 kali           |
| 5\. Pencatatan lingkungan | Suhu dan frekuensi CPU dicatat selama tahap warm-up, eksekusi terukur, dan pengambilan plan. Waktu mulai dan selesai setiap tahap juga dicatat.                                                                                                                                                                                                 | Interval 1 detik |
| 6\. Pemeriksaan           | Periksa kriteria gagal teknis; bandingkan struktur plan eksekusi terukur dengan eksekusi plan dan tandai bila berbeda                                                                                                                                                                                                                           | Maks. 3 ulangan  |
| 7\. Penyimpanan           | Simpan keluaran mentah, hash SHA-256, dan status                                                                                                                                                                                                                                                                                                | Subbab 3.6.8     |

Kriteria gagal teknis:

1. Galat DBMS selain pembatalan oleh _statement_timeout._
2. Indikasi thermal throttling berdasarkan status sensor atau indikator throttling perangkat yang tersedia, dengan frekuensi dan suhu CPU digunakan sebagai informasi pendukung.
3. Pelanggaran kontrol lingkungan pada Tabel 3.13 (adaptor AC terlepas, pembaruan atau pemindaian berjalan, atau proses lain aktif).

Eksekusi yang gagal secara teknis tidak dimasukkan dalam perhitungan statistik dan dapat diulang sesuai batas pengulangan teknis yang ditetapkan. Seluruh percobaan, termasuk yang gagal, tetap disimpan dalam data mentah. Nilai ekstrem tanpa gangguan teknis tidak termasuk gagal teknis dan tetap dipakai.

Bila suatu eksekusi terukur mencapai τ setelah _warm-up_ selesai, kondisi dinyatakan tersensor dengan batas T ≥ τ, eksekusi berikutnya pada kondisi itu dihentikan, dan eksekusi yang sudah selesai tetap disimpan pada data mentah.

# 3.6.5 Urutan dan Pergantian Level

Skenario eksekusi pada G4 berurutan: SF1 lalu SF10. Pada setiap skala, urutannya adalah blok I0; B1 lalu blok I1; B2 lalu blok I2; B3, lalu cek ulang I0. Setiap blok terdiri atas enam kondisi (tiga _query_ × dua bentuk). Urutan keenam kondisi di dalam blok diacak dengan _seed_ tetap yang dicatat sebelum G3, sebagai pelaksanaan terbatas prinsip randomisasi \[32\] (Subbab 3.2.2). Cek ulang I0 memakai urutan yang sama dengan blok I0 awal. Waktu pembuatan indeks diukur satu kali pada setiap tahap penambahan indeks dan skala, tanpa pengulangan. Waktu yang dicatat merepresentasikan durasi proses penambahan indeks pada tahap tersebut dan dilaporkan apa adanya sebagai pengukuran tunggal. Setelah setiap pergantian level dijalankan VACUUM (ANALYZE) (Asumsi A3). Cache sistem operasi tidak dikosongkan; hal ini dicatat sebagai keterbatasan.

Pada cek ulang I0, enam kondisi I0 per skala dijalankan kembali dengan protokol yang sama. Kondisi yang tersensor pada eksekusi pertama tidak dicek ulang. Bila rasio T<sub>ulang</sub>/T<sub>awal</sub> berada di luar pita variasi yang ditetapkan untuk skala terkait (Subbab 3.7.4), hasil pada skala tersebut diberi catatan "pergeseran kondisi". Pemeriksaan ini digunakan untuk mendeteksi perubahan kondisi eksperimen selama pelaksanaan, bukan untuk mengoreksi nilai pengukuran awal. Penyebabnya ditelusuri melalui log termal dan lingkungan. Blok diulang hanya bila penyebab teknis teridentifikasi dan memenuhi kriteria gagal teknis. Bila tidak ada penyebab, pergeseran dilaporkan dan blok tidak diulang, agar keputusan ulang tidak bergantung pada hasil.

# 3.6.6 Pilot

Pilot memvalidasi prosedur, bukan memilih kondisi. Pilot boleh menyetel parameter prosedural (jeda pendinginan antar blok, estimasi waktu, dan ruang disk), tetapi tidak boleh mengubah himpunan indeks, bentuk R, parameter _query_, atau memilih kondisi berdasarkan hasilnya. Seluruh data pilot tidak dimasukkan ke dalam analisis eksperimen utama. Setelah pilot selesai, basis data dikembalikan ke kondisi I0 melalui prosedur B3 sebelum G4 dimulai. Sebelum G3 dinyatakan lulus, _hash_ seluruh berkas SQL dan konfigurasi parameter yang digunakan harus dicatat dalam manifest repositori. Perubahan terhadap berkas SQL atau konfigurasi parameter setelah penguncian diperlakukan sebagai penyimpangan protokol dan mengharuskan validasi ulang sesuai Subbab 3.6.3.

Cakupan pilot meliputi seluruh 18 kondisi pada SF1, yaitu tiga _query_, dua bentuk SQL, dan tiga level indeks I0, I1, serta I2. Pada SF10, pilot mencakup enam kondisi pada level I2. Cakupan pilot SF10 yang terbatas tersebut menjadi batas keterwakilan data pilot dalam penetapan δ<sub>SF10</sub>. Pilot memakai _timeout_ 10 menit agar kondisi lambat tidak menghabiskan waktu. Kondisi yang melebihinya tersensor pada pilot dan tidak ikut menentukan δ<sub>s</sub>.

Kriteria lulus pilot:

1. Skrip berjalan dari awal sampai akhir tanpa intervensi manual.
2. Keluaran mentah tersimpan lengkap dan _hash_ cocok.
3. _Plan_ berformat JSON dapat dibaca untuk semua kondisi tidak tersensor, dan jalur tersensor teruji (mis. _timeout_ singkat pada pernyataan pg_sleep).
4. Pencatatan suhu dan frekuensi CPU berjalan.
5. Estimasi waktu G4 dan ruang disk memadai.
6. Pita variasi dapat ditetapkan: δ<sub>s</sub> adalah nilai tertinggi rentang relatif ρ (Subbab 3.7.2) pada kondisi pilot tidak tersensor dengan n = 5 di skala s, dibulatkan ke atas ke kelipatan 0,05, dari sekurang-kurangnya tiga kondisi per skala. Apabila kurang dari tiga kondisi pada suatu skala memenuhi kriteria tersebut, nilai δ<sub>s</sub> tidak ditetapkan dan gerbang G3 belum dapat dinyatakan lulus.

Bila setelah enam kondisi SF10 pada I2 kurang dari tiga kondisi tak tersensor dengan n = 5, pilot SF10 diperluas ke level I1 lalu I0 dengan urutan tetap (aturan ini ditetapkan sebelum pilot dan tidak bergantung pada hasil), sampai terkumpul sekurang-kurangnya tiga kondisi atau seluruh 18 kondisi telah dicoba. Bila tetap kurang dari tiga, δ<sub>SF10</sub> ditetapkan sama dengan nilai tertinggi dari δ<sub>SF1</sub> dan 0.20 dan dilaporkan sebagai keterbatasan. Cakupan awal pilot SF10 yang hanya pada I2 dapat meremehkan variasi kondisi yang didominasi I/O berurutan atau _spill_. Dampaknya dikurangi oleh penanda "variasi melebihi pita pilot" dan pemeriksaan ulang I0.

# 3.6.7 Penyimpangan Protokol

Penyimpangan protokol adalah perubahan sesudah penguncian pada: himpunan indeks, bentuk R, atau parameter _query_ (G2); serta konfigurasi server, versi DBMS, nilai protokol (n, τ, urutan), atau δ<sub>s</sub> (G3). Setiap penyimpangan dicatat pada log repositori dengan tanggal, butir yang diubah, alasan, dan kondisi yang terdampak. Kondisi yang terdampak diulang dari awal apabila penyimpangan menyebabkan hasil pengukuran tidak lagi mengikuti protokol yang telah ditetapkan. Apabila pengulangan tidak memungkinkan, kondisi tersebut diberi penanda dan dampaknya dijelaskan pada Bab IV. Perubahan tidak boleh didasarkan pada hasil pengukuran. Eksekusi gagal teknis yang diulang menurut Subbab 3.6.4 bukan penyimpangan.

# 3.6.8 Penyimpanan Data Mentah

Setiap percobaan eksekusi, termasuk eksekusi valid, gagal secara teknis, atau tersensor, menghasilkan berkas keluaran mentah yang diberi nama berdasarkan kode kondisi dan nomor percobaan (K##\_run_n). Setiap kondisi juga memiliki satu berkas plan serta log lingkungan yang terkait. Seluruh berkas dihitung _hash_ SHA-256-nya ke manifest, lalu di-_commit_ ke repositori (Subbab 3.4.6). Penguncian ditandai dengan _tag_ Git pada G3 dan G4. Berkas mentah tidak diubah, dan seluruh tabel hasil dibangkitkan dari berkas tersebut oleh skrip.

# 3.7 Analisis dan Evaluasi Data

# 3.7.1 Pendekatan Analisis

Analisis bersifat deskriptif dan komparatif, bukan inferensial. Keputusan ini didasarkan pada tujuan RM1–RM3 yang berfokus pada identifikasi kondisi ketika perubahan performa terjadi, pemilihan _query_ secara purposif (Subbab 3.3.2), serta jumlah pengulangan yang terbatas pada satu mesin dalam satu sesi. Dengan rancangan tersebut, hasil tidak dimaksudkan untuk mengestimasi karakteristik populasi query atau konfigurasi perangkat yang lebih luas.

_Effect size_ dinyatakan sebagai rasio _execution time_ antar-kondisi, yaitu ukuran efek relatif yang lazim dalam evaluasi performa \[37\]. Ketidakpastiannya dinyatakan sebagai rentang rasio konservatif (Subbab 3.7.3), bukan interval kepercayaan, \[37\]. Pemilihan ini mengikuti pendekatan deskriptif penelitian dan menghindari interpretasi inferensial dari jumlah pengulangan yang terbatas. Nilai wakil kondisi adalah median, bukan rata-rata, karena jumlah pengulangan kecil dan distribusi waktu tidak diasumsikan simetris. Rasio yang dihasilkan karenanya adalah rasio median. Rasio tidak dirata-ratakan lintas _query_, level, atau skala, dan tidak ada skor gabungan. Seluruh perhitungan dilakukan dengan skrip pada repositori dari data mentah (Subbab 3.4.6), sehingga tabel hasil dapat dibangkitkan ulang.

# 3.7.2 Ringkasan per Kondisi

Setiap kondisi (K01–K36) diringkas berdasarkan jumlah eksekusi terukur yang valid (n), median execution time (T), nilai minimum dan maksimum (T<sub>min</sub> dan T<sub>max</sub>), rentang relatif ρ **=** (T<sub>max -</sub> T<sub>min</sub>)/T, median _planning time_, serta status akhir (selesai atau tersensor). Untuk kondisi yang tersensor, nilai median dan rentang relatif tidak dihitung. Rentang relatif tidak terdefinisi untuk kondisi tersensor karena hanya memiliki satu eksekusi.

# 3.7.3 Indikator Turunan dan Skala Logaritmik

R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>, C<sub>int</sub>, dan C<sub>sf</sub> dihitung dari median T menurut Tabel 2.8, pada pasangan kondisi pada Tabel 3.6. Rasio bersifat multiplikatif: rasio 2 dan 0,5 sama besar tetapi berlawanan arah. Hasil karenanya ditabulasikan sebagai rasio dan log₂ rasio, dan digambarkan pada sumbu logaritmik. Interpretasi tanda dan besarnya log<sub>2</sub> r mengikuti orientasi pembilang dan penyebut pada definisi masing-masing indikator dalam Tabel 2.8. Nilai nol menunjukkan _execution time_ kedua kondisi sama, sedangkan nilai positif dan negatif menunjukkan arah perubahan sesuai orientasi rasio yang digunakan.

Untuk rasio r = T<sub>a</sub> / T<sub>b</sub>, rentang rasio konservatif adalah \[T<sub>a,min</sub> / T<sub>b,max</sub>; T<sub>a,max</sub> / T<sub>b,min</sub>\]. Rentang ini memuat nilai terkecil dan terbesar yang mungkin dari eksekusi terukur kedua kondisi tanpa asumsi distribusi. Untuk rasio atas rasio (C<sub>int</sub> dan C<sub>sf</sub>), rentang dihitung dengan aritmetika interval pada rentang rasio penyusunnya.

# 3.7.4 Pita Variasi dan Klasifikasi Perubahan

1. Pita variasi

Untuk setiap skala s, δ<sub>s</sub> ditetapkan sebagai nilai tertinggi rentang relatif ρ dari kondisi pilot yang tidak tersensor dan memiliki lima eksekusi terukur valid (n=5), dengan jumlah minimal tiga kondisi pada skala tersebut. Nilai tersebut dibulatkan ke atas ke kelipatan 0,05 sesuai prosedur pada Subbab 3.6.6. Nilai tertinggi dipilih, bukan rata-rata, agar klasifikasi bersifat konservatif. δ dipisahkan per skala karena SF10 melebihi memori (A6, Tabel 3.2) sehingga variasinya dapat berbeda. δ ditetapkan pada G3 dan tidak diubah setelah melihat hasil G4.

2. Ambang.

Perubahan dinyatakan melampaui variasi pengukuran bila rasio median R memenuhi r > θ atau r < 1/θ. Klasifikasi ini merupakan aturan operasional untuk membandingkan hasil eksperimen dengan variasi yang diamati selama pilot, bukan pengujian signifikansi statistik. Ambang θ untuk setiap indikator adalah hasil kali (1 + δ<sub>s</sub>) dari setiap rasio median penyusunnya (Tabel 3.19).

Tabel 3.19 Ambang θ per Indikator

| **Indikator**                                                             | **Rasio median penyusun**              | **θ**                                            |
| ------------------------------------------------------------------------- | -------------------------------------- | ------------------------------------------------ |
| R<sub>rw</sub>, R<sub>ix</sub>, R<sub>base</sub>                          | Satu rasio pada skala s                | 1 + δ<sub>s</sub>                                |
| C<sub>int</sub>                                                           | Dua rasio pada skala s                 | (1 + δ<sub>s</sub>)²                             |
| C<sub>sf</sub> atas R<sub>rw</sub>, R<sub>ix</sub>, atau R<sub>base</sub> | Satu rasio pada SF1 dan satu pada SF10 | (1 + δ<sub>SF1</sub>)(1 + δ<sub>SF10</sub>)      |
| C<sub>sf</sub> atas C<sub>int</sub>                                       | Dua rasio pada SF1 dan dua pada SF10   | \[(1 + δ<sub>SF1</sub>)(1 + δ<sub>SF10</sub>)\]² |

Setiap indikator diklasifikasikan ke salah satu dari empat kelas:

1. Melampaui, lebih cepat (perbaikan): r > θ.
2. Melampaui, lebih lambat (penurunan): r < 1/θ.
3. Dalam ambang variasi pilot: 1/θ ≤ r ≤ θ. Kelas ini dilaporkan sebagai 'tidak melampaui ambang variasi pilot' dan tidak ditafsirkan sebagai bukti bahwa tidak terdapat efek.
4. Tak dapat ditentukan: data tersensor yang batasnya tidak menentukan kelas (Subbab 3.7.5).

Untuk C<sub>int</sub> dan C<sub>sf</sub>, kelas 1 dan 2 dibaca sebagai efek relatif yang berubah (arah menurut Tabel 2.8). Tiga penanda kehati-hatian dicatat pada hasil: (a) "kurang tegas" bila rentang rasio konservatif memuat 1 walau R melampaui θ; (b) "variasi melebihi pita pilot" bila ρ kondisi penyusun lebih besar daripada δ<sub>s</sub>; (c) "pergeseran kondisi" bila pemeriksaan pergeseran di bawah gagal. Gambar 3.8 meringkas aturan ini.

Pemeriksaan pergeseran memakai cek ulang I0 pada akhir G4: untuk 12 kondisi I0 (K01, K04, K07, K10, K13, K16, K19, K22, K25, K28, K31, K34) dihitung T<sub>ulang</sub> / T<sub>awal</sub>. Bila rasio berada di luar \[1/(1 + δ<sub>s</sub>), 1 + δ<sub>s</sub>\], hasil pada skala tersebut diberi catatan, penyebabnya ditelusuri melalui log termal dan lingkungan (Subbab 3.4.5), dan pengulangan diputuskan menurut Subbab 3.6.

Gambar 3.8 Aturan Klasifikasi Perubahan Execution Time

Tabel 3.20 Kerangka Tabel Hasil Rasio dan Klasifikasi

| **Indikator**                        | **Pembilang / penyebut**                   | **R** | **log₂ R** | **Rentang rasio konservatif** | **θ** | **Kelas** |
| ------------------------------------ | ------------------------------------------ | ----- | ---------- | ----------------------------- | ----- | --------- |
| R<sub>rw</sub> (Q2, I0, SF1)         | K01 / K04                                  | \-    | \-         | \-                            | \-    | \-        |
| R<sub>ix</sub> (Q2, O, I1, SF1)      | K01 / K02                                  | \-    | \-         | \-                            | \-    | \-        |
| R<sub>base</sub> (Q2, R, I1, SF1)    | K01 / K05                                  | \-    | \-         | \-                            | \-    | \-        |
| C<sub>int</sub> (Q2, I1, SF1)        | (K01/K04)·(K05/K02)⁻¹                      | \-    | \-         | \-                            | \-    | \-        |
| C<sub>sf</sub><sup>rw</sup> (Q2, I0) | R<sub>rw</sub>(SF10) / R<sub>rw</sub>(SF1) | \-    | \-         | \-                            | \-    | \-        |

Contoh perhitungan (angka ilustratif). Misalkan δ<sub>SF1</sub> = 0,10 sehingga θ = 1,10 dan 1/θ ≈ 0,909. Kondisi A: T_O = 100 detik (rentang 95–105), T_R = 40 detik (rentang 38–43). R<sub>rw</sub> = 2,5; log₂ R<sub>rw</sub> ≈ 1,32; rentang rasio konservatif = \[95/43; 105/38\] ≈ \[2,21; 2,76\]. Karena R<sub>rw</sub> > θ dan rentang tidak memuat 1, kelasnya "melampaui, lebih cepat". Kondisi B: T_O = 100 (95–105), T_R = 95 (80–110). R<sub>rw</sub> = 1,05 dan 1/θ ≤ 1,05 ≤ θ sehingga kelasnya "dalam ambang variasi pilot", tidak ditafsirkan sebagai ketiadaan efek. Contoh C<sub>int</sub>: bila R<sub>rw</sub>(I0) = 2,5 dan R<sub>rw</sub>(I1) = 1,25 maka C<sub>int</sub> = 0,5 (log₂ = −1); karena θ = (1,10)² = 1,21 dan 1/θ ≈ 0,826, kelasnya "melampaui, bergeser ke arah R lebih lambat". θ = 1 + δ<sub>s</sub> adalah pilihan operasional yang dikalibrasi dari variasi pilot, bukan hasil penurunan statistik.

# 3.7.5 Data Tersensor

Kondisi yang mencapai statement_timeout sebesar τ dilaporkan sebagai data tersensor dengan batas waktu T ≥ τ bukan sebagai nilai _execution_ _time_ yang terukur. Nilai τ digunakan sebagai batas bawah untuk membentuk rasio yang melibatkan kondisi tersebut. Rasio yang melibatkannya dilaporkan sebagai batas (Tabel 3.21). Klasifikasi dari sebuah batas hanya diberikan bila batas itu sendiri menentukan kelas: batas bawah R yang melebihi θ dilaporkan sebagai perbaikan (batas bawah), dan batas atas R di bawah 1/θ sebagai penurunan (batas atas). Selebihnya masuk kelas "tak dapat ditentukan". Rasio atas rasio dihitung menggunakan aritmetika interval berdasarkan batas yang tersedia. Apabila batas yang dihasilkan tidak cukup untuk menentukan rentang rasio yang terbatas, nilai rasio tersebut tidak dilaporkan dan diklasifikasikan sebagai tak dapat ditentukan. _Plan_ kondisi tersensor dicatat tanpa ANALYZE (Subbab 3.6) sehingga hanya menjelaskan struktur, bukan waktu.

Tabel 3.21 Penanganan Data Tersensor Pada Rasio r = T<sub>a</sub> / T<sub>b</sub>

| **Kasus**                             | **Hasil**                             |
| ------------------------------------- | ------------------------------------- |
| Pembilang tersensor, penyebut terukur | r ≥ τ / T<sub>b</sub> (batas bawah)   |
| Penyebut tersensor, pembilang terukur | r ≤ T<sub>a</sub> / τ (batas atas)    |
| Keduanya tersensor                    | r tidak dilaporkan; tak terbandingkan |

# 3.7.6 Plan dan Buffer

_Execution plan_, _planning time_, dan _buffer statistics_ dipakai untuk menjelaskan, bukan menguji, perubahan _execution time_. Untuk setiap pasangan pada Tabel 3.6, _plan_ kedua kondisi dibandingkan menurut fitur pada Tabel 2.7: struktur _subquery_ (SubPlan atau InitPlan menjadi _join_), metode akses (_Seq Scan_, _Index Scan_, _Index Only Scan_, _Bitmap Scan_; jumlah _index searches_), jenis _join_, keberadaan _node_ paralel, dan rasio estimasi terhadap aktual dengan memperhitungkan _loops_ \[9\], \[27\]. Aktivitas _buffer_ (_shared hit_ dan _read_, serta blok _temp_) dibandingkan sebagai rasio antar-pasangan. Perbandingan dilakukan pada semua pasangan, termasuk yang berada dalam variasi, agar perubahan _plan_ tanpa perubahan waktu juga terlihat. Bentuk _plan_ pada eksekusi waktu dibandingkan dengan eksekusi _plan_ dan ditandai bila berbeda (Subbab 3.6). Hubungan yang ditemukan dibaca sebagai asosiasi pada kondisi yang diuji, bukan bukti kausal, dan batasnya dibahas pada Subbab 3.8.

# 3.7.7 Analisis Manfaat dan Biaya Indeks

Biaya indeks mencakup ukuran total himpunan indeks, selisih ukuran terhadap I0, serta waktu pembuatan indeks. Ketiga ukuran tersebut dilaporkan per level dan skala. Selisih ukuran dan waktu pembuatan antar-level digunakan untuk menunjukkan biaya inkremental penambahan indeks. Manfaat dibaca dari kelas R<sub>ix</sub> dan R<sub>base</sub> pada level yang sama. Keduanya disandingkan pada satu tabel (Tabel 3.22) tanpa bobot dan tanpa penjumlahan. Pola yang dilaporkan: perbaikan beserta biayanya; penurunan; _trade-off_ lintas _query_ (perbaikan pada satu _query_ dan penurunan pada _query_ lain pada level dan skala yang sama); dan biaya tanpa perubahan melampaui variasi pada _query_ yang diuji. Hasil negatif, tidak konsisten, dan berupa _trade-off_ diperlakukan sebagai temuan yang sah. Biaya penulisan R tidak diukur, karena RM3 hanya mencakup biaya indeks.

Tabel 3.22 Kerangka Tabel Manfaat dan Biaya Indeks

| **Level** | **Skala** | **Ukuran total (MB)** | **Selisih thd I0 (MB)** | **Waktu pembuatan (detik)** | **R<sub>ix</sub> Q2** | **R<sub>ix</sub> Q17** | **R<sub>ix</sub> Q20** | **R<sub>base</sub> Q2** | **R<sub>base</sub> Q17** | **R<sub>base</sub> Q20** |
| --------- | --------- | --------------------- | ----------------------- | --------------------------- | --------------------- | ---------------------- | ---------------------- | ----------------------- | ------------------------ | ------------------------ |
| I1        | SF1       | —                     | —                       | —                           | — / —                 | — / —                  | — / —                  | — / —                   | — / —                    | — / —                    |
| I1        | SF10      | —                     | —                       | —                           | — / —                 | — / —                  | — / —                  | — / —                   | — / —                    | — / —                    |
| I2        | SF1       | —                     | —                       | —                           | — / —                 | — / —                  | — / —                  | — / —                   | — / —                    | — / —                    |
| I2        | SF10      | —                     | —                       | —                           | — / —                 | — / —                  | — / —                  | — / —                   | — / —                    | — / —                    |

# 3.8 Validitas, Reliabilitas, dan Ancaman terhadap Validitas

Subbab ini mengidentifikasi ancaman terhadap validitas hasil penelitian, menjelaskan dampaknya terhadap interpretasi temuan, dan menguraikan penanganan yang diterapkan dalam rancangan eksperimen.

# 3.8.1 Validitas Konstruk

Validitas konstruk menyangkut apakah indikator mengukur hal yang dimaksud.

Tabel 3.23 Ancaman Validitas Konstruk

| **Ancaman**                                                                                                     | **Dampak**                                             | **Penanganan**                                                                                                |
| --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| Execution time dari EXPLAIN ANALYZE tidak mencakup pengiriman hasil ke klien \[9\]                              | Bukan waktu end-to-end aplikasi                        | Dinyatakan sebagai batas; jumlah baris hasil Q2 dibatasi 100 dan Q17 satu baris, dan jumlah baris Q20 dicatat |
| Overhead pembacaan jam sistem pada pengukuran per simpul \[9\], \[27\]                                          | Waktu terlalu besar atau terdistorsi                   | Waktu utama memakai TIMING OFF; plan diambil pada eksekusi terpisah (Subbab 3.4.4)                            |
| Blok "read" belum tentu pembacaan fisik karena cache sistem operasi \[9\]                                       | Salah baca I/O                                         | Buffer statistics ditafsirkan sebagai aktivitas buffer PostgreSQL, bukan I/O fisik                            |
| R hanyalah satu dari banyak kemungkinan penulisan ulang                                                         | Kesimpulan tentang rewriting hanya untuk bentuk R ini  | R dinyatakan eksplisit dan dikunci (Lampiran C, Subbab 3.5.4); varian lain tidak diuji                        |
| Definisi "melampaui variasi pengukuran" bergantung pada pita δ<sub>s</sub> dari pilot (Subbab 3.7.4)            | Ambang terlalu longgar atau ketat                      | δ<sub>s</sub> memakai nilai tertinggi per skala dan dikunci pada G3; R mentah dilaporkan bersama kelasnya     |
| Rasio median, bukan rasio rata-rata seperti pada metode rujukan \[37\]                                          | Ukuran efek tidak sebanding langsung dengan studi lain | Dinyatakan eksplisit pada Subbab 3.7.1; angka tidak dibandingkan lintas studi                                 |
| Biaya indeks hanya ruang dan waktu pembuatan; beban tulis tidak dijalankan (fungsi refresh TPC-H tidak dipakai) | Biaya pemeliharaan indeks tidak terukur                | RM3 dibatasi pada biaya ruang dan waktu pembuatan                                                             |
| Waktu pembuatan indeks diukur satu kali per level dan skala                                                     | Variasinya tidak diketahui                             | Dilaporkan apa adanya, tidak dibandingkan dengan δ<sub>s</sub>, dan dilengkapi catatan lingkungan             |

# 3.8.2 Validitas Internal dan Bias

Validitas internal menyangkut apakah perbedaan hasil benar-benar berasal dari faktor yang dimanipulasi.

Tabel 3.24 Ancaman Validitas Internal dan Bias

| **Ancaman**                                                                                                     | **Dampak**                                            | **Penanganan**                                                                                                                         |
| --------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| Urutan tidak diacak penuh; eksekusi diblokir menurut skala dan level (Subbab 3.2.2)                             | Pergeseran lingkungan bercampur dengan level indeks   | Pengacakan terbatas di dalam blok dengan seed tetap \[32\]; cek ulang I0 dan penanda "pergeseran kondisi" (Subbab 3.7.4)               |
| Efek bawaan antarlevel: indeks dibuat kumulatif pada basis data yang sama                                       | Keadaan fisik setelah B3 mungkin berbeda dari I0 awal | Cek ulang I0 sebagai uji ulang; VACUUM (ANALYZE) setiap pergantian level                                                               |
| Kondisi cache: warm cache, cache sistem operasi tidak dikosongkan, SF10 melebihi memori                         | Hasil SF10 dipengaruhi tekanan memori                 | Restart layanan per blok dan satu warm-up (Subbab 3.6.4); C<sub>sf</sub> tidak dibaca sebagai pengaruh volume murni (A6)               |
| Thermal throttling dan proses latar Windows                                                                     | Bias dan variasi waktu                                | Kontrol pada Tabel 3.13, kriteria gagal teknis, log termal, dan ulangan maksimal tiga kali                                             |
| Statistik planner dan autovacuum                                                                                | Plan berubah antar-eksekusi                           | VACUUM (ANALYZE) manual dan autovacuum mati; struktur plan eksekusi waktu dibandingkan dengan eksekusi plan                            |
| Pita δ<sub>s</sub> diestimasi dari sedikit kondisi pilot dengan timeout 10 menit, sedangkan G4 memakai 60 menit | δ<sub>s</sub> mungkin tidak mewakili kondisi lambat   | δ<sub>s</sub> per skala dari kondisi tidak tersensor; penanda "variasi melebihi pita pilot"                                            |
| Bias seleksi: himpunan indeks atau bentuk R dipilih karena hasilnya                                             | Kondisi menguntungkan                                 | Aturan a priori (Subbab 3.5.3, 3.5.4), dikunci pada G2 sebelum pilot; penyimpangan dicatat (Subbab 3.6.7)                              |
| Bias konfirmasi pada klasifikasi dan penjelasan                                                                 | Penafsiran selektif                                   | Aturan klasifikasi ditetapkan sebelum data (Subbab 3.7.4); seluruh pasangan dianalisis, termasuk yang dalam variasi; hasil negatif sah |
| Kesetaraan SF10 bersandar pada SF1 bila O tersensor (Subbab 3.6.3)                                              | R belum terbukti setara pada SF10                     | Asumsi bahwa kesetaraan semantik tidak bergantung skala dicatat; kesetaraan diperiksa pada kondisi SF10 yang selesai                   |

# 3.8.3 Validitas Eksternal

Validitas eksternal menyangkut sejauh mana hasil berlaku di luar konfigurasi yang diuji

Tabel 3.25 Ancaman Validitas Eksternal

| **Ancaman**                                                                                              | **Batas generalisasi**                                                                      |
| -------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Satu DBMS dan versi (PostgreSQL 18.6) dengan fitur seri 18 seperti skip scan dan asynchronous I/O \[21\] | Tidak berlaku pada versi lain                                                               |
| Satu mesin: RAM 8 GB, Windows 10, metode I/O worker karena io_uring tidak tersedia \[36\]                | Waktu absolut tidak dipindahkan; rasio dapat berbeda pada perangkat keras atau OS lain      |
| Data sintetis TPC-H, tiga query, satu set parameter, dua skala (Subbab 3.3.2)                            | Tidak mewakili beban kerja lain                                                             |
| Parameter planner bawaan (misalnya random_page_cost 4,0 pada SSD) dan jit nonaktif                       | Pemilihan indeks oleh planner dapat berbeda pada konfigurasi lain; sensitivitas tidak diuji |
| Hanya B-tree; I2 berada di luar batas indeks TPC-H \[17\]                                                | Hasil berlaku untuk himpunan indeks ini sebagai beban kerja turunan TPC-H                   |
| Beban baca, satu sesi, warm cache (A2)                                                                   | Tidak mewakili multipengguna, cold start, atau beban tulis                                  |

# 3.8.4 Reliabilitas dan Reproduktibilitas

Reliabilitas pengukuran dijaga melalui pengulangan terukur per kondisi (n = 5 atau 3), median dan rentang sebagai ringkasan (Subbab 3.7.2), dan cek ulang I0 sebagai uji ulang terhadap 12 kondisi I0. Keterbatasannya: eksekusi dalam satu sesi tidak independen dan jumlah pengulangan kecil, sehingga tidak ada klaim statistik inferensial (Subbab 3.7.1).

Reproduktibilitas dijaga melalui: versi tetap (PostgreSQL 18.6, dbgen 3.0.1); _hash_ berkas data dan _seed_; DDL dan SQL pada Lampiran A, B, dan C; konfigurasi pada Tabel 3.11 beserta keluaran SHOW ALL; spesifikasi lingkungan pada Tabel 3.9 dan 3.10; skrip, data mentah, dan log penyimpangan pada repositori dengan _tag_ Git pada G3 dan G4 (Subbab 3.4.6 dan 3.6.8); dan tabel hasil yang dibangkitkan ulang dari data mentah. Rancangan ini menjawab dua kelemahan yang dilaporkan literatur, yaitu konfigurasi yang tidak terdokumentasi serta hasil yang tidak diperiksa kebenarannya \[33\], dan pelaporan yang tidak cukup rinci untuk replikasi \[34\]. Yang direplikasi adalah prosedur dan struktur hasil (rasio dan kelas), bukan waktu absolut, karena waktu absolut bergantung pada perangkat keras.

# 3.8.5 Keterbatasan

Selain ancaman di atas, tiga keterbatasan menentukan cara hasil dibaca. Pertama, analisis _plan_ dan _buffer_ menunjukkan asosiasi pada kondisi yang diuji, bukan bukti kausal. Kedua, biaya penulisan R dan biaya pemeliharaan indeks pada beban tulis tidak diukur, sehingga RM3 dijawab hanya untuk biaya ruang dan waktu pembuatan indeks. Ketiga, seluruh kesimpulan berlaku pada konfigurasi yang diuji.

# 3.9 Tahapan Penelitian

# 3.9.1 Tahapan

Tabel 3.26 Tahapan Penelitian

| **Tahap** | **Kegiatan**                             | **Keluaran**                               |
| --------- | ---------------------------------------- | ------------------------------------------ |
| 1         | Penelusuran literatur dan sintesis       | Tabel 2.10 terisi; Bab I–II final          |
| 2         | Penyusunan dan bimbingan Bab I–III       | Proposal tesis disetujui                   |
| 3         | G0 Lingkungan dan data siap              | Log G0, manifest hash                      |
| 4         | G1 Validasi ekuivalensi SQL              | Log validasi tiga lapis; status R          |
| 5         | G2 Penguncian desain indeks              | Himpunan indeks beku; tag Git G2           |
| 6         | G3 Pilot dan penguncian protokol         | δ<sub>s</sub> per skala; tag Git G3        |
| 7         | G4 Eksperimen utama (SF1 lalu SF10)      | Data mentah dan log lingkungan; tag Git G4 |
| 8         | G5 Analisis                              | Tabel rasio, kelas, dan penjelasan plan    |
| 9         | Penulisan Bab IV–V dan finalisasi naskah | Naskah tesis                               |
| 10        | Sidang dan revisi                        | Naskah revisi                              |

# 3.9.2 Estimasi Waktu Eksperimen Utama

Waktu G4 diperkirakan dari hasil pilot. Untuk satu kondisi tidak tersensor, waktu pengukuran adalah (1 + n) kali median _execution time_ ditambah satu eksekusi _plan_, dengan n = 5 atau 3 menurut Subbab 3.6.4. Kondisi tersensor memerlukan paling lama τ untuk _warm-up_ ditambah pengambilan _plan_ tanpa ANALYZE. Waktu pembuatan indeks, VACUUM (ANALYZE), dan _restart_ layanan ditambahkan pada setiap pergantian level (Subbab 3.6.5). Pemeriksaan ulang I0 menambah 12 kondisi. Batas atas teoretis per kondisi tidak tersensor dengan nilai awal protokol adalah 4τ, tetapi estimasi yang dipakai untuk penjadwalan diambil dari pilot ⚠ dan diperiksa pada kriteria pilot butir 5 (Subbab 3.6.6).

# DAFTAR PUSTAKA

\[1\] J. Kossmann, T. Papenbrock, dan F. Naumann, "Data dependencies for query optimization: a survey," _The VLDB Journal_, vol. 31, no. 1, hlm. 1–22, Jan 2022, doi: 10.1007/s00778-021-00676-3.

\[2\] V. Leis, A. Gubichev, A. Mirchev, P. Boncz, A. Kemper, dan T. Neumann, "How good are query optimizers, really?," _Proceedings of the VLDB Endowment_, vol. 9, no. 3, hlm. 204–215, Nov 2015, doi: 10.14778/2850583.2850594.

\[3\] A. Ramdhani dan S. Widodo, "COMPARATIVE ANALYSIS OF B-TREE AND HASH INDEXES FOR POSTGRESQL QUERY OPTIMIZATION," _JURTEKSI (jurnal Teknologi dan Sistem Informasi)_, vol. 12, no. 3, hlm. 461–468, Jun 2026, doi: 10.33330/jurteksi.v12i3.4653.

\[4\] S. Dharwada, H. Devrani, J. Haritsa, dan H. Doraiswamy, "Query Rewriting via LLMs," _Proceedings of Extending Database Technology (EDBT '26)_, vol. 1, Sep 2025, Diakses: 8 Oktober 2026. \[Daring\]. Tersedia pada: <http://arxiv.org/abs/2502.12918>

\[5\] A. Hamadou, A. Aziz Issaka Hassane, H. Naroua, A. Nasser Abdou Hama, A. Salame Salissou, dan I. Mouazamou Laoualy Chaharou, "A COMPARATIVE STUDY OF INDEXING STRATEGIES FOR BOOSTING POSTGRESQL QUERY PERFORMANCE," _Int. J. Adv. Res. (Indore)._, vol. 14, no. 05, hlm. 844–853, 2026, doi: 10.21474/IJAR01/23486.

\[6\] T. Neumann, "Improving Unnesting of Complex Queries," dalam _Lecture Notes in Informatics (LNI), Proceedings - Series of the Gesellschaft fur Informatik (GI)_, Gesellschaft fur Informatik (GI), 2025, hlm. 25–47. doi: 10.18420/BTW2025-01.

\[7\] N. Bruno, C. Galindo-Legaria, dan M. Joshi, "Query Decorrelation in the Fabric Data Warehouse," dalam _Companion of the 2025 International Conference on Management of Data_, New York, NY, USA: ACM, Jun 2025, hlm. 297–309. doi: 10.1145/3722212.3724448.

\[8\] V. Leis, A. Gubichev, A. Mirchev, P. Boncz, A. Kemper, dan T. Neumann, "Still Asking: How Good Are Query Optimizers, Really?," _Proceedings of the VLDB Endowment_, vol. 18, no. 12, hlm. 5531–5536, Agu 2025, doi: 10.14778/3750601.3760521.

\[9\] PostgreSQL, "EXPLAIN." Diakses: 9 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/sql-explain.html>

\[10\] L. Woltmann, J. Thiessat, C. Hartmann, D. Habich, dan W. Lehner, "FASTgres: Making Learned Query Optimizer Hinting Effective," _Proceedings of the VLDB Endowment_, vol. 16, no. 11, hlm. 3310–3322, Jul 2023, doi: 10.14778/3611479.3611528.

\[11\] C. Galindo-Legaria dan M. Joshi, "Orthogonal optimization of subqueries and aggregation," dalam _Proceedings of the 2001 ACM SIGMOD international conference on Management of data_, New York, NY, USA: ACM, Mei 2001, hlm. 571–581. doi: 10.1145/375663.375748.

\[12\] PostgreSQL, "Indexes." Diakses: 8 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/indexes.html>

\[13\] PostgreSQL, "Multicolumn Indexes." Diakses: 8 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/indexes-multicolumn.html>

\[14\] PostgreSQL, "Combining Multiple Indexes." Diakses: 8 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/indexes-bitmap-scans.html>

\[15\] PostgreSQL, "Index-Only Scans and Covering Indexes." Diakses: 8 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/indexes-index-only-scans.html>

\[16\] R. Schlosser, M. Weisgut, L. Hübscher, dan O. Nordemann, "Robust Index Selection for Stochastic Dynamic Workloads," _SN Comput. Sci._, vol. 4, no. 1, hlm. 59, Nov 2022, doi: 10.1007/s42979-022-01473-7.

\[17\] Transaction Processing Performance Council (TPC), "TPC-H Benchmark Specification, Version 3.0.1." Diakses: 5 November 2026. \[Daring\]. Tersedia pada: <https://www.tpc.org/TPC_Documents_Current_Versions/pdf/TPC-H_v3.0.1.pdf>

\[18\] Z. Li, H. Yuan, H. Wang, G. Cong, dan L. Bing, "LLM-R2 : A Large Language Model Enhanced Rule-Based Rewrite System for Boosting Query Efficiency," _Proceedings of the VLDB Endowment_, vol. 18, no. 1, hlm. 53–65, Sep 2024, doi: 10.14778/3696435.3696440.

\[19\] W. Zhou, C. Lin, X. Zhou, dan G. Li, "Breaking It Down: An In-Depth Study of Index Advisors," _Proceedings of the VLDB Endowment_, vol. 17, no. 10, hlm. 2405–2418, Jun 2024, doi: 10.14778/3675034.3675035.

\[20\] A. Agrawal, T. Wang, dan D. Shasha, "DBTuneSuite: An Extendible Experimental Suite to Test the Time Performance of Multi-layer Tuning Options on Database Management Systems," Jan 2026, \[Daring\]. Tersedia pada: <http://arxiv.org/abs/2601.20015>

\[21\] PostgreSQL, "PostgreSQL 18 Released!" Diakses: 16 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/about/news/postgresql-18-3142/>

\[22\] PostgreSQL, "Release 18.6." Diakses: 17 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/release-18-6.html>

\[23\] PostgreSQL, "Planner/Optimizer." Diakses: 16 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/planner-optimizer.html>

\[24\] PostgreSQL Source Code git master, "subselect.c." Diakses: 17 Oktober 2026. \[Daring\]. Tersedia pada: <https://doxygen.postgresql.org/subselect_8c_source.html>

\[25\] Alibaba Cloud, "Correlated subquery pull-up." Diakses: 16 Oktober 2026. \[Daring\]. Tersedia pada: <https://help.aliyun.com/en/polardb/polardb-for-postgresql/associated-subquery-pull-up>

\[26\] Tencent Cloud, "子查询上拉优化 (Subquery pull-up optimization)." Diakses: 16 Oktober 2026. \[Daring\]. Tersedia pada: <https://cloud.tencent.com/document/product/409/134631>

\[27\] PostgreSQL, "Using EXPLAIN." Diakses: 8 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/using-explain.html>

\[28\] T. Neumann, "A Formalization of Top-Down Unnesting," Jul 2026, \[Daring\]. Tersedia pada: <http://arxiv.org/abs/2412.04294>

\[29\] PostgreSQL, "Functions and Operators." Diakses: 17 Oktober 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/functions-admin.html>

\[30\] P. Fent, A. Birler, dan T. Neumann, "Practical planning and execution of groupjoin and nested aggregates," _The VLDB Journal_, vol. 32, no. 6, hlm. 1165–1190, Nov 2023, doi: 10.1007/s00778-022-00765-x.

\[31\] M. Dreseler, M. Boissier, T. Rabl, dan M. Uflacker, "Quantifying TPC-H choke points and their optimizations," _Proceedings of the VLDB Endowment_, vol. 13, no. 8, hlm. 1206–1220, Apr 2020, doi: 10.14778/3389133.3389138.

\[32\] D. C. . Montgomery, _Design and analysis of experiments_. Wiley, 2020.

\[33\] M. Raasveldt, P. Holanda, T. Gubner, dan H. Mühleisen, "Fair Benchmarking Considered Difficult," dalam _Proceedings of the Workshop on Testing Database Systems_, New York, NY, USA: ACM, Jun 2018, hlm. 1–6. doi: 10.1145/3209950.3209955.

\[34\] T. Taipalus, "Database management system performance comparisons: A systematic literature review," _Journal of Systems and Software_, vol. 208, hlm. 111872, Feb 2024, doi: 10.1016/j.jss.2023.111872.

\[35\] Intel Corporation, "Intel Core i5-10300H Processor (8M Cache, up to 4.50 GHz)." Diakses: 1 November 2026. \[Daring\]. Tersedia pada: <https://www.intel.com/content/www/us/en/products/sku/201839/intel-core-i510300h-processor-8m-cache-up-to-4-50-ghz/specifications.html>

\[36\] PostgreSQL, "Resource Consumption." Diakses: 1 November 2026. \[Daring\]. Tersedia pada: <https://www.postgresql.org/docs/18/runtime-config-resource.html>

\[37\] T. Kalibera dan R. Jones, "Quantifying Performance Changes with Effect Size Confidence Intervals," Jul 2020, \[Daring\]. Tersedia pada: <http://arxiv.org/abs/2007.10899>

&nbsp;

Lampiran A

**Persiapan Dataset, DDL, dan Konfigurasi Database**

**Lampiran A.1 Informasi dan Versi Perangkat**

Tabel A.1 Informasi dan Versi Perangkat

| **Komponen**   | **Spesifikasi**                         | **Versi**                                                               |
| -------------- | --------------------------------------- | ----------------------------------------------------------------------- |
| DBMS           | PostgreSQL                              | PostgreSQL 18.6 on x86_64-windows, compiled by msvc-19.44.35229, 64-bit |
| _Benchmark_    | TPC-H                                   | 3.0.1                                                                   |
| Data Generator | dbgen                                   | Version 3.0.0 build 0                                                   |
| Sistem Operasi | Edition Windows 10 Home Single Language | 22H2                                                                    |
| Prosesor       | Intel Core i5-10300H                    | 4 Core, 8 Logical Processors                                            |
| Memori         | RAM 8 GB                                | 7,84 GB usable                                                          |
| Penyimpanan    | SSD                                     | 477 GB                                                                  |

**Lampiran A.2 Skrip Pembentukan Schema dan PK**

Skrip berikut digunakan untuk membentuk delapan tabel berdasarkan skema TPC-H dan mendefinisikan _primary key_ pada masing-masing tabel.

```
CREATE TABLE region (
    r_regionkey  INTEGER NOT NULL,
    r_name       CHAR(25) NOT NULL,
    r_comment    VARCHAR(152)
);
CREATE TABLE nation (
    n_nationkey  INTEGER NOT NULL,
    n_name       CHAR(25) NOT NULL,
    n_regionkey  INTEGER NOT NULL,
    n_comment    VARCHAR(152)
);
CREATE TABLE part (
    p_partkey     INTEGER NOT NULL,
    p_name        VARCHAR(55) NOT NULL,
    p_mfgr        CHAR(25) NOT NULL,
    p_brand       CHAR(10) NOT NULL,
    p_type        VARCHAR(25) NOT NULL,
    p_size        INTEGER NOT NULL,
    p_container   CHAR(10) NOT NULL,
    p_retailprice NUMERIC(15,2) NOT NULL,
    p_comment     VARCHAR(23) NOT NULL
);
CREATE TABLE supplier (
    s_suppkey   INTEGER NOT NULL,
    s_name      CHAR(25) NOT NULL,
    s_address   VARCHAR(40) NOT NULL,
    s_nationkey INTEGER NOT NULL,
    s_phone     CHAR(15) NOT NULL,
    s_acctbal   NUMERIC(15,2) NOT NULL,
    s_comment   VARCHAR(101) NOT NULL
);
CREATE TABLE partsupp (
    ps_partkey    INTEGER NOT NULL,
    ps_suppkey    INTEGER NOT NULL,
    ps_availqty   INTEGER NOT NULL,
    ps_supplycost NUMERIC(15,2) NOT NULL,
    ps_comment    VARCHAR(199) NOT NULL
);
CREATE TABLE customer (
    c_custkey    INTEGER NOT NULL,
    c_name       VARCHAR(25) NOT NULL,
    c_address    VARCHAR(40) NOT NULL,
    c_nationkey  INTEGER NOT NULL,
    c_phone      CHAR(15) NOT NULL,
    c_acctbal    NUMERIC(15,2) NOT NULL,
    c_mktsegment CHAR(10) NOT NULL,
    c_comment    VARCHAR(117) NOT NULL
);
CREATE TABLE orders (
    o_orderkey      INTEGER NOT NULL,
    o_custkey       INTEGER NOT NULL,
    o_orderstatus   CHAR(1) NOT NULL,
    o_totalprice    NUMERIC(15,2) NOT NULL,
    o_orderdate     DATE NOT NULL,
    o_orderpriority CHAR(15) NOT NULL,
    o_clerk         CHAR(15) NOT NULL,
    o_shippriority  INTEGER NOT NULL,
    o_comment       VARCHAR(79) NOT NULL
);
CREATE TABLE lineitem (
    l_orderkey      INTEGER NOT NULL,
    l_partkey       INTEGER NOT NULL,
    l_suppkey       INTEGER NOT NULL,
    l_linenumber    INTEGER NOT NULL,
    l_quantity      NUMERIC(15,2) NOT NULL,
    l_extendedprice NUMERIC(15,2) NOT NULL,
    l_discount      NUMERIC(15,2) NOT NULL,
    l_tax           NUMERIC(15,2) NOT NULL,
    l_returnflag    CHAR(1) NOT NULL,
    l_linestatus    CHAR(1) NOT NULL,
    l_shipdate      DATE NOT NULL,
    l_commitdate    DATE NOT NULL,
    l_receiptdate   DATE NOT NULL,
    l_shipinstruct  CHAR(25) NOT NULL,
    l_shipmode      CHAR(10) NOT NULL,
    l_comment       VARCHAR(44) NOT NULL
);
ALTER TABLE region
    ADD CONSTRAINT pk_region
    PRIMARY KEY (r_regionkey);
ALTER TABLE nation
    ADD CONSTRAINT pk_nation
    PRIMARY KEY (n_nationkey);
ALTER TABLE part
    ADD CONSTRAINT pk_part
    PRIMARY KEY (p_partkey);
ALTER TABLE supplier
    ADD CONSTRAINT pk_supplier
    PRIMARY KEY (s_suppkey);
ALTER TABLE partsupp
    ADD CONSTRAINT pk_partsupp
    PRIMARY KEY (ps_partkey, ps_suppkey);
ALTER TABLE customer
    ADD CONSTRAINT pk_customer
    PRIMARY KEY (c_custkey);
ALTER TABLE orders
    ADD CONSTRAINT pk_orders
    PRIMARY KEY (o_orderkey);
ALTER TABLE lineitem
    ADD CONSTRAINT pk_lineitem
    PRIMARY KEY (l_orderkey, l_linenumber);
```

**Lampiran A.3 Skrip Pembentukan FK**

Skrip berikut digunakan untuk mendefinisikan _foreign key_ pada masing-masing tabel.

```
ALTER TABLE nation
    ADD CONSTRAINT fk_nation_region
    FOREIGN KEY (n_regionkey)
    REFERENCES region (r_regionkey);
ALTER TABLE supplier
    ADD CONSTRAINT fk_supplier_nation
    FOREIGN KEY (s_nationkey)
    REFERENCES nation (n_nationkey);
ALTER TABLE partsupp
    ADD CONSTRAINT fk_partsupp_part
    FOREIGN KEY (ps_partkey)
    REFERENCES part (p_partkey);
ALTER TABLE partsupp
    ADD CONSTRAINT fk_partsupp_supplier
    FOREIGN KEY (ps_suppkey)
    REFERENCES supplier (s_suppkey);
ALTER TABLE customer
    ADD CONSTRAINT fk_customer_nation
    FOREIGN KEY (c_nationkey)
    REFERENCES nation (n_nationkey);
ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customer
    FOREIGN KEY (o_custkey)
    REFERENCES customer (c_custkey);
ALTER TABLE lineitem
    ADD CONSTRAINT fk_lineitem_orders
    FOREIGN KEY (l_orderkey)
    REFERENCES orders (o_orderkey);
ALTER TABLE lineitem
    ADD CONSTRAINT fk_lineitem_partsupp
    FOREIGN KEY (l_partkey, l_suppkey)
    REFERENCES partsupp (ps_partkey, ps_suppkey);
ALTER TABLE lineitem
    ADD CONSTRAINT fk_lineitem_part
    FOREIGN KEY (l_partkey)
    REFERENCES part (p_partkey);
ALTER TABLE lineitem
    ADD CONSTRAINT fk_lineitem_supplier
    FOREIGN KEY (l_suppkey)
    REFERENCES supplier (s_suppkey);
```

**Lampiran A.4 Skrip Pembangkitan Dataset**

```
Set-Location "C:\Coding\thesis\tools\TPC-H V3.0.1\dbgen"
.\Debug\dbgen.exe -s 1 -f
Set-Location "C:\Coding\thesis\tools\TPC-H V3.0.1\dbgen"
.\Debug\dbgen.exe -s 10 -f
```

**Lampiran A.5 Skrip Pemuatan Dataset**

```
-- SF1
\set ON_ERROR_STOP on
BEGIN;
ALTER TABLE region ADD COLUMN dbgen_extra TEXT;
ALTER TABLE nation ADD COLUMN dbgen_extra TEXT;
ALTER TABLE part ADD COLUMN dbgen_extra TEXT;
ALTER TABLE supplier ADD COLUMN dbgen_extra TEXT;
ALTER TABLE partsupp ADD COLUMN dbgen_extra TEXT;
ALTER TABLE customer ADD COLUMN dbgen_extra TEXT;
ALTER TABLE orders ADD COLUMN dbgen_extra TEXT;
ALTER TABLE lineitem ADD COLUMN dbgen_extra TEXT;
\copy region FROM 'C:/Coding/thesis/dataset/SF1/region.tbl' WITH (FORMAT text, DELIMITER '|')
\copy nation FROM 'C:/Coding/thesis/dataset/SF1/nation.tbl' WITH (FORMAT text, DELIMITER '|')
\copy part FROM 'C:/Coding/thesis/dataset/SF1/part.tbl' WITH (FORMAT text, DELIMITER '|')
\copy supplier FROM 'C:/Coding/thesis/dataset/SF1/supplier.tbl' WITH (FORMAT text, DELIMITER '|')
\copy partsupp FROM 'C:/Coding/thesis/dataset/SF1/partsupp.tbl' WITH (FORMAT text, DELIMITER '|')
\copy customer FROM 'C:/Coding/thesis/dataset/SF1/customer.tbl' WITH (FORMAT text, DELIMITER '|')
\copy orders FROM 'C:/Coding/thesis/dataset/SF1/orders.tbl' WITH (FORMAT text, DELIMITER '|')
\copy lineitem FROM 'C:/Coding/thesis/dataset/SF1/lineitem.tbl' WITH (FORMAT text, DELIMITER '|')
ALTER TABLE region DROP COLUMN dbgen_extra;
ALTER TABLE nation DROP COLUMN dbgen_extra;
ALTER TABLE part DROP COLUMN dbgen_extra;
ALTER TABLE supplier DROP COLUMN dbgen_extra;
ALTER TABLE partsupp DROP COLUMN dbgen_extra;
ALTER TABLE customer DROP COLUMN dbgen_extra;
ALTER TABLE orders DROP COLUMN dbgen_extra;
ALTER TABLE lineitem DROP COLUMN dbgen_extra;
COMMIT;
-- SF10
\set ON_ERROR_STOP on
BEGIN;
ALTER TABLE region ADD COLUMN dbgen_extra TEXT;
ALTER TABLE nation ADD COLUMN dbgen_extra TEXT;
ALTER TABLE part ADD COLUMN dbgen_extra TEXT;
ALTER TABLE supplier ADD COLUMN dbgen_extra TEXT;
ALTER TABLE partsupp ADD COLUMN dbgen_extra TEXT;
ALTER TABLE customer ADD COLUMN dbgen_extra TEXT;
ALTER TABLE orders ADD COLUMN dbgen_extra TEXT;
ALTER TABLE lineitem ADD COLUMN dbgen_extra TEXT;
\copy region FROM 'C:/Coding/thesis/dataset/SF10/region.tbl' WITH (FORMAT text, DELIMITER '|')
\copy nation FROM 'C:/Coding/thesis/dataset/SF10/nation.tbl' WITH (FORMAT text, DELIMITER '|')
\copy part FROM 'C:/Coding/thesis/dataset/SF10/part.tbl' WITH (FORMAT text, DELIMITER '|')
\copy supplier FROM 'C:/Coding/thesis/dataset/SF10/supplier.tbl' WITH (FORMAT text, DELIMITER '|')
\copy partsupp FROM 'C:/Coding/thesis/dataset/SF10/partsupp.tbl' WITH (FORMAT text, DELIMITER '|')
\copy customer FROM 'C:/Coding/thesis/dataset/SF10/customer.tbl' WITH (FORMAT text, DELIMITER '|')
\copy orders FROM 'C:/Coding/thesis/dataset/SF10/orders.tbl' WITH (FORMAT text, DELIMITER '|')
\copy lineitem FROM 'C:/Coding/thesis/dataset/SF10/lineitem.tbl' WITH (FORMAT text, DELIMITER '|')
ALTER TABLE region DROP COLUMN dbgen_extra;
ALTER TABLE nation DROP COLUMN dbgen_extra;
ALTER TABLE part DROP COLUMN dbgen_extra;
ALTER TABLE supplier DROP COLUMN dbgen_extra;
ALTER TABLE partsupp DROP COLUMN dbgen_extra;
ALTER TABLE customer DROP COLUMN dbgen_extra;
ALTER TABLE orders DROP COLUMN dbgen_extra;
ALTER TABLE lineitem DROP COLUMN dbgen_extra;
COMMIT;
```

**Lampiran A.6 Skrip VACUUM dan ANALYZE**

```
VACUUM (ANALYZE, VERBOSE);
ANALYZE VERBOSE;
```

**Lampiran A.7 Skrip Verifikasi Database**

Tabel A.2 Skrip Verifikasi Database

| **Verifikasi** | **Skrip**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Konstrain      | `SELECT`<br> `CASE contype`<br> `WHEN 'p' THEN 'PRIMARY KEY'`<br> `WHEN 'f' THEN 'FOREIGN KEY'`<br> `END AS constraint_type,`<br> `COUNT(*) AS total_constraints`<br>`FROM pg_constraint`<br>`WHERE connamespace = 'public'::regnamespace`<br> `AND contype IN ('p', 'f')`<br>`GROUP BY contype`<br>`ORDER BY contype;`<br>`SELECT`<br> `conname AS constraint_name,`<br> `CASE contype`<br> `WHEN 'p' THEN 'PRIMARY KEY'`<br> `WHEN 'f' THEN 'FOREIGN KEY'`<br> `END AS constraint_type,`<br> `pg_get_constraintdef(oid) AS definition`<br>`FROM pg_constraint`<br>`WHERE connamespace = 'public'::regnamespace`<br> `AND contype IN ('p', 'f')`<br>`ORDER BY contype, conname;`<br>`SELECT`<br> `conname AS constraint_name,`<br> `convalidated AS is_validated`<br>`FROM pg_constraint`<br>`WHERE connamespace = 'public'::regnamespace`<br> `AND contype IN ('p', 'f')`<br>`ORDER BY conname;` |
| Jumlah Dataset | `SELECT 'region' AS table_name, COUNT(*) AS row_count FROM region`<br>`UNION ALL`<br>`SELECT 'nation', COUNT(*) FROM nation`<br>`UNION ALL`<br>`SELECT 'part', COUNT(*) FROM part`<br>`UNION ALL`<br>`SELECT 'supplier', COUNT(*) FROM supplier`<br>`UNION ALL`<br>`SELECT 'partsupp', COUNT(*) FROM partsupp`<br>`UNION ALL`<br>`SELECT 'customer', COUNT(*) FROM customer`<br>`UNION ALL`<br>`SELECT 'orders', COUNT(*) FROM orders`<br>`UNION ALL`<br>`SELECT 'lineitem', COUNT(*) FROM lineitem`<br>`ORDER BY table_name;`                                                                                                                                                                                                                                                                                                                                                                     |

**Lampiran A.8 Bukti Hasil Revifikasi**

Tabel A.3 Hasil Verifikasi Jumlah Record SF1

| **Tabel** | **Jumlah Record** |
| --------- | ----------------- |
| customer  | 150.000           |
| lineitem  | 6.001.215         |
| nation    | 25                |
| orders    | 1.500.000         |
| part      | 200.000           |
| partsupp  | 800.000           |
| region    | 5                 |
| supplier  | 10.000            |
| Total     | 8.661.245         |

Tabel A.4 Hasil Verifikasi Jumlah Record SF2

| **Tabel** | **Jumlah Record** |
| --------- | ----------------- |
| customer  | 1.500.000         |
| lineitem  | 59.986.052        |
| nation    | 25                |
| orders    | 15.000.000        |
| part      | 2.000.000         |
| partsupp  | 8.000.000         |
| region    | 5                 |
| supplier  | 100.000           |
| Total     | 86.586.082        |

Tabel A.5 Laporan Verifikasi

| **Laporan**                       | **Isi**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Laporan Validasi SF1              | `TPC-H DATASET VALIDATION`<br>`=======================`<br>`Scale Factor: SF1`<br>`DBGEN Version: 3.0.0 build 0`<br>`Generation Status: SUCCESS`<br>`Generated files: 8`<br>`Empty files: 0`<br>`Generation Command:`<br>`dbgen.exe -v -f -s 1`<br>`Validation Method:`<br>`PowerShell line-by-line file reading`<br>`Table Row Counts:`<br>`Table RowCount SizeBytes`<br>`----- -------- ---------`<br>`customer 150000 24496144`<br>`lineitem 6001215 765864502`<br>`nation 25 2249`<br>`orders 1500000 173452161`<br>`part 200000 24335125`<br>`partsupp 800000 119784616`<br>`region 5 394`<br>`supplier 10000 1419184`<br>`Validation Result:`<br>`All eight tables match the expected SF1 row counts.`<br>`All generated files are non-empty.`<br>`Validation Date:`<br>`2026-11-11`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| Laporan Validasi SF10             | `TPC-H DATASET VALIDATION`<br>`=======================`<br>`Scale Factor: SF10`<br>`DBGEN Version: 3.0.0 build 0`<br>`Generation Status: SUCCESS`<br>`Generated files: 8`<br>`Empty files: 0`<br>`Generation Command:`<br>`dbgen.exe -v -f -s 10`<br>`Validation Method:`<br>`PowerShell line-by-line file reading`<br>`Table Row Counts:`<br>`Table RowCount SizeBytes`<br>`----- -------- ---------`<br>`customer 1500000 246347642`<br>`lineitem 59986052 7835713740`<br>`nation 25 2249`<br>`orders 15000000 1764195031`<br>`part 2000000 245336157`<br>`partsupp 8000000 1212850769`<br>`region 5 394`<br>`supplier 100000 14276368`<br>`Validation Result:`<br>`All eight tables match the expected SF1 row counts.`<br>`All generated files are non-empty.`<br>`Validation Date:`<br>`2026-11-11`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Manifest SHA-256                  | `TPC-H DBGEN TOOL MANIFEST`<br>`========================`<br>`Tool:`<br>`TPC-H Database Population Generator (DBGEN)`<br>`Source directory:`<br>`C:\Coding\thesis\tools\TPC-H V3.0.1\dbgen`<br>`Executable:`<br>`dbgen.exe`<br>`Executable path:`<br>`C:\Coding\thesis\tools\TPC-H V3.0.1\dbgen\Debug\dbgen.exe`<br>`DBGEN version:`<br>`3.0.0`<br>`DBGEN release:`<br>`3.0.0 build 0`<br>`Source release.h:`<br>`VERSION = 3`<br>`RELEASE = 0`<br>`PATCH = 0`<br>`BUILD = 0`<br>`Random seed configuration:`<br>`Defined internally in rnd.h.`<br>`No custom seed modification.`<br>`Scale factors:`<br>`SF1`<br>`SF10`<br>`Generation parameters:`<br>`-v -f -s 1`<br>`-v -f -s 10`<br>`Compiler:`<br>`Microsoft Visual Studio v18.12.0`<br>`Build configuration:`<br>`Debug`<br>`X64`<br>`Executable SHA256:`<br>`03C02EEED4B2FE469BC456D8A8E5D0328CD74229DA8628476E2A299209F3CBBB`<br>`release.h SHA256:`<br>`C44582A90A77B0818D313174F9F0763021F14DD0E2EAA83A6F2A926E28DA6519`<br>`rnd.h SHA256:`<br>`DBBB31D88F218A1B7F99D87A26E6D64B3A2A22090275A453F9D8D0F0040091A6`<br>`dists.dss SHA256:`<br>`4DC56300DE1E5AC5E1900519794538E2B5D1B6CAF5CD55703BF53000DD748876`<br>`Generation date:`<br>`2026-11-11`<br>`Notes:`<br>`The original DBGEN source files and random seed definitions`<br>`were not modified for dataset generation.`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Bukti Jumlah FK dan Indeks PK SF1 | `TPC-H CONSTRAINT VALIDATION REPORT`<br>`==================================`<br>`A. GENERAL INFORMATION`<br>`----------------------`<br>`Benchmark : TPC-H 3.0.1`<br>`DBMS : PostgreSQL 18.6`<br>`Database Name : tpch_sf1`<br>`Scale Factor : SF1`<br>`Execution Date : 2026-11-12 00:12`<br>`Validation Status: SUCCESS`<br>`B. PRIMARY KEY VALIDATION`<br>`-------------------------`<br>`Expected PK Constraints : 8`<br>`Actual PK Constraints : 8`<br>`PK Validation Status : SUCCESS`<br>`Constraint Name Table Columns`<br>`--------------- ----- -------`<br>`pk_customer customer c_custkey`<br>`pk_lineitem lineitem l_orderkey, l_linenumber`<br>`pk_nation nation n_nationkey`<br>`pk_orders orders o_orderkey`<br>`pk_part part p_partkey`<br>`pk_partsupp partsupp ps_partkey, ps_suppkey`<br>`pk_region region r_regionkey`<br>`pk_supplier supplier s_suppkey`<br>`C. FOREIGN KEY VALIDATION`<br>`-------------------------`<br>`Expected FK Constraints : 10`<br>`Actual FK Constraints : 10`<br>`FK Validation Status : SUCCESS`<br>`Constraint Name Table Referenced Table`<br>`--------------- ----- ----------------`<br>`fk_nation_region nation region`<br>`fk_supplier_nation supplier nation`<br>`fk_partsupp_part partsupp part`<br>`fk_partsupp_supplier partsupp supplier`<br>`fk_customer_nation customer nation`<br>`fk_orders_customer orders customer`<br>`fk_lineitem_orders lineitem orders`<br>`fk_lineitem_partsupp lineitem partsupp`<br>`fk_lineitem_part lineitem part`<br>`fk_lineitem_supplier lineitem supplier`<br>`D. VALIDATION SUMMARY`<br>`---------------------`<br>`Constraint Type Expected Actual Status`<br>`--------------- -------- ------ ------`<br>`Primary Key 8 8 SUCCESS`<br>`Foreign Key 10 10 SUCCESS`<br>`Total 18 18 SUCCESS`<br>`Overall Validation Status : SUCCESS`<br>`E. NOTES`<br>`--------`<br>`1. Constraints were applied after dataset loading.`<br>`2. Primary keys are defined according to the TPC-H schema.`<br>`3. Foreign keys are defined according to the TPC-H relationships.`<br>`4. Primary key constraints automatically create supporting indexes.`<br>`5. No additional experimental indexes (I1/I2) have been created.`<br>`6. No query performance measurements have been conducted.`<br>`END OF REPORT`   |
| Bukti Jumlah FK dan Indeks PK SF1 | `TPC-H CONSTRAINT VALIDATION REPORT`<br>`==================================`<br>`A. GENERAL INFORMATION`<br>`----------------------`<br>`Benchmark : TPC-H 3.0.1`<br>`DBMS : PostgreSQL 18.6`<br>`Database Name : tpch_sf10`<br>`Scale Factor : SF10`<br>`Execution Date : 2026-11-12 00:30`<br>`Validation Status: SUCCESS`<br>`B. PRIMARY KEY VALIDATION`<br>`-------------------------`<br>`Expected PK Constraints : 8`<br>`Actual PK Constraints : 8`<br>`PK Validation Status : SUCCESS`<br>`Constraint Name Table Columns`<br>`--------------- ----- -------`<br>`pk_customer customer c_custkey`<br>`pk_lineitem lineitem l_orderkey, l_linenumber`<br>`pk_nation nation n_nationkey`<br>`pk_orders orders o_orderkey`<br>`pk_part part p_partkey`<br>`pk_partsupp partsupp ps_partkey, ps_suppkey`<br>`pk_region region r_regionkey`<br>`pk_supplier supplier s_suppkey`<br>`C. FOREIGN KEY VALIDATION`<br>`-------------------------`<br>`Expected FK Constraints : 10`<br>`Actual FK Constraints : 10`<br>`FK Validation Status : SUCCESS`<br>`Constraint Name Table Referenced Table`<br>`--------------- ----- ----------------`<br>`fk_nation_region nation region`<br>`fk_supplier_nation supplier nation`<br>`fk_partsupp_part partsupp part`<br>`fk_partsupp_supplier partsupp supplier`<br>`fk_customer_nation customer nation`<br>`fk_orders_customer orders customer`<br>`fk_lineitem_orders lineitem orders`<br>`fk_lineitem_partsupp lineitem partsupp`<br>`fk_lineitem_part lineitem part`<br>`fk_lineitem_supplier lineitem supplier`<br>`D. VALIDATION SUMMARY`<br>`---------------------`<br>`Constraint Type Expected Actual Status`<br>`--------------- -------- ------ ------`<br>`Primary Key 8 8 SUCCESS`<br>`Foreign Key 10 10 SUCCESS`<br>`Total 18 18 SUCCESS`<br>`Overall Validation Status : SUCCESS`<br>`E. NOTES`<br>`--------`<br>`1. Constraints were applied after dataset loading.`<br>`2. Primary keys are defined according to the TPC-H schema.`<br>`3. Foreign keys are defined according to the TPC-H relationships.`<br>`4. Primary key constraints automatically create supporting indexes.`<br>`5. No additional experimental indexes (I1/I2) have been created.`<br>`6. No query performance measurements have been conducted.`<br>`END OF REPORT` |

**Lampiran A.9 Konfigurasi PostgreSQL**

Tabel A.6 Konfigurasi PostgreSQL

| **Parameter**        | **Nilai** |
| -------------------- | --------- |
| shared_buffers       | 128MB     |
| work_mem             | 4MB       |
| effective_cache_size | 4GB       |
| max_connections      | 100       |
| statement_timeout    | 0         |

Lampiran B

**Rancangan dan Implementasi Indeks I0, I1, dan I2**

**Lampiran B.1 Inventaris Indeks I0, I1, dan I2**

Konfigurasi indeks dalam penelitian ini disusun secara kumulatif, yaitu I0 ⊂ I1 ⊂ I2. Konfigurasi I0 terdiri atas indeks yang terbentuk dari delapan _primary key_ pada skema TPC-H. Konfigurasi I1 menambahkan lima indeks B-tree satu kolom pada atribut _foreign key_ yang tidak tercakup sebagai kolom awal indeks I0. Konfigurasi I2 menambahkan lima indeks komposit atau _covering index_ untuk mendukung pola filter, korelasi, dan agregasi pada query Q2, Q17, dan Q20.

Seluruh indeks menggunakan metode B-tree. Indeks yang terbentuk dari _primary key_ bersifat unik (_unique_), sedangkan indeks tambahan I1 dan I2 bersifat tidak unik (_non-unique_). Kolom kunci dan kolom INCLUDE dibedakan secara eksplisit karena kolom INCLUDE hanya menyimpan atribut tambahan pada leaf page dan tidak menjadi bagian dari urutan pencarian kunci indeks.

Inventaris berikut menunjukkan nama indeks, tabel, urutan kolom kunci, kolom INCLUDE, sifat keunikan, operator class, query yang menjadi dasar pemilihan, serta alasan teknis setiap indeks.

Tabel B.1 Inventaris Indeks I0, I1, dan I2

| **No.** | **Level** | **Nama indeks**          | **Tabel dan definisi indeks**                                                    | **Query**    |
| ------- | --------- | ------------------------ | -------------------------------------------------------------------------------- | ------------ |
| 1       | I0        | region_pkey              | region(r_regionkey) UNIQUE                                                       | Q2           |
| 2       | I0        | nation_pkey              | nation(n_nationkey) UNIQUE                                                       | Q2           |
| 3       | I0        | part_pkey                | part(p_partkey) UNIQUE                                                           | Q2, Q17, Q20 |
| 4       | I0        | supplier_pkey            | supplier(s_suppkey) UNIQUE                                                       | Q2, Q20      |
| 5       | I0        | partsupp_pkey            | partsupp(ps_partkey, ps_suppkey) UNIQUE                                          | Q2, Q20      |
| 6       | I0        | customer_pkey            | customer(c_custkey) UNIQUE                                                       | \-           |
| 7       | I0        | orders_pkey              | orders(o_orderkey) UNIQUE                                                        | \-           |
| 8       | I0        | lineitem_pkey            | lineitem(l_orderkey, l_linenumber) UNIQUE                                        | Q17, Q20     |
| 9       | I1        | ix1_nation_regionkey     | nation(n_regionkey)                                                              | Q2           |
| 10      | I1        | ix1_supplier_nationkey   | supplier(s_nationkey)                                                            | Q2, Q20      |
| 11      | I1        | ix1_partsupp_suppkey     | partsupp(ps_suppkey)                                                             | Q2, Q20      |
| 12      | I1        | ix1_lineitem_partkey     | lineitem(l_partkey)                                                              | Q17, Q20     |
| 13      | I1        | ix1_lineitem_suppkey     | lineitem(l_suppkey)                                                              | Q20          |
| 14      | I2        | ix2_lineitem_ps_cover    | lineitem(l_partkey, l_suppkey, l_shipdate) INCLUDE (l_quantity, l_extendedprice) | Q17, Q20     |
| 15      | I2        | ix2_part_brand_container | part(p_brand, p_container) INCLUDE (p_partkey)                                   | Q17          |
| 16      | I2        | ix2_part_size            | part(p_size) INCLUDE (p_partkey, p_type, p_mfgr)                                 | Q2           |
| 17      | I2        | ix2_part_name_prefix     | part(p_name varchar_pattern_ops) INCLUDE (p_partkey)                             | Q20          |
| 18      | I2        | ix2_partsupp_cover       | partsupp(ps_partkey) INCLUDE (ps_suppkey, ps_supplycost, ps_availqty)            | Q2, Q20      |

**Lampiran B.2 Skrip Pembuatan Indeks I1**

```
CREATE INDEX ix1_nation_regionkey
ON public.nation USING btree (n_regionkey);
CREATE INDEX ix1_supplier_nationkey
ON public.supplier USING btree (s_nationkey);
CREATE INDEX ix1_partsupp_suppkey
ON public.partsupp USING btree (ps_suppkey);
CREATE INDEX ix1_lineitem_partkey
ON public.lineitem USING btree (l_partkey);
CREATE INDEX ix1_lineitem_suppkey
ON public.lineitem USING btree (l_suppkey);
```

**Lampiran B.3 Skrip Pembuatan Indeks I2**

```
CREATE INDEX ix2_lineitem_ps_cover
ON public.lineitem USING btree
    (l_partkey, l_suppkey, l_shipdate)
INCLUDE (l_quantity, l_extendedprice);
CREATE INDEX ix2_part_brand_container
ON public.part USING btree
    (p_brand, p_container)
INCLUDE (p_partkey);
CREATE INDEX ix2_part_size
ON public.part USING btree
    (p_size)
INCLUDE (p_partkey, p_type, p_mfgr);
CREATE INDEX ix2_part_name_prefix
ON public.part USING btree
    (p_name varchar_pattern_ops)
INCLUDE (p_partkey);
CREATE INDEX ix2_partsupp_cover
ON public.partsupp USING btree
    (ps_partkey)
INCLUDE (ps_suppkey, ps_supplycost, ps_availqty);
```

**Lampiran B.4 Skrip Pengembalian Konfigurasi ke I0**

```
DROP INDEX IF EXISTS public.ix2_lineitem_ps_cover;
DROP INDEX IF EXISTS public.ix2_part_brand_container;
DROP INDEX IF EXISTS public.ix2_part_size;
DROP INDEX IF EXISTS public.ix2_part_name_prefix;
DROP INDEX IF EXISTS public.ix2_partsupp_cover;
DROP INDEX IF EXISTS public.ix1_nation_regionkey;
DROP INDEX IF EXISTS public.ix1_supplier_nationkey;
DROP INDEX IF EXISTS public.ix1_partsupp_suppkey;
DROP INDEX IF EXISTS public.ix1_lineitem_partkey;
DROP INDEX IF EXISTS public.ix1_lineitem_suppkey;
```

**Lampiran B.5 Skrip Verifikasi Definisi Indeks**

```
SELECT
    tbl.relname AS table_name,
    idx.relname AS index_name,
    am.amname AS index_method,
    pi.indisprimary AS is_primary,
    pi.indisunique AS is_unique,
    pg_get_indexdef(idx.oid) AS index_definition
FROM
    pg_class idx
JOIN
    pg_index pi
    ON pi.indexrelid = idx.oid
JOIN
    pg_class tbl
    ON tbl.oid = pi.indrelid
JOIN
    pg_namespace ns
    ON ns.oid = tbl.relnamespace
JOIN
    pg_am am
    ON am.oid = idx.relam
WHERE
    ns.nspname = 'public'
    AND tbl.relname IN (
        'region',
        'nation',
        'part',
        'supplier',
        'partsupp',
        'customer',
        'orders',
        'lineitem'
    )
ORDER BY
    tbl.relname,
    idx.relname;
```

**Lampiran B.6 Skrip Verifikasi Definisi Indeks**

Tabel B.2 Bukti Hasil Implementasi

| **Database** | **Level** | **Jumlah indeks yang diharapkan** | **Jumlah aktual**  | **Status** |
| ------------ | --------- | --------------------------------- | ------------------ | ---------- |
| SF1          | I0        | 8                                 | Belum diverifikasi | Pending    |
| SF1          | I1        | 13                                | Belum diverifikasi | Pending    |
| SF1          | I2        | 18                                | Belum diverifikasi | Pending    |
| SF1          | Reset I0  | 8                                 | Belum diverifikasi | Pending    |

**Lampiran B.7 Bukti Biaya Indeks**

Belum dibuat

**Lampiran B.8 Bukti Penguncian Rancangan Indeks**

Menunggu Indeks dibuat

Lampiran C

**SQL Original, SQL Rewriting, dan Validasi Ekuivalensi**

**Lampiran C.1 Parameter Validasi TPC-H**

Validasi SQL Original dan SQL Rewriting menggunakan parameter tetap yang sama untuk setiap query. Penetapan parameter bertujuan menjaga konsistensi input selama pemeriksaan ekuivalensi hasil. Parameter yang digunakan ditunjukkan pada Tabel C.1.

Tabel C.1 Parameter Validasi Query

| **Query** | **Parameter** | **Nilai**  |
| --------- | ------------- | ---------- |
| Q2        | SIZE          | 15         |
| Q2        | TYPE          | BRASS      |
| Q2        | REGION        | EUROPE     |
| Q17       | BRAND         | Brand#23   |
| Q17       | CONTAINER     | MED BOX    |
| Q20       | COLOR         | forest     |
| Q20       | DATE          | 1994-01-01 |
| Q20       | NATION        | CANADA     |

Parameter tersebut digunakan secara konsisten pada SQL Original dan SQL _Rewriting_. Dengan demikian, perbedaan hasil yang ditemukan tidak disebabkan oleh perbedaan nilai parameter.

Validasi teknis dilakukan menggunakan dataset tambahan SF0.1 apabila diperlukan untuk mempercepat pemeriksaan transformasi SQL. Dataset SF0.1 hanya digunakan sebagai sarana pengujian teknis dan tidak menggantikan dataset utama penelitian, yaitu SF1 dan SF10.

**Lampiran C.2 SQL Original**

Tabel C.2 SQL Original

| **Query** | **SQL**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q2        | `SELECT`<br> `s_acctbal,`<br> `s_name,`<br> `n_name,`<br> `p_partkey,`<br> `p_mfgr,`<br> `s_address,`<br> `s_phone,`<br> `s_comment`<br>`FROM`<br> `part,`<br> `supplier,`<br> `partsupp,`<br> `nation,`<br> `region`<br>`WHERE`<br> `p_partkey = ps_partkey`<br> `AND s_suppkey = ps_suppkey`<br> `AND p_size = 15`<br> `AND p_type LIKE '%BRASS'`<br> `AND s_nationkey = n_nationkey`<br> `AND n_regionkey = r_regionkey`<br> `AND r_name = 'EUROPE'`<br> `AND ps_supplycost = (`<br> `SELECT`<br> `MIN(ps_supplycost)`<br> `FROM`<br> `partsupp,`<br> `supplier,`<br> `nation,`<br> `region`<br> `WHERE`<br> `p_partkey = ps_partkey`<br> `AND s_suppkey = ps_suppkey`<br> `AND s_nationkey = n_nationkey`<br> `AND n_regionkey = r_regionkey`<br> `AND r_name = 'EUROPE'`<br> `)`<br>`ORDER BY`<br> `s_acctbal DESC,`<br> `n_name,`<br> `s_name,`<br> `p_partkey`<br>`LIMIT 100;`                                                                                             |
| Q17       | `SELECT`<br> `SUM(l_extendedprice) / 7.0 AS avg_yearly`<br>`FROM`<br> `lineitem,`<br> `part`<br>`WHERE`<br> `p_partkey = l_partkey`<br> `AND p_brand = 'Brand#23'`<br> `AND p_container = 'MED BOX'`<br> `AND l_quantity < (`<br> `SELECT`<br> `0.2 * AVG(l_quantity)`<br> `FROM`<br> `lineitem`<br> `WHERE`<br> `l_partkey = p_partkey`<br> `);`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Q20       | SELECT<br><br>&nbsp; s_name,<br><br>&nbsp; s_address<br><br>FROM<br><br>&nbsp; supplier,<br><br>&nbsp; nation<br><br>WHERE<br><br>&nbsp; s_suppkey IN (<br><br>&nbsp; SELECT<br><br>&nbsp; ps_suppkey<br><br>&nbsp; FROM<br><br>&nbsp; partsupp<br><br>&nbsp; WHERE<br><br>&nbsp; ps_partkey IN (<br><br>&nbsp; SELECT<br><br>&nbsp; p_partkey<br><br>&nbsp; FROM<br><br>&nbsp; part<br><br>&nbsp; WHERE<br><br>&nbsp; p_name LIKE 'forest%'<br><br>&nbsp; )<br><br>&nbsp; AND ps_availqty > (<br><br>&nbsp; SELECT<br><br>&nbsp; 0.5 \* SUM(l_quantity)<br><br>&nbsp; FROM<br><br>&nbsp; lineitem<br><br>&nbsp; WHERE<br><br>&nbsp; l_partkey = ps_partkey<br><br>&nbsp; AND l_suppkey = ps_suppkey<br><br>&nbsp; AND l_shipdate >= DATE '1994-01-01'<br><br>&nbsp; AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'<br><br>&nbsp; )<br><br>&nbsp; )<br><br>&nbsp; AND s_nationkey = n_nationkey<br><br>&nbsp; AND n_name = 'CANADA'<br><br>ORDER BY<br><br>&nbsp; s_name; |

**Lampiran C.3 SQL Rewriting**

Tabel C.3 SQL Rewriting

| **Query** | **SQL**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q2        | `WITH min_supply_cost AS (`<br> `SELECT`<br> `ps_partkey,`<br> `MIN(ps_supplycost) AS min_supplycost`<br> `FROM`<br> `partsupp`<br> `JOIN supplier`<br> `ON s_suppkey = ps_suppkey`<br> `JOIN nation`<br> `ON s_nationkey = n_nationkey`<br> `JOIN region`<br> `ON n_regionkey = r_regionkey`<br> `WHERE`<br> `r_name = 'EUROPE'`<br> `GROUP BY`<br> `ps_partkey`<br>`)`<br>`SELECT`<br> `s_acctbal,`<br> `s_name,`<br> `n_name,`<br> `p_partkey,`<br> `p_mfgr,`<br> `s_address,`<br> `s_phone,`<br> `s_comment`<br>`FROM`<br> `part`<br>`JOIN partsupp`<br> `ON p_partkey = ps_partkey`<br>`JOIN supplier`<br> `ON s_suppkey = ps_suppkey`<br>`JOIN nation`<br> `ON s_nationkey = n_nationkey`<br>`JOIN region`<br> `ON n_regionkey = r_regionkey`<br>`JOIN min_supply_cost`<br> `ON min_supply_cost.ps_partkey = p_partkey`<br> `AND ps_supplycost = min_supply_cost.min_supplycost`<br>`WHERE`<br> `p_size = 15`<br> `AND p_type LIKE '%BRASS'`<br> `AND r_name = 'EUROPE'`<br>`ORDER BY`<br> `s_acctbal DESC,`<br> `n_name,`<br> `s_name,`<br> `p_partkey`<br>`LIMIT 100;`                                                                                                                                                                                                                                                                                                      |
| Q17       | `WITH avg_quantity_by_part AS (`<br> `SELECT`<br> `l_partkey,`<br> `AVG(l_quantity) AS avg_quantity`<br> `FROM`<br> `lineitem`<br> `GROUP BY`<br> `l_partkey`<br>`)`<br>`SELECT`<br> `SUM(l.l_extendedprice) / 7.0 AS avg_yearly`<br>`FROM`<br> `part p`<br>`JOIN lineitem l`<br> `ON p.p_partkey = l.l_partkey`<br>`JOIN avg_quantity_by_part aq`<br> `ON aq.l_partkey = p.p_partkey`<br>`WHERE`<br> `p.p_brand = 'Brand#23'`<br> `AND p.p_container = 'MED BOX'`<br> `AND l.l_quantity < 0.2 * aq.avg_quantity;`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Q20       | WITH lineitem_quantity_by_partsupp AS (<br><br>&nbsp; SELECT<br><br>&nbsp; l_partkey,<br><br>&nbsp; l_suppkey,<br><br>&nbsp; SUM(l_quantity) AS total_quantity<br><br>&nbsp; FROM<br><br>&nbsp; lineitem<br><br>&nbsp; WHERE<br><br>&nbsp; l_shipdate >= DATE '1994-01-01'<br><br>&nbsp; AND l_shipdate < DATE '1995-01-01'<br><br>&nbsp; GROUP BY<br><br>&nbsp; l_partkey,<br><br>&nbsp; l_suppkey<br><br>),<br><br>qualifying_suppliers AS (<br><br>&nbsp; SELECT DISTINCT<br><br>&nbsp; ps.ps_suppkey<br><br>&nbsp; FROM<br><br>&nbsp; partsupp ps<br><br>&nbsp; JOIN part p<br><br>&nbsp; ON p.p_partkey = ps.ps_partkey<br><br>&nbsp; JOIN lineitem_quantity_by_partsupp lq<br><br>&nbsp; ON lq.l_partkey = ps.ps_partkey<br><br>&nbsp; AND lq.l_suppkey = ps.ps_suppkey<br><br>&nbsp; WHERE<br><br>&nbsp; p.p_name LIKE 'forest%'<br><br>&nbsp; AND ps.ps_availqty > 0.5 \* lq.total_quantity<br><br>)<br><br>SELECT<br><br>&nbsp; s.s_name,<br><br>&nbsp; s.s_address<br><br>FROM<br><br>&nbsp; supplier s<br><br>JOIN nation n<br><br>&nbsp; ON s.s_nationkey = n.n_nationkey<br><br>JOIN qualifying_suppliers qs<br><br>&nbsp; ON qs.ps_suppkey = s.s_suppkey<br><br>WHERE<br><br>&nbsp; n.n_name = 'CANADA'<br><br>ORDER BY<br><br>&nbsp; s.s_name;<br><br>&nbsp; AND s_nationkey = n_nationkey<br><br>&nbsp; AND n_name = 'CANADA'<br><br>ORDER BY<br><br>&nbsp; s_name; |

**Lampiran C.4 Skrip Validasi Ekuivalensi**

Tabel C.4 SQL Rewriting

| **Query** | **SQL Validasi**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q2        | `CREATE TEMP TABLE q2_original_result AS`<br>`SELECT`<br> `s_acctbal,`<br> `s_name,`<br> `n_name,`<br> `p_partkey,`<br> `p_mfgr,`<br> `s_address,`<br> `s_phone,`<br> `s_comment`<br>`FROM`<br> `part,`<br> `supplier,`<br> `partsupp,`<br> `nation,`<br> `region`<br>`WHERE`<br> `p_partkey = ps_partkey`<br> `AND s_suppkey = ps_suppkey`<br> `AND p_size = 15`<br> `AND p_type LIKE '%BRASS'`<br> `AND s_nationkey = n_nationkey`<br> `AND n_regionkey = r_regionkey`<br> `AND r_name = 'EUROPE'`<br> `AND ps_supplycost = (`<br> `SELECT`<br> `MIN(ps_supplycost)`<br> `FROM`<br> `partsupp,`<br> `supplier,`<br> `nation,`<br> `region`<br> `WHERE`<br> `p_partkey = ps_partkey`<br> `AND s_suppkey = ps_suppkey`<br> `AND s_nationkey = n_nationkey`<br> `AND n_regionkey = r_regionkey`<br> `AND r_name = 'EUROPE'`<br> `)`<br>`ORDER BY`<br> `s_acctbal DESC,`<br> `n_name,`<br> `s_name,`<br> `p_partkey`<br>`LIMIT 100;`<br>`CREATE TEMP TABLE q2_rewritten_result AS`<br>`WITH min_supply_cost AS (`<br> `SELECT`<br> `ps_partkey,`<br> `MIN(ps_supplycost) AS min_supplycost`<br> `FROM`<br> `partsupp`<br> `JOIN supplier`<br> `ON s_suppkey = ps_suppkey`<br> `JOIN nation`<br> `ON s_nationkey = n_nationkey`<br> `JOIN region`<br> `ON n_regionkey = r_regionkey`<br> `WHERE`<br> `r_name = 'EUROPE'`<br> `GROUP BY`<br> `ps_partkey`<br>`)`<br>`SELECT`<br> `s_acctbal,`<br> `s_name,`<br> `n_name,`<br> `p_partkey,`<br> `p_mfgr,`<br> `s_address,`<br> `s_phone,`<br> `s_comment`<br>`FROM`<br> `part`<br>`JOIN partsupp`<br> `ON p_partkey = ps_partkey`<br>`JOIN supplier`<br> `ON s_suppkey = ps_suppkey`<br>`JOIN nation`<br> `ON s_nationkey = n_nationkey`<br>`JOIN region`<br> `ON n_regionkey = r_regionkey`<br>`JOIN min_supply_cost`<br> `ON min_supply_cost.ps_partkey = p_partkey`<br> `AND ps_supplycost = min_supply_cost.min_supplycost`<br>`WHERE`<br> `p_size = 15`<br> `AND p_type LIKE '%BRASS'`<br> `AND r_name = 'EUROPE'`<br>`ORDER BY`<br> `s_acctbal DESC,`<br> `n_name,`<br> `s_name,`<br> `p_partkey`<br>`LIMIT 100;`<br>`SELECT`<br> `'Original' AS query_variant,`<br> `COUNT(*) AS row_count`<br>`FROM q2_original_result`<br>`UNION ALL`<br>`SELECT`<br> `'Rewritten',`<br> `COUNT(*)`<br>`FROM q2_rewritten_result;`<br>`SELECT COUNT(*) AS original_minus_rewritten`<br>`FROM (`<br> `SELECT * FROM q2_original_result`<br> `EXCEPT ALL`<br> `SELECT * FROM q2_rewritten_result`<br>`) AS differences;`<br>`SELECT COUNT(*) AS rewritten_minus_original`<br>`FROM (`<br> `SELECT * FROM q2_rewritten_result`<br> `EXCEPT ALL`<br> `SELECT * FROM q2_original_result`<br>`) AS differences;`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Q17       | `WITH`<br>`original_result AS (`<br> `SELECT`<br> `SUM(l_extendedprice) / 7.0 AS avg_yearly`<br> `FROM lineitem, part`<br> `WHERE`<br> `p_partkey = l_partkey`<br> `AND p_brand = 'Brand#23'`<br> `AND p_container = 'MED BOX'`<br> `AND l_quantity < (`<br> `SELECT 0.2 * AVG(l_quantity)`<br> `FROM lineitem`<br> `WHERE l_partkey = p_partkey`<br> `)`<br>`),`<br>`rewritten_result AS (`<br> `WITH avg_quantity_by_part AS (`<br> `SELECT`<br> `l_partkey,`<br> `AVG(l_quantity) AS avg_quantity`<br> `FROM lineitem`<br> `GROUP BY l_partkey`<br> `)`<br> `SELECT`<br> `SUM(l.l_extendedprice) / 7.0 AS avg_yearly`<br> `FROM part p`<br> `JOIN lineitem l`<br> `ON p.p_partkey = l.l_partkey`<br> `JOIN avg_quantity_by_part aq`<br> `ON aq.l_partkey = p.p_partkey`<br> `WHERE`<br> `p.p_brand = 'Brand#23'`<br> `AND p.p_container = 'MED BOX'`<br> `AND l.l_quantity < 0.2 * aq.avg_quantity`<br>`)`<br>`SELECT`<br> `'Original EXCEPT ALL Rewritten' AS validation,`<br> `COUNT(*) AS difference_count`<br>`FROM (`<br> `SELECT * FROM original_result`<br> `EXCEPT ALL`<br> `SELECT * FROM rewritten_result`<br>`) d`<br>`UNION ALL`<br>`SELECT`<br> `'Rewritten EXCEPT ALL Original',`<br> `COUNT(*)`<br>`FROM (`<br> `SELECT * FROM rewritten_result`<br> `EXCEPT ALL`<br> `SELECT * FROM original_result`<br>`) d;`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Q20       | DROP TABLE IF EXISTS q20_original_result;<br><br>CREATE TEMP TABLE q20_original_result AS<br><br>SELECT<br><br>&nbsp; s_name,<br><br>&nbsp; s_address<br><br>FROM<br><br>&nbsp; supplier,<br><br>&nbsp; nation<br><br>WHERE<br><br>&nbsp; s_suppkey IN (<br><br>&nbsp; SELECT<br><br>&nbsp; ps_suppkey<br><br>&nbsp; FROM<br><br>&nbsp; partsupp<br><br>&nbsp; WHERE<br><br>&nbsp; ps_partkey IN (<br><br>&nbsp; SELECT<br><br>&nbsp; p_partkey<br><br>&nbsp; FROM<br><br>&nbsp; part<br><br>&nbsp; WHERE<br><br>&nbsp; p_name LIKE 'forest%'<br><br>&nbsp; )<br><br>&nbsp; AND ps_availqty > (<br><br>&nbsp; SELECT<br><br>&nbsp; 0.5 \* SUM(l_quantity)<br><br>&nbsp; FROM<br><br>&nbsp; lineitem<br><br>&nbsp; WHERE<br><br>&nbsp; l_partkey = ps_partkey<br><br>&nbsp; AND l_suppkey = ps_suppkey<br><br>&nbsp; AND l_shipdate >= DATE '1994-01-01'<br><br>&nbsp; AND l_shipdate < DATE '1995-01-01'<br><br>&nbsp; )<br><br>&nbsp; )<br><br>&nbsp; AND s_nationkey = n_nationkey<br><br>&nbsp; AND n_name = 'CANADA'<br><br>ORDER BY<br><br>&nbsp; s_name;<br><br>DROP TABLE IF EXISTS q20_rewritten_result;<br><br>CREATE TEMP TABLE q20_rewritten_result AS<br><br>WITH lineitem_quantity_by_partsupp AS (<br><br>&nbsp; SELECT<br><br>&nbsp; l_partkey,<br><br>&nbsp; l_suppkey,<br><br>&nbsp; SUM(l_quantity) AS total_quantity<br><br>&nbsp; FROM<br><br>&nbsp; lineitem<br><br>&nbsp; WHERE<br><br>&nbsp; l_shipdate >= DATE '1994-01-01'<br><br>&nbsp; AND l_shipdate < DATE '1995-01-01'<br><br>&nbsp; GROUP BY<br><br>&nbsp; l_partkey,<br><br>&nbsp; l_suppkey<br><br>),<br><br>qualifying_suppliers AS (<br><br>&nbsp; SELECT DISTINCT<br><br>&nbsp; ps.ps_suppkey<br><br>&nbsp; FROM<br><br>&nbsp; partsupp ps<br><br>&nbsp; JOIN part p<br><br>&nbsp; ON p.p_partkey = ps.ps_partkey<br><br>&nbsp; JOIN lineitem_quantity_by_partsupp lq<br><br>&nbsp; ON lq.l_partkey = ps.ps_partkey<br><br>&nbsp; AND lq.l_suppkey = ps.ps_suppkey<br><br>&nbsp; WHERE<br><br>&nbsp; p.p_name LIKE 'forest%'<br><br>&nbsp; AND ps.ps_availqty > 0.5 \* lq.total_quantity<br><br>)<br><br>SELECT<br><br>&nbsp; s.s_name,<br><br>&nbsp; s.s_address<br><br>FROM<br><br>&nbsp; supplier s<br><br>JOIN nation n<br><br>&nbsp; ON s.s_nationkey = n.n_nationkey<br><br>JOIN qualifying_suppliers qs<br><br>&nbsp; ON qs.ps_suppkey = s.s_suppkey<br><br>WHERE<br><br>&nbsp; n.n_name = 'CANADA'<br><br>ORDER BY<br><br>&nbsp; s.s_name;<br><br>SELECT<br><br>&nbsp; 'Original row count' AS validation_check,<br><br>&nbsp; COUNT(\*) AS actual<br><br>FROM q20_original_result<br><br>UNION ALL<br><br>SELECT<br><br>&nbsp; 'Rewritten row count',<br><br>&nbsp; COUNT(\*)<br><br>FROM q20_rewritten_result;<br><br>SELECT<br><br>&nbsp; 'Original EXCEPT ALL Rewritten' AS validation_check,<br><br>&nbsp; COUNT(\*) AS difference_count<br><br>FROM (<br><br>&nbsp; SELECT \* FROM q20_original_result<br><br>&nbsp; EXCEPT ALL<br><br>&nbsp; SELECT \* FROM q20_rewritten_result<br><br>) AS differences;<br><br>SELECT<br><br>&nbsp; 'Rewritten EXCEPT ALL Original' AS validation_check,<br><br>&nbsp; COUNT(\*) AS difference_count<br><br>FROM (<br><br>&nbsp; SELECT \* FROM q20_rewritten_result<br><br>&nbsp; EXCEPT ALL<br><br>&nbsp; SELECT \* FROM q20_original_result<br><br>) AS differences;<br><br>SELECT<br><br>&nbsp; CASE<br><br>&nbsp; WHEN<br><br>&nbsp; (SELECT COUNT(\*) FROM (<br><br>&nbsp; SELECT \* FROM q20_original_result<br><br>&nbsp; EXCEPT ALL<br><br>&nbsp; SELECT \* FROM q20_rewritten_result<br><br>&nbsp; ) AS diff1) = 0<br><br>&nbsp; AND<br><br>&nbsp; (SELECT COUNT(\*) FROM (<br><br>&nbsp; SELECT \* FROM q20_rewritten_result<br><br>&nbsp; EXCEPT ALL<br><br>&nbsp; SELECT \* FROM q20_original_result<br><br>&nbsp; ) AS diff2) = 0<br><br>&nbsp; THEN 'PASS'<br><br>&nbsp; ELSE 'FAIL'<br><br>&nbsp; END AS equivalence_status; |

**Lampiran C.5 Laporan Validasi Query Original dan Rewriting**

Tabel C.5 Ringkasan Laporan Validasi Ekuivalensi SQL Original dan SQL Rewritten

| **Query** | **Laporan**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q2        | `# Q2 SQL Equivalence Validation Report`<br>`## 1. Informasi Pengujian`<br>`- Query: TPC-H Q2 (Minimum Cost Supplier)`<br>`- DBMS: PostgreSQL 18.6`<br>`- Database: tpch_sf1`<br>`- Scale Factor: SF1`<br>`- Index Configuration: I0 (Primary Key indexes only)`<br>`- Parameter:`<br>`- SIZE = 15`<br>`- TYPE = BRASS`<br>`- REGION = EUROPE`<br>`- Validation Method: Bidirectional EXCEPT ALL`<br>`- Validation Date: 2026-11-12 01:46`<br>`## 2. SQL yang Dibandingkan`<br>`` - Original: `sql/queries/original/Q2_original.sql` ``<br>`` - Rewritten: `sql/queries/rewritten/Q2_rewritten.sql` ``<br>`` - Validation Script: `sql/validation/validate_q2_equivalence.sql` ``<br>`## 3. Hasil Pengujian`<br>`\| Validation Check \| Expected \| Actual \| Status \|`<br>`\|---\|---:\|---:\|---\|`<br>`\| Original row count \| 100 \| 100 \| PASS \|`<br>`\| Rewritten row count \| 100 \| 100 \| PASS \|`<br>`\| Original EXCEPT ALL Rewritten \| 0 \| 0 \| PASS \|`<br>`\| Rewritten EXCEPT ALL Original \| 0 \| 0 \| PASS \|`<br>`## 4. Kesimpulan`<br>`Pengujian menunjukkan bahwa hasil query Q2 Original dan Q2 Rewritten memiliki kesetaraan multiset pada dataset SF1 dengan konfigurasi I0 dan parameter validasi yang ditetapkan. Tidak ditemukan baris yang hanya muncul pada salah satu hasil query.`<br>`Status: PASS`<br>`## 5. Catatan`<br>`Validasi ini merupakan pemeriksaan kesetaraan hasil pada kondisi pengujian yang ditetapkan. Hasil ini belum menjadi bukti kesetaraan untuk seluruh kemungkinan kondisi data dan belum merupakan pengukuran performa query.`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Q17       | `# Q17 SQL Equivalence Validation Report`<br>`## 1. Informasi Pengujian`<br>`- Query: TPC-H Q17 (Small-Quantity-Order Revenue)`<br>`- DBMS: PostgreSQL 18.6`<br>`` - Database: `tpch_sf01` ``<br>`- Scale Factor: SF0.1`<br>`- Index Configuration: I0 (Primary Key indexes only)`<br>`- Parameter:`<br>`- BRAND = Brand#23`<br>`- CONTAINER = MED BOX`<br>`` - Validation Method: Bidirectional `EXCEPT ALL` ``<br>`- Validation Date: 2026-11-12`<br>`## 2. SQL yang Dibandingkan`<br>`` - Original: `sql/queries/original/Q17_original.sql` ``<br>`` - Rewritten: `sql/queries/rewritten/Q17_rewritten.sql` ``<br>`` - Validation Script: `sql/validation/validate_q17_equivalence.sql` ``<br>`## 3. Hasil Pengujian`<br>`\| Validation Check \| Expected \| Actual \| Status \|`<br>`\|---\|---:\|---:\|---\|`<br>`\| Original row count \| 1 \| 1 \| PASS \|`<br>`\| Rewritten row count \| 1 \| 1 \| PASS \|`<br>`\| Original result \| 23512.752857142857 \| 23512.752857142857 \| PASS \|`<br>`\| Rewritten result \| 23512.752857142857 \| 23512.752857142857 \| PASS \|`<br>`\| Original EXCEPT ALL Rewritten \| 0 \| 0 \| PASS \|`<br>`\| Rewritten EXCEPT ALL Original \| 0 \| 0 \| PASS \|`<br>`## 4. Kesimpulan`<br>`Pengujian menunjukkan bahwa hasil query Q17 Original dan Q17 Rewritten memiliki kesetaraan multiset (*multiset equivalence*) pada dataset SF0.1 dengan konfigurasi I0 dan parameter validasi yang ditetapkan.`<br>``Kedua query menghasilkan satu baris dengan nilai `avg_yearly` yang identik, yaitu `23512.752857142857`. Pemeriksaan dua arah menggunakan `EXCEPT ALL` juga menghasilkan 0 baris pada kedua arah perbandingan. Dengan demikian, tidak ditemukan perbedaan hasil antara query Original dan Rewritten pada kondisi pengujian ini.``<br>`**Status: PASS**`<br>`## 5. Catatan`<br>`Validasi ini merupakan pemeriksaan kesetaraan hasil query pada dataset SF0.1 yang digunakan sebagai dataset pendukung untuk pengujian teknis transformasi SQL.`<br>`Hasil ini belum menjadi bukti kesetaraan untuk seluruh kemungkinan kondisi data dan belum merupakan pengukuran performa query. Dataset SF0.1 juga tidak menggantikan dataset utama penelitian, yaitu SF1 dan SF10. Validasi pada dataset utama tetap diperlukan sesuai tahapan validasi penelitian.` |
| Q20       | `# Q20 SQL Equivalence Validation Report`<br>`## 1. Informasi Pengujian`<br>`- Query: TPC-H Q20 (Potential Part Promotion)`<br>`- DBMS: PostgreSQL 18.6`<br>`` - Database: `tpch_sf01` ``<br>`- Scale Factor: SF0.1`<br>`- Index Configuration: I0 (Primary Key indexes only)`<br>`- Parameter:`<br>`- COLOR = forest`<br>`- DATE = 1994-01-01`<br>`- NATION = CANADA`<br>`` - Validation Method: Bidirectional `EXCEPT ALL` ``<br>`- Validation Date: 2026-11-12`<br>`## 2. SQL yang Dibandingkan`<br>`` - Original: `sql/queries/original/q20_original.sql` ``<br>`` - Rewritten: `sql/queries/rewritten/q20_rewritten.sql` ``<br>`` - Validation Script: `sql/validation/validate_q20_equivalence.sql` ``<br>`## 3. Hasil Pengujian`<br>`\| Validation Check \| Expected \| Actual \| Status \|`<br>`\|---\|---:\|---:\|---\|`<br>`\| Original row count \| 9 \| 9 \| PASS \|`<br>`\| Rewritten row count \| 9 \| 9 \| PASS \|`<br>`\| Original EXCEPT ALL Rewritten \| 0 \| 0 \| PASS \|`<br>`\| Rewritten EXCEPT ALL Original \| 0 \| 0 \| PASS \|`<br>`## 4. Kesimpulan`<br>`Pengujian menunjukkan bahwa hasil query Q20 Original dan Q20 Rewritten memiliki kesetaraan multiset (*multiset equivalence*) pada dataset SF0.1 dengan konfigurasi I0 dan parameter validasi yang ditetapkan.`<br>``Kedua query menghasilkan 9 baris data dengan struktur hasil yang sama, yaitu kolom `s_name` dan `s_address`. Pemeriksaan dua arah menggunakan `EXCEPT ALL` menghasilkan 0 baris pada kedua arah perbandingan. Dengan demikian, tidak ditemukan perbedaan hasil antara query Original dan Rewritten pada kondisi pengujian ini.``<br>`**Status: PASS**`<br>`## 5. Catatan`<br>`Validasi ini merupakan pemeriksaan kesetaraan hasil query pada dataset SF0.1 yang digunakan sebagai dataset pendukung untuk pengujian teknis transformasi SQL.`<br>`Hasil ini belum menjadi bukti kesetaraan untuk seluruh kemungkinan kondisi data dan belum merupakan pengukuran performa query. Dataset SF0.1 juga tidak menggantikan dataset utama penelitian, yaitu SF1 dan SF10. Validasi pada dataset utama tetap diperlukan sesuai tahapan validasi penelitian.`                                                                                                                                                 |

Lampiran D

**Protokol Eksperimen dan Bukti Eksekusi Skrip**

Lampiran E

**Bukti Pilot, Perhitungan, Klasifikasi, dan Pengendalian Validitas**