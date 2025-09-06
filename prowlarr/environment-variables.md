---
title: Prowlarr Environment Variables
description: Complete guide to Prowlarr environment variables for configuration management including Docker, database, authentication, and server settings
published: true
date: 2025-09-06T00:00:00.000Z
tags: docker, installation, postgres, prowlarr
editor: markdown
dateCreated: 2025-09-06T00:00:00.000Z
---

# Prowlarr Environment Variables

Prowlarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`PROWLARR__CONFIGNAMESPACE__CONFIGITEM`

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
| `InstanceName`           | `APP`      | `INSTANCENAME`       | `PROWLARR__APP__INSTANCENAME`       |
| `Theme`                  | `APP`      | `THEME`              | `PROWLARR__APP__THEME`              |
| `LaunchBrowser`          | `APP`      | `LAUNCHBROWSER`      | `PROWLARR__APP__LAUNCHBROWSER`      |
| `ApiKey`                 | `AUTH`     | `APIKEY`             | `PROWLARR__AUTH__APIKEY`            |
| `AuthenticationEnabled`  | `AUTH`     | `ENABLED`            | `PROWLARR__AUTH__ENABLED`           |
| `AuthenticationMethod`   | `AUTH`     | `METHOD`             | `PROWLARR__AUTH__METHOD`            |
| `AuthenticationRequired` | `AUTH`     | `REQUIRED`           | `PROWLARR__AUTH__REQUIRED`          |
| `LogLevel`               | `LOG`      | `LEVEL`              | `PROWLARR__LOG__LEVEL`              |
| `FilterSentryEvents`     | `LOG`      | `FILTERSENTRYEVENTS` | `PROWLARR__LOG__FILTERSENTRYEVENTS` |
| `LogRotate`              | `LOG`      | `ROTATE`             | `PROWLARR__LOG__ROTATE`             |
| `LogSizeLimit`           | `LOG`      | `SIZELIMIT`          | `PROWLARR__LOG__SIZELIMIT`          |
| `LogSql`                 | `LOG`      | `SQL`                | `PROWLARR__LOG__SQL`                |
| `ConsoleLogLevel`        | `LOG`      | `CONSOLELEVEL`       | `PROWLARR__LOG__CONSOLELEVEL`       |
| `ConsoleLogFormat`       | `LOG`      | `CONSOLEFORMAT`      | `PROWLARR__LOG__CONSOLEFORMAT`      |
| `AnalyticsEnabled`       | `LOG`      | `ANALYTICSENABLED`   | `PROWLARR__LOG__ANALYTICSENABLED`   |
| `SyslogServer`           | `LOG`      | `SYSLOGSERVER`       | `PROWLARR__LOG__SYSLOGSERVER`       |
| `SyslogPort`             | `LOG`      | `SYSLOGPORT`         | `PROWLARR__LOG__SYSLOGPORT`         |
| `SyslogLevel`            | `LOG`      | `SYSLOGLEVEL`        | `PROWLARR__LOG__SYSLOGLEVEL`        |
| `DbEnabled`              | `LOG`      | `DBENABLED`          | `PROWLARR__LOG__DBENABLED`          |
| `PostgresHost`           | `POSTGRES` | `HOST`               | `PROWLARR__POSTGRES__HOST`          |
| `PostgresPort`           | `POSTGRES` | `PORT`               | `PROWLARR__POSTGRES__PORT`          |
| `PostgresUser`           | `POSTGRES` | `USER`               | `PROWLARR__POSTGRES__USER`          |
| `PostgresPassword`       | `POSTGRES` | `PASSWORD`           | `PROWLARR__POSTGRES__PASSWORD`      |
| `PostgresMainDb`         | `POSTGRES` | `MAINDB`             | `PROWLARR__POSTGRES__MAINDB`        |
| `PostgresLogDb`          | `POSTGRES` | `LOGDB`              | `PROWLARR__POSTGRES__LOGDB`         |
| `UrlBase`                | `SERVER`   | `URLBASE`            | `PROWLARR__SERVER__URLBASE`         |
| `BindAddress`            | `SERVER`   | `BINDADDRESS`        | `PROWLARR__SERVER__BINDADDRESS`     |
| `Port`                   | `SERVER`   | `PORT`               | `PROWLARR__SERVER__PORT`            |
| `EnableSsl`              | `SERVER`   | `ENABLESSL`          | `PROWLARR__SERVER__ENABLESSL`       |
| `SslPort`                | `SERVER`   | `SSLPORT`            | `PROWLARR__SERVER__SSLPORT`         |
| `SslCertPath`            | `SERVER`   | `SSLCERTPATH`        | `PROWLARR__SERVER__SSLCERTPATH`     |
| `SslCertPassword`        | `SERVER`   | `SSLCERTPASSWORD`    | `PROWLARR__SERVER__SSLCERTPASSWORD` |
| `UpdateMechanism`        | `UPDATE`   | `MECHANISM`          | `PROWLARR__UPDATE__MECHANISM`       |
| `UpdateAutomatically`    | `UPDATE`   | `AUTOMATICALLY`      | `PROWLARR__UPDATE__AUTOMATICALLY`   |
| `UpdateScriptPath`       | `UPDATE`   | `SCRIPTPATH`         | `PROWLARR__UPDATE__SCRIPTPATH`      |
| `Branch`                 | `UPDATE`   | `BRANCH`             | `PROWLARR__UPDATE__BRANCH`          |

## Usage Examples

### Docker Compose

```yaml
services:
  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    environment:
      - PROWLARR__SERVER__PORT=9696
      - PROWLARR__SERVER__URLBASE=/prowlarr
      - PROWLARR__POSTGRES__HOST=postgres
      - PROWLARR__POSTGRES__USER=prowlarr
      - PROWLARR__POSTGRES__PASSWORD=prowlarr_password
      - PROWLARR__POSTGRES__MAINDB=prowlarr
```

### Docker Run

```bash
docker run -d \
  --name prowlarr \
  -e PROWLARR__SERVER__PORT=9696 \
  -e PROWLARR__SERVER__URLBASE=/prowlarr \
  -e PROWLARR__POSTGRES__HOST=postgres \
  -e PROWLARR__POSTGRES__USER=prowlarr \
  lscr.io/linuxserver/prowlarr:latest
```

### System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

```bash
export PROWLARR__SERVER__PORT=9696
export PROWLARR__SERVER__URLBASE=/prowlarr
```

**Windows:**

```cmd
set PROWLARR__SERVER__PORT=9696
set PROWLARR__SERVER__URLBASE=/prowlarr
```

## Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Prowlarr after changing environment variables
- These variables are particularly useful for Docker deployments and automation
