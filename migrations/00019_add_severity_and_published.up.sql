BEGIN;

ALTER TABLE "cases"
    ADD COLUMN IF NOT EXISTS "severity" TEXT,
    ADD COLUMN IF NOT EXISTS "published" BOOLEAN DEFAULT FALSE;

UPDATE cases SET severity = 'Draft';
UPDATE cases SET severity = 'Customer-critical' where bot_id = 'XBC-001';
UPDATE cases SET severity = 'Customer-critical' where bot_id = 'XBC-002';
UPDATE cases SET severity = 'Critical' where bot_id = 'XC-003';
UPDATE cases SET severity = 'Critical' where bot_id = 'XBC-003_STC-195';
UPDATE cases SET severity = 'Critical' where bot_id = 'XBC-003_STC-341';
UPDATE cases SET severity = 'Critical' where bot_id = 'XBC-003_STC-343';
UPDATE cases SET published = TRUE WHERE severity in ('Customer-critical', 'Critical');

COMMIT;
