---
title: Readarr FAQ
description: 
published: true
date: 2023-10-13T11:38:49.564Z
tags: readarr, needs-love, troubleshooting, faq
editor: markdown
dateCreated: 2021-05-25T20:01:09.320Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
  - [How does Readarr work?](#how-does-readarr-work)
  - [Forced Authentication](#forced-authentication)
  - [How does Readarr find books?](#how-does-readarr-find-books)
  - [How are possible downloads compared?](#how-are-possible-downloads-compared)
  - [Error of a task was canceled](#a-task-was-canceled)
  - [What are Lists and what can they do for me?](#what-are-lists-and-what-can-they-do-for-me)
  - [Why are lists sync times so long and can I change it?](#why-are-lists-sync-times-so-long-and-can-i-change-it)
  - [Why can I not add a new book or author to Readarr?](#why-can-i-not-add-a-new-book-or-author-to-readarr)
  - [Metadata Profile "None" allowing Foreign Releases](#metadata-profile-none-allowing-foreign-releases)
  - [Book Match is not Close Enough: XX% vs YY% \[book\]](#book-match-is-not-close-enough-xx-vs-yy-book)
  - [How can I rename my author folders?](#how-can-i-rename-my-author-folders)
  - [How can I mass delete authors from the wanted list?](#how-can-i-mass-delete-authors-from-the-wanted-list)
  - [Why doesn't Readarr work behind a reverse proxy](#why-doesnt-readarr-work-behind-a-reverse-proxy)
  - [How do I update Readarr?](#how-do-i-update-readarr)
    - [Can I update Readarr inside my Docker container?](#can-i-update-readarr-inside-my-docker-container)
    - [Installing a newer version](#installing-a-newer-version)
      - [Native](#native)
      - [Docker](#docker)
  - [Can I switch from `nightly` back to `develop`?](#can-i-switch-from-nightly-back-to-develop)
  - [Can I switch between branches?](#can-i-switch-between-branches)
  - [I am getting an error: Database disk image is malformed](#i-am-getting-an-error-database-disk-image-is-malformed)
  - [How do I Backup/Restore my Readarr?](#how-do-i-backuprestore-my-readarr)
    - [Backing up Readarr](#backing-up-readarr)
      - [Using built-in backup](#using-built-in-backup)
      - [Using file system directly](#using-file-system-directly)
    - [Restoring from Backup](#restoring-from-backup)
      - [Using zip backup](#using-zip-backup)
      - [Using file system backup](#using-file-system-backup)
      - [File System Restore on Synology NAS](#file-system-restore-on-synology-nas)
  - [Help, Book Added, But Not Searched](#help-book-added-but-not-searched)
  - [Root path for authors imported from lists becomes “C:” or other weird paths](#root-path-for-authors-imported-from-lists-becomes-c-or-other-weird-paths)
  - [Book Imported, But Source File And Torrent Not Deleted](#book-imported-but-source-file-and-torrent-not-deleted)
  - [Can I disable the refresh books task](#can-i-disable-the-refresh-books-task)
  - [Can I have BOTH an ebook and an audiobook version of the same book?](#can-i-have-both-an-ebook-and-an-audiobook-version-of-the-same-book)
  - [Do I need to use Calibre?](#do-i-need-to-use-calibre)
  - [Why can Readarr not see my files on a remote server?](#why-can-readarr-not-see-my-files-on-a-remote-server)
    - [Readarr runs under the LocalService account by default which doesn't have access to protected remote file shares](#readarr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares)
    - [You're using a mapped network drive (not a UNC path)](#youre-using-a-mapped-network-drive-not-a-unc-path)
  - [Help I have locked myself out](#help-i-have-locked-myself-out)
  - [How do I stop the browser from launching on startup?](#how-do-i-stop-the-browser-from-launching-on-startup)
  - [Weird UI Issues](#weird-ui-issues)
  - [VPNs, Jackett, and the \*ARRs](#vpns-jackett-and-the-arrs)
  - [Jackett's /all Endpoint](#jacketts-all-endpoint)
    - [Jackett /All Solutions](#jackett-all-solutions)
  - [Why are there two files? | Why is there a file left in downloads?](#why-are-there-two-files-why-is-there-a-file-left-in-downloads)
  - [Calibre is saying "Calibre rejected duplicate book" but it's not](#calibre-is-saying-calibre-rejected-duplicate-book-but-its-not)

## How does Readarr work?

- Readarr does *not* regularly search for book files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted books, then compares that with its list of books that are missing or need to be upgraded. Any matches are downloaded. This lets Readarr cover a library of *any size* with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a book/author, you will need to set the correct path, profile and monitoring status then use the Start search for missing book checkbox. If the book hasn't been released yet, you do not need to initiate a search.
- Put another way, Readarr will only find books that are newly uploaded to your indexers. It will not actively try to find books you want that were uploaded in the past.
- If you've already added the book, but now you want to search for it, you have a few choices. You can go to the author's page and use the search button next to the book, which will do a search and then automatically pick one. You can use the Search tab and see *all* the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Readarr has been offline for an extended period of time, Readarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Readarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed books.

## Forced Authentication

If Readarr is exposed so that the UI can be accessed from outside your local network then you should have some form of authentication method enabled in order to access the UI. This is also increasingly required by Trackers and Indexers.

As of Readarr v1, Authentication is Mandatory.

### Authentication Method

- `Basic` (Browser pop-up) - This option when accessing your Readarr will show a small pop-up allowing you to input a Username and Password
- `Forms` (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Readarr
- `External` - Configurable via Config File Only
  - If you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](/readarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost value will be used**

### Authentication Required

- If you do not expose the app externally and/or do not wish to have auth required for local (e.g. LAN) access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`

## How does Readarr find books?

> This FAQ item is a legacy FAQ Entry. Refer to [How does Readarr work?](#how-does-readarr-work)
{.is-info}

## How are possible downloads compared?

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. [See TRaSH's Guide](https://trash-guides.info/merge-quality)***
{.is-info}

- The current logic [can be found here](https://github.com/Readarr/Readarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).

- As of 2022-01-23 the logic is as follows:

1. Quality
1. Preferred Word Score
1. Protocol (as configured in the relevant Delay Profile)
1. Indexer Priority
1. Seeds/Peers (If Torrent)
1. Book Count
1. Age (If Usenet)
1. Size

## A Task was Canceled

- Readarr received no response from the server the request was made to after 100 seconds.
- This is often caused by:
  - improperly configured or use of a VPN
  - improperly configured or use of a proxy
  - local DNS issues
  - local IPv6 issues - *most common* - typically IPv6 is enabled on the host system, but non-functional
  - the use of Privoxy and it being improperly configured
  - PiHole [Rate Limiting](https://docs.pi-hole.net/ftldns/configfile/#rate_limit) requests

## What are Lists and what can they do for me?

- Lists are a part of Readarr that allow you to follow a given list creator.
- Let's say that you follow a given list creator on GoodReads and really like their collection of Great Books and want to add every book on their list. You look in your Readarr and realize that you do not have those books. Well instead of searching one by one and adding those lists and then searching your indexers for those books. You can do this all at once with a List. The Lists can be set to import all the books on that curators list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that book.

>`CAUTION:` If lists are done improperly they will absolutely wreck your library with a bunch of trash you have no intention of reading. So make sure of what you're importing before you click save.
{.is-warning}

- It is suggested that you read through the list before you import it into Readarr.

## Why are lists sync times so long and can I change it?

Lists never were nor are intended to be `add it now` they are `hey I want this, add it eventually` tools.

You can trigger a list refresh manually, script it and trigger it via the API, or add the books directly to Readarr. Lists will otherwise refresh every 24 hours.

This change was due to not have our server get killed by people updating lists every 10 minutes.

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

> The same process applies for moving/changing Author paths as well{.is-info}

1. Author
1. Author Editor
1. Select what authors need their folder renamed
1. Change Root Folder to the same Root Folder that the authors currently exist in
1. Select "Yes move files"

## How can I mass delete authors from the wanted list?

- Use Author Editor from the Author tab => Select authors you want to delete => Delete

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

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://readarr.servarr.com/v1/update/master/changes) -    (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch. 

> **Readarr does not yet have a stable release.**
{.is-danger}

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://readarr.servarr.com/v1/update/develop/changes) -  (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first after nightly. It can be considered semi-stable, but is still `beta`.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://readarr.servarr.com/v1/update/nightly/changes) -  (Alpha/Unstable): This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch.  ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:testing`, `:develop`, or `:nightly` to the end of your container tag depending on who makes your builds.

|                                                           | `master` (stable) ![Current Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://readarr.servarr.com/v1/update/master/changes) | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://readarr.servarr.com/v1/update/develop/changes) | `nightly` (unstable) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://readarr.servarr.com/v1/update/nightly/changes) |
| --------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [hotio](https://hotio.dev/containers/readarr)             | no stable release yet                                                                                                                                                                                           | `testing`                                                                                                                                                                                                            | `nightly`                                                                                                                                                                                                                 |
| [lsio](https://docs.linuxserver.io/images/docker-readarr) | no stable release yet                                                                                                                                                                                           | `develop`                                                                                                                                                                                                            | `nightly`                                                                                                                                                                                                                 |

### Can I update Readarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

#### Native

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

#### Docker

1. Repull your tag and update your container

## Can I switch from `nightly` back to `develop`?

## Can I switch between branches?

- If version is identical you can switch, otherwise check with the development team to see if you can switch from `nightly` to `master`; `nightly` to `develop`; or `develop` to `master` for your given build.
- Failure to follow these instructions may result in your Readarr becoming unusable or throwing errors. You have been warned
  - The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.

## I am getting an error: Database disk image is malformed

- **Errors of `Error creating log database` indicate issues with log.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with readarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Readarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backuprestore-my-readarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## How do I Backup/Restore my Readarr?

### Backing up Readarr

#### Using built-in backup

- Go to System => Backup in the Readarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### Using file system directly

- Find the location of the AppData directory for Readarr  
  - Via the Readarr UI go to System => About  
  - [Readarr Appdata Directory](/readarr/appdata-directory)
- Stop Readarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.
{.is-warning}

#### Using zip backup

- Re-install Readarr (if applicable / not already installed)
- Run Readarr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### Using file system backup

- Re-install Readarr (if applicable / not already installed)
- Find the location of the AppData directory for Readarr  
  - Running Readarr once and via the UI go to System => About  
  - [Readarr Appdata Directory](/readarr/appdata-directory)
- Stop Readarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Readarr
- As long as the paths are the same, everything will pick up where it left off

#### File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.
{.is-warning}

- Re-install Readarr (if applicable / not already installed)
- Find the location of the AppData directory for Readarr  
  - Running Readarr once and via the UI go to System => About  
  - [Readarr Appdata Directory](/readarr/appdata-directory)
- Stop Readarr
- Connect to the Synology NAS through SSH and log in as root  

> On some installations, the user is different than the below commands: `chown -R sc-Readarr:Readarr *`
{.is-info}

- Execute the following commands:

```shell
rm -r /usr/local/Readarr/var/.config/Readarr/Readarr.db
cp -f /tmp/Readarr_backup/* /usr/local/Readarr/var/.config/Readarr/
```

- Update permissions on the files:

 ```shell
cd /usr/local/Readarr/var/.config/Readarr/
chown -R Readarr:users *
chmod -R 0644 *
```

- Start Readarr

## Help, Book Added, But Not Searched

- Readarr does not *actively* search for missing books automatically. Instead, a periodic query of new posts is made to all indexers configured for RSS. When a wanted or cutoff unmet book shows up in that list, it gets downloaded. This means that until a book is posted (or reposted), it won’t get downloaded.
- If you’re adding an author with books that you want now, the best option is to check the “Start search for missing books” box, to the left of the *Add Author* button. You can also go to the page for an author you’ve added and click the magnifying glass *Search* button next to the book you want, or use the Wanted view to search for Missing or Cutoff Unmet books.

## Root path for authors imported from lists becomes “C:” or other weird paths

- Sometimes you can get a problem that authors that are imported from your lists, gets imported with the root path set to “C:” or other weird paths.
- This is a known issue for when the root path is either not setup during the creation of the list, or if the root path has been deleted after the list was created. Note that this problem can still occur even if the list is `edited` and the correct root path is set.
- Use the Mass Editor to fix paths of existing authors.

## Book Imported, But Source File And Torrent Not Deleted

- Check if you have Completed Download Handling - Remove turned on.
- If you are using deluge make sure auto-managed is turned on. And that torrents get paused when they reach specified seeding quota.

## Can I disable the refresh books task

- No, nor should you through any SQL hackery. The refresh books task queries the upstream Servarr proxy and checks to see if the metadata for each book (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Readarr. If necessary, it will then update the applicable books.
- A common complaint is the Refresh task causes heavy I/O usage. One setting that can cause issues is "Rescan Author Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`. Do not change this to `Never` unless all changes to your library (new books, upgrades, deletions etc) are done through Readarr. If you delete book files manually or a third party program, do not set this to `Never`.

## Can I have BOTH an ebook and an audiobook version of the same book?

- No. With a single Readarr instance, you can have either one or the other, but not both. If you want both, you would need to run two separate instances of Readarr (much like some people run 2 instances of Sonarr or Radarr for 1080p and 4K versions of their media).

## Do I need to use Calibre?

- No. In general Calibre offers some further enhancement, such as the ability to auto-convert ebooks to another format specific to your e-reader's capabilities, and also to connect to that e-reader. But if you weren't running Calibre prior to installing Readarr, then it's probably going to be of limited added benefit to you to install it, and it's a very large program.

## Why can Readarr not see my files on a remote server?

- For all OSes ensure the user/group you're running \*Arr as has read and write access to the mounted drive.
- For Linux ensure:
  - If you're using an NFS mount ensure nolock is enabled for your mount.
  - If you're using an SMB mount ensure nobrl is enabled for your mount.
- For Windows: In short: the user \*Arr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is \*Arr  is running as a service, which causes the issues described below.

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

To disable authentication (to reset your forgotten username or password) you will need need to edit `config.xml` which will be inside the [Readarr Appdata Directory](/readarr/appdata-directory)

1. Close Readarr
1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
*(Be sure that you do not have two AuthenticationMethod entries in your file)*
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
- In other words, putting the  \*Arrs (Lidarr, Prowlarr, Radarr, Readarr, and Lidarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible.

> **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of \*Arr servers (updates, metadata, etc.) and liable to block you too**
{.is-warning}

- **Many private trackers will ban you for using or accessing them (i.e. using Jackett or Prowlarr) via a VPN.**

### Use of a VPN

- If a VPN is required and Docker is used it is recommended to use Hotio or Binhex's Download Client + VPN Containers.
- If a VPN is required and Docker is not used your VPN client ***must*** support split tunneling so only the required (Download Client) apps are behind the VPN.
- Many issues with accessing trackers can be resolved by using Google or Cloudflare's DNS servers in lieu of your ISP's DNS servers.
- In some cases (i.e. UK ISPs) you may need to put your torrent download client behind a VPN and Jackett/Prowlarr as follows:
  - put Jackett behind the VPN and ensure split tunneling allows local access
  - for Prowlarr configure your vpn client to provide a proxy and add the proxy in Settings => Indexers. Give the proxy a tag and any indexers that need to use it the same tag.
    - If absolutely required and if your vpn does not provide a way to create a proxy you may put Prowlarr behind the VPN and ensure split tunneling allows local access.

## Jackett's /all Endpoint

{#jackett-all-endpoint}

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)
- **January 20 2022 Update: Jackett `/all` endpoint is no longer supported (e.g. warnings will occur) as of 0.1.0.1188 due to the fact it only causes issues.**
- The Jackett /all endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is now required.
- [Even Jackett's Devs says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)
- Using the /all endpoint has no advantages, only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000
  - if one of the trackers in /all returns an error, \*Arr will disable it and now you do not get any results.

### Jackett /All Solutions

- Add each tracker in Jackett manually as an indexer in \*Arr
- Check out [Prowlarr](/prowlarr) which can sync indexers to \*Arr and from the Lidarr/Radarr/Readarr development team.
- Check out [NZBHydra2](https://github.com/theotherp/nzbhydra2) which can sync indexers to \*Arr. But do not use their single aggregate endpoint and use `multi` if sync will be used.

## Why are there two files? | Why is there a file left in downloads?

This is expected. With a setup that supports [hardlinks](https://trash-guides.info/hardlinks), double space will not be used. Below is how the Torrent Process works.

1. Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Readarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Readarr's settings, Readarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped.

> Hardlinks are enabled by default. [A hardlink will allow not use any additional disk space.](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/) The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file.
{.is-info}

## Calibre is saying "Calibre rejected duplicate book" but it's not

If you're using Calibre integration, Calibre is occasionally going to reject a book, saying it's a duplicate. It's probably not actually a duplicate. If this happens, there's not much Readarr can do, and you will need to unmonitor that book to prevent Readarr from continuing to try to grab it and push it to Calibre. This is just one of the fun downsides to Calibre integration.
