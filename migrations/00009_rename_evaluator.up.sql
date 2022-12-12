BEGIN;

ALTER TABLE activities RENAME COLUMN evaluator TO bot_id;
ALTER TABLE cases RENAME COLUMN evaluator TO bot_id;
ALTER TABLE issues RENAME COLUMN evaluator TO bot_id;

UPDATE activities SET bot_id = 'XBC-001' WHERE bot_id = 'Blocked Cards Bot';
UPDATE cases SET bot_id = 'XBC-001' WHERE bot_id = 'Blocked Cards Bot';
UPDATE issues SET bot_id = 'XBC-001' WHERE bot_id = 'Blocked Cards Bot';

UPDATE activities SET bot_id = 'XBC-002' WHERE bot_id = 'Pay Limit Bot';
UPDATE cases SET bot_id = 'XBC-002' WHERE bot_id = 'Pay Limit Bot';
UPDATE issues SET bot_id = 'XBC-002' WHERE bot_id = 'Pay Limit Bot';

UPDATE activities SET bot_id = 'XBC-003' WHERE bot_id = 'Data Quality Bot';
UPDATE cases SET bot_id = 'XBC-003' WHERE bot_id = 'Data Quality Bot';
UPDATE issues SET bot_id = 'XBC-003' WHERE bot_id = 'Data Quality Bot';

UPDATE activities SET bot_id = 'XC-001.01' WHERE bot_id = 'Twistlock Container';
UPDATE cases SET bot_id = 'XC-001.01' WHERE bot_id = 'Twistlock Container';
UPDATE issues SET bot_id = 'XC-001.01' WHERE bot_id = 'Twistlock Container';

UPDATE activities SET bot_id = 'XC-001.02' WHERE bot_id = 'Twistlock Images';
UPDATE cases SET bot_id = 'XC-001.02' WHERE bot_id = 'Twistlock Images';
UPDATE issues SET bot_id = 'XC-001.02' WHERE bot_id = 'Twistlock Images';

UPDATE activities SET bot_id = 'XC-002' WHERE bot_id = 'User Access Management';
UPDATE cases SET bot_id = 'XC-002' WHERE bot_id = 'User Access Management';
UPDATE issues SET bot_id = 'XC-002' WHERE bot_id = 'User Access Management';

UPDATE activities SET bot_id = 'XC-003' WHERE bot_id = 'CMEK';
UPDATE cases SET bot_id = 'XC-003' WHERE bot_id = 'CMEK';
UPDATE issues SET bot_id = 'XC-003' WHERE bot_id = 'CMEK';

COMMIT;