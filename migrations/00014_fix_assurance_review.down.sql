ALTER TABLE "cases" RENAME COLUMN "assurance_review_by_id" TO "assurance_review_by";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "assurance_review_by_name";
