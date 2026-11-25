SELECT SUM(l.l_extendedprice) / 7.0 AS avg_yearly
FROM part p
JOIN lineitem l ON p.p_partkey = l.l_partkey
JOIN (
    SELECT l_partkey, AVG(l_quantity) AS avg_quantity
    FROM lineitem
    GROUP BY l_partkey
) aq ON aq.l_partkey = p.p_partkey
WHERE p.p_brand = 'Brand#23' AND p.p_container = 'MED BOX'
  AND l.l_quantity < 0.2 * aq.avg_quantity;
