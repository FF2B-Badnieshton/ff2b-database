-- Revert ff2b_db:price_licences from pg

BEGIN;

DROP TABLE IF EXISTS "license_type_prices";

COMMIT;
