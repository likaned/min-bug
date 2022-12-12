ALTER TABLE "cases" RENAME COLUMN "comments" TO "triage_comments";
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "assurance_review_comments" text;
