---
title: Radarr Configuring PostgreSQL Database
description: Configuring Radarr with a Postgres Database
published: true
date: 2022-03-04T12:59:00.268Z
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
    -v ..appdata/postgres14:/var/lib/postgresql/data \
    postgres:14
```

## Creation of database

Radarr needs two databases:

- `radarr-main`   This is used to store all configuration and history
- `radarr-log`    This is used to store events that produce a logentry

Create these databases using your favorite method, with the same username and password. Roxedus used Adminer, as he already had that set up.

### Schema creation

 We need to tell Radarr to use Postgres. The `config.xml` should already be populated with the entries we need:

```xml
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres14</PostgresHost>
```

You can now run Radarr using the postgres database. 
## Migrate data

If you do not want to migrate a existing SQLite database to Postgres, you are already finished with this guide! {.is-info}

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader). It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).
  Roxedus [built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (no code modification was needed, simply had to be built with updated dependencies).
- The existing data in the `Profiles` table will need to be deleted before migrating as there is no way to overwrite this yet. If you do not delete this existing data your profiles with scoring from your custom formats will not be migrated over. Meaning you will have to redo this. (Honestly it is easier to just delete the data rather then setting it all up again)

With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`:

```bash
pgloader --with "quote identifiers" --with "data only" radarr.db 'postgresql://qstick:qstick@localhost/radarr-main'
```

Or alternatively, using the Docker image producing the binary:

```bash
docker run -v ..radarr.db:/radarr.db --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /radarr.db "postgresql://qstick:qstick@localhost/radarr-main"
```
