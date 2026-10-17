-- Verify ff2b_db:competition_organizer on pg

BEGIN;

SELECT organizing_organization_id, director_id FROM "competitions" WHERE FALSE;

ROLLBACK;
