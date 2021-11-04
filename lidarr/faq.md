---
title: Lidarr FAQ
description: 
published: true
date: 2021-08-15T01:21:13.041Z
tags: lidarr, needs-love, faq
editor: markdown
dateCreated: 2021-06-14T14:33:41.344Z
---

## How does Lidarr work?

- Lidarr relies on RSS feeds to automate grabbing of releases as they are posted, for both new releases as well as previously released releases being released or re-released. The RSS feed is the latest releases from a site, typically between 50 and 100 releases, though some sites provide more and some less. The RSS feed is comprised of all releases recently available, including releases for requested media you do not follow, if you look at debug logs you will see these releases being processed, which is completely normal.
- Lidarr enforces a minimum of 10 minutes on the RSS Sync interval and a maximum of 2 hours. 15 minutes is the minimum recommended by most indexers, though some do allow lower intervals and 2 hours ensures Lidarr is checking frequently enough to not miss a release (even though it can page through the RSS feed on many indexers to help with that). Some indexers allow clients to perform an RSS sync more frequently than 10 minutes, in those scenarios we recommend using Lidarr's Release-Push API endpoint along with an IRC announce channel to push releases to Lidarr for processing which can happen in near real time and with less overhead on the indexer and Lidarr as Lidarr doesn’t need to request the RSS feed too frequently and process the same releases over and over.

## How does Lidarr find releases?

- Lidarr does ''not'' regularly search for book files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for ''all'' the newly posted releases, then compares that with its list of releases that are missing or need to be upgraded. Any matches are downloaded. This lets Lidarr cover a library of ''any size'' with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the ''future'' though.
- So how do you deal with the present and past? When you're adding a book, you will need to set the correct path, profile and monitoring status then use the Start search for missing book checkbox. If the book hasn't been released yet, you do not need to initiate a search.
- Put another way, Lidarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases you want that were uploaded in the past.
- If you've already added the book, but now you want to search for it, you have a few choices. You can go to the book's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see ''all'' the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Lidarr has been offline for an extended period of time, Lidarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Lidarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed releases.

## How are possible downloads compared?

***Generally Quality Trumps All***

The current logic [can be found here](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).

As of 2021-06-09 the logic is as follows:

1. Quality
1. Preferred Word Score
1. Protocol
1. Indexer Priority
1. Seeds/Peers (If Torrent)
1. Album Count
1. Age (If Usenet)
1. Size

## Why can I not add a new release or artist to Lidarr?

- The release is likely `unknown` type on MusicBrainz

## Why can I not add a various artists album?

- Various Artists and other meta artists on Musicbrainz are due to the number of entries they provide.

## Why does Lidarr only show studio albums, How do I find singles or EPs?

- Lidarr defaults to only bringing in studio albums for each artist. However, you can expand the album types per an artist, or for your entire library by utilizing Metadata Profiles.

## Can I add just an album?

- Not at the moment.

## Can I download single tracks?

- Lidarr works by searching for and downloading full releases, therefore individual tracks cannot be downloaded unless they were released as a single by the artist.

## Why doesn't artist X show up in search?

- Search is still a work in progress. Artists that do not show up in search may be added by searching for `lidarr:mbid` where `mbid` is the Musicbrainz ID of the artist.

## Lidarr matched an album with too many tracks. How can I change the Album to the correct Release?

- Open the Album details page and select the Edit Icon in the top nav. There you can find a dropdown of all releases tied to that Album.

## I cannot find a release in Lidarr but it is on MusicBrainz

- This is likely due to the release having an `unknown` release status.  Update MusicBrainz.

## How often do Lidarr's and MusicBrainz databases sync?

- Every hour at 5 after the hour

## How can I add missing artist images?

- Add art to fanart.tv and wait ~7+ days for it to clear through the cache. Then refresh the metadata.

## How can I get missing album images? (Cover Art)

- Add coverart to musicbrainz and wait ~1hr+ for it to clear through the cache. Then refresh the metadata.

## I'm having trouble importing my artists, what could it be?

- The artist import process just imports the Artist names and path locations, which are then stored in the database so that a) metadata can be retrieved and b) downloaded content can be put in the same location in future.  To this end, the user account that Lidarr runs under needs both read and write to your data directory.

## How can I rename my artist folders?

- Library
- Mass Editor
- Select what artists need their folder renamed
- Change Root Folder to the same Root Folder that the artists currently exist in
- Select "Yes move files"

## How can I mass delete artists from the wanted list?

- Use Mass Editor => Select artists you want to delete => Delete

## Why doesn't Lidarr work behind a reverse proxy

- Lidarr uses .NET Core and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Lidarr:
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;

