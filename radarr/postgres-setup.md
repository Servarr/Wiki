---
title: Radarr Configuring PostgreSQL Database
description: Configuring Radarr with a Postgres Database
published: true
date: 2026-06-07T00:00:00.000Z
tags: radarr, postgres, database, installation
editor: markdown
dateCreated: 2022-01-10T15:42:34.178Z
---

# Radarr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Radarr.

> Radarr v4.1.0.6133 or newer required
{.is-info}

This guide was created by the amazing [Roxedus](https://github.com/Roxedus).

> Postgres databases are NOT backed up by Radarr, any backups must be implemented and maintained by the user
{.is-danger}

> Radarr connects to Postgres via [Npgsql](https://www.npgsql.org/) and supports all currently supported PostgreSQL versions (PostgreSQL 14 through 18). PostgreSQL 13 reached end-of-life in November 2025 and isn't recommended. This guide uses `postgres:17`. The SQLite-to-Postgres migration steps below were written against Postgres 14 and may need adjustment on newer majors; for Postgres 18 or later, start with a fresh database.
{.is-info}

## Setting up Postgres

 First, we need a Postgres instance. This guide is written for usage of the `postgres:17` Docker image.

 > Do not even think about using the `latest` tag! {.is-danger}

```bash
docker create --name=postgres17 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=radarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres17:/var/lib/postgresql/data \
    postgres:17
```

## Creation of database

Radarr needs two databases, the default names of these are:

- `radarr-main`   This is used to store all configuration and history
- `radarr-log`    This is used to store events that produce a logentry

> Radarr will not create the databases for you. Make sure you create them ahead of time{.is-warning}

Create the databases mentioned above using your favorite method - for example [pgAdmin](https://www.pgadmin.org/) or [Adminer](https://www.adminer.org/).

You can give the databases any name you want but make sure `config.xml` file has the correct names. For further information see [schema creation](/radarr/postgres-setup#schema-creation).

### Schema creation

 We need to tell Radarr to use Postgres. The `config.xml` should already be populated with the entries we need:

```xml
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres17</PostgresHost>
```

If you want to specify a database name then should also include the following configuration:

```xml
<PostgresMainDb>MainDbName</PostgresMainDb>
<PostgresLogDb>LogDbName</PostgresLogDb>
```

Alternatively, if you need to pass a full Postgres connection string (e.g. to include additional parameters like `sslmode`), you can use the connection string options **instead of** the host/user/password/port settings above. Both must be provided if either is set:

```xml
<PostgresMainDbConnectionString>Host=postgres17;Database=radarr-main;Username=qstick;Password=qstick;Port=5432</PostgresMainDbConnectionString>
<PostgresLogDbConnectionString>Host=postgres17;Database=radarr-log;Username=qstick;Password=qstick;Port=5432</PostgresLogDbConnectionString>
```

> You cannot mix connection string settings and host/user/password/port settings — use one approach or the other, not both.
{.is-warning}

Only **after creating** both databases you can start the Radarr migration from SQLite to Postgres.

## Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide! {.is-info}

> Migrating an existing sqlite3 database is unsupported, and this script may not work without modifications which we cannot assist you with. We support only new installs using postgres. {.is-warning}

To migrate data we can use [PGLoader](https://github.com/dimitri/pgloader). It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).
  Roxedus [built a binary](https://github.com/Roxedus/Pgloader-bin) to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Do not drop any tables in the Postgres instance {.is-danger}

Before starting a migration please ensure that you have run Radarr against the created Postgres databases **at least once** successfully. Begin the migration by doing the following:

1. Stop Radarr
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
      pgloader --with "quote identifiers" --with "data only" radarr.db 'postgresql://qstick:qstick@localhost/radarr-main'
      ```

    - ```bash
      docker run --rm -v /absolute/path/to/radarr.db:/radarr.db:ro --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /radarr.db "postgresql://qstick:qstick@localhost/radarr-main"
      ```

    > If you experience an error using pgloader it could be due to your DB being too large, to resolve this try adding `--with "prefetch rows = 100" --with "batch size = 1MB"` to the above command
    {.is-warning}

    > With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`
    {.is-info}

1. For those having the issues POST-MIGRATION from SQLite run the following:

    ```postgres
    select setval('public."AlternativeTitles_Id_seq"', (SELECT MAX("Id")+1 FROM "AlternativeTitles"));
    select setval('public."Blacklist_Id_seq"', (SELECT MAX("Id")+1 FROM "Blocklist"));
    select setval('public."Collections_Id_seq"', (SELECT MAX("Id")+1 FROM "Collections"));
    select setval('public."Commands_Id_seq"', (SELECT MAX("Id")+1 FROM "Commands"));
    select setval('public."Config_Id_seq"', (SELECT MAX("Id")+1 FROM "Config"));
    select setval('public."Credits_Id_seq"', (SELECT MAX("Id")+1 FROM "Credits"));
    select setval('public."CustomFilters_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFilters"));
    select setval('public."CustomFormats_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFormats"));
    select setval('public."DelayProfiles_Id_seq"', (SELECT MAX("Id")+1 FROM "DelayProfiles"));
    select setval('public."DownloadClientStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClientStatus"));
    select setval('public."DownloadClients_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClients"));
    select setval('public."DownloadHistory_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadHistory"));
    select setval('public."ExtraFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "ExtraFiles"));
    select setval('public."History_Id_seq"', (SELECT MAX("Id")+1 FROM "History"));
    select setval('public."ImportExclusions_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportExclusions"));
    select setval('public."ImportListMovies_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportListMovies"));
    select setval('public."IndexerStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "IndexerStatus"));
    select setval('public."Indexers_Id_seq"', (SELECT MAX("Id")+1 FROM "Indexers"));
    select setval('public."MetadataFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "MetadataFiles"));
    select setval('public."Metadata_Id_seq"', (SELECT MAX("Id")+1 FROM "Metadata"));
    select setval('public."MovieFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "MovieFiles"));
    select setval('public."MovieMetadata_Id_seq"', (SELECT MAX("Id")+1 FROM "MovieMetadata"));
    select setval('public."MovieTranslations_Id_seq"', (SELECT MAX("Id")+1 FROM "MovieTranslations"));
    select setval('public."Movies_Id_seq"', (SELECT MAX("Id")+1 FROM "Movies"));
    select setval('public."NamingConfig_Id_seq"', (SELECT MAX("Id")+1 FROM "NamingConfig"));
    select setval('public."Notifications_Id_seq"', (SELECT MAX("Id")+1 FROM "Notifications"));
    select setval('public."PendingReleases_Id_seq"', (SELECT MAX("Id")+1 FROM "PendingReleases"));
    select setval('public."Profiles_Id_seq"', (SELECT MAX("Id")+1 FROM "QualityProfiles"));
    select setval('public."QualityDefinitions_Id_seq"', (SELECT MAX("Id")+1 FROM "QualityDefinitions"));
    select setval('public."Restrictions_Id_seq"', (SELECT MAX("Id")+1 FROM "ReleaseProfiles"));
    select setval('public."RootFolders_Id_seq"', (SELECT MAX("Id")+1 FROM "RootFolders"));
    select setval('public."ScheduledTasks_Id_seq"', (SELECT MAX("Id")+1 FROM "ScheduledTasks"));
    select setval('public."SubtitleFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "SubtitleFiles"));
    select setval('public."Tags_Id_seq"', (SELECT MAX("Id")+1 FROM "Tags"));
    select setval('public."Users_Id_seq"', (SELECT MAX("Id")+1 FROM "Users"));
    ```

3. Start Radarr
