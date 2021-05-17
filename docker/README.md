# postgreSQLtest

planning...

 - use container
 - use replication
 - use kubernates
 - use ansible

- download and build container.
```
sudo docker-compose up -d
```

- login to container as root.
```
sudo docker exec -it pgtest01-primary /bin/bash
```


- connect to database in the container.
```
psql -U pguser01 -d postgres
```
- login to replica container as root.
```
sudo docker exec -it pgtest02-replica /bin/bash
```

??? TODO login replicated db
```
psql -U repl_user -d postgres
```

