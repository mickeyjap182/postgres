# postgreSQLtest

planning...

 - use container
 - use replication
 - use kubernates
 - use ansible

 - use envsubst and bind tpl
```
- file: base.tpl as template a file is contains next contents.

param=$VARS

- you may exec following shell, it will replace.1
VARS=aaa envsubst < base.tpl > replaced.conf 
```

- download and build container.
```
sudo /bin/bash ./before.sh && sudo docker-compose up -d
```

- Please confirm it is enable to login container as root and connect other server via docker network. and if you exit from container bash session, you should "press ctrl+c then ctrl+d". 

```
# pgtest01-primary.
docker exec -it pgtest01-primary /bin/bash
export PGPASSWORD=pgpass01 && psql -h localhost -p5432 -U pguser01 -d postgres
export PGPASSWORD=pgpass02 && psql -h pgtest02-replica -p5432 -U pguser02 -d postgres
export PGPASSWORD=pgpass03 && psql -h pgtest03-replica -p5432 -U pguser03 -d postgres

# pgtest02-replica.
docker exec -it pgtest02-replica /bin/bash
export PGPASSWORD=pgpass02 && psql -h localhost -p5432 -U pguser02 -d postgres
export PGPASSWORD=pgpass01 && psql -h pgtest01-primary -p5432 -U pguser01 -d postgres
export PGPASSWORD=pgpass03 && psql -h pgtest03-replica -p5432 -U pguser03 -d postgres

# pgtest03-replica.
docker exec -it pgtest03-replica /bin/bash
export PGPASSWORD=pgpass03 && psql -h localhost -p5432 -U pguser03 -d postgres
export PGPASSWORD=pgpass01 && psql -h pgtest01-primary -p5432 -U pguser01 -d postgres
export PGPASSWORD=pgpass02 && psql -h pgtest02-replica -p5432 -U pguser02 -d postgres
```


- connect to database on the container from host.
```
psql -U pguser01 -d postgres -p30001
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

```
docker network ls

```
### destroy
if you wanna destroy all. run following command.
```
docker-compose down --rmi all --volumes --remove-orphans

sudo /bin/bash ./clear.sh
```
