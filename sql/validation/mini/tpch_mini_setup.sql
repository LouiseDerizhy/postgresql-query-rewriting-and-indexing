-- tpch_mini_setup.sql
-- G1 Lapis 1: basis data mini dengan kasus batas untuk Q2, Q17, Q20 (parameter validasi set 1).
-- Jalankan:  psql -U postgres -d postgres -f tpch_mini_setup.sql
-- Skema, PK, dan FK identik dengan Lampiran A.2 dan A.3 (FK ditambahkan setelah data dimuat).
\set ON_ERROR_STOP on

DROP DATABASE IF EXISTS tpch_mini;
CREATE DATABASE tpch_mini TEMPLATE template0 ENCODING 'UTF8'
    LOCALE_PROVIDER libc LC_COLLATE 'C' LC_CTYPE 'C';
\c tpch_mini

-- ===== Skema (Lampiran A.2) =====
CREATE TABLE region (
    r_regionkey INTEGER NOT NULL, r_name CHAR(25) NOT NULL, r_comment VARCHAR(152));
CREATE TABLE nation (
    n_nationkey INTEGER NOT NULL, n_name CHAR(25) NOT NULL, n_regionkey INTEGER NOT NULL,
    n_comment VARCHAR(152));
CREATE TABLE part (
    p_partkey INTEGER NOT NULL, p_name VARCHAR(55) NOT NULL, p_mfgr CHAR(25) NOT NULL,
    p_brand CHAR(10) NOT NULL, p_type VARCHAR(25) NOT NULL, p_size INTEGER NOT NULL,
    p_container CHAR(10) NOT NULL, p_retailprice NUMERIC(15,2) NOT NULL,
    p_comment VARCHAR(23) NOT NULL);
CREATE TABLE supplier (
    s_suppkey INTEGER NOT NULL, s_name CHAR(25) NOT NULL, s_address VARCHAR(40) NOT NULL,
    s_nationkey INTEGER NOT NULL, s_phone CHAR(15) NOT NULL, s_acctbal NUMERIC(15,2) NOT NULL,
    s_comment VARCHAR(101) NOT NULL);
CREATE TABLE partsupp (
    ps_partkey INTEGER NOT NULL, ps_suppkey INTEGER NOT NULL, ps_availqty INTEGER NOT NULL,
    ps_supplycost NUMERIC(15,2) NOT NULL, ps_comment VARCHAR(199) NOT NULL);
CREATE TABLE customer (
    c_custkey INTEGER NOT NULL, c_name VARCHAR(25) NOT NULL, c_address VARCHAR(40) NOT NULL,
    c_nationkey INTEGER NOT NULL, c_phone CHAR(15) NOT NULL, c_acctbal NUMERIC(15,2) NOT NULL,
    c_mktsegment CHAR(10) NOT NULL, c_comment VARCHAR(117) NOT NULL);
CREATE TABLE orders (
    o_orderkey INTEGER NOT NULL, o_custkey INTEGER NOT NULL, o_orderstatus CHAR(1) NOT NULL,
    o_totalprice NUMERIC(15,2) NOT NULL, o_orderdate DATE NOT NULL, o_orderpriority CHAR(15) NOT NULL,
    o_clerk CHAR(15) NOT NULL, o_shippriority INTEGER NOT NULL, o_comment VARCHAR(79) NOT NULL);
CREATE TABLE lineitem (
    l_orderkey INTEGER NOT NULL, l_partkey INTEGER NOT NULL, l_suppkey INTEGER NOT NULL,
    l_linenumber INTEGER NOT NULL, l_quantity NUMERIC(15,2) NOT NULL,
    l_extendedprice NUMERIC(15,2) NOT NULL, l_discount NUMERIC(15,2) NOT NULL,
    l_tax NUMERIC(15,2) NOT NULL, l_returnflag CHAR(1) NOT NULL, l_linestatus CHAR(1) NOT NULL,
    l_shipdate DATE NOT NULL, l_commitdate DATE NOT NULL, l_receiptdate DATE NOT NULL,
    l_shipinstruct CHAR(25) NOT NULL, l_shipmode CHAR(10) NOT NULL, l_comment VARCHAR(44) NOT NULL);

ALTER TABLE region   ADD CONSTRAINT pk_region   PRIMARY KEY (r_regionkey);
ALTER TABLE nation   ADD CONSTRAINT pk_nation   PRIMARY KEY (n_nationkey);
ALTER TABLE part     ADD CONSTRAINT pk_part     PRIMARY KEY (p_partkey);
ALTER TABLE supplier ADD CONSTRAINT pk_supplier PRIMARY KEY (s_suppkey);
ALTER TABLE partsupp ADD CONSTRAINT pk_partsupp PRIMARY KEY (ps_partkey, ps_suppkey);
ALTER TABLE customer ADD CONSTRAINT pk_customer PRIMARY KEY (c_custkey);
ALTER TABLE orders   ADD CONSTRAINT pk_orders   PRIMARY KEY (o_orderkey);
ALTER TABLE lineitem ADD CONSTRAINT pk_lineitem PRIMARY KEY (l_orderkey, l_linenumber);

