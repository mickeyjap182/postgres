-- show autovaccum is valid?
SHOW autovacuum;

-- vaccum, analyze
VACUUM ( 
        FULL, 
        ANALYZE
)
    admins


SHOW default_statistics_target;
/** バックアップ・リストア */
-- カスタム形式
-- export PGPASSWORD=pgpass04 && pg_dump -Fc -d postgres -f ./postgres.bak.cstm -h localhost -p30004 -U pguser04 
-- export PGPASSWORD=pgpass04 && pg_restore -c -C -j 4 --disable-triggers -s postgres -f ./postgres.bak.cstm postgres -h localhost -p30004 -U pguser04

-- 必ずバキュームと実行計画メンテナンス
analyze verbose;


/** リストア */
-- ALTER TABLEなどロックが必要
SHOW work_mem;
SHOW maintenance_work_mem;

-- modify config when postgresql server restarts.
ALTER SYSTEM SET work_mem = '128MB';
ALTER SYSTEM SET maintenance_work_mem = '4GB';

-- restore config when postgresql server restarts.
ALTER SYSTEM RESET work_mem;
ALTER SYSTEM RESET maintenance_work_mem;

pg_dump -Fc  -d <database_name> -f ./postgres.bak.cstm -h localhost
pg_dump -Fd -j 2 -p 30001 -U pguser01 -f ./postgres.bak.dir postgres -h localhost
psql -U pguser01 -d postgres -p 30001 -h localhost


-- カスタム形式 -j <thread count>
pg_restore -j 2 -d postgres ./postgres.bak.cstm
-- ディレクトリ形式
tar xf ./kot2_YYYYMMDD.94.dir.tar
pg_restore -j 2 -f ./postgres.bak.dir -h localhost
-- テーブルスペースを使用していない場合
pg_restore --no-tablespaces -j 2 -d <database name> ./<custom backupfile name>
-- テーブル単位のリストア
pg_restore -t <table_a> -t <table_b> -j 4 -d <database name> ./<custom backupfile name>

