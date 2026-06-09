---
title: Lidarr File Naming Guide
description: Common file and folder naming schemes for Lidarr music organization including custom formats and multi-disc album handling
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, naming, configuration
editor: markdown
dateCreated: 2024-03-30T13:23:53.095Z
---

# Lidarr File Naming Guide

Lidarr renames and organises files on import according to four configurable templates: **Standard Track Format**, **Multi-Disc Track Format**, **Artist Folder Format**, and **Album Folder Format**. Getting these right before you populate your library. Changing them later forces a full rename of every file the next time Lidarr refreshes each artist.

> Changing any naming template after you have populated your library will rename every existing file the next time Lidarr refreshes that artist. Test on a small artist first, and make sure your backup is current before changing naming on a large library.
{.is-warning}

# Before you choose a format

## OS path limits and illegal characters

**Windows** enforces a 260-character limit on full file paths by default. Most users hit this limit on nested libraries. Long album titles and artist names compound fast: `Root\Artist\Album\Track.flac` can push 200 characters before the filename. The `:N` truncation syntax (see below) is the standard workaround. Most Windows-friendly naming conventions cap tokens at 100-150 characters.

**Windows also prohibits** these characters in file and folder names: `\ / : * ? " < > |`. Lidarr's **Replace Illegal Characters** setting handles these automatically, but be aware that Lidarr substitutes or removes characters that are valid on Linux/macOS (colons in particular) on Windows.

**Linux and macOS** have a 255-byte limit per path component and prohibit only `/` and null bytes. Long names aren't a practical problem unless you share the library with a Windows machine.

## Media server compatibility

Different media servers have different expectations about music library folder structure:

- **Plex** expects `Artist/Album/Track` folder nesting. It reads tags for metadata and uses the folder structure as a secondary hint. Plex doesn't require the release year in the album folder but many users include it to disambiguate re-issues.
- **Navidrome** reads only tags and is indifferent to folder structure, so almost any sane layout works.
- **Jellyfin** follows MusicBrainz conventions and works best with `Artist/Album/Track` nesting, a release year in the album folder, and accurate MusicBrainz tags in the files themselves.

If you run more than one media server against the same library, choose a format that the pickiest server accepts. Plex and Jellyfin tend to be the most restrictive.

## Cost of changing naming later

Every naming change triggers a rename of all files the next time Lidarr refreshes the artist. On a large library this means thousands of file moves. All must be on the same filesystem for hardlinks (or full copies if they're not). Media servers will also need to re-scan after a mass rename. It's worth spending time upfront to pick a format you can live with permanently.

# Naming token reference

Wrap tokens in `{}`. Lidarr substitutes them at import time. Any token that resolves to an empty string Lidarr omits, including any surrounding literal text that's inside the same `{}`. This is how conditional formatting works (for example, `{ (Album Disambiguation)}` produces nothing if there's no disambiguation string).

**Truncation:** append `:N` inside any token to cap the rendered value at N characters: `{Album Title:150}` truncates to 150 characters. Use this on Windows to stay within path limits.

## Artist tokens

| Token | Description |
|---|---|
| `{Artist Name}` | Full artist name as stored in MusicBrainz. |
| `{Artist NameThe}` | Artist name with a leading "The" moved to the end, for example, `Beatles, The`. Useful for consistent alphabetical sorting. |
| `{Artist CleanName}` | Artist name with illegal filesystem characters removed. |
| `{Artist CleanNameThe}` | Clean artist name with "The" moved to the end. |
| `{Artist Disambiguation}` | Disambiguation string from MusicBrainz, for example, `UK band`. Empty for most artists. |
| `{Artist Genre}` | First genre tag associated with the artist. |
| `{Artist NameFirstCharacter}` | First letter of the artist name (after moving "The" to the end). Useful for alphabetical sub-folder grouping, for example, `A`, `B`, `#`. |
| `{Artist MbId}` | MusicBrainz artist ID (UUID). |

## Album tokens

| Token | Description |
|---|---|
| `{Album Title}` | Album title. |
| `{Album TitleThe}` | Album title with a leading "The" moved to the end. |
| `{Album CleanTitle}` | Album title with illegal filesystem characters removed. |
| `{Album CleanTitleThe}` | Clean album title with "The" moved to the end. |
| `{Album Disambiguation}` | Disambiguation string from MusicBrainz. Useful when an artist has two albums with the same name. |
| `{Album Type}` | Release group type: Album, Single, EP, Compilation, Live, Remix, Soundtrack, etc. |
| `{Album Genre}` | First genre tag for the album. |
| `{Album MbId}` | MusicBrainz album (release group) ID (UUID). |
| `{Release Year}` | Four-digit release year. |

## Track tokens

| Token | Description |
|---|---|
| `{Track Title}` | Track title. |
| `{Track CleanTitle}` | Track title with illegal filesystem characters removed. |
| `{Track ArtistName}` | Track-level artist name. Useful for Various Artists compilations where each track has a different credited artist. |
| `{Track ArtistCleanName}` | Track artist name with illegal filesystem characters removed. |
| `{Track ArtistNameThe}` | Track artist name with "The" moved to the end. |
| `{Track ArtistCleanNameThe}` | Clean track artist name with "The" moved to the end. |
| `{Track ArtistMbId}` | MusicBrainz ID of the track-level artist. |
| `{track:00}` | Track number zero-padded to 2 digits (01, 02 … 99). Use `{track:000}` for 3-digit padding on large releases. |

## Medium (disc) tokens

