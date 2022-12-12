UPDATE cases
SET
    entity_id = 'product-information-is-well-managed',
    sub_entity_id = NULL,
    segment = 'Business'
WHERE
    bot_id IN ('BOT-007', 'BOT-008', 'BOT-009');

UPDATE issues
SET
    entity_id = 'product-information-is-well-managed',
    sub_entity_id = NULL,
    segment = 'Business'
WHERE
    bot_id IN ('BOT-007', 'BOT-008', 'BOT-009');