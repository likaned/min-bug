UPDATE cases
SET
    entity_id = 'zafin',
    sub_entity_id = 'zafin',
    segment = 'Technology'
WHERE
    bot_id IN ('BOT-007', 'BOT-008', 'BOT-009');

UPDATE issues
SET
    entity_id = 'product-information-is-well-managed',
    sub_entity_id = 'zafin',
    segment = 'Technology'
WHERE
    bot_id IN ('BOT-007', 'BOT-008', 'BOT-009');