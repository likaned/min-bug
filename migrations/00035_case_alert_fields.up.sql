ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "alert_activated_at" timestamptz;
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "alert_reason" text;
