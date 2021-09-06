#!/bin/bash
# settings for logical replication subscriber. 
sed -i -e 's/#max_replication_slots = 10/#max_replication_slots = 4/g' ../tmp/sub/postgresql.conf
sed -i -e 's/#max_sync_workers_per_subscription = 2/max_sync_workers_per_subscription = 3/g' ../tmp/sub/postgresql.conf
sed -i -e 's/#max_logical_replication_workers = 4/max_logical_replication_workers = 4/g' ../tmp/sub/postgresql.conf
sed -i -e 's/#max_worker_processes = 8/max_worker_processes = 4/g' ../tmp/postgresql.conf
sed -i -e 's/# IPv4 local connections:/# IPv4 local connections:\nhost    all             all             0.0.0.0/0            trust/g' ../tmp/pg_hba.conf
