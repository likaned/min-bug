UPDATE cases SET segment = 'Business' WHERE segment = 'Situational';
UPDATE cases SET segment = 'Technology' WHERE segment = 'Generic';
UPDATE issues SET segment = 'Business' WHERE segment = 'Situational';
UPDATE issues SET segment = 'Technology' WHERE segment = 'Generic';