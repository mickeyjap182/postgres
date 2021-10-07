
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

-- show rollname
SELECT rolname FROM pg_roles;

-- GRANT SELECT ON ALL TABLES IN SCHEMA postgres To role_name;

CREATE ROLE ;
GRANT user TO role_name;

select current_schema();