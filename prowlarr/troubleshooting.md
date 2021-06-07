---
title: Troubleshooting
description: 
published: true
date: 2021-06-06T14:05:33.587Z
tags: 
editor: markdown
dateCreated: 2021-06-05T17:31:43.983Z
---

## Asking for Help

Do you need help? That's okay, everyone needs help sometimes. You can get real time help via chat on [Discord](https://prowlarr.com/discord) or [Reddit](https://www.reddit.com/r/prowlarr/).

But before you go there and post, be sure your request for help is the best it can be. Clearly describe the problem and briefly describe your setup, including things like your OS/distribution, version of Mono or .Net/.Netcore, version of Prowlarr, download client and its version. If you are using Docker please run through the [Docker Guide](https://wiki.servarr.com/Docker_Guide) first as that will solve common and frequent path/permissions issues. Otherwise please have a docker compose handy Tell us about what you've tried already, what you've looked at. Use the Logging and Log Files to turn your logging up to trace, recreate the issue, paste the logs into a pastebin such as [0bin](https://0bin.net/): the relevant context and include a link to it in your post. Maybe even include some screen shots to highlight the issue.

The more we know, the easier it is to help you.

## Logging and Log Files

If you're linked here for support remember to get them the information from the actual trace log file, put the logs in a pastebin and show us context around what we need to see. If you're asked for debug logs your logs will contain debug and if you're asked for trace logs your logs will contain trace. If the logs you are providing do not contain either then they are not the logs requested.

What you need to do is:

- Turn Logging up to Trace
- Clear Logs
- Reproduce the Issue
- Open the trace log file (Prowlarr.trace.txt) and fine the relevant context
- Upload the context to Hastebin, Pastebin, 0bin, or any other pastebin type site a big chunk before the issue, the issue, and a big chunk after the issue.
- Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use N++. You can use the Notepad++ "Find in Files" function to search old log files as needed.
- Unix Only: Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use grep. For example if you want to find information about the movie or show "Shooter" you can run the following command:

`grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt`

If your Appdata Directory is in your home folder then you'd run:

`grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`

The flags have the following functions:

- -i: ignore case
- -n: show line number
- -r: recursively check all files in the path
- -C: provide # of lines before and after the line it is found on
- -e: the pattern to search for

## Standard Logs Location

The log files are located in Prowlarr's Appdata Directory, inside the logs/ folder. You can also access the log files from the Prowlarr UI at `System` -> `Logs` -> `Files`.

> The Logs ("Events") Table in the UI is not the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.

## Update Logs Location

If your update fails, you'll need to review your Update Logs instead of the normal logs. The update log files are located in Prowlarr's Appdata Directory, inside the UpdateLogs/ folder.

## Sharing Logs

The logs can be long and hard to read as part of a forum or Reddit post and they're spammy in Discord, so please use 0bin, Hastebin, or any other similar pastebin site (Pastebin itself cannot usually hold the amount of trace logs we need). The whole file typically isn't needed, just a good amount of context from before and after the issue/error. Don't forget to wait for spammy tasks like the RSS sync or library refresh to finish.

## Trace/Debug Logs

You can change the log level at `Settings` -> `General` -> `Logging`. Prowlarr does not need to restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are named Prowlarr.debug.txt and Prowlarr.trace.txt respectively.

> Debug logs contain normal log items, and trace logs contain debug log items, so if you're logging at a trace level, you only need to provide trace logs.

If you're unable to access the Prowlarr UI to set the logging level you can do so by editing `config.xml` in the AppData directory by setting the LogLevel value to `Debug` or `Trace` instead of `Info`.

 `<Config>`
  `...`
  `<LogLevel>debug</LogLevel>`
  `...`
 `</Config>`

## Clearing Logs

You can clear log files and the logs database directly from the UI, under `System` -> `Logs` -> `Files` and `System` -> `Logs` -> `Delete` (Trash Can Icon).

## Multiple Log Files

Prowlarr uses rolling log files limited to 1MB each. The current log file is always Prowlarr.txt, for the the other files Prowlarr.0.txt is the next newest (the higher the number the older it is). This log file contains fatal, error, warn, and info entries.

When Debug log level is enabled, additional Prowlarr.debug.txt rolling log files will be present. This log files contains fatal, error, warn, info, and debug entries. It usually covers a 40h period.

When Trace log level is enabled, additional Prowlarr.trace.txt rolling log files will be present. This log files contains fatal, error, warn, info, debug, and trace entries. Due to trace verbosity it only covers a couple of hours at most, and sometimes less than a minute if you're doing something intensive.

## Recovering from a Failed Update

### Purpose

We do everything we can to prevent issues when upgrading, but they occur, this will walk you through the steps of recovering your installation.

### Determine the issue

The best place to look when Prowlarr won't start after an update is your log files, before trying to start Prowlarr again, use Logging and Log Files to find them and increase the log level.

### Migration Issue

Migration errors won't be identical, but here is an example:

`14-2-4 18:56:49.5|Info|MigrationLogger|*** 36: update_with_quality_converters migrating ***`
`14-2-4 18:56:49.6|Error|MigrationLogger|SQL logic error or missing database duplicate column name: Items`
`While Processing: "ALTER TABLE "QualityProfiles" ADD COLUMN "Items" TEXT"`

### Resolving the issue

In the event of a migration issue there is not much you can do immediately, if the issue is specific to you (or there are not yet any posts), please create a post on our subreddit or swing by our discord. If there are others with the same issue, then rest assured we are working on it.

## Manually upgrading

Grab the latest release from our website.

Install the update (.exe) or extract (.zip) the contents over your existing installation and re-run Prowlarr as you normally would.

## NGINX errors

In your Prowlarr setup, you will need this line:

`proxy_set_header Host $host;`

If you have any different `proxy_set_header` you must replace it with the line above.
