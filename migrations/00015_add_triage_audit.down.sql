ALTER TABLE "cases" RENAME COLUMN "triage_response_type" TO "response_type";
ALTER TABLE "cases" RENAME COLUMN "triage_response_link" TO "response_link";
ALTER TABLE "cases" RENAME COLUMN "triage_estimated_resolved_at" TO "estimated_resolve_at";
ALTER TABLE "cases"
    DROP COLUMN IF EXISTS "triaged_by_id",
    DROP COLUMN IF EXISTS "triaged_by_name",
    DROP COLUMN IF EXISTS "triaged_at";
