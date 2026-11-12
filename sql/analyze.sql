ANALYZE VERBOSE;

SELECT
    schemaname,
    relname AS table_name,
    n_live_tup AS estimated_rows,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY relname;