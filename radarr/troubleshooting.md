---
title: Radarr Troubleshooting
description: 
published: true
date: 2021-07-06T19:52:32.652Z
tags: radarr, troubleshooting
editor: markdown
dateCreated: 2021-06-20T19:13:43.764Z
---

## Asking for Help

Do you need help? That's okay, everyone needs help sometimes. You can get real time help via chat on

- [<i class="fab fa-discord"></i>&emsp;Discord *Official Radarr Discord*](https://radarr.video/discord)
- [<i class="fab fa-reddit"></i>&emsp;Reddit *Official Radarr Subreddit*](https://reddit.com/r/radarr)
{.links-list}

But before you go there and post, be sure your request for help is the best it can be. Clearly describe the problem and briefly describe your setup, including things like your OS/distribution, version of .Net, version of Radarr, download client and its version. **If you are using [Docker](https://www.docker.com/) please run through [Docker Guide](/docker-guide) first as that will solve common and frequent path/permissions issues. Otherwise please have a [docker compose](/docker-guide#docker-compose) handy** Tell us about what you've tried already, what you've looked at. Use the [Logging and Log Files section](#logging-and-log-files) to turn your logging up to trace, recreate the issue, pastebin the relevant context and include a link to it in your post. Maybe even include some screen shots to highlight the issue.

The more we know, the easier it is to help you.

### Logging and Log Files

If you're linked here for support remember to get them the information from the actual trace log file, put the logs in a pastebin and show us context around what we need to see. If you're asked for debug logs your logs will contain `debug` and if you're asked for trace logs your logs will contain `trace`. If the logs you are providing do not contain either then they are not the logs requested.

>- **Do not simply provide the whole log file unless explictly asked.**
>- **Do not upload the logs directly to discord as a file nor paste them as a wall of text unless explictly asked.**
>	- When the relevant section is ~ 15 lines, it may be acceptable to paste in discord in a code block like this:
>````
>   ```
>   words here
>   ```
>````
>- **Do not attempt to get logs while a spammy task is running such as an RSS refresh.**
>- **Do ensure [Logging](/radarr/settings#logging) is set to Trace (or Debug if requested).**
>- **Do ensure the logs you provide capture the issue**

What you need to do is:

1. Turn Logging up to Trace
1. Clear Logs
1. Reproduce the Issue
1. Open the trace log file (radarr.trace.txt) and find the relevant context
1. Use [Hastebin](https://hastebin.com/), [Ubuntu's Pastebin](https://pastebin.ubuntu.com/), [0bin](https://0bin.net/), [Gist](https://gist.github.com/), or any other pastebin type site a big chunk before the issue, the issue, and a big chunk after the issue.
> It is **not** suggested to use [pastebin](https://pastebin.com) as their filters have a tendency to block the logs.{.is-info}

- Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use N++. You can use the Notepad++ "Find in Files" function to search old log files as needed.
- Unix Only: Alternatively If you're looking for a specific entry in an old log file but aren't sure which one you can use grep. For example if you want to find information about the movie or show "Shooter" you can run the following command:

`grep -inr -C 100 -e 'Shooter' /path/to/logs/*.trace*.txt`

If your Appdata Directory is in your home folder then you'd run:

`grep -inr -C 100 -e 'Shooter' /home/$User/.config/logs/*.trace*.txt`

The flags have the following functions:

- -i: ignore case
- -n: show line number
- -r: recursively check all files in the path
- -C: provide ## of lines before and after the line it is found on
- -e: the pattern to search for

#### Standard Logs Location

The log files are located in radarr's [Appdata Directory](/radarr/appdata-directory), inside the logs/ folder. You can also access the log files from the UI at System -> Logs -> Files.

> Note: The Logs ("Events") Table in the UI is not the same as the log files and isn't as useful. If you're asked for logs, please copy/paste from the log files and not the table.
{.is-info}

#### Update Logs Location

The update log files are located in radarr's [Appdata Directory](/radarr/appdata-directory), inside the UpdateLogs/ folder.

#### Sharing Logs

The logs can be long and hard to read as part of a forum or Reddit post and they're spammy in Discord, so please use [Pastebin](https://pastebin.ubuntu.com/), [Hastebin](https://hastebin.com/), [Gist](https://gist.github.com), [0bin](https://0bin.net), or any other similar pastebin site . The whole file typically isn't needed, just a good amount of context from before and after the issue/error. Do not forget to wait for spammy tasks like an RSS sync or library refresh to finish.

#### Trace/Debug Logs

You can change the log level at Settings -> General -> Logging.  does not need to restarted for the change to take effect. This change only affects the log files, not the logging database. The latest debug/trace log files are named `radarr.debug.txt` and `radarr.trace.txt` respectively.

If you're unable to access the UI to set the logging level you can do so by editing config.xml in the AppData directory by setting the LogLevel value to Debug or Trace instead of Info.

```xml
 <Config>
  ...
  <LogLevel>debug</LogLevel>
  ...
 </Config>
```

#### Clearing Logs

You can clear log files and the logs database directly from the UI, under System -> Logs -> Files and System -> Logs -> Delete (Trash Can Icon)

#### Log Files

 uses rolling log files limited to 1MB each. The current log file is always ,`.txt`, for the the other files `.0.txt` is the next newest (the higher the number the older it is). This log file contains `fatal`, `error`, `warn`, and `info` entries.

When Debug log level is enabled, additional `.debug.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a 40h period.

When Trace log level is enabled, additional `.trace.txt` rolling log files will be present. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.

### Recovering from a Failed Update

-----

- We do everything we can to prevent issues when upgrading, but they occur, this will walk you through the steps of recovering your installation.

### Determine the issue

- The best place to look when the application will not start after an update is to review the [update logs](#update-logs-location) and see if the update completed sucessfully. If those do not have an issue then the next step is to look at your regular application log files, before trying to start again, use [Logging](/radarr/settings#logging) and [Log Files](/radarr/system#log-files) to find them and increase the log level.

- **Migration Issue** - Migration errors will not be identical, but here is an example:

```none
14-2-4 18:56:49.5|Info|MigrationLogger|\*\*\* 36: update\_with\_quality\_converters migrating \*\*\*

14-2-4 18:56:49.6|Error|MigrationLogger|SQL logic error or missing database duplicate column name: Items

While Processing: "ALTER TABLE "QualityProfiles" ADD COLUMN "Items" TEXT"

```

#### Resolving the issue

In the event of a migration issue there is not much you can do immediately, if the issue is specific to you (or there are not yet any posts), please create a post on <https://reddit.com/r/radarr> our subreddit or swing by our discord, if there are others with the same issue, then rest assured we are working on it.

##### Manually upgrading

Grab the latest release from <https://radarr.video>

Install the update (.exe) or extract (.zip) the contents over your existing installation and re-run as you normally would.

### Downloads and Importing

Downloading and importing is where *most* people experience issues. From a high level perspective,  needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even *bigger* variety of setups. This means that while there are some *common* setups, there isn’t one *right* setup and everyone’s setup can be a little different.

**The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net), [Gist](https://gist.com), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.

When you reach out for help, be sure to read [asking for help](#asking-for-help) so that you can provide us with the details we’ll need.

#### Testing the Download Client

Ensure your download client(s) are running. Start by testing the download client, if it doesn’t work you’ll be able to see details in the trace level logs. You should find a URL you can put into your browser and see if it works. It could be a connection problem, which could indicate a wrong ip, hostname, port or even a firewall blocking access. It might be obvious, like an authentication problem where you’ve gotten the username, password or apikey wrong.

#### Testing a Download

Now we’ll try a download, pick a and do a manual search. Pick one of those files and attempt to download it. Does it get sent to the download client? Does it end up with the correct category? Does it show up in Activity? Does it end up in the trace level logs during the **Check For Finished Download** task which runs roughly every minute? Does it get correctly parsed during that task? Does the queued up download have a reasonable name? Since searches by ****, on most indexers/trackers, it can queue one up with a name that it can’t recognize.

#### Testing an Import

Import issues should almost always manifest as an item in Activity with an orange icon you can hover to see the error. If they’re not showing up in Activity, this is the issue you need to focus on first so go back and figure that out. Most import errors are *permissions* issues, remember that needs to be able to read and write in the download folder. Sometimes, permissions in the library folder can be at fault too, so be sure to check both.

Incorrect path issues are possible too, though less common in normal setups. The key to understanding path issues is knowing that gets the path to the download *from* the download client, via its API. This becomes a problem in more unique use cases, like the download client running on a different system (maybe even OS\!). It can also occur in a Docker setup, when volumes are not done well. A remote path map is a good solution where you don’t have control, like a seedbox setup. On a Docker setup, fixing the paths is a better option.

#### Common Problems

##### Download Client's WebUI is not enabled

 talks to you download client via it's API and accesses it via the client's webui. You must ensure the client's webui is enabled and the port it is using does not conflict with any other client ports in use or ports in use on your system.

##### SSL in use and incorrectly configured

Ensure SSL encryption is not turned on if you're using both your instance and your download client on a local network. See [the SSL FAQ entry](/radarr/faq#invalid-certificate-and-other-HTTPS-or-SSL-issues) for more information.

##### Can’t see share on Windows

The default user for a Windows service is **SYSTEM** which typically doesn’t have access to your shares. Edit the service and set it up to run as your own user, see the FAQ entry [why can’t see my files on a remote server](/radarr/faq#why-cant-i-see-my-files-on-a-remote-server) for details.

##### Mapped network drives are not reliable

While mapped network drives like `X:\` are convenient, they aren’t as reliable as UNC paths like `\\server\share` and they’re also not available before login. Setup and your download client(s) so that they use UNC paths as needed. If your library is on a share, you’d make sure your root folders are using UNC paths. If your download client sends to a share, that is where you’ll need to configure UNC paths since gets the download path from the download client. It is fine to keep your mapped network drives to use yourself, just don’t use them for automation.

##### Docker and user, group, ownership, permissions and paths

Docker adds another layer of complexity that is easy to get wrong, but still end up with a setup that functions, but has various problems. Instead of going over them here, read this wiki article [for these automation software and Docker](/docker-guide) which is all about user, group, ownership, permissions and paths. It isn’t specific to any Docker system, instead it goes over things at a high level so that you can implement them in your own environment.

##### Permissions on the Library Folder

Don’t forget to check permissions and ownership of the *destination*. It is easy to get fixated on the download’s ownership and permissions and that is *usually* the cause of permissions related issues, but it *could* be the destination as well. Check that the destination folder(s) exist. Check that a destination *file* doesn’t already exist or can’t be deleted or moved to recycle bin. Check that ownership and permissions allow the downloaded file to be copied, hard linked or moved. The user or group that runs as needs to be able to read and write the root folder.

##### Permissions on the Downloads Folder

Don’t forget to check permissions and ownership of the *source*. It is easy to get fixated on the destination's ownership and permissions and that is a *possible* cause of permissions related issues, but it *typically* is the source. Check that the source folder(s) exist. Check that ownership and permissions allow the downloaded file to be copied/hardlinked or copy+delete/moved. The user or group that runs as needs to be able to read and write the downloads folder.

##### Download folder and library folder not different folders

The download client should download into a folder accessible by and that is not your root/library folder;  should import from that separate download folder into your Library folder.

You should never download directly into your root folder. You also should not use your root folder as the download client's completed folder or incomplete folder.

If you download right into your library folder, you’ll end up with multiple copies of your media and when there are import issues, which there will be, you may not notice because your media server will see the download client copy.

The download folder will also be a hot mess of poorly named folders and files while your library folder will be nice and neat.

This frequently causes other random import issues as well.

##### Incorrect category

 should be setup to use a category so that it only tries to process its own downloads. It is rare that a torrent submitted by gets added without the correct category, but it can happen. If you’re adding torrents manually and want to process them, they’ll need to have the correct category. It can be set at any time, since tries to process downloads every minute.

##### Packed torrents

If your torrent is packed in `.rar` files, you’ll need to setup extraction. We recommend [unpackerr](https://github.com/davidnewhall/unpackerr). One issue to look out for with packed torrents is that the video file will be copied or hard linked like normal, but it isn’t needed since the `.rar` files are seeding. That means if you’re using a *copy* setup, the torrent will be consuming double the space. And if you’re using a hard link setup, your torrent folder will be a little messier because of the unneeded file. This can be mitigated with a [cleanup script](https://gist.github.com/fryfrog/94716e7e27ba38dff57c7631d9f58bed).

##### Repeated downloads

There are a few causes of repeated downloads, but a recent one is related to the Indexer restriction in Release Profiles. Because the indexer *isn’t* stored with the data, any preferred word scores are *zero* for media in your library, *but* during “RSS” and search, they’ll be applied. This gets you into a loop where you download the items again and again because it looks like an upgrade, then isn’t, then shows up again and looks like an upgrade, then isn’t. Don’t restrict your release profile to an indexer.

##### Usenet download misses import

 only looks at the 60 most recent downloads in SABnzbd and NZBGet, so if you *keep* your history this means that during large queues with import issues, downloads can be silently missed and not imported. The best way to avoid that is to keep your history clear, so that any items that still appear need investigating. You can achieve this by enabling Remove under Completed and Failed Download Handler. In NZBGet, this will move items to the *hidden* history which is great. Unfortunately, SABnzbd does not have a similar feature. The best you can achieve there is to use the nzb backup folder.

##### Download client clearing items

The download client should *not* be responsible for removing downloads. Usenet clients should be configured so they *don’t* remove downloads from history. Torrent clients should be setup so they *don’t* remove torrents when they’re finished seeding (pause or stop instead). This is because communicates with the download client to know what to import, so if they’re *removed* there is nothing to be imported… even if there is a folder full of files.

For SABnzbd, this is handled with the History Retention setting.

##### Download cannot be matched to a library item

For various reasons, releases cannot be parsed once grabbed and sent to the download client. Activity -> Options -> Shown Unknown will display all items not otherwise ignored / already imported within *Arr's download client category. These will typically need to be manually mapped and imported.

This can also occur if you have a release in your download client but that media item (movie/episode/book/song) does not exist in the application.

#### Problem Not Listed

Please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

### Searches Indexers and Trackers

#### Turn logging up to trace

**The first step is to turn logging up to Trace, see [Logging and Log Files](#logging-and-log-files) for details on adjusting logging and searching logs. You’ll then reproduce the issue and use the trace level logs from that time frame to examine the issue.** If someone is helping you, put context from before/after in a [pastebin](https://0bin.net), [Gist](https://gist.com), or similar site to show them. It doesn’t need to be the whole file and it shouldn’t *just* be the error. You should also reproduce the issue while tasks that spam the log file aren’t running.

#### Testing an Indexer or Tracker

When you test an indexer or tracker, in debug or trace logs you can find the URL used. An example of a successful test is below, you can see it query the indexer via a specific URL with specific parameters and then the response. You test this url in your browser like replacing the `apikey=(removed)` with the correct apikey like `apikey=123`. You can experiment with the parameters if you’re getting an error from the indexer or see if you have connectivity issues if it doesn’t even work. After you’ve tested in your own browser, you should test from the system is running on *if* you haven’t already.

### Testing a Search

placeholder

#### Common Problems

Below are some common problems.

##### Media is Unmonitored

The media is/are not monitored.

##### Wrong categories

Incorrect categories is probably the most common cause of results showing in manual searches of an indexer/tracker, but *not* in . The indexer/tracker *should* show the category in the search results, which should help you figure out what is missing. If you’re using Jackett, each tracker has a list of specifically supported categories. Make sure you’re using the correct ones for Categories. I find it helpful to have the list visible in one browser window while I edit the entry in.

##### Wrong results

Sometimes indexers will return completely unrelated results,  will feed in parameters to limit the search to a , but the results returned are completely unrelated. Or sometimes, mostly related with a few incorrect results. The first is usually an indexer problem and you’ll be able to tell from the trace logs which is causing it. You can disable that indexer and report the problem. The other is usually categorized releases which should be reportable on the indexer/tracker.

##### Certificate validation

You’ll be connecting to most indexers/trackers via https, so you’ll need that to work properly on your system. That means your time zone and time both need to be set *correctly*. It also means your system certificates need to be up to date.

##### Hitting rate limits

If you run your through a VPN or proxy, you may be competing with 10s or 100s or 1000s of other people all trying to use services like , theXEM ,and/or your indexers and trackers. Rate limiting and DDOS protection are often done by IP address and your VPN/proxy exit point is *one* IP address. Unless you’re in a repressive country like China, Australia or South Africa you don’t need to VPN/proxy .

Rarbg has a tendency to have some sort of rate limiting within their API and displays as responding with no results.

##### Year doesn't match

Sometimes a movie won't be grabbed, because it's release year was pushed back. So on TMDB, the movie listed as 2021, for example, but the release names all have 2020. The only way to get these movies is with a manual download/import. There is no "fix" to be made. Eventually, someone will usually upload a movie with the correct year and Radarr will grab it without issue, but until they do, you can only manually manage it.

##### Missing year

Radarr will not grab a release if the release name doesn't contain a year. This is a bad release, and can only be manually grabbed. This is a common thing to overlook when trying to figure out why a movie was not grabbed as expected.

##### Using the Jackett /all endpoint

The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is recommended.

[Even Jackett says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

Using the all endpoint has no advantages (besides reduced management overhead), only disadvantages:

- you lose control over indexer specific settings (categories, search modes, etc.)
- mixing search modes (IMDB, query, etc.) might cause low-quality results
- indexer specific categories (\>= 100000) cannot be used.
- slow indexers will slow down the overall result
- total results are limited to 1000

Adding each indexer separately It allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In , each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you’re more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error,  will disable it and now you don’t get any results.

##### Problem Not Listed

Please discuss with the support team on discord. If this is something that may be a common problem, please suggest adding it to the wiki.

#### Errors

These are some of the common errors you may see when adding an indexer

##### The underlying connection was closed: An unexpected error occurred on a send

This is caused by the indexer using a SSL protocol not supported by .net 4.5, to resolve this you will need to install .net 4.5, which is available on Vista/Server 2008 and above (if you’re on XP/Server 2003 its time to upgrade).

##### The request timed out

 seems to have issues with certain TLS versions or configurations. If you get the following error messages in your log:

```none
    System.Net.WebException: The request timed out: ’https://example.org/api?t=caps&apikey=(removed) —> System.Net.WebException: The request timed out
```

And you can see the following in the trace log file:

```none
    <DATE&TIME>|Trace|FallbackHttpDispatcher|Curl not available, using default WebClient. 
```

You might fix it by installing libcurl3. On Ubuntu/Debian use;

```shell
    `sudo apt install libcurl3`
```

This can also be caused by:

- improperly configured or use of a VPN
- improperly configured or use of a proxy
- local DNS issues
- local IPv6 issues
