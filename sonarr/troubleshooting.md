---
title: Sonarr Troubleshooting
description: 
published: true
date: 2022-01-27T04:31:55.724Z
tags: sonarr, troubleshooting
editor: markdown
dateCreated: 2021-06-20T19:13:01.108Z
---

# Asking for Help

Do you need help? That's okay, everyone needs help sometimes. You can get real time help via chat on

- [<i class="fab fa-discord"></i>&emsp;Discord *Official Sonarr Discord*](https://discord.gg/73QUuf3bgA)
- [<i class="fab fa-reddit"></i>&emsp;Reddit *Official Sonarr Subreddit*](https://reddit.com/r/sonarr)
{.links-list}

But before you go there and post, be sure your request for help is the best it can be. Clearly describe the problem and briefly describe your setup, including things like your OS/distribution, version of .net/Mono, version of Sonarr, download client and its version. **If you are using [Docker](https://www.docker.com/) please run through [Docker Guide](/docker-guide) first as that will solve common and frequent path/permissions issues. Otherwise please have a [docker compose](/docker-guide#docker-compose) handy. [How to Generate a Docker Compose](https://trash-guides.info/compose)** Tell us about what you've tried already, what you've looked at. Use the [Logging and Log Files section](#logging-and-log-files) to turn your logging up to trace, recreate the issue, pastebin the relevant context and include a link to it in your post. Maybe even include some screen shots to highlight the issue.

The more we know, the easier it is to help you.

# Logging and Log Files

If you're linked here for support remember to get them the information from the actual trace log file, put the logs in a pastebin and show us context around what we need to see. If you're asked for debug logs your logs will contain `debug` and if you're asked for trace logs your logs will contain `trace`. If the logs you are providing do not contain either then they are not the logs requested.

>- **Do not simply provide the whole log file unless explicitly asked.**
>- **Do not upload the logs directly to discord as a file nor paste them as a wall of text unless explicitly asked.**
>- When the relevant section is ~ 15 lines, it may be acceptable to paste in discord in a code block like this:
>
>````none
>   ```
>   words here
>   ```
>````
>
>- **Do not attempt to get logs while a spammy task is running such as an RSS refresh.**
>- **Do ensure [Logging](/sonarr/settings#logging) is set to Trace (or Debug if requested).**
>- **Do not just provide the whole log file nor a combination of info, debug, and/or trace logs.**
>- **Do ensure the logs you provide capture the issue**
{.is-info}

To provide good and useful logs for sharing:

1. [Turn Logging up to Trace](#tracedebug-logs)
1. [Clear Logs](#clearing-logs)
1. Reproduce the Issue (Redo what is breaking things)
1. [Open the trace log file (sonarr.trace.txt) via the UI or the log file](#standard-logs-location) on the filesystem and find the relevant context
1. Copy a big chunk before the issue, the issue itself, and a big chunk after the issue.
1. Use [Gist](https://gist.github.com/), [Hastebin](https://hastebin.com/), [Ubuntu's Pastebin](https://pastebin.ubuntu.com/), [0bin](https://0bin.net/), [PrivateBin](https://privatebin.net/) or similar sites to share the issue from above

> Do not use [pastebin.com](https://pastebin.com) as their filters have a tendency to block the logs.
> Do not use [pastebin.pl](https://pastebin.pl) as their site is frequently not accessible.
> Do not use [JustPasteIt](https://justpaste.it/) as their site does not facilitate reviewing logs.
> Do not upload your logs and share via Google Drive, Dropbox, or any other site not noted above.
{.is-info}

> When using [0bin](https://0bin.net/) be sure to disable colorize and do not burn after reading.
{.is-warning}

- Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use N++. You can use the Notepad++ "Find in Files" function to search old log files as needed.
- **Unix Only:** Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use grep. For example if you want to find information about the movie/show/book/song/indexer "Shooter" you can run the following command `grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt` If your [Appdata Directory](/sonarr/appdata-directory) is in your home folder then you'd run: `grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`

```none

    * The flags have the following functions
    * -i: ignore case
    * -n: show line number
    *  -r: recursively check all files in the path
    * -C: provide # of lines before and after the line it is found on
    * -e: the pattern to search for

```

## Standard Logs Location

The log files are located in Sonarr's [Appdata Directory](/sonarr/appdata-directory), inside the logs/ folder. You can also access the log files from the UI at System => Logs => Files.

> Note: The Logs ("Events") Table in the UI is not the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.
{.is-info}

## Update Logs Location

The update log files are located in Sonarr's [Appdata Directory](/sonarr/appdata-directory), inside the UpdateLogs/ folder.

## Sharing Logs

The logs can be long and hard to read as part of a forum or Reddit post and they're spammy in Discord, so please use [Pastebin](https://pastebin.ubuntu.com/), [Hastebin](https://hastebin.com/), [Gist](https://gist.github.com), [0bin](https://0bin.net), or any other similar pastebin site. The whole file typically isn't needed, just a good amount of context from before and after the issue/error. Do not forget to wait for spammy tasks like an RSS sync or library refresh to finish.

## Trace/Debug Logs

You can change the log level at Settings => General => Logging. Sonarr does not need to restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are named `sonarr.debug.txt` and `sonarr.trace.txt` respectively.

If you're unable to access the UI to set the logging level you can do so by editing config.xml in the AppData directory by setting the LogLevel value to Debug or Trace instead of Info.

```xml
 <Config>
  [...]
  <LogLevel>debug</LogLevel>
  [...]
 </Config>
```

## Clearing Logs

You can clear log files and the logs database directly from the UI, under System => Logs => Files and System => Logs => Delete (Trash Can Icon)

# Multiple Log Files

 Sonarr uses rolling log files limited to 1MB each. The current log file is always ,`sonarr.txt`, for the the other files `sonarr.0.txt` is the next newest (the higher the number the older it is). This log file contains `fatal`, `error`, `warn`, and `info` entries.

When Debug log level is enabled, additional `sonarr.debug.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a 40h period.

When Trace log level is enabled, additional `sonarr.trace.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.

# Recovering from a Failed Update

We do everything we can to prevent issues when upgrading, but if they do occur this will walk you through the steps to take to recover your installation.

## Determine the issue

The best place to look when the application will not start after an update is to review the [update logs](#update-logs-location) and see if the update completed successfully. If those do not have an issue then the next step is to look at your regular application log files, before trying to start again, use [Logging](/sonarr/settings#logging) and [Log Files](/sonarr/system#log-files) to find them and increase the log level.

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

In the event of a migration issue there is not much you can do immediately, if the issue is specific to you (or there are not yet any posts), please create a post on [our subreddit](https://reddit.com/r/sonarr) or swing by our [discord](https://discord.gg/M6BvZn5), if there are others with the same issue, then rest assured we are working on it.

> Please ensure you did not try to use a database from `develop` on the stable version. Branch hopping is ill-advised.{.is-info}

### Permissions Issues

- Fix the permissions to ensure the user/group the application is running as can access (read and write) to both `/tmp` and the installation directory of the application.

- For Synology users experiencing issues with `/proc/###/maps` stopping Sonarr or the other \*Arr applications and updating should resolve this. This is an issue with the SynoCommunity package.

### Manually upgrading

Grab the latest release from our website.

Install the update (.exe) or extract (.zip) the contents over your existing installation and re-run Sonarr as you normally would.

# Downloads and Importing

Downloading and importing is where *most* people experience issues. From a high level perspective,  Sonarr needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even *bigger* variety of setups. This means that while there are some *common* setups, there isn’t one *right* setup and everyone’s setup can be a little different.

> **The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net), [Gist](https://gist.com), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.
{.is-danger}

When you reach out for help, be sure to read [asking for help](#asking-for-help) so that you can provide us with the details we’ll need.

## Testing the Download Client

Ensure your download client(s) are running. Start by testing the download client, if it doesn’t work you’ll be able to see details in the trace level logs. You should find a URL you can put into your browser and see if it works. It could be a connection problem, which could indicate a wrong ip, hostname, port or even a firewall blocking access. It might be obvious, like an authentication problem where you’ve gotten the username, password or apikey wrong.

## Testing a Download

Now we’ll try a download, pick an episode for a series and do a manual search. Pick one of those files and attempt to download it. Does it get sent to the download client? Does it end up with the correct category? Does it show up in Activity? Does it end up in the trace level logs during the **Check For Finished Download** task which runs roughly every minute? Does it get correctly parsed during that task? Does the queued up download have a reasonable name? Since searches by are by id on some indexers/trackers, it can queue one up with a name that it can’t recognize.

## Testing an Import

Import issues should almost always manifest as an item in Activity with an orange icon you can hover to see the error. If they’re not showing up in Activity, this is the issue you need to focus on first so go back and figure that out. Most import errors are *permissions* issues, remember that needs to be able to read and write in the download folder. Sometimes, permissions in the library folder can be at fault too, so be sure to check both.

Incorrect path issues are possible too, though less common in normal setups. The key to understanding path issues is knowing that gets the path to the download *from* the download client, via its API. This becomes a problem in more unique use cases, like the download client running on a different system (maybe even OS\!). It can also occur in a Docker setup, when volumes are not done well. A remote path map is a good solution where you don’t have control, like a seedbox setup. On a Docker setup, fixing the paths is a better option.

## Common Problems

Below are some common problems.

### Using qBittorrent v4.4.0

Due to undocumented api changes made by qBittorrent - qBittorrent v4.4.0 is not compatible with Sonarr. Rollback to v4.3.9 or hope qBittorrent has hotfixed the issue in a future release (e.g. v4.4.1) if it exists.

### Download Client's WebUI is not enabled

Sonarr talks to you download client via it's API and accesses it via the client's webui. You must ensure the client's webui is enabled and the port it is using does not conflict with any other client ports in use or ports in use on your system.

### SSL in use and incorrectly configured

Ensure SSL encryption is not turned on if you're using both your instance and your download client on a local network. See [the SSL FAQ entry](/sonarr/faq#invalid-certificate-and-other-HTTPS-or-SSL-issues) for more information.

### Can’t see share on Windows

The default user for a Windows service is `LocalService` which typically doesn’t have access to your shares. Edit the service and set it up to run as your own user, see the FAQ entry [why can’t see my files on a remote server](/sonarr/faq#why-cant-i-see-my-files-on-a-remote-server) for details.

### Mapped network drives are not reliable

While mapped network drives like `X:\` are convenient, they aren’t as reliable as UNC paths like `\\server\share` and they’re also not available before login. Setup and your download client(s) so that they use UNC paths as needed. If your library is on a share, you’d make sure your root folders are using UNC paths. If your download client sends to a share, that is where you’ll need to configure UNC paths since gets the download path from the download client. It is fine to keep your mapped network drives to use yourself, just don’t use them for automation.

### Docker and user, group, ownership, permissions and paths

Docker adds another layer of complexity that is easy to get wrong, but still end up with a setup that functions, but has various problems. Instead of going over them here, read this wiki article [for these automation software and Docker](/docker-guide) which is all about user, group, ownership, permissions and paths. It isn’t specific to any Docker system, instead it goes over things at a high level so that you can implement them in your own environment.

### Remote Path Mapping

A remote path mapping is used when your download client is reporting a path for completed data either on another server or in a way that Sonarr doesn't address that folder. A remote path map is required if your download client is on Linux when \*Arr is on Windows or vice versa. It is also likely needed if mixing Docker and Native clients or if using a remote server. It is a DUMB search/replace (where you find this value, replace it with this value). If the error message about a bad path does not contain the REPLACED value, then the path mapping is not working as you expect. For further information regarding remote path mapping, please [click here](https://trash-guides.info/Sonarr/Sonarr-remote-path-mapping/).

### Permissions on the Library Folder

Don’t forget to check permissions and ownership of the *destination*. It is easy to get fixated on the download’s ownership and permissions and that is *usually* the cause of permissions related issues, but it *could* be the destination as well. Check that the destination folder(s) exist. Check that a destination *file* doesn’t already exist or can’t be deleted or moved to recycle bin. Check that ownership and permissions allow the downloaded file to be copied, hard linked or moved. The user or group that runs as needs to be able to read and write the root folder.

- For Windows Users this may be due to running as a service:
  - the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.
  - 'Local Service' also generally has very limited permissions. It's therefore advisable to install the app as a system tray application if the user can remain logged in. The option to do so is provided during the installer. See the FAQ for how to convert from a service to tray app.

- For Synology Users refer to [SynoCommunity's Permissions Article for their Packages](https://github.com/SynoCommunity/spksrc/wiki/Permission-Management)

### Permissions on the Downloads Folder

Don’t forget to check permissions and ownership of the *source*. It is easy to get fixated on the destination's ownership and permissions and that is a *possible* cause of permissions related issues, but it *typically* is the source. Check that the source folder(s) exist. Check that ownership and permissions allow the downloaded file to be copied/hardlinked or copy+delete/moved. The user or group that runs as needs to be able to read and write the downloads folder.

- For Windows Users this may be due to running as a service:
  - the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.
  - 'Local Service' also generally has very limited permissions. It's therefore advisable to install the app as a system tray application if the user can remain logged in. The option to do so is provided during the installer. See the FAQ for how to convert from a service to tray app.

- For Synology Users refer to [SynoCommunity's Permissions Article for their Packages](https://github.com/SynoCommunity/spksrc/wiki/Permission-Management)

### Download folder and library folder not different folders

- The download client should download into a folder accessible by \*Arr and that is not your root/library folder; should import from that separate download folder into your Library folder.
- You should never download directly into your root folder. You also should not use your root folder as the download client's completed folder or incomplete folder.
- [**This will also cause a healthcheck in System as well**](/sonarr/system#downloading-into-root-folder)
- Within the application, a root folder is defined as the configured media library folder. This is not the root folder of a mounted drive. You're downloading directly into your root (library) folder. This frequently causes issues and is not advised. To fix this change your download client so it is not placing downloads within your root folder. Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, should not be the same folder you have configured as your root/library/final media destination folder in the *arr application.
- Configured Root Folders (aka Library folders) can be found in [Settings => Media Management => Root Folders](/sonarr/settings/#root-folders)
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It is suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.

> Your download folder and your root/library folder MUST be separate
{.is-warning}

### Incorrect category

Sonarr should be setup to use a category so that it only tries to process its own downloads. It is rare that a torrent submitted by gets added without the correct category, but it can happen. If you’re adding torrents manually and want to process them, they’ll need to have the correct category. It can be set at any time, since tries to process downloads every minute.

### Packed torrents

If your torrent is packed in `.rar` files, you’ll need to setup extraction. We recommend [unpackerr](https://github.com/davidnewhall/unpackerr). One issue to look out for with packed torrents is that the video file will be copied or hard linked like normal, but it isn’t needed since the `.rar` files are seeding. That means if you’re using a *copy* setup, the torrent will be consuming double the space. And if you’re using a hard link setup, your torrent folder will be a little messier because of the unneeded file. This can be mitigated with a [cleanup script](https://gist.github.com/fryfrog/94716e7e27ba38dff57c7631d9f58bed).

### Repeated downloads

There are a few causes of repeated downloads, but one is related to the Indexer restriction in Release Profiles. Because the indexer *isn’t* stored with the data, any `preferred word` scores are *zero* for media in your library, *but* during “RSS” and search, they’ll be applied. Similarly for any `must contain` or `must-not` contain the restrictions only apply to that indexer; anything else is fair game. This gets you into a loop where you download the items again and again because it looks like an upgrade, then isn’t, then shows up again and looks like an upgrade, then isn’t. Don’t restrict your release profile to an indexer.

This may also be due to the fact that the download never actually imports and then is missing from the queue, so a new download is perpetually grabbed and never imported. Please see the various other common problems and troubleshooting steps for this.

### Usenet download misses import

Sonarr only looks at the 60 most recent downloads in SABnzbd and NZBGet, so if you *keep* your history this means that during large queues with import issues, downloads can be silently missed and not imported. The best way to avoid that is to keep your history clear, so that any items that still appear need investigating. You can achieve this by enabling Remove under Completed and Failed Download Handler. In NZBGet, this will move items to the *hidden* history which is great. Unfortunately, SABnzbd does not have a similar feature. The best you can achieve there is to use the nzb backup folder.

### Download client clearing items

The download client should *not* be responsible for removing downloads. Usenet clients should be configured so they *don’t* remove downloads from history. Torrent clients should be setup so they *don’t* remove torrents when they’re finished seeding (pause or stop instead). This is because communicates with the download client to know what to import, so if they’re *removed* there is nothing to be imported. even if there is a folder full of files.

For SABnzbd, this is handled with the History Retention setting.

### Download cannot be matched to a library item

For various reasons, releases cannot be parsed once grabbed and sent to the download client. Activity => Options => Shown Unknown will display all items not otherwise ignored / already imported within \*Arr's download client category. These will typically need to be manually mapped and imported.

This can also occur if you have a release in your download client but that media item (movie/episode/book/song) does not exist in the application.

### Episode Name is TBA

On TVDB, when episode names are unknown they'll be titled TBA and there is a 24 hour cache on the API. Typically, changes to the TVDB website take 24-48 hours to reach Sonarr due to TVDB cache, Skyhook cache and the series refresh interval.

The [Episode Title Required](/sonarr/settings#importing) setting in Sonarr controls import behavior when the title is TBA, but after 24 hours from the episode's air date  the release will be imported even if the title is still TBA. There is also no automatic follow up renaming of TBA titled files.

### Connection Timed Out

`The request timed out`

Sonarr is getting no response from the client.

This is typically caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy

## Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in our guide](/permissions-and-networking. Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

# Searches Indexers and Trackers

## Turn logging up to trace

> **The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net), [Gist](https://gist.com), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.
{.is-danger}

## Testing an Indexer or Tracker

When you test an indexer or tracker, in debug or trace logs you can find the URL used. An example of a successful test is below, you can see it query the indexer via a specific URL with specific parameters and then the response. You test this url in your browser like replacing the `apikey=(removed)` with the correct apikey like `apikey=123`. You can experiment with the parameters if you’re getting an error from the indexer or see if you have connectivity issues if it doesn’t even work. After you’ve tested in your own browser, you should test from the system is running on *if* you haven’t already.

## Testing a Search

Just like the indexer/tracker test above, when you trigger a search while at Debug or Trace level logging, you can get the URL used from the log files. While testing, it is best to use as narrow a search as possible. A manual search is good because it is specific and you can see the results in the UI while examining the logs.

In this test, you’ll be looking for obvious errors and running some simple tests. You can see the search used the url `https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1`, which you can try yourself in a browser after replacing (removed) with your apikey for that indexer. Does it work? Do you see the expected results? Does this FAQ entry apply? In that URL, you can see that it set specific categories with `cat=5030,5040,5045,5080`, so if you’re not seeing expected results, this is one likely reason. You can also see that it searched by tvdbid with `tvdbid=354629`, so if the episode isn’t properly categorized on the indexer, it will need to be fixed. You can also see that it searches by specific season and episode with season=1 and ep=1, so if that isn’t correct on the indexer, you won’t see those results. Look at Manual Search XML Output below to see an example of a working query’s output.

- Manual Search XML Output

```xml
<rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:newznab="http://www.newznab.com/DTD/2010/feeds/attributes/" version="2.0">
<channel>
<atom:link href="https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1" rel="self" type="application/rss+xml"/>
<title>api.nzbgeek.info</title>
<description>NZBgeek API</description>
<link>http://api.nzbgeek.info/</link>
<language>en-gb</language>
<webMaster>info@nzbgeek.info (NZBgeek)</webMaster>
<category/>
<image>
<url>https://api.nzbgeek.info/covers/nzbgeek.png</url>
<title>api.nzbgeek.info</title>
<link>http://api.nzbgeek.info/</link>
<description>NZBgeek</description>
</image>
<newznab:response offset="0" total="2"/>
<item>
<title>The.Fix.S01E01.1080p.AMZN.WEB-DL</title>
<guid isPermaLink="true">
https://api.nzbgeek.info/details/358e0f946f953771c7688864b0334ba1
</guid>
<link>
https://api.nzbgeek.info/api?t=get&id=358e0f946f953771c7688864b0334ba1&apikey=(removed)
</link>
<comments>
https://nzbgeek.info/geekseek.php?guid=358e0f946f953771c7688864b0334ba1
</comments>
<pubDate>Wed, 20 Mar 2019 05:03:32 +0000</pubDate>
<category>TV > HD</category>
<description>The.Fix.S01E01.1080p.AMZN.WEB-DL</description>
<enclosure url="https://api.nzbgeek.info/api?t=get&id=358e0f946f953771c7688864b0334ba1&apikey=(removed)" length="3810861000" type="application/x-nzb"/>
<newznab:attr name="category" value="5000"/>
<newznab:attr name="category" value="5040"/>
<newznab:attr name="size" value="3810861000"/>
<newznab:attr name="guid" value="358e0f946f953771c7688864b0334ba1"/>
<newznab:attr name="tvdbid" value="354629"/>
<newznab:attr name="season" value="S01"/>
<newznab:attr name="episode" value="E01"/>
<newznab:attr name="tvairdate" value="2019-03-18T00:00:00Z"/>
<newznab:attr name="grabs" value="55"/>
<newznab:attr name="usenetdate" value="Wed, 20 Mar 2019 04:54:15 +0000"/>
</item>
<item>
<title>The.Fix.S01E01.720p.AMZN.WEB-DL</title>
<guid isPermaLink="true">
https://api.nzbgeek.info/details/f7e4ac2875b6a1ce45bae91ab19e9699
</guid>
<link>
https://api.nzbgeek.info/api?t=get&id=f7e4ac2875b6a1ce45bae91ab19e9699&apikey=(removed)
</link>
<comments>
https://nzbgeek.info/geekseek.php?guid=f7e4ac2875b6a1ce45bae91ab19e9699
</comments>
<pubDate>Wed, 20 Mar 2019 05:03:33 +0000</pubDate>
<category>TV > HD</category>
<description>The.Fix.S01E01.720p.AMZN.WEB-DL</description>
<enclosure url="https://api.nzbgeek.info/api?t=get&id=f7e4ac2875b6a1ce45bae91ab19e9699&apikey=(removed)" length="1195794000" type="application/x-nzb"/>
<newznab:attr name="category" value="5000"/>
<newznab:attr name="category" value="5040"/>
<newznab:attr name="size" value="1195794000"/>
<newznab:attr name="guid" value="f7e4ac2875b6a1ce45bae91ab19e9699"/>
<newznab:attr name="tvdbid" value="354629"/>
<newznab:attr name="season" value="S01"/>
<newznab:attr name="episode" value="E01"/>
<newznab:attr name="tvairdate" value="2019-03-18T00:00:00Z"/>
<newznab:attr name="grabs" value="14"/>
<newznab:attr name="usenetdate" value="Wed, 20 Mar 2019 04:51:45 +0000"/>
</item>
</channel>
</rss>
```

![searches-indexers-and-trackers1.png](/assets/sonarr/searches-indexers-and-trackers1.png)
![searches-indexers-and-trackers2.png](/assets/sonarr/searches-indexers-and-trackers2.png)

- Trace Log Snippet

```none
2021-03-20 13:15:23.6|Info|NzbSearchService|Searching 1 indexers for [The Fix : S01E01]
2021-03-20 13:15:23.6|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
2021-03-20 13:15:23.6|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
```

- Full Trace Log of a Search

```none
2021-03-20 13:15:23.6|Trace|Http|Req: 66 [GET] /api/v3/release?episodeId=1   
2021-03-20 13:15:23.6|Info|NzbSearchService|Searching 1 indexers for [The Fix : S01E01]
2021-03-20 13:15:23.6|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
2021-03-20 13:15:23.6|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
2021-03-20 13:15:23.6|Trace|ConfigService|Using default config value for 'proxyenabled' defaultValue:'False'
2021-03-20 13:15:24.3|Trace|HttpClient|Res: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1: 200.OK (680 ms)
2021-03-20 13:15:24.3|Trace|NewznabRssParser|Parsed: The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Trace|NewznabRssParser|Parsed: The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|NzbSearchService|Total of 2 reports were found for [The Fix : S01E01] from 1 indexers
2021-03-20 13:15:24.3|Debug|NzbSearchService|Setting last search time to: 11/20/2019 13:15:24
2021-03-20 13:15:24.3|Info|DownloadDecisionMaker|Processing 2 releases
2021-03-20 13:15:24.3|Trace|DownloadDecisionMaker|Processing release 1/2
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Processing release 'The.Fix.S01E01.1080p.AMZN.WEB-DL' from 'NZBgeek'
2021-03-20 13:15:24.3|Debug|Parser|Parsing string 'The.Fix.S01E01.1080p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|Parser|^(?<title>.+?)(?:(?:[-_\W](?<![()\[!]))+S?(?<season>(?<!\d+)(?:\d{1,2})(?!\d+))(?:[ex]|\W[ex]){1,2}(?<episode>\d{2,3}(?!\d+))(?:(?:\-|[ex]|\W[ex]|_){1,2}(?<episode>\d{2,3}(?!\d+)))*)\W?(?!\\)
2021-03-20 13:15:24.3|Debug|Parser|Episode Parsed. The Fix - S01E01
2021-03-20 13:15:24.3|Debug|Parser|Language parsed: English
2021-03-20 13:15:24.3|Debug|QualityParser|Trying to parse quality for The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|Parser|Quality parsed: WEBDL-1080p v1
2021-03-20 13:15:24.3|Debug|Parser|Release Group parsed:
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculating preferred word score for 'The.Fix.S01E01.1080p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculated preferred word score for 'The.Fix.S01E01.1080p.AMZN.WEB-DL': 0
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Beginning size check for: The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Possible double episode, doubling allowed size.
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Item: The.Fix.S01E01.1080p.AMZN.WEB-DL, meets size constraints.
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Performing already imported check on report
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Skipping already imported check for episode without file
2021-03-20 13:15:24.3|Debug|LanguageSpecification|Checking if report meets language requirements. English
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'maximumsize' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MaximumSizeSpecification|Maximum size is not set.
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'minimumage' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MinimumAgeSpecification|Minimum age is not set.
2021-03-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Checking if report meets quality requirements. WEBDL-1080p v1
2021-03-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Quality WEBDL-1080p v1 rejected by Series' quality profile
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|Checking if release meets restrictions: The.Fix.S01E01.1080p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|[The.Fix.S01E01.1080p.AMZN.WEB-DL] No restrictions apply, allowing
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'retention' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|RetentionSpecification|Checking if report meets retention requirements. 245
2021-03-20 13:15:24.3|Debug|SeriesSpecification|Checking if series matches searched series
2021-03-20 13:15:24.3|Debug|DelaySpecification|Ignoring delay for user invoked search
2021-03-20 13:15:24.3|Debug|HistorySpecification|Skipping history check during search
2021-03-20 13:15:24.3|Debug|MonitoredEpisodeSpecification|Skipping monitored check during search
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Release rejected for the following reasons: [Permanent] WEBDL-1080p is not wanted in profile
2021-03-20 13:15:24.3|Trace|DownloadDecisionMaker|Processing release 2/2
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Processing release 'The.Fix.S01E01.720p.AMZN.WEB-DL' from 'NZBgeek'
2021-03-20 13:15:24.3|Debug|Parser|Parsing string 'The.Fix.S01E01.720p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|Parser|^(?<title>.+?)(?:(?:[-_\W](?<![()\[!]))+S?(?<season>(?<!\d+)(?:\d{1,2})(?!\d+))(?:[ex]|\W[ex]){1,2}(?<episode>\d{2,3}(?!\d+))(?:(?:\-|[ex]|\W[ex]|_){1,2}(?<episode>\d{2,3}(?!\d+)))*)\W?(?!\\)
2021-03-20 13:15:24.3|Debug|Parser|Episode Parsed. The Fix - S01E01
2021-03-20 13:15:24.3|Debug|Parser|Language parsed: English
2021-03-20 13:15:24.3|Debug|QualityParser|Trying to parse quality for The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|Parser|Quality parsed: WEBDL-720p v1
2021-03-20 13:15:24.3|Debug|Parser|Release Group parsed:
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculating preferred word score for 'The.Fix.S01E01.720p.AMZN.WEB-DL'
2021-03-20 13:15:24.3|Trace|PreferredWordService|Calculated preferred word score for 'The.Fix.S01E01.720p.AMZN.WEB-DL': 0
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Beginning size check for: The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Possible double episode, doubling allowed size.
2021-03-20 13:15:24.3|Debug|AcceptableSizeSpecification|Item: The.Fix.S01E01.720p.AMZN.WEB-DL, meets size constraints.
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Performing already imported check on report
2021-03-20 13:15:24.3|Debug|AlreadyImportedSpecification|Skipping already imported check for episode without file
2021-03-20 13:15:24.3|Debug|LanguageSpecification|Checking if report meets language requirements. English
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'maximumsize' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MaximumSizeSpecification|Maximum size is not set.
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'minimumage' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|MinimumAgeSpecification|Minimum age is not set.
2021-03-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Checking if report meets quality requirements. WEBDL-720p v1
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|Checking if release meets restrictions: The.Fix.S01E01.720p.AMZN.WEB-DL
2021-03-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|[The.Fix.S01E01.720p.AMZN.WEB-DL] No restrictions apply, allowing
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'retention' defaultValue:'0'
2021-03-20 13:15:24.3|Debug|RetentionSpecification|Checking if report meets retention requirements. 245
2021-03-20 13:15:24.3|Debug|SeriesSpecification|Checking if series matches searched series
2021-03-20 13:15:24.3|Debug|DelaySpecification|Ignoring delay for user invoked search
2021-03-20 13:15:24.3|Debug|HistorySpecification|Skipping history check during search
2021-03-20 13:15:24.3|Debug|MonitoredEpisodeSpecification|Skipping monitored check during search
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'autounmonitorpreviouslydownloadedepisodes' defaultValue:'False'
2021-03-20 13:15:24.3|Debug|DownloadDecisionMaker|Release accepted
2021-03-20 13:15:24.3|Trace|ConfigService|Using default config value for 'downloadpropersandrepacks' defaultValue:'PreferAndUpgrade'
2021-03-20 13:15:24.3|Trace|Http|Res: 66 [GET] /api/v3/release?episodeId=1: 200.OK (775 ms)
2021-03-20 13:15:24.3|Debug|Api|[GET] /api/v3/release?episodeId=1: 200.OK (775 ms)
```

## Common Problems

Below are some common problems.

### Tracker needs RawSearch Caps

- Sonarr is searching for `9 1 1` but your tracker only has results for `9-1-1` or `John s Show` and `John's Show`
- This is due to your tracker not supporting normal standardized searches.
- The solution is that your tracker's definition's search capabilities need to be updates to indicate it [requires and supports `RawSearch`](https://github.com/Sonarr/Sonarr/issues/1225#issuecomment-981153943)
- Jackett [does not support](https://github.com/Jackett/Jackett/pull/11889) this capabilities flag.
- Prowlarr supports the flag, but the capabilites need to be updated on a per-indexer basis. Open a feature request for Prowlarr to add this functionality for your indexer.

### Series needs an alias

Releases may be uploaded as `The Series Name`, but TVDB has the series as `Series Name` or similar naming differences. Please see [this FAQ entry](/sonarr/faq#why-cannot-sonarr-import-episode-files-for-series-x-why-cannot-sonarr-find-releases-for-series-x)

### Series needs an XEM Mapping

Releases may be uploaded as `Series Title S02E45` or `Other Series Title S2022E42`, but TVDB has this episode as `Series Title S03E01` or `Other Series Title S03E42`  Please see [this FAQ entry](/sonarr/faq#how-does-sonarr-handle-scene-numbering-issues-american-dad-etc)

### Wrong Series Type

The series type affects how Sonarr searches. The series type should be selected based on how the series is being released on the indexers.
[See this FAQ entry for more details](/sonarr/faq#whats-the-different-series-types)

> If **Anime** Series Type is used - it is [possible to also have your indexer searched with the standard type as well.](/sonarr/settings#indexers)
{.is-info}

#### Daily

Logs will show `Searching indexers for [The Witcher : 2021-12-20]`

- Some.Daily.Show.**2021.03.04**.1080p.HDTV.x264-DARKSPORT
- A.Daily.Show.with.Some.Guy.**2021.03.03**.1080p.CC.WEB-DL.AAC2.0.x264-null
- DailyShow.**2021.03.08**.720p.HDTV.x264-NTb

#### Standard

Logs will show `Searching indexers for [The Witcher : S01E09]`

- The.Show.**S20E03**.Episode.Title.Part.3.1080p.HULU.WEB-DL.DDP5.1.H.264-NTb
- Another.Show.**S03E08**.1080p.WEB.H264-GGEZ
- GreatShow.**S17E02**.1080p.HDTV.x264-DARKFLiX

#### Anime

Logs will show `Searching indexers for [The Witcher : 09]`

- Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
- \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC) \[63B8AC67\]
- \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]

### Media is Unmonitored

The series/season/episode(s) is(are) not monitored.

### Query Successful - No Results Returned

You receive a message similar to `Query successful, but no results were returned from your indexer. This may be an issue with the indexer or your indexer category settings.`

This is caused by your Indexer failing to return any results that are within the categories you configured for the Indexer.

### Wrong Categories

Incorrect categories is probably the most common cause of results showing in manual searches of an indexer/tracker, but *not* in . The indexer/tracker *should* show the category in the search results, which should help you figure out what is missing. If you’re using Jackett or Prowlarr, each tracker has a list of specifically supported categories. Make sure you’re using the correct ones for Categories. Many find it helpful to have the list visible in one browser window while they edit the entry in.

> Note that if you have `Anime Categories` blank in your Indexer settings then the Indexer will not be used for Anime Series Type searches. Similarly, if you have `Categories` blank in your Indexer settings then the Indexer will not be used for Standard nor Daily Series Type searches.
{.is-info}

### Wrong Results

Sometimes indexers will return completely unrelated results; Sonarr will feed in parameters to limit the search to an series. Sometimes the results returned are completely unrelated. Or sometimes, mostly related with a few incorrect results. The first is usually an indexer problem and you’ll be able to tell from the trace logs which is causing it. You can disable that indexer and report the problem. The other is usually categorized releases which should be reportable on the indexer/tracker.

### Missing Results

If you have results on the site you can find that are not showing in Sonarr then your issue is likely one of several possibilities:

- [Categories are incorrect - See Above](#wrong-categories)
- An ID (IMDbId, TVDBId, etc.) based searched is being done and the Indexer does not have the releases correctly mapped to that ID. This is something only your indexer can solve. They need to ensure the release is mapped to the correct applicable ids.
- Not searching how Sonarr is searching; It's highly likely the terms you are searching on the indexer is not how Sonarr is querying it. You can see how Sonarr is querying from the Trace Logs. Text based queries will generally be in the format of `q=words%20and%20things%20here`  this string is HTTP encoded and can be easily decoded using any HTML decoding/encoding tool online.

### Certificate validation

You’ll be connecting to most indexers/trackers via https, so you’ll need that to work properly on your system. That means your time zone and time both need to be set *correctly*. It also means your system certificates need to be up to date.

### Hitting rate limits

If you run your through a VPN or proxy, you may be competing with 10s or 100s or 1000s of other people all trying to use services like , theXEM ,and/or your indexers and trackers. Rate limiting and DDOS protection are often done by IP address and your VPN/proxy exit point is *one* IP address. Unless you’re in a repressive country like China, Australia or South Africa you don’t need to VPN/proxy.

Rarbg has a tendency to have some sort of rate limiting within their API and displays as responding with no results.

### IP Ban

Similarly to rate limits, certain indexers - such as Nyaa - may outright ban an IP address. This is typically semi-permanent and the solution is to  to get a new IP from your ISP or VPN provider.

### Using the Jackett /all endpoint

The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is strongly recommended. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)

[Even Jackett says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

Using the all endpoint has no advantages (besides reduced management overhead), only disadvantages:

- you lose control over indexer specific settings (categories, search modes, etc.)
- mixing search modes (IMDB, query, etc.) might cause low-quality results
- indexer specific categories (\>= 100000) cannot be used.
- slow indexers will slow down the overall result
- total results are limited to 1000

Adding each indexer separately It allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In , each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you’re more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error,  will disable it and now you don’t get any results.

### Using NZBHydra2 as a single entry

Using NZBHydra2 as a single indexer entry (i.e. 1 NZBHydra2 Entry in Sonarr for many indexers in NZBHydra2) rather than multiple (i.e. many NZBHydra2 entries in Sonarr for many indexers in NZBHydra2) has the same problems as noted above with Jackett's `/all` endpoint.

### Indexer not being searched

- If an indexer does not appear to being searched, it is likely due to the indexer not supporting the query type. The most common instance is Nyaa only supports query searches and not Season/Episode searches. The Trace logs indicate after a reboot on the first search what capabilites an indexer has or does not have.

### Jackett manual search finding more results

- [See this FAQ entry](/sonarr/faq#jackett-shows-more-results-than-sonarr-when-manually-searching)

### Release Profiles not being respected

There are a few causes why it may appear your profiles are being ignored. The most common one is related to the Indexer restriction in Release Profiles. Because the indexer *isn’t* stored with the data, any `preferred word` scores are *zero* for media in your library, *but* during “RSS” and search, they’ll be applied. Similarly for any `must contain` or `must-not` contain the restrictions only apply to that indexer; anything else is fair game. This may then cause release profiles to appear to be ignored or for upgrade loops to occur.

### Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in our guide](/permissions-and-networking. Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

## Errors

These are some of the common errors you may see when adding an indexer

### The underlying connection was closed: An unexpected error occurred on a send

This is caused by the indexer using a SSL protocol not supported by the current .NET Version found in [Sonarr => System => Status](/sonarr/system#status).

### The request timed out

Sonarr is getting no response from the indexer.

Sonarr seems to have issues with certain TLS versions or configurations. If you get the following error messages in your log:

```none
    System.NET.WebException: The request timed out: ’https://example.org/api?t=caps&apikey=(removed) —> System.NET.WebException: The request timed out
```

And you can see the following in the trace log file:

```none
    <DATE&TIME>|Trace|FallbackHttpDispatcher|Curl not available, using default WebClient. 
```

You might fix it by installing libcurl3. On Ubuntu/Debian use;

```shell
    sudo apt install libcurl3
```

This can also be caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues
- local IPv6 issues - typically IPv6 is enabled, but non-functional
- the use of Privoxy

### Problem Not Listed

You can also review some common permissions and networking troubleshooting commands [in our guide](/permissions-and-networking. Otherwise please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.
