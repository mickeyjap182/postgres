DROP EXTENSION IF EXISTS postgres_fdw;

CREATE EXTENSION IF NOT EXISTS postgres_fdw 
    WITH SCHEMA public;
      

DROP SERVER IF EXISTS foreign_server CASCADE;

-- cascadeで削除されるのは、スキーマ内から参照しているリモートテーブルへのシンボリックリンク。
DROP SCHEMA IF EXISTS link_origin CASCADE;
DROP USER MAPPING IF EXISTS FOR pguser01 SERVER foreign_server;

CREATE SERVER foreign_server
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (
            host 'pgtest04-remote', 
            port '5432', dbname 'postgres', 
            use_remote_estimate 'true'
        );
 
CREATE USER MAPPING FOR pguser01
        SERVER foreign_server
        OPTIONS (user 'pguser04', password 'pgpass04');

CREATE SCHEMA link_origin AUTHORIZATION pguser01;
IMPORT FOREIGN SCHEMA origin
    FROM SERVER foreign_server INTO link_origin;

/*
-- cost planning options
--  use_remote_estimate;
--  fdw_startup_cost
--  fdw_tuple_cost
-- remote action options
--  extensions
--  fetch_size
-- grant
--  updatable
-- NOT NULL以外の制約は決してリモートのテーブルからインポートされない

- senty
 web/nginx.server.log
 - 
 munin.log

- io
google/analytics
recorder.exception->
アプリclient/log -> developer dashboard

*/
SELECT * FROM pg_catalog.pg_extension WHERE extname = 'postgres_fdw';
SELECT * FROM pg_available_extensions ORDER BY name; 
SELECT * FROM pg_available_extension_versions ORDER BY name; 
SELECT * FROM pg_catalog.pg_foreign_data_wrapper;
SELECT * FROM pg_catalog.pg_foreign_server;
SELECT * FROM pg_catalog.pg_foreign_table;




