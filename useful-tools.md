---
title: Useful Tools
description: 
published: true
date: 2021-07-15T00:13:39.047Z
tags: useful-tools
editor: markdown
dateCreated: 2021-06-05T20:51:53.183Z
---

The following apps are companions to the \*ARR Suite of Applications or media hoarding in general. They are neither maintained, developed, nor supported by the \*ARR Development Team. Please direct any specific support questions to the respective application development team.

## Common  Software

### DB Browser for SQLite

[DB Browser for SQLite (DB4S)](https://SQLitebrowser.org/) is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite. DB4S is for users and developers who want to create, search, and edit databases. DB4S uses a familiar spreadsheet-like interface, and complicated SQL commands do not have to be learned.

Open the `{*arr}.db` which can be found in the [Lidarr Appdata Directory](/lidarr/appdata-directory), [Prowlarr Appdata Directory](/prowlarr/appdata-directory), [Radarr Appdata Directory](/radarr/appdata-directory), [Readarr Appdata Directory](/readarr/appdata-directory), or [Sonarr Appdata Directory](/sonarr/appdata-directory).

#### Recovering a Corrupt DB

1. Make a copy of your corrupt DB
1. Open your corrupt DB in DB Browser for SQLite
1. File -> Export -> Export DB to SQL file
1. Select all tables
1. Check/Enable "Keep column names in INSERT INTO"
1. Export Everything
1. Overwrite old schema
1. Save
1. New DB -> File -> Import -> import that file
1. Any import errors or constraint issues, clean up the problematic insert statement if possible or delete it
1. Run a pragma check on the new DB
1. Save the DB and point the application at it

## Other Projects and Programs

### AMD

[Automated Music Downlaoder](https://github.com/RandomNinjaAtk/docker-amd) RandomNinjaAtk/amd is a Lidarr companion script to automatically download music for Lidarr

### AMVD

[Automated Music Video Downloader](https://github.com/RandomNinjaAtk/docker-amvd) RandomNinjaAtk/amvd is a Lidarr companion script to automatically download and tag Music Videos for use in other video applications (plex/kodi/jellyfin/emby)

### AMTD

[Automated Movie Trailer Downloader](https://github.com/RandomNinjaAtk/docker-amtd) RandomNinjaAtk/amtd is a Radarr companion script to automatically download movie trailers and extras for use in other video applications (plex/kodi/jellyfin/emby)

### Bazarr

[Bazarr](https://github.com/morpheus65535/bazarr) is a companion application to Sonarr and Radarr that manages and downloads subtitles based on your requirements.

### Cross-Seed

[Cross-Seed](https://github.com/mmgoodnow/cross-seed) is an app designed to help you download torrents that you can cross seed based on your existing torrents. It is designed to match conservatively to minimize manual intervention.  It supports Jackett and Qbittorrent/rTorrent at this time.

### Filebot

[FileBot](https://www.filebot.net/) is the ultimate tool for organizing and renaming your Movies, TV Shows and Anime as well as fetching subtitles and artwork. It's smart and just works.

### LunaSea

[LunaSea](https://www.lunasea.app/) is a fully featured, open source self-hosted controller! Focused on giving you a seamless experience between all of your self-hosted media software

### NZB360

[NZB360](https://nzb360.com/) is a full-featured NZB manager that focuses on providing the best experience possible for controlling all of your usenet needs.

### Notifiarr (fka Discord Notifier)

[Notifiarr](https://notifiarr.com/) is a tool created to facilitate more in-depth detailed discord notifications. It provides a configurable way to add notifications (including reactions) based on triggers you pick. Website provides a UI or picking what to show in the notification. Includes support for Grab, Import, Upgrade, Health, & Failed notifications in addition to much more.

[Setup Guide](https://trash-guides.info/Misc/Discord-Notifier-Basic-Setup/)

Highlights

- Application Status
- Requests and Approvals (\~Ombi, Requesterr)
- Customizable *ARR application notifications
- Request System with approvals
- Follow system for users to monitor a series or movie and be notified (via @mentions)
- Server Status
- Frequent New Features

### Ombi

[Ombi](https://github.com/tidusjar/Ombi/) gives users the ability to request movies, tv shows (series, seasons or single episodes) and music albums.

### Overseerr

[Overseerr](https://overseerr.dev/) is a request management and media discovery tool built to work with your existing Plex ecosystem.

### Petio

[Petio](https://petio.tv/) is a third party companion app available to Plex server owners to allow their users to request, review and discover content.

The app is built to appear instantly familiar and intuitive to even the most tech-agnostic users. Petio will help you manage requests from your users, connect to other third party apps such as Sonarr and Radarr, notify users when content is available and track request progress. Petio also allows users to discover media both on and off your server, quickly and easily find related content and review to leave their opinion for other users.

### qBit Management

[qBit Management](https://github.com/StuffAnThings/qbit_manage) is a program used to manage your qBittorrent instance such as:

- Tag torrents based on tracker URL (only tag torrents that have no tags)
- Update categories based on save directory
- Remove unregistered torrents (delete data & torrent if it is not being cross-seeded, otherwise it will just remove the torrent)
- Automatically add cross-seed torrents in paused state (used in conjunction with the [cross-seed script](#cross-seed))
- Recheck paused torrents sorted by lowest size and resume if completed
- Remove orphaned files from your root directory that are not referenced by qBittorrent

### Radarr & Sonarr Companion - Android App

Add new movies/shows to your system easily with your phone. App available at [Google Play](https://play.google.com/store/apps/details?id=easy.radarr)

### Tautulli

[Tautulli](https://tautulli.com/) is a 3rd party application that you can run alongside your Plex Media Server to monitor activity and track various statistics. Most importantly, these statistics include what has been watched, who watched it, when and where they watched it, and how it was watched. The only thing missing is "why they watched it", but who am I to question your 42 plays of Frozen. All statistics are presented in a nice and clean interface with many tables and graphs, which makes it easy to brag about your server to everyone else.

### Tdarr

[Tdarr](https://tdarr.io) is a closed-source self hosted web-app for automating media library transcode/remux management and making sure your files are exactly how you need them to be in terms of codecs/streams/containers etc. Designed to work alongside [Sonarr](/sonarr)/[Radarr](/radarr) and built with the aim of modularisation, parallelisation and scalability, each library you add has its own transcode settings, filters and schedule. Workers can be fired up and closed down as necessary, and are split into 3 types - 'general', 'transcode' and 'health check'. Worker limits can be managed by the scheduler as well as manually.

### Unpackerr

[Unpackerr](https://github.com/davidnewhall/unpackerr) This application runs as a daemon on your download host. It checks for completed downloads and extracts them so Radarr and/or Sonarr and/or Lidarr may import them.

There are a handful of options out there for extracting and deleting files after your client downloads them. I just didn't care for any of them, so I wrote my own. I wanted a small single-binary with reasonable logging that can extract downloaded archives and clean up the mess after they've been imported.

## Scripts & Things

## Twitter Connect

Create a Twitter application (if you haven't already) at <https://apps.twitter.com/>

Fill in the mandatory fields as well as the callback URL, set it to a publicly available URL (not localhost), it doesn't need to exist, but it does need to be set, using <https://sonarr.tv/twitter> or <https://radarr.video> is sufficient.
