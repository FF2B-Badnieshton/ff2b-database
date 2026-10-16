-- Verify ff2b_db:persons_document_mentions on pg

BEGIN;

-- Verify table and columns exist
SELECT
    person_id,
    document_id
FROM persons_documents_mentions
WHERE FALSE;

-- Verify primary key
SELECT 1 / (
    COUNT(*) = 1
)::INTEGER
FROM pg_constraint
WHERE conrelid = 'persons_documents_mentions'::regclass
  AND conname = 'pk_persons_documents_mentions'
  AND contype = 'p';

-- Verify foreign keys
SELECT 1 / (
    COUNT(*) = 2
)::INTEGER
FROM pg_constraint
WHERE conrelid = 'persons_documents_mentions'::regclass
  AND contype = 'f'
  AND conname IN (
      'fk_persons_documents_mentions_person_id_ff2b_id_persons',
      'fk_persons_documents_mentions_document_id_id_documents'
  );

ROLLBACK;
