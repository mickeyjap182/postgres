-- connection errors cause docker process.
-- https://github.com/docker/for-mac/issues/3679#issuecomment-585367735

-- SHOW DEFAULT_TRANSACTION_ISOLATION;
-- SHOW TRANSACTION ISOLATION LEVEL;

-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- SHOW TRANSACTION ISOLATION LEVEL;

-- SHOW MAX_CONNECTIONS;

SELECT rolname FROM pg_roles;

-- GRANT SELECT ON ALL TABLES IN SCHEMA postgres To role_name;

-- AWS
CREATE ROLE postgres apg_plan_mgmt;
GRANT postgres TO apg_plan_mgmt;
