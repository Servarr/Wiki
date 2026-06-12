---
title: Lidarr Configuring PostgreSQL Database
description: Configuring Lidarr with a Postgres Database
published: true
date: 2026-06-12T12:43:34.868Z
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

## Backing up and restoring Postgres

> Lidarr's built-in backup covers only the application config (`config.xml`) and, when using SQLite, the database files. It does not back up a Postgres database. Restoring a Lidarr backup will not restore your Postgres data.
{.is-danger}

Use `pg_dump` to back up each database separately. The examples below use the `postgres:17` Docker container from the setup above. Adjust the container name, user, and database names to match your environment.

### Creating a backup

**Native Postgres install:**

```shell
pg_dump -U qstick -F c -f /path/to/backups/lidarr-main.dump lidarr-main
pg_dump -U qstick -F c -f /path/to/backups/lidarr-log.dump lidarr-log
```

**Docker:**

```shell
docker exec postgres17 pg_dump -U qstick -F c lidarr-main > /path/to/backups/lidarr-main.dump
docker exec postgres17 pg_dump -U qstick -F c lidarr-log > /path/to/backups/lidarr-log.dump
```

The `-F c` flag uses the custom format, which is compressed and supports selective restore with `pg_restore`. Use `-F p` for a plain SQL file if you prefer something human-readable.

### Restoring from a backup

1. Stop Lidarr.
2. Drop and recreate the target databases so you start from a clean state:

   ```sql
   DROP DATABASE "lidarr-main";
   DROP DATABASE "lidarr-log";
   CREATE DATABASE "lidarr-main";
   CREATE DATABASE "lidarr-log";
   ```

3. Restore each dump:

   **Native Postgres install:**

   ```shell
   pg_restore -U qstick -d lidarr-main /path/to/backups/lidarr-main.dump
   pg_restore -U qstick -d lidarr-log /path/to/backups/lidarr-log.dump
   ```

   **Docker:**

   ```shell
   docker exec -i postgres17 pg_restore -U qstick -d lidarr-main < /path/to/backups/lidarr-main.dump
   docker exec -i postgres17 pg_restore -U qstick -d lidarr-log < /path/to/backups/lidarr-log.dump
   ```

4. Start Lidarr.

### Automating backups

> Keep several days of rolling backups. A single backup file that gets overwritten daily gives you no recovery point if the database was already corrupted before the last dump ran.
{.is-warning}

Store dumps in a location that is included in your normal system or offsite backup.

#### Linux and macOS

Use `cron` to schedule a daily dump. The example below backs up the main database and removes dumps older than 7 days:

```shell
0 2 * * * pg_dump -U qstick -F c lidarr-main > /path/to/backups/lidarr-main-$(date +\%Y\%m\%d).dump && find /path/to/backups -name "lidarr-main-*.dump" -mtime +7 -delete
```

Add a second entry for the log database if you want to preserve it as well.

#### Windows

> The scripts below are provided for convenience and reference only. They are not supported by the Servarr team. Review them before running and adapt them to your environment.
{.is-warning}

The following PowerShell script creates a scheduled task that backs up both databases daily and removes dumps older than the retention period. Run it once as Administrator. Re-run it with updated parameters to change the schedule or connection details.

