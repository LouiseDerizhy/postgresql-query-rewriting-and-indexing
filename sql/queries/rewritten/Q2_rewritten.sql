
-- ============================================================
-- TPC-H Q2: Minimum Cost Supplier
-- Variant: Rewritten (R)
-- Reference: TPC-H 3.0.1, Clause 2.4.2
-- DBMS: PostgreSQL 18.6
--
-- Fixed validation parameters:
-- SIZE   = 15
-- TYPE   = BRASS
-- REGION = EUROPE
-- ============================================================

WITH min_supply_cost AS (
    SELECT
        ps_partkey,
        MIN(ps_supplycost) AS min_supplycost
    FROM
        partsupp
    JOIN supplier
        ON s_suppkey = ps_suppkey
    JOIN nation
        ON s_nationkey = n_nationkey
    JOIN region
        ON n_regionkey = r_regionkey
    WHERE
        r_name = 'EUROPE'
    GROUP BY
        ps_partkey
)
SELECT
    s_acctbal,
    s_name,
    n_name,
    p_partkey,
    p_mfgr,
    s_address,
    s_phone,
    s_comment
FROM
    part
JOIN partsupp
    ON p_partkey = ps_partkey
JOIN supplier
    ON s_suppkey = ps_suppkey
JOIN nation
    ON s_nationkey = n_nationkey
JOIN region
    ON n_regionkey = r_regionkey
JOIN min_supply_cost
    ON min_supply_cost.ps_partkey = p_partkey
    AND ps_supplycost = min_supply_cost.min_supplycost
WHERE
    p_size = 15
    AND p_type LIKE '%BRASS'
    AND r_name = 'EUROPE'
ORDER BY
    s_acctbal DESC,
    n_name,
    s_name,
    p_partkey
LIMIT 100;
