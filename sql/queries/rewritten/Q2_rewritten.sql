SELECT s_acctbal, s_name, n_name, p_partkey, p_mfgr, s_address, s_phone, s_comment
FROM part
JOIN partsupp ON p_partkey = ps_partkey
JOIN supplier ON s_suppkey = ps_suppkey
JOIN nation   ON s_nationkey = n_nationkey
JOIN region   ON n_regionkey = r_regionkey
JOIN (
    SELECT ps_partkey AS m_partkey, MIN(ps_supplycost) AS min_supplycost
    FROM partsupp
    JOIN supplier ON s_suppkey = ps_suppkey
    JOIN nation   ON s_nationkey = n_nationkey
    JOIN region   ON n_regionkey = r_regionkey
    WHERE r_name = 'EUROPE'
    GROUP BY ps_partkey
) AS msc ON msc.m_partkey = p_partkey AND ps_supplycost = msc.min_supplycost
WHERE p_size = 15 AND p_type LIKE '%BRASS' AND r_name = 'EUROPE'
ORDER BY s_acctbal DESC, n_name, s_name, p_partkey
LIMIT 100;
