-- some
show search_path


-- show rollname
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

-- show schema list
SELECT schema_name FROM information_schema.schemata;
-- alias as
SELECT nspname FROM pg_catalog.pg_namespace;
/*
 pg_toast
 pg_temp_1
 pg_toast_temp_1
 pg_catalog
 public
 information_schema
*/
-- show schema list ... \dt
\dt pg_catalog.*

\d pg_stat_activity;
select * from pg_stat_activity;


SELECT COUNT(*) FROM sys.dm_exec_sessions