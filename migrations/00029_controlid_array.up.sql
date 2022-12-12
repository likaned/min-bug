DELETE FROM
    issues i
        USING issues j
WHERE
    i.id > j.id
    AND i.case_id = j.case_id
    AND i.issue_tag = j.issue_tag
    AND i.status = j.status
    AND i.status != 'Closed';

CREATE TABLE IF NOT EXISTS "control_references" (
    "id" bigserial,
    "created_at" timestamptz,
    "updated_at" timestamptz,
    "deleted_at" timestamptz,
    "control_id" text,
    "control_component_id" text,
    PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX IF NOT EXISTS "unique_control" ON "control_references" ("control_id","control_component_id");

CREATE INDEX IF NOT EXISTS "idx_control_references_deleted_at" ON "control_references" ("deleted_at");

CREATE TABLE IF NOT EXISTS "case_controls" (
    "case_id" bigint,
    "control_reference_id" bigint,
    PRIMARY KEY ("case_id","control_reference_id"),
    CONSTRAINT "fk_case_controls_case" FOREIGN KEY ("case_id") REFERENCES "cases"("id"),
    CONSTRAINT "fk_case_controls_control_reference" FOREIGN KEY ("control_reference_id") REFERENCES "control_references"("id")
);

DROP INDEX IF EXISTS "unique_issue";
CREATE UNIQUE INDEX IF NOT EXISTS "unique_issue" ON "issues" ("issue_tag", "case_id") WHERE "status" != 'Closed';