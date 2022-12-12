DELETE FROM "case_histories";
COMMIT;

CREATE INDEX IF NOT EXISTS "idx_issues_case_id" ON "issues" ("case_id");
CREATE INDEX IF NOT EXISTS "idx_issues_created_at" ON "issues" ("created_at");
CREATE INDEX IF NOT EXISTS "idx_issues_status" ON "issues" ("status");
CREATE INDEX IF NOT EXISTS "idx_case_histories_case_id" ON "case_histories" ("case_id");
CREATE INDEX IF NOT EXISTS "idx_case_histories_created_at" ON "case_histories" ("created_at");
