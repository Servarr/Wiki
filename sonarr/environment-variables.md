---
title: Sonarr Environment Variables
description: Complete guide to Sonarr environment variables for configuration management including Docker, database, authentication, and server settings
published: true
date: 2025-09-06T00:00:00.000Z
tags: sonarr, configuration, environment-variables, docker, installation, postgres
editor: markdown
dateCreated: 2025-09-06T00:00:00.000Z
---

# Sonarr Environment Variables

Sonarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`SONARR__CONFIGNAMESPACE__CONFIGITEM`

## Configuration Namespaces

The config namespaces are shared between all Servarr apps and correspond to the option types in the project:

- **APP** - Application-specific settings
- **AUTH** - Authentication settings
- **LOG** - Logging configuration
- **POSTGRES** - PostgreSQL database settings
- **SERVER** - Server and network settings
- **UPDATE** - Update mechanism settings

## Environment Variables Table

| Config Option            | Namespace  | Variable Name        | Full Environment Variable         |
| ------------------------ | ---------- | -------------------- | --------------------------------- |
| `InstanceName`           | `APP`      | `INSTANCENAME`       | `SONARR__APP__INSTANCENAME`       |
| `Theme`                  | `APP`      | `THEME`              | `SONARR__APP__THEME`              |
| `LaunchBrowser`          | `APP`      | `LAUNCHBROWSER`      | `SONARR__APP__LAUNCHBROWSER`      |
| `ApiKey`                 | `AUTH`     | `APIKEY`             | `SONARR__AUTH__APIKEY`            |
| `AuthenticationEnabled`  | `AUTH`     | `ENABLED`            | `SONARR__AUTH__ENABLED`           |
| `AuthenticationMethod`   | `AUTH`     | `METHOD`             | `SONARR__AUTH__METHOD`            |
| `AuthenticationRequired` | `AUTH`     | `REQUIRED`           | `SONARR__AUTH__REQUIRED`          |
| `LogLevel`               | `LOG`      | `LEVEL`              | `SONARR__LOG__LEVEL`              |
| `FilterSentryEvents`     | `LOG`      | `FILTERSENTRYEVENTS` | `SONARR__LOG__FILTERSENTRYEVENTS` |
| `LogRotate`              | `LOG`      | `ROTATE`             | `SONARR__LOG__ROTATE`             |
| `LogSizeLimit`           | `LOG`      | `SIZELIMIT`          | `SONARR__LOG__SIZELIMIT`          |
| `LogSql`                 | `LOG`      | `SQL`                | `SONARR__LOG__SQL`                |
| `ConsoleLogLevel`        | `LOG`      | `CONSOLELEVEL`       | `SONARR__LOG__CONSOLELEVEL`       |
| `ConsoleLogFormat`       | `LOG`      | `CONSOLEFORMAT`      | `SONARR__LOG__CONSOLEFORMAT`      |
| `AnalyticsEnabled`       | `LOG`      | `ANALYTICSENABLED`   | `SONARR__LOG__ANALYTICSENABLED`   |
| `SyslogServer`           | `LOG`      | `SYSLOGSERVER`       | `SONARR__LOG__SYSLOGSERVER`       |
| `SyslogPort`             | `LOG`      | `SYSLOGPORT`         | `SONARR__LOG__SYSLOGPORT`         |
| `SyslogLevel`            | `LOG`      | `SYSLOGLEVEL`        | `SONARR__LOG__SYSLOGLEVEL`        |
| `DbEnabled`              | `LOG`      | `DBENABLED`          | `SONARR__LOG__DBENABLED`          |
| `PostgresHost`           | `POSTGRES` | `HOST`               | `SONARR__POSTGRES__HOST`          |
| `PostgresPort`           | `POSTGRES` | `PORT`               | `SONARR__POSTGRES__PORT`          |
| `PostgresUser`           | `POSTGRES` | `USER`               | `SONARR__POSTGRES__USER`          |
| `PostgresPassword`       | `POSTGRES` | `PASSWORD`           | `SONARR__POSTGRES__PASSWORD`      |
| `PostgresMainDb`         | `POSTGRES` | `MAINDB`             | `SONARR__POSTGRES__MAINDB`        |
| `PostgresLogDb`          | `POSTGRES` | `LOGDB`              | `SONARR__POSTGRES__LOGDB`         |
| `UrlBase`                | `SERVER`   | `URLBASE`            | `SONARR__SERVER__URLBASE`         |
| `BindAddress`            | `SERVER`   | `BINDADDRESS`        | `SONARR__SERVER__BINDADDRESS`     |
| `Port`                   | `SERVER`   | `PORT`               | `SONARR__SERVER__PORT`            |
| `EnableSsl`              | `SERVER`   | `ENABLESSL`          | `SONARR__SERVER__ENABLESSL`       |
| `SslPort`                | `SERVER`   | `SSLPORT`            | `SONARR__SERVER__SSLPORT`         |
| `SslCertPath`            | `SERVER`   | `SSLCERTPATH`        | `SONARR__SERVER__SSLCERTPATH`     |
| `SslCertPassword`        | `SERVER`   | `SSLCERTPASSWORD`    | `SONARR__SERVER__SSLCERTPASSWORD` |
| `UpdateMechanism`        | `UPDATE`   | `MECHANISM`          | `SONARR__UPDATE__MECHANISM`       |
| `UpdateAutomatically`    | `UPDATE`   | `AUTOMATICALLY`      | `SONARR__UPDATE__AUTOMATICALLY`   |
| `UpdateScriptPath`       | `UPDATE`   | `SCRIPTPATH`         | `SONARR__UPDATE__SCRIPTPATH`      |
| `Branch`                 | `UPDATE`   | `BRANCH`             | `SONARR__UPDATE__BRANCH`          |

## Usage Examples

### Docker Compose

```yaml
services:
  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    environment:
      - SONARR__SERVER__PORT=8989
      - SONARR__SERVER__URLBASE=/sonarr
      - SONARR__POSTGRES__HOST=postgres
      - SONARR__POSTGRES__USER=sonarr
      - SONARR__POSTGRES__PASSWORD=sonarr_password
      - SONARR__POSTGRES__MAINDB=sonarr
```

### Docker Run

```bash
docker run -d \
  --name sonarr \
  -e SONARR__SERVER__PORT=8989 \
  -e SONARR__SERVER__URLBASE=/sonarr \
  -e SONARR__POSTGRES__HOST=postgres \
  -e SONARR__POSTGRES__USER=sonarr \
  lscr.io/linuxserver/sonarr:latest
```

### System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

```bash
export SONARR__SERVER__PORT=8989
export SONARR__SERVER__URLBASE=/sonarr
export SONARR__POSTGRES__HOST=localhost
```

**Windows:**

```cmd
set SONARR__SERVER__PORT=8989
set SONARR__SERVER__URLBASE=/sonarr
set SONARR__POSTGRES__HOST=localhost
```

## Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Sonarr after changing environment variables
- These variables are particularly useful for Docker deployments and automation
