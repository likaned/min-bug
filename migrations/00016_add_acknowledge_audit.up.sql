ALTER TABLE "cases" RENAME COLUMN "assigned_to_id" TO "acknowledged_by_id";
ALTER TABLE "cases" RENAME COLUMN "assigned_to_name" TO "acknowledged_by_name";
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "acknowledged_at" timestamptz;
