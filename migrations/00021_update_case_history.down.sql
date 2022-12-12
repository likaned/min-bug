DELETE FROM "case_histories";
COMMIT;

ALTER TABLE "case_histories"
    DROP COLUMN IF EXISTS "status",
    DROP COLUMN IF EXISTS "acknowledged_by_id",
    DROP COLUMN IF EXISTS "acknowledged_by_name",
    DROP COLUMN IF EXISTS "acknowledged_at",
    DROP COLUMN IF EXISTS "assurance_review_by_id",
    DROP COLUMN IF EXISTS "assurance_review_by_name",
    DROP COLUMN IF EXISTS "assurance_review_at",
    DROP COLUMN IF EXISTS "assurance_review_comments",
    DROP COLUMN IF EXISTS "triaged_by_id",
    DROP COLUMN IF EXISTS "triaged_by_name",
    DROP COLUMN IF EXISTS "triaged_at",
    DROP COLUMN IF EXISTS "triage_response_type",
    DROP COLUMN IF EXISTS "triage_response_link",
    DROP COLUMN IF EXISTS "triage_estimated_resolved_at",
    DROP COLUMN IF EXISTS "triage_comments",

    ADD COLUMN IF NOT EXISTS "user_id"         text,
    ADD COLUMN IF NOT EXISTS "user_name"       text,
    ADD COLUMN IF NOT EXISTS "action_type"     text,
    ADD COLUMN IF NOT EXISTS "action_uid"      text,
    ADD COLUMN IF NOT EXISTS "attribute_name"  text,
    ADD COLUMN IF NOT EXISTS "attribute_type"  text,
    ADD COLUMN IF NOT EXISTS "attribute_value" text;
