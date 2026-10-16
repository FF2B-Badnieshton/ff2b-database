-- Verify ff2b_db:courts on pg

BEGIN;

SELECT id, code, label, description
FROM court_categories
WHERE FALSE;

-- Verify court_sizes table
SELECT id, code, label, description
FROM courts_sizes
WHERE FALSE;

-- Verify courts table
SELECT
    id,
    practice_site_id,
    name,
    description,
    court_category_id,
    court_size_id
FROM courts
WHERE FALSE;
 
SELECT 1 / (
    COUNT(*) = 3
)::INTEGER
FROM pg_constraint
WHERE conrelid = 'courts'::regclass
  AND contype = 'f'
  AND conname IN (
      'fk_courts_practice_site_id_practice_sites',
      'fk_courts_court_category_id_court_categories',
      'fk_courts_court_size_id_courts_sizes'
  );

-- Verify unique constraint
SELECT 1 / (
    COUNT(*) = 1
)::INTEGER
FROM pg_constraint
WHERE conrelid = 'courts'::regclass
  AND conname = 'unique_courts_practice_site_id_name'
  AND contype = 'u';

-- Verify indexes
SELECT 1 / (
    COUNT(*) = 2
)::INTEGER
FROM pg_class
WHERE relkind = 'i'
  AND relname IN (
      'idx_courts_practice_site_id',
      'idx_courts_court_category_id'
  );


ROLLBACK;
