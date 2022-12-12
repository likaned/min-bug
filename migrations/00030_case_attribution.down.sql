ALTER TABLE "cases" DROP COLUMN IF EXISTS "asset_id" text;
ALTER TABLE "cases" DROP COLUMN IF EXISTS "component_id" text;
ALTER TABLE "cases" DROP COLUMN IF EXISTS "goal_id" text;
ALTER TABLE "cases" DROP COLUMN IF EXISTS "episode_id" text;

UPDATE cases SET entity_id = asset_id, sub_entity_id = component_id WHERE segment = 'Generic';
UPDATE cases SET entity_id = goal_id, sub_entity_id = episode_id WHERE segment = 'Situational';

ALTER TABLE "activities" DROP COLUMN IF EXISTS "asset_id" text;
ALTER TABLE "activities" DROP COLUMN IF EXISTS "component_id" text;
ALTER TABLE "activities" DROP COLUMN IF EXISTS "goal_id" text;
ALTER TABLE "activities" DROP COLUMN IF EXISTS "episode_id" text;

UPDATE activities SET entity_id = asset_id, sub_entity_id = component_id WHERE segment = 'Generic';
UPDATE activities SET entity_id = goal_id, sub_entity_id = episode_id WHERE segment = 'Situational';

DROP INDEX IF EXISTS "unique_case";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_case"
ON "cases" ("segment", "bot_id", "entity_id", "sub_entity_id", "case_tag") WHERE "status" != 'Closed';

DROP INDEX IF EXISTS "unique_activity";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_activity" ON "activities" ("bot_id", "entity_id", "sub_entity_id");