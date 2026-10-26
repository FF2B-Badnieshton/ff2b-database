-- Revert ff2b_db:arbitrator from pg

BEGIN;

ALTER TABLE "competitions"
DROP COLUMN "arbitrator";


COMMIT;
