-- Deploy ff2b_db:competition_organizer to pg

BEGIN;


ALTER TABLE "competitions"
RENAME COLUMN "organizer_id" TO "director_id";

ALTER TABLE "competitions"
ADD COLUMN "organizing_organization_id" INTEGER,
ADD FOREIGN KEY ("organizing_organization_id") REFERENCES "organizations"("id") 
ON DELETE RESTRICT 
ON UPDATE NO ACTION;
COMMENT ON COLUMN "competitions"."organizing_organization_id" IS 'Identifier of the organization organizing the competition';
COMMENT ON COLUMN "competitions"."director_id" IS 'Identifier of the director (referencing persons table)';

COMMIT;
