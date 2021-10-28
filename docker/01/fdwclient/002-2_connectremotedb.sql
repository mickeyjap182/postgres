CREATE EXTENSION postgres_fdw;


DROP SERVER IF EXISTS foreign_server CASCADE;

-- cascadeで削除されるのは、スキーマ内から参照しているリモートテーブルへのシンボリックリンク。
DROP SCHEMA IF EXISTS link_origin CASCADE;
DROP USER MAPPING IF EXISTS FOR pguser01 SERVER foreign_server;
DROP FOREIGN TABLE IF EXISTS foreign_tenant CASCADE;

CREATE SERVER foreign_server
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host 'pgtest04-remote', port '5432', dbname 'postgres');

CREATE USER MAPPING FOR pguser01
        SERVER foreign_server
        OPTIONS (user 'pguser04', password 'pgpass04');

CREATE SCHEMA link_origin AUTHORIZATION pguser01;
IMPORT FOREIGN SCHEMA origin
    FROM SERVER foreign_server INTO link_origin;

