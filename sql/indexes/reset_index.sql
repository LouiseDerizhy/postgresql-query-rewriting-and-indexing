-- B.4 RESET INDEX CONFIGURATION TO I0
-- Menghapus seluruh indeks tambahan I1 dan I2.
-- Indeks primary key tidak dihapus.

-- Hapus indeks tambahan I2
DROP INDEX IF EXISTS public.ix2_lineitem_ps_cover;
DROP INDEX IF EXISTS public.ix2_part_brand_container;
DROP INDEX IF EXISTS public.ix2_part_size;
DROP INDEX IF EXISTS public.ix2_partsupp_cover;

-- Hapus indeks tambahan I1
DROP INDEX IF EXISTS public.ix1_nation_regionkey;
DROP INDEX IF EXISTS public.ix1_supplier_nationkey;
DROP INDEX IF EXISTS public.ix1_partsupp_suppkey;
DROP INDEX IF EXISTS public.ix1_lineitem_partkey;
DROP INDEX IF EXISTS public.ix1_lineitem_suppkey;