BEGIN;

DELETE FROM "activities";
DELETE FROM "case_histories";
DELETE FROM "issues";
DELETE FROM "cases";

DROP INDEX IF EXISTS "unique_issue";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_issue" ON "issues" ("segment", "bot_id", "entity_id",
                                                              "sub_entity_id", "issue_tag", "case_tag", "case_id") WHERE "status" != 'Closed';

COMMIT;