```powershell
# New-LidarrBackupTask.ps1
# Creates a Windows scheduled task that backs up Lidarr's Postgres databases.
#
# Parameters:
#   -PgHost         Postgres host             (default: localhost)
#   -PgPort         Postgres port             (default: 5432)
#   -PgUser         Postgres username         (default: qstick)
#   -PgPassword     Postgres password         (default: qstick)
#   -MainDb         Main database name        (default: lidarr-main)
#   -LogDb          Log database name         (default: lidarr-log)
#   -BackupDir      Directory for dump files  (default: C:\ProgramData\lidarr-backup\dumps)
#   -RetentionDays  Days of backups to keep   (default: 7)
#   -RunAt          Daily run time HH:mm      (default: 02:00)
#   -TaskName       Scheduled task name       (default: Lidarr Postgres Backup)

param(
    [string]$PgHost        = "localhost",
    [int]   $PgPort        = 5432,
    [string]$PgUser        = "qstick",
    [string]$PgPassword    = "qstick",
    [string]$MainDb        = "lidarr-main",
    [string]$LogDb         = "lidarr-log",
    [string]$BackupDir     = "C:\ProgramData\lidarr-backup\dumps",
    [int]   $RetentionDays = 7,
    [string]$RunAt         = "02:00",
    [string]$TaskName      = "Lidarr Postgres Backup"
)

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Run this script as Administrator."
    exit 1
}

$installDir = "C:\ProgramData\lidarr-backup"
$scriptPath = Join-Path $installDir "Invoke-LidarrBackup.ps1"

foreach ($dir in $installDir, $BackupDir) {
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
}

# Write the backup script with connection details embedded.
# To change settings, re-run New-LidarrBackupTask.ps1 rather than editing this file.
@"
`$PgHost        = '$PgHost'
`$PgPort        = $PgPort
`$PgUser        = '$PgUser'
`$PgPassword    = '$PgPassword'
`$MainDb        = '$MainDb'
`$LogDb         = '$LogDb'
`$BackupDir     = '$BackupDir'
`$RetentionDays = $RetentionDays

`$env:PGPASSWORD = `$PgPassword
`$date = Get-Date -Format 'yyyyMMdd-HHmmss'

# Locate pg_dump. Uses PATH first, then searches common install locations.
`$pgDump = 'pg_dump'
if (-not (Get-Command `$pgDump -ErrorAction SilentlyContinue)) {
    `$found = Get-ChildItem 'C:\Program Files\PostgreSQL' -Filter 'pg_dump.exe' -Recurse -ErrorAction SilentlyContinue |
              Sort-Object FullName -Descending |
              Select-Object -First 1
    if (`$found) {
        `$pgDump = `$found.FullName
    } else {
        Write-Error 'pg_dump not found. Add the PostgreSQL bin directory to PATH or install PostgreSQL client tools.'
        exit 1
    }
}

if (-not (Test-Path `$BackupDir)) { New-Item -ItemType Directory -Path `$BackupDir | Out-Null }

function Invoke-Dump {
    param([string]`$Db, [string]`$Label)
    `$file = Join-Path `$BackupDir "`$Label-`$date.dump"
    & `$pgDump -h `$PgHost -p `$PgPort -U `$PgUser -F c -f `$file `$Db
    if (`$LASTEXITCODE -ne 0) {
        Write-Error "Backup of `$Db failed (exit code `$LASTEXITCODE)."
        exit 1
    }
    Write-Host "Backed up `$Db to `$file"
}

Invoke-Dump -Db `$MainDb -Label 'lidarr-main'
Invoke-Dump -Db `$LogDb  -Label 'lidarr-log'

Get-ChildItem `$BackupDir -Filter '*.dump' |
    Where-Object { `$_.LastWriteTime -lt (Get-Date).AddDays(-`$RetentionDays) } |
    ForEach-Object {
        Remove-Item `$_.FullName
        Write-Host "Removed old backup: `$(`$_.Name)"
    }

`$env:PGPASSWORD = ''
"@ | Set-Content -Path $scriptPath -Encoding UTF8

$action    = New-ScheduledTaskAction -Execute 'powershell.exe' `
                 -Argument "-NonInteractive -ExecutionPolicy Bypass -File `"$scriptPath`""
$trigger   = New-ScheduledTaskTrigger -Daily -At $RunAt
$settings  = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Hours 1) -StartWhenAvailable
$principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName $TaskName `
    -Action $action -Trigger $trigger -Settings $settings -Principal $principal `
    -Force | Out-Null

Write-Host "Task '$TaskName' registered. Backups will run daily at $RunAt."
Write-Host "Backup script: $scriptPath"
Write-Host "Dump directory: $BackupDir"
```

Run the script from an elevated PowerShell prompt:

```powershell
.\New-LidarrBackupTask.ps1 -PgPassword "yourpassword" -BackupDir "D:\backups\lidarr" -RetentionDays 14
```

The script writes `Invoke-LidarrBackup.ps1` to `C:\ProgramData\lidarr-backup\` with your connection details embedded, then registers a daily scheduled task running as the SYSTEM account. To update the schedule or connection details, re-run `New-LidarrBackupTask.ps1` with the new parameters rather than editing the generated script directly.

> The password is stored in plain text inside the generated script. Restrict access to `C:\ProgramData\lidarr-backup\` to administrator accounts only.
{.is-warning}