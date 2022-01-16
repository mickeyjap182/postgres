-- postgres parameters settings: 
-- https://postgresqlco.nf/doc/ja/param/maintenance_work_mem/

-- connection errors cause docker process.
-- https://github.com/docker/for-mac/issues/3679#issuecomment-585367735


-- SHOW DEFAULT_TRANSACTION_ISOLATION;
-- SHOW TRANSACTION ISOLATION LEVEL;

-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- SHOW TRANSACTION ISOLATION LEVEL;

-- SHOW MAX_CONNECTIONS;



-- クエリ操作(ORDER BY, hastable操作)
-- SHOW work_mem;
-- pg_restore, vacuum, create index, add foreignkeyのような保守作業
-- SHOW maintenance_work_mem;

SHOW config_file;
-- ログ出力先
SHOW log_destination;
SHOW logging_collector;

ALTER SYSTEM SET log_destination 

SELECT rolname FROM pg_roles;
SELECT * FROM pg_stat_replication;

-- トリガ・ルール発行制御: replica上では起動されない　origin（デフォルト）、replica、local
SHOW session_replication_role;

-- GRANT SELECT ON ALL TABLES IN SCHEMA postgres To role_name;

SET <parameter> TO 'off'
SET <parameter> TO 'on'




