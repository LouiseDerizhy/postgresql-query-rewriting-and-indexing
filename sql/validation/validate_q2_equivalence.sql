
-- ============================================================
-- Q2 SEMANTIC EQUIVALENCE VALIDATION
-- Database: tpch_sf1
-- Configuration: I0
-- Comparison: EXCEPT ALL, both directions
-- ============================================================

CREATE TEMP TABLE q2_original_result AS
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
    part,
    supplier,
    partsupp,
    nation,
    region
WHERE
    p_partkey = ps_partkey
    AND s_suppkey = ps_suppkey
    AND p_size = 15
    AND p_type LIKE '%BRASS'
    AND s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = 'EUROPE'
    AND ps_supplycost = (
        SELECT
            MIN(ps_supplycost)
        FROM
            partsupp,
            supplier,
            nation,
            region
        WHERE
            p_partkey = ps_partkey
            AND s_suppkey = ps_suppkey
            AND s_nationkey = n_nationkey
            AND n_regionkey = r_regionkey
            AND r_name = 'EUROPE'
    )
ORDER BY
    s_acctbal DESC,
    n_name,
    s_name,
    p_partkey
LIMIT 100;

CREATE TEMP TABLE q2_rewritten_result AS
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

-- Result counts
SELECT
    'Original' AS query_variant,
    COUNT(*) AS row_count
FROM q2_original_result

UNION ALL

SELECT
    'Rewritten',
    COUNT(*)
FROM q2_rewritten_result;

-- Rows present in Original but absent in Rewritten
SELECT COUNT(*) AS original_minus_rewritten
FROM (
    SELECT * FROM q2_original_result
    EXCEPT ALL
    SELECT * FROM q2_rewritten_result
) AS differences;

-- Rows present in Rewritten but absent in Original
SELECT COUNT(*) AS rewritten_minus_original
FROM (
    SELECT * FROM q2_rewritten_result
    EXCEPT ALL
    SELECT * FROM q2_original_result
) AS differences;
