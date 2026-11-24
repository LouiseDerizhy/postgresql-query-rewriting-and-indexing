ALTER SYSTEM SET shared_buffers = '2GB';
ALTER SYSTEM SET work_mem = '64MB';
ALTER SYSTEM SET maintenance_work_mem = '1GB';
ALTER SYSTEM SET effective_cache_size = '4GB';
ALTER SYSTEM SET jit = off;

SELECT name, current_setting(name) AS value, source FROM pg_settings
WHERE name IN ('shared_buffers','work_mem','maintenance_work_mem','effective_cache_size','jit',
 'hash_mem_multiplier','max_parallel_workers_per_gather','random_page_cost','io_method','io_workers',
 'effective_io_concurrency','autovacuum','statement_timeout','track_io_timing') ORDER BY name;