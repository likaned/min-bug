DELETE FROM "case_histories";
COMMIT;

ALTER TABLE "case_histories"
    ADD COLUMN IF NOT EXISTS "status"                       text,
    ADD COLUMN IF NOT EXISTS "acknowledged_by_id"           text,
    ADD COLUMN IF NOT EXISTS "acknowledged_by_name"         text,
    ADD COLUMN IF NOT EXISTS "acknowledged_at"              timestamptz,
    ADD COLUMN IF NOT EXISTS "assurance_review_by_id"       text,
    ADD COLUMN IF NOT EXISTS "assurance_review_by_name"     text,
    ADD COLUMN IF NOT EXISTS "assurance_review_at"          timestamptz,
    ADD COLUMN IF NOT EXISTS "assurance_review_comments"    text,
    ADD COLUMN IF NOT EXISTS "triaged_by_id"                text,
    ADD COLUMN IF NOT EXISTS "triaged_by_name"              text,
    ADD COLUMN IF NOT EXISTS "triaged_at"                   timestamptz,
    ADD COLUMN IF NOT EXISTS "triage_response_type"         text,
    ADD COLUMN IF NOT EXISTS "triage_response_link"         text,
    ADD COLUMN IF NOT EXISTS "triage_estimated_resolved_at" timestamptz,
    ADD COLUMN IF NOT EXISTS "triage_comments"              text,

    DROP COLUMN IF EXISTS "user_id",
    DROP COLUMN IF EXISTS "user_name",
    DROP COLUMN IF EXISTS "action_type",
    DROP COLUMN IF EXISTS "action_uid",
    DROP COLUMN IF EXISTS "attribute_name",
    DROP COLUMN IF EXISTS "attribute_type",
    DROP COLUMN IF EXISTS "attribute_value";
