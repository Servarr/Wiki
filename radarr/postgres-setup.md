---
title: Radarr Configuring PostgreSQL Database
description: Configuring Radarr with a Postgres Database
published: true
date: 2022-03-04T13:13:49.487Z
tags: 
editor: markdown
dateCreated: 2022-01-10T15:42:34.178Z
---

# Radarr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Radarr.

This guide was been created by the amazing [Roxedus](https://github.com/Roxedus).

## Setting up Postgres

 First, we need a Postgres instance. This guide is written for usage of the `postgres:14` Docker image.

 > Do not even think about using the `latest` tag! {.is-danger}

```bash
docker create --name=postgres14 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=radarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres14:/var/lib/postgresql/data \
    postgres:14
```

## Creation of database

Radarr needs two databases, the default names of these are:

- `radarr-main`   This is used to store all configuration and history
- `radarr-log`    This is used to store events that produce a logentry

These can be named whatever you want them to be

Create these databases using your favorite method, with the same username and password. Roxedus used Adminer, as he already had that set up.

### Schema creation

 We need to tell Radarr to use Postgres. The `config.xml` should already be populated with the entries we need:

```xml
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres14</PostgresHost>
```

If you want to specify a database name then should also include the following configuration
```xml
<PostgresMainDb>MainDbName</PostgresMainDb>
<PostgresLogDb>LogDbName</PostgresLogDb>
```

You can now run Radarr using the Postgres databases. 

## Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide! {.is-info}

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader). It does, however, have some gotchas:
- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).
  Roxedus [built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Before migrating please ensure that you have run Radarr against the created Postgres databases and then delete any data within the `Profiles` table {.is-warning}


With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`:

```bash
pgloader --with "quote identifiers" --with "data only" radarr.db 'postgresql://qstick:qstick@localhost/radarr-main'
```

Or alternatively, using the Docker image producing the binary:

```bash
docker run -v ..radarr.db:/radarr.db --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /radarr.db "postgresql://qstick:qstick@localhost/radarr-main"
```
