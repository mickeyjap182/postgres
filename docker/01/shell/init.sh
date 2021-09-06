#!/bin/bash
rm
# settings for logical replication publisher. 
sed -i -e 's/#wal_level = replica/wal_level = replica/g' ../tmp/sub/postgresql.conf
sed -i -e 's/#max_replication_slots = 10/#max_replication_slots = 4/g' ../tmp/sub/postgresql.conf
sed -i -e 's/#max_wal_senders = 10/max_wal_senders = 4/g' ../tmp/sub/postgresql.conf
sed -i -e 's/# IPv4 local connections:/# IPv4 local connections:\nhost    all             all             0.0.0.0/0            trust/g' ../tmp/sub/pg_hba.conf

