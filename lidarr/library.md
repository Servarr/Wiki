---
title: Lidarr Library
description: Managing your music library in Lidarr including artist monitoring, album tracking, and metadata management
published: true
date: 2026-09-09T13:10:21.885Z
tags: lidarr, library, monitoring, albums, music, metadata, artists
editor: markdown
dateCreated: 2021-06-14T21:34:03.446Z
---

# Artists

The Artists index is the main view of your library. Each row represents an artist Lidarr is tracking, with columns showing monitoring status, quality and metadata profiles, album count, track availability, path, tags, and disk size.

## Views

The toolbar's **View** toggle switches between four display modes:

- **Table**: a sortable list with configurable columns. Use **Options** to show or hide individual columns.
- **Posters**: artist artwork in a grid, good for browsing a large library visually.
- **Banners**: wide banner art, one artist per row.
- **Overview**: artist art alongside a short biography and key stats.

## Actions

The toolbar above the artist list contains the following actions:

- **Update All** / **Update Filtered** / **Update Selected**: refreshes metadata for all artists, the current filtered view, or only the selected artists from the Servarr metadata server and rescans their folders.
- **RSS Sync**: polls your configured indexers' RSS feeds immediately, rather than waiting for the next scheduled sync.
- **Select Artists**: enters select mode, showing a footer with bulk-action buttons (Edit, Rename Files, Write Metadata Tags, Set App Tags, Update Monitoring, Delete) that apply to the artists you select.
- **Options**: shows or hides columns in Table view and adjusts poster/banner/overview size in the grid views.

## Filters

The **Filter** button narrows the artist list. Built-in filters:

- **All**: every artist in the library, monitored or not.
- **Monitored**: artists with monitoring enabled.
- **Unmonitored**: artists with monitoring disabled. Lidarr won't search for new releases from these artists.
- **Continuing**: artists whose career status is active/continuing.
- **Ended**: artists who are no longer releasing new music.
- **Missing**: artists that have at least one track with no file on disk.
- **Custom Filters**: you can build and save your own filters against any combination of artist fields (monitored status, quality profile, metadata profile, path, tags, added date, and more).

## Artist detail

Clicking an artist's name opens their detail page, which shows the artist biography, a full list of release groups, and the per-album track breakdown. From here you can:

- Toggle monitoring on individual albums or the artist as a whole.
- Trigger a refresh and rescan for just that artist.
- Edit the artist's quality profile, metadata profile, root folder, tags, and monitoring status.
- Trigger an automatic search for a specific album.

# Add New

The Add New tab is where you search for and add artists to Lidarr. Search by name or paste a MusicBrainz artist ID directly (prefixed with `lidarr:`, for example, `lidarr:9255f594-b912-4bdf-87a2-ada04502a459`). See [Finding music and MusicBrainz](/lidarr/faq#finding-music-and-musicbrainz) in the FAQ if an artist is hard to find.

When adding an artist you will set:

- **Root Folder**: the parent directory under which Lidarr will create the artist's folder.
- **Monitor**: which albums to monitor initially. See [Monitor](#monitor) below.
- **Monitor New Items**: how to handle albums Lidarr discovers later for this artist. See [Monitor New Items](#monitor-new-items) below.
- **Quality Profile**: the target quality and upgrade rules for this artist's files.
- **Metadata Profile**: which release group types (Album, Single, EP, etc.) and statuses to include in the artist's library.
- **Tags**: optional tags to assign to the artist for use in custom filters and profiles.
- **Start Search for Missing Albums**: triggers an immediate search after adding, rather than waiting for the next scheduled search.

## Monitor

{#monitor}

**Monitor** is a one-time action, applied to whatever albums Lidarr already has on file at the moment it runs, whether that's when you first add the artist, or later via the **Update Monitoring** bulk action. It does not reach forward to catch albums added to MusicBrainz afterward; that's what [Monitor New Items](#monitor-new-items) is for.

| Option | Sets monitored to true for |
|---|---|
| **All Albums** | Every album. |
| **Future Albums** | Albums with no file that have a release date in the future. Already-released albums, with or without a file, are unmonitored. |
| **Missing Albums** | Albums with no file, whether already released or upcoming. |
| **Existing Albums** | Albums that already have a file. |
| **First Album** | Only the album with the earliest release date. |
| **Latest Album** | Only the album with the most recent release date. |
| **None** | Nothing. |

> The in-app tooltip for **Existing Albums** currently reads "Monitor albums that have files or have not released yet," which duplicates the **Missing Albums** wording and doesn't match what the option does. Based on `AlbumMonitoredService.cs`, **Existing Albums** monitors only albums that already have a file.
{.is-warning}

## Monitor New Items

{#monitor-new-items}

**Monitor New Items** is an ongoing, artist-level setting. Unlike **Monitor** above, it doesn't run once — it fires every time a metadata refresh finds an album for this artist that isn't already in Lidarr's database.

| Option | Behavior |
|---|---|
| **All Albums** | Monitor every newly discovered album. |
| **New Albums** | Monitor a newly discovered album only if its release date is on or after the most recent release date Lidarr already has on file for that artist. |
| **None** | Leave newly discovered albums unmonitored. |

**New Albums** is a release-date comparison against your existing catalog, not a check of when MusicBrainz added the album to its database. An album that has existed on MusicBrainz for years but is only now appearing in Lidarr (for example, after a merge or a metadata correction) is monitored or skipped based purely on its release date relative to what you already have, regardless of when it showed up in Lidarr.

> **Monitor** and **Monitor New Items** are easy to conflate, and setting **Monitor = Future Albums** does not give you the same result as **Monitor New Items = New Albums**. **Monitor** only ever looks at albums Lidarr already knows about at the instant it runs. If MusicBrainz adds a new future release to an artist's discography afterward, **Monitor** won't touch it; only **Monitor New Items** decides what happens to it when Lidarr's next refresh picks it up.
{.is-warning}

# Library Import

Library Import is for bringing an existing organised music collection into Lidarr. It scans a root folder, matches what it finds to MusicBrainz release groups, and imports matched files into Lidarr's library without moving or copying them.

See [Importing an Existing Library](/lidarr/importing-existing-library) for the full walkthrough, including how to prepare your files, what the matching thresholds are, and what to do when files don't match automatically.

> Library Import is for an already-organised library. To import files from a download folder, use **Manual Import** from the toolbar instead.
{.is-info}
