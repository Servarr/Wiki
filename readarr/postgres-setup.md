---
title: Readarr Configuring PostgreSQL Database
description: Configuring Readarr with a Postgres Database
published: true
date: 2022-07-25T22:49:56.668Z
tags: 
editor: markdown
dateCreated: 2022-07-25T22:49:56.668Z
---

# Readarr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Readarr.

This guide was been created by the amazing [Roxedus](https://github.com/Roxedus).

> Postgres databases are NOT backed up by Readarr, any backups must be implemented and maintained by the user
{.is-danger}

## Setting up Postgres

 First, we need a Postgres instance. This guide is written for usage of the `postgres:14` Docker image.

 > Do not even think about using the `latest` tag! {.is-danger}

```bash
docker create --name=postgres14 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=readarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres14:/var/lib/postgresql/data \
    postgres:14
```

## Creation of database

Readarr needs two databases, the default names of these are:

- `readarr-main`   This is used to store all configuration and history
- `readarr-log`    This is used to store events that produce a logentry
- `readarr-cache`    This is used to store GoodReads cache

> Readarr will not create the databases for you. Make sure you create them ahead of time{.is-warning}

Create the databases mentioned above using your favorite method - for example [pgAdmin](https://www.pgadmin.org/) or [Adminer](https://www.adminer.org/).

You can give the databases any name you want but make sure `config.xml` file has the correct names. For further information see [schema creation](/readarr/postgres-setup#schema-creation).

### Schema creation

 We need to tell Readarr to use Postgres. The `config.xml` should already be populated with the entries we need:

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

Only **after creating** both databases you can start the Readarr migration from SQLite to Postgres.

## Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide! {.is-info}

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader). It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).
  Roxedus [built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Do not drop any tables in the Postgres instance {.is-danger}

Before starting a migration please ensure that you have run Readarr against the created Postgres databases **at least once** successfully. Begin the migration by doing the following:

1. Stop Readarr
1. Open your preferred database management tool and connect to the Postgres database instance
1. Run the following commands:

```SQL
DELETE FROM "Profiles";
```

```SQL
DELETE FROM "QualityDefinitions";
```

```SQL
DELETE FROM "DelayProfiles";
```

```SQL
DELETE FROM "Metadata";
```

1. Start the migration by using either of these options:

    - ```bash
      pgloader --with "quote identifiers" --with "data only" readarr.db 'postgresql://qstick:qstick@localhost/readarr-main'
      ```

    - ```bash
      docker run -v /absolute/path/to/readarr.db:/readarr.db --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /readarr.db "postgresql://qstick:qstick@localhost/readarr-main"
      ```

> With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`
{.is-info}

1. Start Readarr
