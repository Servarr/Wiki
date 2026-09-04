---
title: Lidarr Settings
description: Complete configuration guide for Lidarr settings including media management, profiles, quality definitions, and metadata preferences
published: true
date: 2026-07-27T22:18:04.365Z
tags: lidarr, settings, configuration, quality, profiles, metadata, media
editor: markdown
dateCreated: 2021-06-14T21:36:07.513Z
---

# Lidarr Settings

This page covers all settings available in Lidarr. For field-level detail on a specific area, jump directly to the relevant section below.

# Media Management

{#media-management}

## Track Naming

### Rename Tracks

When enabled, Lidarr renames imported track files according to the format strings below, and reveals the [Standard Track Format and Multi Disc Track Format](#naming-format) fields. When disabled, Lidarr imports files using their original filenames. It still manages the folder structure but leaves individual filenames as-is.

> Renaming files that a torrent client is currently seeding will break seeding unless you are using hardlinks. See [Hardlinks and Completed Downloads](/lidarr/concepts#hardlinks-and-completed-downloads) before enabling this.
{.is-warning}

### Replace Illegal Characters

Replaces characters in filenames that aren't valid on the target filesystem (for example, `: / \ * ? " < > |` on Windows). When disabled, Lidarr won't sanitize filenames and imports may fail on restricted filesystems.

## Naming Format

The format strings below use tokens to build file and folder names. For a full token reference, see the [Naming Guide](/lidarr/naming-guide).

> **Standard Track Format** and **Multi Disc Track Format** are hidden until you enable **Rename Tracks** under [Track Naming](#track-naming) above.
{.is-info}

### Standard Track Format

The filename template for regular single-disc track files. Lidarr appends the file extension automatically.

Example: `{Album Title}/{track:00} {Track Title}` → `Blood on the Tracks/01 Tangled Up in Blue.flac`

### Multi Disc Track Format

The filename template for tracks on releases with more than one disc. Use `{medium:00}` to include the disc number.

Example: `{Album Title}/{medium:00}-{track:00} {Track Title}` → `Mellon Collie/01-01 Mellon Collie and the Infinite Sadness.flac`

> Enable **Settings → Show Advanced** to reveal **Artist Folder Format**.
{.is-info}

### Artist Folder Format

The folder name template for each artist at the root folder level. Only artist-level tokens work here.

Example: `{Artist Name}` → `/music/The Beatles/`

## Folders

| Setting | Default | Description |
|---|---|---|
| **Create Empty Artist Folders** | Off | Lidarr creates an artist folder immediately when you add an artist, even before importing any tracks. |
| **Delete Empty Folders** | Off | Lidarr automatically removes empty artist and album folders after deleting or moving files. |

## Importing

| Setting | Default | Description |
|---|---|---|
| **Skip Free Space Check** | Off | Skip the available disk space check before importing. Only enable this if Lidarr can't correctly detect free space (some network shares and unusual storage setups). |
| **Minimum Free Space** | 100 MB | Lidarr will refuse to import if available space in the root folder falls below this value. |
| **Use Hardlinks Instead of Copy** | On | Use hardlinks when the source and destination are on the same filesystem. Hardlinks avoid copying data and allow seeding to continue. Falls back to copy if hardlinks aren't supported. |
| **Import Extra Files** | Off | Import sidecar files with the same base name alongside audio files at import time (for example, lyric files, NFO files, cover images). See below. |
| **Extra File Extensions** | (empty) | Comma-separated list of file extensions to import when you enable **Import Extra Files**. Example: `lrc,nfo,jpg,png`. Don't use `*`; the code treats it as a literal character, not a wildcard, and it matches nothing. |

### How Import Extra Files works

When enabled, Lidarr scans the **same directory as each downloaded track file** immediately after that track imports. It looks for sidecar files: files whose name (without extension) starts with the track's name (without extension). For example, when importing `01 Song.flac`, Lidarr will consider `01 Song.lrc`, `01 Song.nfo`, and `01 Song.jpg` as candidates. Lidarr ignores files like `cover.jpg` or `album.nfo` whose name doesn't start with the track's filename.

Matching files are then filtered against the configured extension list. Files that pass are:

1. Moved into the **library folder** alongside the imported track (or hardlinked/copied if the download is seeding and is read-only).
2. Renamed to match the track filename, preserving the extension.
3. Recorded in Lidarr's database and associated with the track file.

**NFO files:** Lidarr imports only the first NFO file found in the source folder per run. Lidarr skips later NFO files from the same folder to prevent duplicates.

**Lyric files** (`.lrc`, `.txt`, `.utf`, `.utf8`, `.utf-8`): a separate lyric manager handles these with priority over the general extra-file handler. Lidarr imports them with the same base name as the track and renames them alongside it.

**When you move an artist to a new root folder**, all files in the artist directory move together at the filesystem level, including extra files Lidarr isn't tracking. Lidarr tracks extra files relative to the artist folder, so stored paths update correctly during the move.

> The `*` wildcard isn't supported in the extension list. The code matches by `filename.EndsWith(extension)`; a file never literally ends in `*`. List explicit extensions only.
{.is-warning}

## File Management

| Setting | Default | Description |
|---|---|---|
| **Unmonitor Deleted Tracks** | Off | When something outside Lidarr deletes a track file from disk, automatically unmonitor that track. |
| **Download Propers and Repacks** | Prefer and Upgrade | How to handle proper/repack releases. **Prefer and Upgrade** grabs and upgrades to propers when found. **Don't Upgrade Automatically** includes them in scores but won't autograb. **Don't Prefer** treats them as equal to the original release. |
| **Analyse Audio Files** | On | Read audio file metadata (bitrate, sample rate, bit depth) to improve quality detection. Disabling this makes quality detection rely solely on filename parsing. |
| **Rescan Artist Folder after Refresh** | Always | When to rescan an artist folder after a metadata refresh. **Always** rescans every time. **After Manual Refresh** only rescans when triggered manually. **Never** disables rescanning. |
| **Watch Library for File Changes** | On | Monitor the library folder for external file changes (additions, deletions, renames). Disabling this means Lidarr only discovers changes during scheduled rescans. |

## Permissions

These settings apply to Linux and macOS only. Leave disabled on Windows.

| Setting | Default | Description |
|---|---|---|
| **Set Permissions** | Off | Set file and folder permissions on imported files. |
| **chmod Folder** | 755 | Octal permission mode applied to folders on import (for example, `755` = rwxr-xr-x). |
| **chown Group** | (empty) | Group to assign to imported files and folders. The Lidarr process user must be a member of this group. |

## Recycling Bin

| Setting | Default | Description |
|---|---|---|
| **Recycle Bin** | (empty) | Path to a recycling bin folder. When Lidarr deletes files, they're moved here rather than permanently deleted. Leave empty to skip the recycle bin. |
| **Recycle Bin Cleanup** | 7 days | Number of days before files in the recycle bin are permanently deleted. Set to `0` to disable automatic cleanup. |

## Root Folders

Root folders are the top-level directories where Lidarr stores your library. Each imported artist gets a subfolder inside a root folder.

Click **Add (+)** to add a root folder. The path must exist and Lidarr must have read and write access to it. A root folder must not overlap with your download client's output directory.

> Don't point a root folder at a cloud storage mount (Dropbox, OneDrive, Google Drive). Lidarr writes audio tags and metadata frequently; cloud storage APIs have rate limits that will cause failures.
{.is-warning}

## Metadata Profiles

{#metadata-profiles}

Metadata profiles control which release types are visible per artist. Lidarr hides releases whose type isn't in the assigned profile and won't monitor or search for them.

### Fields

| Field | Description |
|---|---|
| **Name** | Profile name. |
| **Release Types** | Checkboxes for each MusicBrainz release type. Only releases matching a checked type appear for artists using this profile. |

### Release Types

| Type | Description |
|---|---|
| **Albums** | Standard studio albums. |
| **Singles** | Single releases (one or a few tracks). |
| **EPs** | Extended plays, longer than a single but shorter than an album. |
| **Broadcasts** | Live broadcasts, radio sessions, and similar. |
| **Others** | Release types not covered by the above categories. |

You can include or exclude secondary types (Compilation, Soundtrack, Spokenword, Interview, Live, Remix, DJ-Mix, Mixtape, Demo, etc.) as extra filters on top of the primary type selection.

> MusicBrainz determines release types. If a release you expect to see is missing, check its entry on MusicBrainz: the type may be `Unknown`, which Lidarr can't filter on, or the primary type may be one you have unchecked in your profile.
{.is-info}

## Release Profiles

{#release-profiles}

Release profiles filter and score releases based on their titles. Use them to require certain terms, reject others, or shift scoring without creating a full custom format.

### Fields

| Field | Description |
|---|---|
| **Must Contain** | Comma-separated list of terms (or regex patterns) that a release title must include. Lidarr rejects releases that don't match. |
| **Must Not Contain** | Comma-separated list of terms a release title must not include. Lidarr rejects releases that match any term. |
| **Preferred** | Terms with associated scores. Positive scores boost a release; negative scores penalise it. Separate terms with commas to share a score across more than one term. |
| **Include Preferred when Renaming** | If enabled, Lidarr appends the matched preferred term to the filename during rename. Useful for tagging releases from specific groups in the filename. |
| **Indexers** | Restrict this profile to specific indexers. Leave empty to apply to all indexers. |
| **Tags** | Restrict this profile to artists with matching tags. Leave empty to apply to all artists. |

> Release profiles apply at **grab/download time**: they filter and score releases from indexers before Lidarr sends anything to a download client. They have no effect on which MusicBrainz release (pressing, edition, format) Lidarr matches your already-downloaded files to during import. See [FAQ → Can Lidarr prefer a specific pressing or format during import?](/lidarr/faq#can-lidarr-prefer-a-specific-pressing-or-format-during-import) for the import side of this.
{.is-info}

## Custom Formats

{#custom-formats-2}

Custom formats score releases based on patterns matched against the release title and indexer flags. Unlike release profiles, which require or reject terms absolutely, custom formats assign a numeric score that accumulates across all matched formats. A quality profile can then set a **Minimum Custom Format Score**. Releases below that threshold aren't grabbed.

Click **Add (+)** to create a format, or **Import** to paste a JSON definition.

> Like release profiles, custom formats apply at **grab/download time**: Lidarr computes scores against indexer release titles before sending anything to a download client. They don't influence which MusicBrainz release Lidarr matches an already-downloaded file to during import.
{.is-info}

### Specifications

Each custom format contains one or more specifications. A specification defines a single matching rule, for example "release title contains `\bFLAC\b`" or "release is from indexer X." Specifications within a format combine with AND logic (all must match for the format to fire) unless you tick **Negate** (inverts the match) or adjust the **Required** flag.

Common specification types for music:

| Specification | Matches against |
|---|---|
| **Release Title** | The full release title string from the indexer. Supports regex. |
| **Release Group** | The release group part of the title, if parseable. |
| **Indexer Flag** | Indexer-specific flags (Freeleech, Halfleech, etc.) where the indexer supports them. |
| **Size** | The reported release size. Matches when the size falls between the configured **Minimum Size** and **Maximum Size** (in GB). |

For worked examples and suggested scoring values for a FLAC-focused library, see [Tips and Tricks → Custom Formats](/lidarr/tips-and-tricks#custom-formats).

### Testing release title parsing

Two ways to test how Lidarr will parse a release name before committing to a profile:

**In Lidarr:** Use the **Test Parsing** button on the Settings → Custom Formats page. Enter a release title and Lidarr shows the parsed fields (source, quality, release group, etc.) alongside which custom formats match and their combined score. This is the fastest way to confirm a specification fires as expected.

**Via the Servarr Discord bot:** In the `#bot-spam` channel, run `/parser lidarr <release title>` (for example, `/parser lidarr Artist.Album.2022.FLAC-GROUP`). The bot replies with the same parsed breakdown. Useful for quick spot-checks without opening the UI.

# Quality

{#quality}

The Quality page defines size thresholds for each quality level. Lidarr uses these to check that a release's reported size is consistent with the claimed quality, catching mislabelled releases.

For audio, size limits use **kilobits per second (kbps)**. Lidarr computes a bitrate from the file size and duration and compares it to the configured range.

| Column | Description |
|---|---|
| **Quality** | The quality name (for example, FLAC, MP3-320, MP3-256). |
| **Min** | Minimum acceptable bitrate in kbps. Lidarr rejects releases below this. Set to `0` to disable the lower bound. |
| **Preferred** | The bitrate Lidarr aims for when scoring releases. Releases at this level receive a higher score than those at the minimum. |
| **Max** | Maximum acceptable bitrate in kbps. Lidarr rejects releases above this. Set to `0` for no upper limit. |

> FLAC is lossless and doesn't have a consistent bitrate; its effective bitrate varies by content. The FLAC entry in quality definitions serves primarily as a file-size sanity check rather than strict bitrate enforcement.
{.is-info}

# Indexers

{#indexer-settings}

> Find information on supported indexers at the [Supported](/lidarr/supported#indexers) page.
{.is-info}

Indexers are the sources Lidarr searches for releases: Usenet indexers (Newznab-compatible) or torrent trackers. Click **Add (+)**, choose an indexer type, and fill in its connection details.

## Common Fields (all indexers)

| Field | Description |
|---|---|
| **Name** | Label for this indexer, shown in activity and logs. |
| **Enable RSS** | Whether Lidarr includes this indexer in periodic RSS sync (the automatic background search for new releases). |
| **Enable Automatic Search** | Whether Lidarr uses this indexer for automatic searches, triggered from the UI or by Lidarr itself (for example, on a missing-album search). |
| **Enable Interactive Search** | Whether this indexer's results appear when you manually search for a release from the UI. |
| **Indexer Priority** | 1 (highest) to 50 (lowest). Default: 25. Used as a tiebreaker when grabbing between otherwise-equal releases from different indexers. All enabled indexers are still used for RSS sync and searching regardless of priority. |
| **(Advanced) Download Client** | Pin this indexer's grabs to a specific download client instead of Lidarr's normal client-selection logic. |
| **Tags** | Restrict this indexer to artists with at least one matching tag. Leave empty to use it for all artists. |

Most Usenet (Newznab-compatible) indexers additionally need a **URL**, **API Path** (defaults to `/api`), **API Key**, and **Categories**. Torrent indexers vary by type but commonly need a **URL** and either an **API Key** or a cookie/session-based login, plus **Minimum Seeders** and, for private trackers, seed ratio and seed time goals.

## Options

{#indexer-options}

Global settings that apply across all indexers, found under **Settings → Indexers → Options**.

| Setting | Description |
|---|---|
| **Minimum Age** | Usenet only. Minimum age in minutes of an NZB before Lidarr will grab it. Gives new releases time to propagate across Usenet providers. |
| **Maximum Size** | Maximum release size in MB. Lidarr rejects releases larger than this. Set to `0` for unlimited. |
| **Retention** | Usenet only. Set to `0` for unlimited retention. |
| **(Advanced) RSS Sync Interval** | Interval in minutes between automatic RSS syncs. Set to `0` to disable all automatic release grabbing. This applies to every indexer; follow the usage rules each indexer sets for itself. See [FAQ → How does Lidarr work?](/lidarr/faq#how-does-lidarr-work) for how RSS sync fits into Lidarr's overall search cycle. |

# Download Clients

{#download-clients}

> Find information on supported download clients at the [Supported](/lidarr/supported#download-clients) page.
{.is-info}

## Overview

Lidarr sends download requests to a configured client, monitors the client's queue via its API, and imports finished files into the library. The download client and Lidarr must both be able to read and write to the same filesystem path. Mismatched paths are the most common cause of import failures.

## How Downloading Works

### Usenet

1. Lidarr sends a download request to the Usenet client with a configured category label.
2. Lidarr monitors the client's queue via its API for items in that category.
3. When the download completes, Lidarr reads the reported file path, scans it for audio files, and imports them into the library.
4. Lidarr uses atomic moves (instantaneous moves within the same filesystem) by default. If the download folder and library folder are on different filesystems, Lidarr falls back to copy + delete, which uses more I/O and temporary disk space.

### BitTorrent

1. Lidarr sends a download request to the torrent client with a category label.
2. Lidarr monitors the client's queue for items in that category.
3. When the download completes, Lidarr imports the files. If the download folder and library folder are on the same filesystem, Lidarr creates a **hardlink**: the file appears in both locations without using extra disk space, and seeding continues uninterrupted.
4. The torrent client retains the original files so seeding can continue. Lidarr requests removal only after seeding finishes (when you enable **Remove** and the client reaches its seed goal).

> The download folder and library root folder must be on the **same filesystem** for hardlinks to work. In Docker, both must be mounted through the same volume or bind mount. See [Hardlinks and Completed Downloads](/lidarr/concepts#hardlinks-and-completed-downloads) and [TRaSH's Hardlink Guide](https://trash-guides.info/hardlinks) for setup details.
{.is-info}

## Download Client Settings

Click **Add (+)**, choose a client type, and fill in the connection details.

### Common Fields (all clients)

| Field | Description |
|---|---|
| **Name** | Label for this client, shown in activity and logs. |
| **Enable** | Whether Lidarr actively monitors this client. |
| **Host** | Hostname or IP of the download client. |
| **Port** | Port the client's web UI or API listens on. |
| **Use SSL** | Connect to the client over HTTPS. |
| **(Advanced) URL Base** | Path prefix for the client, needed when behind a reverse proxy (for example, `/sabnzbd`). |
| **Username / Password** | Credentials if the client requires authentication. |
| **Category** | Category or label to apply to Lidarr's downloads. Lidarr only monitors items in this category; setting one is strongly recommended to avoid conflicts with other applications sharing the same client. |
| **Recent Priority** | Priority level for recently released music. |
| **Older Priority** | Priority level for back-catalogue music. |
| **(Advanced) Client Priority** | Order among clients of the same type. `1` = highest priority; `50` = lowest. Lidarr uses round-robin among equal-priority clients. |

### Usenet-Only Fields

| Field | Description |
|---|---|
| **API Key** | API key to authenticate with the Usenet client. |

### Torrent-Only Fields

| Field | Description |
|---|---|
| **Post-Import Category** | Category to assign after import. Note: setting this disables completed-download removal, since Lidarr can no longer identify the torrent as one it manages. |
| **Initial State** | Whether new torrents start paused or downloading immediately. |

### Torrent Client Seed Goal Compatibility

Lidarr can set seed ratio and time goals via the torrent client's API when you add a torrent, but not all clients support this.

| Client | Seed Ratio | Seed Time |
| :---: | :---: | :---: |
| Deluge | ✓ | ✗ |
| Download Station | ✗ | ✗ |
| Flood | ✓ | ✓ |
| Hadouken | ✗ | ✗ |
| qBittorrent | ✓ | ✓ |
| rTorrent | ✓ | ✓ |
| Torrent Blackhole | ✗ | ✗ |
| Transmission | ✓ | Idle Limit only |
| uTorrent | ✓ | ✓ |
| Vuze | ✓ | ✓ |

## Completed Download Handling

| Setting | Description |
|---|---|
| **Enable** (Advanced, global) | Automatically import completed downloads from the download client. Disabling this means Lidarr will never import anything, so leave it enabled unless you have a specific reason to disable it. |
| **Remove** (per-client) | After import, ask the download client to remove the completed item. For torrents, removal only occurs when the client reports seeding is complete and the torrent is paused/stopped. |

### Failed Download Handling

Failed download handling is available for SABnzbd and NZBGet only. It isn't supported for torrent clients.

| Setting | Description |
|---|---|
| **Redownload** | When a download fails, automatically search for a replacement. |
| **(Advanced) Remove** | Remove the failed download from the client when Lidarr detects the failure. |

When Lidarr detects a failure, it logs it, optionally removes the failed item, searches for a replacement, and blocklists the failed release so it isn't grabbed again automatically.

## Remote Path Mappings

You need remote path mappings when Lidarr and the download client see the same files at different paths. This happens when they run on separate machines or in separate Docker containers with different volume mount paths.

A mapping translates a remote path (as reported by the download client) to a local path (as Lidarr accesses it). Add a mapping per client under **Settings → Download Clients → Remote Path Mappings**.

> If both Lidarr and the download client are in Docker containers on the same host with matching volume mounts, a remote path mapping isn't needed. See [TRaSH's Remote Path Mapping guide](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/) for diagnosis and setup.
{.is-info}

# Connect

{#connections}

> Find information on supported connection types at the [Supported](/lidarr/supported#notifications) page.
{.is-info}

Connections send notifications or trigger actions when events occur in Lidarr. Common uses include Discord or Slack notifications on import, Plex library updates, and custom scripts.

Click **Add (+)** and select a connection type. Most connections share these fields:

| Field | Description |
|---|---|
| **Name** | Label for this connection. |
| **On Grab** | Trigger when Lidarr sends a release to a download client. |
| **On Release Import** | Trigger when a downloaded release is successfully imported. |
| **On Upgrade** | Trigger when Lidarr upgrades a file to better quality. |
| **On Rename** | Trigger when Lidarr renames files. |
| **On Artist Added** | Trigger when you add an artist to Lidarr. |
| **On Artist Deleted** | Trigger when you remove an artist. |
| **On Album Delete** | Trigger when Lidarr deletes an album. |
| **On Track Retag** | Trigger when audio tags are rewritten. |
| **On Health Issue** | Trigger when a health check fails. |
| **On Health Restored** | Trigger when a health check recovers. |
| **On Application Update** | Trigger when Lidarr updates to a new version. |
| **Include Health Warnings** | Include `Warning`-level health issues in health notifications (not just `Error`). |

For **Custom Script** connections, see the [Custom Scripts](/lidarr/custom-scripts) page for the full list of environment variables available per event.

# Metadata

{#metadata}

## Write Metadata to Audio Files

{#write-metadata-to-audio-files}

| Setting | Description |
|---|---|
| **Tag Audio Files with Metadata** | **All files, keep in sync with MusicBrainz**: writes tags on import and rewrites them whenever the MusicBrainz data changes. **All files, initial import only**: writes tags once, on import. **For new downloads only**: only files imported from now on get tags; files already in the library are left alone. **Never**: Lidarr never writes audio tags. |
| **Embed Cover Art in Audio Files** | Embeds Lidarr's album art into the audio file itself when writing tags. Only shown when tag writing is enabled. |
| **Scrub Existing Tags** | Removes existing tags from a file before writing, leaving only the tags Lidarr itself adds. |

> Choosing **All files, keep in sync with MusicBrainz** or **All files, initial import only** alters existing files the first time they're imported or re-synced, not just new downloads.
{.is-warning}

## Metadata Consumers

Below **Write Metadata to Audio Files**, the Metadata page lists external metadata formats Lidarr can write to disk alongside your music: NFO files for media-center software (Kodi/XBMC), and image sidecar formats for Roksbox and WD TV. Enable a consumer and choose which of Artist Metadata, Album Metadata, Artist Images, and Album Images it writes. See [Supported → Metadata](/lidarr/supported) for what each consumer generates and which media players read it.

# Tags

{#tags}

Tags link artists, indexers, delay profiles, and release profiles together. A tag on an artist and a matching tag on a delay profile means that delay profile applies to that artist. Without a matching tag, the default (untagged) delay profile applies.

Tags are particularly useful for:

- Assigning a specific indexer to specific artists (for example, a private tracker that only carries jazz: tag it `jazz` and tag the relevant artists `jazz`).
- Assigning a non-default delay profile to a subset of artists.
- Restricting a release profile to certain artists.
- Tracking which import list added an artist.

# General

{#general}

General settings live under **Settings → General**.

## Host

{#host}

- Bind Address - Valid IPv4 address or `*` for all interfaces.
  - `0.0.0.0` or `*` - any address can connect.
  - `127.0.0.1` or `localhost` - only localhost applications can connect.
  - Any other IP (for example `1.2.3.4`) - only that IP can connect.
- Port Number - The port used to access the Lidarr web UI.
- URL Base - For reverse proxy support; default is empty.
- Allowed Hosts - Which hostnames (including FQDN, Fully Qualified Domain Names) or IP Addresses Lidarr will accept as a valid host. This setting is required if Authentication Required is not set to `Enabled`. This is the host portion of the address you enter in your address bar of your browser to access Lidarr.
  - IP Address: `192.168.50.1`
  - Hostname: `lidarr`
  - FQDN: `lidarr.example.com`
  - Wildcard subdomain: `*.example.com` - For example `lidarr.example.com` or any other subdomain would be accepted.
  - Docker with a `.internal` suffix: `*.internal` - accepts container hostnames such as `lidarr.internal` when you name your containers with a `.internal` suffix.
  - A blank value is accepted only when Authentication Required is `Enabled`; otherwise at least one host is required and a blank value is rejected on save.
- Enable SSL - If you have SSL credentials and would like to secure communication to and from Lidarr, enable this option.

## Security

{#security}

- Authentication - How would you like to authenticate to access your Lidarr instance
  - None - You have no authentication to access your Lidarr. Typically if you're the only user of your network, do not have anybody on your network that would care to access your Lidarr or your Lidarr is not exposed to the web
  - Basic (Browser pop-up) - This option when accessing your Lidarr will show a small pop-up allowing you to input a Username and Password
  - Forms (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Lidarr
  - External - Hands authentication off entirely to a reverse proxy (e.g. Authelia, Organizr) placed in front of Lidarr. Not selectable in the UI; set it via `config.xml` or the `LIDARR__AUTH__METHOD` environment variable. Lidarr performs no authentication of its own in this mode, so Authentication Required and Trust CGNAT IP Addresses have no effect
- Authentication Required - Controls which requests must authenticate. Do not change this unless you understand the risks.
  - Enabled - Always require authentication (recommended)
  - Disabled for Local Addresses - Skip authentication for requests Lidarr identifies as coming from localhost or the LAN

> With Authentication Required set to `Disabled for Local Addresses`, a request that spoofs the `X-Forwarded-For` header can appear local and skip authentication unless Lidarr is behind a properly configured reverse proxy whose address is listed under Trusted Networks below. Lidarr only trusts `X-Forwarded-For` from addresses in that list. If you do not run a trusted reverse proxy, set Authentication Required to `Enabled`, or put Lidarr behind a VPN or Tailscale rather than exposing it directly.
{.is-warning}

- API Key - This is how other programs would communicate or have Lidarr communicate to other programs. This key if given to the wrong person with access could do all kinds of things to your library. This is why in the logs the API key is redacted
- Certificate Validation - Change how strict HTTPS certification validation is
  - Enabled - Validate all HTTPS certificates (recommended)
  - Disabled for Local Addresses - Validate all HTTPS certificates except those on localhost and the LAN
  - Disabled - Do not validate any HTTPS certificates
- Trusted Networks - Comma-separated list of IP addresses or CIDR networks that trusted reverse proxies are on (for example `172.17.0.1`, `10.0.0.0/8`, or `fc00::/7`). Lidarr only trusts the `X-Forwarded-For` header from these addresses. Only add proxies that are properly configured to send the correct headers.

> Trust CGNAT IP Addresses - Not exposed in the UI. Set via `config.xml` or the `LIDARR__AUTH__TRUSTCGNATIPADDRESSES` environment variable (default `false`). When enabled, Lidarr treats CGNAT addresses (`100.64.0.0/10`, the range Tailscale uses) as local for the Authentication Required `Disabled for Local Addresses` check. It has no effect with any other Authentication Required or Authentication setting.
{.is-info}

# Logging

{#logging}

Logging options live under **Settings → General → Logging**.

| Setting | Default | Description |
|---|---|---|
| **Log Level** | Info | `Info`, `Debug`, or `Trace`. Debug and Trace produce substantially more output; use them for diagnosing a specific problem, not as a permanent setting. |
| **(Advanced) Log Size Limit** | 1 MB | Maximum size of a single log file before Lidarr archives it and starts a new one, in MB (1 to 10). |

> Trace logging should only be enabled temporarily. Leaving it on generates large log files and can itself affect performance on slower systems.
{.is-warning}

See [System → Log Files](/lidarr/system#log-files) for where log files live on disk and how log rotation works.
