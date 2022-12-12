CREATE TABLE IF NOT EXISTS "cases"
(
    "id"            bigserial,
    "created_at"    timestamptz,
    "updated_at"    timestamptz,
    "deleted_at"    timestamptz,
    "segment"       text,
    "status"        text,
    "entity_id"     text,
    "sub_entity_id" text,
    "control_id"    text,
    "title"         text,
    "description"   text,
    "evaluator"     text,
    "case_tag"      text,
    "auto_close"    boolean,
    PRIMARY KEY ("id")
);

CREATE INDEX IF NOT EXISTS "idx_cases_deleted_at" ON "cases" ("deleted_at");

CREATE TABLE IF NOT EXISTS "issues"
(
    "id"            bigserial,
    "created_at"    timestamptz,
    "updated_at"    timestamptz,
    "deleted_at"    timestamptz,
    "segment"       text,
    "title"         text,
    "description"   text,
    "evaluator"     text,
    "severity"      text,
    "entity_id"     text,
    "sub_entity_id" text,
    "issue_tag"     text,
    "case_tag"      text,
    "case_id"       bigint,
    "control_id"    text,
    "auto_close"    boolean,
    PRIMARY KEY ("id"),
    CONSTRAINT "fk_cases_issues" FOREIGN KEY ("case_id") REFERENCES "cases" ("id")
);

CREATE UNIQUE INDEX IF NOT EXISTS "unique_issue" ON "issues" ("title", "description", "evaluator", "severity",
                                                              "entity_id", "sub_entity_id", "issue_tag", "case_tag",
                                                              "case_id");

CREATE INDEX IF NOT EXISTS "idx_issues_deleted_at" ON "issues" ("deleted_at");

CREATE TABLE IF NOT EXISTS "activities"
(
    "id"            bigserial,
    "created_at"    timestamptz,
    "updated_at"    timestamptz,
    "deleted_at"    timestamptz,
    "segment"       text,
    "evaluator"     text,
    "entity_id"     text,
    "sub_entity_id" text,
    PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX IF NOT EXISTS "unique_activity" ON "activities" ("evaluator", "entity_id", "sub_entity_id");

CREATE INDEX IF NOT EXISTS "idx_activities_deleted_at" ON "activities" ("deleted_at");
