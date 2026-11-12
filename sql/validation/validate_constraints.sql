SELECT
    CASE contype
        WHEN 'p' THEN 'PRIMARY KEY'
        WHEN 'f' THEN 'FOREIGN KEY'
    END AS constraint_type,
    COUNT(*) AS total_constraints
FROM pg_constraint
WHERE connamespace = 'public'::regnamespace
  AND contype IN ('p', 'f')
GROUP BY contype
ORDER BY contype;

SELECT
    conname AS constraint_name,
    CASE contype
        WHEN 'p' THEN 'PRIMARY KEY'
        WHEN 'f' THEN 'FOREIGN KEY'
    END AS constraint_type,
    pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE connamespace = 'public'::regnamespace
  AND contype IN ('p', 'f')
ORDER BY contype, conname;

SELECT
    conname AS constraint_name,
    convalidated AS is_validated
FROM pg_constraint
WHERE connamespace = 'public'::regnamespace
  AND contype IN ('p', 'f')
ORDER BY conname;