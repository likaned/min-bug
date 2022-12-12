UPDATE cases SET triage_estimated_resolved_at = NOW() + '1 week'::INTERVAL WHERE status = 'InProgress' AND triage_estimated_resolved_at IS NULL;