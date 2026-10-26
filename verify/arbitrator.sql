-- Verify ff2b_db:arbitrator on pg

BEGIN;

SELECT "arbitrator" FROM "competitions" WHERE FALSE;

ROLLBACK;
