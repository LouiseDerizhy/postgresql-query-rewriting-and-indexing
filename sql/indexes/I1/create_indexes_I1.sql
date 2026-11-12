-- B.2 CREATE INDEX CONFIGURATION I1
-- Prasyarat: konfigurasi I0 telah tersedia.
-- Hasil yang diharapkan: 13 indeks.

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