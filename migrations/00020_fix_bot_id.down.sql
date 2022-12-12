BEGIN;

UPDATE cases SET bot_id = 'XBC-001' where bot_id = 'BOT-001';
UPDATE cases SET bot_id = 'XBC-002' where bot_id = 'BOT-002';
UPDATE cases SET bot_id = 'XC-001.01' where bot_id = 'BOT-003';
UPDATE cases SET bot_id = 'XC-001.02' where bot_id = 'BOT-004';
UPDATE cases SET bot_id = 'XC-002' where bot_id = 'BOT-005';
UPDATE cases SET bot_id = 'XC-003' where bot_id = 'BOT-006';
UPDATE cases SET bot_id = 'XBC-003_STC-195' where bot_id = 'BOT-007';
UPDATE cases SET bot_id = 'XBC-003_STC-341' where bot_id = 'BOT-008';
UPDATE cases SET bot_id = 'XBC-003_STC-343' where bot_id = 'BOT-009';

UPDATE issues SET bot_id = 'XBC-001' where bot_id = 'BOT-001';
UPDATE issues SET bot_id = 'XBC-002' where bot_id = 'BOT-002';
UPDATE issues SET bot_id = 'XC-001.01' where bot_id = 'BOT-003';
UPDATE issues SET bot_id = 'XC-001.02' where bot_id = 'BOT-004';
UPDATE issues SET bot_id = 'XC-002' where bot_id = 'BOT-005';
UPDATE issues SET bot_id = 'XC-003' where bot_id = 'BOT-006';
UPDATE issues SET bot_id = 'XBC-003_STC-195' where bot_id = 'BOT-007';
UPDATE issues SET bot_id = 'XBC-003_STC-341' where bot_id = 'BOT-008';
UPDATE issues SET bot_id = 'XBC-003_STC-343' where bot_id = 'BOT-009';

COMMIT;
