BEGIN;

DROP INDEX IF EXISTS "unique_issue";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_issue" ON "issues" ("title", "segment", "bot_id", "entity_id",
                                                              "sub_entity_id", "issue_tag", "case_tag", "case_id") WHERE "status" != 'Closed';

COMMIT;