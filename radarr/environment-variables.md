---
title: Radarr Environment Variables
description: Environment variables for configuring Radarr settings
published: true
date: 2025-09-06T00:00:00.000Z
tags: radarr, configuration, environment-variables
editor: markdown
dateCreated: 2025-09-06T00:00:00.000Z
---

# Radarr Environment Variables

Radarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`RADARR__CONFIGNAMESPACE__CONFIGITEM`

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
| `InstanceName` | `APP` | `INSTANCENAME` | `RADARR__APP__INSTANCENAME` |
| `Theme` | `APP` | `THEME` | `RADARR__APP__THEME` |
| `LaunchBrowser` | `APP` | `LAUNCHBROWSER` | `RADARR__APP__LAUNCHBROWSER` |
| `ApiKey` | `AUTH` | `APIKEY` | `RADARR__AUTH__APIKEY` |
| `AuthenticationEnabled` | `AUTH` | `ENABLED` | `RADARR__AUTH__ENABLED` |
| `AuthenticationMethod` | `AUTH` | `METHOD` | `RADARR__AUTH__METHOD` |
| `AuthenticationRequired` | `AUTH` | `REQUIRED` | `RADARR__AUTH__REQUIRED` |
| `LogLevel` | `LOG` | `LEVEL` | `RADARR__LOG__LEVEL` |
| `FilterSentryEvents` | `LOG` | `FILTERSENTRYEVENTS` | `RADARR__LOG__FILTERSENTRYEVENTS` |
| `LogRotate` | `LOG` | `ROTATE` | `RADARR__LOG__ROTATE` |
| `LogSizeLimit` | `LOG` | `SIZELIMIT` | `RADARR__LOG__SIZELIMIT` |
| `LogSql` | `LOG` | `SQL` | `RADARR__LOG__SQL` |
| `ConsoleLogLevel` | `LOG` | `CONSOLELEVEL` | `RADARR__LOG__CONSOLELEVEL` |
| `ConsoleLogFormat` | `LOG` | `CONSOLEFORMAT` | `RADARR__LOG__CONSOLEFORMAT` |
| `AnalyticsEnabled` | `LOG` | `ANALYTICSENABLED` | `RADARR__LOG__ANALYTICSENABLED` |
| `SyslogServer` | `LOG` | `SYSLOGSERVER` | `RADARR__LOG__SYSLOGSERVER` |
| `SyslogPort` | `LOG` | `SYSLOGPORT` | `RADARR__LOG__SYSLOGPORT` |
| `SyslogLevel` | `LOG` | `SYSLOGLEVEL` | `RADARR__LOG__SYSLOGLEVEL` |
| `DbEnabled` | `LOG` | `DBENABLED` | `RADARR__LOG__DBENABLED` |
| `PostgresHost` | `POSTGRES` | `HOST` | `RADARR__POSTGRES__HOST` |
| `PostgresPort` | `POSTGRES` | `PORT` | `RADARR__POSTGRES__PORT` |
| `PostgresUser` | `POSTGRES` | `USER` | `RADARR__POSTGRES__USER` |
| `PostgresPassword` | `POSTGRES` | `PASSWORD` | `RADARR__POSTGRES__PASSWORD` |
| `PostgresMainDb` | `POSTGRES` | `MAINDB` | `RADARR__POSTGRES__MAINDB` |
| `PostgresLogDb` | `POSTGRES` | `LOGDB` | `RADARR__POSTGRES__LOGDB` |
| `UrlBase` | `SERVER` | `URLBASE` | `RADARR__SERVER__URLBASE` |
| `BindAddress` | `SERVER` | `BINDADDRESS` | `RADARR__SERVER__BINDADDRESS` |
| `Port` | `SERVER` | `PORT` | `RADARR__SERVER__PORT` |
| `EnableSsl` | `SERVER` | `ENABLESSL` | `RADARR__SERVER__ENABLESSL` |
| `SslPort` | `SERVER` | `SSLPORT` | `RADARR__SERVER__SSLPORT` |
| `SslCertPath` | `SERVER` | `SSLCERTPATH` | `RADARR__SERVER__SSLCERTPATH` |
| `SslCertPassword` | `SERVER` | `SSLCERTPASSWORD` | `RADARR__SERVER__SSLCERTPASSWORD` |
| `UpdateMechanism` | `UPDATE` | `MECHANISM` | `RADARR__UPDATE__MECHANISM` |
| `UpdateAutomatically` | `UPDATE` | `AUTOMATICALLY` | `RADARR__UPDATE__AUTOMATICALLY` |
| `UpdateScriptPath` | `UPDATE` | `SCRIPTPATH` | `RADARR__UPDATE__SCRIPTPATH` |
| `Branch` | `UPDATE` | `BRANCH` | `RADARR__UPDATE__BRANCH` |

## Usage Examples

### Docker Compose

```yaml
services:
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    environment:
      - RADARR__SERVER__PORT=7878
      - RADARR__SERVER__URLBASE=/radarr
      - RADARR__POSTGRES__HOST=postgres
      - RADARR__POSTGRES__USER=radarr
      - RADARR__POSTGRES__PASSWORD=radarr_password
      - RADARR__POSTGRES__MAINDB=radarr
```

### Docker Run

```bash
docker run -d \
  --name radarr \
  -e RADARR__SERVER__PORT=7878 \
  -e RADARR__SERVER__URLBASE=/radarr \
  -e RADARR__POSTGRES__HOST=postgres \
  -e RADARR__POSTGRES__USER=radarr \
  lscr.io/linuxserver/radarr:latest
```

### System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

```bash
export RADARR__SERVER__PORT=7878
export RADARR__SERVER__URLBASE=/radarr
export RADARR__POSTGRES__HOST=localhost
```

**Windows:**

```cmd
set RADARR__SERVER__PORT=7878
set RADARR__SERVER__URLBASE=/radarr
set RADARR__POSTGRES__HOST=localhost
```

## Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Radarr after changing environment variables
- These variables are particularly useful for Docker deployments and automation
