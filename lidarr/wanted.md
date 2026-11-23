---
title: Lidarr Wanted
description: Managing wanted albums, manual searches, and download monitoring in Lidarr's Wanted section
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, wanted, monitoring, albums, search, missing
editor: markdown
dateCreated: 2021-06-14T21:35:43.417Z
---

# Wanted

The Wanted section has two tabs, **Missing** and **Cutoff Unmet**, covering albums Lidarr is actively searching for or trying to upgrade.

# Missing

The Missing tab lists every monitored album that has no files on disk. Albums appear here once their release date has passed and Lidarr hasn't been able to find or import them.

## Toolbar actions

- **Search Selected**: triggers an automatic search for the albums you have checked.
- **Unmonitor Selected** / **Monitor Selected**: toggles monitoring for the checked albums. The label changes depending on the active filter — when viewing monitored albums it shows **Unmonitor Selected**; when viewing unmonitored albums it shows **Monitor Selected**.
- **Search All**: triggers an automatic search for every album currently shown in the list. If a filter is active, only filtered results are searched.
- **Manual Import**: opens the manual import dialog, letting you match files in any accessible folder to albums in your library. Use this when you have files on disk that Lidarr hasn't picked up automatically. See [Import Troubleshooting](/lidarr/import-troubleshooting) for guidance.
- **Options**: opens Table Options to configure page size and visible columns.
- **Filter**: narrows the list, including toggling between monitored and unmonitored albums.

## Per-row actions

Each row has two action icons on the right:

- **Automatic Search** (magnifying glass): triggers an automatic search for that album only.
- **Interactive Search** (interactive icon): opens the interactive search dialog scoped to that album, letting you browse and manually pick a release.

## Options

| Option | Default | Description |
| --- | --- | --- |
| Page Size | 20 | Number of albums shown per page. |
| Columns | (see below) | Choose which columns are visible and their display order. |

Available columns: Artist Name, Album Title, Album Type, Release Date, Last Searched, Actions.

# Cutoff Unmet

The Cutoff Unmet tab lists albums that have files on disk but haven't yet reached the quality target defined in their Quality Profile. Lidarr will continue searching for an upgrade for these albums until the cutoff is met.

An album appears here when the file Lidarr has is below the **Cutoff** quality set in the artist's Quality Profile. For example, if you have an MP3 but your profile's cutoff is FLAC. Once a file at or above the cutoff quality is imported, the album drops off this list.

## Toolbar actions

- **Search Selected**: triggers an upgrade search for the checked albums.
- **Unmonitor Selected** / **Monitor Selected**: toggles monitoring for the checked albums. The label changes depending on the active filter — when viewing monitored albums it shows **Unmonitor Selected**; when viewing unmonitored albums it shows **Monitor Selected**.
- **Search All**: triggers an upgrade search for every album currently shown in the list.
- **Options**: opens Table Options to configure page size and visible columns.
- **Filter**: narrows the list, including toggling between monitored and unmonitored albums.

## Per-row actions

Each row has two action icons on the right:

- **Automatic Search** (magnifying glass): triggers an automatic upgrade search for that album only.
- **Interactive Search** (interactive icon): opens the interactive search dialog scoped to that album, letting you browse and manually pick a release.

## Options

| Option | Default | Description |
| --- | --- | --- |
| Page Size | 20 | Number of albums shown per page. |
| Columns | (see below) | Choose which columns are visible and their display order. |

Available columns: Artist Name, Album Title, Album Type, Release Date, Last Searched, Actions.
