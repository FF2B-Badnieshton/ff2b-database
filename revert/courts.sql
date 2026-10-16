-- Revert ff2b_db:courts from pg

BEGIN;

DROP TABLE IF EXISTS "courts" CASCADE;
DROP TABLE IF EXISTS "courts_categories" CASCADE;
DROP TABLE IF EXISTS "courts_sizes"

COMMIT;
