-- Verify ff2b_db:price_licences on pg

BEGIN;

SELECT id, license_type_id, season_id, amount, currency
FROM license_type_prices
WHERE FALSE;


ROLLBACK;
