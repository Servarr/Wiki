---
title: Whisparr FAQ
description: Reorganized Whisparr FAQ
published: true
date: 2022-03-23T14:38:55.693Z
tags: whisparr, needs-love, troubleshooting, faq
editor: markdown
dateCreated: 2021-05-16T20:44:27.778Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Whisparr Basics](#whisparr-basics)
  - [How does Whisparr work?](#how-does-whisparr-work)
  - [How does Whisparr find movies?](#how-does-whisparr-find-movies)
  - [How do I access Whisparr from another computer?](#how-do-i-access-whisparr-from-another-computer)
  - [What is Minimum Availability?](#what-is-minimum-availability)
  - [How are possible downloads compared?](#how-are-possible-downloads-compared)
  - [What are Lists and what can they do for me?](#what-are-lists-and-what-can-they-do-for-me)
  - [Why are lists sync times so long and can I change it?](#why-are-lists-sync-times-so-long-and-can-i-change-it)
  - [Can all my movie files be stored in one folder?](#can-all-my-movie-files-be-stored-in-one-folder)
  - [Can I put all my movies in my library into one folder?](#can-i-put-all-my-movies-in-my-library-into-one-folder)
  - [How do I update Whisparr?](#how-do-i-update-whisparr)
  - [Can I update Whisparr inside my Docker container?](#can-i-update-whisparr-inside-my-docker-container)
    - [Installing a newer version](#installing-a-newer-version)
      - [Native](#native)
      - [Docker](#docker)
  - [Can I switch from `nightly` back to `develop`?](#can-i-switch-from-nightly-back-to-develop)
  - [Can I switch between branches?](#can-i-switch-between-branches)
  - [How do I Backup/Restore Whisparr?](#how-do-i-backuprestore-whisparr)
    - [Backing up Whisparr](#backing-up-whisparr)
      - [Using built-in backup](#using-built-in-backup)
      - [Using file system directly](#using-file-system-directly)
    - [Restoring from Backup](#restoring-from-backup)
      - [Using zip backup](#using-zip-backup)
      - [Using file system backup](#using-file-system-backup)
- [Whisparr Common Problems](#whisparr-common-problems)
  - [Path is Already Configured for an Existing Movie](#path-is-already-configured-for-an-existing-movie)
  - [How can I rename my movie folders?](#how-can-i-rename-my-movie-folders)
  - [Movie File and Folder Naming](#movie-file-and-folder-naming)
  - [Movie Folders Named Incorrectly](#movie-folders-named-incorrectly)
  - [Can I disable the refresh movies task](#can-i-disable-the-refresh-movies-task)
  - [How do I request a feature for Whisparr?](#how-do-i-request-a-feature-for-whisparr)
  - [Help, My Mac says Whisparr cannot be opened because the developer cannot be verified](#help-my-mac-says-whisparr-cannot-be-opened-because-the-developer-cannot-be-verified)
  - [Help, My Mac says Whisparr.app is damaged and can’t be opened](#help-my-mac-says-whisparrapp-is-damaged-and-cant-be-opened)
  - [I am getting an error: Database disk image is malformed](#i-am-getting-an-error-database-disk-image-is-malformed)
  - [I use Whisparr on a Mac and it suddenly stopped working. What happened?](#i-use-whisparr-on-a-mac-and-it-suddenly-stopped-working-what-happened)
  - [Why can Whisparr not see my files on a remote server?](#why-can-whisparr-not-see-my-files-on-a-remote-server)
    - [Whisparr runs under the LocalService account by default which doesn't have access to protected remote file shares](#whisparr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares)
    - [You're using a mapped network drive (not a UNC path)](#youre-using-a-mapped-network-drive-not-a-unc-path)
  - [How do I change from the Windows Service to a Tray App?](#how-do-i-change-from-the-windows-service-to-a-tray-app)
  - [Help I have locked myself out](#help-i-have-locked-myself-out)
  - [How do I stop the browser from launching on startup?](#how-do-i-stop-the-browser-from-launching-on-startup)
  - [Weird UI Issues](#weird-ui-issues)
  - [Web Interface Only Loads at localhost on Windows](#web-interface-only-loads-at-localhost-on-windows)
  - [Permissions](#permissions)
  - [System & Logs loads forever](#system--logs-loads-forever)
  - [Finding Cookies](#finding-cookies)
  - [Unpack Torrents](#unpack-torrents)
  - [uTorrent is no longer working](#utorrent-is-no-longer-working)
  - [I got a pop-up that said config.xml was corrupt, what now?](#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now)
  - [Invalid Certificate and other HTTPS or SSL issues](#invalid-certificate-and-other-https-or-ssl-issues)
  - [VPNs, Jackett, and the \*ARRs](#vpns-jackett-and-the-arrs)
- [Whisparr and Movie Issues + Metadata](#whisparr-and-movie-issues--metadata)
  - [Why can I not add a new movie to Whisparr?](#why-can-i-not-add-a-new-movie-to-whisparr)
- [Whisparr Searching & Downloading Common Problems](#whisparr-searching--downloading-common-problems)
  - [Jackett shows more results than when manually searching](#jackett-shows-more-results-than-when-manually-searching)
  - [How does Whisparr handle foreign movies or foreign titles?](#how-does-whisparr-handle-foreign-movies-or-foreign-titles)
  - [How does Whisparr handle "multi" in names?](#how-does-whisparr-handle-multi-in-names)
  - [Help, Movie Added, But Not Searched](#help-movie-added-but-not-searched)
  - [Jackett's /all Endpoint](#jacketts-all-endpoint)
  - [Why are there two files? | Why is there a file left in downloads?](#why-are-there-two-files--why-is-there-a-file-left-in-downloads)
  - [Why doesn't Whisparr work behind a reverse proxy](#why-doesnt-whisparr-work-behind-a-reverse-proxy)

# Whisparr Basics

## How does Whisparr work?

- Whisparr relies on RSS feeds to automate grabbing of releases as they are posted, for both new releases as well as previously released releases being released or re-released. The RSS feed is the latest releases from a site, typically between 50 and 100 releases, though some sites provide more and some less. The RSS feed is comprised of all releases recently available, including releases for requested media you do not follow, if you look at debug logs you will see these releases being processed, which is completely normal.
- Whisparr enforces a minimum of 10 minutes on the RSS Sync interval and a maximum of 2 hours. 15 minutes is the minimum recommended by most indexers, though some do allow lower intervals and 2 hours ensures Whisparr is checking frequently enough to not miss a release (even though it can page through the RSS feed on many indexers to help with that). Some indexers allow clients to perform an RSS sync more frequently than 10 minutes, in those scenarios we recommend using Whisparr's Release-Push API endpoint along with an IRC announce channel to push releases to Whisparr for processing which can happen in near real time and with less overhead on the indexer and Whisparr as Whisparr doesn’t need to request the RSS feed too frequently and process the same releases over and over.

## How does Whisparr find movies?

- Whisparr does *not* regularly search for movie files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted movies, then compares that with its list of movies that are missing or need to be upgraded. Any matches are downloaded. This lets Whisparr cover a library of *any size* with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a movie, you will need to set the correct path, profile and monitoring status then use the Start search for missing movie checkbox. If the movie hasn't been released yet, you do not need to initiate a search.
- Put another way, Whisparr will only find movies that are newly uploaded to your indexers. It will not actively try to find movies you want that were uploaded in the past.
- If you've already added the movie, but now you want to search for it, you have a few choices. You can go to the movie's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see *all* the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Whisparr has been offline for an extended period of time, Whisparr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Whisparr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed movies.

## How do I access Whisparr from another computer?

- By default Whisparr doesn't listen to requests from all systems (when not run as administrator), it will only listen on localhost, this is due to how the Web Server Whisparr uses integrates with Windows (this also applies for current alternatives). If Whisparr is run as an administrator it will correctly register itself with Windows as well as open the Firewall port so it can be accessed from other systems on your network. Running as admin only needs to happen once (if you change the port it will need to be re-run).

## What is Minimum Availability?

- **Announced**: Whisparr shall consider movies available as soon as they are added to Whisparr. This setting is recommended if you have good private trackers (or really good public ones, e.g. rarbg.to) that do not have fakes.
- **In Cinemas**: Whisparr shall consider movies available as soon as movies hit cinemas. This option is not recommended.
- **Released**: Whisparr shall consider movies available as soon as the Blu-Ray or streaming version is released. This option is recommended and likely should be combined with an Availability Delay of `-14` or `-21` days.

## How are possible downloads compared?

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. [See TRaSH's Guide](https://trash-guides.info/merge-quality)
{.is-info}

- The current logic [can always be found here](https://github.com/Whisparr/Whisparr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).

- As of 2022-01-23 the logic is as follows:

1. Quality\*
1. Custom Format Score
1. Protocol (as configured in the relevant Delay Profile)
1. Indexer Priority
1. Indexer Flags
1. Seeds/Peers (If Torrent)
1. Age (If Usenet)
1. Size

> \*REPACKS and PROPERs are v2 of Qualities and thus rank above a non-repack of the same quality. [Set Media Management => File Management `Download Proper & Repacks` "Do Not Prefer"](/whisparr/settings#file-management) and use the [Repack/Proper Custom Format](https://trash-guides.info/Whisparr/Whisparr-collection-of-custom-formats/#repack-proper).{.is-warning}

## What are Lists and what can they do for me?

- Lists are a part of Whisparr that allow you to follow a given list creator.

- Let's say that you follow a given list creator on Trakt/TMDb and really like their Marvel Cinematic Universe film section and want to watch every movie on their list. You look in your Whisparr and realize that you do not have those movies. Well instead of searching one by one and adding those lists and then searching your indexers for those movies. You can do this all at once with a List. The Lists can be set to import all the movies on that curators list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that movie.

> **CAUTION:** If done improperly lists can wreak havoc on your library by adding many movies you have no intention of watching. Make certain you are familiar with the list before you click save.
{.is-warning}

- It's suggested that physically look at the list before you even go to Whisparr.

## Why are lists sync times so long and can I change it?

- Lists never were nor are intended to be `add it now` they are `hey i want this, add it eventually` tools

- You can trigger a list refresh manually, script it and trigger it via the API, add the movies to Whisparr, use Ombi, Petio, Overseer, or any similar app that adds them right away

- This restriction is to not have our server get killed by people updating lists every 10 minutes.

- This interval can be configured in [Settings => Lists](/whisparr/settings#lists) for between 6-24 hours. The default is 24 hours.

## Can all my movie files be stored in one folder?

- No and the reason is that Whisparr is a fork of [Sonarr](/sonarr), where every show has a folder. This limitation is a known pain point for many users and will maybe come in a future version. Please note that it is not a simple change and effectively requires an entire rewrite of the backend.
- The [Custom Folder GitHub Issue](https://github.com/Whisparr/Whisparr/issues/153) technically covers this request, but it is no guarantee that all movie files in one folder will be implemented at that time.
- A slight hack-ish solution is described below. Please note that you mustn't trigger a rescan in Whisparr or it will show as missing and regardless the movie will never be upgraded.

  - Use a Custom Script
    - the script should be triggered on import
    - it should be designed to move the file whenever you want it
    - it then needs to call the Whisparr API and change the movie to unmonitored.
- If you're looking to moving all your movies from one folder to individual folders check out the [Tips and Tricks Section => Create a Folder for Each Movie](/whisparr/tips-and-tricks#creating-a-folder-for-each-movie) article

## Can I put all my movies in my library into one folder?

- No, see above.

## How do I update Whisparr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `master` or `develop`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/prowlarr/release/VERSION.json) -    (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch. **Prowlarr does not yet have a stable release.**

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/readarr/testing/VERSION.json) -  (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/whisparr/nightly/VERSION.json) - (Alpha/Unstable) : The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-danger}

- Note: If your install is through Docker append `:release`, `:latest`, `:testing`, or `:develop` to the end of your container tag depending on who makes your builds. Please note that `nightly` branches are intentionally not listed below.

|                                                                    | `master` (stable) ![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/whisparr/release/VERSION.json) | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/whisparr/testing/VERSION.json) | `nightly` (alpha) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/whisparr/nightly/VERSION.json) |
| ------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [hotio](https://hotio.dev/containers/whisparr)                       | `release`                                                                                                                                                                                                             | `testing`                                                                                                                                                                                                           | `nightly`                                                                                                                                                                                                             |
| [LinuxServer.io](https://docs.linuxserver.io/images/docker-whisparr) | `latest`                                                                                                                                                                                                              | `develop`                                                                                                                                                                                                           | `nightly`                                                                                                                                                                                                             |

## Can I update Whisparr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

#### Native

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

#### Docker

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

## How do I Backup/Restore Whisparr?

### Backing up Whisparr

#### Using built-in backup

- Go to System => Backup in the Whisparr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### Using file system directly

- Find the location of the AppData directory for Whisparr
  - Via the Whisparr UI go to System => About
  - [Whisparr Appdata Directory](/whisparr/appdata-directory)
- Stop Whisparr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.
{.is-warning}

#### Using zip backup

- Re-install Whisparr (if applicable / not already installed)
- Run Whisparr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### Using file system backup

- Re-install Whisparr (if applicable / not already installed)
- Find the location of the AppData directory for Whisparr
  - Running Whisparr once and via the UI go to System => About
  - [Whisparr Appdata Directory](/whisparr/appdata-directory)
- Stop Whisparr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Whisparr
- As long as the paths are the same, everything will pick up where it left off

- **Restore for Synology NAS**

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.
{.is-warning}

- Re-install Whisparr (if applicable / not already installed)
- Find the location of the AppData directory for Whisparr
  - Running Whisparr once and via the UI go to System => About
  - [Whisparr Appdata Directory](/whisparr/appdata-directory)
- Stop Whisparr
- Connect to the Synology NAS through SSH and log in as root

> On some installations, the user is different than the below commands: `chown -R sc-Whisparr:Whisparr *` {.is-info}

- Execute the following commands:

    ```shell
        rm -r /usr/local/Whisparr/var/.config/Whisparr/Whisparr.db
        cp -f /tmp/Whisparr_backup/* /usr/local/Whisparr/var/.config/Whisparr/
    ```

- Update permissions on the files:

    ```shell
        cd /usr/local/Whisparr/var/.config/Whisparr/
        chown -R Whisparr:users *
        chmod -R 0644 *
    ```

- Start Whisparr

# Whisparr Common Problems

## Path is Already Configured for an Existing Movie

![existing-movie.png](/assets/whisparr/existing-movie.png)

- This occurs when trying to add a movie or edit an existing movie's path that already is assigned to a different movie.
- Likely this was caused by not correcting a mismatched movie when the user imported their library.
- Locate and correct the movie that is already assigned to that movie's path.
  - Movie Index
  - Table View
  - Options => Add path as a column
  - Sort and find the movie at the noted problematic path.

## How can I rename my movie folders?

{#rename-folders}

> The same process applies for moving/changing Movie paths as well{.is-info}

1. Movies
1. Movie Editor
1. Select what movies need their folder renamed
1. Change Root Folder to the same Root Folder that the movies currently exist in
1. Select "Yes move files"

> If you are using Plex, this will trigger re-detection of intros, thumbnails, chapters, and preview metadata.
{.is-warning}

## Movie File and Folder Naming

- Currently, Whisparr requires that each movie be in a folder with the format containing at minimum `Movie Title (Year)/`, optionally `_` or `.` are valid separators. To facilitate correct quality and resolution identification during import, a file name like `Movie Title (Year) [Quality-Resolution].ext` is best, again `_` or `.` are valid separators too.

  - A useful tool for making these changes to your collection is [filebot](http://www.filebot.net/#download) which has paid version in both the Apple and Windows stores, but can be found for free on their legacy [SourceForge](https://sourceforge.net/projects/filebot/files/latest/download) site. It has both a GUI and CLI, so you can use whatever you’re comfortable with. For the above example, `{ny}` expands to `Name (Year)` and `{vf}` gives the resolution like `1080p`. There is nothing to infer quality, so you can fake it using `{ny}/{ny} [{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` which will name anything lower than 720p to `[DVD-572p]` and greater or equal to 720p like `[Bluray-1080p]`.

- See [Tips and Tricks Section => Create a Folder for Each Movie](/whisparr/faq)whisparr/tips-and-tricks#creating-a-folder-for-each-movie) for more details.

## Movie Folders Named Incorrectly

- Even if your movies are in folders already, the folders may not be named correctly. The folder name should be `Movie Title (Year)`, having the title and year in the folder’s name is critical right now.

  - Examples that will work well:
    - `/mnt/Movies/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - `/mnt/Kid Movies/Frozen (2013)/Frozen (2013) [Bluray-1080p].mkv`
  - Examples that will work, but will require manual management:
    - By letters: `/mnt/Movies/A-D/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - By rating: `/mnt/Movies/R/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - By genre: `/mnt/Movies/Crime, Drama, Sci-Fi/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - These examples will require manual management when the movie is added. Each of the examples will have many root directories, like `A-D` and `E-G` in the first letter example, `R` and `PG-13` in the rating example and you can guess at the variety of genre folders. When adding a new movie, the correct base folder will need to be selected for this format to work.
  - Examples that won’t work:
    - Single folder: `/mnt/Kid Movies/Frozen (2013) [Bluray-1080p].mkv`
      - At this time, movies simply have to be in a folder named after the movie. There is no way around this until development work is done to add this feature.
    - **Movie** Folder Naming Formats from v0.2 that include **File** properties in the **movie folder** name such as ``{Movie.Title}.{Release Year}.{Quality.Full}-{MediaInfo.Simple}{`Release.Group}`` will not work in v3.
      - Folders are related to the movie and independent of the file. Additionally, this will break with the planned multiple files per movie support.
      - The other reason it was removed was it caused frequent confusion, database corruption, and generally was only half baked.
  - The [Tips and Tricks Section => Create a Folder for Each Movie](/whisparr/tips-and-tricks#creating-a-folder-for-each-movie) is a great source for making sure your file and folder structure will work great.

## Can I disable the refresh movies task

- No, nor should you through any SQL hackery. The refresh movies task queries the upstream Servarr proxy and checks to see if the metadata for each movie (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Whisparr. If necessary, it will then update the applicable movies.

- A common complaint is the Refresh task causes heavy I/O usage. This is partly due to the setting "Analyze video files" which is advised to be enabled if you use tdarr or otherwise externally modify your files. If you do not you can safely disable "Analyze video files" to reduce some I/O. The other setting is "Rescan Movie Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`. Do not change this to `Never` unless all changes to your library (new movies, upgrades, deletions etc) are done through Whisparr. If you delete movie files manually or via Plex or another third party program, do not set this to `Never`.

## How do I request a feature for Whisparr?

- This is an easy one [click here](https://github.com/Whisparr/Whisparr/issues)

## Help, My Mac says Whisparr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac) ![Developer Cannot be verified](developer-cannot-be-verified.png "Developer Cannot be verified")
- Alternatively, you may need to self-sign Whisparr `codesign --force --deep -s - Whisparr.app`

## Help, My Mac says Whisparr.app is damaged and can’t be opened

- That is either due to a corrupt download so try again or [security issues, please see this related FAQ entry.](#help-my-mac-says-whisparr-cannot-be-opened-because-the-developer-cannot-be-verified)

## I am getting an error: Database disk image is malformed

> \* For Whisparr users experiencing this after upgrading to v4. v4 does several far reaching migrations because of that if your database had previous corruption at any place (which may not have been detectable previously running Whisparr) the migration will bomb out and fail. This will cause Whisparr to fail to start. It is likely all your backups are corrupt as well, so simply restoring those will likely not resolve the issue.
> \* If the post-migrated database will not open or cannot be recovered then make a copy of the database from a recent backup and apply the database recovery process to that file then try starting Whisparr with the recovered backup file. It should then migrate without issues.
{.is-warning}

- This means your SQLite database that stores most of the information for Whisparr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modifed your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backup-and-restore-whisparr). However, for users receiving this after upgrading to v4 it is highly unlikely the backup itself will work and you'll need to try the other recovery methods mentioned.
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use Whisparr on a Mac and it suddenly stopped working. What happened?

- Most likely this is due to a MacOS bug which caused one of the databases to be corrupted.

- See the above database is malformed entry.

- Then attempt to launch and see if it works. If it does not work, you will need further support. Post in our [subreddit /r/whisparr](http://reddit.com/r/whisparr) or hop on [our discord](https://whisparr.com/discord) for help.

## Why can Whisparr not see my files on a remote server?

- In short: the user is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is,  is running as a service, which causes one of two things:

### Whisparr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Whisparr's service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Whisparr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.
- Run Whisparr.exe using the Startup Folder

### You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Whisparr.exe via the Startup Folder

## How do I change from the Windows Service to a Tray App?

1. Shut down Whisparr
1. Run serviceuninstall.exe that's in the Whisparr directory
1. Run `Whisparr.exe` as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
1. (Optional) Drop a shortcut to .exe in the startup folder to auto-start on boot.

## Help I have locked myself out

{#help-i-have-forgotten-my-password}

To disable authentication (to reset your username or password) you will need need to edit `config.xml` which will be inside the [Whisparr Appdata Directory](/whisparr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Whisparr
1. Whisparr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` => `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Whisparr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Whisparr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](/useful-tools#clearing-cookies-and-local-storage) wiki article.

## Web Interface Only Loads at localhost on Windows

- If you can only reach your web interface at <http://localhost:6969/> or <http://127.0.0.1:6969/>, you need to run as administrator at least once.

## Permissions

- Whisparr will need to move files away from where the downloader puts them into the final location, so this means that will need to read/write to both the source and the destination directory and files.

- On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and . In umask notation, that would be `002`.

## System & Logs loads forever

- It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Sonarr is running on. But I still recommend checking the list.

## Finding Cookies

- Some sites cannot be logged into automatically and require you to login manually then give the cookies to Whisparr to work. [Please see this article for details.](/useful-tools#finding-cookies)

## Unpack Torrents

- Most torrent clients doesn’t come with the automatic handling of compressed archives like their usenet counterparts. We recommend [unpackerr](https://github.com/davidnewhall/unpackerr).

## uTorrent is no longer working

- Ensure the Web UI is enabled

- Ensure that the Alt Listening Port (Advanced => Web UI) is not the same as the Listening Port (Connections)

- We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

## I got a pop-up that said config.xml was corrupt, what now?

- Whisparr was unable to read your config file on start-up as it became corrupted somehow. In order to get back online, you will need to delete `.xml` in your [appdata-directory](/whisparr/appdata-directory), once deleted start and it will start on the default port (6969), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

- Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

- Whisparr validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then will refuse to connect. Free properly signed certificates are available from [let's encrypt](https://letsencrypt.org/).

- If your download client and are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## VPNs, Jackett, and the \*ARRs

- Unless you're in a repressive country like China or Australia, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

- In other words, putting the \*Arrs (Lidarr, Prowlarr, Whisparr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of arr servers (updates, metadata, etc.) and liable to block you too**

- In addition, some private trackers **ban** for browsing from a VPN, which is how Jackett and Prowlarr work. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Jackett behind the VPN. However, you should not do that if you have private trackers without checking their rules first. **Many private trackers will ban you for using or accessing them (i.e. using Jackett or Prowlarr) via a VPN.**

# Whisparr and Movie Issues + Metadata

## Why can I not add a new movie to Whisparr?

{#why-cant-i-add-a-new-movie-to-whisparr}

- Whisparr uses [The Movie Database (TMDb)](http://themoviedb.org) for movie information and images like fanart, banners and backgrounds. Generally, there are a few reasons why you may not be able to add a movie:
  - TMDb doesn't like special characters to be used when searching for movies through the API (which Whisparr uses), so try searching a translated name, and/or without special characters.
  - You can also add by TMDb ID or, if TMDb has it, the IMDb ID
  - The movie hasn't been added to TMDb yet, follow their [guide](https://www.themoviedb.org/bible/new_content#59f7933c9251413e93000006) to get it added.

# Whisparr Searching & Downloading Common Problems

## Jackett shows more results than when manually searching

- This is usually due to searching Jackett differently than you do. See our [troubleshooting article](/whisparr/troubleshooting) for more information.

## How does Whisparr handle foreign movies or foreign titles?

- Search will use the Movie's Original Title, English Title, and Translated Title from whatever languages you have preferred in the movie's quality profile and any custom formats with scores in the quality profile greater than zero. - Parsing (i.e. importing) looks for a match in all Translations and Alternative Titles.
- To get a movie in a foreign language set your movie's Quality Profile Language to Original (Movie's Original Language), a specific language for that profile, or `Any` and use custom formats to determine which language to grab.
- Note that this does not include any indexer languages configured in the indexer's settings as `multi`.
  - Note that `multi` by default is assumed English and French

> Note that for indexers that support ID based searches - such as many Usenet indexers and many private Torrent trackers - text queries are not used if results are returned for an ID based search. Therefore the above about searching does not apply. Whisparr will search the ID and if results are returned will not fall back to a name search. If you're missing results from your indexer then this is due to them having the release(s) associated with the incorrect movie id.
{.is-warning}

## How does Whisparr handle "multi" in names?

- Whisparr by default assumes multi is English and French unless specified in your indexer's advanced settings in Whisparr.
- Note that `multi` definitions only help for release parsing and not for foreign titles or movies searches.

## Help, Movie Added, But Not Searched

- Whisparr does not *actively* search for missing movies automatically. Instead, a periodic query of new posts is made to all indexers configured for RSS. When a wanted or cutoff unmet movie shows up in that list, it gets downloaded. This means that until a movie is posted (or reposted), it won’t get downloaded.
- If you’re adding a movie that you want now, the best option is to check the “Start search for missing movie” box, to the left of the *Add Movie* (**1**) button. You can also go to the page for a movie you’ve added and click the magnifying glass “Search” (**2**) button or use the Wanted view to search for Missing or Cutoff Unmet movies.

  - Add and Search for Movie when adding a movie
![addmovie-add-and-search.png](/assets/whisparr/addmovie-add-and-search.png)
  - Search an existing Movie
![searchmovie-movie-page.png](/assets/whisparr/searchmovie-movie-page.png)

## Jackett's /all Endpoint

{#jackett-all-endpoint}

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is strongly recommended. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)

- **January 1 2022 Update: Jackett `/all` endpoint is no longer supported (e.g. warnings will occur) as of 4.0.0.5730 due to the fact it only causes issues.**

- [Even Jackett says /all should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

- Using the `/all` endpoint has no advantages (besides reduced management overhead), only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000

- Note that using NZBHydra2 as a single aggregate entry has the same issues as Jackett's `/all`

- Add each indexer separately. This allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In \*Arr, each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you're more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error, \*Arr will disable it and now you do not get any results.

## Why are there two files? | Why is there a file left in downloads?

This is expected. With a setup that supports [hardlinks](https://trash-guides.info/hardlinks), double space will not be used. Below is how the Torrent Process works.

1. Whisparr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Whisparr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Whisparr's settings, Whisparr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped.

> Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file. {.is-info}

## Why doesn't Whisparr work behind a reverse proxy

- Starting with v3 Whisparr has switched to .NET and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Whisparr:

```nginx
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection $http_connection;
```

- Make sure you **do not** include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. **THIS WILL NOT WORK**
- [See this ASP.NET Core issue](https://github.com/aspnet/AspNetCore/issues/17081)
- If you are using a CDN like Cloudflare ensure websockets are enabled to allow websocket connections.
- If you have unexpected redirects, ensure your host header is being forwarded.
