-- Revert ff2b_db:persons_document_mentions from pg

BEGIN;

DROP TABLE IF EXISTS "persons_documents_mentions";

COMMIT;
