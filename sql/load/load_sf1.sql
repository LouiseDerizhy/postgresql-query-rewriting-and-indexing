
\set ON_ERROR_STOP on

BEGIN;

-- Tambahkan kolom sementara untuk menampung field kosong terakhir
ALTER TABLE region ADD COLUMN dbgen_extra TEXT;
ALTER TABLE nation ADD COLUMN dbgen_extra TEXT;
ALTER TABLE part ADD COLUMN dbgen_extra TEXT;
ALTER TABLE supplier ADD COLUMN dbgen_extra TEXT;
ALTER TABLE partsupp ADD COLUMN dbgen_extra TEXT;
ALTER TABLE customer ADD COLUMN dbgen_extra TEXT;
ALTER TABLE orders ADD COLUMN dbgen_extra TEXT;
ALTER TABLE lineitem ADD COLUMN dbgen_extra TEXT;

-- Load data SF1
\copy region FROM 'C:/Coding/thesis/dataset/SF1/region.tbl' WITH (FORMAT text, DELIMITER '|')
\copy nation FROM 'C:/Coding/thesis/dataset/SF1/nation.tbl' WITH (FORMAT text, DELIMITER '|')
\copy part FROM 'C:/Coding/thesis/dataset/SF1/part.tbl' WITH (FORMAT text, DELIMITER '|')
\copy supplier FROM 'C:/Coding/thesis/dataset/SF1/supplier.tbl' WITH (FORMAT text, DELIMITER '|')
\copy partsupp FROM 'C:/Coding/thesis/dataset/SF1/partsupp.tbl' WITH (FORMAT text, DELIMITER '|')
\copy customer FROM 'C:/Coding/thesis/dataset/SF1/customer.tbl' WITH (FORMAT text, DELIMITER '|')
\copy orders FROM 'C:/Coding/thesis/dataset/SF1/orders.tbl' WITH (FORMAT text, DELIMITER '|')
\copy lineitem FROM 'C:/Coding/thesis/dataset/SF1/lineitem.tbl' WITH (FORMAT text, DELIMITER '|')

-- Hapus kolom sementara
ALTER TABLE region DROP COLUMN dbgen_extra;
ALTER TABLE nation DROP COLUMN dbgen_extra;
ALTER TABLE part DROP COLUMN dbgen_extra;
ALTER TABLE supplier DROP COLUMN dbgen_extra;
ALTER TABLE partsupp DROP COLUMN dbgen_extra;
ALTER TABLE customer DROP COLUMN dbgen_extra;
ALTER TABLE orders DROP COLUMN dbgen_extra;
ALTER TABLE lineitem DROP COLUMN dbgen_extra;

COMMIT;
