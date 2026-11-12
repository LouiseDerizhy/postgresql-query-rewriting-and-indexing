-- ============================================================
-- TPC-H Q17 SQL Equivalence Validation
-- Method: Bidirectional EXCEPT ALL
-- DBMS: PostgreSQL 18.6
-- Database: tpch_sf01
-- Scale Factor: SF0.1
-- Index Configuration: I0
-- ============================================================

WITH
original_result AS (
    SELECT
        SUM(l_extendedprice) / 7.0 AS avg_yearly
    FROM lineitem, part
    WHERE
        p_partkey = l_partkey
        AND p_brand = 'Brand#23'
        AND p_container = 'MED BOX'
        AND l_quantity < (
            SELECT 0.2 * AVG(l_quantity)
            FROM lineitem
            WHERE l_partkey = p_partkey
        )
),
rewritten_result AS (
    WITH avg_quantity_by_part AS (
        SELECT
            l_partkey,
            AVG(l_quantity) AS avg_quantity
        FROM lineitem
        GROUP BY l_partkey
    )
    SELECT
        SUM(l.l_extendedprice) / 7.0 AS avg_yearly
    FROM part p
    JOIN lineitem l
        ON p.p_partkey = l.l_partkey
    JOIN avg_quantity_by_part aq
        ON aq.l_partkey = p.p_partkey
    WHERE
        p.p_brand = 'Brand#23'
        AND p.p_container = 'MED BOX'
        AND l.l_quantity < 0.2 * aq.avg_quantity
)
SELECT
    'Original EXCEPT ALL Rewritten' AS validation,
    COUNT(*) AS difference_count
FROM (
    SELECT * FROM original_result
    EXCEPT ALL
    SELECT * FROM rewritten_result
) d

UNION ALL

SELECT
    'Rewritten EXCEPT ALL Original',
    COUNT(*)
FROM (
    SELECT * FROM rewritten_result
    EXCEPT ALL
    SELECT * FROM original_result
) d;