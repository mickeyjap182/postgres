CREATE EXTENSION postgres_fdw;

DROP SERVER IF EXISTS foreign_server CASCADE;
DROP USER MAPPING IF EXISTS FOR pguser01 SERVER foreign_server;
DROP FOREIGN TABLE IF EXISTS foreign_tenant CASCADE;

CREATE SERVER foreign_server
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host 'pgtest04-remote', port '5432', dbname 'postgres');

CREATE USER MAPPING FOR pguser01
        SERVER foreign_server
        OPTIONS (user 'pguser04', password 'pgpass04');

CREATE FOREIGN TABLE foreign_tenant (
    tenant_id bigint,
    tenant_name text,
    insert_date timestamp with time zone,
    update_date timestamp with time zone
)
        SERVER foreign_server
        OPTIONS (schema_name 'public', table_name 'tenant');
