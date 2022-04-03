---
title: Whisparr Configuring PostgreSQL Database
description: Configuring Whisparr with a Postgres Database
published: true
date: 2022-03-22T18:08:45.637Z
tags:
editor: markdown
dateCreated: 2022-01-10T15:42:34.178Z
---

# Whisparr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Whisparr.

This guide was been created by the amazing [Roxedus](https://github.com/Roxedus).

## Setting up Postgres

 First, we need a Postgres instance. This guide is written for usage of the `postgres:14` Docker image.

 > Do not even think about using the `latest` tag! {.is-danger}

```bash
docker create --name=postgres14 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=whisparr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres14:/var/lib/postgresql/data \
    postgres:14
```

## Creation of database

Whisparr needs two databases, the default names of these are:

- `whisparr-main`   This is used to store all configuration and history
- `whisparr-log`    This is used to store events that produce a logentry

These can be named whatever you want them to be if you update the corresponding variables (see [Schema creation](/whisparr/postgres-setup#schema-creation)).

Create these databases using your favorite method, with the same username and password. Roxedus used Adminer, as he already had that set up.

### Schema creation

 We need to tell Whisparr to use Postgres. The `config.xml` should already be populated with the entries we need:

```xml
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres14</PostgresHost>
```

If you want to specify a database name then should also include the following configuration:

```xml
<PostgresMainDb>MainDbName</PostgresMainDb>
<PostgresLogDb>LogDbName</PostgresLogDb>
```

You can now run Whisparr using the Postgres databases.

## Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide! {.is-info}

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader). It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).
  Roxedus [built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Before migrating please ensure that you have run Whisparr against the created Postgres databases and then delete any data within the `Profiles`, `QualityDefinitions` & `DelayProfiles` tables on the new Postgres database. {.is-warning}

With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`:

```bash
pgloader --with "quote identifiers" --with "data only" whisparr.db 'postgresql://qstick:qstick@localhost/whisparr-main'
```

Or alternatively, using the Docker image producing the binary:

```bash
docker run -v ..whisparr.db:/whisparr.db --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /whisparr.db "postgresql://qstick:qstick@localhost/whisparr-main"
```
