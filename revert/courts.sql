-- Revert ff2b_db:courts from pg

BEGIN;

DROP TABLE courts;
DROP TABLE court_categories;
DROP TABLE courts_sizes;



COMMIT;
