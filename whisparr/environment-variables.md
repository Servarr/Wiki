---
title: Whisparr Environment Variables
description: Complete guide to Whisparr environment variables for configuration management including Docker, database, authentication, and server settings
published: true
date: 2025-09-06T00:00:00.000Z
tags: whisparr, configuration, environment-variables, docker, installation, postgres
editor: markdown
dateCreated: 2025-09-06T00:00:00.000Z
---

# Whisparr Environment Variables

Whisparr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`WHISPARR__CONFIGNAMESPACE__CONFIGITEM`

## Configuration Namespaces

The config namespaces are shared between all Servarr apps and correspond to the option types in the project:

- **APP** - Application-specific settings
- **AUTH** - Authentication settings
- **LOG** - Logging configuration
- **POSTGRES** - PostgreSQL database settings
- **SERVER** - Server and network settings
- **UPDATE** - Update mechanism settings

## Environment Variables Table

| Config Option            | Namespace  | Variable Name        | Full Environment Variable           |
| ------------------------ | ---------- | -------------------- | ----------------------------------- |
| `InstanceName`           | `APP`      | `INSTANCENAME`       | `WHISPARR__APP__INSTANCENAME`       |
| `Theme`                  | `APP`      | `THEME`              | `WHISPARR__APP__THEME`              |
| `LaunchBrowser`          | `APP`      | `LAUNCHBROWSER`      | `WHISPARR__APP__LAUNCHBROWSER`      |
| `ApiKey`                 | `AUTH`     | `APIKEY`             | `WHISPARR__AUTH__APIKEY`            |
| `AuthenticationEnabled`  | `AUTH`     | `ENABLED`            | `WHISPARR__AUTH__ENABLED`           |
| `AuthenticationMethod`   | `AUTH`     | `METHOD`             | `WHISPARR__AUTH__METHOD`            |
| `AuthenticationRequired` | `AUTH`     | `REQUIRED`           | `WHISPARR__AUTH__REQUIRED`          |
| `LogLevel`               | `LOG`      | `LEVEL`              | `WHISPARR__LOG__LEVEL`              |
| `FilterSentryEvents`     | `LOG`      | `FILTERSENTRYEVENTS` | `WHISPARR__LOG__FILTERSENTRYEVENTS` |
| `LogRotate`              | `LOG`      | `ROTATE`             | `WHISPARR__LOG__ROTATE`             |
| `LogSizeLimit`           | `LOG`      | `SIZELIMIT`          | `WHISPARR__LOG__SIZELIMIT`          |
| `LogSql`                 | `LOG`      | `SQL`                | `WHISPARR__LOG__SQL`                |
| `ConsoleLogLevel`        | `LOG`      | `CONSOLELEVEL`       | `WHISPARR__LOG__CONSOLELEVEL`       |
| `ConsoleLogFormat`       | `LOG`      | `CONSOLEFORMAT`      | `WHISPARR__LOG__CONSOLEFORMAT`      |
| `AnalyticsEnabled`       | `LOG`      | `ANALYTICSENABLED`   | `WHISPARR__LOG__ANALYTICSENABLED`   |
| `SyslogServer`           | `LOG`      | `SYSLOGSERVER`       | `WHISPARR__LOG__SYSLOGSERVER`       |
| `SyslogPort`             | `LOG`      | `SYSLOGPORT`         | `WHISPARR__LOG__SYSLOGPORT`         |
| `SyslogLevel`            | `LOG`      | `SYSLOGLEVEL`        | `WHISPARR__LOG__SYSLOGLEVEL`        |
| `DbEnabled`              | `LOG`      | `DBENABLED`          | `WHISPARR__LOG__DBENABLED`          |
| `PostgresHost`           | `POSTGRES` | `HOST`               | `WHISPARR__POSTGRES__HOST`          |
| `PostgresPort`           | `POSTGRES` | `PORT`               | `WHISPARR__POSTGRES__PORT`          |
| `PostgresUser`           | `POSTGRES` | `USER`               | `WHISPARR__POSTGRES__USER`          |
| `PostgresPassword`       | `POSTGRES` | `PASSWORD`           | `WHISPARR__POSTGRES__PASSWORD`      |
| `PostgresMainDb`         | `POSTGRES` | `MAINDB`             | `WHISPARR__POSTGRES__MAINDB`        |
| `PostgresLogDb`          | `POSTGRES` | `LOGDB`              | `WHISPARR__POSTGRES__LOGDB`         |
| `UrlBase`                | `SERVER`   | `URLBASE`            | `WHISPARR__SERVER__URLBASE`         |
| `BindAddress`            | `SERVER`   | `BINDADDRESS`        | `WHISPARR__SERVER__BINDADDRESS`     |
| `Port`                   | `SERVER`   | `PORT`               | `WHISPARR__SERVER__PORT`            |
| `EnableSsl`              | `SERVER`   | `ENABLESSL`          | `WHISPARR__SERVER__ENABLESSL`       |
| `SslPort`                | `SERVER`   | `SSLPORT`            | `WHISPARR__SERVER__SSLPORT`         |
| `SslCertPath`            | `SERVER`   | `SSLCERTPATH`        | `WHISPARR__SERVER__SSLCERTPATH`     |
| `SslCertPassword`        | `SERVER`   | `SSLCERTPASSWORD`    | `WHISPARR__SERVER__SSLCERTPASSWORD` |
| `UpdateMechanism`        | `UPDATE`   | `MECHANISM`          | `WHISPARR__UPDATE__MECHANISM`       |
| `UpdateAutomatically`    | `UPDATE`   | `AUTOMATICALLY`      | `WHISPARR__UPDATE__AUTOMATICALLY`   |
| `UpdateScriptPath`       | `UPDATE`   | `SCRIPTPATH`         | `WHISPARR__UPDATE__SCRIPTPATH`      |
| `Branch`                 | `UPDATE`   | `BRANCH`             | `WHISPARR__UPDATE__BRANCH`          |

## Usage Examples

### Docker Compose

```yaml
services:
  whisparr:
    image: ghcr.io/hotio/whisparr:latest
    environment:
      - WHISPARR__SERVER__PORT=6969
      - WHISPARR__SERVER__URLBASE=/whisparr
      - WHISPARR__POSTGRES__HOST=postgres
      - WHISPARR__POSTGRES__USER=whisparr
      - WHISPARR__POSTGRES__PASSWORD=whisparr_password
      - WHISPARR__POSTGRES__MAINDB=whisparr
```

### Docker Run

```bash
docker run -d
  --name whisparr
  -e WHISPARR__SERVER__PORT=6969
  -e WHISPARR__SERVER__URLBASE=/whisparr
  -e WHISPARR__POSTGRES__HOST=postgres
  -e WHISPARR__POSTGRES__USER=whisparr
  ghcr.io/hotio/whisparr:latest
```

### System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

```bash
export WHISPARR__SERVER__PORT=6969
export WHISPARR__SERVER__URLBASE=/whisparr
```

**Windows:**

```cmd
set WHISPARR__SERVER__PORT=6969
set WHISPARR__SERVER__URLBASE=/whisparr
```

## Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Whisparr after changing environment variables
- These variables are particularly useful for Docker deployments and automation