-- ===== Data buatan =====
INSERT INTO region (r_regionkey, r_name, r_comment) VALUES
 (0,'AFRICA','mini'), (1,'AMERICA','mini'), (2,'ASIA','mini'), (3,'EUROPE','mini'), (4,'MIDDLE EAST','mini');

INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment) VALUES
 (3,'CANADA',1,'mini'), (6,'FRANCE',3,'mini'), (7,'GERMANY',3,'mini'), (8,'INDIA',2,'mini');

-- Pemasok: S1 FRANCE, S2 GERMANY, S3 CANADA, S4 CANADA, S5 GERMANY
INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) VALUES
 (1,'Supplier#1','addr1',6,'00-000-000-0001',100.00,'mini'),
 (2,'Supplier#2','addr2',7,'00-000-000-0002',200.00,'mini'),
 (3,'Supplier#3','addr3',3,'00-000-000-0003',300.00,'mini'),
 (4,'Supplier#4','addr4',3,'00-000-000-0004',400.00,'mini'),
 (5,'Supplier#5','addr5',7,'00-000-000-0005',500.00,'mini');

-- Part 1,2,7 = kasus Q2 | Part 3,4,9 = kasus Q17 | Part 5,6,10 = kasus Q20
INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) VALUES
 (1,'alpha part',  'Manufacturer#1','Brand#11','STANDARD POLISHED BRASS',15,'SM CASE', 901.00,'mini'),
 (2,'beta part',   'Manufacturer#1','Brand#12','SMALL PLATED BRASS',     15,'SM CASE', 902.00,'mini'),
 (3,'gamma part',  'Manufacturer#1','Brand#23','ECONOMY ANODIZED STEEL',  5,'MED BOX', 903.00,'mini'),
 (4,'delta part',  'Manufacturer#1','Brand#23','ECONOMY BURNISHED TIN',   5,'MED BOX', 904.00,'mini'),
 (5,'forest green','Manufacturer#2','Brand#34','PROMO BRUSHED COPPER',   20,'LG PACK', 905.00,'mini'),
 (6,'forest red',  'Manufacturer#2','Brand#34','PROMO BRUSHED NICKEL',   21,'LG PACK', 906.00,'mini'),
 (7,'epsilon part','Manufacturer#1','Brand#15','LARGE BRUSHED BRASS',    15,'JUMBO JAR',907.00,'mini'),
 (9,'zeta part',   'Manufacturer#1','Brand#23','ECONOMY PLATED TIN',      5,'MED BAG', 909.00,'mini'),
 (10,'dark forest','Manufacturer#2','Brand#34','PROMO BRUSHED STEEL',    22,'LG PACK', 910.00,'mini');

INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) VALUES
 -- Q2: part 1 biaya minimum seri (S1 dan S2 = 10.00; S5 = 25.00)
 (1,1,100,10.00,'mini'), (1,2,100,10.00,'mini'), (1,5,100,25.00,'mini'),
 -- Q2: part 2 hanya punya pemasok CANADA (tidak ada pemasok di EUROPE)
 (2,3,100,12.00,'mini'),
 -- Q2: part 7, biaya terendah dipegang pemasok CANADA (5.00) tetapi minimum EUROPE = 30.00
 (7,1,100,30.00,'mini'), (7,3,100,5.00,'mini'),
 -- Q17
 (3,1,100,9.00,'mini'), (4,1,100,8.00,'mini'), (9,2,100,7.00,'mini'),
 -- Q20
 (5,1,1000,40.00,'mini'), (5,3,1000,40.00,'mini'), (5,4,1000,40.00,'mini'),
 (6,3,100,41.00,'mini'),  (6,4,1000,41.00,'mini'),
 (10,3,1000,42.00,'mini');

INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) VALUES
 (1,'Customer#1','addr',3,'00-000-000-0001',0.00,'BUILDING','mini');
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority,
                    o_clerk, o_shippriority, o_comment) VALUES
 (1,1,'O',0.00,DATE '1993-01-01','1-URGENT','Clerk#000000001',0,'mini');

-- Lineitem (ord, partkey, suppkey, qty, price, shipdate)
INSERT INTO lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice,
                      l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate,
                      l_receiptdate, l_shipinstruct, l_shipmode, l_comment)
SELECT 1, v.pk, v.sk, row_number() OVER (ORDER BY v.ord), v.q, v.price, 0.00, 0.00, 'N', 'O',
       v.sd, v.sd, v.sd, 'NONE', 'AIR', 'mini'
