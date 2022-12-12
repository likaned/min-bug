ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "asset_id" text;
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "component_id" text;
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "goal_id" text;
ALTER TABLE "cases" ADD COLUMN IF NOT EXISTS "episode_id" text;

UPDATE cases SET asset_id = entity_id, component_id = sub_entity_id WHERE segment = 'Generic';
UPDATE cases SET goal_id = entity_id, episode_id = sub_entity_id WHERE segment = 'Situational';

ALTER TABLE "activities" ADD COLUMN IF NOT EXISTS "asset_id" text;
ALTER TABLE "activities" ADD COLUMN IF NOT EXISTS "component_id" text;
ALTER TABLE "activities" ADD COLUMN IF NOT EXISTS "goal_id" text;
ALTER TABLE "activities" ADD COLUMN IF NOT EXISTS "episode_id" text;

UPDATE activities SET asset_id = entity_id, component_id = sub_entity_id WHERE segment = 'Generic';
UPDATE activities SET goal_id = entity_id, episode_id = sub_entity_id WHERE segment = 'Situational';

DROP INDEX IF EXISTS "unique_case";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_case"
ON "cases" ("segment", "bot_id", "asset_id", "component_id", "goal_id", "episode_id", "case_tag") WHERE "status" != 'Closed';

DROP INDEX IF EXISTS "unique_activity";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_activity" ON "activities" ("bot_id", "asset_id", "component_id", "goal_id", "episode_id");