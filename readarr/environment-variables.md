---
title: Readarr Environment Variables (Retired)
description: Complete guide to Readarr environment variables for configuration management including Docker, database, authentication, and server settings
published: true
date: 2025-09-06T00:00:00.000Z
tags: readarr, configuration, environment-variables, docker, installation, postgres
editor: markdown
dateCreated: 2025-09-06T00:00:00.000Z
---

# Readarr Environment Variables

Readarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`READARR__CONFIGNAMESPACE__CONFIGITEM`

## Configuration Namespaces

The config namespaces are shared between all Servarr apps and correspond to the option types in the project:

- **APP** - Application-specific settings
- **AUTH** - Authentication settings
- **LOG** - Logging configuration
- **POSTGRES** - PostgreSQL database settings
- **SERVER** - Server and network settings
- **UPDATE** - Update mechanism settings

## Environment Variables Table

| Config Option | Namespace | Variable Name | Full Environment Variable |
|---------------|-----------|---------------|---------------------------|
| `InstanceName` | `APP` | `INSTANCENAME` | `READARR__APP__INSTANCENAME` |
| `Theme` | `APP` | `THEME` | `READARR__APP__THEME` |
| `LaunchBrowser` | `APP` | `LAUNCHBROWSER` | `READARR__APP__LAUNCHBROWSER` |
| `ApiKey` | `AUTH` | `APIKEY` | `READARR__AUTH__APIKEY` |
| `AuthenticationEnabled` | `AUTH` | `ENABLED` | `READARR__AUTH__ENABLED` |
| `AuthenticationMethod` | `AUTH` | `METHOD` | `READARR__AUTH__METHOD` |
| `AuthenticationRequired` | `AUTH` | `REQUIRED` | `READARR__AUTH__REQUIRED` |
| `LogLevel` | `LOG` | `LEVEL` | `READARR__LOG__LEVEL` |
| `FilterSentryEvents` | `LOG` | `FILTERSENTRYEVENTS` | `READARR__LOG__FILTERSENTRYEVENTS` |
| `LogRotate` | `LOG` | `ROTATE` | `READARR__LOG__ROTATE` |
| `LogSizeLimit` | `LOG` | `SIZELIMIT` | `READARR__LOG__SIZELIMIT` |
| `LogSql` | `LOG` | `SQL` | `READARR__LOG__SQL` |
| `ConsoleLogLevel` | `LOG` | `CONSOLELEVEL` | `READARR__LOG__CONSOLELEVEL` |
| `ConsoleLogFormat` | `LOG` | `CONSOLEFORMAT` | `READARR__LOG__CONSOLEFORMAT` |
| `AnalyticsEnabled` | `LOG` | `ANALYTICSENABLED` | `READARR__LOG__ANALYTICSENABLED` |
| `SyslogServer` | `LOG` | `SYSLOGSERVER` | `READARR__LOG__SYSLOGSERVER` |
| `SyslogPort` | `LOG` | `SYSLOGPORT` | `READARR__LOG__SYSLOGPORT` |
| `SyslogLevel` | `LOG` | `SYSLOGLEVEL` | `READARR__LOG__SYSLOGLEVEL` |
| `DbEnabled` | `LOG` | `DBENABLED` | `READARR__LOG__DBENABLED` |
| `PostgresHost` | `POSTGRES` | `HOST` | `READARR__POSTGRES__HOST` |
| `PostgresPort` | `POSTGRES` | `PORT` | `READARR__POSTGRES__PORT` |
| `PostgresUser` | `POSTGRES` | `USER` | `READARR__POSTGRES__USER` |
| `PostgresPassword` | `POSTGRES` | `PASSWORD` | `READARR__POSTGRES__PASSWORD` |
| `PostgresMainDb` | `POSTGRES` | `MAINDB` | `READARR__POSTGRES__MAINDB` |
| `PostgresLogDb` | `POSTGRES` | `LOGDB` | `READARR__POSTGRES__LOGDB` |
| `UrlBase` | `SERVER` | `URLBASE` | `READARR__SERVER__URLBASE` |
| `BindAddress` | `SERVER` | `BINDADDRESS` | `READARR__SERVER__BINDADDRESS` |
| `Port` | `SERVER` | `PORT` | `READARR__SERVER__PORT` |
| `EnableSsl` | `SERVER` | `ENABLESSL` | `READARR__SERVER__ENABLESSL` |
| `SslPort` | `SERVER` | `SSLPORT` | `READARR__SERVER__SSLPORT` |
| `SslCertPath` | `SERVER` | `SSLCERTPATH` | `READARR__SERVER__SSLCERTPATH` |
| `SslCertPassword` | `SERVER` | `SSLCERTPASSWORD` | `READARR__SERVER__SSLCERTPASSWORD` |
| `UpdateMechanism` | `UPDATE` | `MECHANISM` | `READARR__UPDATE__MECHANISM` |
| `UpdateAutomatically` | `UPDATE` | `AUTOMATICALLY` | `READARR__UPDATE__AUTOMATICALLY` |
| `UpdateScriptPath` | `UPDATE` | `SCRIPTPATH` | `READARR__UPDATE__SCRIPTPATH` |
| `Branch` | `UPDATE` | `BRANCH` | `READARR__UPDATE__BRANCH` |

## Usage Examples

### Docker Compose

```yaml
services:
  readarr:
    image: lscr.io/linuxserver/readarr:develop
    environment:
      - READARR__SERVER__PORT=8787
      - READARR__SERVER__URLBASE=/readarr
      - READARR__POSTGRES__HOST=postgres
      - READARR__POSTGRES__USER=readarr
      - READARR__POSTGRES__PASSWORD=readarr_password
      - READARR__POSTGRES__MAINDB=readarr
```

### Docker Run

```bash
docker run -d \
  --name readarr \
  -e READARR__SERVER__PORT=8787 \
  -e READARR__SERVER__URLBASE=/readarr \
  -e READARR__POSTGRES__HOST=postgres \
  -e READARR__POSTGRES__USER=readarr \
  lscr.io/linuxserver/readarr:develop
```

### System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

```bash
export READARR__SERVER__PORT=8787
export READARR__SERVER__URLBASE=/readarr
```

**Windows:**

```cmd
set READARR__SERVER__PORT=8787
set READARR__SERVER__URLBASE=/readarr
```

## Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Readarr after changing environment variables
- These variables are particularly useful for Docker deployments and automation
