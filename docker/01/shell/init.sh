#!/bin/bash
# settings for logical replication publisher. 
sed -i -e 's/#wal_level = replica/wal_level = replica/g' ../tmp/postgresql.conf
sed -i -e 's/#max_replication_slots = 10/#max_replication_slots = 4/g' ../tmp/postgresql.conf
sed -i -e 's/#max_wal_senders = 10/max_wal_senders = 4/g' ../tmp/postgresql.conf

echo "host all postgres 127.0.0.1/32 trust" >> ../tmp/pg_hba.conf
