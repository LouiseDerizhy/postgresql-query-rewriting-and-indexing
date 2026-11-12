SELECT
    tbl.relname AS table_name,
    idx.relname AS index_name,
    am.amname AS index_method,
    pi.indisprimary AS is_primary,
    pi.indisunique AS is_unique,
    pg_get_indexdef(idx.oid) AS index_definition
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
JOIN
    pg_am am
    ON am.oid = idx.relam
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