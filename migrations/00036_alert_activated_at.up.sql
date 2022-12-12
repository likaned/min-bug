UPDATE "cases" SET
    alert_activated_at = updated_at
WHERE alert AND alert_activated_at is null;

COMMIT;