-- # learning sql tuning from pgjp-ug
explain (analyze, buffers)
-- analyze option... calculate actual time.
-- buffers option... calculate buffer hit.

/*
  * Nested Loop, Sequ Scan, Index Scan
     ... プラン要素、計画ノード

         入れ子なので下から読むといい。
    - 上の行... 見積もり予想
　　　 - cost (a)..(b) ...仮想的なかかった時間。
        a-> 最初の一行目を返すまで, b->全部の行を返すまで 
        1page defaultで8KBをシーケンシャルスキャンするときにかかる処理量。
      - rows ... 返る行数
      - width ... 幅、selectするカラムのが多ければ大きくなる。
    - 下の行... 実際    
      - actual time ... 実際にかかった時間
      - rows ... 実際に取得した行数
      - loops ... 実行回数(rows x loops = actural time)

    - Buffers: shared hit=5... バッファヒット。ヒットしなかった場合、
      カーネルメモリ上かファイルかは判別できない。
    か、postgresプロセス上かは不明


    同じ目的に複数の手段

       Seq scan 
       Index Scan 
       Index Only Scan ... indexだけで済ませる。同時に更新が発生知っている場合は負荷、vaccum以降はかける。
       Bitmap Index Scan
       Bitmap Heap Scan

     Hash Aggregate
     Group Aggregate
        ... 大体Hashが早い

        Nested Join... 全ての組み合わせ
        Merge Join... ソートが前提
        Hash Join... Hashデータ構造で検索
*/

/*
  プランの妥当性について確認

  - postgresが出してきたプランがおかしいと判断するには

     - rows と actual の行数が大きく違う場合は、
     間違ったプランの可能性がある。



  プランナの統計情報が正しくできているか
   - Vacccum と Analyze ができているか
      Vaccum...テーブル間数と物理サイズを採取。
      Analyze...列の値の分布、NULL率、物理配置、値の相関、値の平均長

    - 大小比較ができないため分布情報が入らない。
      Range Date型、幾何情報(x.y座標データ)など


*/

-- last execute timestamp for updated planner infrmation.
SELECT 
    schemaname, relname, 
    last_vacuum, last_autovacuum,
    last_analyze, last_autoanalyze
FROM
    pg_stat_all_tables;

-- logical rows, physical pages.
SELECT 
    relname,
    reltuples,
    relpages
FROM
    pg_class;

-- statistics by coloms.
SELECT 
    *
FROM
    pg_stats;

SHOW autovacuum;

-- プランナ統計情報の粒度を上げる
-- ヒストグラムの粒度をパラメータで調整する。

SHOW default_statistics_target;

/* postgresql.conf/setコマンドで調整可能。 
https://www.postgresql.jp/document/12/html/runtime-config-query.html
*/

-- default on だが、必要なクエリ前で一時的offにすることで選択されるプランを限定する。
SHOW enable_bitmapscan;
SHOW enable_hashjoin;
SHOW enable_indexonlyscan;
SHOW enable_mergejoin;
SHOW enable_seqscan;
SHOW enable_hashagg;
SHOW enable_indexscan;
SHOW enable_material;
SHOW enable_nestloop;
SHOW enable_sort;

-- plannerのコスト計算基準値を指定する(全体的にindex scanを選ぶ傾向になる)

SHOW seq_page_cost;        -- 1.0
SHOW random_page_cost;     -- 4.0 → 2.0 or 1.0(1.1?) 速いRAIDやSSDならランダムアクセススキャン(diskが回る待機時間が不要)のため、この値を減らすことでインデックススキャンを好むようになる。
SHOW cpu_tuple_cost;       -- 0.01
SHOW cpu_index_tuple_cost; -- 0.005
SHOW cpu_operator_cost;    -- 0.0025

-- 共有バッファとカーネルキャッシュに使われる想定値。インデックス利用判断にも使われる。
SHOW effective_cache_size; -- 4GB

-- カーソルの場合に、先頭の1行応答を優先する。1.0以外でカーソルでプランが変わる。
SHOW cursor_tuple_fraction; -- 0.1

/*
  SQLを書き換える。
  - 指定の結合順序で実行させる
    - 先に結合させたい箇所を括弧で括ったり、サブクエリ化して、以下パラメータを与え、。
    - 上記対応でSQLのチューニングをプランナが試行しなくなる。
    - 左辺を加工した値でなくインデックスを使わない。

  - With句<->サブクエリ間でプランの変わることが多いため、書き換えてみる。
  - 検索条件をサブクエリ内で重複して記載してみるなど。
*/
-- if you set 1, SQL will not try to optimize query.
SHOW from_collapse_limit; -- 8 -> 1
SHOW join_collapse_limit; -- 8 -> 1


/*
  - indexを使わせない方法 
    - 左辺が変数でなく加工した値にする。 where to_char(a + b) = 100 + 1

*/


/* パラレル動作を推奨する、抑止するのチューニング */
SHOW max_worker_processes; -- 8  小さくするとパラレルにならない
SHOW max_parallel_workers_per_gather;  -- 2 小さくするとパラレルにならない
SHOW max_parallel_workers; -- 8

SHOW parallel_tuple_cost;  -- 0.1  小さくするとパラレルしやすくなる。
SHOW parallel_setup_cost;  -- 1000 小さくするとパラレルしやすくなる。

SHOW min_parallel_table_scan_size; -- 8MB　 小さくするとパラレルしやすくなる?
SHOW min_parallel_index_scan_size; -- 512kB 小さくするとパラレルしやすくなる?


/* 一時ファイルの使用(ハッシュ処理、ソート処理、IOが生じるので遅延の原因になる) */

-- 出力先: $PGDATA/base/pgsql_tmp
SHOW log_tmp_files = '１MB'　-- 超えたときにログ報告してくれるので確認できる。
EXPLAIN (analyze)　-- ハッシュ処理、ソート処理のコストで判断
SELECT datname, temp_files FROM pg_stat_database;

SHOW work_mem; -- 1バックエンドプロセスあたりの保持メモリ領域を大きくする。ソートなどで使用するメモリ領域のサイズを大きくする


/* ロックまち() */
SHOW loc_lock_wait;
SHOW loc_lock_wait;
SELECT * FROM pg_stat_activity;

SHOW dead_locktimeout;

SELECT l.pid, db.datname, c.relname, l.locktype, l.mode
FROM pg_locks l
        LEFT JOIN pg_class c ON l.relation=c.relfilenode
        LEFT JOIN pg_database db ON l.database = db.oid
ORDER BY l.pid;

SELECT pg_cancel_backend(<pid>);


-- slow query
SELECT pid, query_start, substr(query, 0, 80) AS query FROM pg_stat_activity WHERE state='active' ORDER BY query_start;

-- AccessExclusiveLock
SELECT 
    l.pid, db.datname, c.relname, l.locktype, l.mode
FROM pg_locks l
    LEFT JOIN pg_class c ON l.relation=c.relfilenode
    LEFT JOIN pg_database db ON l.database = db.oid
WHERE l.mode = 'AccessExclusiveLock'
    ORDER BY l.pid;