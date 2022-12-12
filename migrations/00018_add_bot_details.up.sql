ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "bot_title" text,
    ADD COLUMN IF NOT EXISTS "bot_link" text,
    ADD COLUMN IF NOT EXISTS "bot_icon_link" text;
