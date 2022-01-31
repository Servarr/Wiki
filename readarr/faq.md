---
title: Readarr FAQ
description: 
published: true
date: 2022-01-31T18:09:51.908Z
tags: readarr, needs-love, troubleshooting, faq
editor: markdown
dateCreated: 2021-05-25T20:01:09.320Z
---

## How does Readarr work?

- Readarr relies on RSS feeds to automate grabbing of releases as they are posted, for both new releases as well as previously released releases being released or re-released. The RSS feed is the latest releases from a site, typically between 50 and 100 releases, though some sites provide more and some less. The RSS feed is comprised of all releases recently available, including releases for requested media you do not follow, if you look at debug logs you will see these releases being processed, which is completely normal.
- Readarr enforces a minimum of 10 minutes on the RSS Sync interval and a maximum of 2 hours. 15 minutes is the minimum recommended by most indexers, though some do allow lower intervals and 2 hours ensures Readarr is checking frequently enough to not miss a release (even though it can page through the RSS feed on many indexers to help with that). Some indexers allow clients to perform an RSS sync more frequently than 10 minutes, in those scenarios we recommend using Readarr's Release-Push API endpoint along with an IRC announce channel to push releases to Readarr for processing which can happen in near real time and with less overhead on the indexer and Readarr as Readarr doesn’t need to request the RSS feed too frequently and process the same releases over and over.

## How does Readarr find books?

- Readarr does ''not'' regularly search for book files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for ''all'' the newly posted books, then compares that with its list of books that are missing or need to be upgraded. Any matches are downloaded. This lets Readarr cover a library of ''any size'' with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the ''future'' though.
- So how do you deal with the present and past? When you're adding a book, you will need to set the correct path, profile and monitoring status then use the Start search for missing book checkbox. If the book hasn't been released yet, you do not need to initiate a search.
- Put another way, Readarr will only find books that are newly uploaded to your indexers. It will not actively try to find books you want that were uploaded in the past.
- If you've already added the book, but now you want to search for it, you have a few choices. You can go to the book's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see ''all'' the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Readarr has been offline for an extended period of time, Readarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Readarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed books.

