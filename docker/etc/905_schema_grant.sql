
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

* from table_space;

-- show rollname
SELECT rolname FROM pg_roles;

-- create user is alias of a create roll.

-- GRANT SELECT ON ALL TABLES IN SCHEMA postgres To role_name;
CREATE ROLE ;
GRANT user TO role_name;

-- GRANT EACH TABLE;
GRANT SELECT ON <object> TO <user>;
GRANT REFERENCES, INSERT, TRIGGER, UPDATE, SELECT, DELETE, TRUNCATE ON <object> TO <user>;

-- AWS
CREATE ROLE postgres apg_plan_mgmt;
GRANT postgres TO apg_plan_mgmt;


select current_schema();