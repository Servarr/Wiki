The following apps are companions to the ARR Suite of Applications. They
are neither maintained, developed, nor supported by the ARR Dev Teams.
Please direct any specific support questions to the respective
application development team.

## Common Software

### DB Browser for SQLite

[DB Browser for SQLite (DB4S)](https://sqlitebrowser.org/) is a high
quality, visual, open source tool to create, design, and edit database
files compatible with SQLite. DB4S is for users and developers who want
to create, search, and edit databases. DB4S uses a familiar
spreadsheet-like interface, and complicated SQL commands do not have to
be learned.

Open the `{arr}.db` which can be found in the [Lidarr Appdata
Directory](Lidarr_Troubleshooting#AppData_Directory "wikilink"), [Radarr
Appdata Directory](Radarr_Troubleshooting#AppData_Directory "wikilink"),
[Readarr Appdata
Directory](Readarr_Troubleshooting#AppData_Directory "wikilink"), or
[Sonarr Appdata
Directory](Sonarr_Troubleshooting#AppData_Directory "wikilink").

#### Recovering a Corrupt DB

1.  Make a copy of your corrupt DB
2.  Open your corrupt DB in DB Browser for Sqlite
3.  File -\> Export -\> Export DB to SQL file
    1.  Select all tables
    2.  Check/Enable "Keep column names in INSERT INTO"
    3.  Export Everything
    4.  Overwrite old schema
    5.  Save
4.  New DB -\> File -\> Import -\> import that file
5.  Any import errors or constraint issues, clean up the problematic
    insert statement if possible or delete it
6.  Run a pragma check on the new DB
7.  Save the DB and point the application at it

## Other Projects and Programs

### Bazarr

[Bazarr](https://github.com/morpheus65535/bazarr) is a companion
application to Sonarr and Radarr that manages and downloads subtitles
based on your requirements.

### Discord Notifier

[Discord Notifier](https://discordnotifier.com/) is a tool created to
facilitate more in-depth detailed discord notifications. It provides a
configurable way to add notifications (including reactions) based on
triggers you pick. Website provides a UI or picking what to show in the
notification. Includes support for Grab, Import, Upgrade, Health, &
Failed notifications.

[Setup
Guide](https://trash-guides.info/Misc/Discord-Notifier-Basic-Setup/)

Highlights

  - Application Status
  - Requests and Approvals (\~Ombi, Requesterr)
  - Customizable ARR application notifications
  - Request System with approvals
  - Follow system for users to monitor a series or movie and be notified
    (via @mentions)
  - Server Status
  - Frequent New Features

### Filebot

[FileBot](https://www.filebot.net/) is the ultimate tool for organizing
and renaming your Movies, TV Shows and Anime as well as fetching
subtitles and artwork. It's smart and just works.

### NZBHydra2

[NZBHydra (NZBHydra 2)](https://github.com/theotherp/nzbhydra2) is a
meta search for newznab indexers and torznab trackers. It provides easy
access to newznab indexers and many torznab trackers via Jackett. You
can search all your indexers and trackers from one place and use it as
an indexer source for tools like Sonarr, Radarr, Lidarr or CouchPotato.

### Jackett

[Jackett](https://github.com/Jackett/Jackett) works as a proxy server:
it translates queries from apps ([Sonarr](Sonarr "wikilink"),
[Radarr](Radarr "wikilink"), [SickRage](https://sickrage.github.io/),
[CouchPotato](https://couchpota.to/),
[Mylar](https://github.com/evilhero/mylar), etc) into
tracker-site-specific http queries, parses the html response, then sends
results back to the requesting software. This allows for getting recent
uploads (like RSS) and performing searches.

### Ombi

[Ombi](https://github.com/tidusjar/Ombi/) gives users the ability to
request movies, tv shows (series, seasons or single episodes) and music
albums.

### Radarr & Sonarr Companion - Android App

Add new movies/shows to your system easily with your phone. App
available at [Google
Play](https://play.google.com/store/apps/details?id=easy.radarr)

### Tautulli

[Tautulli](https://tautulli.com/) is a 3rd party application that you
can run alongside your Plex Media Server to monitor activity and track
various statistics. Most importantly, these statistics include what has
been watched, who watched it, when and where they watched it, and how it
was watched. The only thing missing is "why they watched it", but who am
I to question your 42 plays of Frozen. All statistics are presented in a
nice and clean interface with many tables and graphs, which makes it
easy to brag about your server to everyone else.

### Tdarr

[Tdarr](https://tdarr.io) is a closed-source self hosted web-app for
automating media library transcode/remux management and making sure your
files are exactly how you need them to be in terms of
codecs/streams/containers etc. Designed to work alongside
[Sonarr](Sonarr "wikilink")/[Radarr](Radarr "wikilink") and built with
the aim of modularisation, parallelisation and scalability, each library
you add has its own transcode settings, filters and schedule. Workers
can be fired up and closed down as necessary, and are split into 3 types
- 'general', 'transcode' and 'health check'. Worker limits can be
managed by the scheduler as well as manually.

### Unpackerr

[Unpackerr](https://github.com/davidnewhall/unpackerr) This application
runs as a daemon on your download host. It checks for completed
downloads and extracts them so Radarr and/or Sonarr and/or Lidarr may
import them.

There are a handful of options out there for extracting and deleting
files after your client downloads them. I just didn't care for any of
them, so I wrote my own. I wanted a small single-binary with reasonable
logging that can extract downloaded archives and clean up the mess after
they've been imported.

### AMD

[Automated Music
Downlaoder](https://github.com/RandomNinjaAtk/docker-amd)
RandomNinjaAtk/amd is a Lidarr companion script to automatically
download music for Lidarr

### AMVD

[Automated Music Video
Downloader](https://github.com/RandomNinjaAtk/docker-amvd)
RandomNinjaAtk/amvd is a Lidarr companion script to automatically
download and tag Music Videos for use in other video applications
(plex/kodi/jellyfin/emby)

### AMTD

[Automated Movie Trailer
Downloader](https://github.com/RandomNinjaAtk/docker-amtd)
RandomNinjaAtk/amtd is a Radarr companion script to automatically
download movie trailers and extras for use in other video applications
(plex/kodi/jellyfin/emby)

## Scripts & Things

## Twitter Connect

Create a Twitter application (if you haven't already) at
<https://apps.twitter.com/>

Fill in the mandatory fields as well as the callback URL, set it to a
publicly available URL (not localhost), it doesn't need to exist, but it
does need to be set, using <https://sonarr.tv/twitter> or
<https://radarr.video> is sufficient.
