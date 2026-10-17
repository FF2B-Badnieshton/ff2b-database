-- Revert ff2b_db:competition_organizer from pg

BEGIN;

ALTER TABLE "competitions"
DROP COLUMN "organizing_organization_id";

COMMIT;
