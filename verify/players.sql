-- Verify ff2b_db:players on pg

BEGIN;


-- Verify ff2b_db:players on pg

DO $$
BEGIN
    -- Colonnes ajoutées à persons
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = current_schema()
          AND table_name = 'persons'
          AND column_name = 'alias'
    ) THEN
        RAISE EXCEPTION 'Missing column: persons.alias';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = current_schema()
          AND table_name = 'persons'
          AND column_name = 'sex'
    ) THEN
        RAISE EXCEPTION 'Missing column: persons.sex';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = current_schema()
          AND table_name = 'persons'
          AND column_name = 'birth_place'
    ) THEN
        RAISE EXCEPTION 'Missing column: persons.birth_place';
    END IF;

    -- Tables
    IF to_regclass(format('%I.%I', current_schema(), 'players')) IS NULL THEN
        RAISE EXCEPTION 'Missing table: players';
    END IF;

    IF to_regclass(format('%I.%I', current_schema(), 'player_medical_information')) IS NULL THEN
        RAISE EXCEPTION 'Missing table: player_medical_information';
    END IF;

    IF to_regclass(format('%I.%I', current_schema(), 'player_contacts')) IS NULL THEN
        RAISE EXCEPTION 'Missing table: player_contacts';
    END IF;

    -- Type enum
    IF NOT EXISTS (
        SELECT 1
        FROM pg_type t
        JOIN pg_namespace n ON n.oid = t.typnamespace
        WHERE n.nspname = current_schema()
          AND t.typname = 'player_contact_type'
          AND t.typtype = 'e'
    ) THEN
        RAISE EXCEPTION 'Missing enum type: player_contact_type';
    END IF;

    -- Valeurs attendues dans l'enum
    IF (
        SELECT COUNT(*)
        FROM pg_enum e
        JOIN pg_type t ON t.oid = e.enumtypid
        JOIN pg_namespace n ON n.oid = t.typnamespace
        WHERE n.nspname = current_schema()
          AND t.typname = 'player_contact_type'
          AND e.enumlabel IN ('legal_representative', 'emergency_contact')
    ) <> 2 THEN
        RAISE EXCEPTION 'Unexpected values in player_contact_type';
    END IF;

    -- Un profil joueur par personne
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE n.nspname = current_schema()
          AND t.relname = 'players'
          AND c.contype = 'u'
          AND pg_get_constraintdef(c.oid) = 'UNIQUE (person_id)'
    ) THEN
        RAISE EXCEPTION 'Missing UNIQUE constraint on players.person_id';
    END IF;

    -- Une fiche médicale par joueur
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE n.nspname = current_schema()
          AND t.relname = 'player_medical_information'
          AND c.contype = 'p'
          AND pg_get_constraintdef(c.oid) = 'PRIMARY KEY (player_id)'
    ) THEN
        RAISE EXCEPTION 'Missing primary key on player_medical_information.player_id';
    END IF;

    -- Index de recherche des contacts
    IF to_regclass(format('%I.%I', current_schema(), 'idx_player_contacts_player_id')) IS NULL THEN
        RAISE EXCEPTION 'Missing index: idx_player_contacts_player_id';
    END IF;

    IF to_regclass(format('%I.%I', current_schema(), 'idx_player_contacts_contact_person_id')) IS NULL THEN
        RAISE EXCEPTION 'Missing index: idx_player_contacts_contact_person_id';
    END IF;
END
$$;



ROLLBACK;
