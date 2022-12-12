ALTER TABLE "issues"
    ADD COLUMN IF NOT EXISTS "status" text;

UPDATE "issues" SET
    "status" = 'Open'
WHERE "status" is null;

ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "assigned_to_id" text;
ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "assigned_to_name" text;
ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "response_type" text;
ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "response_link" text;
ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "estimated_resolve_at" timestamptz;
ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "comments" text;

CREATE TABLE "case_histories"
(
    "id"              bigserial,
    "created_at"      timestamptz,
    "case_id"         bigint,
    "user_id"         text,
    "user_name"       text,
    "action_type"     text,
    "action_uid"      text,
    "attribute_name"  text,
    "attribute_type"  text,
    "attribute_value" text,
    PRIMARY KEY ("id"),
    CONSTRAINT "fk_case_histories_case" FOREIGN KEY ("case_id") REFERENCES "cases" ("id")
)