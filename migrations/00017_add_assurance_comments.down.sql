ALTER TABLE "cases" RENAME COLUMN "triage_comments" TO "comments";
ALTER TABLE "cases" DROP COLUMN IF EXISTS "assurance_review_comments";
