---
title: Lidarr Environment Variables
description: Complete guide to Lidarr environment variables for configuration management including Docker, database, authentication, and server settings
published: true
date: 2025-12-16T17:04:28.314Z
tags: lidarr, docker, installation, scripts, postgres
editor: markdown
dateCreated: 2025-09-06T22:28:37.512Z
---

# Lidarr Environment Variables

Lidarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`LIDARR__CONFIGNAMESPACE__CONFIGITEM`

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
| `InstanceName`           | `APP`      | `INSTANCENAME`       | `LIDARR__APP__INSTANCENAME`       |
| `Theme`                  | `APP`      | `THEME`              | `LIDARR__APP__THEME`              |
| `LaunchBrowser`          | `APP`      | `LAUNCHBROWSER`      | `LIDARR__APP__LAUNCHBROWSER`      |
| `ApiKey`                 | `AUTH`     | `APIKEY`             | `LIDARR__AUTH__APIKEY`            |
| `AuthenticationEnabled`  | `AUTH`     | `ENABLED`            | `LIDARR__AUTH__ENABLED`           |
| `AuthenticationMethod`   | `AUTH`     | `METHOD`             | `LIDARR__AUTH__METHOD`            |
| `AuthenticationRequired` | `AUTH`     | `REQUIRED`           | `LIDARR__AUTH__REQUIRED`          |
| `LogLevel`               | `LOG`      | `LEVEL`              | `LIDARR__LOG__LEVEL`              |
| `FilterSentryEvents`     | `LOG`      | `FILTERSENTRYEVENTS` | `LIDARR__LOG__FILTERSENTRYEVENTS` |
| `LogRotate`              | `LOG`      | `ROTATE`             | `LIDARR__LOG__ROTATE`             |
| `LogSizeLimit`           | `LOG`      | `SIZELIMIT`          | `LIDARR__LOG__SIZELIMIT`          |
| `LogSql`                 | `LOG`      | `SQL`                | `LIDARR__LOG__SQL`                |
| `ConsoleLogLevel`        | `LOG`      | `CONSOLELEVEL`       | `LIDARR__LOG__CONSOLELEVEL`       |
| `ConsoleLogFormat`       | `LOG`      | `CONSOLEFORMAT`      | `LIDARR__LOG__CONSOLEFORMAT`      |
| `AnalyticsEnabled`       | `LOG`      | `ANALYTICSENABLED`   | `LIDARR__LOG__ANALYTICSENABLED`   |
| `SyslogServer`           | `LOG`      | `SYSLOGSERVER`       | `LIDARR__LOG__SYSLOGSERVER`       |
| `SyslogPort`             | `LOG`      | `SYSLOGPORT`         | `LIDARR__LOG__SYSLOGPORT`         |
| `SyslogLevel`            | `LOG`      | `SYSLOGLEVEL`        | `LIDARR__LOG__SYSLOGLEVEL`        |
| `DbEnabled`              | `LOG`      | `DBENABLED`          | `LIDARR__LOG__DBENABLED`          |
| `PostgresHost`           | `POSTGRES` | `HOST`               | `LIDARR__POSTGRES__HOST`          |
| `PostgresPort`           | `POSTGRES` | `PORT`               | `LIDARR__POSTGRES__PORT`          |
| `PostgresUser`           | `POSTGRES` | `USER`               | `LIDARR__POSTGRES__USER`          |
| `PostgresPassword`       | `POSTGRES` | `PASSWORD`           | `LIDARR__POSTGRES__PASSWORD`      |
| `PostgresMainDb`         | `POSTGRES` | `MAINDB`             | `LIDARR__POSTGRES__MAINDB`        |
| `PostgresLogDb`          | `POSTGRES` | `LOGDB`              | `LIDARR__POSTGRES__LOGDB`         |
| `UrlBase`                | `SERVER`   | `URLBASE`            | `LIDARR__SERVER__URLBASE`         |
| `BindAddress`            | `SERVER`   | `BINDADDRESS`        | `LIDARR__SERVER__BINDADDRESS`     |
| `Port`                   | `SERVER`   | `PORT`               | `LIDARR__SERVER__PORT`            |
| `EnableSsl`              | `SERVER`   | `ENABLESSL`          | `LIDARR__SERVER__ENABLESSL`       |
| `SslPort`                | `SERVER`   | `SSLPORT`            | `LIDARR__SERVER__SSLPORT`         |
| `SslCertPath`            | `SERVER`   | `SSLCERTPATH`        | `LIDARR__SERVER__SSLCERTPATH`     |
| `SslCertPassword`        | `SERVER`   | `SSLCERTPASSWORD`    | `LIDARR__SERVER__SSLCERTPASSWORD` |
| `UpdateMechanism`        | `UPDATE`   | `MECHANISM`          | `LIDARR__UPDATE__MECHANISM`       |
| `UpdateAutomatically`    | `UPDATE`   | `AUTOMATICALLY`      | `LIDARR__UPDATE__AUTOMATICALLY`   |
| `UpdateScriptPath`       | `UPDATE`   | `SCRIPTPATH`         | `LIDARR__UPDATE__SCRIPTPATH`      |
| `Branch`                 | `UPDATE`   | `BRANCH`             | `LIDARR__UPDATE__BRANCH`          |

