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
-- export PGPASSWORD=pgpass04 && pg_dump -Fc  -d postgres -f ./postgres.bak.cstm -h localhost -p30004 -U pguser04 
-- export PGPASSWORD=pgpass04 && pg_restore -Fc -j 4 -d postgres  ./postgres.bak.cstm -h localhost -p30004 -U pguser04

-- 必ずバキュームと実行計画メンテナンス
analyze verbose;


/** リストア */
-- カスタム形式 -j <thread count>
pg_restore -j 2 -d postgres ./postgres.bak.cstm
-- ディレクトリ形式
tar xf ./kot2_YYYYMMDD.94.dir.tar
pg_restore -j 2 -d <database name> ./<directory backupfile name>
-- テーブルスペースを使用していない場合
pg_restore --no-tablespaces -j 2 -d <database name> ./<custom backupfile name>
-- テーブル単位のリストア
pg_restore -t <table_a> -t <table_b> -j 4 -d <database name> ./<custom backupfile name>

