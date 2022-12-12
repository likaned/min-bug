DROP INDEX IF EXISTS "unique_case";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_case"
    ON "cases" ("control_type", "bot_id", "asset_id", "component_id", "goal_id", "episode_id", "case_tag") WHERE "status" != 'Closed';
