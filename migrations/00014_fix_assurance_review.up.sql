ALTER TABLE "cases" RENAME COLUMN "assurance_review_by" TO "assurance_review_by_id";
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "assurance_review_by_name" text;
