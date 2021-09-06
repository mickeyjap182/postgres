create table tenant
(
    tenant_id bigint UNIQUE,
    tenant_name text,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
);
-- s
INSERT INTO tenant VALUES(1, 'shop109', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
