-- Deploy ff2b_db:arbitrator to pg

BEGIN;

ALTER TABLE "competitions"
ADD COLUMN "arbitrator" UUID REFERENCES "persons"("ff2b_id");

COMMENT ON COLUMN "competitions"."arbitrator" IS 'The arbitrator of the competition (optional)';



COMMIT;
