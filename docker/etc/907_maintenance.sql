/** 接続の確認をする。 */

-- 接続の確認:
select *
from pg_stat_activity
order by client_addr,client_port,pid,usename,datname

-- クライアント毎の接続数確認:
SELECT client_addr, datname, usename, COUNT(*)
FROM pg_stat_activity
GROUP BY client_addr, datname, usename;

/**  プロセスが固まる、デッドロックする。 */

show dead_lock
-- 固まってるプロセス確認
SELECT *, (current_timestamp - xact_start)::interval(3) AS duration
FROM pg_stat_activity
WHERE pid <> pg_backend_pid() and state != 'idle'
order by duration desc;

-- キャンセル
select pg_cancel_backend(procpid);

-- 強制終了
select pg_terminate_backend(procpid);

-- OS側でプロセスをKILL
netstat -tanp | grep [client_port※]
kill -9 <PID>

-- 性質