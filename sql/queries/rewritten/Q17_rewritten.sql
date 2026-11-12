-- ============================================================
-- TPC-H Q17: Small-Quantity-Order Revenue
-- Variant: Rewritten (R)
-- Reference: TPC-H 3.0.1, Clause 2.4.17
-- DBMS: PostgreSQL 18.6
--
-- Fixed validation parameters:
-- BRAND     = Brand#23
-- CONTAINER = MED BOX
--
-- Rewrite strategy:
-- Correlated scalar subquery -> Pre-aggregation + JOIN
-- ============================================================

WITH avg_quantity_by_part AS (
    SELECT
        l_partkey,
        AVG(l_quantity) AS avg_quantity
    FROM
        lineitem
    GROUP BY
        l_partkey
)
SELECT
    SUM(l.l_extendedprice) / 7.0 AS avg_yearly
FROM
    part p
JOIN lineitem l
    ON p.p_partkey = l.l_partkey
JOIN avg_quantity_by_part aq
    ON aq.l_partkey = p.p_partkey
WHERE
    p.p_brand = 'Brand#23'
    AND p.p_container = 'MED BOX'
    AND l.l_quantity < 0.2 * aq.avg_quantity;