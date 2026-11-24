SELECT datname, pg_encoding_to_char(encoding) AS encoding, datcollate, datctype, datlocprovider
FROM pg_database WHERE datname LIKE 'tpch%' ORDER BY datname;