---
title: Useful Tools
description: 
published: true
date: 2022-01-31T19:43:56.218Z
tags: useful-tools
editor: markdown
dateCreated: 2021-06-05T20:51:53.183Z
---

The following apps are companions to the \*Arr Suite of Applications or media hoarding in general. They are not maintained, developed, nor supported by the \*Arr Development Team. Please direct any specific support questions to the respective application development team.

# Recovering a Corrupt DB

Note that the application's database can be found in the Application Data Directory which are linked below. The directory may also be passed as a datadir argument.

- [Lidarr Appdata Directory](/lidarr/appdata-directory)
- [Prowlarr Appdata Directory](/prowlarr/appdata-directory)
- [Radarr Appdata Directory](/radarr/appdata-directory)
- [Readarr Appdata Directory](/readarr/appdata-directory)
- [Sonarr Appdata Directory](/sonarr/appdata-directory)
{.links-list}

> There are two options to recover the database.{.is-info}
- [Using DB Browser for SQLite and using the UI](#recovering-a-corrupt-db-ui)
- [Using Sqlite's `.recover` function](#command-line-db-recovery)
{.links-list}

## Recovering a Corrupt DB (UI) (Windows)

{#windows}
{#recovering-a-corrupt-db-ui}

> Note this effectively does the same as `.recover` which requires Sqlite v3.29 | [Please refer to the Sqlite docs for more details on the `.recover` command](https://www.sqlite.org/cli.html#recover_data_from_a_corrupted_database). The steps to do so are linked below {.is-info}

> [DB Browser for SQLite (DB4S)](https://SQLitebrowser.org/) is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite. DB4S is for users and developers who want to create, search, and edit databases. DB4S uses a familiar spreadsheet-like interface, and complicated SQL commands do not have to be learned.
{.is-info}

1. Stop the application
1. Make a copy of your corrupt database (`.db`) and copy any `.shm` and `.wal` files with it
1. Open your corrupt database in [DB Browser for SQLite (DB4S)](https://SQLitebrowser.org/)
1. File => Export => Export database to SQL file
1. Select all tables
1. Check/Enable "Keep column names in INSERT INTO"
1. Export Everything
1. Overwrite old schema
1. Save
1. New Database => File => Import => import that file
1. Any import errors or constraint issues, clean up the problematic insert statement if possible or delete it
1. Run a pragma check on the new database
1. Remove all `wal`, `shm`, and `db` files from the config folder
1. Save the new database in the config folder and point the application at it. All \*Arrs name their database as `<appname>.db` e.g. `radarr.db`
1. Correct permissions for the recovered database if needed. The owner should be the user and group \*Arr is configured to run as.
1. Start the application

![dbrecover.gif](/dbrecover.gif)

## Command Line DB Recovery

{#nix}

The below instructions are for \*Nix Operating Systems, but the concept will be similar on Windows Command Line.

> This uses the [sqlite3 `.recover` command](https://www.sqlite.org/cli.html#recover_data_from_a_corrupted_database) is ideal. Note that it requires Sqlite 3.29+
{.is-info}

> Given sqlite3 is required by \*Arrs it is assumed you have sqlite3 installed on your system {.is-info}

1. Stop the application
1. SSH into your box or otherwise get a shell up
1. Enter `sqlite3 <path to bad database> ".recover" | sqlite3 <output path for recovered database>`
1. Correct permissions for the recovered database if needed. The owner should be the user and group \*Arr is configured to run as.
1. Remove or move/rename the old corrupt database and any `wal` or `shm` in the folder
1. Rename the covered database. All \*Arrs name their database as `<appname>.db` e.g. `radarr.db`
1. Start the application

# Finding Cookies

- Some sites cannot be logged into automatically and require you to login manually then give the cookies to to work. The pages below describe how you do that.

## Chrome

- Go to the torrent tracker website and log in.

- Hit F12

- Under the Application tab at the top, there will be "Storage" on the left side. You will see a "Cookies" subsection, and under that you will see IPT's url. Click on that.

- Click on "Pass" on that screen, and it will pop up a box that says "Cookie Value" with a string about 25-30 chars long. Copy that and paste it into the application that needs it.

![cookie_chrome.png](/assets/prowlarr/cookie_chrome.png)
Firefox

![faq_3_cookies.png](/assets/general/faq_3_cookies.png)

- You may also reference Chrome's documents [Chrome cookies](https://developer.chrome.com/docs/devtools/storage/cookies/)

## Firefox

- [Please see Mozilla's documentation](https://developer.mozilla.org/en-US/docs/Tools/Storage_Inspector/Cookies)

# Clearing Cookies and Local Storage

## Chrome

1. Navigate to `chrome://settings/siteData`
1. Enter the site (or app) name you wish to clear
1. Click the trash icon for the site

## Firefox

- Please see [Mozilla's Help Article](https://support.mozilla.org/en-US/kb/clear-cookies-and-site-data-firefox)

## Microsoft Edge (Chromium)

1. Navigate to `edge://settings/siteData`
1. Enter the site (or app) name you wish to clear
1. Click the arrow for the site
1. Click the trash icon for the site

# Other Projects and Programs

## AMD

[Automated Music Downloader](https://github.com/RandomNinjaAtk/docker-amd) RandomNinjaAtk/amd is a Lidarr companion script to automatically download music for Lidarr

## AMVD

[Automated Music Video Downloader](https://github.com/RandomNinjaAtk/docker-amvd) RandomNinjaAtk/amvd is a Lidarr companion script to automatically download and tag Music Videos for use in other video applications (plex/kodi/jellyfin/emby)

## AMTD

[Automated Movie Trailer Downloader](https://github.com/RandomNinjaAtk/docker-amtd) RandomNinjaAtk/amtd is a Radarr companion script to automatically download movie trailers and extras for use in other video applications (plex/kodi/jellyfin/emby)

## Bazarr

[Bazarr](https://github.com/morpheus65535/bazarr) is a companion application to Sonarr and Radarr that manages and downloads subtitles based on your requirements.

## Cross-Seed

[Cross-Seed](https://github.com/mmgoodnow/cross-seed) is an app designed to help you download torrents that you can cross seed based on your existing torrents. It is designed to match conservatively to minimize manual intervention. It supports Jackett and Qbittorrent/rTorrent at this time.

## Filebot

[FileBot](https://www.filebot.net/) is the ultimate tool for organizing and renaming your Movies, TV Shows and Anime as well as fetching subtitles and artwork. It's smart and just works.

## LunaSea

[LunaSea](https://www.lunasea.app/) is a fully featured, open source self-hosted controller! Focused on giving you a seamless experience between all of your self-hosted media software

## JDupes

[Jdupes](https://github.com/jbruchon/jdupes) is a program for identifying and taking actions upon duplicate files.

> TRaSH [has a guide](https://trash-guides.info/jdupes) as well {.is-info}

- `jdupes -M -r "/data/tv/" "/data/tv/.torrents/"` <= this would check for double files and print a summary of the results

- `jdupes -L -r "/data/tv/" "/data/tv/.torrents/"` <= this would recreate them as hardlinks thus reducing the used duplicate space

## NZB360

[NZB360](https://nzb360.com/) is a full-featured NZB manager that focuses on providing the best experience possible for controlling all of your usenet needs.

## Notifiarr (fka Discord Notifier)

[Notifiarr](https://notifiarr.com/) is a tool created to facilitate more in-depth detailed discord notifications by one of the \*Arr Developers. It provides a configurable way to add notifications (including reactions) based on triggers you pick. Website provides a UI or picking what to show in the notification. Includes support for Grab, Import, Upgrade, Health, & Failed notifications in addition to much more.

[Wiki](https://notifiarr.wiki/)

Highlights

- Application Status
- Requests and Approvals (\~Ombi)
- Customizable *ARR application notifications
- Request System with approvals
- Follow system for users to monitor a series or movie and be notified (via @mentions)
- Server Status
- Frequent New Features

## Ombi

[Ombi](https://github.com/tidusjar/Ombi/) gives users the ability to request movies, tv shows (series, seasons or single episodes) and music albums.

## Overseerr

[Overseerr](https://overseerr.dev/) is a request management and media discovery tool built to work with your existing Plex ecosystem.

## Petio

[Petio](https://petio.tv/) is a third party companion app available to Plex server owners to allow their users to request, review and discover content.

The app is built to appear instantly familiar and intuitive to even the most tech-agnostic users. Petio will help you manage requests from your users, connect to other third party apps such as Sonarr and Radarr, notify users when content is available and track request progress. Petio also allows users to discover media both on and off your server, quickly and easily find related content and review to leave their opinion for other users.

## Plex Meta Manager

[Plex Meta Manager (PMM)](https://github.com/meisnate12/Plex-Meta-Manager) is a Python script to update metadata information for movies, shows, and collections as well as automatically build collections.

## qBit Management

[qBit Management a.k.a. "qbit_manage"](https://github.com/StuffAnThings/qbit_manage) is a program used to manage your qBittorrent instance such as:

- Tag torrents based on tracker URL (only tag torrents that have no tags)
- Update categories based on save directory
- Remove unregistered torrents (delete data & torrent if it is not being cross-seeded, otherwise it will just remove the torrent)
- Automatically add cross-seed torrents in paused state (used in conjunction with the [cross-seed script](#cross-seed))
- Recheck paused torrents sorted by lowest size and resume if completed
- Remove orphaned files from your root directory that are not referenced by qBittorrent
- Tag any torrents that have no hard links and allows optional cleanup to delete these torrents and contents based on maximum ratio and/or time seeded

## Radarr & Sonarr Companion - Android App

Add new movies/shows to your system easily with your phone. App available at [Google Play](https://play.google.com/store/apps/details?id=easy.radarr)

## Tautulli

[Tautulli](https://tautulli.com/) is a 3rd party application that you can run alongside your Plex Media Server to monitor activity and track various statistics. Most importantly, these statistics include what has been watched, who watched it, when and where they watched it, and how it was watched. The only thing missing is "why they watched it", but who am I to question your 42 plays of Frozen. All statistics are presented in a nice and clean interface with many tables and graphs, which makes it easy to brag about your server to everyone else.

## Tdarr

[Tdarr](https://tdarr.io) is a closed-source self hosted web-app for automating media library transcode/remux management and making sure your files are exactly how you need them to be in terms of codecs/streams/containers etc. Designed to work alongside [Sonarr](/sonarr)/[Radarr](/radarr) and built with the aim of modularization, parallelization and scalability, each library you add has its own transcode settings, filters and schedule. Workers can be fired up and closed down as necessary, and are split into 3 types - 'general', 'transcode' and 'health check'. Worker limits can be managed by the scheduler as well as manually.

## Unpackerr

[Unpackerr](https://github.com/davidnewhall/unpackerr) This application runs as a daemon on your download host. It checks for completed downloads and extracts them so Radarr and/or Sonarr and/or Lidarr may import them.

There are a handful of options out there for extracting and deleting files after your client downloads them. I just didn't care for any of them, so I wrote my own. I wanted a small single-binary with reasonable logging that can extract downloaded archives and clean up the mess after they've been imported.

# Scripts & Things

# Twitter Connect

Create a Twitter application (if you haven't already) at <https://apps.twitter.com/>

Fill in the mandatory fields as well as the callback URL, set it to a publicly available URL (not localhost), it doesn't need to exist, but it does need to be set, using <https://sonarr.tv/twitter> or <https://radarr.video> is sufficient.
