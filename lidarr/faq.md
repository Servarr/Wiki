---
title: Lidarr FAQ
description: 
published: true
date: 2023-10-13T11:37:08.630Z
tags: lidarr, needs-love, faq
editor: markdown
dateCreated: 2021-06-14T14:33:41.344Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
  - [How does Lidarr work?](#how-does-lidarr-work)
  - [How does Lidarr find releases?](#how-does-lidarr-find-releases)
  - [Forced Authentication](#forced-authentication)
  - [How are possible downloads compared?](#how-are-possible-downloads-compared)
  - [Lidarr stopped working after updating to Ubuntu 22.04](#lidarr-stopped-working-after-updating-to-ubuntu-2204)
  - [Why can I not add a new release or artist to Lidarr?](#why-can-i-not-add-a-new-release-or-artist-to-lidarr)
  - [Why can I not add a various artists album?](#why-can-i-not-add-a-various-artists-album)
  - [Why does Lidarr only show studio albums, How do I find singles or EPs?](#why-does-lidarr-only-show-studio-albums-how-do-i-find-singles-or-eps)
  - [Can I add just an album?](#can-i-add-just-an-album)
  - [Can I download single tracks?](#can-i-download-single-tracks)
  - [Why doesn't artist X show up in search?](#why-doesnt-artist-x-show-up-in-search)
  - [Lidarr matched an album with too many tracks. How can I change the Album to the correct Release?](#lidarr-matched-an-album-with-too-many-tracks-how-can-i-change-the-album-to-the-correct-release)
  - [I cannot find a release in Lidarr but it is on MusicBrainz](#i-cannot-find-a-release-in-lidarr-but-it-is-on-musicbrainz)
  - [How often do Lidarr's and MusicBrainz databases sync?](#how-often-do-lidarrs-and-musicbrainz-databases-sync)
  - [How can I add missing artist images?](#how-can-i-add-missing-artist-images)
  - [How can I get missing album images? (Cover Art)](#how-can-i-get-missing-album-images-cover-art)
  - [I'm having trouble importing my artists, what could it be?](#im-having-trouble-importing-my-artists-what-could-it-be)
  - [How can I rename my artist folders?](#how-can-i-rename-my-artist-folders)
  - [How can I mass delete artists from the wanted list?](#how-can-i-mass-delete-artists-from-the-wanted-list)
  - [Why doesn't Lidarr work behind a reverse proxy](#why-doesnt-lidarr-work-behind-a-reverse-proxy)
  - [How do I update Lidarr?](#how-do-i-update-lidarr)
    - [Can I update Lidarr inside my Docker container?](#can-i-update-lidarr-inside-my-docker-container)
    - [Installing a newer version](#installing-a-newer-version)
      - [Native](#native)
      - [Docker](#docker)
  - [Can I switch from `nightly` back to `develop`?](#can-i-switch-from-nightly-back-to-develop)
  - [Can I switch between branches?](#can-i-switch-between-branches)
  - [I am getting an error: Database disk image is malformed](#i-am-getting-an-error-database-disk-image-is-malformed)
  - [How do I Backup/Restore my Lidarr?](#how-do-i-backuprestore-my-lidarr)
    - [Backing up Lidarr](#backing-up-lidarr)
      - [Using built-in backup](#using-built-in-backup)
      - [Using file system directly](#using-file-system-directly)
    - [Restoring from Backup](#restoring-from-backup)
      - [Using zip backup](#using-zip-backup)
      - [Using file system backup](#using-file-system-backup)
      - [File System Restore on Synology NAS](#file-system-restore-on-synology-nas)
  - [I use Lidarr on a Mac and it suddenly stopped working. What happened?](#i-use-lidarr-on-a-mac-and-it-suddenly-stopped-working-what-happened)
  - [I am using a Pi and Raspbian and Lidarr will not launch](#i-am-using-a-pi-and-raspbian-and-lidarr-will-not-launch)
  - [Why are lists sync times so long and can I change it?](#why-are-lists-sync-times-so-long-and-can-i-change-it)
  - [Can I disable the refresh releases task](#can-i-disable-the-refresh-releases-task)
  - [Why can Lidarr not see my files on a remote server?](#why-can-lidarr-not-see-my-files-on-a-remote-server)
    - [Lidarr runs under the LocalService account by default which doesn't have access to protected remote file shares](#lidarr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares)
    - [You're using a mapped network drive (not a UNC path)](#youre-using-a-mapped-network-drive-not-a-unc-path)
  - [Help I have locked myself out](#help-i-have-locked-myself-out)
  - [How do I stop the browser from launching on startup?](#how-do-i-stop-the-browser-from-launching-on-startup)
  - [Weird UI Issues](#weird-ui-issues)
  - [VPNs, Jackett, and the \*ARRs](#vpns-jackett-and-the-arrs)
  - [Jackett's /all Endpoint](#jacketts-all-endpoint)
    - [Jackett /All Solutions](#jackett-all-solutions)
  - [Why are there two files? | Why is there a file left in downloads?](#why-are-there-two-files--why-is-there-a-file-left-in-downloads)
  - [I keep getting warnings from my cloud storage about API limits](#i-keep-getting-warnings-from-my-cloud-storage-about-api-limits)

## How does Lidarr work?

- Lidarr relies on RSS feeds to automate grabbing of releases as they are posted, for both new releases as well as previously released releases being released or re-released. The RSS feed is the latest releases from a site, typically between 50 and 100 releases, though some sites provide more and some less. The RSS feed is comprised of all releases recently available, including releases for requested media you do not follow, if you look at debug logs you will see these releases being processed, which is completely normal.
- Lidarr enforces a minimum of 10 minutes on the RSS Sync interval and a maximum of 2 hours. 15 minutes is the minimum recommended by most indexers, though some do allow lower intervals and 2 hours ensures Lidarr is checking frequently enough to not miss a release (even though it can page through the RSS feed on many indexers to help with that). Some indexers allow clients to perform an RSS sync more frequently than 10 minutes, in those scenarios we recommend using Lidarr's Release-Push API endpoint along with an IRC announce channel to push releases to Lidarr for processing which can happen in near real time and with less overhead on the indexer and Lidarr as Lidarr doesn’t need to request the RSS feed too frequently and process the same releases over and over.

## How does Lidarr find releases?

- Lidarr does ''not'' regularly search for album files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for ''all'' the newly posted releases, then compares that with its list of releases that are missing or need to be upgraded. Any matches are downloaded. This lets Lidarr cover a library of ''any size'' with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the ''future'' though.
- So how do you deal with the present and past? When you're adding a album, you will need to set the correct path, profile and monitoring status then use the Start search for missing album checkbox. If the album hasn't been released yet, you do not need to initiate a search.
- Put another way, Lidarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases you want that were uploaded in the past.
- If you've already added the album, but now you want to search for it, you have a few choices. You can go to the album's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see ''all'' the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Lidarr has been offline for an extended period of time, Lidarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Lidarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed releases.

## Forced Authentication

If Lidarr is exposed so that the UI can be accessed from outside your local network then you should have some form of authentication method enabled in order to access the UI. This is also increasingly required by Trackers and Indexers.

As of Lidarr v2, Authentication is Mandatory.

### Authentication Method

- `Basic` (Browser pop-up) - This option when accessing your Lidarr will show a small pop-up allowing you to input a Username and Password
- `Forms` (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Lidarr
- `External` - Configurable via Config File Only
  - If you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](/lidarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost value will be used**

### Authentication Required

- If you do not expose the app externally and/or do not wish to have auth required for local (e.g. LAN) access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`

## How are possible downloads compared?

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. [See TRaSH's Guide](https://trash-guides.info/merge-quality)***
{.is-info}

- The current logic [can be found here](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).

- As of 2022-01-23 the logic is as follows:

1. Quality
1. Preferred Word Score
1. Protocol (as configured in the relevant Delay Profile)
1. Indexer Priority
1. Seeds/Peers (If Torrent)
1. Album Count
1. Age (If Usenet)
1. Size

## Lidarr stopped working after updating to Ubuntu 22.04

- Lidarr v0.8 is not compatible and not supported on Ubuntu 22.04
- Only Lidarr v1 supports Ubuntu 22.04
- [See this FAQ entry for the branches and versions](#how-do-i-update-lidarr)

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

- This is likely due to the release having an `unknown` release status. Update MusicBrainz.

## How often do Lidarr's and MusicBrainz databases sync?

- Every hour at 5 after the hour

## How can I add missing artist images?

- Add art to fanart.tv and wait ~7+ days for it to clear through the cache. Then refresh the metadata.

## How can I get missing album images? (Cover Art)

- Add coverart to musicbrainz and wait ~1hr+ for it to clear through the cache. Then refresh the metadata.

## I'm having trouble importing my artists, what could it be?

- The artist import process just imports the Artist names and path locations, which are then stored in the database so that a) metadata can be retrieved and b) downloaded content can be put in the same location in future. To this end, the user account that Lidarr runs under needs both read and write to your data directory.

## How can I rename my artist folders?

{#rename-folders}

> The same process applies for moving/changing Artist paths as well.
{.is-info}

1. Library
1. Mass Editor
1. Select what artists need their folder renamed
1. Change Root Folder to the same Root Folder that the artists currently exist in
1. Select "Yes move files"

## How can I mass delete artists from the wanted list?

- Use Mass Editor => Select artists you want to delete => Delete

## Why doesn't Lidarr work behind a reverse proxy

- Lidarr uses .NET and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Lidarr:
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

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://lidarr.servarr.com/v1/update/master/changes) - (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. This version will receive updates approximately monthly. On GitHub, this is the `master` branch.

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://lidarr.servarr.com/v1/update/develop/changes) - (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first after nightly. It can be considered semi-stable, but is still `beta`. This version will receive updates either weekly or biweekly depending on development.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://lidarr.servarr.com/v1/update/nightly/changes) - (Alpha/Unstable): This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch.  ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-danger}

- Note: If your install is through Docker append `:release`, `:latest`, `:testing`, or `:develop` to the end of your container tag depending on who makes your builds. Please note that `nightly` branches are intentionally not listed below.

|                                                                    | `master` (stable) ![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://lidarr.servarr.com/v1/update/master/changes) | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://lidarr.servarr.com/v1/update/develop/changes) | `nightly` (alpha) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://lidarr.servarr.com/v1/update/nightly/changes) |
| ------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [hotio](https://hotio.dev/containers/lidarr)                       | `release`                                                                                                                                                                                                             | `testing`                                                                                                                                                                                                           | `nightly`                                                                                                                                                                                                             |
| [LinuxServer.io](https://docs.linuxserver.io/images/docker-lidarr) | `latest`                                                                                                                                                                                                              | `develop`                                                                                                                                                                                                           | `nightly`                                                                                                                                                                                                             |

### Can I update Lidarr inside my Docker container?

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
- Failure to follow these instructions may result in your Lidarr becoming unusable or throwing errors. You have been warned
  - The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.

## I am getting an error: Database disk image is malformed

- **Errors of `Error creating log database` indicate issues with logs.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with lidarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Lidarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backuprestore-my-lidarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## How do I Backup/Restore my Lidarr?

### Backing up Lidarr

#### Using built-in backup

- Go to System => Backup in the Lidarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### Using file system directly

- Find the location of the AppData directory for Lidarr  
  - Via the Lidarr UI go to System => About  
  - [Lidarr Appdata Directory](/lidarr/appdata-directory)
- Stop Lidarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.
{.is-warning}

#### Using zip backup

- Re-install Lidarr (if applicable / not already installed)
- Run Lidarr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### Using file system backup

- Re-install Lidarr (if applicable / not already installed)
- Find the location of the AppData directory for Lidarr  
  - Running Lidarr once and via the UI go to System => About  
  - [Lidarr Appdata Directory](/lidarr/appdata-directory)
- Stop Lidarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Lidarr
- As long as the paths are the same, everything will pick up where it left off

#### File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.
{.is-warning}

- Re-install Lidarr (if applicable / not already installed)
- Find the location of the AppData directory for Lidarr  
  - Running Lidarr once and via the UI go to System => About  
  - [Lidarr Appdata Directory](/lidarr/appdata-directory)
- Stop Lidarr
- Connect to the Synology NAS through SSH and log in as root  

> On some installations, the user is different than the below commands: `chown -R sc-Lidarr:Lidarr *` {.is-info}

- Execute the following commands:

```shell
rm -r /usr/local/Lidarr/var/.config/Lidarr/Lidarr.db
cp -f /tmp/Lidarr_backup/* /usr/local/Lidarr/var/.config/Lidarr/
```

- Update permissions on the files:

 ```shell
cd /usr/local/Lidarr/var/.config/Lidarr/
chown -R Lidarr:users *
chmod -R 0644 *
```

- Start Lidarr

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

No, nor should you through any SQL hackery. The refresh releases task queries the upstream Servarr proxy and checks to see if the metadata for each release (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Lidarr. If necessary, it will then update the applicable releases.

A common complaint is the Refresh task causes heavy I/O usage. One setting that can cause issues is "Rescan Artist Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`. Do not change this to `Never` unless all changes to your library (new releases, upgrades, deletions etc) are done through Lidarr. If you delete release files manually or a third party program, do not set this to `Never`.

## Why can Lidarr not see my files on a remote server?

- For all OSes ensure the user/group you're running \*Arr as has read and write access to the mounted drive.
- For Linux ensure:
  - If you're using an NFS mount ensure `nolock` is enabled for your mount.
  - If you're using an SMB mount ensure `nobrl` is enabled for your mount.
- For Windows: In short: the user \*Arr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is \*Arr  is running as a service, which causes the issues described below.

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

To disable authentication (to reset your forgotten username or password) you will need need to edit `config.xml` which will be inside the [Lidarr Appdata Directory](/lidarr/appdata-directory)

1. Stop Lidarr
1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
*(Be sure you do not have two AuthenticationMethod entries in your file!)*
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

- **April 2022 Update: \*Arr support has been removed out for the jackett `/all` due to the fact it only causes issues.**
- The Jackett /all endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is now required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)
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

1. Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Lidarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Lidarr's settings, Lidarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped (i.e. paused). See [TRaSH's Download Client Guides](https://trash-guides.info/Downloaders/) for how to configure your download client optimally.

> Hardlinks are enabled by default. [A hardlink will not use any additional disk space.](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/) The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file.
{.is-info}

## I keep getting warnings from my cloud storage about API limits

Lidarr is not like the other Arrs. It uses tags instead of file names for operation. If you keep Lidarr files on cloud storage, it has to download the file to read the tags. This will very quickly blow through any API limits you have on your storage provider. We very much discourage you from keeping your Lidarr library on a cloud storage provider, and any issues you may be experiencing are likely due to that setup.