| Token | Description |
|---|---|
| `{medium:0}` | Disc number, single digit. |
| `{medium:00}` | Disc number zero-padded to 2 digits. |
| `{Medium Format}` | Physical format of the disc: CD, Vinyl, Digital Media, etc. |
| `{Medium Name}` | Name of the disc as stored in MusicBrainz (for example, `Disc 1`). |

## Quality and technical tokens

| Token | Description |
|---|---|
| `{Quality Title}` | Quality profile name as defined in Lidarr (for example, FLAC, MP3-320). |
| `{Quality Full}` | Full quality string including proper/repack designation. |
| `{Quality Proper}` | `Proper` or `Repack` when applicable; empty otherwise. |
| `{MediaInfo AudioBitRate}` | Audio bitrate (for example, 320kbps). Only available after import; blank on pre-import rename previews. |
| `{MediaInfo AudioChannels}` | Number of audio channels. |
| `{MediaInfo AudioCodec}` | Audio codec (for example, FLAC, MP3). |
| `{MediaInfo AudioSampleRate}` | Audio sample rate (for example, 44100Hz). |
| `{MediaInfo AudioBitsPerSample}` | Bit depth of the audio (for example, 24-bit). |

## Miscellaneous tokens

| Token | Description |
|---|---|
| `{Release Group}` | Ripping or encoding group tag from the file. Defaults to `Lidarr` when no group tag is present and the token is used without surrounding separators. |
| `{Original Title}` | Scene name of the file if available; falls back to the original filename without extension. |
| `{Original Filename}` | Original filename without extension. |
| `{Custom Formats}` | All custom formats that have "Include Custom Format when Renaming" enabled, joined by spaces. |
| `{Custom Format}` | A specific custom format by name, for example `{Custom Format:FLAC}`. Empty when the format is not matched or not enabled for renaming. |

# Community naming conventions

Community members contributed the following formats as tested starting points, not official recommendations. Each covers Standard Track Format, Multi-Disc Track Format, and Artist Folder Format. Read the trade-offs before adopting one wholesale.

## Davo's convention

From Davo's [community guide](/lidarr/community-guide). Puts the album folder inside the artist folder, uses underscores as separators, and includes a disambiguation token so identically named albums don't collide.

### Standard Track Format

```jinja
{Album Title} {(Album Disambiguation)}/{Artist Name}_{Album Title}_{track:00}_{Track Title}
```

### Multi-Disc Track Format

```jinja
{Album Title} {(Album Disambiguation)}/{Artist Name}_{Album Title}_{medium:00}-{track:00}_{Track Title}
```

### Artist Folder Format

```jinja
{Artist Name}
```

## B's convention

Limits folder and file lengths to avoid Windows path-limit issues. **Not recommended for Windows**: the truncated paths can become inaccessible after a Lidarr rename on that OS. See the [FAQ entry on Windows folder access after rename](/lidarr/faq#why-cant-i-access-a-folder-in-windows-after-lidarr-rename). Useful for libraries containing artists with notoriously long album titles.

### Standard Track Format

```jinja
{Album CleanTitle:100} {(Release Year)}/{Artist CleanName:100} - {Album CleanTitle:100} - {track:00} - {Track Title:100}
```

### Multi-Disc Track Format

```jinja
{Album CleanTitle:100} ({Release Year})/{Medium Format} {medium:00}/{Artist CleanName:100} - {Album CleanTitle:100} - {track:00} - {Track Title:100}
```

### Artist Folder Format

```jinja
{Artist Name}
```

## PearsonFlyer's convention

Embeds quality and bitrate in the filename, which makes file provenance visible at a glance in any file browser. The `{-Release Group}` token at the end renders as nothing when no group tag is present.

### Standard Track Format

```jinja
{Album Title} ({Release Year})/{Artist Name} - {Album Title} - {track:00} - {Track Title} ({Quality Full} {MediaInfo AudioBitRate}) {-Release Group}
```

### Multi-Disc Track Format

```jinja
{Album Title} ({Release Year})/{Medium Format} {medium:00}/{Artist Name} - {Album Title} - {medium:00}-{track:00} - {Track Title} ({Quality Full} {MediaInfo AudioBitRate}) {-Release Group}
```

### Artist Folder Format

```jinja
{Artist NameThe} {(Artist Disambiguation)}
```

## JasonVelocity's convention

Groups albums by type at the top level, then by year and title. Works well with Plex and avoids collisions when an artist has more than one release group sharing the same name and year. The 150-character cap on most tokens keeps paths safe on Windows. `CleanNameThe` moves "The" to the end for cleaner folder sorting.

### Standard Track Format

```jinja
{Album Type}/({Release Year}) {Album Title:150}{ (Album Disambiguation:150)}/{track:00} - {Track ArtistNameThe:150} - {Album Title:150} - {Track Title:150}
```

### Multi-Disc Track Format

```jinja
{Album Type}/({Release Year}) {Album Title:150}{ (Album Disambiguation:150)}/{medium:0}{track:00} - {Track ArtistNameThe:150} - {Album Title:150} - {Track Title:150}
```

### Artist Folder Format

```jinja
{Artist CleanNameThe:150} {(Artist Disambiguation:150)}
```

## Fra's convention

Minimal format aligned with [Plex's music folder naming recommendations](https://support.plex.tv/articles/200265296-adding-music-media-from-folders/#toc-0). Relies entirely on tags for metadata. Only the track number and title are in the filename, which keeps names short and readable.

### Standard Track Format

```jinja
{Album Title}/{track:00} - {Track Title}
```

### Multi-Disc Track Format

```jinja
{Album Title}/{medium:0}{track:00} - {Track Title}
```

### Artist Folder Format

```jinja
{Artist Name}
```
