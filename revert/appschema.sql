-- Revert ff2b_db:appschema from pg

BEGIN;


DROP FUNCTION IF EXISTS 
    validate_game_integrity,
    validate_game_participant,
    validate_team_membership_change,
    validate_team_competition_change CASCADE;


DROP TABLE IF EXISTS 
    logs, users_status, payments_history, payments, commissions_members, 
    commissions, projects_status, projects_members_role, projects_members, 
    projects, documents_practices_sites, documents_organizations, 
    documents_commissions, documents_projects, documents_licenses, 
    documents_competitions, documents_persons, document_types, documents, 
    consents_type, consents, users_roles, access_roles, users, contacts, 
    prospects, organizations_contact, organization_types, organizations, 
    volunteers, referent_status, referents, team_members, teams, 
    game_side_result, game_side, game_participant, game_format, games, 
    competition_participant_category, competition_participant_status, 
    competition_participant, competition_status, competition_formats, 
    competitions, session_participants, sessions, slots, equipment_status, 
    equipment_categories, equipments, practice_sites, countries, regions, 
    departments, development_status, municipalities, seasons, license_types, 
    licenses, roles, person_roles, person_status, persons CASCADE;


DROP TYPE IF EXISTS 
    game_status,
    payments_status,
    payments_method,
    seance_status,
    contact_origin,
    licence_status CASCADE;

COMMIT;