ALTER TABLE "cases" RENAME COLUMN "acknowledged_by_id" TO "assigned_to_id";
ALTER TABLE "cases" RENAME COLUMN "acknowledged_by_name" TO "assigned_to_name"; 
ALTER TABLE "cases" DROP COLUMN IF EXISTS "acknowledged_at";
