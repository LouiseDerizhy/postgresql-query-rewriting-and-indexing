
-- ============================================================
-- TPC-H 3.0.1
-- PostgreSQL 18.6
-- Primary Key and Foreign Key Constraints
--
-- Execute AFTER loading all eight TPC-H tables.
-- Primary keys create their corresponding unique B-tree indexes.
-- ============================================================

-- PRIMARY KEYS

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


-- FOREIGN KEYS

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