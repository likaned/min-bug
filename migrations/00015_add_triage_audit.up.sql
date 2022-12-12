ALTER TABLE "cases" RENAME COLUMN "response_type" TO "triage_response_type";
ALTER TABLE "cases" RENAME COLUMN "response_link" TO "triage_response_link";
ALTER TABLE "cases" RENAME COLUMN "estimated_resolve_at" TO "triage_estimated_resolved_at";
ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "triaged_by_id" text,
    ADD COLUMN IF NOT EXISTS "triaged_by_name" text,
    ADD COLUMN IF NOT EXISTS "triaged_at" timestamptz;
