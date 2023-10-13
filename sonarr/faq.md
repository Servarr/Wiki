---
title: Sonarr FAQ
description: 
published: true
date: 2023-10-13T11:44:29.977Z
tags: 
editor: markdown
dateCreated: 2021-06-09T18:39:33.208Z
---

<!-- # Table of Contents

- [Table of Contents](#table-of-contents)
- [Sonarr Basics](#sonarr-basics)
  - [How does Sonarr find episodes?](#how-does-sonarr-find-episodes)
  - [How are possible downloads compared?](#how-are-possible-downloads-compared)
  - [Preferred Words FAQs](#preferred-words-faqs)
  - [How do I change from the Windows Service to a Tray App?](#how-do-i-change-from-the-windows-service-to-a-tray-app)
  - [How do I Backup/Restore my Sonarr?](#how-do-i-backuprestore-my-sonarr)
    - [Backing up Sonarr](#backing-up-sonarr)
      - [Using built-in backup](#using-built-in-backup)
      - [Using file system directly](#using-file-system-directly)
    - [Restoring from Backup](#restoring-from-backup)
      - [Using zip backup](#using-zip-backup)
      - [Using file system backup](#using-file-system-backup)
      - [File System Restore on Synology NAS](#file-system-restore-on-synology-nas)
  - [Help I have locked myself out](#help-i-have-locked-myself-out)
  - [Why are there two files? \| Why is there a file left in downloads?](#why-are-there-two-files-why-is-there-a-file-left-in-downloads)
  - [I see that feature/bug X was fixed, Why can I not see it?](#i-see-that-featurebug-x-was-fixed-why-can-i-not-see-it)
  - [Episode Progress - How is it calculated?](#episode-progress-how-is-it-calculated)
  - [How do I access Sonarr from another computer?](#how-do-i-access-sonarr-from-another-computer)
  - [Why does Sonarr refresh series information so frequently?](#why-does-sonarr-refresh-series-information-so-frequently)
  - [Why is there a number next to Activity?](#why-is-there-a-number-next-to-activity)
  - [What's the different Series Types?](#whats-the-different-series-types)
    - [Series Types](#series-types)
    - [Series Type Examples](#series-type-examples)
      - [Daily](#daily)
      - [Standard](#standard)
      - [Anime](#anime)
  - [How can I rename my series folders?](#how-can-i-rename-my-series-folders)
  - [How do I update Sonarr?](#how-do-i-update-sonarr)
    - [Installing a newer version](#installing-a-newer-version)
      - [Native](#native)
      - [Docker](#docker)
  - [Can I switch from `develop` back to `main`?](#can-i-switch-from-develop-back-to-main)
  - [Can I switch between branches?](#can-i-switch-between-branches)
- [Sonarr and Series Issues + Metadata](#sonarr-and-series-issues-metadata)
  - [How does Sonarr handle scene numbering issues (American Dad!, etc)?](#how-does-sonarr-handle-scene-numbering-issues-american-dad-etc)
    - [How Sonarr handles scene numbering issues](#how-sonarr-handles-scene-numbering-issues)
    - [Problematic Shows](#problematic-shows)
  - [Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?](#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x)
  - [TVDb is updated why isn't Sonarr?](#tvdb-is-updated-why-isnt-sonarr)
  - [Why can I not add a series?](#why-can-i-not-add-a-series)
  - [Why can I not add a series when I know the TVDb ID?](#why-can-i-not-add-a-series-when-i-know-the-tvdb-id)
  - [Title Slug in Use](#title-slug-in-use)
  - [Episode does not have an absolute number](#episode-does-not-have-an-absolute-number)
  - [Episode Air Times](#episode-air-times)
- [Sonarr Common Problems](#sonarr-common-problems)
  - [Path is Already Configured for an Existing Series](#path-is-already-configured-for-an-existing-series)
  - [Episode does not have an forever](#system-logs-loads-forever)
  - [Weird UI Issues](#weird-ui-issues)
  - [Web Interface Only Loads at localhost on Windows](#web-interface-only-loads-at-localhost-on-windows)
  - [uTorrent is no longer working](#utorrent-is-no-longer-working)
  - [Does Sonarr require a SABnzbd post-processing script to import downloaded episodes?](#does-sonarr-require-a-sabnzbd-post-processing-script-to-import-downloaded-episodes)
  - [I got a pop-up that said config.xml was corrupt, what now?](#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now)
  - [Sonarr on Synology Stopped Working (SSL)](#sonarr-on-synology-stopped-working-ssl)
  - [Invalid Certificate and other HTTPS or SSL issues](#invalid-certificate-and-other-https-or-ssl-issues)
  - [How do I stop the browser from launching on startup?](#how-do-i-stop-the-browser-from-launching-on-startup)
  - [VPNs, Jackett, and the \*ARRs](#vpns-jackett-and-the-arrs)
  - [I see log messages for shows I do not have/do not want](#i-see-log-messages-for-shows-i-do-not-havedo-not-want)
  - [Seeding torrents aren't deleted automatically](#seeding-torrents-arent-deleted-automatically)
  - [Help, my Mac says Sonarr cannot be opened because the developer cannot be verified](#help-my-mac-says-sonarr-cannot-be-opened-because-the-developer-cannot-be-verified)
  - [Help, my Mac says Sonarr.app is damaged and cannot be opened](#help-my-mac-says-sonarrapp-is-damaged-and-cannot-be-opened)
  - [I am getting an error: Database disk image is malformed](#i-am-getting-an-error-database-disk-image-is-malformed)
  - [I use Sonarr on a Mac and it suddenly stopped working. What happened?](#i-use-sonarr-on-a-mac-and-it-suddenly-stopped-working-what-happened)
  - [Why can Sonarr not see my files on a remote server?](#why-can-sonarr-not-see-my-files-on-a-remote-server)
    - [Sonarr runs under the LocalService account by default which doesn't have access to protected remote file shares](#sonarr-runs-under-the-localservice-account-by-default-which-doesnt-have-access-to-protected-remote-file-shares)
    - [You're using a mapped network drive (not a UNC path)](#youre-using-a-mapped-network-drive-not-a-unc-path)
  - [Mapped Network Drives vs UNC Paths](#mapped-network-drives-vs-unc-paths)
  - [Sonarr will not work on Big Sur](#sonarr-will-not-work-on-big-sur)
  - [My Custom Script stopped working after upgrading from v2](#my-custom-script-stopped-working-after-upgrading-from-v2)
- [Sonarr Searching & Downloading Common Problems](#sonarr-searching-downloading-common-problems)
  - [Query Successful - No Results Returned](#query-successful-no-results-returned)
  - [Why didn't Sonarr grab an episode I was expecting?](#why-didnt-sonarr-grab-an-episode-i-was-expecting)
  - [Found matching series via grab history, but release was matched to series by ID. Automatic import is not possible](#found-matching-series-via-grab-history-but-release-was-matched-to-series-by-id-automatic-import-is-not-possible)
  - [Why wont Sonarr import a TBA episode?](#why-wont-sonarr-import-a-tba-episode)
  - [Sonarr says Unknown Series on Searches or Imports](#sonarr-says-unknown-series-on-searches-or-imports)
  - [Jackett's /all Endpoint](#jacketts-all-endpoint)
    - [Jackett /All Solutions](#jackett-all-solutions)
  - [Jackett shows more results than Sonarr when manually searching](#jackett-shows-more-results-than-sonarr-when-manually-searching)
  - [Finding Cookies](#finding-cookies)
  - [Unpack Torrents](#unpack-torrents)
  - [Permissions](#permissions)
-->
# Sonarr Basics

## How does Sonarr find episodes?

- Sonarr does *not* regularly search for episode files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted episodes/newly uploaded releases, then compares that with its list of episodes that are missing or need to be upgraded. Any matches are downloaded. This lets Sonarr cover a library of *any size* with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a show, you will need to set the correct path, profile and monitoring status then use the Start search for missing checkbox. If the show has had no episodes and hasn't been released yet, you do not need to initiate a search.
- Put another way, Sonarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases uploaded in the past.
- If you've already added the show, but now you want to search for it, you have a few choices. You can go to the show's page and use the search button, which will do a search and then automatically pick episode(s). You can search individual episodes or seasons automatically or manually. Or you can go to the [Wanted](/sonarr/wanted) tab and search from there.
- If Sonarr has been offline for an extended period of time, Sonarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Sonarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed episodes.

### Instances When Auto Searching Does Occur

Active searching (via the indexer's API) is only done in the below situations. Note that the same rules as normal apply: series + episode must be monitored and episodes without an airdate are skipped

- Triggered Automatic or Manual Search
  - User or API triggered search. Typically executed by clicking the Automatic or Manual Search buttons on a specific episode, season, or series.
- Adding a show using the Add and Search button
- Using Wanted => Missing or Wanted => Cutoff Unmet to do one or more searches
- Recently Aired Episodes added after airing
  - If a new episode is added to Sonarr that aired in the last 14 days or within 1 day into the future (to cover those episodes that may release a bit early) Sonarr **will search** for those episodes after the series folder is rescanned (to catch things imported outside of Sonarr)

## How are possible downloads compared?

> Generally Quality Trumps All. If you wish to have Quality not be the main priority - you can merge your qualities together. [See TRaSH's Guide](https://trash-guides.info/merge-quality)
{.is-info}

- The current logic [can always be found here](https://github.com/Sonarr/Sonarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs#L31-L40s).

- As of 2022-01-23 the logic is as follows:

1. Quality
1. Language
1. Preferred Word Score\*
1. Protocol (as configured in the relevant Delay Profile)
1. Episode Count\*
1. Episode Number
1. Indexer Priority
1. Seeds/Peers (If Torrent)
1. Age (If Usenet)
1. Size

> REPACKS and PROPERs are v2 of Qualities and thus rank above a non-repack of the same quality. [Set Media Management => File Management `Download Proper & Repacks` to "Do Not Prefer"](/sonarr/settings#file-management) and use a preferred word regex of `/\b(repack|proper)\b/i` with a positive score as suggested by [TRaSH's Guides](https://trash-guides.info/Sonarr/Sonarr-Release-Profile-RegEx/#p2p-groups-repackproper)
{.is-warning}

> \* Preferred Words always upgrade a release even if the quality and/or language cutoff has been met. This includes if the Profile has Upgrades disabled.
> \* Preferred Words override the standard Season Pack Preference. This is [Sonarr Github Issue #3562](https://github.com/Sonarr/Sonarr/issues/3562). To prefer Season Packs when using preferred words, you need to [add a season pack preference as well](https://trash-guides.info/Sonarr/Sonarr-Release-Profile-RegEx/#optional-prefer-season-packs)
{.is-info}

## Preferred Words FAQs

- For the score of the on disk file: The existing name of the file and the "original scene name" of the release are evaluated for preferred words. The higher score of the two is taken.

- How are preferred words included in renaming?

  - For Sonarr you can make use of the `{Preferred Words}` token in your renaming scheme and also enable`Include Preferred when Renaming` in the release profile. take a look [at TRaSH's recommended naming scheme](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/) for a recommended naming scheme examples for Sonarr. Using the tokens in your renaming scheme could help with download loop issues.

- As of v3.0.7, you can now also include Preferred Words on a Release Profile basis `{Preferred Words:<Release Profile Name>}`

- Preferred Words always upgrade a release even if the quality and/or language cutoff has been met. This includes if the Profile has `Upgrades` disabled

> Preferred Words override the standard Season Pack Preference. This is [Sonarr Github Issue #3562](https://github.com/Sonarr/Sonarr/issues/3562). To prefer Season Packs when using preferred words, you need to [add a season pack preference as well](https://trash-guides.info/Sonarr/Sonarr-Release-Profile-RegEx/#optional-prefer-season-packs)
{.is-info}

- Tags can be used to control what Series a Release Profile applies to; refer to the settings entry for Release Profiles for more information

- For additional information on Preferred Words and Release Profiles [see the settings page](/sonarr/settings#release-profiles)

## How do I change from the Windows Service to a Tray App?

1. Shut Sonarr down
1. Run serviceuninstall.exe that's in the Sonarr directory
1. Run Sonarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
1. (Optional) Drop a shortcut to Sonarr.exe in the startup folder to auto-start on boot.

## How do I Backup/Restore my Sonarr?

### Backing up Sonarr

#### Using built-in backup

- Go to System => Backup in the Sonarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### Using file system directly

- Find the location of the AppData directory for Sonarr  
  - Via the Sonarr UI go to System => About  
  - [Sonarr Appdata Directory](/sonarr/appdata-directory)
- Stop Sonarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database or use [Toolbarr](https://github.com/Notifiarr/toolbarr).
{.is-warning}

#### Using zip backup

- Re-install Sonarr (if applicable / not already installed)
- Run Sonarr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### Using file system backup

- Re-install Sonarr (if applicable / not already installed)
- Find the location of the AppData directory for Sonarr  
  - Running Sonarr once and via the UI go to System => About  
  - [Sonarr Appdata Directory](/sonarr/appdata-directory)
- Stop Sonarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Sonarr
- As long as the paths are the same, everything will pick up where it left off

#### File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.
{.is-warning}

- Re-install Sonarr (if applicable / not already installed)
- Find the location of the AppData directory for Sonarr  
  - Running Sonarr once and via the UI go to System => About  
  - [Sonarr Appdata Directory](/sonarr/appdata-directory)
- Stop Sonarr
- Connect to the Synology NAS through SSH and log in as root  

> On some installations, the user is different than the below commands: `chown -R sc-Sonarr:Sonarr *` {.is-info}

- Execute the following commands:

```shell
rm -r /usr/local/Sonarr/var/.config/Sonarr/Sonarr.db
cp -f /tmp/Sonarr_backup/* /usr/local/Sonarr/var/.config/Sonarr/
```

- Update permissions on the files:

 ```shell
cd /usr/local/Sonarr/var/.config/Sonarr/
chown -R Sonarr:users *
chmod -R 0644 *
```

- Start Sonarr

## Help I have locked myself out

{#help-i-have-forgotten-my-password}

> If you are using v4 of Sonarr the `AuthenticationMethod` type `None` is no longer valid - please see this [FAQ](/sonarr/faq-v4) {.is-info}

To disable authentication (to reset your forgotten username or password) you will need need to edit `config.xml` which will be inside the [Sonarr Appdata Directory](/sonarr/appdata-directory)

1. Stop Sonarr
1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
*(Make sure you only have one AuthenticationMethod entry in your file)*
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
*(If you are running v4, the correct entry is External instead of None)*
1. Restart Sonarr
1. Sonarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## Why are there two files? \| Why is there a file left in downloads?

This is expected. With a setup that supports [hardlinks](https://trash-guides.info/hardlinks), double space will not be used. Below is how the Torrent Process works.

1. Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Sonarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Sonarr's settings, Sonarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped (i.e. paused). See [TRaSH's Download Client Guides](https://trash-guides.info/Downloaders/) for how to configure your download client optimally.

> Hardlinks are enabled by default. [A hardlink will not use any additional disk space](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/). The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then it will fall back and copy the file.{.is-info}

## I see that feature/bug X was fixed, Why can I not see it?

Sonarr consists of two main branches of code, `main` and `develop`.

- `main`is released periodically, when the `develop` branch is stable
- `develop` is for pre-release testing and people willing to live on the edge. When a feature is marked as in `develop` it will only be available to users running the `develop` branch, once it has been move to live (in `main`) it is officially released.

## Episode Progress - How is it calculated?

- There are two parts to the episode count, one being the number of episodes (Episode Count) and the other being the number of episodes with files (Episode File Count), each one uses slightly different logic to give you the overall progress for a series or season.

  - Episode Count => Episode has already aired AND is monitored OR - Episode has a file
  - Episode File Count => Episode has a file

- If a series has 10 episodes that have all aired and you do not have any files for them you would have 0/10 episodes, if you unmonitored all the episodes in that series you would have 0/0 and if you got all the episodes for that series, regardless of if the episodes are monitored or not, you would have 10/10 episodes.

## How do I access Sonarr from another computer?

- By default Sonarr doesn't listen to requests from all systems (when not run as administrator), it will only listen on localhost, this is due to how the Web Server Sonarr uses integrates with Windows (this also applies for current alternatives). If Sonarr is run as an administrator it will correctly register itself with Windows as well as open the Firewall port so it can be accessed from other systems on your network. Running as admin only needs to happen once (if you change the port it will need to be re-run).

## Why does Sonarr refresh series information so frequently?

- Sonarr refreshes series and episode information in addition to rescanning the disk for files every 12 hours. This might seem aggressive, but is a very important process. The data refresh from our TVDb proxy is important, because new episode information is synced down, air dates, number of episodes, status (continuing/ended). Even shows that aren't airing are being updated with new information.
- The disk scan is less important, but is used to check for new files that weren't sorted by Sonarr and detect deleted files.
- The most time consuming portion is the information refresh (assuming reasonable disk access speed), larger shows take longer due to the number of episodes to process.

> It is not possible to disable this task. If this task is running for long enough that you feel it's the problem, something else is going on that needs to be solved instead of stopping this task.
{.is-warning}

## Why is there a number next to Activity?

- This number shows the count of episodes in your download client's queue and the last 60 items in its history that have not yet been imported. If the number is blue it is operating normally and should import episodes when they complete. Yellow means there is a warning on one of the episodes. Red means there has been an error. In the case of yellow (warning) and red (error), you will need to look at the queue under Activity to see what the issue is (hover over the icon to get more details).
- You need to remove the item from your download client's queue or history to remove them from Sonarr's queue.

## What's the different Series Types?

- Series Type impacts how Sonarr searches for series. A series type is based on how the series is released on one's indexers and is not necessarily the true 'type' of the series.
- Most shows should be `Standard`. For daily shows which are typically released with a date, `Daily` should be used. Finally, there is anime where using `Anime` is *usually* right, but sometimes `Standard` can work better, so try the *other* one if you're having issues.
- Please note that if the series type is set to anime and if none of your enabled indexers have any anime categories configured then it effectively skips the indexer and may appear that it is not searching.
- Please note that the Anime type does not have any concept of Season Packs or Seasons and will cause each episode individually to be searched.
- Please note that not all indexers support season/episode (standard) searches.
- Series types can be modified from Mass Editor or from `Edit` when viewing a series. Note that the series type is selectable at import.

- If **Anime** Series Type is used - it is [possible to also have your indexer searched with the standard type as well.](/sonarr/settings#indexers)

### Series Types

- **Anime** - Episodes released using an absolute episode number
- **Daily** - Episodes released daily or less frequently that use year-month-day (2017-05-25)
- **Standard** - Episodes released with SxxEyy pattern

### Series Type Examples

Below are some example release names for each show type. The specific differentiating piece is noted in bold.

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

Logs will show `Searching indexers for [The Witcher : S01E09 (09)]`

- Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
- \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC) \[63B8AC67\]
- \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]

## How can I rename my series folders?

{#rename-folders}

> The same process applies for moving/changing Series paths as well{.is-info}

If you have adjusted your your Series Name format after Sonarr has already created some Series folders, Sonarr will not automatically rename existing folders. In order to trigger a rename of these folders the following steps should be taken:

1. Series
1. Mass Editor
1. Select what series need their folder renamed
1. Change Root Folder to the same Root Folder that the series currently exist in
1. Select "Yes move files" to have

> If you are using Plex or Emby, this will trigger re-detection of intros, thumbnails, chapters, and preview metadata.
{.is-warning}

## How do I update Sonarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `main` or `develop`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- main - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Main&query=%24%5B%27v3-stable%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) - (Default/Stable): This has been tested by users on nightly (`develop`) branch and it's not known to have any major issues. This branch should be used by the majority of users. On GitHub, this is the `main` branch.
- develop - ![Current Develop/Nightly](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Develop&query=%24%5B%27v3-nightly%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) -  (Alpha/Unstable) : This is now the same as main for non-Docker users and likely the last v3 release.

> ~~**Warning: You may not be able to go back to `main` after switching to this branch.** On GitHub, this is the `develop` branch.~~
{.is-danger}

- v4 develop - ![Current v4 Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=v4-preview&query=%24%5B%27v4-preview%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) -  (Alpha/Unstable) : **For Non-Docker users the branch is `develop` once v4 is installed. For Docker users this is likely the `develop` tag** This is the bleeding edge for Sonarr v4 Beta. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch. On GitHub, this is the `develop` branch.

> **Warning: You are not able to go back to (v3) `main` or (v3) `develop` after switching to the v4 branch without reinstalling and locating a v3 backup.** On GitHub, this is the `develop` branch.
{.is-danger}

> v3 **non-docker** installs **cannot** be upgraded directly to v4 and require installing Sonarr v4
{.is-info}

- Note: If your install is through Docker append `:release`, `:latest`, `:nightly`, or `:develop` to the end of your container tag depending on who makes your builds.

|                                                                    | `main` (stable) ![Current Main/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Main&query=%24%5B%27v3-stable%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) | `develop` (v3) (beta) ![Current v3 Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=Develop&query=%24%5B%27v3-nightly%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) | `develop` (v4) (v4 beta) ![Current v4 Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&label=v4-preview&query=%24%5B%27v4-preview%27%5D.version&url=https%3A%2F%2Fservices.sonarr.tv%2Fv1%2Freleases) |
|--------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [hotio](https://hotio.dev/containers/sonarr)                       | `release`                                                                                                                                                                                             | `nightly`                                                                                                                                                                                                   | `v4`                                                                                                                                                                                                            |
| [LinuxServer.io](https://docs.linuxserver.io/images/docker-sonarr) | `latest`                                                                                                                                                                                              | `3.0.10`                                                                                                                                                                                                     | `develop`                                                                                                                                                                                                       |

### Installing a newer version

#### Native

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

> v3 cannot be updated to beta v4 and requires manually installing. Refer to the [v4 Beta Announcement](https://www.reddit.com/r/sonarr/comments/z3nb82/sonarr_v4_beta/)
{.is-info}

#### Docker

1. Repull your tag and update your container

## Can I switch from `develop` back to `main`?

- See the entry below

## Can I switch between branches?

> You can (almost) always increase your risk.{.is-info}

- `main` can go to `develop`
- See below or otherwise check with the development team to see if you can switch from `develop` to `main` for your given build.
- Failure to follow these instructions may result in your Sonarr becoming unusable or throwing errors. You have been warned. If the below errors are encountered then you are using a newer database with an older \*Arr version which is not supported. Upgrade \*Arr to the version you were previously on or newer.
  - Example Error Messages:
    - `Error parsing column 45 (Language=31 - Int64)`
    - `The DataMapper was unable to load the following field: 'Languages' value`
    - `ID does not match a known language Parameter name: id`
    - Other similar database errors around missing columns or tables.
- **August 7 2022 Update**
  - `3.0.9.1549` has been released as main/stable
  - For those on develop and are still on `3.0.9.1549` or lower you can safely downgrade to main
  - If you are on a newer version you *may be stuck* on nightly/develop until a new stable release is cut. If you have a backup from prior to upgrading past the version noted above, you can reinstall and restore the backup. Check with the development team to see if you can safely downgrade.

# Sonarr and Series Issues + Metadata

## How does Sonarr handle scene numbering issues (American Dad!, etc)?

### How Sonarr handles scene numbering issues

- Sonarr relies on [TheXEM](http://thexem.info/), a community driven site that lets users create mappings of shows that the scene (the people that post the files) and TheTVDb (which typically follows the network's numbering). There are a number of shows on there already, but it is easy to add another and typically the changes are accepted within a couple days (if they're correct). TheXEM is used to correct differences in episode numbering (disagreement whether an episode is a special or not) as well as season number differences, such as episodes being released as S10E01, but TheTVDb listing that same episode as S2017E01.
- XEM typically fixes the issues when release groups' (colloquially known as 'the scene') numbering does not match TVDb numbering so Sonarr doesn't work. Well enter [XEM](http://thexem.info) which creates a map for Sonarr to look at.
- Releases double episodes in a single file since that is how they air but TVDb marks each episode individually.
- Release groups use a year for the season S2010 and TVDb uses S01.
- [XEM](http://thexem.info) works in most cases and keeps it running smooth without you ever knowing. However as with most things, there will always be a *problematic exceptions* and in this case there is a list of them.

> Certain indexers or release groups may follow TVDb rather than `Scene` (i.e. XEM).
> If this is observed, please submit them via the scene mapping form.
{.is-info}

- [Services Requested Mappings *Review and ensure the alias and release have not already been requested or added*](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
- [Services Scene Mapping Request Form *Make a new request for an alias. Ensure the form is filled out in full*](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)
{.links-list}

### Problematic Shows

> This by no means is an all inclusive list of shows that have known issues with scene mapping; however, these are some common ones.
{.is-info}

- This is an incomplete list of the known shows and how/why they're problematic:  
- American Dad {#problemshow-americandad}
  - Due to network season changes, American Dad is typically off by 1 season between releases and TVDb. Refer to the XEM map for details
  - [American Dad](https://thexem.info/xem/show/4948) is currently on S19 based on TVDb or S18 based on Scene at the time of this writing. So searching in Sonarr for Season 19 will **only** return Season 18 results because of the XEM map.
  - If you have an indexer / release groups with Season 19 episodes, please submit them via the scene mapping form and ensure they are not already requested
    - [Services Requested Mappings *Review and ensure the alias and release have not already been requested or added*](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
    - [Services Scene Mapping Request Form *Make a new request for an alias. Ensure the form is filled out in full*](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)
   {.links-list}
- Paw Patrol {#problemshow-pawpatrol}
  - Double episode files vs single episode TVDb but also not all episodes are doubles so the map can get added wrong pointing to which ones are singles vs doubles
- Pokémon {#problemshow-pokemon}
  - On TheXem, [Pokemon](http://thexem.info/xem/show/4638) is tracking *dubbed* episodes. So if you want subbed episodes, you may be out of luck. If certain release groups are following TVDb and not XEM mapping, please submit them via the scene mapping form and ensure they are not already requested
    - [Services Requested Mappings *Review and ensure the alias and release have not already been requested or added*](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
    - [Services Scene Mapping Request Form *Make a new request for an alias. Ensure the form is filled out in full*](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)
   {.links-list}
- La Casa de Papel / Money Heist  {#problemshow-moneyheist}
  - TVDb has the original airing order from the Spanish network, but Netflix bought the rights and re-cut the series into a different episode count. This is causing "season 5" to be imported over existing "season 3" episodes. [Additional information can be found on this reddit thread](https://old.reddit.com/r/sonarr/comments/pdrr6l/money_heist_mess/)
- Kamen Rider {#problemshow-kamenrider}
  - The anthology entry ([TVDb ID 74096](https://thetvdb.com/series/kamen-rider)) should be used in Sonarr for automation
 as this show has both an anthology entry (collecting all seasons) and the individual seasons listed as separate entries on TVDb. Due to the anthology entry having individual season name mappings on [TheXEM](https://thexem.info/xem/show/5376) it is not possible to add the individual season entries to Sonarr without manually downloading and importing releases.
- Bleach: Thousand-Year Blood War {#problemshow-bleach}
  - The newest season of Bleach: Thousand-Year Blood War is being released with a variety of different naming schemes making it difficult to automate and potentially overwriting some of your existing episodes. It can only be automated if your release group is either:
    - Releasing the episodes as S17Exx numbering, or
    - Releasing them with the correct Season 2 series title (found here <https://thexem.info/xem/show/5476>) and have began this new arc at absolute episode number 1.
- Great Asian Railway Journeys {#problemshow-greatasianrail}
  - Great Asian Railway Journeys was first aired as 20 smaller episodes, but was later re-aired as 10 long episodes. These longer combined episodes were added as Specials, and should be named accordingly. (S00E01, etc, ...)
- Horizon {#problemshow-horizon}
  - A show that sporadically airs episodes since 1964. This makes mapping particularly difficult, as you can see on [TheXEM](https://thexem.info/xem/show/5495). Those interested can find the original discussion on the Sonarr discord [here](https://discord.com/channels/383686866005917708/649018968559845376/1046898050909622312).
- Kaleidoscope (2023) {#problemshow-kaleidoscope}
  - Kaleidoscope (2023) was released on Netflix as a non-linear show meaning that every user got a different order when watching the series. This causes an issue for Sonarr as release groups have different episode orders for the show. In order to prevent incorrect mapping of episodes Sonarr will not automatically grab episodes and you will need to grab and import the episodes manually. You can match them based on episode title, or by previewing the first few seconds and seeing the episode 'color' matching the title.

Some examples of other shows that commonly have issues, most of which may be resolved by TheXEM mappings are: Arrested Development, Kitchen Nightmares (US), Mythbusters, Pawn Stars.

## Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?

There can be multiple reasons why Sonarr is not able to find or import episodes for a particular series.

> Sonarr does not use aliases nor translations (i.e. any foreign language titles) from TVDb.
{.is-warning}

> **For indexers that support ID based searches**, the series TVDbID or IMDbID are used for searching. Series titles and any aliases are only used if ID based searches return no results.
{.is-info}

- Sonarr relies on being able to match titles, often the uploaders name episodes using different titles, e.g. `CSI: Crime Scene Investigation` is posted just `CSI` thus Sonarr cannot match the names without some help. These are handled by the Scene Mapping that the Sonarr Team maintains.
- You may also wish to review the [FAQ Entry for Problematic Shows and Release Group vs. TVDb numbering issues](#how-does-sonarr-handle-scene-numbering-issues-american-dad-etc)

> **For all Japanese Anime, aliases will need to be added to [thexem.info](https://thexem.info)**, for other series to request a new mapping see the steps below. Further information can be found with some of the XEM folks that hangout in the #XEM discord channel on the Sonarr Discord.
{.is-danger}

- [Services Requested Mappings *Review and ensure the alias and release have not already been requested or added*](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
- [Services Scene Mapping Request Form *Make a new request for an alias. Ensure the form is filled out in full*](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)
{.links-list}

> Typically Services requests are added within 1-5 days
{.is-info}

> Again, do not request a mapping for Japanese Anime; use XEM for that.
> Further information can be found with some of the XEM folks that hangout in the [\#XEM discord channel on the Sonarr Discord](https://discord.gg/Z3D6u5hBJb)
{.is-danger}

> If a Non-Japanese Series requires Season mapping (e.g. released as S25E26 but TVDB is S26E2 then an XEM mapping will be required. This cannot be done with Services mapping.
{.is-info}

> The series "Helt Perfekt" with TVDb ids of `343189` and `252077` is difficult to automate due to TVDb having the same name for both shows, violating TVDb's own rules. The first entry for the series gets the name. Any future entries for the series must have the year as part of the series name. However, a scene exception as been added to map releases (case sensitive mapping) Helt Perfekt releases containing `NORWEGIAN` -\> `252077` and containing `SWEDISH` -\> `343189`
{.is-info}

## TVDb is updated why isn't Sonarr?

{#tvdb}

- TVDb has a 24 hour cache on their API.
- TVDb's API then needs to populate through their CDN cache which takes several hours.
- Sonarr's Skyhook has a much smaller few hour cache on top of that.
- Additionally, Sonarr only runs the Refresh Series task every 12 hours. This task can be manually ran from System => Tasks; "Update All" from the Series Index, or manually ran for a specific series on that series's page.

- Therefore for a change on TVDb to get into Sonarr automatically it will typically take between 36 and 48 hours (24 + ~3 + ~3 + 12)

- If a series or episodes are missing on TVDb, they'll take 36 to 48 hours from when they're added to populate into your Sonarr instance.

{#missing-episodes}

- If you know a TVDb update was made more than 48 hours ago, then please come discuss on our [Discord](https://discord.sonarr.tv/).

## Why can I not add a series?

{#why-can-i-not-add-a-new-series}

- In the event that TheTVDb is unavailable Sonarr is unable to get search results and you will be unable to add any new series by searching. You may be able to add a new series by the TVDbID if you know what it is, the UI explains how to add it by an ID.
- Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDb ID that does not have an English title. If no English title exists for that series on TheTVDb it will need to be added and then [one will need to wait for TVDb's cache to clear](#tvdb).
- The show must be a TV Series, and not a movie. It must also exist on TVDb. If it is on IMDB, TMDB, or anywhere else, but not on TVDb you cannot add the show.
- The series must exist on TVDb
- Certain series may actually be considered continuations are and seasons in their primary series.
  - Some series/seasons known are:
  - [Dexter New Blood was Season 9](https://thetvdb.com/series/dexter/seasons/official/9) but it is now [it's own series](https://thetvdb.com/series/dexter-new-blood)

## Why can I not add a series when I know the TVDb ID?

{#why-cant-i-add-a-new-series-when-i-know-the-tvdb-id}

- Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDb ID that does not have an English title then the series will not be found. If no English title exists for that series on TheTVDb it will need to be added (if available).
- Check the URL / series - Sonarr does not support movies; use [Radarr](/radarr) for movies

## Title Slug in Use

- There are two primary causes of this error that are listed below.

## Duplicate Names No Year

- This error often occurs when two series are named with the same title on TheTVDB, if this is the case the second series should have the year appended to the series title.
  - Series A
  - Series A (2021)
- To rectify this, wait for someone to eventually (maybe) update TVDb or update TVDb yourself. Once corrected **and once approved by TVDb's moderators**, due to [TVDb's API issues](#tvdb-is-updated-why-isnt-sonarr), once updated you'll need to wait 30+ hours before the corrected title can be used in Sonarr.

## Duplicate Names Punctuation

- It will also happen with two similarly named series that may only differ by punctuation, if this is the case please report this on the [Sonarr Discord](https://discord.sonarr.tv/).
  - Joe's Show (2022)
  - Joes Show (2022)

## Episode does not have an absolute number

- The episode(s) on TVDb do not have an absolute number assigned. Update the series on TVDb if required and then wait the 36-48 hours for the update to clear TVDb's internal cache and load into Sonarr

## Episode Air Times

- Within Sonarr, Episode Air Date and Times shown in the browser are based of the client's time/timezone, all times are sent from Sonarr to the browser as UTC times (ISO-8601 formatted to be exact)
- TVDb dictates - with exceptions for streaming services - that the airtime and date is based on the Primary Airing Network's local time in the country's most popular city. [See TVDb's FAQ entry for details](https://support.thetvdb.com/kb/faq.php?id=29)
- Episode Air Dates and Air Time on TVDb is converted to UTC and uses Sonarr's Timezone that is mapped in Skyhook by the Sonarr team for the Network TVDb has for the series.
  - In the rare case a network is not mapped then the time in TVDb will be assumed to be US EST (UTC-5).
  - If the airtime does not seem to align when converting from the airtime Network's local timezone to your browser's timezone then it is likely the network needs to be mapped in Skyhook. [Contact the development team on Discord](https://discord.sonarr.tv/) for support with updating the Network's timezone.  

# Sonarr Common Problems

## Path is Already Configured for an Existing Series

- Library Import shows "Existing" or you get an error of "Path is configured for an existing series"
- This occurs when trying to add a series or edit an existing series's path that already is assigned to a different series.
- Likely this was caused by not correcting a mismatched series when the user imported their library.
- Locate and correct the movie that is already assigned to that series's path.
  - Series Index
  - Table View
  - Options => Add path as a column
  - Sort and find the movie at the noted problematic path.
- Alternatively, delete the series using the existing path from Sonarr

## System & Logs loads forever

- It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Sonarr is running on. But I still recommend checking the list.

## Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](/useful-tools#clearing-cookies-and-local-storage) wiki article.

## Web Interface Only Loads at localhost on Windows

- If you can only reach your web interface at <http://localhost:8989/> or <http://127.0.0.1:8989>, you need to run Sonarr as administrator at least once.

## I got a pop-up that said config.xml was corrupt, what now?

- Sonarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Sonarr back online, you will need to delete `.xml` in your [AppData Folder](/sonarr/appdata-directory) once deleted start Sonarr and it will start on the default port (8989), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

- If you're on non-Windows, most likely your mono's certificates are out of date and need to be synced. [See the section about mono ssl in the installation article for details](/sonarr/installation#mono-ssl-issues)
- Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?
  - Sonarr now validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Sonarr will refuse to connect. Free properly signed certificates are available from [let's encrypt](https://letsencrypt.org/).
  - If your download client and Sonarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` => `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Sonarr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Sonarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

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

## I see log messages for shows I do not have/do not want

- These messages are completely normal and come from the RSS feeds that Sonarr checks to see if there are episodes you do want, usually these only appear in debug/trace logging, but in the event of an problem processing an item you may see a warning or error. It is safe to ignore the warnings/errors as well since they are for shows you do not want, in the event it is for a show you want, open up a support thread on the forums.

## Seeding torrents aren't deleted automatically

- When a torrent that is still seeding is imported, it is copied or hard linked (if enabled and *possible*) so that the torrent client can continue seeding. In an ideal setup, the torrent download folder and the library folder will be on the same file system and *look like it* (Docker and network shares make this easy to get wrong), which makes hard links possible and minimizes wasted space.
- In addition, you can configure your seed time/ratio goals in Sonarr or your download client, setup your download client to *pause* or *stop* when they're met and enable Remove under Completed and Failed Download Handler. That way, torrents that finish seeding will be removed from the download client by Sonarr.

## Help, my Mac says Sonarr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac)
[![Developer Cannot be verified](/assets/general/faq_1_mac.png)]

## Help, my Mac says Sonarr.app is damaged and cannot be opened

- That is either due to a corrupt download so try again or [security issues, please see this related FAQ entry.](#help-my-mac-says-sonarr-cannot-be-opened-because-the-developer-cannot-be-verified)

## I am getting an error: Database disk image is malformed

> You may receive this after upgrading sqlite3 to 3.41. Sonarr v3.0.9 does not support sqlite3 3.41 due to a breaking default change. [Details on the issue can be found in Sonarr GHI #5464](https://github.com/Sonarr/Sonarr/issues/5464)
> This is resolved with Sonarr v3.0.10 and users should upgrade Sonarr accordingly.
{.is-warning}

- **Errors of `Error creating log database` indicate issues with logs.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with sonarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Sonarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backuprestore-my-sonarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use Sonarr on a Mac and it suddenly stopped working. What happened?

- Most likely this is due to a MacOS bug which caused one of the Sonarr databases to be corrupted.
- [Follow these steps to resolve](#i-am-getting-an-error-database-disk-image-is-malformed)
- Then attempt to launch Sonarr and see if it works. If it does not work, you will need further support. Post in our [reddit](http://reddit.com/r/Sonarr) or hop on [discord](https://discord.sonarr.tv/) for help.

## Why can Sonarr not see my files on a remote server?

- For all OSes ensure the user/group you're running \*Arr as has read and write access to the mounted drive.
- For Linux ensure:
  - If you're using an NFS mount ensure `nolock` is enabled for your mount.
  - If you're using an SMB mount ensure `nobrl` is enabled for your mount.
- For Windows: In short: the user \*Arr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is \*Arr  is running as a service, which causes the issues described below.

### Sonarr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Sonarr's service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Sonarr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.
- Run Sonarr.exe using the Startup Folder

### You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Sonarr.exe via the Startup Folder

## Mapped Network Drives vs UNC Paths

- Using mapped network drives generally doesn't work very well, especially when Sonarr is configured to run as a service. The better way to set shares up is using UNC paths. So instead of `X:\TV` use `\\Server\TV`.

- A key point to remember is that Sonarr gets path information from the downloader, so you will *also* need to setup NZBGet, SABNzbd or any other downloader to use UNC paths too.

## Sonarr will not work on Big Sur

Run

```shell
chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr
```

## My Custom Script stopped working after upgrading from v2

- You were likely passing arguments in your connection\...that is not supported.
- To correct this:
  1. Change your argument to be your path
  1. Make sure the shebang in your script maps to your pwsh path (if you do not have a shebang definition in there, add it)
  1. Make sure the pwsh script is executable

# Sonarr Searching & Downloading Common Problems

## Query Successful - No Results Returned

- [See this troubleshooting entry](/sonarr/troubleshooting#query-successful-no-results-returned)

## Why didn't Sonarr grab an episode I was expecting?

First, make sure you read and understand the section above called ["How does Sonarr find episodes?](#how-does-sonarr-find-episodes) Second, make sure at least one of your indexers has the episode you were expecting to be grabbed.

1. Click the 'Manual Search' icon next to the episode listing in Sonarr. Are there any results? If no, then either Sonarr is having trouble communicating with your indexers, or your indexers do not have the episode, or the episode is improperly named/categorized on the indexer.
1. **If there are results from step 1**, check next to them for red exclamation point icon. Hover over the icon to see why that release is not a candidate for automatic downloads. If every result has the icon, then no automatic download will occur.
1. **If there is at least one valid manual search result from step 2**, then an automatic download should have happened. If it didn't, the most likely reason is a temporary communication problem preventing an RSS Sync from your indexer. It is recommended to have several indexers set up for best results.
1. **If there is no manual result from a show, but you can find it when you browse your indexer's website** - This can be caused by a number of reasons, for example the release is not properly tagged on your indexer causing it to not be returned to sonarr in an automatic search. This [troubleshooting entry](/sonarr/troubleshooting#searches-indexers-and-trackers) provides some tips on how to determine the cause. Having several indexers active can help solve this by providing more sources to the same content.

## Found matching series via grab history, but release was matched to series by ID. Automatic import is not possible

- See [this troubleshooting entry](/sonarr/troubleshooting#found-matching-series-via-grab-history-but-series-was-matched-by-series-id-automatic-import-is-not-possible)

- On TVDb, when episode names are unknown they'll be titled TBA and there is a 24 hour cache on the TVDb API. Typically, changes to the TVDb website take 24-48 hours to reach Sonarr due to TVDb cache (24 hours), skyhook cache (a few hours), and the series refresh interval (every 12 hours). The [Episode Title Required setting](/sonarr/settings#importing) in Sonarr controls import behavior when the title is TBA, but after 48 hours from series airing the release will be imported even if the title is still TBA. There is also no automatic follow up renaming of TBA titled files. Note that the TBA timer is calculated from the episode airdate and time, not from when you've grabbed it or the upload time.

## Sonarr says Unknown Series on Searches or Imports

- See the [Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?](/sonarr/faq#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x) entry

## Jackett's /all Endpoint

{#jackett-all-endpoint}

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is required. Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)

- **February 5 2022 Update: \*Arr Support has been discontinued for the jackett `\all` endpoint. Jackett /all endpoint is no longer supported (e.g. warnings will occur) as of v3.0.6.1457 due to the fact it only causes issues.**

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

## Jackett shows more results than Sonarr when manually searching

- Check your configured categories for your tracker in Sonarr
- This is usually due to Sonarr searching Jackett differently than you do. [See this troubleshooting article for further information](/sonarr/troubleshooting#searches-indexers-and-trackers).

## Finding Cookies

- Some sites cannot be logged into automatically and require you to login manually then give the cookies to Sonarr to work. [Please see this article for details.](/useful-tools#finding-cookies)

## Unpack Torrents

- Most torrent clients doesn't come with the automatic handling of compressed archives like their usenet counterparts. We recommend [unpackerr](https://github.com/unpackerr/unpackerr).

## Permissions

- Sonarr will need to move files away from where the downloader puts them into the final location, so this means that Sonarr will need to read/write to both the source and the destination directory and files.
- On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and Sonarr. In umask notation, that would be `002`.

## Forced Authentication

- In Sonarr v4 (beta) authentication is mandatory. Please see the [Sonarr v4 FAQ - Forced Authentication](/sonarr/faq-v4#forced-authentication) for details
