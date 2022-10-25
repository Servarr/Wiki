---
title: Prowlarr Troubleshooting
description: 
published: true
date: 2022-10-18T16:51:08.838Z
tags: prowlarr, troubleshooting
editor: markdown
dateCreated: 2021-06-20T20:05:25.223Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Asking for Help](#asking-for-help)
- [Logging and Log Files](#logging-and-log-files)
  - [Standard Logs Location](#standard-logs-location)
  - [Update Logs Location](#update-logs-location)
  - [Sharing Logs](#sharing-logs)
  - [Trace/Debug Logs](#tracedebug-logs)
  - [Clearing Logs](#clearing-logs)
- [Multiple Log Files](#multiple-log-files)
- [Recovering from a Failed Update](#recovering-from-a-failed-update)
  - [Determine the issue](#determine-the-issue)
    - [Migration Issue](#migration-issue)
    - [Permission Issue](#permission-issue)
  - [Resolving the issue](#resolving-the-issue)
    - [Permissions Issues](#permissions-issues)
    - [Manually upgrading](#manually-upgrading)
- [NGINX errors](#nginx-errors)
- [Indexer, Application, and Download Client Issues](#indexer-application-and-download-client-issues)
  - [Connection Timed Out](#connection-timed-out)
  - [Sonarr HTTP 404 Errors](#sonarr-http-404-errors)
  - [\*Arr HTTP 400 Errors](#arr-http-400-errors)
  - [503 HTTP Service Unavailable](#503-http-service-unavailable)
  - [Invalid Torrents](#invalid-torrents)

# Asking for Help

Do you need help? That's okay, everyone needs help sometimes. You can get real time help via chat on

- [<i class="fab fa-discord"></i>&emsp;Discord *Official Prowlarr Discord*](https://prowlarr.com/discord)
- [<i class="fab fa-reddit"></i>&emsp;Reddit *Official Prowlarr Subreddit*](https://reddit.com/r/prowlarr)
{.links-list}

But before you go there and post, be sure your request for help is the best it can be. Clearly describe the problem and briefly describe your setup, including things like your OS/distribution, version of .NET, version of Prowlarr, download client and its version. **If you are using [Docker](https://www.docker.com/) please run through [Docker Guide](/docker-guide) first as that will solve common and frequent path/permissions issues. Otherwise please have a [docker compose](/docker-guide#docker-compose) handy. [How to Generate a Docker Compose](https://trash-guides.info/compose)** Tell us about what you've tried already, what you've looked at. Use the [Logging and Log Files section](#logging-and-log-files) to turn your logging up to trace, recreate the issue, pastebin the relevant context and include a link to it in your post. Maybe even include some screen shots to highlight the issue.

The more we know, the easier it is to help you.

# Logging and Log Files

If you're linked here for support remember to get them the information from the actual trace log file, put the logs in a pastebin and show us context around what we need to see. If you're asked for debug logs your logs will contain `debug` and if you're asked for trace logs your logs will contain `trace`. If the logs you are providing do not contain either then they are not the logs requested.

> \* **Do not simply provide the whole log file unless explicitly asked.**
> \* **Do not upload the logs directly to discord as a file nor paste them as a wall of text unless explicitly asked.**
{.is-info}

To provide good and useful logs for sharing:

> If asked to provide the indexer response for development or debugging continue reading this blue section...otherwise continue to the steps below. For debugging indexer responses, it is likely helpful to go to `settings/development` (hidden page) in Prowlarr and temporarily enable Enhanced Indexer Logging to log the Indexer's Response.  It should not be kept on all the time
{.is-info}

> Ensure a spammy task is NOT running such as an RSS refresh.**
{.is-warning}

1. [Turn Logging up to Trace (Settings => General => Log Level or Edit The Config File)](#tracedebug-logs)
2. [Clear Logs (System => Logs => Clear Logs or Delete all the Logs in the Log Folder)](#clearing-logs)
3. Reproduce the Issue (Redo what is breaking things)
4. [Open the trace log file (prowlarr.trace.txt) via the UI or the log file](#standard-logs-location) on the filesystem and find the relevant context
5. Copy a big chunk before the issue, the issue itself, and a big chunk after the issue.
6. Use [Gist](https://gist.github.com/), [0bin (**Be sure to disable colorization**)](https://0bin.net/), [PrivateBin](https://privatebin.net/), [Notifiarr PrivateBin](http://logs.notifiarr.com/), [Hastebin](https://hastebin.com/), [Ubuntu's Pastebin](https://pastebin.ubuntu.com/), or similar sites to share the copied logs from above

> \* Do not use [pastebin.com](https://pastebin.com) as their filters have a tendency to block the logs.
> \* Do not use [pastebin.pl](https://pastebin.pl) as their site is frequently not accessible.
> \* Do not use [JustPasteIt](https://justpaste.it/) as their site does not facilitate reviewing logs.
> \* Do not upload your logs and share via Google Drive, Dropbox, or any other site not noted above.
{.is-danger}

> When using [0bin](https://0bin.net/) be sure to disable colorize and do not burn after reading.
{.is-warning}

- Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use N++. You can use the Notepad++ "Find in Files" function to search old log files as needed.
- **Unix Only:** Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use grep. For example if you want to find information about the movie/show/book/song/indexer "Shooter" you can run the following command `grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt` If your [Appdata Directory](/prowlarr/appdata-directory) is in your home folder then you'd run: `grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`

```none

    * The flags have the following functions
    * -i: ignore case
    * -n: show line number
    *  -r: recursively check all files in the path
    * -C: provide # of lines before and after the line it is found on
    * -e: the pattern to search for

```

## Standard Logs Location

The log files are located in Prowlarr's [Appdata Directory](/prowlarr/appdata-directory), inside the logs/ folder. You can also access the log files from the UI at System => Logs => Files.

> Note: The Logs ("Events") Table in the UI is not the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.
{.is-info}

## Update Logs Location

The update log files are located in Prowlarr's [Appdata Directory](/prowlarr/appdata-directory), inside the UpdateLogs/ folder.

## Sharing Logs

The logs can be long and hard to read as part of a forum or Reddit post and they're spammy in Discord, so please use [Pastebin](https://pastebin.ubuntu.com/), [Hastebin](https://hastebin.com/), [Gist](https://gist.github.com), [0bin](https://0bin.net), or any other similar pastebin site. The whole file typically isn't needed, just a good amount of context from before and after the issue/error. Do not forget to wait for spammy tasks like an RSS sync or library refresh to finish.

## Trace/Debug Logs

You can change the log level at Settings => General => Logging. Prowlarr does not need to restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are named `prowlarr.debug.txt` and `prowlarr.trace.txt` respectively.

If you're unable to access the UI to set the logging level you can do so by editing config.xml in the AppData directory by setting the LogLevel value to Debug or Trace instead of Info.

```xml
 <Config>
  [...]
  <LogLevel>debug</LogLevel>
  [...]
 </Config>
```

## Clearing Logs

You can clear log files and the logs database directly from the UI, under `System` => `Logs` => `Files` and `System` => `Logs` => `Delete` (Trash Can Icon).

# Multiple Log Files

Prowlarr uses rolling log files limited to 1MB each. The current log file is always Prowlarr.txt, for the the other files Prowlarr.0.txt is the next newest (the higher the number the older it is). This log file contains `fatal`, `error`, `warn`, and `info` entries.

When Debug log level is enabled, additional `prowlarr.debug.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a 40h period.

When Trace log level is enabled, additional `prowlarr.trace.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most, and sometimes less than a minute if you're doing something intensive.

# Recovering from a Failed Update

We do everything we can to prevent issues when upgrading, but if they do occur this will walk you through the steps to take to recover your installation.

## Determine the issue

- The best place to look when the application will not start after an update is to review the [update logs](#update-logs-location) and see if the update completed successfully. If those do not have an issue then the next step is to look at your regular application log files, before trying to start again, use [Logging](/prowlarr/settings#logging) and [Log Files](/prowlarr/system#log-files) to find them and increase the log level.
- The most frequently seen issue is that the system the app is installed on messed with the `/tmp` directory and deleted critical \*Arr files during the upgrade thus causing both the upgrade and rollback to fail. In this case, simply reinstall in-place over the existing borked installation.

### Migration Issue

- Migration errors will not be identical, but here is an example:

```none
14-2-4 18:56:49.5|Info|MigrationLogger|\*\*\* 36: update\_with\_quality\_converters migrating \*\*\*

14-2-4 18:56:49.6|Error|MigrationLogger|SQL logic error or missing database duplicate column name: Items

While Processing: "ALTER TABLE "QualityProfiles" ADD COLUMN "Items" TEXT"

```

### Permission Issue

- Permissions issues are due to the application being unable to access the the relevant temporary folders and/or the app binary folder. Fix the permissions so the user/group the application runs as has the appropriate access.

- Synology users may encounter this Synology bug `Access to the path '/proc/{some number}/maps is denied`

- Synology users may also encounter being out of space in `/tmp` on certain NASes. You'll need to specify a different `/tmp` path for the app. See the SynoCommunity or other Synology support channels for help with this.

## Resolving the issue

In the event of a migration issue there is not much you can do immediately, if the issue is specific to you (or there are not yet any posts), please create a post on [our subreddit](https://reddit.com/r/prowlarr) or swing by our [discord](https://prowlarr.com/discord). If there are others with the same issue, then rest assured we are working on it.

> Please ensure you did not try to use a database from `nightly` on the stable version. Branch hopping is ill-advised.{.is-info}

### Permissions Issues

- Fix the permissions to ensure the user/group the application is running as can access (read and write) to both `/tmp` and the installation directory of the application.

- For Synology users experiencing issues with `/proc/###/maps` stopping Sonarr or the other \*Arr applications and updating should resolve this. This is an issue with the SynoCommunity package.

### Manually upgrading

Grab the latest release from our website.

Install the update (.exe) or extract (.zip) the contents over your existing installation and re-run Prowlarr as you normally would.

# NGINX errors

In your Prowlarr setup, you will need this line:

`proxy_set_header Host $host;`

If you have any different `proxy_set_header` you must replace it with the line above.

# Indexer, Application, and Download Client Issues

- At a basic level Prowlarr needs to be able to talk to your indexers.
- If you use application sync, Prowlarr also needs to be able to talk to your applications and the applications need to be able to talk to Prowlarr.
- If you have a download client in Prowlarr for manual in-Prowlarr downloads, Prowlarr will need to be able to talk with your download client.

> Note that logs indicating querying indexer ID 0: The 0 ID is a generic test endpoint that allows us to test if \*Arr can call back and connect to Prowlarr without actually relying on an indexer working.
{.is-info}

Below are some common causes

## Connection Timed Out

`The request timed out`

Prowlarr is getting no response from the client. [See our General Network & Permissions Troubleshooting guide](/permissions-and-networking)

This is typically caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy

## Sonarr HTTP 404 Errors

- This is typically due to running an end of life (EOL) version of Sonarr which does not have the v3 API endpoints
- Prowlarr does not support Sonarr v2
- Prowlarr only supports Sonarr v3

## \*Arr HTTP 400 Errors

- See this FAQ Entry: [Prowlarr will not sync X Indexer to App](/prowlarr/faq#prowlarr-will-not-sync-x-indexer-to-app)

## 503 HTTP Service Unavailable

- This is typically due to your tracker blocking you via Cloudflare and requiring [FlareSolverr](https://github.com/FlareSolverr/FlareSolverr)

## Invalid Torrents

- Try downloading the link via the URL and variables Prowlarr used
- Try downloading the torrent proxied via prowlarr (i.e. use the prowlarr link the app that grabbed the file use)
- Ensure that your cookie or other credentials for your indexer are not expired and are valid
- If the issue is Prowlarr caused then please file a bug report.
