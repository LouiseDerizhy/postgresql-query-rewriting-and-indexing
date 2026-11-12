SELECT
    tbl.relname AS table_name,
    idx.relname AS index_name,
    pg_size_pretty(pg_relation_size(idx.oid)) AS index_size,
    pg_relation_size(idx.oid) AS index_size_bytes
FROM
    pg_class idx
JOIN
    pg_index pi
    ON pi.indexrelid = idx.oid
JOIN
    pg_class tbl
    ON tbl.oid = pi.indrelid
JOIN
    pg_namespace ns
    ON ns.oid = tbl.relnamespace
WHERE
    ns.nspname = 'public'
    AND tbl.relname IN (
        'region',
        'nation',
        'part',
        'supplier',
        'partsupp',
        'customer',
        'orders',
        'lineitem'
    )
ORDER BY
    tbl.relname,
    idx.relname;