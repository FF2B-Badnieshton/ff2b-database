-- Revert ff2b_db:players from pg

BEGIN;

DROP TABLE player_contacts;
DROP TABLE player_medical_information;
DROP TABLE players;


DROP TYPE player_contact_type;

ALTER TABLE persons
    DROP COLUMN birth_place,
    DROP COLUMN sex,
    DROP COLUMN alias;


COMMIT;
