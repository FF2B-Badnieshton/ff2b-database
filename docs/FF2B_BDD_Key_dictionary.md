# FF2B Diagram Documentation

## Summary

- [Introduction](#introduction)
- [Database Type](#database-type)
- [Table Structure](#table-structure)
  - [persons](#persons)
  - [person_role](#person_role)
  - [roles](#roles)
  - [licenses](#licenses)
  - [license_type](#license_type)
  - [season](#season)
  - [municipalities](#municipalities)
  - [departments](#departments)
  - [regions](#regions)
  - [countries](#countries)
  - [practice_site](#practice_site)
  - [slots](#slots)
  - [sessions](#sessions)
  - [session_participants](#session_participants)
  - [competitions](#competitions)
  - [competition_format](#competition_format)
  - [competition_status](#competition_status)
  - [competition_participant](#competition_participant)
  - [competition_participant_status](#competition_participant_status)
  - [competition_participant_category](#competition_participant_category)
  - [games](#games)
  - [game_format](#game_format)
  - [game_participant](#game_participant)
  - [game_side](#game_side)
  - [game_side_result](#game_side_result)
  - [team](#team)
  - [team_members](#team_members)
  - [referents](#referents)
  - [referent_status](#referent_status)
  - [volunteers](#volunteers)
  - [organizations](#organizations)
  - [organizations_type](#organizations_type)
  - [organizations_contact](#organizations_contact)
  - [prospects](#prospects)
  - [contacts](#contacts)
  - [users](#users)
  - [access_roles](#access_roles)
  - [users_roles](#users_roles)
  - [consents](#consents)
  - [consents_type](#consents_type)
  - [documents](#documents)
  - [document_type](#document_type)
  - [documents_persons](#documents_persons)
  - [documents_competitions](#documents_competitions)
  - [documents_licenses](#documents_licenses)
  - [documents_projects](#documents_projects)
  - [documents_commissions](#documents_commissions)
  - [documents_organizations](#documents_organizations)
  - [documents_practices_sites](#documents_practices_sites)
  - [projects](#projects)
  - [projects_members](#projects_members)
  - [project_members_role](#project_members_role)
  - [projects_status](#projects_status)
  - [commissions](#commissions)
  - [commissions_members](#commissions_members)
  - [payments](#payments)
  - [payments_history](#payments_history)
  - [users_status](#users_status)
- [Relationships](#relationships)
- [Database Diagram](#database-diagram)

## Introduction

## Database type

- **Database system:** PostgreSQL

## Table structure

### persons

The central system table that aggregates the civil information, contact details, and current status of all individuals (licensees, organizers, volunteers, etc.) associated with the federation.

| Name                      | Type           | Settings                | References                                | Note                                                        |
| ------------------------- | -------------- | ----------------------- | ----------------------------------------- | ----------------------------------------------------------- |
| **ff2b_id**         | UUID           | 🔑 PK, not null, unique |                                           | Identifiant unique de la personne au sein de l'organisation |
| **first_name**      | TEXT           | not null                |                                           | Prénom de la personne                                      |
| **last_name**       | TEXT           | not null                |                                           | Nom de famille de la personne                               |
| **birthdate**       | DATE           | not null                |                                           | Date de naissance de la personne                            |
| **phone_number**    | TEXT           | not null                |                                           | Numéro de téléphone de la personne                       |
| **email**           | TEXT           | not null, unique        |                                           | Adresse email de la personne                                |
| **status**          | VARCHAR(40)    | null                    |                                           | Status de la personne dans l'organisation                   |
| **contact_origin**  | CONTACT_ORIGIN | not null                |                                           | L'origine du contact avec la personne                       |
| **address**         | VARCHAR(255)   | null                    |                                           | Adresse postale de la personne                              |
| **municipality_id** | INTEGER        | null                    | fk_persons_municipality_id_municipalities | ID de la clée primaire de la commune de la personne        |
| **creation_date**   | TIMESTAMPTZ    | null                    |                                           | Date de création de la personne dans la base de données   |

### person_role

A junction table used to link a specific individual to one or multiple business roles .

| Name          | Type     | Settings                       | References                       | Note                             |
| ------------- | -------- | ------------------------------ | -------------------------------- | -------------------------------- |
| **id**        | INTEGER  | 🔑 PK, not null, autoincrement |                                  | ID unique du rôle de la personne |
| **role_id**   | SMALLINT | not null                       | fk_person_role_role_id_roles     | ID du rôle                       |
| **person_id** | UUID     | not null                       | fk_person_role_person_id_persons | ID de la personne                |

#### Unique constraints

| Name                 | Columns            |
| -------------------- | ------------------ |
| person_role_unique_0 | role_id, person_id |

### roles

Contains the catalog of the different functional roles that can be assigned within the organization.

| Name            | Type     | Settings                       | References | Note                                        |
| --------------- | -------- | ------------------------------ | ---------- | ------------------------------------------- |
| **id**    | SMALLINT | 🔑 PK, not null, autoincrement |            | L'identifiant unique du role                |
| **code**  | TEXT     | not null, unique               |            | Le code unique du rôle                     |
| **label** | TEXT     | not null, unique               |            | Le texte affiché du rôle dans le système |

### licenses

Tracks the historical record of each license granted to a person for a specific season, detailing its type and associated approval documentation.

| Name                      | Type           | Settings        | References                            | Note                                                  |
| ------------------------- | -------------- | --------------- | ------------------------------------- | ----------------------------------------------------- |
| **id**              | UUID           | 🔑 PK, not null |                                       | ID unique de la licence dans l'organisation           |
| **license_type**    | INTEGER        | not null        | fk_licenses_license_type_licence_type | Le type de la licence.                                |
| **person_id**       | UUID           | not null        | fk_licenses_person_id_persons         | ID de la personne propriétaire de la licence         |
| **season**          | INTEGER        | not null        | fk_licences_season_season             | ID de la saison durant laquelle la licence est valide |
| **request_date**    | DATE           | not null        |                                       | Date de demande de la licence                         |
| **validation_date** | DATE           | null            |                                       | Date de validation de la licence                      |
| **beginning_date**  | DATE           | null            |                                       | Date de début de la licence                          |
| **end_date**        | DATE           | null            |                                       | Date de fin de validité de la licence                |
| **license_status**  | LICENCE_STATUS | not null        |                                       | Le statut de la licence                               |
| **document_id**     | UUID           | null            | fk_licenses_document_id_documents     | ID du document de certificat de la licence            |

### license_type

A reference catalog outlining the various categories of licenses that the federation can issue.

| Name                    | Type    | Settings                       | References | Note                              |
| ----------------------- | ------- | ------------------------------ | ---------- | --------------------------------- |
| **id**            | INTEGER | 🔑 PK, not null, autoincrement |            | ID Unique du type de licence      |
| **license_code**  | TEXT    | not null, unique               |            | Code du type de licence           |
| **license_label** | TEXT    | not null, unique               |            | Texte affiché du type de licence |

#### Unique constraints

| Name                  | Columns                     |
| --------------------- | --------------------------- |
| license_type_unique_0 | license_code, license_label |

### season

Manages the sports timeline by defining the specific temporal boundaries for each active sports season.

| Name                 | Type     | Settings                       | References | Note                          |
| -------------------- | -------- | ------------------------------ | ---------- | ----------------------------- |
| **id**         | INTEGER  | 🔑 PK, not null, autoincrement |            | ID unique de la saison        |
| **start_year** | SMALLINT | not null                       |            | Année de début de la saison |
| **end_year**   | SMALLINT | not null                       |            | Année de fin de la saison    |

#### Unique constraints

| Name            | Columns              |
| --------------- | -------------------- |
| season_unique_0 | start_year, end_year |

### municipalities

This table stores the municipalities with its development status as well as it's departement, zip code & name

| Name                         | Type        | Settings                       | References                                   | Note                                   |
| ---------------------------- | ----------- | ------------------------------ | -------------------------------------------- | -------------------------------------- |
| **id**                 | INTEGER     | 🔑 PK, not null, autoincrement |                                              | ID unique de la commune                |
| **name**               | TEXT        | not null                       |                                              | Nom de la commune                      |
| **zip_code**           | TEXT        | not null                       |                                              | Le code postale de la commune          |
| **insee_code**         | VARCHAR(10) | null                           |                                              | Code INSEE de la commune               |
| **departement_id**     | INTEGER     | not null                       | fk_municipalities_departement_id_departments | ID du département de la commune       |
| **development_status** | TEXT        | not null                       |                                              | Status de développement de la commune |

### departments

| Name                | Type    | Settings                       | References                       | Note                                                |
| ------------------- | ------- | ------------------------------ | -------------------------------- | --------------------------------------------------- |
| **id**        | INTEGER | 🔑 PK, not null, autoincrement |                                  | ID du departement                                   |
| **name**      | TEXT    | not null                       |                                  | Nom du département                                 |
| **code**      | TEXT    | not null                       |                                  | Code du département                                |
| **region_id** | INTEGER | not null                       | fk_departments_region_id_regions | ID de la région dans laquelle se trouve la commune |

### regions

| Name                 | Type    | Settings                       | References                      | Note                             |
| -------------------- | ------- | ------------------------------ | ------------------------------- | -------------------------------- |
| **id**         | INTEGER | 🔑 PK, not null, autoincrement |                                 | ID de la région                 |
| **name**       | TEXT    | not null                       |                                 | Nom de la région                |
| **code**       | TEXT    | null                           |                                 | Code de la region, si disponible |
| **country_id** | INTEGER | not null                       | fk_regions_country_id_countries | ID du pays correspondant         |

### countries

| Name           | Type    | Settings                       | References | Note           |
| -------------- | ------- | ------------------------------ | ---------- | -------------- |
| **id**   | INTEGER | 🔑 PK, not null, autoincrement |            | ID du pays     |
| **name** | TEXT    | not null                       |            | Le nom du pays |
| **code** | TEXT    | not null                       |            | Code du pays   |

### practice_site

| Name                      | Type    | Settings                       | References                                      | Note                                  |
| ------------------------- | ------- | ------------------------------ | ----------------------------------------------- | ------------------------------------- |
| **id**              | INTEGER | 🔑 PK, not null, autoincrement |                                                 | ID du site de pratique                |
| **name**            | TEXT    | not null                       |                                                 | Nom du site de pratique               |
| **municipality_id** | INTEGER | not null                       | fk_practice_site_municipality_id_municipalities | ID de la municipalité                |
| **address**         | TEXT    | null                           |                                                 | Adresse du site de pratique           |
| **opening_date**    | DATE    | null                           |                                                 | Date d'ouverture du site de pratique  |
| **closing_date**    | DATE    | null                           |                                                 | Date de fermeture du site de pratique |

### slots

| Name                  | Type     | Settings                       | References                     | Note                               |
| --------------------- | -------- | ------------------------------ | ------------------------------ | ---------------------------------- |
| **id**          | INTEGER  | 🔑 PK, not null, autoincrement |                                | ID du créneau                     |
| **site_id**     | INTEGER  | not null                       | fk_slots_site_id_practice_site | ID du site appartenant au créneau |
| **season_id**   | INTEGER  | not null                       | fk_slots_season_id_season      | ID de la saison                    |
| **start_at**    | TIME     | not null                       |                                | Timestamp de début de créneau    |
| **end_at**      | TIME     | not null                       |                                | Timestamp de fin de créneau       |
| **capacity**    | SMALLINT | null                           |                                | Capacité d'effectif               |
| **day_of_week** | SMALLINT | null                           |                                | Le jour du créneau (entre 1 et 7) |

### sessions

| Name                  | Type          | Settings                       | References                        | Note                              |
| --------------------- | ------------- | ------------------------------ | --------------------------------- | --------------------------------- |
| **id**          | INTEGER       | 🔑 PK, not null, autoincrement |                                   | ID de la séance                  |
| **slot_id**     | INTEGER       | not null                       | fk_sessions_slot_id_slots         | ID du créneau pour la séance    |
| **start_time**  | TIMESTAMPTZ   | not null                       |                                   | Timestamp de début de séance    |
| **duration**    | SMALLINT      | not null                       |                                   | Durée de la séance (en minutes) |
| **referent_id** | INTEGER       | null                           | fk_sessions_referent_id_referents | ID du référent de la séance    |
| **coach_id**    | UUID          | null                           | fk_sessions_coach_id_persons      | ID du coach de la séance         |
| **content**     | TEXT          | null                           |                                   | Contenu de la séance             |
| **status**      | SEANCE_STATUS | null                           |                                   | Statut de la séance              |

### session_participants

| Name                 | Type    | Settings                       | References                                  | Note                                            |
| -------------------- | ------- | ------------------------------ | ------------------------------------------- | ----------------------------------------------- |
| **id**         | INTEGER | 🔑 PK, not null, autoincrement |                                             | ID de combinaison participant séance           |
| **person_id**  | UUID    | not null                       | fk_session_participants_person_id_persons   | ID de la personne                               |
| **session_id** | INTEGER | not null                       | fk_session_participants_session_id_sessions | ID de la séance                                |
| **license_id** | UUID    | not null                       | fk_session_participants_license_id_licenses | ID de la licence                                |
| **presence**   | BOOLEAN | not null                       |                                             | Valeur enregistrant la présence d'une personne |

#### Unique constraints

| Name                          | Columns               |
| ----------------------------- | --------------------- |
| session_participants_unique_0 | person_id, session_id |

### competitions

| Name                        | Type     | Settings                       | References                                  | Note                                                       |
| --------------------------- | -------- | ------------------------------ | ------------------------------------------- | ---------------------------------------------------------- |
| **id**                | INTEGER  | 🔑 PK, not null, autoincrement |                                             | ID de la compétition                                      |
| **season_id**         | INTEGER  | not null                       | fk_competitions_season_season               | ID de la saison auquel la compétition appartient          |
| **date**              | DATE     | not null                       |                                             | Date de la compétition                                    |
| **location_id**       | INTEGER  | not null                       | fk_competitions_location_municipalities     | Lieu de la compétition                                    |
| **practice_site_id**  | INTEGER  | not null                       | fk_competitions_practice_site_practice_site | ID du site de pratique                                     |
| **organizer_id**      | UUID     | not null                       | fk_competitions_organizer_Personnes         | ID de l'organisateur                                       |
| **format_id**         | SMALLINT | not null                       | fk_competitions_format_competition_format   | ID référant au format de la compétition                 |
| **status**            | INTEGER  | null                           | fk_competitions_status_competition_status   | Statut de la compétition                                  |
| **rules_document_id** | UUID     | null                           | fk_competitions_rules_document_id_documents | Clée étrangère vers le document des règles dans la BDD |

### competition_format

| Name            | Type     | Settings                       | References | Note                                        |
| --------------- | -------- | ------------------------------ | ---------- | ------------------------------------------- |
| **id**    | SMALLINT | 🔑 PK, not null, autoincrement |            | ID du format de compétition                |
| **code**  | TEXT     | not null, unique               |            | Code du format de compétition              |
| **label** | TEXT     | not null, unique               |            | Texte affiché du format de la compétition |

### competition_status

| Name            | Type    | Settings                       | References | Note                                        |
| --------------- | ------- | ------------------------------ | ---------- | ------------------------------------------- |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID unique du statut de compétition         |
| **code**  | TEXT    | not null, unique               |            | Code unique du statut de la compétition    |
| **label** | TEXT    | not null, unique               |            | Texte affiché du statut de la compétition |

### competition_participant

| Name                     | Type     | Settings                       | References                                                           | Note                                             |
| ------------------------ | -------- | ------------------------------ | -------------------------------------------------------------------- | ------------------------------------------------ |
| **id**             | INTEGER  | 🔑 PK, not null, autoincrement |                                                                      | ID unique de la participation à la compétition |
| **competition_id** | INTEGER  | not null                       | fk_competition_participant_competition_id_competitions               | ID de la compétition                            |
| **person_id**      | UUID     | not null                       | fk_participants_person_id_Personnes                                  | UUID de la personne                              |
| **status**         | INTEGER  | not null                       | fk_competition_participant_status_competition_participant_status     | Status de la participation à la compétition    |
| **category**       | INTEGER  | not null                       | fk_competition_participant_category_competition_participant_category | Catégorie de la participation                   |
| **license_id**     | UUID     | not null                       | fk_competition_participant_license_id_licenses                       | UUID de la licence du participant                |
| **ranking_before** | SMALLINT | null                           |                                                                      | Classement avant participation                   |
| **ranking_after**  | SMALLINT | null                           |                                                                      | Classement après modification                   |

### competition_participant_status

| Name            | Type    | Settings                       | References | Note                                                    |
| --------------- | ------- | ------------------------------ | ---------- | ------------------------------------------------------- |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID unique du statut du participant de la compétition   |
| **code**  | TEXT    | not null, unique               |            | Code unique du statut du participant de la compétition |
| **label** | TEXT    | not null, unique               |            | Label du statut du participant de la compétition       |

#### Unique constraints

| Name                                    | Columns     |
| --------------------------------------- | ----------- |
| competition_participant_status_unique_0 | code, label |

### competition_participant_category

| Name            | Type    | Settings                       | References | Note                                                           |
| --------------- | ------- | ------------------------------ | ---------- | -------------------------------------------------------------- |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID de la catégorie du participant de la compétition          |
| **code**  | TEXT    | not null, unique               |            | Code unique de la catégorie du participant de la compétition |
| **label** | TEXT    | not null, unique               |            | Label de la catégorie du participant de la compétition       |

#### Unique constraints

| Name                                      | Columns     |
| ----------------------------------------- | ----------- |
| competition_participant_category_unique_0 | code, label |

### games

| Name                     | Type        | Settings                       | References                           | Note                  |
| ------------------------ | ----------- | ------------------------------ | ------------------------------------ | --------------------- |
| **id**             | INTEGER     | 🔑 PK, not null, autoincrement |                                      | ID du match           |
| **competition_id** | INTEGER     | null                           | fk_games_competition_id_competitions | ID de la compétition |
| **format_id**      | SMALLINT    | not null                       | fk_games_format_id_game_format       | ID du format du match |
| **date**           | TIMESTAMPTZ | not null                       |                                      | Timestamp du match    |

### game_format

| Name            | Type     | Settings                       | References | Note                   |
| --------------- | -------- | ------------------------------ | ---------- | ---------------------- |
| **id**    | SMALLINT | 🔑 PK, not null, autoincrement |            | ID du format de match  |
| **code**  | TEXT     | not null, unique               |            | Code unique du format  |
| **label** | TEXT     | not null, unique               |            | Label unique du format |

### game_participant

| Name                     | Type     | Settings                       | References                                 | Note                                |
| ------------------------ | -------- | ------------------------------ | ------------------------------------------ | ----------------------------------- |
| **id**             | INTEGER  | 🔑 PK, not null, autoincrement |                                            | ID de la participation à la partie |
| **game_side_id**   | INTEGER  | not null                       | fk_game_participant_game_side_id_game_side | ID du côté du participant         |
| **ranking_before** | SMALLINT | not null                       |                                            | Classement avant participation      |
| **ranking_after**  | SMALLINT | null                           |                                            | Classement après le match          |
| **elo_before**     | SMALLINT | null                           |                                            | ELO avant match                     |
| **elo_after**      | SMALLINT | null                           |                                            | ELO après match                    |
| **person_id**      | UUID     | not null                       | fk_game_participant_person_id_persons      | ID de la personne                   |

### game_side

| Name                  | Type     | Settings                       | References                 | Note                                 |
| --------------------- | -------- | ------------------------------ | -------------------------- | ------------------------------------ |
| **id**          | INTEGER  | 🔑 PK, not null, autoincrement |                            | ID du côté du match                |
| **game_id**     | INTEGER  | not null                       | fk_game_side_game_id_games | ID du match                          |
| **side_number** | SMALLINT | not null                       |                            | Le numéro du côté du match (1, 2) |

#### Unique constraints

| Name               | Columns              |
| ------------------ | -------------------- |
| game_side_unique_0 | game_id, side_number |

### game_side_result

| Name                      | Type     | Settings                       | References                                 | Note                                 |
| ------------------------- | -------- | ------------------------------ | ------------------------------------------ | ------------------------------------ |
| **id**              | INTEGER  | 🔑 PK, not null, autoincrement |                                            | ID du résultat d'un côté du match |
| **game_side_id**    | INTEGER  | not null, unique               | fk_game_side_result_game_side_id_game_side | ID du côté du match                |
| **nieshs_scored**   | SMALLINT | not null                       |                                            | La valeur de nieshs marqué          |
| **nieshs_conceded** | SMALLINT | not null                       |                                            | La valeur de nieshs concédé        |
| **result**          | SMALLINT | not null                       |                                            | Le résultat du côté du match      |

### team

| Name                     | Type    | Settings                       | References                          | Note                                                       |
| ------------------------ | ------- | ------------------------------ | ----------------------------------- | ---------------------------------------------------------- |
| **id**             | INTEGER | 🔑 PK, not null, autoincrement |                                     | ID unique de l'équipe                                     |
| **competition_id** | INTEGER | not null                       | fk_team_competition_id_competitions | ID de la compétition dans laquelle l'équipe est inscrite |
| **name**           | TEXT    | not null                       |                                     | Nom de l'équipe                                           |

#### Unique constraints

| Name          | Columns              |
| ------------- | -------------------- |
| team_unique_0 | competition_id, name |

### team_members

| Name                | Type    | Settings        | References                        | Note                        |
| ------------------- | ------- | --------------- | --------------------------------- | --------------------------- |
| **team_id**   | INTEGER | 🔑 PK, not null | fk_team_members_team_id_team      | ID de l'équipe             |
| **person_id** | UUID    | 🔑 PK, not null | fk_team_members_person_id_persons | UUID du membre de l'équipe |

#### Unique constraints

| Name                  | Columns            |
| --------------------- | ------------------ |
| team_members_unique_0 | team_id, person_id |

### referents

| Name                          | Type    | Settings                       | References                          | Note                                       |
| ----------------------------- | ------- | ------------------------------ | ----------------------------------- | ------------------------------------------ |
| **id**                  | INTEGER | 🔑 PK, not null, autoincrement |                                     | ID du référent                           |
| **person_id**           | UUID    | not null                       | fk_referents_person_id_persons      | UUID de la personne                        |
| **site_id**             | INTEGER | not null                       | fk_referents_site_id_practice_site  | ID du site de pratique                     |
| **start_date**          | DATE    | not null                       |                                     | Date de début de rôle de référent      |
| **end_date**            | DATE    | null                           |                                     | Date de fin de référent                  |
| **professionnal_phone** | TEXT    | not null                       |                                     | Numéro de téléphone professionnel       |
| **professionnal_mail**  | TEXT    | not null                       |                                     | Adresse mail professionnelle du référent |
| **status**              | INTEGER | null                           | fk_referents_status_referent_status | Statut du référent dans l'organisation   |

### referent_status

| Name            | Type    | Settings                       | References | Note                         |
| --------------- | ------- | ------------------------------ | ---------- | ---------------------------- |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID du statut de référent   |
| **code**  | TEXT    | not null                       |            | Code du type de référent   |
| **label** | TEXT    | not null                       |            | Texte affiché du référent |

### volunteers

| Name                       | Type    | Settings                       | References                            | Note                                       |
| -------------------------- | ------- | ------------------------------ | ------------------------------------- | ------------------------------------------ |
| **id**               | INTEGER | 🔑 PK, not null, autoincrement |                                       | ID Unique du volontaire                    |
| **person_id**        | UUID    | not null                       | fk_volunteers_person_id_persons       | UUID de la personne                        |
| **manager_id**       | UUID    | not null                       | fk_volunteers_manager_id_persons      | UUID du manager                            |
| **mission**          | TEXT    | null                           |                                       | Le contenu de la mission à effectuer      |
| **skills**           | TEXT    | null                           |                                       | Les compétences de la personne            |
| **availability**     | TEXT    | null                           |                                       | Contenu de la disponibilité du volontaire |
| **location**         | INTEGER | not null                       | fk_volunteers_location_municipalities | ID du la localisation du volontaire        |
| **application_date** | DATE    | null                           |                                       | Date de demande de volontariat             |
| **observations**     | TEXT    | null                           |                                       | Contenu de l'observation                   |
| **start_date**       | DATE    | not null                       |                                       | Début de la période de volontariat       |
| **end_date**         | DATE    | null                           |                                       | Fin de la période de volontariat          |
| **tasks**            | TEXT    | null                           |                                       | Tâches effectués par le volontaire       |

### organizations

| Name                           | Type     | Settings                       | References                                               | Note                                                    |
| ------------------------------ | -------- | ------------------------------ | -------------------------------------------------------- | ------------------------------------------------------- |
| **id**                   | INTEGER  | 🔑 PK, not null, autoincrement |                                                          | ID de l'organisation                                    |
| **name**                 | TEXT     | not null                       |                                                          | Nom de l'organisation                                   |
| **organization_type_id** | SMALLINT | not null                       | fk_organizations_organization_type_id_organizations_type | ID du type d'organisation                               |
| **municipality_id**      | INTEGER  | null                           | fk_organizations_municipality_id_municipalities          | ID de la commune dans laquelle se trouve l'organisation |

### organizations_type

| Name            | Type     | Settings                       | References | Note                                     |
| --------------- | -------- | ------------------------------ | ---------- | ---------------------------------------- |
| **id**    | SMALLINT | 🔑 PK, not null, autoincrement |            | ID du type de l'organisation             |
| **code**  | TEXT     | not null                       |            | Code du type de l'organisation           |
| **label** | TEXT     | not null                       |            | Texte affiché du type de l'organisation |

### organizations_contact

| Name                      | Type    | Settings                       | References                                             | Note                              |
| ------------------------- | ------- | ------------------------------ | ------------------------------------------------------ | --------------------------------- |
| **id**              | INTEGER | 🔑 PK, not null, autoincrement |                                                        | ID du contact de l'organisation   |
| **organization_id** | INTEGER | not null                       | fk_organizations_contact_organization_id_organizations | ID de l'organisation              |
| **person_id**       | UUID    | not null                       | fk_organizations_contact_person_id_persons             | ID du gérant de l'organisation   |
| **function**        | TEXT    | null                           |                                                        | Fonction de la personne contacté |
| **start_date**      | DATE    | null                           |                                                        | Date de début du contact         |
| **end_date**        | DATE    | null                           |                                                        | Date de fin du contact            |

### prospects

| Name                      | Type    | Settings                       | References                                 | Note                     |
| ------------------------- | ------- | ------------------------------ | ------------------------------------------ | ------------------------ |
| **id**              | INTEGER | 🔑 PK, not null, autoincrement |                                            | ID du prospect           |
| **person_id**       | UUID    | null                           | fk_prospects_person_id_persons             | UUID de la personne      |
| **organization_id** | INTEGER | null                           | fk_prospects_organization_id_organizations | ID de l'organisation     |
| **type**            | TEXT    | null                           |                                            | Le type de prospect      |
| **status**          | TEXT    | null                           |                                            | Statut de la prospection |
| **interest**        | TEXT    | null                           |                                            | Intérêt du prospect    |

### contacts

| Name                      | Type        | Settings                       | References                                | Note                                                   |
| ------------------------- | ----------- | ------------------------------ | ----------------------------------------- | ------------------------------------------------------ |
| **id**              | INTEGER     | 🔑 PK, not null, autoincrement |                                           | ID unique du contact                                   |
| **person_id**       | UUID        | null                           | fk_contacts_person_id_persons             | ID de la personne                                      |
| **organization_id** | INTEGER     | null                           | fk_contacts_organization_id_organizations | ID de l'organisation                                   |
| **date**            | TIMESTAMPTZ | null                           |                                           | Date du contact                                        |
| **responsible_id**  | UUID        | not null                       | fk_contacts_responsible_id_persons        | ID de la personne responsable au sein de l'association |
| **subject**         | TEXT        | null                           |                                           | Sujet du contact                                       |
| **notes**           | TEXT        | null                           |                                           | Notes de l'interaction                                 |

### users

Manages the application accounts (including login credentials and hashed passwords) that allow individuals to securely connect to the platform.

| Name                    | Type        | Settings        | References                   | Note                                                                 |
| ----------------------- | ----------- | --------------- | ---------------------------- | -------------------------------------------------------------------- |
| **id**            | UUID        | 🔑 PK, not null |                              | ID du l'utilisateur sur les plateformes numériques de l'association |
| **person_id**     | UUID        | not null        | fk_users_person_id_persons   | UUID de la personne                                                  |
| **email**         | TEXT        | not null        |                              | Adresse mail de l'utilisateur sur les plateformes numériques        |
| **password**      | TEXT        | not null        |                              | Mot de passe hashé de l'utilisateur                                 |
| **statut**        | SMALLINT    | null            | fk_users_statut_users_status | Le status du compte de l'utilisateur                                 |
| **creation_date** | TIMESTAMPTZ | not null        |                              | La date de création du compte utilisateur                           |

### access_roles

Manage application-level permissions (RBAC) to strictly define which specific modules of the application each user is authorized to access

| Name            | Type    | Settings                       | References | Note                    |
| --------------- | ------- | ------------------------------ | ---------- | ----------------------- |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID unique du rôle      |
| **code**  | TEXT    | not null, unique               |            | Code du rôle           |
| **label** | TEXT    | not null, unique               |            | Texte affiché du rôle |

### users_roles

A junction table that link the users table & access_roles table

| Name              | Type    | Settings        | References                          | Note                |
| ----------------- | ------- | --------------- | ----------------------------------- | ------------------- |
| **role_id** | INTEGER | 🔑 PK, not null | fk_users_roles_role_id_access_roles | ID du rôle         |
| **user_id** | UUID    | 🔑 PK, not null | fk_users_roles_user_id_users        | ID de l'utilisateur |

#### Unique constraints

| Name                 | Columns          |
| -------------------- | ---------------- |
| users_roles_unique_0 | role_id, user_id |

### consents

Ensure strict GDPR compliance by verifiably storing which mandatory or optional agreements (such as image rights) each individual has accepted.

| Name                | Type        | Settings                       | References                                | Note                                      |
| ------------------- | ----------- | ------------------------------ | ----------------------------------------- | ----------------------------------------- |
| **id**              | INTEGER     | 🔑 PK, not null, autoincrement |                                           | ID du consentement                        |
| **person_id**       | UUID        | not null                       | fk_consents_person_id_persons             | UUID de la personne                       |
| **consent_type_id** | INTEGER     | not null                       | fk_consents_consent_type_id_consents_type | Le type de consentement                   |
| **given_at**        | TIMESTAMPTZ | not null                       |                                           | La date de l'accord donné par la personne |
| **is_accepted**     | BOOLEAN     | not null                       |                                           | Valeur d'acceptation de la personne       |

### consents_type

Ensure strict GDPR compliance by verifiably storing which mandatory or optional agreements (such as image rights) each individual has accepted.

| Name                   | Type    | Settings                       | References | Note                                                               |
| ---------------------- | ------- | ------------------------------ | ---------- | ------------------------------------------------------------------ |
| **id**           | INTEGER | 🔑 PK, not null, autoincrement |            | ID unique du type de consentement                                  |
| **code**         | TEXT    | not null, unique               |            | Code unique du type de consentement                                |
| **label**        | TEXT    | not null                       |            | Texte affiché du type de consentement                             |
| **description**  | TEXT    | null                           |            | Description du type de consentement                                |
| **is_mandatory** | BOOLEAN | not null                       |            | Champ pour savoir si l'acceptation est obligatoire pour s'inscrire |

### documents

| Name                       | Type        | Settings        | References                                  | Note                                                       |
| -------------------------- | ----------- | --------------- | ------------------------------------------- | ---------------------------------------------------------- |
| **id**               | UUID        | 🔑 PK, not null |                                             | ID Unique du document                                      |
| **filename**         | TEXT        | not null        |                                             | Le nom du fichier                                          |
| **storage_path**     | TEXT        | not null        |                                             | Le lien du fichier sur la plateforme de stockage           |
| **document_type_id** | SMALLINT    | not null        | fk_documents_document_type_id_document_type | ID du type de document                                     |
| **creation_date**    | TIMESTAMPTZ | not null        |                                             | Date d'enregistrement du document dans la base de données |
| **mime_type**        | VARCHAR(40) | null            |                                             | Le type applicatif du document                             |
| **file_size**        | INTEGER     | not null        |                                             | La taille du fichier                                       |
| **hash**             | VARCHAR(64) | not null        |                                             | Le hash du fichier                                         |
| **uploaded_by**      | UUID        | null            | fk_documents_uploaded_by_users              | L'UUID de la personne qui a uploadé le fichier            |
| **expires_at**       | TIMESTAMPTZ | null            |                                             | La date d'expiration du document (si dispo)                |

### document_type

| Name                     | Type     | Settings                       | References | Note                                                 |
| ------------------------ | -------- | ------------------------------ | ---------- | ---------------------------------------------------- |
| **id**             | SMALLINT | 🔑 PK, not null, autoincrement |            | ID du type de document                               |
| **document_code**  | TEXT     | not null, unique               |            | Le code du type de document dans la base de données |
| **document_label** | TEXT     | not null                       |            | Le texte affiché dans les applications              |

### documents_persons

| Name                  | Type | Settings        | References                                 | Note                |
| --------------------- | ---- | --------------- | ------------------------------------------ | ------------------- |
| **document_id** | UUID | 🔑 PK, not null | fk_documents_persons_document_id_documents | UUID du document    |
| **person_id**   | UUID | 🔑 PK, not null | fk_documents_persons_person_id_persons     | UUID de la personne |

#### Unique constraints

| Name                       | Columns                |
| -------------------------- | ---------------------- |
| documents_persons_unique_0 | document_id, person_id |

### documents_competitions

| Name                     | Type    | Settings        | References                                            | Note                    |
| ------------------------ | ------- | --------------- | ----------------------------------------------------- | ----------------------- |
| **document_id**    | UUID    | 🔑 PK, not null | fk_documents_competitions_document_id_documents       | UUID du document        |
| **competition_id** | INTEGER | 🔑 PK, not null | fk_documents_competitions_competition_id_competitions | UUID de la compétition |

#### Unique constraints

| Name                            | Columns                     |
| ------------------------------- | --------------------------- |
| documents_competitions_unique_0 | document_id, competition_id |

### documents_licenses

| Name                  | Type | Settings        | References                                  | Note               |
| --------------------- | ---- | --------------- | ------------------------------------------- | ------------------ |
| **document_id** | UUID | 🔑 PK, not null | fk_documents_licenses_document_id_documents | UUID du document   |
| **license_id**  | UUID | 🔑 PK, not null | fk_documents_licenses_license_id_licenses   | UUID de la licence |

#### Unique constraints

| Name                        | Columns                 |
| --------------------------- | ----------------------- |
| documents_licenses_unique_0 | document_id, license_id |

### documents_projects

| Name                  | Type    | Settings        | References                                  | Note             |
| --------------------- | ------- | --------------- | ------------------------------------------- | ---------------- |
| **document_id** | UUID    | 🔑 PK, not null | fk_documents_projects_document_id_documents | UUID du document |
| **project_id**  | INTEGER | 🔑 PK, not null | fk_documents_projects_project_id_projects   | ID du projet     |

#### Unique constraints

| Name                        | Columns                 |
| --------------------------- | ----------------------- |
| documents_projects_unique_0 | document_id, project_id |

### documents_commissions

| Name                    | Type    | Settings        | References                                         | Note                |
| ----------------------- | ------- | --------------- | -------------------------------------------------- | ------------------- |
| **document_id**   | UUID    | 🔑 PK, not null | fk_documents_commissions_document_id_documents     | IUUID du document   |
| **commission_id** | INTEGER | 🔑 PK, not null | fk_documents_commissions_commission_id_commissions | ID de la commission |

#### Unique constraints

| Name                           | Columns                    |
| ------------------------------ | -------------------------- |
| documents_commissions_unique_0 | document_id, commission_id |

### documents_organizations

| Name                      | Type    | Settings        | References                                               | Note                 |
| ------------------------- | ------- | --------------- | -------------------------------------------------------- | -------------------- |
| **document_id**     | UUID    | 🔑 PK, not null | fk_documents_organizations_document_id_documents         | UUID du document     |
| **organization_id** | INTEGER | 🔑 PK, not null | fk_documents_organizations_organization_id_organizations | ID de l'organisation |

#### Unique constraints

| Name                             | Columns                      |
| -------------------------------- | ---------------------------- |
| documents_organizations_unique_0 | document_id, organization_id |

### documents_practices_sites

| Name                       | Type    | Settings        | References                                                  | Note                   |
| -------------------------- | ------- | --------------- | ----------------------------------------------------------- | ---------------------- |
| **document_id**      | UUID    | 🔑 PK, not null | fk_documents_practices_sites_document_id_documents          | UUID du document       |
| **practice_site_id** | INTEGER | 🔑 PK, not null | fk_documents_practices_sites_practice_site_id_practice_site | ID du site de pratique |

#### Unique constraints

| Name                               | Columns                       |
| ---------------------------------- | ----------------------------- |
| documents_practices_sites_unique_0 | document_id, practice_site_id |

### projects

| Name                  | Type     | Settings                       | References                         | Note                     |
| --------------------- | -------- | ------------------------------ | ---------------------------------- | ------------------------ |
| **id**          | INTEGER  | 🔑 PK, not null, autoincrement |                                    | ID unique du projet      |
| **name**        | TEXT     | not null                       |                                    | Nom du projet            |
| **description** | TEXT     | null                           |                                    | Description du projet    |
| **status**      | SMALLINT | not null                       | fk_projects_status_projects_status | ID du statut du projet   |
| **start_date**  | DATE     | not null                       |                                    | Date de début du projet |
| **end_date**    | DATE     | null                           |                                    | Date de fin du projet    |

### projects_members

| Name                   | Type    | Settings        | References                                            | Note                                            |
| ---------------------- | ------- | --------------- | ----------------------------------------------------- | ----------------------------------------------- |
| **project_id**   | INTEGER | 🔑 PK, not null | fk_projects_members_project_id_projects               | ID du projet                                    |
| **person_id**    | UUID    | 🔑 PK, not null | fk_projects_members_person_id_persons                 | UUID de la personne                             |
| **project_role** | INTEGER | not null        | fk_projects_members_project_role_project_members_role | ID du rôle de la personne dans le projet       |
| **joined_at**    | DATE    | null            |                                                       | Date à laquelle le membre à rejoint le projet |

#### Unique constraints

| Name                      | Columns               |
| ------------------------- | --------------------- |
| projects_members_unique_0 | project_id, person_id |

### project_members_role

| Name            | Type    | Settings                       | References | Note                           |
| --------------- | ------- | ------------------------------ | ---------- | ------------------------------ |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID du rôle de projet          |
| **code**  | TEXT    | not null, unique               |            | Code unique du rôle du projet |
| **label** | TEXT    | not null, unique               |            | Label du rôle de projet       |

### projects_status

| Name            | Type     | Settings                       | References | Note                      |
| --------------- | -------- | ------------------------------ | ---------- | ------------------------- |
| **id**    | SMALLINT | 🔑 PK, not null, autoincrement |            | ID du statut du projet    |
| **code**  | TEXT     | not null, unique               |            | Code du statut du projet  |
| **label** | TEXT     | not null, unique               |            | Label du statut du projet |

### commissions

| Name                    | Type        | Settings                       | References                          | Note                                |
| ----------------------- | ----------- | ------------------------------ | ----------------------------------- | ----------------------------------- |
| **id**            | INTEGER     | 🔑 PK, not null, autoincrement |                                     | ID de la commission                 |
| **name**          | TEXT        | not null                       |                                     | Nom de la commission                |
| **code**          | TEXT        | not null, unique               |                                     | Code de la commission               |
| **description**   | TEXT        | null                           |                                     | Description de la commission        |
| **president_id**  | UUID        | not null                       | fk_commissions_president_id_persons | UUID du président de la commission |
| **creation_date** | TIMESTAMPTZ | not null                       |                                     | Date de création de la commission  |

### commissions_members

| Name                    | Type    | Settings        | References                                       | Note                                              |
| ----------------------- | ------- | --------------- | ------------------------------------------------ | ------------------------------------------------- |
| **commission_id** | INTEGER | 🔑 PK, not null | fk_commissions_members_commission_id_commissions | ID de la commission                               |
| **person_id**     | UUID    | 🔑 PK, not null | fk_commissions_members_person_id_persons         | ID du membre de la commission                     |
| **joined_at**     | DATE    | not null        |                                                  | Date à laquelle le membre à joint la commission |

#### Unique constraints

| Name                         | Columns                  |
| ---------------------------- | ------------------------ |
| commissions_members_unique_0 | commission_id, person_id |

### payments

| Name                            | Type            | Settings         | References                             | Note                             |
| ------------------------------- | --------------- | ---------------- | -------------------------------------- | -------------------------------- |
| **id**                    | UUID            | 🔑 PK, not null  |                                        | ID du paiement                   |
| **person_id**             | UUID            | not null         | fk_payments_person_id_persons          | UUID de la personne              |
| **license_id**            | UUID            | not null         | fk_payments_license_id_licenses        | UUID de la licence               |
| **amount**                | NUMERIC(8,2)    | not null         |                                        | Le montant du paiement           |
| **currency**              | VARCHAR(3)      | not null         |                                        |                                  |
| **payment_method**        | PAYMENTS_METHOD | not null         |                                        | Méthode de paiement             |
| **payment_status**        | PAYMENTS_STATUS | not null         |                                        | Statut du paiement               |
| **payment_date**          | TIMESTAMPTZ     | not null         |                                        | Date du paiement                 |
| **transaction_reference** | TEXT            | not null, unique |                                        | Référence de la transaction    |
| **invoice_document**      | UUID            | null             | fk_payments_invoice_document_documents | UUID du document de facture      |
| **notes**                 | TEXT            | null             |                                        | Notes sur le paiement            |
| **created_at**            | TIMESTAMPTZ     | not null         |                                        | Date de création du paiement    |
| **updated_at**            | TIMESTAMPTZ     | not null         |                                        | Date de mise à jour du paiement |

### payments_history

| Name                      | Type            | Settings                       | References                              | Note                                         |
| ------------------------- | --------------- | ------------------------------ | --------------------------------------- | -------------------------------------------- |
| **id**              | INTEGER         | 🔑 PK, not null, autoincrement |                                         | ID de l'historique                           |
| **payment_id**      | UUID            | not null                       | fk_payments_history_payment_id_payments | ID du paiement                               |
| **previous_status** | PAYMENTS_STATUS | not null                       |                                         | Statut précédent                           |
| **new_status**      | PAYMENTS_STATUS | not null                       |                                         | Nouveau statut                               |
| **changed_by**      | UUID            | null                           | fk_payments_history_changed_by_users    | UUID de la personne qui à changé le statut |
| **changed_at**      | TIMESTAMPTZ     | not null                       |                                         | Timestamp du moment du changement            |
| **reason**          | TEXT            | null                           |                                         | Raison du changement                         |

### users_status

A reference table defining the current operational state of a user account, such as active or suspended.

| Name            | Type    | Settings                       | References | Note                                    |
| --------------- | ------- | ------------------------------ | ---------- | --------------------------------------- |
| **id**    | INTEGER | 🔑 PK, not null, autoincrement |            | ID unique du statut de l'utilisateur    |
| **code**  | TEXT    | not null, unique               |            | Code unique du statut de l'utilisateur  |
| **label** | TEXT    | not null, unique               |            | Label unique du statut de l'utilisateur |

#### Unique constraints

| Name                  | Columns     |
| --------------------- | ----------- |
| users_status_unique_0 | code, label |

## Relationships

- **competitions to season**: many_to_one
- **licenses to season**: many_to_one
- **practice_site to municipalities**: many_to_one
- **competitions to municipalities**: many_to_one
- **competitions to practice_site**: many_to_one
- **competitions to persons**: many_to_one
- **competitions to competition_format**: many_to_one
- **competition_participant to persons**: many_to_one
- **games to competitions**: many_to_one
- **games to game_format**: many_to_one
- **team to competitions**: many_to_one
- **team_members to persons**: many_to_one
- **team_members to team**: many_to_one
- **game_side to games**: many_to_one
- **game_side_result to game_side**: many_to_one
- **competition_participant to licenses**: many_to_one
- **game_participant to game_side**: many_to_one
- **game_participant to persons**: many_to_one
- **users to persons**: many_to_one
- **licenses to license_type**: many_to_one
- **slots to practice_site**: many_to_one
- **slots to season**: many_to_one
- **referents to persons**: many_to_one
- **referents to practice_site**: many_to_one
- **sessions to slots**: many_to_one
- **sessions to referents**: many_to_one
- **session_participants to sessions**: many_to_one
- **session_participants to licenses**: many_to_one
- **session_participants to persons**: many_to_one
- **volunteers to persons**: many_to_one
- **volunteers to persons**: many_to_one
- **volunteers to municipalities**: many_to_one
- **contacts to persons**: many_to_one
- **contacts to organizations**: many_to_one
- **contacts to persons**: many_to_one
- **users_roles to users**: many_to_one
- **prospects to organizations**: many_to_one
- **organizations_contact to persons**: many_to_one
- **person_role to persons**: many_to_one
- **persons to municipalities**: many_to_one
- **person_role to roles**: many_to_one
- **competition_participant to competitions**: many_to_one
- **documents to document_type**: many_to_one
- **licenses to documents**: many_to_one
- **municipalities to departments**: many_to_one
- **departments to regions**: many_to_one
- **regions to countries**: many_to_one
- **referents to referent_status**: many_to_one
- **organizations to organizations_type**: many_to_one
- **users_roles to access_roles**: many_to_one
- **prospects to persons**: many_to_one
- **organizations to municipalities**: many_to_one
- **organizations_contact to organizations**: many_to_one
- **competitions to documents**: many_to_one
- **licenses to persons**: many_to_one
- **consents to consents_type**: many_to_one
- **consents to persons**: many_to_one
- **documents to users**: many_to_one
- **competitions to competition_status**: many_to_one
- **documents_persons to documents**: one_to_one
- **documents_practices_sites to documents**: one_to_one
- **documents_commissions to documents**: one_to_one
- **documents_projects to documents**: one_to_one
- **documents_competitions to documents**: one_to_one
- **documents_licenses to documents**: one_to_one
- **documents_organizations to documents**: one_to_one
- **documents_organizations to organizations**: one_to_one
- **documents_competitions to competitions**: one_to_one
- **documents_licenses to licenses**: one_to_one
- **documents_persons to persons**: one_to_one
- **projects to projects_status**: many_to_one
- **projects_members to projects**: one_to_one
- **projects_members to persons**: one_to_one
- **projects_members to project_members_role**: many_to_one
- **documents_projects to projects**: one_to_one
- **commissions to persons**: many_to_one
- **commissions_members to commissions**: one_to_one
- **commissions_members to persons**: one_to_one
- **documents_commissions to commissions**: one_to_one
- **competition_participant to competition_participant_category**: many_to_one
- **competition_participant to competition_participant_status**: many_to_one
- **payments_history to payments**: many_to_one
- **payments to documents**: many_to_one
- **payments to persons**: many_to_one
- **payments to licenses**: many_to_one
- **documents_practices_sites to practice_site**: one_to_one
- **sessions to persons**: many_to_one
- **users to users_status**: many_to_one
- **payments_history to users**: many_to_one

## Database Diagram

```mermaid
erDiagram
	competitions }o--|| season : references
	licenses }o--|| season : references
	practice_site }o--|| municipalities : references
	competitions }o--|| municipalities : references
	competitions }o--|| practice_site : references
	competitions }o--|| persons : references
	competitions }o--|| competition_format : references
	competition_participant }o--|| persons : references
	games }o--|| competitions : references
	games }o--|| game_format : references
	team }o--|| competitions : references
	team_members }o--|| persons : references
	team_members }o--|| team : references
	game_side }o--|| games : references
	game_side_result }o--|| game_side : references
	competition_participant }o--|| licenses : references
	game_participant }o--|| game_side : references
	game_participant }o--|| persons : references
	users }o--|| persons : references
	licenses }o--|| license_type : references
	slots }o--|| practice_site : references
	slots }o--|| season : references
	referents }o--|| persons : references
	referents }o--|| practice_site : references
	sessions }o--|| slots : references
	sessions }o--|| referents : references
	session_participants }o--|| sessions : references
	session_participants }o--|| licenses : references
	session_participants }o--|| persons : references
	volunteers }o--|| persons : references
	volunteers }o--|| persons : references
	volunteers }o--|| municipalities : references
	contacts }o--|| persons : references
	contacts }o--|| organizations : references
	contacts }o--|| persons : references
	users_roles }o--|| users : references
	prospects }o--|| organizations : references
	organizations_contact }o--|| persons : references
	person_role }o--|| persons : references
	persons }o--|| municipalities : references
	person_role }o--|| roles : references
	competition_participant }o--|| competitions : references
	documents }o--|| document_type : references
	licenses }o--|| documents : references
	municipalities }o--|| departments : references
	departments }o--|| regions : references
	regions }o--|| countries : references
	referents }o--|| referent_status : references
	organizations }o--|| organizations_type : references
	users_roles }o--|| access_roles : references
	prospects }o--|| persons : references
	organizations }o--|| municipalities : references
	organizations_contact }o--|| organizations : references
	competitions }o--|| documents : references
	licenses }o--|| persons : references
	consents }o--|| consents_type : references
	consents }o--|| persons : references
	documents }o--|| users : references
	competitions }o--|| competition_status : references
	documents_persons ||--|| documents : references
	documents_practices_sites ||--|| documents : references
	documents_commissions ||--|| documents : references
	documents_projects ||--|| documents : references
	documents_competitions ||--|| documents : references
	documents_licenses ||--|| documents : references
	documents_organizations ||--|| documents : references
	documents_organizations ||--|| organizations : references
	documents_competitions ||--|| competitions : references
	documents_licenses ||--|| licenses : references
	documents_persons ||--|| persons : references
	projects }o--|| projects_status : references
	projects_members ||--|| projects : references
	projects_members ||--|| persons : references
	projects_members }o--|| project_members_role : references
	documents_projects ||--|| projects : references
	commissions }o--|| persons : references
	commissions_members ||--|| commissions : references
	commissions_members ||--|| persons : references
	documents_commissions ||--|| commissions : references
	competition_participant }o--|| competition_participant_category : references
	competition_participant }o--|| competition_participant_status : references
	payments_history }o--|| payments : references
	payments }o--|| documents : references
	payments }o--|| persons : references
	payments }o--|| licenses : references
	documents_practices_sites ||--|| practice_site : references
	sessions }o--|| persons : references
	users }o--|| users_status : references
	payments_history }o--|| users : references

	persons {
		UUID ff2b_id
		TEXT first_name
		TEXT last_name
		DATE birthdate
		TEXT phone_number
		TEXT email
		VARCHAR(40) status
		CONTACT_ORIGIN contact_origin
		VARCHAR(255) address
		INTEGER municipality_id
		TIMESTAMPTZ creation_date
	}

	person_role {
		INTEGER id
		SMALLINT role_id
		UUID person_id
	}

	roles {
		SMALLINT id
		TEXT code
		TEXT label
	}

	licenses {
		UUID id
		INTEGER license_type
		UUID person_id
		INTEGER season
		DATE request_date
		DATE validation_date
		DATE beginning_date
		DATE end_date
		LICENCE_STATUS license_status
		UUID document_id
	}

	license_type {
		INTEGER id
		TEXT license_code
		TEXT license_label
	}

	season {
		INTEGER id
		SMALLINT start_year
		SMALLINT end_year
	}

	municipalities {
		INTEGER id
		TEXT name
		TEXT zip_code
		VARCHAR(10) insee_code
		INTEGER departement_id
		TEXT development_status
	}

	departments {
		INTEGER id
		TEXT name
		TEXT code
		INTEGER region_id
	}

	regions {
		INTEGER id
		TEXT name
		TEXT code
		INTEGER country_id
	}

	countries {
		INTEGER id
		TEXT name
		TEXT code
	}

	practice_site {
		INTEGER id
		TEXT name
		INTEGER municipality_id
		TEXT address
		DATE opening_date
		DATE closing_date
	}

	slots {
		INTEGER id
		INTEGER site_id
		INTEGER season_id
		TIME start_at
		TIME end_at
		SMALLINT capacity
		SMALLINT day_of_week
	}

	sessions {
		INTEGER id
		INTEGER slot_id
		TIMESTAMPTZ start_time
		SMALLINT duration
		INTEGER referent_id
		UUID coach_id
		TEXT content
		SEANCE_STATUS status
	}

	session_participants {
		INTEGER id
		UUID person_id
		INTEGER session_id
		UUID license_id
		BOOLEAN presence
	}

	competitions {
		INTEGER id
		INTEGER season_id
		DATE date
		INTEGER location_id
		INTEGER practice_site_id
		UUID organizer_id
		SMALLINT format_id
		INTEGER status
		UUID rules_document_id
	}

	competition_format {
		SMALLINT id
		TEXT code
		TEXT label
	}

	competition_status {
		INTEGER id
		TEXT code
		TEXT label
	}

	competition_participant {
		INTEGER id
		INTEGER competition_id
		UUID person_id
		INTEGER status
		INTEGER category
		UUID license_id
		SMALLINT ranking_before
		SMALLINT ranking_after
	}

	competition_participant_status {
		INTEGER id
		TEXT code
		TEXT label
	}

	competition_participant_category {
		INTEGER id
		TEXT code
		TEXT label
	}

	games {
		INTEGER id
		INTEGER competition_id
		SMALLINT format_id
		TIMESTAMPTZ date
	}

	game_format {
		SMALLINT id
		TEXT code
		TEXT label
	}

	game_participant {
		INTEGER id
		INTEGER game_side_id
		SMALLINT ranking_before
		SMALLINT ranking_after
		SMALLINT elo_before
		SMALLINT elo_after
		UUID person_id
	}

	game_side {
		INTEGER id
		INTEGER game_id
		SMALLINT side_number
	}

	game_side_result {
		INTEGER id
		INTEGER game_side_id
		SMALLINT nieshs_scored
		SMALLINT nieshs_conceded
		SMALLINT result
	}

	team {
		INTEGER id
		INTEGER competition_id
		TEXT name
	}

	team_members {
		INTEGER team_id
		UUID person_id
	}

	referents {
		INTEGER id
		UUID person_id
		INTEGER site_id
		DATE start_date
		DATE end_date
		TEXT professionnal_phone
		TEXT professionnal_mail
		INTEGER status
	}

	referent_status {
		INTEGER id
		TEXT code
		TEXT label
	}

	volunteers {
		INTEGER id
		UUID person_id
		UUID manager_id
		TEXT mission
		TEXT skills
		TEXT availability
		INTEGER location
		DATE application_date
		TEXT observations
		DATE start_date
		DATE end_date
		TEXT tasks
	}

	organizations {
		INTEGER id
		TEXT name
		SMALLINT organization_type_id
		INTEGER municipality_id
	}

	organizations_type {
		SMALLINT id
		TEXT code
		TEXT label
	}

	organizations_contact {
		INTEGER id
		INTEGER organization_id
		UUID person_id
		TEXT function
		DATE start_date
		DATE end_date
	}

	prospects {
		INTEGER id
		UUID person_id
		INTEGER organization_id
		TEXT type
		TEXT status
		TEXT interest
	}

	contacts {
		INTEGER id
		UUID person_id
		INTEGER organization_id
		TIMESTAMPTZ date
		UUID responsible_id
		TEXT subject
		TEXT notes
	}

	users {
		UUID id
		UUID person_id
		TEXT email
		TEXT password
		SMALLINT statut
		TIMESTAMPTZ creation_date
	}

	access_roles {
		INTEGER id
		TEXT code
		TEXT label
	}

	users_roles {
		INTEGER role_id
		UUID user_id
	}

	consents {
		INTEGER id
		UUID person_id
		INTEGER consent_type_id
		TIMESTAMPTZ given_at
		BOOLEAN is_accepted
	}

	consents_type {
		INTEGER id
		TEXT code
		TEXT label
		TEXT description
		BOOLEAN is_mandatory
	}

	documents {
		UUID id
		TEXT filename
		TEXT storage_path
		SMALLINT document_type_id
		TIMESTAMPTZ creation_date
		VARCHAR(40) mime_type
		INTEGER file_size
		VARCHAR(64) hash
		UUID uploaded_by
		TIMESTAMPTZ expires_at
	}

	document_type {
		SMALLINT id
		TEXT document_code
		TEXT document_label
	}

	documents_persons {
		UUID document_id
		UUID person_id
	}

	documents_competitions {
		UUID document_id
		INTEGER competition_id
	}

	documents_licenses {
		UUID document_id
		UUID license_id
	}

	documents_projects {
		UUID document_id
		INTEGER project_id
	}

	documents_commissions {
		UUID document_id
		INTEGER commission_id
	}

	documents_organizations {
		UUID document_id
		INTEGER organization_id
	}

	documents_practices_sites {
		UUID document_id
		INTEGER practice_site_id
	}

	projects {
		INTEGER id
		TEXT name
		TEXT description
		SMALLINT status
		DATE start_date
		DATE end_date
	}

	projects_members {
		INTEGER project_id
		UUID person_id
		INTEGER project_role
		DATE joined_at
	}

	project_members_role {
		INTEGER id
		TEXT code
		TEXT label
	}

	projects_status {
		SMALLINT id
		TEXT code
		TEXT label
	}

	commissions {
		INTEGER id
		TEXT name
		TEXT code
		TEXT description
		UUID president_id
		TIMESTAMPTZ creation_date
	}

	commissions_members {
		INTEGER commission_id
		UUID person_id
		DATE joined_at
	}

	payments {
		UUID id
		UUID person_id
		UUID license_id
		NUMERIC(8,2) amount
		VARCHAR(3) currency
		PAYMENTS_METHOD payment_method
		PAYMENTS_STATUS payment_status
		TIMESTAMPTZ payment_date
		TEXT transaction_reference
		UUID invoice_document
		TEXT notes
		TIMESTAMPTZ created_at
		TIMESTAMPTZ updated_at
	}

	payments_history {
		INTEGER id
		UUID payment_id
		PAYMENTS_STATUS previous_status
		PAYMENTS_STATUS new_status
		UUID changed_by
		TIMESTAMPTZ changed_at
		TEXT reason
	}

	users_status {
		INTEGER id
		TEXT code
		TEXT label
	}
```
