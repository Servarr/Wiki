---
title: Lidarr Configuring PostgreSQL Database
description: Configuring Lidarr with a Postgres Database
published: true
date: 2026-06-06T14:25:49.056Z
tags: lidarr, installation, postgres, database
editor: markdown
dateCreated: 2022-11-25T01:35:56.796Z
---

## Lidarr and Postgres

> Lidarr v1.1.2.2890 or newer required.
{.is-info}

> Lidarr doesn't back up Postgres databases. Set up and maintain your own backups.
{.is-danger}

Lidarr uses [Npgsql](https://www.npgsql.org/) 9.x, which targets all [currently supported PostgreSQL versions](https://www.postgresql.org/support/versioning/) (PostgreSQL 14 through 18). PostgreSQL 13 reached end-of-life in November 2025 and isn't recommended.

## Setting up Postgres

First, you need a Postgres instance. This guide covers the `postgres:17` Docker image.

> Don't use the `latest` tag. It will upgrade your database engine on container recreate and can break compatibility.
{.is-danger}

```shell
docker create --name=postgres17 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=lidarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres17:/var/lib/postgresql/data \
    postgres:17
```

## Creation of database

Lidarr needs two databases. The default names are:

- `lidarr-main`: stores all configuration and history
- `lidarr-log`: stores events that produce a log entry

> Lidarr won't create the databases for you. Create them before starting Lidarr.
{.is-warning}

Create the databases using your preferred tool, for example [pgAdmin](https://www.pgadmin.org/) or [Adminer](https://www.adminer.org/).

You can give the databases any name you want, but make sure `config.xml` has the correct names. See [Schema creation](#schema-creation) below.

### Schema creation

Tell Lidarr to use Postgres. Open `config.xml` and add or update these entries:

```xml
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres17</PostgresHost>
```

To use custom database names, also add:

```xml
<PostgresMainDb>MainDbName</PostgresMainDb>
<PostgresLogDb>LogDbName</PostgresLogDb>
```

Only **after creating** both databases, start Lidarr to initialize the schema.

## Migrating data

> If you don't want to migrate an existing SQLite database to Postgres, you're done.
{.is-info}

> Lidarr doesn't officially support SQLite-to-Postgres migration. The community script below works for many users on Postgres 14–17, but isn't guaranteed to work on Postgres 18 or later. For Postgres 18+, start with a fresh database.
{.is-warning}

To migrate data, use [PGLoader](https://github.com/dimitri/pgloader). Two gotchas:

- By default, identifiers are case-insensitive. Use `--with "quote identifiers"` to make them case-sensitive.
- The version packaged in Debian and Ubuntu apt repos is too old for Postgres 14+. Use the [Roxedus pgloader binary](https://github.com/Roxedus/Pgloader-bin), which includes updated dependencies.

> Don't drop any tables in the Postgres instance.
{.is-danger}

Before migrating, run Lidarr against the created Postgres databases **at least once** so the schema exists, then stop Lidarr and follow these steps:

1. Stop Lidarr.
2. Open your preferred database management tool and connect to the Postgres instance.
3. Run the following commands to clear the default seed data:

   ```sql
   DELETE FROM "QualityProfiles";
   DELETE FROM "QualityDefinitions";
   DELETE FROM "DelayProfiles";
   DELETE FROM "Metadata";
   DELETE FROM "MetadataProfiles";
   ```

4. Start the migration using one of these options:

   ```shell
   pgloader --with "quote identifiers" --with "data only" lidarr.db 'postgresql://qstick:qstick@localhost/lidarr-main'
   ```

   ```shell
   docker run --rm -v /absolute/path/to/lidarr.db:/lidarr.db:ro --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /lidarr.db "postgresql://qstick:qstick@localhost/lidarr-main"
   ```

   > If pgloader errors on a large database, add `--with "prefetch rows = 100" --with "batch size = 1MB"` to the command.
   {.is-warning}

5. If you see sequence errors after migration, run the following to reset all sequences:

   ```sql
   select setval('public."AlbumReleases_Id_seq"', (SELECT MAX("Id")+1 FROM "AlbumReleases"));
   select setval('public."Albums_Id_seq"', (SELECT MAX("Id")+1 FROM "Albums"));
   select setval('public."ArtistMetadata_Id_seq"', (SELECT MAX("Id")+1 FROM "ArtistMetadata"));
   select setval('public."Artists_Id_seq"', (SELECT MAX("Id")+1 FROM "Artists"));
   select setval('public."Blacklist_Id_seq"', (SELECT MAX("Id")+1 FROM "Blocklist"));
   select setval('public."Commands_Id_seq"', (SELECT MAX("Id")+1 FROM "Commands"));
   select setval('public."Config_Id_seq"', (SELECT MAX("Id")+1 FROM "Config"));
   select setval('public."CustomFilters_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFilters"));
   select setval('public."CustomFormats_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFormats"));
   select setval('public."DelayProfiles_Id_seq"', (SELECT MAX("Id")+1 FROM "DelayProfiles"));
   select setval('public."DownloadClients_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClients"));
   select setval('public."DownloadClientStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClientStatus"));
   select setval('public."DownloadHistory_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadHistory"));
   select setval('public."ExtraFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "ExtraFiles"));
   select setval('public."History_Id_seq"', (SELECT MAX("Id")+1 FROM "History"));
   select setval('public."ImportListExclusions_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportListExclusions"));
   select setval('public."ImportLists_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportLists"));
   select setval('public."ImportListStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportListStatus"));
   select setval('public."Indexers_Id_seq"', (SELECT MAX("Id")+1 FROM "Indexers"));
   select setval('public."IndexerStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "IndexerStatus"));
   select setval('public."LyricFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "LyricFiles"));
   select setval('public."Metadata_Id_seq"', (SELECT MAX("Id")+1 FROM "Metadata"));
   select setval('public."MetadataFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "MetadataFiles"));
   select setval('public."MetadataProfiles_Id_seq"', (SELECT MAX("Id")+1 FROM "MetadataProfiles"));
   select setval('public."NamingConfig_Id_seq"', (SELECT MAX("Id")+1 FROM "NamingConfig"));
   select setval('public."Notifications_Id_seq"', (SELECT MAX("Id")+1 FROM "Notifications"));
   select setval('public."PendingReleases_Id_seq"', (SELECT MAX("Id")+1 FROM "PendingReleases"));
   select setval('public."Profiles_Id_seq"', (SELECT MAX("Id")+1 FROM "QualityProfiles"));
   select setval('public."QualityDefinitions_Id_seq"', (SELECT MAX("Id")+1 FROM "QualityDefinitions"));
   select setval('public."RemotePathMappings_Id_seq"', (SELECT MAX("Id")+1 FROM "RemotePathMappings"));
   select setval('public."Restrictions_Id_seq"', (SELECT MAX("Id")+1 FROM "ReleaseProfiles"));
   select setval('public."RootFolders_Id_seq"', (SELECT MAX("Id")+1 FROM "RootFolders"));
   select setval('public."ScheduledTasks_Id_seq"', (SELECT MAX("Id")+1 FROM "ScheduledTasks"));
   select setval('public."Tags_Id_seq"', (SELECT MAX("Id")+1 FROM "Tags"));
   select setval('public."TrackFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "TrackFiles"));
   select setval('public."Tracks_Id_seq"', (SELECT MAX("Id")+1 FROM "Tracks"));
   select setval('public."Users_Id_seq"', (SELECT MAX("Id")+1 FROM "Users"));
   ```

6. Start Lidarr.
