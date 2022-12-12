DELETE FROM case_histories WHERE case_id IN (SELECT id FROM cases WHERE bot_id = 'BOT-006' AND severity = 'Draft');
DELETE FROM issues WHERE case_id IN (SELECT id FROM cases WHERE bot_id = 'BOT-006' AND severity = 'Draft');
DELETE FROM cases WHERE bot_id = 'BOT-006' AND severity = 'Draft';

CREATE UNIQUE INDEX IF NOT EXISTS "unique_case"
ON "cases" ("segment", "bot_id", "entity_id", "sub_entity_id", "case_tag") WHERE "status" != 'Closed';
