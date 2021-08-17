#!/bin/bash
# settings for logical replication subscriber. 
sed -i -e 's/#max_replication_slots = 10/#max_replication_slots = 4/g' ../tmp/postgresql.conf
sed -i -e 's/#max_sync_workers_per_subscription = 2/max_sync_workers_per_subscription = 3/g' ../tmp/postgresql.conf
sed -i -e 's/#max_logical_replication_workers = 4/max_logical_replication_workers = 4/g' ../tmp/postgresql.conf
sed -i -e 's/#max_worker_processes = 8/max_worker_processes = 4/g' ../tmp/postgresql.conf
