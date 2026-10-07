-- Verify ff2b_db:appschema from pg

BEGIN;

SELECT ff2b_id, first_name, email FROM "persons" WHERE FALSE;
SELECT id, person_id, email FROM "users" WHERE FALSE;
SELECT id, role_id, person_id FROM "person_role" WHERE FALSE;
SELECT id, person_id, is_accepted FROM "consents" WHERE FALSE;
SELECT id, action, changed_by FROM "logs" WHERE FALSE;

SELECT id, person_id, license_status, amount FROM "licenses" WHERE FALSE;
SELECT id, season_id, status FROM "competitions" WHERE FALSE;
SELECT id, competition_id, status FROM "games" WHERE FALSE;
SELECT id, game_side_id, person_id FROM "game_participant" WHERE FALSE;
SELECT id, game_side_id, result FROM "game_side_result" WHERE FALSE;

SELECT id, person_id, amount, payment_status FROM "payments" WHERE FALSE;
SELECT id, name, category_id, quantity FROM "equipments" WHERE FALSE;
SELECT id, filename, storage_path FROM "documents" WHERE FALSE;

SELECT has_function_privilege('validate_game_integrity()', 'execute');
SELECT has_function_privilege('validate_game_participant()', 'execute');
SELECT has_function_privilege('validate_team_membership_change()', 'execute');

ROLLBACK;