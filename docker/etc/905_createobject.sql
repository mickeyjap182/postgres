
/**
 * OBJECTS
 * SCHEMA
 * ROLE
 * USER
 * GRANT PRIVILEGES 
 * TABLE
 * VIEW
 * TRIGGER
 **/

-- show schema name
SELECT current_schema;


SELECT * from table_space;

/** 各種オブジェクト設定について */
-- schema
SELECT nspname FROM pg_catalog.pg_namespace;
SELECT schema_name FROM information_schema.schemata;
CREATE SCHEMA IF NOT EXISTS origin AUTHORIZATION postgres;
CREATE TRIGGER <trigger_name> AFTER TRUNCATE ON <schema_name>.<table_name> FOR EACH STATEMENT EXECUTE FUNCTION <function_name>()

GRANT REFERENCES, INSERT, TRIGGER, UPDATE, SELECT, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA origin TO postgres;

-- ロールの権限

/** トリガーについて */
-- トリガーの有効無効を切り替える
ALTER TABLE <table_name> DISABLE TRIGGER ALL;
ALTER TABLE <table_name> ENABLE TRIGGER ALL;

-- ルールついて

-- ストアドファンクション



-- show rollname
SELECT rolname FROM pg_roles;

-- create user is alias of a create roll.

-- GRANT SELECT ON ALL TABLES IN SCHEMA postgres To role_name;
CREATE ROLE ;
GRANT <object> TO role_name;

-- GRANT EACH TABLE;
GRANT SELECT ON <object> TO <role_name>;
GRANT REFERENCES, INSERT, TRIGGER, UPDATE, SELECT, DELETE, TRUNCATE ON <object> TO <user>;

-- AWS
CREATE ROLE postgres apg_plan_mgmt;
GRANT postgres TO apg_plan_mgmt;


select current_schema();