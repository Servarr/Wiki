---
title: Sonarr Configuring PostgreSQL Database
description: Configuring Sonarr with a Postgres Database
published: true
date: 2023-08-12T13:04:38.218Z
tags: 
editor: markdown
dateCreated: 2023-08-12T12:26:25.094Z
---

# Sonarr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Sonarr.

> Sonarr v4.0.0.615 or newer required
{.is-info}

This guide was been created by the amazing [Roxedus](https://github.com/Roxedus).

> Postgres databases are NOT backed up by Sonarr, any backups must be implemented and maintained by the user
{.is-danger}

## Setting up Postgres

 First, we need a Postgres instance. This guide is written for usage of the `postgres:14` Docker image.

 > Do not even think about using the `latest` tag! {.is-danger}

```bash
docker create --name=postgres14 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=sonarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres14:/var/lib/postgresql/data \
    postgres:14
```

## Creation of database

Sonarr needs two databases, the default names of these are:

- `sonarr-main`   This is used to store all configuration and history
- `sonarr-log`    This is used to store events that produce a logentry

> Sonarr will not create the databases for you. Make sure you create them ahead of time{.is-warning}

Create the databases mentioned above using your favorite method - for example [pgAdmin](https://www.pgadmin.org/) or [Adminer](https://www.adminer.org/).

You can give the databases any name you want but make sure `config.xml` file has the correct names. For further information see [schema creation](/sonarr/postgres-setup#schema-creation).

### Schema creation

 We need to tell Sonarr to use Postgres. The `config.xml` should already be populated with the entries we need:

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

Only **after creating** both databases you can start the Sonarr migration from SQLite to Postgres.

## Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide! {.is-info}

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader). It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).
  Roxedus [built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Do not drop any tables in the Postgres instance {.is-danger}

Before starting a migration please ensure that you have run Sonarr against the created Postgres databases **at least once** successfully. Begin the migration by doing the following:

1. Stop Sonarr
1. Open your preferred database management tool and connect to the Postgres database instance
1. Run the following commands:

```SQL
DELETE FROM "QualityProfiles";
DELETE FROM "QualityDefinitions";
DELETE FROM "DelayProfiles";
DELETE FROM "Metadata";
```

1. Start the migration by using either of these options:

    - ```bash
      pgloader --with "quote identifiers" --with "data only" sonarr.db 'postgresql://qstick:qstick@localhost/sonarr-main'
      ```

    - ```bash
      docker run --rm -v /absolute/path/to/sonarr.db:/sonarr.db:ro --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /sonarr.db "postgresql://qstick:qstick@localhost/sonarr-main"
      ```

  > If you experience an error using pgloader it could be due to your DB being too large, to resolve this try adding `--with "prefetch rows = 100" --with "batch size = 1MB"` to the above command
  {.is-warning}

  > With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`
  {.is-info}


2. Start Sonarr
