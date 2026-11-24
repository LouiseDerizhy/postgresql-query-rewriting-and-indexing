-- B.3 CREATE INDEX CONFIGURATION I2
-- Prasyarat: konfigurasi I1 telah tersedia.
-- Hasil yang diharapkan: 18 indeks.

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

CREATE INDEX ix2_partsupp_cover
ON public.partsupp USING btree
    (ps_partkey)
INCLUDE (ps_suppkey, ps_supplycost, ps_availqty);