- Make sure you `do not` include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. `THIS WILL NOT WORK`
- [See this ASP.NET Core issue](https://github.com/aspnet/AspNetCore/issues/17081)
- If you are using a CDN like Cloudflare ensure websockets are enabled to allow websocket connections.

## How do I update Lidarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `master` or `develop`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/lidarr/release/VERSION.json) -    (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch.

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/lidarr/testing/VERSION.json) -  (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/lidarr/nightly/VERSION.json) -  (Alpha/Unstable): The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:testing` or `:develop` if needed to the end of your container tag depending on who makes your builds.

| |`master` (stable) ![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/lidarr/release/VERSION.json)|`develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/lidarr/testing/VERSION.json)|
|---|---|---|
|[hotio](https://hotio.dev/containers/lidarr)|`hotio/lidarr:release`|`hotio/lidarr:testing`|
|[LinuxServer.io](https://docs.linuxserver.io/images/docker-lidarr)|`lscr.io/linuxserver/lidarr:latest`|`lscr.io/linuxserver/lidarr:develop`|

## Can I update Lidarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

If Native:

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

If Docker:

1. Repull your tag and update your container

## Can I switch from `nightly` back to `develop`?

- See the entry below

## Can I switch between branches?

> You can (almost) always increase your risk.{.is-info}

- `master` can go to `develop` or `nightly`
- `develop` can go to `nightly`
- Check with the development team to see if you can switch from `nightly` to `master`; `nightly` to `develop`; or `develop` to `master` for your given build.
- Failure to follow these instructions may result in your Lidarr becoming unusable or throwing errors. You have been warned.
- The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.

## I am getting an error: Database disk image is malformed

- This means your SQLite database that stores most of the information for Lidarr is corrupt.
- Try the [sqlite3 `.recover` command](https://www.sqlite.org/cli.html#recover_data_from_a_corrupted_database)
- If your sqlite does not have `.recover` or you wish a more GUI friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db)
- [Try restoring from a backup](#how-do-i-backup-and-restore-lidarr)

- This error may show if the database file is not writable by the user/group Lidarr is running as.

- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). Simple answer to this is to not do this as SQLite and network drives not typically play nice together and will cause a malformed database eventually. The config folder must be on a local drive**. If you're trying to restore your database you can check out our Backup/Restore guide [here](#how-do-i-backup-and-restore-lidarr).

- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use Lidarr on a Mac and it suddenly stopped working. What happened?

- Most likely this is due to a MacOS bug which caused one of the databases to be corrupted.

- See the above database is malformed entry.

- Then attempt to launch and see if it works. If it does not work, you will need further support. Post in our [subreddit /r/lidarr](http://reddit.com/r/lidarr) or hop on [our discord](https://lidarr.audio/discord) for help.

## I am using a Pi and Raspbian and Lidarr will not launch

Raspbian has a version of libseccomp2 that is too old to support running a docker container based on Ubuntu 20.04, which both hotio and LinuxServer use as their base. You either need to use `--privileged`, update libseccomp2 from Ubuntu or get a better OS (We recommend Ubuntu 20.04 arm64)

**Possible Solution:**

Managed to fix the issue by installing the backport from debian repo. Generally not recommended to use backport in blanket upgrade mode. Installation of a single package may be ok but may also cause issues. So got to understand what you are doing.

Steps to fix:

First ensure you are running Raspbian buster e.g using `lsb_release -a`

> Distributor ID: Raspbian
> Description: Raspbian GNU/Linux 10 (buster)
> Release: 10
> Codename: buster

- If you are using buster:
  - Run the following to add the backports to your sources

  ```shell
   echo "deb <http://deb.debian.org/debian> buster-backports main" | sudo tee /etc/apt/sources.list.d/buster-backports.list
   ```

  - Install the backport of libseccomp2

  ```shell
  sudo apt update && sudo apt-get -t buster-backports install libseccomp2
  ```

## Why are lists sync times so long and can I change it?

Lists never were nor are intended to be `add it now` they are `hey I want this, add it eventually` tools.

You can trigger a list refresh manually, script it and trigger it via the API, or add the releases directly to Lidarr.

This change was due to not have our server get killed by people updating lists every 10 minutes.

## Can I disable the refresh releases task

No, nor should you through any SQL hackery.  The refresh releases task queries the upstream Servarr proxy and checks to see if the metadata for each release (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Lidarr. If necessary, it will then update the applicable releases.

A common complaint is the Refresh task causes heavy I/O usage.  One setting that can cause issues is "Rescan Author Folder after Refresh".  If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`.  Do not change this to `Never` unless all changes to your library (new releases, upgrades, deletions etc) are done through Lidarr.  If you delete release files manually or a third party program, do not set this to `Never`.

## Why can Lidarr not see my files on a remote server?

- In short: the user is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is,  is running as a service, which causes one of two things:

### Lidarr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Lidarr's service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Lidarr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.
- Run Lidarr.exe using the Startup Folder

### You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Lidarr.exe via the Startup Folder

## Help I have locked myself out

{#help-i-have-forgotten-my-password}

To disable authentication (to reset your username or password) you will need need to edit `config.xml` which will be inside the [Lidarr Appdata Directory](/lidarr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Lidarr
1. Lidarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` => `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Lidarr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Lidarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](/useful-tools#clearing-cookies-and-local-storage) wiki article.

## VPNs, Jackett, and the \*ARRs

- Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

- In other words, putting the  \*Arrs (Lidarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of arr servers (updates, metadata, etc.) and liable to block you too**

- In addition, some private trackers **ban** for browsing from a VPN, which is how Jackett works. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Jackett behind the VPN. However, you should not do that if you have private trackers without checking their rules first. **Many private trackers will ban you for using or accessing them (i.e. using Jackett) via a VPN.**

## Jackett's /all Endpoint

{#jackett-all-endpoint}

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is recommended.

- **May 2021 Update: It is likely \*Arr support will be phased out for the jackett `/all` endpoint in the future due to the fact it only causes issues.**

- [Even Jackett says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

- Using the `/all` endpoint has no advantages (besides reduced management overhead), only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000

- Note that using NZBHydra2 as a single aggregate entry has the same issues as Jackett's `/all`

- Add each indexer seperatedly. This allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In \*Arr, each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you're more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error, \*Arr will disable it and now you do not get any results.

## Why are there two files? | Why is there a file left in downloads?

This is expected. Below is how the Torrent Process works.

1. Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Lidarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Lidarr's settings, Lidarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped.

> Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file. {.is-info}
