BEGIN;

UPDATE cases SET bot_id = 'BOT-001' where bot_id = 'XBC-001';
UPDATE cases SET bot_id = 'BOT-002' where bot_id = 'XBC-002';
UPDATE cases SET bot_id = 'BOT-003' where bot_id = 'XC-001.01';
UPDATE cases SET bot_id = 'BOT-004' where bot_id = 'XC-001.02';
UPDATE cases SET bot_id = 'BOT-005' where bot_id = 'XC-002';
UPDATE cases SET bot_id = 'BOT-006' where bot_id = 'XC-003';
UPDATE cases SET bot_id = 'BOT-007' where bot_id = 'XBC-003_STC-195';
UPDATE cases SET bot_id = 'BOT-008' where bot_id = 'XBC-003_STC-341';
UPDATE cases SET bot_id = 'BOT-009' where bot_id = 'XBC-003_STC-343';

UPDATE issues SET bot_id = 'BOT-001' where bot_id = 'XBC-001';
UPDATE issues SET bot_id = 'BOT-002' where bot_id = 'XBC-002';
UPDATE issues SET bot_id = 'BOT-003' where bot_id = 'XC-001.01';
UPDATE issues SET bot_id = 'BOT-004' where bot_id = 'XC-001.02';
UPDATE issues SET bot_id = 'BOT-005' where bot_id = 'XC-002';
UPDATE issues SET bot_id = 'BOT-006' where bot_id = 'XC-003';
UPDATE issues SET bot_id = 'BOT-007' where bot_id = 'XBC-003_STC-195';
UPDATE issues SET bot_id = 'BOT-008' where bot_id = 'XBC-003_STC-341';
UPDATE issues SET bot_id = 'BOT-009' where bot_id = 'XBC-003_STC-343';


COMMIT;
