ALTER TABLE "issues" DROP COLUMN IF EXISTS "status";

ALTER TABLE "cases" DROP COLUMN IF EXISTS "assigned_to_id";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "assigned_to_name";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "response_type";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "response_link";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "estimated_resolve_at";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "comments";

DROP TABLE IF EXISTS public.case_histories;
