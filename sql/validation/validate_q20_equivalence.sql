-- ============================================================
-- TPC-H Q20 SQL Equivalence Validation
-- Method: Bidirectional EXCEPT ALL
-- DBMS: PostgreSQL 18.6
-- Database: tpch_sf01
-- Scale Factor: SF0.1
-- Index Configuration: I0
-- ============================================================

-- 1. Execute Original and store its result
DROP TABLE IF EXISTS q20_original_result;
CREATE TEMP TABLE q20_original_result AS
SELECT
    s_name,
    s_address
FROM
    supplier,
    nation
WHERE
    s_suppkey IN (
        SELECT
            ps_suppkey
        FROM
            partsupp
        WHERE
            ps_partkey IN (
                SELECT
                    p_partkey
                FROM
                    part
                WHERE
                    p_name LIKE 'forest%'
            )
            AND ps_availqty > (
                SELECT
                    0.5 * SUM(l_quantity)
                FROM
                    lineitem
                WHERE
                    l_partkey = ps_partkey
                    AND l_suppkey = ps_suppkey
                    AND l_shipdate >= DATE '1994-01-01'
                    AND l_shipdate < DATE '1995-01-01'
            )
    )
    AND s_nationkey = n_nationkey
    AND n_name = 'CANADA'
ORDER BY
    s_name;


-- 2. Execute Rewritten and store its result
DROP TABLE IF EXISTS q20_rewritten_result;
CREATE TEMP TABLE q20_rewritten_result AS
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


-- 3. Compare row counts
SELECT
    'Original row count' AS validation_check,
    COUNT(*) AS actual
FROM q20_original_result

UNION ALL

SELECT
    'Rewritten row count',
    COUNT(*)
FROM q20_rewritten_result;


-- 4. Original EXCEPT ALL Rewritten
SELECT
    'Original EXCEPT ALL Rewritten' AS validation_check,
    COUNT(*) AS difference_count
FROM (
    SELECT * FROM q20_original_result
    EXCEPT ALL
    SELECT * FROM q20_rewritten_result
) AS differences;


-- 5. Rewritten EXCEPT ALL Original
SELECT
    'Rewritten EXCEPT ALL Original' AS validation_check,
    COUNT(*) AS difference_count
FROM (
    SELECT * FROM q20_rewritten_result
    EXCEPT ALL
    SELECT * FROM q20_original_result
) AS differences;


-- 6. Display final validation status
SELECT
    CASE
        WHEN
            (SELECT COUNT(*) FROM (
                SELECT * FROM q20_original_result
                EXCEPT ALL
                SELECT * FROM q20_rewritten_result
            ) AS diff1) = 0
        AND
            (SELECT COUNT(*) FROM (
                SELECT * FROM q20_rewritten_result
                EXCEPT ALL
                SELECT * FROM q20_original_result
            ) AS diff2) = 0
        THEN 'PASS'
        ELSE 'FAIL'
    END AS equivalence_status;