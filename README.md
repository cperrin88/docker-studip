# Supported tags and respective  `Dockerfile` links

 - `3.5`, `latest` [(3.5/Dockerfile)](https://github.com/cperrin88/docker-studip/tree/master/3.5/Dockerfile)
 - `3.4.3` [(3.4.3/Dockerfile)](https://github.com/cperrin88/docker-studip/tree/master/3.4.3/Dockerfile)
 - `3.3.4` [(3.3.4/Dockerfile)](https://github.com/cperrin88/docker-studip/tree/master/3.3.4/Docker)
 - `3.3` [(3.3/Dockerfile)](https://github.com/cperrin88/docker-studip/tree/master/3.3/Docker)

# What is Stud.IP?

Stud.IP is a learning platform for education

# How to use this image

## Starting a `studip` server instance

To start a Stud.IP instance you need to run the following command to initialize the database

```
$ docker run --link some-mysql:mysql cperrin/studip initdb
```

and then start a new server

```
$ docker run --link some-mysql:mysql -p 80:80 cperrin/studip
```

This only works if the following enviroment variables are set in the linked `mysql` container:

  - `MYSQL_ENV_MYSQL_USER`
  - `MYSQL_ENV_MYSQL_PASSWORD`
  - `MYSQL_ENV_MYSQL_DATABASE`
