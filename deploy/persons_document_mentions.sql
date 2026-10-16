-- Deploy ff2b_db:persons_document_mentions to pg

BEGIN;

CREATE TABLE IF NOT EXISTS "persons_documents_mentions" (
    -- UUID of the person referencing persons table
    "person_id" UUID NOT NULL,
    -- UUID of the document referencing documents table
    "document_id" UUID NOT NULL,

     CONSTRAINT "pk_persons_documents_mentions"
        PRIMARY KEY ("person_id", "document_id"),

    CONSTRAINT "fk_persons_documents_mentions_person_id_ff2b_id_persons"
        FOREIGN KEY ("person_id")
        REFERENCES "persons" ("ff2b_id")
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT "fk_persons_documents_mentions_document_id_id_documents"
        FOREIGN KEY ("document_id")
        REFERENCES "documents" ("id")
        ON DELETE CASCADE
        ON UPDATE NO ACTION
);

COMMENT ON COLUMN "persons_documents_mentions"."person_id" IS 'UUID of the person referencing persons table';
COMMENT ON COLUMN "persons_documents_mentions"."document_id" IS 'UUID of the document referencing documents table';


COMMIT;
