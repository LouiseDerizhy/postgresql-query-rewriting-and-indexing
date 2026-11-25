SELECT s.s_name, s.s_address
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN (
    SELECT DISTINCT ps.ps_suppkey
    FROM partsupp ps
    JOIN part p ON p.p_partkey = ps.ps_partkey
    JOIN (
        SELECT l_partkey, l_suppkey, SUM(l_quantity) AS total_quantity
        FROM lineitem
        WHERE l_shipdate >= DATE '1994-01-01'
          AND l_shipdate < DATE '1994-01-01' + INTERVAL '1 year'
        GROUP BY l_partkey, l_suppkey
    ) lq ON lq.l_partkey = ps.ps_partkey AND lq.l_suppkey = ps.ps_suppkey
    WHERE p.p_name LIKE 'forest%'
      AND ps.ps_availqty > 0.5 * lq.total_quantity
) qs ON qs.ps_suppkey = s.s_suppkey
WHERE n.n_name = 'CANADA'
ORDER BY s.s_name;
