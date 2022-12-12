DROP TABLE IF EXISTS "control_references";
DROP TABLE IF EXISTS "case_controls";
DROP INDEX IF EXISTS "unique_issue";
DROP INDEX IF EXISTS "unique_issue";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_issue" ON "issues" ("segment", "bot_id", "entity_id",
                                                              "sub_entity_id", "issue_tag", "case_tag", "case_id") WHERE "status" != 'Closed';