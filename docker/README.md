# postgreSQLtest

planning...

 - use container
 - use replication
 - use kubernates
 - use ansible

- download and build container.
```
sudo /bin/bash ./before.sh && sudo docker-compose up -d
```

- login to container as root.
```
sudo docker exec -it pgtest01-primary /bin/bash
sudo docker exec -it pgtest02-replica /bin/bash
sudo docker exec -it pgtest03-replica /bin/bash
```


- connect to database in the container.
```
psql -U pguser01 -d postgres
```
or
```
export PGPASSWORD=pgpass01 && psql -h localhost -p30001 -U pguser01 -d postgres

```
```
export PGPASSWORD=pgpass02 && psql -h localhost -p30002 -U pguser02 -d postgres

```
```
export PGPASSWORD=pgpass03 && psql -h localhost -p30003 -U pguser03 -d postgres

```

- login to replica container as root.
```
sudo docker exec -it pgtest02-replica /bin/bash
```

??? TODO login replicated db
```
psql -U repl_user -d postgres
```
or 
```
export PGPASSWORD=repl_pass
psql -h localhost -p30001 -U pguser01 -d postgres
psql -h localhost -p30001 -U repl_user -d postgres
```

### destroy
if you wanna destroy all. run following command.
```
docker-compose down --rmi all --volumes --remove-orphans
```