FROM (VALUES
 -- Q17: part 4 (Brand#23 MED BOX): qty 1,2,3,4,5,50 -> 0.2*avg = 2.1667 -> hanya qty 1 dan 2 lolos
 ( 1, 4, 1,    1.00,   100.00, DATE '1993-01-01'),
 ( 2, 4, 1,    2.00,   200.00, DATE '1993-01-01'),
 ( 3, 4, 1,    3.00,   300.00, DATE '1993-01-01'),
 ( 4, 4, 1,    4.00,   400.00, DATE '1993-01-01'),
 ( 5, 4, 1,    5.00,   500.00, DATE '1993-01-01'),
 ( 6, 4, 1,   50.00,  5000.00, DATE '1993-01-01'),
 -- Q17: part 9 (container MED BAG) harus tereliminasi oleh filter container
 ( 7, 9, 2,    1.00,   100.00, DATE '1993-01-01'),
 -- Q20: (5,3) total 1994 = 100; (6,3) total 1994 = 100 -> S3 lolos lewat DUA pasangan partsupp
 ( 8, 5, 3,   60.00,   600.00, DATE '1994-03-15'),
 ( 9, 5, 3,   40.00,   400.00, DATE '1994-06-20'),
 (10, 6, 3,  100.00,  1000.00, DATE '1994-07-01'),
 -- Q20: batas tanggal. 1994-01-01 masuk; 1995-01-01 tidak masuk
 --      (kalau 1995-01-01 ikut terhitung, total 5100 dan S4 gagal)
 (11, 5, 4,  100.00,  1000.00, DATE '1994-01-01'),
 (12, 5, 4, 5000.00, 50000.00, DATE '1995-01-01'),
 -- Q20: (6,4) tidak punya lineitem pada rentang 1994 -> SUM NULL -> tidak lolos
 (13, 6, 4,   10.00,   100.00, DATE '1995-02-02'),
 -- Q20: lolos syarat kuantitas tetapi pemasok FRANCE -> tereliminasi filter nation
 (14, 5, 1,   20.00,   200.00, DATE '1994-05-05'),
 -- Q20: nama part tidak berawalan 'forest' -> tereliminasi
 (15,10, 3,   10.00,   100.00, DATE '1994-04-04')
) AS v(ord, pk, sk, q, price, sd);

-- ===== FK ditambahkan setelah pemuatan (Lampiran A.3) =====
ALTER TABLE nation   ADD CONSTRAINT fk_nation_region     FOREIGN KEY (n_regionkey) REFERENCES region (r_regionkey);
ALTER TABLE supplier ADD CONSTRAINT fk_supplier_nation   FOREIGN KEY (s_nationkey) REFERENCES nation (n_nationkey);
ALTER TABLE partsupp ADD CONSTRAINT fk_partsupp_part     FOREIGN KEY (ps_partkey)  REFERENCES part (p_partkey);
ALTER TABLE partsupp ADD CONSTRAINT fk_partsupp_supplier FOREIGN KEY (ps_suppkey)  REFERENCES supplier (s_suppkey);
ALTER TABLE customer ADD CONSTRAINT fk_customer_nation   FOREIGN KEY (c_nationkey) REFERENCES nation (n_nationkey);
ALTER TABLE orders   ADD CONSTRAINT fk_orders_customer   FOREIGN KEY (o_custkey)   REFERENCES customer (c_custkey);
ALTER TABLE lineitem ADD CONSTRAINT fk_lineitem_orders   FOREIGN KEY (l_orderkey)  REFERENCES orders (o_orderkey);
ALTER TABLE lineitem ADD CONSTRAINT fk_lineitem_partsupp FOREIGN KEY (l_partkey, l_suppkey) REFERENCES partsupp (ps_partkey, ps_suppkey);
ALTER TABLE lineitem ADD CONSTRAINT fk_lineitem_part     FOREIGN KEY (l_partkey)   REFERENCES part (p_partkey);
ALTER TABLE lineitem ADD CONSTRAINT fk_lineitem_supplier FOREIGN KEY (l_suppkey)   REFERENCES supplier (s_suppkey);

VACUUM (ANALYZE);

-- ===== Pemeriksaan jumlah constraint dan baris =====
SELECT contype, count(*) FROM pg_constraint
 WHERE connamespace = 'public'::regnamespace AND contype IN ('p','f') GROUP BY contype ORDER BY contype;
SELECT 'lineitem' AS tabel, count(*) FROM lineitem
UNION ALL SELECT 'partsupp', count(*) FROM partsupp
UNION ALL SELECT 'part', count(*) FROM part;

-- ===== HASIL YANG DIHARAPKAN (dihitung manual, bebas dari O dan R) =====
-- Q2  : 3 baris -> (Supplier#2, part 1), (Supplier#1, part 1), (Supplier#1, part 7)
--       urutan s_acctbal DESC: Supplier#2 (200) dahulu, lalu Supplier#1 (100) untuk part 1 dan part 7.
--       Part 2 tidak muncul. Pasangan (part 1, Supplier#5, 25.00) tidak muncul.
-- Q17 : 1 baris, avg_yearly = (100.00 + 200.00) / 7.0 = 42.857142857142857...
-- Q20 : 2 baris -> Supplier#3 (satu kali saja), Supplier#4
-- Uji kosong (--empty): Q2 dan Q20 nol baris; Q17 satu baris bernilai NULL.