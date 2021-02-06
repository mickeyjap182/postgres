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
sudo docker exec -it pgtest01 /bin/bash
```


- connect to database in the container.
```
psql -U pgserver01
```
