DROP SCHEMA IF EXISTS origin CASCADE;
CREATE SCHEMA IF NOT EXISTS origin AUTHORIZATION pguser04;

DROP TABLE IF EXISTS origin.tenant;

CREATE TABLE origin.tenant
(
    tenant_id bigint UNIQUE,
    tenant_name text,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);

DROP TABLE IF EXISTS origin.tenant_branch;
CREATE TABLE origin.tenant_branch
(
    tenant_branch BIGINT UNIQUE,
    tenant_branch_name TEXT,
    tenant_id BIGINT,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);

GRANT REFERENCES, INSERT, TRIGGER, UPDATE, SELECT, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA origin TO pguser04;

INSERT INTO origin.tenant VALUES(1, 'shop109', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO origin.tenant_branch VALUES(1, '5F', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO origin.tenant_branch VALUES(2, '6F', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
