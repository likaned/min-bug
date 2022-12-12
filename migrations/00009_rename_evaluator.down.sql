BEGIN;

UPDATE activities SET bot_id = 'Blocked Cards Bot' WHERE bot_id = 'XBC-001';
UPDATE cases SET bot_id = 'Blocked Cards Bot' WHERE bot_id = 'XBC-001';
UPDATE issues SET bot_id = 'Blocked Cards Bot' WHERE bot_id = 'XBC-001';

UPDATE activities SET bot_id = 'Pay Limit Bot' WHERE bot_id = 'XBC-002';
UPDATE cases SET bot_id = 'Pay Limit Bot' WHERE bot_id = 'XBC-002';
UPDATE issues SET bot_id = 'Pay Limit Bot' WHERE bot_id = 'XBC-002';

UPDATE activities SET bot_id = 'Data Quality Bot' WHERE bot_id = 'XBC-003';
UPDATE cases SET bot_id = 'Data Quality Bot' WHERE bot_id = 'XBC-003';
UPDATE issues SET bot_id = 'Data Quality Bot' WHERE bot_id = 'XBC-003';

UPDATE activities SET bot_id = 'Twistlock Container' WHERE bot_id = 'XC-001.01';
UPDATE cases SET bot_id = 'Twistlock Container' WHERE bot_id = 'XC-001.01';
UPDATE issues SET bot_id = 'Twistlock Container' WHERE bot_id = 'XC-001.01';

UPDATE activities SET bot_id = 'Twistlock Images' WHERE bot_id = 'XC-001.02';
UPDATE cases SET bot_id = 'Twistlock Images' WHERE bot_id = 'XC-001.02';
UPDATE issues SET bot_id = 'Twistlock Images' WHERE bot_id = 'XC-001.02';

UPDATE activities SET bot_id = 'User Access Management' WHERE bot_id = 'XC-002';
UPDATE cases SET bot_id = 'User Access Management' WHERE bot_id = 'XC-002';
UPDATE issues SET bot_id = 'User Access Management' WHERE bot_id = 'XC-002';

UPDATE activities SET bot_id = 'CMEK' WHERE bot_id = 'XC-003';
UPDATE cases SET bot_id = 'CMEK' WHERE bot_id = 'XC-003';
UPDATE issues SET bot_id = 'CMEK' WHERE bot_id = 'XC-003';

ALTER TABLE activities RENAME COLUMN bot_id TO evaluator;
ALTER TABLE cases RENAME COLUMN bot_id TO evaluator;
ALTER TABLE issues RENAME COLUMN bot_id TO evaluator;

COMMIT;