## Usage Examples

### Docker Compose

```yaml
services:
  lidarr:
    image: lscr.io/linuxserver/lidarr:latest
    environment:
      - LIDARR__SERVER__PORT=8686
      - LIDARR__SERVER__URLBASE=/lidarr
      - LIDARR__POSTGRES__HOST=postgres
      - LIDARR__POSTGRES__USER=lidarr
      - LIDARR__POSTGRES__PASSWORD=lidarr_password
      - LIDARR__POSTGRES__MAINDB=lidarr
```

### Docker Run

```bash
docker run -d \
  --name lidarr \
  -e LIDARR__SERVER__PORT=8686 \
  -e LIDARR__SERVER__URLBASE=/lidarr \
  -e LIDARR__POSTGRES__HOST=postgres \
  -e LIDARR__POSTGRES__USER=lidarr \
  lscr.io/linuxserver/lidarr:latest
```

### System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

```bash
export LIDARR__SERVER__PORT=8686
export LIDARR__SERVER__URLBASE=/lidarr
```

**Windows:**

```cmd
set LIDARR__SERVER__PORT=8686
set LIDARR__SERVER__URLBASE=/lidarr
```

## Package Info File

For package maintainers and custom installations, Lidarr supports a `package_info` file to override deployment settings.

### Location

The `package_info` file should be placed in the parent directory of the `bin` folder:

```text
/opt/Lidarr/package_info
/opt/Lidarr/bin/Lidarr
```

### Format

The file uses simple key=value pairs, one per line:

```text
PackageVersion=1.0.0
PackageAuthor=YourName
UpdateMethod=External
Branch=master
```

### Available Keys

| Key | Description | Example |
|-----|-------------|---------|
| `PackageVersion` | Custom package version identifier | `1.0.0-custom` |
| `PackageAuthor` | Package maintainer name | `Community Package` |
| `PackageGlobalMessage` | Message displayed in UI | `Custom build for Debian 11` |
| `UpdateMethod` | How updates are handled (see values below) | `External` |
| `UpdateMethodMessage` | Custom message about update method | `Updates managed by apt` |
| `Branch` | Default branch to use | `master` or `develop` |
| `ReleaseVersion` | Override release version | `2.0.0.0` |

### UpdateMethod Values

| Value | Numeric | Description | Use Case |
|-------|---------|-------------|----------|
| `BuiltIn` | 0 | Default built-in updater | Standard installations |
| `Script` | 1 | Updates via custom script | Advanced custom setups |
| `External` | 10 | Updates managed externally | Package managers, Docker |
| `Apt` | 11 | Debian/Ubuntu package manager | Used by package maintainers |
| `Docker` | 12 | Docker container updates | Used by Docker maintainers |

### Real-World Example

**Arch Linux AUR Package** (from [prowlarr AUR](https://aur.archlinux.org/packages/prowlarr/)):

```text
# PackageVersion is added by PKGBUILD
PackageAuthor=[lidarr](https://aur.archlinux.org/packages/lidarr/)
UpdateMethod=External
UpdateMethodMessage=flag [lidarr](https://aur.archlinux.org/packages/lidarr/) [out-of-date](https://aur.archlinux.org/pkgbase/lidarr/flag/), use an [aur helper](https://wiki.archlinux.org/index.php/AUR_helpers) or the [manual method](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages) to update.
Branch=master
```

## Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Lidarr after changing environment variables
- The `package_info` file is read at startup and overrides built-in update mechanisms
- These variables are particularly useful for Docker deployments and automation
