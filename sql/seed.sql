-- =============================================================================
-- SCRIPT D'INJECTION DES DONNÉES DE RÉFÉRENCE
-- =============================================================================

BEGIN;

INSERT INTO "countries" ("id", "name", "code") 
VALUES (1, 'France', 'FR') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO "regions" ("id", "name", "code", "country_id") 
VALUES (1, 'Guadeloupe', 'GP', 1) 
ON CONFLICT (id) DO NOTHING;

INSERT INTO "departments" ("id", "name", "code", "region_id") 
VALUES (1, 'Guadeloupe', '971', 1) 
ON CONFLICT (id) DO NOTHING;

INSERT INTO "municipalities" ("id", "name", "zip_code", "insee_code", "departement_id", "development_status") 
VALUES (1, 'Deshaies', '97126', '97111', 1, 'pilote') 
ON CONFLICT (id) DO NOTHING;

INSERT INTO "license_type" ("id", "license_code", "license_label") VALUES
(1, 'competition', 'Compétition'),
(2, 'loisir', 'Loisir'),
(3, 'jeune', 'Jeune')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "roles" ("id", "code", "label") VALUES
(1, 'licencie', 'Licencié'),
(2, 'referent_site', 'Référent de site'),
(3, 'coach', 'Entraîneur / Coach'),
(4, 'membre_bureau', 'Membre du bureau / Commission'),
(5, 'benevole', 'Bénévole')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "access_roles" ("id", "code", "label") VALUES
(1, 'admin', 'Admin'),
(2, 'gestionnaire', 'Gestionnaire'),
(3, 'viewer', 'Consultant')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "users_status" ("id", "code", "label") VALUES
(1, 'active', 'Actif'),
(2, 'inactive', 'Inactif'),
(3, 'suspended', 'Suspendu')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "document_type" ("id", "document_code", "document_label") VALUES
(1, 'medical_certificate', 'Certificat Médical'),
(2, 'identity_proof', 'Justificatif d''identité'),
(3, 'competition_rule', 'Règlement de Compétition'),
(4, 'invoice', 'Facture / Reçu de paiement')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "consents_type" ("id", "code", "label", "is_mandatory") VALUES
(1, 'image_right', 'Droit à l''image', FALSE),
(2, 'newsletter', 'Newsletter / Communications', FALSE)
ON CONFLICT (id) DO NOTHING;

INSERT INTO "seasons" ("id", "start_year", "end_year") VALUES
(1, 2025, 2026),
(2, 2026, 2027)
ON CONFLICT (id) DO NOTHING;

INSERT INTO "competition_format" ("id", "code", "label") VALUES
(1, 'simple', 'Simple'),
(2, 'double', 'Double'),
(3, 'mixte', 'Double Mixte')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "competition_status" ("id", "code", "label") VALUES
(1, 'ouverte', 'Inscriptions Ouvertes'),
(2, 'en_cours', 'En Cours'),
(3, 'cloturee', 'Clôturée'),
(4, 'annulee', 'Annulée')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "competition_participant_status" ("id", "code", "label") VALUES
(1, 'inscrit', 'Inscrit'),
(2, 'liste_attente', 'Liste d''attente'),
(3, 'forfait', 'Forfait')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "competition_participant_category" ("id", "code", "label") VALUES
(1, 'senior', 'Sénior'),
(2, 'veteran', 'Vétéran'),
(3, 'jeune', 'Jeune')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "game_format" ("id", "code", "label") VALUES
(1, 'un_set', 'Set unique (21 pts)'),
(2, 'deux_sets_gagnants', '2 sets gagnants (21 pts)')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "projects_status" ("id", "code", "label") VALUES
(1, 'en_etude', 'En étude'),
(2, 'actif', 'Actif'),
(3, 'termine', 'Terminé'),
(4, 'suspendu', 'Suspendu')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "project_members_role" ("id", "code", "label") VALUES
(1, 'chef_projet', 'Chef de projet'),
(2, 'contributeur', 'Contributeur'),
(3, 'observateur', 'Observateur')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "referent_status" ("id", "code", "label") VALUES
(1, 'titulaire', 'Titulaire'),
(2, 'adjoint', 'Adjoint')
ON CONFLICT (id) DO NOTHING;

INSERT INTO "organizations_type" ("id", "code", "label") VALUES
(1, 'club', 'Club affilié'),
(2, 'sponsor', 'Sponsor / Partenaire'),
(3, 'institution', 'Institution publique')
ON CONFLICT (id) DO NOTHING;

COMMIT;