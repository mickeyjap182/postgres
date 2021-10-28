-- shortcut
\du -- role list.

\dn -- show schema users

\dt -- show schemas tables

\do -- show operators.

\dx -- like this.
SELECT * FROM pg_catalog.pg_extension;
-- some
show search_path



/**
 * schema: information_schema
 * 
 **/
-- alias as
SELECT nspname FROM pg_catalog.pg_namespace;
SELECT schema_name FROM information_schema.schemata;
/*
 pg_toast
 pg_temp_1
 pg_toast_temp_1
 pg_catalog
 public
 information_schema
*/

-- show rolename for system and user.
SELECT rolname FROM pg_catalog.pg_roles;
-- pg_catalog is callable without schema.
SELECT rolname FROM pg_roles;
/*---------------------------
 pg_monitor
 pg_read_all_settings
 pg_read_all_stats
 pg_stat_scan_tables
 pg_read_server_files
 pg_write_server_files
 pg_execute_server_program
 pg_signal_backend
 pguser01
*/
-- show rollname

pg_database
-- show schema list
SELECT schema_name FROM information_schema.schemata;

/**
 schema:pg_catalog
 about 63;
**/
\dt pg_catalog.*

/*
 pg_stat_activity
 pg_stat_database
*/
-- show schema list ... \dt
\dt pg_catalog.*

\d pg_stat_activity;
select * from pg_stat_activity;


SELECT datname, temp_files FROM pg_stat_database;

SELECT COUNT(*) FROM sys.dm_exec_sessions


pg_available_extension_versions

-- show extensions.
SELECT * FROM pg_extension;
\dx

SELECT * FROM pg_catalog.pg_available_extensions

-- 
SELECT * FROM pg_catalog.pg_foreign_data_wrapper

SELECT * FROM pg_catalog.pg_foreign_server
SELECT * FROM pg_catalog.pg_foreign_table



