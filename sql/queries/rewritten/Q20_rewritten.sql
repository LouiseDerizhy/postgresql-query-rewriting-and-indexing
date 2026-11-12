
-- ============================================================
-- TPC-H Q20: Potential Part Promotion
-- Variant: Rewritten (R)
-- Reference: TPC-H 3.0.1, Clause 2.4.20
-- DBMS: PostgreSQL 18.6
--
-- Fixed validation parameters:
-- COLOR   = forest
-- DATE    = 1994-01-01
-- NATION  = CANADA
-- ============================================================

WITH lineitem_quantity_by_partsupp AS (
    SELECT
        l_partkey,
        l_suppkey,
        SUM(l_quantity) AS total_quantity
    FROM
        lineitem
    WHERE
        l_shipdate >= DATE '1994-01-01'
        AND l_shipdate < DATE '1995-01-01'
    GROUP BY
        l_partkey,
        l_suppkey
),
qualifying_suppliers AS (
    SELECT DISTINCT
        ps.ps_suppkey
    FROM
        partsupp ps
    JOIN part p
        ON p.p_partkey = ps.ps_partkey
    JOIN lineitem_quantity_by_partsupp lq
        ON lq.l_partkey = ps.ps_partkey
        AND lq.l_suppkey = ps.ps_suppkey
    WHERE
        p.p_name LIKE 'forest%'
        AND ps.ps_availqty > 0.5 * lq.total_quantity
)
SELECT
    s.s_name,
    s.s_address
FROM
    supplier s
JOIN nation n
    ON s.s_nationkey = n.n_nationkey
JOIN qualifying_suppliers qs
    ON qs.ps_suppkey = s.s_suppkey
WHERE
    n.n_name = 'CANADA'
ORDER BY
    s.s_name;
