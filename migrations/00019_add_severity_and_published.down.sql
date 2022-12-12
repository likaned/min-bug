BEGIN;

UPDATE cases SET published = FALSE;
ALTER TABLE "cases"
    DROP COLUMN IF EXISTS "published",
    DROP COLUMN IF EXISTS "severity";

COMMIT;

