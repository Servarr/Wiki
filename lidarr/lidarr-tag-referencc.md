---
title: Lidarr Audio Tags Reference
description: Complete list of the metadata fields Lidarr writes into audio files on import, where each one is stored per file format, and the rules that govern when writing happens
published: true
date: 2026-09-12T11:26:03.301Z
tags: lidarr, reference, metadata, musicbrainz, tagging
editor: markdown
dateCreated: 2026-09-12T11:26:03.301Z
---

# Lidarr Audio Tags Reference

This page lists every metadata field Lidarr can write into an audio file, and the conditions under which it writes them. It's a companion to the [Write Metadata to Audio Files](/lidarr/settings#write-metadata-to-audio-files) setting: that page explains the on/off/sync options, this page lists what actually lands in the file once tagging is enabled.

> Tag writing is off by default. Nothing in this page applies until you set **Tag Audio Files with Metadata** to something other than **Never** in [Settings → Metadata](/lidarr/settings#write-metadata-to-audio-files).
{.is-warning}

# When Lidarr writes tags

Lidarr only writes tags to a file in these situations:

- **On import**, when the applicable **Tag Audio Files with Metadata** option covers the import type (new download vs. library scan).
- **On retag**, triggered manually from the artist or album context menu, or automatically whenever MusicBrainz data changes, if **All files, keep in sync with MusicBrainz** is selected.
- **Never**, if the file is linked to more than one track. Lidarr can't safely tag a single file that represents multiple tracks, so it skips it entirely and leaves existing tags untouched.

Before writing, Lidarr reads the file's current tags and compares them against what it's about to write. If nothing differs, it skips the file rather than rewriting it unnecessarily. If **Scrub Existing Tags** is on, Lidarr removes all existing tags first, so the result contains only the fields listed below, nothing else that was in the file before.

# Fields Lidarr writes

## Track and album fields

| Field | Source | Notes |
|---|---|---|
| Title | Track title | |
| Artist | Track's credited artist name | |
| Album Artist | Album's artist name | |
| Album | Album title | |
| Track | Absolute track number | |
| Track Count | Number of tracks on the same medium | |
| Disc | Medium number | |
| Disc Count | Number of media in the release | |
| Media Format | Format of the medium, for example CD or Vinyl | Taken from the medium matching the track, not the first medium in the release. |
| Label | Release label | First label listed on the release, if more than one is credited. |
| Genres | Album genres | Falls back to the artist's genres if the album has none. |

## Dates

| Field | Source | Notes |
|---|---|---|
| Date | Release date of the specific release matched to this file | |
| Year | Album release year | |
| Original Release Date | Album's original release date | Distinguishes a reissue's release date from the date the album was first released. |
| Original Year | Year portion of Original Release Date | |

## MusicBrainz identifiers

| Field | Source |
|---|---|
| MusicBrainz Artist Id | Track's credited artist |
| MusicBrainz Release Artist Id | Album artist |
| MusicBrainz Release Id | The matched release |
| MusicBrainz Release Group Id | The album (release group) |
| MusicBrainz Track Id | The recording (despite the name, this holds the MusicBrainz *recording* ID, not the track ID) |
| MusicBrainz Release Track Id | The track on the specific matched release |
| MusicBrainz Release Country | Two-letter country code for the release |
| MusicBrainz Release Status | Official, promotion, bootleg, etc. |
| MusicBrainz Release Type | Album, single, EP, compilation, etc. |
| MusicBrainz Album Comment | Album disambiguation string, for example "remastered" |

## Cover art

If **Embed Cover Art in Audio Files** is enabled, Lidarr embeds the album's cover image into the file. Turning this setting off doesn't strip an image already embedded from a previous tagging pass; the existing picture is left alone unless **Scrub Existing Tags** is also on, in which case scrubbing removes it and nothing replaces it.

# Where fields are stored per format

Most fields above map to the standard tag for the format in use, for example Title becomes `TIT2` in ID3v2 and `TITLE` in Vorbis comments. A handful of fields don't have a standard home in every format and get format-specific treatment:

| Field | ID3v2 (MP3) | Vorbis comments (FLAC, Ogg) |
|---|---|---|
| Media Format | `TMED` | `MEDIA` |
| Date | `TDRC` (ID3v2.4) or `TYER`/`TDAT` (ID3v2.3) | `DATE` |
| Original Release Date | `TDOR` (ID3v2.4) or `TORY` (ID3v2.3, year only) | `ORIGINALDATE` and `ORIGINALYEAR` |
| MusicBrainz Album Comment | `TXXX:MusicBrainz Album Comment` | `MUSICBRAINZ_ALBUMCOMMENT` |
| MusicBrainz Release Track Id | `TXXX:MusicBrainz Release Track Id` | `MUSICBRAINZ_RELEASETRACKID` |
| MusicBrainz Release Status | standard mapping | `MUSICBRAINZ_ALBUMSTATUS`, plus `RELEASESTATUS` for compatibility with alternate Picard mappings |
| MusicBrainz Release Type | standard mapping | `MUSICBRAINZ_ALBUMTYPE`, plus `RELEASETYPE` for compatibility with alternate Picard mappings |
| Label | standard mapping | `LABEL` (not `ORGANIZATION`, which some tools default to) |

Lidarr also handles APEv2 (Monkey's Audio, WavPack), ASF (WMA), and MP4/M4A container tags for these same fields, using each format's native equivalent of the boxes above.

> ID3v2.3 can't store a full original release date, only a year. If a file uses ID3v2.3 and the original release date isn't January 1, Lidarr's retag preview shows this as an "Original Year" change instead of an "Original Release Date" change.
{.is-info}

# See also

- [Settings: Write Metadata to Audio Files](/lidarr/settings#write-metadata-to-audio-files): the setting that controls if and when these fields get written
- [Importing an Existing Library: Tagging](/lidarr/importing-existing-library#tagging): how existing tags affect import matching, the reverse direction of what this page covers
- [Metadata Troubleshooting](/lidarr/metadata-troubleshooting): diagnosing MusicBrainz data problems that show up in these fields
- [File Naming Guide](/lidarr/naming-guide): the companion reference for how Lidarr names and organizes files on import
