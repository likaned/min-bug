UPDATE cases SET segment = 'Situational' WHERE segment = 'Business';
UPDATE cases SET segment = 'Generic' WHERE segment = 'Technology';
UPDATE issues SET segment = 'Situational' WHERE segment = 'Business';
UPDATE issues SET segment = 'Generic' WHERE segment = 'Technology';