## How are possible downloads compared?

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. [See TRaSH's Guide](https://trash-guides.info/merge-quality)***
{.is-info}

- The current logic [can be found here](https://github.com/Readarr/Readarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).

- As of 2022-01-23 the logic is as follows:

1. Quality
1. Preferred Word Score
1. Protocol
1. Indexer Priority
1. Seeds/Peers (If Torrent)
1. Book Count
1. Age (If Usenet)
1. Size

## What are Lists and what can they do for me?

- Lists are a part of Readarr that allow you to follow a given list creator.
- Let's say that you follow a given list creator on Trakt/TMDb and really like their Marvel Cinematic Universe film section and want to watch every book on their list. You look in your Readarr and realize that you do not have those books. Well instead of searching one by one and adding those lists and then searching your indexers for those books. You can do this all at once with a List. The Lists can be set to import all the books on that curators list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that book.
- `CAUTION:` If lists are done improperly they will absolutely wreck your library with a bunch of trash you have no intention of watching. So make sure of what you're importing before you click save.
- ie. physically look at the list before you even go to Readarr.

## Why can I not add a new book or author to Readarr?

- Readarr uses [GoodReads](http://goodreads.com) for book and author information and images like cover and author art, banners and backgrounds. Generally, there are a few reasons why you may not be able to add a book:
- GoodReads doesn't like special characters to be used when searching for books through the API (which Readarr uses), so try searching a translated name, and/or without special characters.
- You can also add books and authors by GoodReads ID, ISBN ID, or ASIN ID.
- The book has an issue with GoodReads API data. Unfortunately this is something we probably cannot solve for you.
- The book falls below the settings you've chosen (votes, pages, etc.) to appear in Readarr.

## Metadata Profile "None" allowing Foreign Releases

- Using a metadata profile of `None` is useful to only have books explicitly added by the user in Readarr. However, the downside of this is that it opens you up to every edition - including foreign editions - of a book to be available.
- To work around this issue  create a new Metadata Profile with [the popularity threshold described on the settings page](/readarr/settings#metadata-profiles)

## Book Match is not Close Enough: XX% vs YY% \[book\]

- Readarr has a hardcoded minimum percent match threshold when comparing the to-be-imported file against the book and author. Matches below this threshold will need to be manually imported.
- This is not user configurable.
- Currently this is 80% [1-_bookThreshold](https://github.com/Readarr/Readarr/blob/develop/src/NzbDrone.Core/MediaFiles/BookImport/Specifications/CloseAlbumMatchSpecification.cs#L11)
- The development team is considering lowering this to somewhere in the 70%s. If you have false negative matches between 70% and 80% please share them with us on discord.

## How can I rename my author folders?

{#rename-folders}

1. Library
1. Mass Editor
1. Select what authors need their folder renamed
1. Change Root Folder to the same Root Folder that the authors currently exist in
1. Select "Yes move files"

## How can I mass delete authors from the wanted list?

- Use Mass Editor => Select authors you want to delete => Delete

## Why doesn't Readarr work behind a reverse proxy

- Readarr uses .NET Core and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Readarr:

```none
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;
```

- Make sure you `do not` include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. `THIS WILL NOT WORK`
- [See this ASP.NET Core issue](https://github.com/aspnet/AspNetCore/issues/17081)
- If you are using a CDN like Cloudflare ensure websockets are enabled to allow websocket connections.

## How do I update Readarr?

{#how-do-I-update-my-readarr}

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `develop` or `nightly`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/readarr/release/VERSION.json) -    (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch. **Readarr does not yet have a stable release.**

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/readarr/testing/VERSION.json) -  (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first. **Readarr does not yet have a beta release.**

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/readarr/nightly/VERSION.json) -  (Alpha/Unstable): The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:testing`, `:develop`, or `:nightly` to the end of your container tag depending on who makes your builds.

|                                               | `master` (stable)     | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/readarr/testing/VERSION.json) | `nightly` (unstable) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/readarr/nightly/VERSION.json) |
| --------------------------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [hotio](https://hotio.dev/containers/readarr) | no stable release yet | no beta release yet                                                                                                                                                                                                  | `nightly`                                                                                                                                                                                                                 |

## Can I update Readarr inside my Docker container?

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
- Failure to follow these instructions may result in your Readarr becoming unusable or throwing errors. You have been warned.
- The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.

## I am getting an error: Database disk image is malformed

- This means your SQLite database that stores most of the information for Readarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modifed your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backup-and-restore-readarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## How does Readarr handle foreign books or foreign titles?

- Readarr uses both Alt Titles and Translations for parsing and searching. Search will use the Original Title, English Title, and Translated Title from whatever languages you have preferred (in profile and CFs). Parsing should look for a match in all Translations and Alt Titles.

- To get a book in a foreign language set your Profile Language to Original (Book's Original Language), a specific language for that profile, or any and use custom formats to determine which language to grab.
- Note that this does not include any indexer languages specified as multi.

## Help, Book Added, But Not Searched

- Neither Readarr *actively* search for missing books automatically. Instead, a periodic query of new posts is made to all indexers configured for RSS. When a wanted or cutoff unmet book shows up in that list, it gets downloaded. This means that until a book is posted (or reposted), it won’t get downloaded.
- If you’re adding an author with books that you want now, the best option is to check the “Start search for missing books” box, to the left of the *Add Author* button. You can also go to the page for an author you’ve added and click the magnifying glass *Search* button next to the book you want, or use the Wanted view to search for Missing or Cutoff Unmet books.

## Root path for authors imported from lists becomes “C:” or other weird paths

- Sometimes you can get a problem that authors that are imported from your lists, gets imported with the root path set to “C:” or other weird paths.

- This is a known issue for when the root path is either not setup during the creation of the list, or if the root path has been deleted after the list was created. Note that this problem can still occur even if the list is `edited` and the correct root path is set.

- Use the Mass Editor to fix paths of existing authors.

## Book Imported, But Source File And Torrent Not Deleted

- Check if you have Completed Download Handling - Remove turned on. (This does not work if you are using rtorrent.)

- If you are using deluge make sure auto-managed is turned on. And that torrents get paused when they reach specified seeding quota.

## I am using a Pi and Raspbian and Readarr will not launch

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

You can trigger a list refresh manually, script it and trigger it via the API, or add the books directly to Readarr.

This change was due to not have our server get killed by people updating lists every 10 minutes.

## Can I disable the refresh books task

- No, nor should you through any SQL hackery. The refresh books task queries the upstream Servarr proxy and checks to see if the metadata for each book (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Readarr. If necessary, it will then update the applicable books.

- A common complaint is the Refresh task causes heavy I/O usage. One setting that can cause issues is "Rescan Author Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`. Do not change this to `Never` unless all changes to your library (new books, upgrades, deletions etc) are done through Readarr. If you delete book files manually or a third party program, do not set this to `Never`.

## Can I have BOTH an ebook and an audiobook version of the same book?

- No. With a single Readarr instance, you can have either one or the other, but not both. If you want both, you would need to run two separate instances of Readarr (much like some people run 2 instances of Sonarr or Radarr for 1080p and 4K versions of their media).

## Do I need to use Calibre?

- No. In general Calibre offers some further enhancement, such as the ability to auto-convert ebooks to another format specific to your e-reader's capabilities, and also to connect to that e-reader. But if you weren't running Calibre prior to installing Readarr, then it's probably going to be of limited added benefit to you to install it, and it's a very large program.

## Why can Readarr not see my files on a remote server?

- In short: the user is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is,  is running as a service, which causes one of two things:

### Readarr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Readarr service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Readarr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.
- Run Readarr.exe using the Startup Folder

### You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Readarr.exe via the Startup Folder

## Help I have locked myself out

{#help-i-have-forgotten-my-password}

To disable authentication (to reset your username or password) you will need need to edit `config.xml` which will be inside the [Readarr Appdata Directory](/readarr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Readarr
1. Readarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` => `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Readarr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Readarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](/useful-tools#clearing-cookies-and-local-storage) wiki article.

## VPNs, Jackett, and the \*ARRs

- Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

- In other words, putting the  \*Arrs (Lidarr, Prowlarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of arr servers (updates, metadata, etc.) and liable to block you too**

- In addition, some private trackers **ban** for browsing from a VPN, which is how Jackett and Prowlarr work. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Jackett behind the VPN. However, you should not do that if you have private trackers without checking their rules first. **Many private trackers will ban you for using or accessing them (i.e. using Jackett or Prowlarr) via a VPN.**

## Jackett's /all Endpoint

{#jackett-all-endpoint}

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is strongly recommended. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)

- **January 20 2022 Update: Jackett `/all` endpoint is no longer supported (e.g. warnings will occur) as of 0.1.0.1188 due to the fact it only causes issues.**

- [Even Jackett says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

- Using the `/all` endpoint has no advantages (besides reduced management overhead), only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000

- Note that using NZBHydra2 as a single aggregate entry has the same issues as Jackett's `/all`

- Add each indexer separately. This allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In \*Arr, each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you're more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error, \*Arr will disable it and now you do not get any results.

## Why are there two files? | Why is there a file left in downloads?

This is expected. Below is how the Torrent Process works.

1. Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Readarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Readarr's settings, Readarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped.

> Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file. {.is-info}

## Calibre is saying "Calibre rejected duplicate book" but it's not

If you're using Calibre integration, Calibre is occasionally going to reject a book, saying it's a duplicate. It's probably not actually a duplicate. If this happens, there's not much Readarr can do, and you will need to unmonitor that book to prevent Readarr from continuing to try to grab it and push it to Calibre. This is just one of the fun downsides to Calibre integration.
