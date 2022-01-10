---
title: Radarr Configuring PostgreSQL Database
description: Configuring Radarr with a Postgres Database
published: true
date: 2022-01-10T15:42:34.178Z
tags: 
editor: markdown
dateCreated: 2022-01-10T15:42:34.178Z
---

# Radarr and Postgres

This document will go over the key items for migrating and setting up Postgres support in Radarr.

This guide has been created by [Roxedus](https://github.com/Roxedus)

## Creation of initial database

- We do this also when migrating, this is to ensure Radarr sets up the required schema.

### Setting up Postgres

Firstly we need a Postgres instance, this guide is written for using the postgres:14 docker image.

> Do not even think about using the latest tag {.is-danger}

```bash
docker create --name=postgres14 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=radarr-main \
    -p 5432:5432/tcp \
    -v ..appdata/postgres14:/var/lib/postgresql/data \
    postgres:14
```

Radarr needs two databases:

- `radarr-main`   This is used to store all configuration and history
- `radarr-log`    This is used to store events that produce a logentry

Create these databases using your favorite method, with the same username and password. I used Adminer as I already had that set up.

### Schema creation

We need to tell Radarr to use Postgres, the `config.xml` should already be populated with the entries we need.

```xml
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres14</PostgresHost>
```

## Migrate data

> If you do not want to migrate a existing SQLite database to Postgres, you can are finished with this guide.

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader), it does however have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are tested as too old for newer versions of Postgres (I have not tested the packages in other distros)
  I have [re-built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (No code-modification needed, just need to be built with updated dependencies)

Once these handled, it's pretty straight forward, after telling it to not mess with the scheme using `--with "data only"`.

```bash
pgloader --with "quote identifiers" --with "data only" radarr.db 'postgresql://qstick:qstick@localhost/radarr-main'
```

Or alternativly using the dockerimage producing the binary:

```bash
docker run -v ..radarr.db:/radarr.db --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /radarr.db "postgresql://qstick:qstick@localhost/radarr-main"
```
