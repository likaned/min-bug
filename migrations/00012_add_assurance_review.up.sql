ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "assurance_review_by" text,
    ADD COLUMN IF NOT EXISTS "assurance_review_at" timestamptz;
