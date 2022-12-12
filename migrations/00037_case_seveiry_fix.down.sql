BEGIN;

UPDATE "cases" SET severity='Critical'
where bot_id in ('BOT-006','BOT-007','BOT-008','BOT-009');

COMMIT;