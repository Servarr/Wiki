---
title: Lidarr Troubleshooting
description: Common issues, error codes, and solutions for troubleshooting Lidarr installation, configuration, and operational problems
published: true
date: 2026-05-29T12:34:28.538Z
tags: lidarr, troubleshooting, support, issues, debugging, errors
editor: markdown
dateCreated: 2021-06-14T21:36:46.193Z
---

# Asking for Help

Need help? That's okay. Everyone needs help sometimes. You can get real-time help via chat on Discord.

- [<i class="fab fa-discord"></i>&emsp;Discord *Official Lidarr Discord*](https://lidarr.audio/discord)
{.links-list}

Before posting, make sure your request is clear. Describe the problem and your setup, including your OS/distribution, .NET version, Lidarr version, and download client and its version. **If you are using [Docker](https://www.docker.com/) please run through [Docker Guide](/docker-guide) first as that will solve common and frequent path/permissions issues. Otherwise please have a [docker compose](/docker-guide#docker-compose) handy. [How to Generate a Docker Compose](https://trash-guides.info/compose)** Describe what you've tried and what you've looked at. Use the [Logging and Log Files section](#logging-and-log-files) to turn your logging up to trace, recreate the issue, pastebin the relevant context and include a link to it in your post. Include screenshots if they help highlight the issue.

The more context you provide, the easier it's to help you.

> Lidarr only supports builds created by the Servarr build platform.
{.is-info}

# Logging and Log Files

It's likely beneficial to also review the Common Troubleshooting problems:

- [Downloads and Importing Common Problems](#common-problems)
- [Searching Indexers and Trackers Common Problems](#common-problems-1)
{.links-list}

If you're asked for debug logs your logs will contain `debug` and if you're asked for trace logs your logs will contain `trace`. If the logs you are providing don't contain either then they aren't the logs requested.

- Avoid sharing the entire log file unless asked.
- Don't upload logs directly to Discord or paste them as walls of text, unless requested.
- Don't share the logs as an attachment, a zip archive, or anything other than text shared via the services noted below

To provide good and useful logs for sharing:

> Ensure a spammy task isn't running, such as an RSS refresh
{.is-warning}

1. [Turn Logging up to Trace (Settings => General => Log Level or Edit The Config File)](#tracedebug-logs)
2. [Clear Logs (System => Logs => Clear Logs or Delete all the Logs in the Log Folder)](#clearing-logs)
3. Reproduce the Issue (Redo what's breaking things)
4. [Open the trace log file (Lidarr.trace.txt) via the UI or the log file](#standard-logs-location) on the filesystem and find the relevant context
5. Copy a big chunk before the issue, the issue itself, and a big chunk after the issue.
6. Use [Gist](https://gist.github.com/), [0bin (**Be sure to disable colorization**)](https://0bin.net/), [PrivateBin](https://privatebin.net/), [Notifiarr PrivateBin](http://logs.notifiarr.com/), [Hastebin](https://hastebin.com/), [Ubuntu's Pastebin](https://pastebin.ubuntu.com/), or similar sites - excluding those noted to avoid below - to share the copied logs from above

**Warnings:**

- **Don't use [pastebin.com](https://pastebin.com) as their filters often block logs.
- Don't use [pastebin.pl](https://pastebin.pl) as their site is frequently inaccessible.
- Don't use [JustPasteIt](https://justpaste.it/) as their site doesn't support reviewing logs.
- Don't upload your log as a file
- Don't upload and share your logs via Google Drive, Dropbox, or any other site not noted above.
- Don't archive (zip, tar (tarball), 7zip, etc.) your logs.
- Don't share console output, docker container output, or anything other than the application logs specified

**Important Note:**

- When using [0bin](https://0bin.net/), be sure to disable colorization and don't burn after reading.

- To search across old log files in Windows, use the Notepad++ **Find in Files** function.
- **Unix only:** To search across old log files, use `grep`. For example, to find entries for an artist or release named "Shooter": `grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt`. If your [Appdata Directory](/lidarr/appdata-directory) is in your home folder: `grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`

```none

    * The flags have the following functions
    * -i: ignore case
    * -n: show line number
    *  -r: recursively check all files in the path
    * -C: provide # of lines before and after the line it's found on
    * -e: the pattern to search for

```

## Standard Logs Location

Lidarr stores log files in the [Appdata Directory](/lidarr/appdata-directory), inside the logs/ folder. You can also access the log files from the UI at System => Logs => Files.

> Note: The Logs ("Events") Table in the UI isn't the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.
{.is-info}

## Update Logs Location

Lidarr stores update log files in the [Appdata Directory](/lidarr/appdata-directory), inside the UpdateLogs/ folder.

## Sharing Logs

Logs are long and hard to read in forum posts, and too verbose to paste into Discord. Use [Pastebin](https://pastebin.ubuntu.com/), [Hastebin](https://hastebin.com/), [Gist](https://gist.github.com), [0bin](https://0bin.net), or a similar paste site. The full file isn't needed. Share context from before and after the issue. Wait for spammy tasks like an RSS sync or library refresh to finish before capturing logs.

## Trace/Debug Logs

You can change the log level at Settings => General => Logging. Lidarr doesn't need to be restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are `lidarr.debug.txt` and `lidarr.trace.txt` respectively.

If you can't access the UI to set the log level, edit config.xml in the AppData directory. Set LogLevel to Debug or Trace instead of Info.

```xml
 <Config>
  [...]
  <LogLevel>debug</LogLevel>
  [...]
 </Config>
```

## Clearing Logs

You can clear log files and the logs database directly from the UI, under System => Logs => Files and System => Logs => Delete (Trash Can Icon)

# Log File Rotation

Lidarr uses rolling log files limited to 1MB each. The current log file is always `lidarr.txt`. For the other files, `.0.txt` is the next newest (higher numbers are older). This log file contains `fatal`, `error`, `warn`, and `info` entries.

With Debug log level enabled, `lidarr.debug.txt` rolling log files appear. This log file contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It covers a 40-hour window.

With Trace log level enabled, `lidarr.trace.txt` rolling log files appear. This log file contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.

# Recovering from a Failed Update

If an upgrade goes wrong, these steps will help you recover your installation.

## Determine the issue

- The best place to look when the application won't start after an update is to review the [update logs](#update-logs-location) and see if the update completed successfully. If those don't have an issue then the next step is to look at your regular application log files, before trying to start again, use [Logging](/lidarr/settings#logging) and [Log Files](/lidarr/system#log-files) to find them and increase the log level.
- Most often, the host system messes with the `/tmp` directory and deletes critical Lidarr files during the upgrade, causing both the upgrade and rollback to fail. In this case, reinstall in-place over the existing installation.

### Migration Issue

- Migration errors won't be identical, but here is an example:

```none
14-2-4 18:56:49.5|Info|MigrationLogger|\*\*\* 36: update\_with\_quality\_converters migrating \*\*\*

14-2-4 18:56:49.6|Error|MigrationLogger|SQL logic error or missing database duplicate column name: Items

While Processing: "ALTER TABLE "QualityProfiles" ADD COLUMN "Items" TEXT"

```

### Permission Issue

- Permissions issues are due to the application being unable to access the relevant temporary folders and/or the app binary folder. Fix the permissions so the user/group the application runs as has the appropriate access.

- Synology users may encounter this Synology bug `Access to the path '/proc/{some number}/maps is denied`

- Synology users may also encounter being out of space in `/tmp` on certain NASes. You'll need to specify a different `/tmp` path for the app. See the SynoCommunity or other Synology support channels for help with this.

## Resolving the issue

Post to [r/lidarr](https://reddit.com/r/lidarr) or ask in [Discord](https://lidarr.audio/discord). If others have the same issue, someone has likely filed it already.

> Don't use a database from `nightly` on the stable version. Branch hopping is ill-advised.
{.is-info}

### Permissions Issues

- Fix the permissions to ensure the user/group the application is running as can access (read and write) to both `/tmp` and the installation directory of the application.

- For Synology users experiencing issues with `/proc/###/maps`, updating Lidarr should resolve this. This is an issue with the SynoCommunity package.

### Manually upgrading

Grab the latest release from the [Lidarr website](https://lidarr.audio).

Install the update (.exe) or unpack (.zip) the contents over your existing installation and re-run Lidarr as you normally would.

# Downloads and Importing

Downloading and importing is where *most* people experience issues. From a high level perspective, Lidarr needs to be able to communicate with your download client and have access to the files it downloads. There's a large variety of supported download clients and an even *bigger* variety of setups. This means that while there are some *common* setups, there isn’t one *right* setup and everyone’s setup can be a little different.

> **The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that window to examine it.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net), [Gist](https://gist.com), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.
{.is-danger}

When you reach out for help, be sure to read [asking for help](#asking-for-help) so you can provide the details needed.

## Testing the Download Client

Ensure your download clients are running. Start by testing the download client, if it doesn’t work you’ll be able to see details in the trace level logs. You should find a URL you can put into your browser and see if it works. It could be a connection problem: wrong IP, hostname, or port, or a firewall blocking access. It might be obvious, like an authentication problem where you’ve gotten the username, password or apikey wrong.

## Testing a Download

Next, try a download. Pick a song and do a manual search. Pick one of those files and attempt to download it. Does it get sent to the download client? Does it end up with the correct category? Does it show up in Activity? Does it end up in the trace level logs during the **Check For Finished Download** tasks (Refresh Monitored Downloads and Process Monitored Downloads tasks) which runs every minute? Does it get correctly parsed during that task? Does the queued up download have a reasonable name? Since searches by are by id on some indexers/trackers, it can queue one up with a name that it can’t recognize.

## Testing an Import

Import issues should almost always manifest as an item in Activity with an orange icon you can hover to see the error. If they’re not showing up in Activity, this is the issue you need to focus on first so go back and figure that out. Most import errors are *permissions* issues. Lidarr needs read and write access to the download folder. Sometimes, permissions in the library folder can be at fault too, so be sure to check both.

Incorrect path issues are possible too, though less common in normal setups. The key to understanding path issues is knowing that Lidarr gets the path to the download *from* the download client, via its API. This becomes a problem in more unique use cases, like the download client running on a different system (maybe even OS\!). It can also occur in a Docker setup when volumes aren't configured correctly. A remote path map is a good solution where you don’t have control, like a seedbox setup. On a Docker setup, fixing the paths is a better option.

## Common Problems

Below are some common problems.

### Download Client's WebUI isn't enabled

Lidarr communicates with your download client via its API through the client's web UI. Enable the client's web UI and make sure its port doesn't conflict with other active ports on your system.

### SSL in use and incorrectly configured

Ensure SSL encryption isn't turned on if you're using both your instance and your download client on a local network. See [the SSL FAQ entry](/lidarr/faq#invalid-certificate-and-other-HTTPS-or-SSL-issues) for more information.

### Can’t see share on Windows

The default user for a Windows service is `LocalService` which typically doesn’t have access to your shares. Edit the service and set it up to run as your own user, see the FAQ entry [why can’t see my files on a remote server](/lidarr/faq#why-cant-see-my-files-on-a-remote-server) for details.

### Mapped network drives aren't reliable

While mapped network drives like `X:\` are convenient, they aren’t as reliable as UNC paths like `\\server\share` and they’re also not available before login. Set up Lidarr and your download clients to use UNC paths as needed. If your library is on a share, you’d make sure your root folders are using UNC paths. If your download client sends to a share, that's where you’ll need to configure UNC paths since Lidarr gets the download path from the download client. It's fine to keep your mapped network drives to use yourself, just don’t use them for automation.

### Docker and user, group, ownership, permissions and paths

Docker adds another layer of complexity that’s easy to get wrong and still end up with a setup that appears to work but has hidden problems. Rather than covering them here, read [the Docker Guide](/docker-guide), which covers user, group, ownership, permissions, and paths in depth. It isn’t specific to any Docker system. It covers things at a high level so you can apply them in your own environment.

### Remote Path Mapping

If Lidarr runs in Docker while your download client doesn't (or vice versa), or they run on different servers, you may need a remote path map.

Logs will look like

```none
2022-02-03 14:03:54.3|Error|DownloadedTracksImportService|Import failed, path doesn't exist or isn't accessible by Lidarr: /volume3/data/torrents/music/Five Finger Death Punch - F8 (2020) FLAC. Ensure the path exists and the user running Lidarr has the correct permissions to access this file/folder
```

Thus `/volume3/data` doesn't exist within Lidarr's container or isn't accessible.

- [Settings => Download Clients => Remote Path Mappings](/lidarr/settings#remote-path-mappings)
- Use a remote path mapping when your download client reports a path for completed data on another server or in a way that \Lidarr can't resolve.
- You only need a remote path map if your download client is on Linux when Lidarr is on Windows or vice versa. A remote path map may also be necessary when mixing Docker and native clients or using a remote server.
- A remote path map does a simple search and replace: it finds the remote path value and substitutes the local path value for the specified host.
- If the error message about a bad path doesn't contain the REPLACED value, then the path mapping isn't working as you expect. The typical solution is to add and remove the mapping.
- [See TRaSH's Tutorial for more information on remote path mapping](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/)

> If both Lidarr and your download client are Docker containers, you seldom need a remote path map. Review the [Docker Guide](/docker-guide) and/or [follow TRaSH's Tutorial](https://trash-guides.info/hardlinks)
{.is-info}

#### Remote Mount or Remote Sync (Syncthing)

- You need it to be syncing the whole time it's downloading. And you need that local sync destination to be able to be hard links when \Lidarr imports, which means same filesystem and look like it.
  - Sync at a lower, common folder that contains both incomplete and complete.
  - Sync to a location that's on the same file system locally as your library and looks like it (docker and network shares make this easy to misconfigure)
  - You want to sync the incomplete and complete so that when the torrent client does the move, that's reflected locally and all the files are already "there" (even if they're still downloading). Then you want to use hard links because even if it imports before its done, they'll still finish.
  - This way the whole time it downloads, it's syncing, then torrent client moves to tv sub-folder and sync reflects that. That way downloads are in place when declared finished. And even if they're not totally done, having the hard link possible means that's still okay.
  - (Optional - if applicable and/or required (for example, remote usenet client)) Configure a custom script to run on import/download/upgrade to remove the remote file
- A remote mount is simpler to configure than a sync setup, though it tends to be slower.
  - Mount your remote storage with sshfs or another network file system protocol
  - Ensure the user and group that Lidarr runs as has read or write access.
  - Configure a remote path map to find the remote path and replace it with the local path

### Permissions on the Library Folder

Logs will look like

```none
2022-02-28 18:51:01.1|Error|DownloadedTracksImportService|Import failed, path doesn't exist or isn't accessible by Lidarr: /data/media/music/Jasmine Guillory/Party of Two - Jasmine Guillory.mp3. Ensure the path exists and the user running Lidarr has the correct permissions to access this file/folder
```

Don’t forget to check permissions and ownership of the *destination*. It's easy to get fixated on the download’s ownership and permissions and that's often the cause of permissions issues, but the destination can also be at fault. Check that the destination folders exist. Check that no destination *file* already exists, or that you can delete or move any existing file to the recycle bin. Check that ownership and permissions allow you to copy, hard link, or move the downloaded file. The user or group that runs as needs to be able to read and write the root folder.

- For Windows Users this may be due to running as a service:
  - the Windows Service runs under the 'Local Service' account, by default this account doesn't have permissions to access your user's home directory unless you assign permissions manually. This is particularly relevant when using download clients configured to download to your home directory.
  - 'Local Service' also has limited permissions. Install the app as a system tray application to install the app as a system tray application if the user can remain logged in. The installer provides this option. See the FAQ for how to convert from a service to tray app.

- For Synology Users refer to [SynoCommunity's Permissions Article for their Packages](https://github.com/SynoCommunity/spksrc/wiki/Permission-Management)

- Non-Windows: If you're using an NFS mount, enable `nolock`.
- If you're using an SMB mount, enable `nobrl`.

### Permissions on the Downloads Folder

Logs will look like

```none
2022-02-28 18:51:01.1|Error|DownloadedTracksImportService|Import failed, path doesn't exist or isn't accessible by Lidarr: /data/downloads/music/Party of Two - Jasmine Guillory.mp3. Ensure the path exists and the user running Lidarr has the correct permissions to access this file/folder
```

Don’t forget to check permissions and ownership of the *source*. It's easy to get fixated on the destination's ownership and permissions and that's a *possible* cause of permissions related issues, but it *typically* is the source. Check that the source folders exist - and if docker that the mounts are aligned and consistent. Check that ownership and permissions allow you to copy, hard-link, or move the downloaded file. The user or group that runs as needs to be able to read and write the downloads folder.

- For Windows Users this may be due to running as a service:
  - the Windows Service runs under the 'Local Service' account, by default this account doesn't have permissions to access your user's home directory unless you assign permissions manually. This is particularly relevant when using download clients configured to download to your home directory.
  - 'Local Service' also has limited permissions. Install the app as a system tray application to install the app as a system tray application if the user can remain logged in. The installer provides this option. See the FAQ for how to convert from a service to tray app.

- For Synology Users refer to [SynoCommunity's Permissions Article for their Packages](https://github.com/SynoCommunity/spksrc/wiki/Permission-Management)

- Non-Windows: If you're using an NFS mount, enable `nolock`.
- If you're using an SMB mount, enable `nobrl`.

### Download folder and library folder not different folders

- The download client should download into a folder accessible by Lidarr and that isn't your root/library folder; should import from that separate download folder into your Library folder.
- You should never download directly into your root folder. You also shouldn't use your root folder as the download client's completed folder or incomplete folder.
- [**This will also cause a healthcheck in System as well**](/lidarr/system#downloading-into-root-folder)
- Within the application, the configured media library folder is the root folder. This isn't the root folder of a mount. Your download client has an incomplete or complete (or is moving completed downloads) into your root (library) folder. This frequently causes issues and isn't advised. To fix this change your download client so it isn't placing downloads within your root folder. Note that 'placing' also includes if your download client category points to your root folder or if NZBGet/SABnzbd have sort enabled and are sorting to your root folder. Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, shouldn't be the same folder you have configured as your root/library/final media destination folder in Lidarr.
- Find configured root folders (aka library folders) in [Settings => Media Management => Root Folders](/lidarr/settings/#root-folders)
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It's suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.

> Your download folder and your root/library folder MUST be separate
{.is-warning}

### Incorrect category

Set Lidarr to use a category so it only processes its own downloads. It's rare that a torrent Lidarr submits gets added without the correct category, but it can happen. If you’re adding torrents manually and want to process them, they’ll need to have the correct category. You can set it at any time, since Lidarr processes downloads every minute.

### Packed torrents

Logs will show errors like

```none
No files found are eligible for import
```

If your torrent arrives in `.rar` files, you’ll need to set up extraction. [Unpackerr](https://github.com/unpackerr/unpackerr) handles unpacking correctly: it prevents corrupt partial imports and cleans up unpacked files after import.

This error also appears if there's no valid media file in the folder.

### Repeated downloads

Repeated downloads have a few causes. One relates to the Indexer restriction in Release Profiles. Because the indexer *isn’t* stored with the data, any preferred word scores are *zero* for media in your library, *but* during “RSS” and search, Lidarr applies them. This creates a loop: the item looks like an upgrade, then isn’t, then reappears and looks like an upgrade again. Don’t restrict your release profile to an indexer.

This can also happen because the download never imports and drops from the queue, so Lidarr grabs a new download that also never imports. Check the other common problems and troubleshooting steps.

### Usenet download misses import

Lidarr only looks at the 60 most recent downloads in SABnzbd and NZBGet. If you keep your history, large queues with import issues can cause Lidarr to miss downloads. The best way to avoid that's to keep your history clear, so that any items that still appear need investigating. You can achieve this by enabling Remove under Completed and Failed Download Handler. In NZBGet, this will move items to the *hidden* history which is great. SABnzbd doesn't have a similar feature. The best you can achieve there's to use the nzb backup folder.

### Download client clearing items

The download client shouldn’t be responsible for removing downloads. Configure usenet clients so they *don’t* remove downloads from history. Set up torrent clients so they *don’t* remove torrents when they’re finished seeding (pause or stop instead). Lidarr communicates with the download client to know what to import. If items are *removed*, Lidarr has nothing to import, even if a folder full of files exists.

For SABnzbd, use the History Retention setting.

### Download doesn't match a library item

Lidarr can't parse some releases once grabbed and sent to the download client. Activity => Options => Show Unknown (this is now enabled by default in recent builds) will display all items not otherwise ignored / already imported within Lidarr's download client category. These need manual mapping and import.

This can also occur if you have a release in your download client but that media item (album/artist) doesn't exist in Lidarr. See [Import Troubleshooting](/lidarr/import-troubleshooting) for match and import issues.

### The underlying connection was closed: An unexpected error occurred on a send

The indexer uses a TLS/SSL protocol that the current .NET Version doesn't support. Check [Lidarr => System => Status](/lidarr/system#status) for the installed version.

### The request timed out

Lidarr is getting no response from the client.

```none
    System.NET.WebException: The request timed out: ’https://example.org/api?t=caps&apikey=(removed) —> System.NET.WebException: The request timed out
```

```none
2022-11-01 10:16:54.3|Warn|Newznab|Unable to connect to indexer

[v4.3.0.6671] System.Threading.Tasks.TaskCanceledException: A task was canceled.
```

Other causes include:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues - Try changing to a different DNS provider
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy and it being improperly configured

## Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in the guide](/permissions-and-networking). Otherwise please discuss with the support team on [Discord](https://lidarr.audio/discord). If this is something that may be a common problem, please suggest adding it to the wiki.

# UI and Filesystem Issues

Problems that don't fall under downloads/imports or indexer searches: library and filesystem edge cases, plus browser-side UI quirks.

## Weird UI issues

If the Library page doesn't render, looks stale, or a view or sort seems broken after an upgrade, test in a **Chrome Incognito** or **Firefox Private Browsing** window. If the UI works cleanly there, cached assets or cookies for your Lidarr URL in your main browser profile are the cause.

Fix by clearing browser cache, cookies, and local storage scoped to the Lidarr origin. The dev-tools *Application* tab in Chromium-based browsers lets you do this targeted at a single origin without signing you out of everything else. See [Clear Cache, Cookies, and Local Storage](/useful-tools#clearing-cookies-and-local-storage) for the full walkthrough.

> Older cached JavaScript is the most common cause of "new UI features aren't showing up after I updated Lidarr." Hard-refresh (Ctrl+Shift+R / Cmd+Shift+R) is faster than a full cache purge.
{.is-info}

## Windows folder access after Lidarr rename

Lidarr supports limiting the length of `{Tag Length}` or similar truncation-sensitive tokens in the naming format. When a truncated name ends with a space or period, Lidarr writes the folder. The [Windows naming rules](https://learn.microsoft.com/windows/win32/fileio/naming-a-file#naming-conventions) leave the resulting folder in a state the Windows shell refuses to traverse:

> Don't end a file or directory name with a space or a period. Although the underlying file system may support such names, the Windows shell and user interface doesn't.

The folder exists on NTFS, but Explorer, `dir`, and most Windows applications will report it as inaccessible or not found.

**Recovery (WSL):**

```console
mv <foldername...> <foldername>
```

(Replace `<foldername...>` with the actual name including its trailing dots/spaces. Tab-completion inside WSL works even when the Windows shell can't see the folder.)

**Prevention:** adjust the naming format to avoid truncation that could land on a trailing space or period. A common pattern is to trim whitespace from the end of the truncated segment in the naming template.

# Searches Indexers and Trackers

- If you use [Prowlarr](/prowlarr), then you can view the [History](/prowlarr/history) of all queries Prowlarr received and how Prowlarr sent them to the sites. Enable `Parameters` in Prowlarr History => Options. The (i) icon provides more details.

## Turn logging up to trace

> Turn logging up to Trace before diagnosing search issues. See [Logging and Log Files](#logging-and-log-files) for details on adjusting the log level and sharing logs.
{.is-danger}

## Testing an Indexer or Tracker

When you test an indexer or tracker, in debug or trace logs you can find the URL used. An example of a successful test is below, you can see it query the indexer via a specific URL with specific parameters and then the response. You test this url in your browser like replacing the `apikey=(removed)` with the correct apikey like `apikey=123`. You can experiment with the parameters if you’re getting an error from the indexer or see if you have connectivity issues if it doesn’t even work. After you’ve tested in your own browser, you should test from the system is running on *if* you haven’t already.

## Testing a Search

Just like the indexer/tracker test above, when you trigger a search while at Debug or Trace level logging, you can get the URL used from the log files. While testing, it's best to use as narrow a search as possible. A manual search is good because it's specific and you can see the results in the UI while examining the logs.

In this test, look for obvious errors and run some simple checks. The trace log shows the URL Lidarr used for the query. For a music search, Lidarr uses `t=music` with category codes in the 3000 range and artist/album parameters. Copy that URL from the trace log, replace the key placeholder with your actual API key, and paste it into a browser. If the browser returns results, connectivity is fine. Look at the categories and parameters to see whether the results match what you expect. If the browser returns an error, that's where to start.

![searches-indexers-and-trackers1.png](/assets/lidarr/searches-indexers-and-trackers1.png)
![searches-indexers-and-trackers2.png](/assets/lidarr/searches-indexers-and-trackers2.png)

## Common Problems

Below are some common problems.

### Unable to Load Search Results

Most likely you're using a reverse proxy and your reverse proxy timeout is too short for Lidarr to complete the search query. Increase the timeout and try again.

### Media is Unmonitored

The songs aren't monitored.

### Tracker needs RawSearch Caps

- Lidarr is searching for `Kikis Delivery Service` but your tracker only has results for `Kiki's Delivery Service`
- This is due to your tracker not supporting normal standardized searches.
- The solution is that your tracker's definition's search capabilities need updating to show they require and support `RawSearch`
- Jackett supports the flag, but you need to update the capabilities per indexer. Open a feature request for Jackett to add this functionality for your indexer.
- Prowlarr supports the flag, but you need to update the capabilities per indexer. Open a feature request for Prowlarr to add this functionality for your indexer.

### Wrong categories

Incorrect categories are probably the most common cause of results showing in manual searches of an indexer/tracker, but *not* in Lidarr. The indexer/tracker *should* show the category in the search results, which should help you figure out what's missing. If you’re using Jackett or Prowlarr, each tracker has a list of specifically supported categories. Make sure you’re using the correct ones for Categories. Many find it helpful to have the list visible in one browser window while they edit the entry in.

### Wrong results

Sometimes an indexer returns unrelated results despite correct parameters. Or most results are correct but a few mismatches appear. The first type points to an indexer problem. The trace logs will show which one. Disable that indexer and report the problem. The second type covers miscategorized releases. Report those on the indexer/tracker.

### Query Successful - No Results returned

You receive a message like `Query successful, but no results were returned from your indexer. This may be an issue with the indexer or your indexer category settings.`

Your indexer returned no results within the categories you configured.

### Missing Results

If you find results on the site that aren't showing in Lidarr, the cause is likely one of the following:

- [Categories are incorrect - See Above](#wrong-categories)
- Lidarr ran an ID-based search but the indexer hasn't mapped those releases to that ID correctly. Only your indexer can fix this -- they need to map the release to the correct IDs.
- Not searching how Lidarr searches. The terms you enter on the indexer site may differ from how Lidarr queries it. Check the Trace Logs to see Lidarr's exact query. Text-based queries use the format `q=words%20and%20things%20here`. This string is HTTP-encoded. Any HTML encoding tool online can decode it.

### Release Rejected: Album duration is 0

When Lidarr grabs a release it checks that the file size returned by the indexer is plausible for the album. That check requires knowing the total duration of the album. If MusicBrainz doesn't have track lengths for the release (shown as `???` on the MusicBrainz release page), Lidarr calculates a duration of 0 and rejects every candidate with:

```none
Release Rejected
* Album duration is 0, unable to validate size until it's available
```

You can still add the album to Lidarr and it will appear in your library, but no automatic or manual search will succeed until the duration data exists.

**Fix:** Add the missing track lengths to MusicBrainz, then let the data propagate to Lidarr.

1. Open the release on [MusicBrainz](https://musicbrainz.org) and edit the track list to add durations. If you don’t have a MusicBrainz account, [creating one](https://musicbrainz.org/register) is free.
2. Wait for the Servarr metadata server to pick up the change (up to ~1 hour), or use the `!refresh` bot command in the [Lidarr Discord](https://lidarr.audio/discord) `#lidarr-music-requests` channel to force an early refresh.
3. In Lidarr, go to the artist page and trigger **Artist → Refresh & Scan** to pull in the updated metadata.
4. Retry the search. Lidarr can now check sizes and will grab matching releases normally.

> If you can't edit MusicBrainz (for example, the release has a pending vote), the only workaround is **Manual Import**: download the files through other means and use Lidarr’s manual import flow to match and move them.
{.is-info}

### Certificate validation

You’ll be connecting to most indexers/trackers via https, so your system certificates and time settings need to be correct. That means you need to set your time zone and time *correctly*. It also means your system certificates need to be up to date.

### Hitting rate limits

If you run Lidarr through a VPN or proxy, you may be competing with many others trying to use the same indexers and trackers. Rate limiting and DDoS protection are often done by IP address, and your VPN/proxy exit point is *one* IP address. If you aren't required to use a VPN for your region, using one for Lidarr can cause more problems than it solves.

### IP Ban

Similarly to rate limits, certain indexers - such as Nyaa - may outright ban an IP address. This is typically semi-permanent and the solution is to get a new IP from your ISP or VPN provider.

### Using the Jackett /all endpoint

{#jacketts-all-endpoint}
{#jackett-all-endpoint}

The Jackett `/all` endpoint is convenient, but that's its only benefit. Everything else is potential problems, so add each tracker individually. You may also want to check out [Prowlarr](/prowlarr) as an alternative to Jackett & NZBHydra2

[The Jackett maintainers themselves recommend against /all.](https://github.com/Jackett/Jackett#aggregate-indexers)

Using the all endpoint has no advantages (besides reduced management overhead), only disadvantages:

- you lose control over indexer specific settings (categories, search modes, etc.)
- mixing search modes (IMDB, query, etc.) might cause low-quality results
- you can't use indexer-specific categories (>= 100000).
- slow indexers will slow down results
- total results cap at 1000

Adding each indexer individually lets you fine-tune categories per indexer, which matters when the wrong category causes errors on some trackers. In Lidarr, each indexer caps at 1000 results with pagination or 100 without, so the more trackers you add to Jackett, the more likely you are to clip results. Finally, if *one* of the trackers in `/all` returns an error, Lidarr disables it and you get no results.

### Using NZBHydra2 as a single entry

Using NZBHydra2 as a single indexer entry (one NZBHydra2 entry in Lidarr for many indexers) rather than one entry per indexer has the same problems as Jackett's `/all` endpoint.

### Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in the guide](/permissions-and-networking). Otherwise please discuss with the support team on [Discord](https://lidarr.audio/discord). If this is something that may be a common problem, please suggest adding it to the wiki.

## Errors

These are some common errors you may see when adding an indexer

### The underlying connection was closed: An unexpected error occurred on a send

The indexer uses a TLS/SSL protocol that the current .NET Version doesn't support. Check [Lidarr => System => Status](/lidarr/system#status) for the installed version.

### The request timed out

Lidarr is getting no response from the indexer.

```none
    System.NET.WebException: The request timed out: ’https://example.org/api?t=caps&apikey=(removed) —> System.NET.WebException: The request timed out
```

```none
2022-11-01 10:16:54.3|Warn|Newznab|Unable to connect to indexer

[v4.3.0.6671] System.Threading.Tasks.TaskCanceledException: A task was canceled.
```

Other causes include:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues - Try changing to a different DNS provider
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy and it being improperly configured

### Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in the guide](/permissions-and-networking). Otherwise please discuss with the support team on [Discord](https://lidarr.audio/discord). If this is something that may be a common problem, please suggest adding it to the wiki.
