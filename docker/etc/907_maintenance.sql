-- プロセスが固まる、デッドロックする。


- 固まってるプロセス確認
SELECT *, (current_timestamp - xact_start)::interval(3) AS duration
FROM pg_stat_activity
WHERE pid <> pg_backend_pid() and state != 'idle'
order by duration desc;

- キャンセル
select pg_cancel_backend(procpid);

- 強制終了
select pg_terminate_backend(procpid);

- OS側でプロセスをKILL
netstat -tanp | grep [client_port※]
kill -9 <PID>