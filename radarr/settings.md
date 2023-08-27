---
title: Radarr Settings
description: Description of Radarr's Settings Menus
published: true
date: 2023-08-27T22:02:11.780Z
tags: radarr, needs-love, settings
editor: markdown
dateCreated: 2021-05-29T15:57:25.304Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Menu options](#menu-options)
- [Media Management](#media-management)
  - [Community Naming Suggestions](#community-naming-suggestions)
  - [Movie Naming](#movie-naming)
    - [Standard Movie Format](#standard-movie-format)
    - [Movie Naming](#movie-naming-1)
    - [Movie IDs](#movie-ids)
    - [Quality](#quality)
    - [Media Info](#media-info)
    - [Release Group](#release-group)
    - [Edition](#edition)
    - [Custom Formats (Naming)](#custom-formats-naming)
    - [Original](#original)
  - [Movie Folder Format](#movie-folder-format)
    - [Movie Naming](#movie-naming-2)
    - [Movie ID](#movie-id)
  - [Folders](#folders)
  - [Importing](#importing)
  - [File Management](#file-management)
  - [Permissions](#permissions)
  - [Root Folders](#root-folders)
- [Profiles](#profiles)
  - [Quality Profiles](#quality-profiles)
  - [Delay Profiles](#delay-profiles)
    - [Uses](#uses)
    - [How Delay Profiles Work](#how-delay-profiles-work)
      - [Examples](#examples)
        - [Example 1](#example-1)
        - [Example 2](#example-2)
        - [Example 3](#example-3)
- [Quality](#quality-1)
  - [Quality Table Meanings](#quality-table-meanings)
  - [Qualities Defined](#qualities-defined)
- [Custom Formats](#custom-formats)
  - [Custom Format Conditions](#custom-format-conditions)
    - [Modifiers](#modifiers)
    - [Conditions](#conditions)
    - [Profiling Settings and Ranking](#profiling-settings-and-ranking)
      - [Importing / Exporting Custom Formats](#importing-exporting-custom-formats)
      - [Importing / Updating Existing Custom Formats](#importing-updating-existing-custom-formats)
    - [Collection of Custom Formats](#collection-of-custom-formats)
- [Indexers](#indexers)
  - [Supported Indexers](#supported-indexers)
    - [Indexer Settings](#indexer-settings)
    - [Usenet Indexer Configuration](#usenet-indexer-configuration)
    - [Torrent Tracker Configuration](#torrent-tracker-configuration)
      - [Indexer Flags](#indexer-flags)
  - [Options](#options)
  - [Restrictions](#restrictions)
- [Download Clients](#download-clients)
  - [Overview](#overview)
  - [Download Client Processes](#download-client-processes)
    - [Usenet Process](#usenet-process)
    - [Torrent Process](#torrent-process)
  - [Download Clients](#download-clients-1)
    - [Supported Download Clients](#supported-download-clients)
    - [Usenet Client Settings](#usenet-client-settings)
    - [Torrent Client Settings](#torrent-client-settings)
    - [Torrent Client Remove Download Compatibility](#torrent-client-remove-download-compatibility)
  - [Completed Download Handling](#completed-download-handling)
    - [Remove Completed Downloads](#remove-completed-downloads)
    - [Failed Download Handling](#failed-download-handling)
  - [Remote Path Mappings](#remote-path-mappings)
- [Import Lists](#import-lists)
  - [Lists](#lists)
  - [List Options](#list-options)
  - [List Exclusions](#list-exclusions)
- [Connect](#connect)
  - [Connections](#connections)
  - [Connection Triggers](#connection-triggers)
- [Metadata](#metadata)
  - [Options](#options-1)
  - [Metadata Consumers](#metadata-consumers)
- [Tags](#tags)
- [General](#general)
  - [Host](#host)
  - [Security](#security)
  - [Proxy](#proxy)
  - [Logging](#logging)
  - [Analytics](#analytics)
  - [Updates](#updates)
  - [Backups](#backups)
- [UI](#ui)
  - [Calendar](#calendar)
  - [Movies](#movies)
  - [Dates](#dates)
  - [Style](#style)
  - [Language](#language)

This page will go through all the settings available in Radarr and how they work. This is not meant to be a comprehensive "how to set up Radarr." If you want that, please use the [Quick Start](/radarr/quick-start-guide) page instead.

# Menu options

To get to the Settings page, choose Settings from the sidebar. The following sub-menu options will be available:

![settings_1_menu.png](/assets/radarr/settings_1_menu.png)

Also, note that for each individual settings page, there are some options at the top of the menu:

![settings_2_topmenu.png](/assets/radarr/settings_2_topmenu.png)

- Hide/Show advanced is important for any items that are marked below as `(Advanced Option)`, otherwise they will not show up. These menu items are shown in orange in the screenshots.

- You must save your changes before leaving the screen. You do that by clicking the disk icon. If you've made no changes, it will show "No Changes" and be grayed out, as shown above.

# Media Management

> Some of these settings are only visible through `Show Advanced Settings` which is on the top bar under the search bar{.is-info}

## Community Naming Suggestions

> Below are some Community Naming Suggestions from [TRaSH's Guides](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/) {.is-info}

### Movie Files

- Radarr v4.2.2.6489 or newer

`{Movie CleanTitle} {(Release Year)} {imdb-{ImdbId}} {edition-{Edition Tags}} {[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels}]{MediaInfo AudioLanguages}[{Mediainfo VideoCodec}]{-Release Group}`

- Older Radarr Versions

`{Movie CleanTitle} {(Release Year)} {Edition Tags} [imdb-{ImdbId}]{[Custom Formats]}{[Quality Full]}{[MediaInfo 3D]}{[MediaInfo VideoDynamicRangeType]}{[Mediainfo AudioCodec}{ Mediainfo AudioChannels}][{Mediainfo VideoCodec}]{-Release Group}`

### Movie Folders

`{Movie CleanTitle} ({Release Year})`

## Movie Naming

- Rename Movies - If unchecked, Radarr will use the existing name if renaming is disabled
  - If unchecked:
    - Download Client Import
      - Download Client's Release Title is used
    - Manual (Ad-Hoc) Import: Original File Name
- Replace Illegal` Characters - If unchecked, Radarr will remove them instead.

  - The characters are: `:` `\` `/` `>` `<` `?` `*` `|` `"`
- Colon (`:`) Replacement - This setting will dictate how Radarr handles colons within the movie file. This is only available when Replace Illegal Characters is enabled.
  - Delete - Self explanatory
    - Example: Movie,The.mkv => MovieThe.mkv
  - Replace with Dash - Removes the colon and adds a dash in its place
    - Example: Movie,The.mkv => Movie-The.mkv
  - Replace with Space - Removes the colon and adds a space in its place
    - Example: Movie,The.mkv => Movie The.mkv
  - Replace with Space Dash Space - self explanatory
    - Example: Movie,The.mkv => Movie - The.mkv

### Standard Movie Format

- Here you will select the naming convention for your movies

- Dropdown Box (upper right corner)
  - Left Box - Space Handling
    Space ( ) - Use spaces in naming (Default)
    Period (.) - Use periods in lieu of spaces in naming
    Underscore (_) - Use underscores in lieu of spaces in naming
    Dash (-) - Use dashes in lieu of spaces in naming
  - Right Box - Case Handling
    Default Case - Make title uppercase and lowercase (~camel-case) (Default)
    Uppercase - Make title all uppercase
    Lowercase - Make title all lowercase

### Movie Naming

- `{Movie Title}` = The Movie's Title!
- `{Movie Title:DE}` = Titel des Films
- `{Movie CleanTitle}` = The Movies Title!
- `{Movie TitleThe}` = Movie's Title!, The
- `{Movie OriginalTitle}` = Τίτλος ταινίας
- `{Movie CleanOriginalTitle}` = Τίτλος ταινίας
- `{Movie TitleFirstCharacter}` = S
- `{Movie Collection}` = The Movie Collection
- `{Movie Certification}` = R
- `{Release Year}` = 2009

`CleanTitle` [does the following](https://github.com/Radarr/Radarr/blob/5948f564827eabb7afc1e89bf4a5987e3c71dc74/src/NzbDrone.Core/Organizer/FileNameBuilder.cs#L207):

- Replace `&` with `and`
- Replace `/` and `\` with ` `
- Remove `,`,`<`,`>`,`/`,`\`,`;`,`:`,`'`,`|`, `~`,`!`,`?`,`@`,`$`,`%`,`^`,`*`,`-`,`_`,`=` as per the following regex:

```regex
(?<=\s)(,|<|>|\/|\\|;|:|'|""|\||`|~|!|\?|@|$|%|^|\*|-|_|=){1}(?=\s)|('|:|\?|,)(?=(?:(?:s|m)\s)|\s|$)|(\(|\)|\[|\]|\{|\})
```

### Movie IDs

- `{ImdbId}` = tt12345
- `{Tmdbid}` = 123456

> Imdb Tags used in Plex naming format will conditionally hide when value is blank `{imdb-{ImdbId}}` {.is-info}

### Quality

- `{Quality Full}` = HDTV 720p Proper
- `{Quality Title}` = HDTV 720p

### Media Info

- `{MediaInfo Simple}` = x264 DTS
- `{MediaInfo Full}` = x264 DTS \[EN+DE\]
- `{MediaInfo AudioCodec}` = DTS
- `{MediaInfo AudioChannels}` = 5.1
- `{MediaInfo AudioLanguages}` = \[EN+DE\]
- `{MediaInfo SubtitleLanguages}` = \[EN\]
- `{MediaInfo VideoCodec}` = x264
- `{MediaInfo VideoBitDepth}` = 8
- `{MediaInfo VideoDynamicRange}` = HDR
- `{MediaInfo VideoDynamicRangeType}` = DV HDR10

> `MediaInfo Full`, `AudioLanguages`, and `SubtitleLanguages` do not currently support a `:EN+DE` suffix allowed in Sonarr to filter the languages included in the filename. There is an open [issue](https://github.com/Radarr/Radarr/issues/4710) regarding this.
~~`MediaInfo Full`, `AudioLanguages`, and `SubtitleLanguages` support a `:EN+DE` suffix allowing you to filter the languages included in the filename. Use `-DE` to exclude specific languages. Appending <kb>+</kb> (e.g.: `:EN+`) will output `[EN]`,`[EN+--]` or `[--]` depending on excluded languages. For example - `{MediaInfo Full:EN+DE}`.~~
{.is-info}

> `MediaInfo VideoDynamicRangeType` will give possible values of: DV, DV HDR10, DV HLG, DV SDR, HDR10, HDR10Plus, HLG, and PQ.
{.is-info}

### Release Group

- `{Release Group}` = Rls Grp

### Edition

- `{Edition Tags}` = IMAX

> As of v4.2.2.6489, Edition Tags used in Radarr following Plex's naming format of `{edition-{Edition Tags}}` will conditionally hide like `{-Group}` does when the Edition Tags value is blank
{.is-info}

### Custom Formats (Naming)

- `{Custom Formats}` = Surround Sound x264

> Custom Formats will be the literal custom format name and require the Custom Format is enabled to be included in renaming {.is-info}

### Original

- `{Original Title}` = Movie.Title.HDTV.x264-EVOLVE
- `{Original Filename}` = Movie.title.hdtv.x264-EVOLVE

> `Original Title` is the release name and it is what is suggested to be used.
{.is-info}

>`Original Filename` is not recommended. It is the literal original filename and may be obfuscated `t1i0p3s7i8yuti`.{.is-warning}

## Movie Folder Format

Here you will set the naming convention for the folder that contains the season folders or movie files. Click on the `?` to bring up the `Folder Name Tokens` dialog box.

### Movie Naming

- `{Movie Title}` = Movie Name!
- `{Movie Title:DE}` = FileTitle
- `{Movie CleanTitle}` = Movie Title
- `{Movie TitleThe}` = Movie Title, The
- `{Movie OriginalTitle}` = Τίτλος ταινίας
- `{Movie TitleFirstCharacter}` = S
- `{Movie Collection}` = The Movie Collection
- `{Movie Certification}` = R
- `{Release Year}` = 2009

### Movie ID

- `{ImdbId}` = tt12345
- `{Tmdbid}` = 123456

## Folders

- Create Empty Media Folders - Create missing movie folders during disk scan
- Delete Empty Folders - Delete empty movie folders during disk scan and when movie files are deleted

## Importing

- Skip Free Space Check - Use when Radarr is unable to detect free space from your series root folder
- Minimum Free Space - Toggling this will prevent import if it would leave less than this amount of disk space available
- Use Hard links instead of Copy - Use Hard links when trying to copy files from torrents that are still being seeded

  - For more information on this click [here](https://trash-guides.info/hardlinks)

> Rarely - but possibly -, file locks may prevent renaming files that are being seeded. You may temporarily disable seeding and use Radarr's rename function as a work around.
{.is-warning}

- Import Extra Files - Import matching extra files (subtitles, nfo, etc) after importing a file

## File Management

- Unmonitor Deleted Movies - Movies deleted from disk are automatically unmonitored in Radarr
- Download Proper & Repacks - Whether or not to automatically upgrade to Propers/Repacks. Use `Do not Prefer` to sort by preferred word score over propers/repacks

  - Prefer and Upgrade - Rank repacks and propers higher than non-repacks and non-propers. Treat new repacks and propers as upgrade to current releases.
  - Do Not Upgrade Automatically - Rank repacks and propers higher than non-repacks and non-propers. Do not treat new repacks and propers as upgrade to current releases.
  - Do Not Prefer - Effectively this ignores repacks and propers. You'll need to manage any preference for those with [Custom Formats](#custom-formats).

> \* `PROPER` - means there was a problem with the previous release. Downloads tagged as PROPER shows that the problems have been fixed in that release. This is done by a Group that did not release the original.
> \* `REPACK` - means there was a problem with the previous release and is corrected by the original Group. Downloads tagged as REPACK shows that the problems have been fixed in that release. This is done by a Group that did release the original.
{.is-info}

> [Use custom formats for automatic upgrades to propers/repacks](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/)
{.is-info}

- Analyse video files - Extract file information such as resolution, runtime and codec information from files. This requires Radarr to read parts of the file which may cause high disk or network activity during scans.
- Rescan Movie Folder after Refresh
  - Always - This will rescan movie folders based upon Tasks Schedule. This is recommended for most cases including if one uses Bazarr.
  - After Manual Refresh - You will have to manually rescan the disk. This is recommended for users of cloud storage.
  - Never - Just as it says, never rescan the movie folders. This is not recommended.
- Change File Date - Change file date on import/rescan
  - None - Radarr will not change the date that shows in your given file browser
  - In Cinemas Date - The date the movie was released in theaters.
  - Physical Release Date - The date the movie was released either on disk (physical) or on the web.
- Recycling Bin - Movie files will go here when deleted instead of being permanently deleted
- Recycling Bin Cleanup - This is how old a given file can be before it is deleted permanently

> Files in the recycle bin older than the selected number of days will be cleaned up automatically {.is-warning}

## Permissions

- Set Permissions - Should `chmod` be run when files are imported/renamed?
  - chmod Folder - Octal, applied during import/rename to media folders and files (without execute bits)

> The drop down box has a preset list of very commonly used permissions that can be used. However, you can manually enter a folder octal if you wish.
{.is-info}

> This only works if the user running `Radarr` is the owner of the file. It's better to ensure the download client sets the permissions properly.{.is-warning}

- chown Group - Group name or GID. Use GID for remote file systems

> This only works if the user running `Radarr` is the owner of the file. It's better to ensure the download client sets the permissions properly.{.is-warning}

## Root Folders

- Path - This shows the path to your media library
- Free Space - This is the free space being reported to Radarr from the system
- Unmapped Folders - These are folders that do not have a Movie associated to it

> The `X` at the end will remove this root path
{.is-info}

- Add Root Folder - This allows you to select a root path for a place to either place new imported downloads into this folder or to allow Radarr to scan existing media.

> Non-Windows Users:
> \* If you're using an NFS mount ensure `nolock` is enabled.
> \* If you're using an SMB mount ensure `nobrl` is enabled.
{.is-warning}

# Profiles

## Quality Profiles

- Set profiles for the quality of movies you're looking to download.

> When selecting an existing profile or adding an additional profile a new window will appear{.is-info}

> Note: The quality which has a blue box is the quality at which any media with this profile will continue to be upgraded to.
{.is-info}

- Plus icon (<kb>+</kb>) - Create a new quality profile

- Name - Select a **UNIQUE** name for the quality profile you are creating
- Upgrades Allowed - When this option is checked and you tell Radarr to download a `WEB 1080p` as it is the first release of a specific movie then later somebody is able to upload a `Bluray-1080p` Radarr will automatically upgrade to the better quality ***if*** `Upgrade Until` has that quality selected
- Upgrade Until - Once this quality is reached Radarr will no longer download movies

> Note: This is only applicable if you have `Bluray-1080p` higher than `WEB 1080p` within the `Qualities` section
{.is-warning}

- Qualities - Qualities higher in the list are more preferred even if not checked. Qualities within the same group are equal. Only checked qualities are wanted.
  - Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases. Prime example of this is `WebDL` and `WebRip` as these are very similar and typically have similar bitrates. When editing the groups you can change the preference within each of the groups. [See TRaSH's Guide for how to Merge Qualities](https://trash-guides.info/merge-quality)

  - [See Qualities](#qualities-defined)

> By default the qualities are set from lowest (bottom) to highest (top)
{.is-info}

- Language - Select your preferred language

- Custom Format - Radarr scores each release using the sum of scores for matching custom formats. If a new release would improve the score, at the same or better quality, then Radarr will grab it.
See [Custom Formats](#custom-formats) for more details.

## Delay Profiles

- Delay profiles allow you to reduce the number of releases that will be downloaded for an movie by adding a delay while Radarr continues to watch for releases that better match your preferences.
- Preferred Protocol - This will either be `Usenet` or `Torrent` depending on which download protocol you prefer
- Usenet Delay - Set by the number of minutes you will want to wait before the download to start
- Torrent Delay - Set by the number of minutes you will want to wait before the download to start
- Bypass if Highest Quality - Bypass delay when release has the highest enabled quality profile with the preferred protocol
- Tags - With giving this delay profile a tag you will be able to tag a given movie to have it play by the rules set here.
- Wrench icon - This will allow you to edit the delay profile
- Plus icon (<kb>+</kb>) - Create a new delay profile

### Uses

Some media will receive half a dozen different releases of varying quality in the hours after a release, and without delay profiles Radarr might try to download all of them. With delay profiles, Radarr can be configured to ignore the first few hours of releases.

Delay profiles are also helpful if you want to emphasize one protocol (Usenet or BitTorrent) over the other. (See Example 3)

### How Delay Profiles Work

The timer begins as soon as Radarr detects a movie has a release available. This release will show up in your Queue with a clock icon to indicate that it is under a delay.

> The clock starts from the releases uploaded time and not from the time Radarr sees it.
{.is-info}

During the delay period, any new releases that become available will be noted by Radarr. When the delay timer expires, Radarr will download the single release which best matches your quality preferences.

The timer period can be different for Usenet and Torrents. Each profile can be associated with one or more tags to allow you to customize which shows have which profiles. A delay profile with no tag is considered the default and applies to all shows that do not have a specific tag.

> Delay profiles start from the timestamp that the indexer reports the release was uploaded. This means that any content older than the number of minutes you have set are not impacted in any way by your delay profile, and will be downloaded immediately. In addition, **any manual searches** for content (non-RSS feed searches) will ignore delay profile settings.
{.is-warning}

#### Examples

- For each example, assume the user has the follow quality profile active: WebDL-720p and above are allowed WebDL-1080p is the quality cutoff * BluRay1080p is the highest ranked quality

##### Example 1

- In this simple example, the profile is set with a 120 minute (two hour) delay for both Usenet and Torrent.

- At 11:00pm the first release for an Movie is detected by Radarr and it was uploaded at 10:50pm and the 120 minute clock begins. At 12:50am, Radarr will evaluate any releases it has found in the past two hours, and download the best one, which is WebDL 720p.

- At 3:00am another release is found, which is WebDL 720p that was added to your indexer at 2:46am. Another 120 minute clock begins. At 4:46am the best-available release is downloaded. Since the quality cutoff is now reached, the Movie no longer is upgradable and Radarr will stop looking for new releases.

- At any point, if a WebDL 1080p release is found, it will be downloaded immediately because it is the highest-ranking quality. If there is a delay timer currently active it will be canceled.

##### Example 2

- This example has different timers for Usenet and Torrents. Assume a 120 minute timer for Usenet and a 180 minute timer for BitTorrent.

- At 11:00pm the first release for an Movie is detected by Radarr and both timers begin. The release was added to the indexer at 10:15pm At 12:15am, Radarr will evaluate any releases, and if there are any acceptable Usenet releases, the best one will be downloaded and both timers will end. If not, Radarr will wait until 12:15am and download the best release, regardless of which source it came from.

##### Example 3

- A common use for delay profiles is to emphasize one protocol over another. For example, you might only want to download a BitTorrent release if nothing has been uploaded to Usenet after a certain amount of time.

- You could set a 60 minute timer for BitTorrent, and a 0 minute timer for Usenet.

- If the first release that is detected is from Usenet, Radarr will download it immediately.

- If the first release is from BitTorrent, Radarr will set a 60 minute timer. If any qualifying Usenet release is detected during that timer, the BitTorrent release will be ignored and the Usenet release will be grabbed.

## Release Profiles

- Here you will be able to set global restrictions based upon a couple of parameters
- Click the <kb>+</kb> and a new window will open
- Must Contain - Within this field you can tell Radarr that if a release does not contain a certain string then Radarr will not grab that release. This is case insensitive by default and regex can be used.
- Must Not Contain - Within this field you can tell Radarr that if a release does contain a certain string then Radarr will not grab that release. This is case insensitive by default and regex can be used.
- Tags - Here you can apply these settings to movies with at least one of the given [tag](#tags).

# Quality

## Quality Table Meanings

- Quality - The scene quality name (hardcoded)
- Title - The name of the Quality in the GUI (configurable)
- Megabytes Per Minute - Self Explanatory
- Size Limit - Self Explanatory
- Min - The minimum Megabytes per Minute (MB/min) a quality can have.
- Preferred - The preferred Megabytes per Minute (MB/min) a quality can have.
- Max - The maximum Megabytes per Minute (MB/min) a quality can have.

## Qualities Defined

- Unknown - Self Explanatory
- SDTV - Post air rips from an analog source (usually cable television or OTA standard definition). The image quality is generally good (for the resolution) and they are usually encoded in DivX/XviD or MP4.
- WEBDL-480p - WEB-DL (P2P) refers to a file losslessly ripped from a streaming service, such as Netflix, Amazon Video, Hulu, Crunchyroll, Discovery GO, BBC iPlayer, etc., or downloaded via an online distribution website such as iTunes. The quality is quite good, since they are not reencoded. The video (H.264 or H.265) and audio (AC3/AAC) streams are usually extracted from the iTunes or Amazon Video and remuxed into a MKV container without sacrificing quality. An advantage with these releases is that, like BD/DVDRips, they usually have no onscreen network logos. These are nearly as good as a Blu-ray source but can suffer from audio lag or visual artifacts from the adaptive bitrate of streaming services. If a ripper's internet connection drops to a point where the bitrate lowers, the source bitrate could change dynamically, causing variations in picture quality. Most releases that suffer from an extreme amount of visual artifacts are NUKED and a PROPER is generally released to fix any wild variations in adaptive bitrate. This will be in 480p (SD) quality.
- WEBRip-480p - In a WEB-Rip (P2P), the file is often extracted using the HLS or RTMP/E protocols and remuxed from a TS, MP4 or FLV container to MKV. This will be in 480p (SD) quality.
- DVD - A re-encode of the final released DVD9. If possible this is released PRE retail. It should be excellent quality (for the resolution). DVDrips are usually released in DivX/XviD or MP4.
- Bluray-480p - A re-encode of the final released Blu-ray, downscaled to 480p resolution (720x480 @ 16:9, any other Aspect Ratio may be a different resolution). If possible this is released PRE retail. It should be excellent quality for the resolution. Bitrates may vary, but these are generally encoded to DivX, XviD, or AVC and offer the tradeoff of a small perceived quality reduction over the original source while drastically reducing filesize. These are generally MKV or MP4, but some DivX/XviD are around as well which use AVI.
- HDTV-720p - A re-encode of the final released Blu-ray, but broadcast over HD cable or satellite (1280x720 @ 16:9, any other aspect ratio may be a different resolution). It may be modified for runtime or content depending on the network it came from. This is released usually several months after a retail release, but sometimes upscaled versions of a Standard Definition film are released on cable channels such as STARZ or HBO, and they would be the only HD copies of that specific film available. These are generally MKV or MP4.
- HDTV-1080p - A re-encode of the final released Blu-ray, but broadcast over HD cable or satellite (1920x1080 @ 16:9, any other aspect ratio may be a different resolution). It may be modified for runtime or content depending on the network it came from. This is released usually several months after a retail release, but sometimes upscaled versions of a Standard Definition film are released on cable channels such as STARZ or HBO, and they would be the only HD copies of that specific film available. These are generally MKV or MP4 container.
- WEBRip-720p - In a WEB-Rip (P2P), the file is often extracted using the HLS or RTMP/E protocols and remuxed from a TS, MP4 or FLV container to MKV. This will be in 720p quality.
- Bluray-720p - A re-encode of the final released Blu-ray, downscaled to 720p resolution (1280x720 @ 16:9, any other aspect ratio may be a different resolution). If possible this is released PRE retail. It should be excellent quality for the resolution. Bitrates may vary, but these are generally encoded to AVC or HEVC and offer the tradeoff of a small perceived quality reduction over the original source while drastically reducing filesize. These are generally MKV or MP4 container.
- WEBDL-1080p - WEB-DL (P2P) refers to a file losslessly ripped from a streaming service, such as Netflix, Amazon Video, Hulu, Crunchyroll, Discovery GO, BBC iPlayer, etc., or downloaded via an online distribution website such as iTunes. The quality is quite good, since they are not reencoded. The video (H.264 or H.265) and audio (AC3/AAC) streams are usually extracted from the iTunes or Amazon Video and remuxed into a MKV container without sacrificing quality. An advantage with these releases is that, like BD/DVDRips, they usually have no onscreen network logos. These are nearly as good as a Blu-ray source but can suffer from audio lag or visual artifacts from the adaptive bitrate of streaming services. If a ripper's internet connection drops to a point where the bitrate lowers, the source bitrate could change dynamically, causing variations in picture quality. Most releases that suffer from an extreme amount of visual artifacts are NUKED and a PROPER is generally released to fix any wild variations in adaptive bitrate. This will be in 1080p quality.
- WEBRip-1080p - In a WEB-Rip (P2P), the file is often extracted using the HLS or RTMP/E protocols and remuxed from a TS, MP4 or FLV container to MKV. This will be in 1080p quality.
- Bluray-1080p - A re-encode of the final released Blu-ray, at its native 1080p resolution (1920x1080 @ 16:9, any other aspect ratio may be a different resolution). If possible this is released PRE retail. It should be excellent quality and the same resolution as the source. Bitrates may vary, but these are generally encoded to AVC or HEVC and offer the tradeoff of a small perceived quality reduction over the original source while slightly reducing filesize. These are generally MKV or MP4 container.
- Remux-1080p - A remux is a rip of a Blu-ray or HD DVD disc to another container format or just stripping the disc of menus and bonus material while keeping the contents of its audio and video streams intact (also keeping the current codecs), guaranteeing the exact 1:1 movie quality as on original disc. This is at 1080p quality.
- HDTV-2160p - TVRip is a capture source from an capture card. HDTV stands for captured source from HD television. With an HDTV source, the quality can sometimes even surpass DVD. Movies in this format are starting to grow in popularity. Some advertisement and commercial banner can be seen on some releases during playback. This is at 2160p (4K) quality.
- WEBDL-2160p - WEB-DL (P2P) refers to a file losslessly ripped from a streaming service, such as Netflix, Amazon Video, Hulu, Crunchyroll, Discovery GO, BBC iPlayer, etc., or downloaded via an online distribution website such as iTunes. The quality is quite good, since they are not reencoded. The video (H.264 or H.265) and audio (AC3/AAC) streams are usually extracted from the iTunes or Amazon Video and remuxed into a MKV container without sacrificing quality. An advantage with these releases is that, like BD/DVDRips, they usually have no onscreen network logos. These are nearly as good as a Blu-ray source but can suffer from audio lag or visual artifacts from the adaptive bitrate of streaming services. If a ripper's internet connection drops to a point where the bitrate lowers, the source bitrate could change dynamically, causing variations in picture quality. Most releases that suffer from an extreme amount of visual artifacts are NUKED and a PROPER is generally released to fix any wild variations in adaptive bitrate. This will be in 2160p (4K) quality.
- WEBRip-2160p - In a WEB-Rip (P2P), the file is often extracted using the HLS or RTMP/E protocols and remuxed from a TS, MP4 or FLV container to MKV. This will be in 2160p (4k) quality.
- Bluray-2160p - A re-encode of the final released Blu-ray, at its native 2160p resolution (3840x2160 @ 16:9, any other aspect ratio may be a different resolution). 4K versions of films that are released in generally HEVC codec and could be either 8-bit or 10-bit color reproduction or from an HDR source. slightly reducing filesize. These are generally MKV or MP4 container.
- Remux-2160p - A remux is a rip of a Blu-ray or HD DVD disc to another container format or just stripping the disc of menus and bonus material while keeping the contents of its audio and video streams intact (also keeping the current codecs), guaranteeing the exact 1:1 movie quality as on original disc. This is at 2160p (4K) quality.

# Custom Formats

{#custom-formats-2}

- Ensure you get the right release every time! Custom formats allows fine control over release prioritization and selection. As simple as a single preferred word or as complex as you want with multiple criteria and regex.
- Custom formats are calculated on-the-fly instead of being stored in the database, so they update as soon as you change the definitions.
- Custom formats are used within your Quality Profiles to determine the scoring of each custom format. Within each quality profile, you can set a minimum custom format score for a release to be grabbed and an upgrade until score as well.
- It's strongly recommended to add the below Custom Formats from [TRaSH's Guides](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/) to avoid unwanted downloads. Refer to the linked TRaSH Guide Custom Format article and additional referenced 3 TRaSH Custom Format Guides on the top of the Collection of Custom Formats page for more information.
  - [DV (WEB-DL)](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#dv-webdl) will avoid grabbing releases with Dolby Vision (DV) that have a green hue if DV is not supported.
  - [BR-DISK](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/#br-disk) to avoid grabbing poorly named BR-DISKs that do not match the BR-DISK quality parsing.

---

- Name - The Name of the Custom Format
- Include Custom Format when Renaming - Include the Name of the Custom Format in Renaming?

> Custom Formats have no influence on what is searched - only how the results are evaluated. It is also not possible to modify in any form the search Radarr uses.
{.is-info}

Profiles is where Custom Format Scores are configured.  

## Custom Format Conditions

### Modifiers

- Negate - the match is inverted, so the condition is satisfied if and only if the non-negated condition is not satisfied
- Required - only applies to formats with more than one condition of the same type and changes the matching rules for type groups. Enabling this option means that this specific condition must be satisfied for the whole custom format to apply regardless of if another condition of the same type would otherwise satisfy the type group. **Note: You only use this if you use a condition more than once. In other words, if you have a custom format with 2 required release title conditions and 3 non required language conditions, then it MUST meet BOTH of the required release title conditions and it MUST meet ONE OF the 3 language conditions.** Similarly, if you have a custom format with 4 release title conditions and none are required, then the custom format will apply if ANY of the conditions are met.

### Conditions

> **Different Condition Types** act as `and` within the same Custom Format.  **Multiple Conditions of the same type** act as `or` unless Required is used
{.is-info}

- **Any conditions that use RegEx are case insensitive**
- Note the following GitHub Issues
  - [Custom Formats do not apply before the Movie Year in release titles #4859](https://github.com/Radarr/Radarr/issues/4859)
  - [Custom Format doesn't match for term "xvid" at end of release name #6824](https://github.com/Radarr/Radarr/issues/6824)
- Release Title - This is a regular expression matched against the release title and, after download, the filename on disk.
  - Note: Radarr only considers text after the movie title and year which means anything preceding the title is ignored.
- Edition - This tag is matched against any Editions Radarr may parse. You can put any value Radarr will try to match that against what it parsed (case-insensitive).
- Language - This language is matched against any language(s) Radarr parses. All languages previously selectable in profiles work here.
- [Indexer Flag](/radarr/settings#indexer-flags) - This tag is matched against any Indexer Flags that Radarr may parse.
- Source - The source where a release was ripped from (e.g. BLURAY).
- Resolution - The resolution parsed from either the release name or mediainfo (if available).
- Quality Modifier - Quality Modifier sets things like Telescene, Telesync, Remux, Regional. It disambiguates a given source and resolution pair when there are multiple quality (source) types that can apply.
- Size - This is matched against the release size. The release size is converted to gigabytes and compared against the min and max values.
- Group - This is matched against the group that Radarr parses based on Radarr's group detection logic.

### Profiling Settings and Ranking

- Custom formats are implemented within and have their impact controlled by Quality Profiles. The Upgrade Until score prevents upgrading once a release with this desired score has been downloaded.
- A score of 0 results in the custom format being informational only and has non impact on release ranking nor languages searched.
- The Minimum Score requires releases cumulative custom format score to reach this threshold otherwise they will be rejected.
  - Custom formats that match with undesirable attributes should be given a negative score to lower their appeal.
  - Outright rejections should be given a negative score low enough that even if all of the other formats with positive scores were added, the score would still fall below the minimum.
- [Please see TRaSH's Guides for how to setup and use custom formats](https://trash-guides.info/Radarr/Radarr-setup-custom-formats/)

#### Importing / Exporting Custom Formats

- [Please see TRaSH's Guides for how to import/export custom formats.](https://trash-guides.info/Radarr/Radarr-import-custom-formats/) However, one is able to import and export custom formats.

#### Importing / Updating Existing Custom Formats

- [Please see TRaSH's Guides for how to import or update existing custom formats.](https://trash-guides.info/Radarr/Radarr-how-to-update-custom-formats/)

### Collection of Custom Formats

- [TRaSH maintains a collection of custom formats](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/)

# Indexers

> Information on supported indexers can be found at the [More Info (Supported)](/radarr/supported#indexers) page for this section
{.is-info}

## Supported Indexers

- A list of supported indexers is located at the [More Info (Supported)](/radarr/supported#indexers) page

### Indexer Settings

- Once you've clicked the <kb>+</kb> button to add a new indexer you will be presented with a new window with many different options. For the purposes of this wiki Radarr considers both Usenet Indexers and Torrent Trackers to be "Indexers".

- There are two sections here: Usenet and Torrents. Based upon what download client you will be using you will want to select the type of indexer you will be going with.

### Usenet Indexer Configuration

- Newznab - Here you will find presets of popular usenet indexers (that are prefilled out, all you will need is your API key which is provided by the usenet indexer of your choice) along with the ability to create a custom Indexer
- Software that works with usenet and integrates quite well with Radarr are [NZBHydra2](https://github.com/theotherp/nzbhydra2/) or [Prowlarr](/prowlarr) which integrate with both Usenet and Torrents
- Regardless if you select a pre-filled out indexer or a custom indexer setup you will be presented with a new window to input all your settings
- Choose from the presets or add a custom indexer (such as NZBHydra2 or Prowlarr)
- Name - The name of the indexer in Radarr
- Enable RSS - If enabled, use this indexer to watch for files that are wanted and missing or have not yet reached their cutoff.
- Enable Automatic Search - If enabled, use this indexer for automatic searches including Search on Add
- Enable Interactive Search - If enabled, use this indexer for manual interactive searches.
- URL - The indexer provided URL of the indexer such as `https://api.nzbgeek.info`.
- API Path - The indexer provided path to the api. This is typically `/api`
- Multi Languages - Set what languages `MULTI` are for this indexer.
- API Key - The indexer provided key to access the API.
- Categories - Default categories will be used unless edited. It is likely these default categories are suboptimal. Upon editing this setting, Radarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
- (Advanced Option) Additional Parameters - Additional Newznab parameters to add to the query link
- Remove year from search string - For text based queries should Radarr remove the year after the movie title when searching this indexer?
- (Advanced Option) Indexer Priority - Priority of this indexer to prefer one indexer over another in release tiebreaker scenarios. 1 is highest priority and 50 is lowest priority.
- (Advanced Option) Download Client - Select and specify which download client is used for grabs from this indexer
- Tags - Only use this indexer for movies with at least one matching tag. Leave blank to use with all movies.

### Torrent Tracker Configuration

- As with Usenet there are an assortment of prefilled out Torrent tracker information. If you are not a member of any of these these specific trackers they will not do you any good.
- One of the best and simplest ways to utilize Torrent trackers that are not natively supported with Radarr is to utilize a second program such as [Prowlarr](/prowlarr) or [Jackett](https://github.com/Jackett/Jackett). These software pair well with Radarr as a search indexer that houses all your information and sends it to Radarr.
- Torznab - This option will set you up with a Jackett preset, if you utilize multiple trackers you will need to have each entry have a unique name
- Torznab Indexer
- Choose from the presets or add a custom indexer (such as Jackett)
- Name - The name of the indexer in Radarr
- Enable RSS - If enabled, use this indexer to watch for files that are wanted and missing or have not yet reached their cutoff.
- Enable Automatic Search - If enabled, use this indexer for automatic searches including Search on Add
- Enable Interactive Search - If enabled, use this indexer for manual interactive searches.
- URL - The indexer provided URL such as `http://localhost:9117/jackett/api/v2.0/indexers/torrentdb/results/torznab/`.
- API Path - The indexer provided path to the api. This is typically `/api`
- API Key - The indexer provided key to access the API.
- Multi Languages - Set what languages `MULTI` are for this indexer.
- Categories - Default categories will be used unless edited. It is likely these default categories are suboptimal. Upon editing this setting, Radarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
- (Advanced Option)  Additional Parameters - Additional Torznab parameters to add to the query link
- Remove year from search string - For text based queries should Radarr remove the year after the movie title when searching this indexer?
- Minimum Seeders - The minimum number of seeders required for a release from this tracker to be grabbed.
- Seed Ratio - If empty, use the download client default. Otherwise, the minimum seed ratio required for your download client to meet for releases from this indexer prior to it being paused by your client and removed by Radarr (Requires Completed Download Handling - Remove enabled)
- Seed Time - If empty, use the download client default. Otherwise, the minimum seed time in minutes required for your download client to meet for releases from this indexer prior to it being paused by your client and removed by Radarr (Requires Completed Download Handling - Remove enabled)
- Required Flags - What indexer flags are required?

#### Indexer Flags

| Flag             | Symbol | Description                                                                                                                                                                                                                 |
| ---------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `G_Freeleech`    | ⬇⬇     | Sometimes, torrent sites set a torrent to be freeleech. This means, that the download of this torrent will not count towards your download quota or ratio. This is really useful if you have not built up a good ratio yet. |
| `G_Halfleech`    | ⇩⇩     | Similar to `G_Freeleech`, `G_Halfleech` signifies that only half of the size of this torrent will count towards your download quota or ratio.                                                                               |
| `G_DoubleUpload` | ⬆      | Similar to `G_Freeleech`, `G_DoubleUpload` signifies that any amount of data you upload via seeding is counted twice towards your upload quota and ratio. This is very useful, if you want to build up a ratio buffer.      |
| `PTP_Golden`     | 🌟      | On PassThePopcorn, some torrents are given the *Golden* tag, when they meet certain encoding standards. These are usually the best encodes, with almost no perceptible quality loss. You can learn more on their wiki page. |
| `PTP_Approved`   | ✔      | On PassThePopcorn, some torrents are approved, when they meet the minimum standards for encoding (e.g., no low bitrates). See their wiki for more information.                                                              |
| `HDB_Internal`   | 🚪      | Releases on HDBits receive this tag, when the release was uploaded by one of the release groups of HDBits themselves.                                                                                                       |
| `G_Scene`        | ☠      | Similar to `G_Freeleech`, `G_Freeleech75` signifies that only 25% of the size of this torrent will count towards your download quota or ratio.                                                                              |
| `G_Freeleech75`  | ⇩⬇     | Similar to `G_Freeleech`, `G_Freeleech75` signifies that only 25% of the size of this torrent will count towards your download quota or ratio.                                                                              |
| `G_Freeleech25`  | ⇩      | Similar to `G_Freeleech`, `G_Freeleech25` signifies that only 75% of the size of this torrent will count towards your download quota or ratio.                                                                              |

- (Advanced Option) Indexer Priority - Priority of this indexer to prefer one indexer over another in release tiebreaker scenarios. 1 is highest priority and 50 is lowest priority.
- (Advanced Option) Download Client - Select and specify which download client is used for grabs from this indexer
- Tags - Only use this indexer for movies with at least one matching tag. Leave blank to use with all movies.

## Options

- Minimum Age - Usenet only: Minimum age in minutes of NZBs before they are grabbed. Use this to give new releases time to propagate to your usenet provider.
- Retention - Usenet only: Set to zero to set for unlimited retention
- Maximum Size - Maximum size for a release to be grabbed in MB. Set to zero to set to unlimited. Please note that this applies globally.
- Prefer Indexer Flags - Prioritize releases with special flags. (See Required Flags above)
- Availability Delay - Amount of time before (-#) or after (#) the available date to search for Movie
  - This is helpful to delay searching for a release to give the community time to perform the best encodes.
  - Typically a Movie Availability of `Released` with a delay of `-21` or `-14` is suggested.
- RSS Sync interval - Interval in minutes. Set to zero to disable (this will stop all automatic release grabbing) Minimum: 10 minutes Maximum: 120 minutes
  - Please see [How does Radarr find movies?](/radarr/faq#how-does-radarr-find-movies) for a better understanding of how RSS Sync will help you

> If Radarr has been offline for an extended period of time, Radarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn’t been too long will be able to process the releases it would have missed and avoid you needing to perform a search for the missed releases.{.is-info}

- Whitelisted Subtitle Tags - Tags entered here will not be considered hardcoded subtitles.
- Allow Hardcoded Subs - If enabled, allow releases with hardcoded subtitles to be downloaded automatically

# Download Clients

> Information on supported download clients can be found at the [More Info (Supported)](/radarr/supported#download-clients) page for this section
{.is-info}

## Overview

- Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn't one right setup and everyone's setup can be a little different. But there are many wrong setups.

## Download Client Processes

### Usenet Process

- Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
- Radarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Radarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Radarr
- Radarr will scan that completed file location for files that Radarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Radarr will fall back and copy the file then delete from the source which is IO intensive.

### Torrent Process

- Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
- Radarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Radarr under the specific download client). When files are imported to your media folder Radarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. [A hardlink will allow not use any additional disk space.](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/) The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Radarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Radarr's settings, Radarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped (i.e. paused).

## Download Clients

Click on `Settings =>`Download Clients`, and then click the <kb>+</kb> to add a new download client. Your download client should already be configured and running.

### Supported Download Clients

- A list of supported download clients is located at the [More Info (Supported)](/radarr/supported#download-clients) page

Select the download client you wish to add, and there will be a pop-up box to enter connection details. These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.

### Usenet Client Settings

- Name - The name of the download client within Radarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- (Advanced Option) URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- API Key - the API key to authenticate to your client
- Username - the username to authenticate to your client (typically not needed)
- Password- the password to authenticate to your client (typically not needed)
- Category - the category within your download client that \*Arr will use. To avoid unrelated downloads showing in Activity it is strongly recommended to set a category.
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- (Advanced Option) Client Priority - Priority of the download client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority. 1 is highest priority and 50 is lowest priority
- Completed Download Handling
  - Remove (Per Client Setting) - Remove completed downloads when finished (usenet) or stopped/complete (torrents). See [Completed Download Handling for more details](#completed-download-handling)

### Torrent Client Settings

- Name - The name of the download client within Radarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client; this is typically the webgui port
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- (Advanced Option) URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- Username - the username to authenticate to your client
- Password- the password to authenticate to your client
- Category - the category within your download client that \*Arr will use. To avoid unrelated downloads showing in Activity it is strongly recommended to set a category.
- Post-Import Category - the category to set after the release is downloaded and imported. Please note that this breaks completed download handling removal.
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Initial State - Initial state for torrents (Qbittorrent Only: Forced bypasses all seed thresholds)
- (Advanced Option) Client Priority - Priority of the download client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority. 1 is highest priority and 50 is lowest priority
- Completed Download Handling
  - Remove (Per Client Setting) - Remove completed downloads when finished (usenet) or stopped/complete (torrents). See [Completed Download Handling for more details](#completed-download-handling)
    - For torrents this requires your download client to pause upon hitting the seed goals. It also requires the seed goals to be supported by Radarr per the below table. Torrents must also stay in the same category.

### Torrent Client Remove Download Compatibility

- Radarr is only able to set the seed ratio/time on clients that support setting this value via their API when the torrent is added. Seed goals can be set globally in the client itself or per tracker in \*Arr settings for each indexer. See the table below for client compatibility.

|      Client       |                                Ratio                                 |                                    Time                                    |
| :---------------: | :------------------------------------------------------------------: | :------------------------------------------------------------------------: |
|       Aria2       |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |    ![Not Supported](https://img.shields.io/badge/Supported-No-critical)    |
|      Deluge       |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |    ![Not Supported](https://img.shields.io/badge/Supported-No-critical)    |
| Download Station  | ![Not Supported](https://img.shields.io/badge/Supported-No-critical) |    ![Not Supported](https://img.shields.io/badge/Supported-No-critical)    |
|       Flood       |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |      ![Supported](https://img.shields.io/badge/Supported-Yes-success)      |
|     Hadouken      | ![Not Supported](https://img.shields.io/badge/Supported-No-critical) |    ![Not Supported](https://img.shields.io/badge/Supported-No-critical)    |
|    qBittorrent    |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |      ![Supported](https://img.shields.io/badge/Supported-Yes-success)      |
|     rTorrent      |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |      ![Supported](https://img.shields.io/badge/Supported-Yes-success)      |
| Torrent Blackhole | ![Not Supported](https://img.shields.io/badge/Supported-No-critical) |    ![Not Supported](https://img.shields.io/badge/Supported-No-critical)    |
|   Transmission    |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   | ![Idle Limit](https://img.shields.io/badge/Supported-Idle%20Limit*-blue)\* |
|     uTorrent      |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |      ![Supported](https://img.shields.io/badge/Supported-Yes-success)      |
|       Vuze        |   ![Supported](https://img.shields.io/badge/Supported-Yes-success)   |      ![Supported](https://img.shields.io/badge/Supported-Yes-success)      |

> ![Idle Limit](https://img.shields.io/badge/Supported-Idle%20Limit*-blue) - Transmission internally has an Idle Time check, but Radarr compares it with the seeding time if the idle limit is set on a per-torrent basis. This is done as workaround to Transmission’s api limitations.{.is-info}

## Completed Download Handling

- Completed Download Handling is how Radarr imports media from your download client to your series folders. Many common issues are related to bad Docker paths and/or other Docker permissions issues.

- (Advanced Global Setting) Enable - Automatically import completed downloads from the download client
- (Advanced Option) Check For Finished Downloads Interval - Set how often to query the download clients' queues and refresh monitored downloads, minimum 1 minute
- (Per Client Setting) Remove - Remove completed downloads when finished (usenet) or stopped/complete (torrents)
  - For torrents this requires your download client to pause upon hitting the seed goals. It also requires the seed goals to be supported by Radarr per the above table. Torrents must also stay in the same category.

### Remove Completed Downloads

- Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
- Radarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Radarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
- Radarr will scan that completed file location for video files. It will parse the video file name to match it to an movie. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
- Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

- Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Radarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
- If the "Completed Download Handling - Remove" option is enabled in settings, Radarr will ask the torrent client to delete the original file and torrent, but this will only occur if the client reports that seeding is complete, the torrent is in the same category (i.e. not using a post-import category), the seed goal reached is supported by Radarr, and torrent is paused (stopped).

### Failed Download Handling

- Failed Download Handling is only compatible with SABnzbd and NZBGet.
- Failed Downloading Handling does not apply to Torrents nor are there plans to add such functionality.

- There are several components that make up the failed download handling process:

- Check Downloader:
  - Queue - Check your downloader's queue for password-protected (encrypted) releases marked as a failure
  - History - Check your downloader's history for failure (e.g. not enough to repair, or extraction failed)
- When Radarr finds a failed download it starts processing them and does a few things:
  - Adds a failed event to Radarr's history
  - Removes the failed download from Download Client to free space and clear downloaded files (optional)
  - Starts searching for a replacement file (optional)
  - Blocklisting (fka 'Blacklisting') allows automatic skipping of nzbs when they fail, this means that nzb will not be automatically downloaded by Radarr ever again (You can still force the download via a manual search).
  - There are 2 advanced options (on 'Download Client' settings page) that control the behavior of failed downloading in Radarr, at this time, they are all on by default.

- Redownload - Controls whether or not Radarr will search for the same file after a failure
- (Advanced Option) Remove - Whether or not the download should automatically be removed from Download Client when the failure is detected

## Remote Path Mappings

- Remote Path Mapping acts as a dumb find Remote Path and replace with Local Path This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.
- A remote path mapping is used when your download client is reporting a path for completed data either on another server or in a way that \*Arr doesn't address that folder.
- Generally, a remote path map is only required if your download client is on Linux when \*Arr is on Windows or vice versa. A remote path map is also possibly needed if mixing Docker and Native clients or if using a remote server.
- A remote path map is a DUMB search/replace (where it finds the REMOTE value, replace it with LOCAL value for the specified Host).
- If the error message about a bad path does not contain the REPLACED value, then the path mapping is not working as you expect.  The typical solution is to add and remove the mapping.
- [See TRaSH's Tutorial for additional information regarding remote path mapping](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/)

> If both \*Arr and your Download Client are Docker Containers it is rare a remote path map is needed. It is suggested you [review the Docker Guide](/docker-guide) and/or [follow TRaSH's Tutorial](https://trash-guides.info/hardlinks)
{.is-info}

# Import Lists

> Information on supported list types can be found at the [More Info (Supported)](/radarr/supported#lists) page for this section
{.is-info}

## Lists

Import lists are a part of Radarr that allow you to follow a given list creator. Let's say that you follow a given list creator on Trakt/TMDb and really like their ArrowVerse Collection section and want to watch every show on their list. You look in your Radarr and realize that you do not have those series. Well instead of searching one by one and adding those items and then searching your indexers for those series. You can do this all at once with a List. The Lists can be set to import all the series on that curator's list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that series.

- CAUTION: If lists are done improperly they will absolutely wreck your library with a bunch of trash you have no intention of watching. So make sure of what you're importing before you click save. i.e. physically look at the list before you even go to Radarr.

- Here you can select the <kb>+</kb> button to open a new pop up window
- From this new window you are presented with many different options to set up your list from many different list providers. As stated before be careful when doing lists. It is highly recommended to not select the Search on add button before you're absolutely sure the list you select/setup is adding the series that you're looking for.
- Once you've selected the list provider that you're looking to pull from (such as IMDb or Trakt) You'll be presented with a new window.
Most of the lists settings are fairly self explanatory, some lists require you to authenticate with the provider such as Trakt (requiring you to have an account with Trakt.tv

## List Options

- (Advanced Option) List Update Interval - How often should Radarr poll the list for updates?  [This is a minimum of 6 hours.](/radarr/faq#why-are-lists-sync-times-so-long-and-can-i-change-it)
- (Advanced Option) Clean Library Level - Movies in library will be removed or unmonitored if not in your list(s)
  - Disabled - Do not clean the library (Recommended)
  - Log Only - Only log the movies are not on the list(s) and take no other actions
  - Keep and Unmonitor Movie - Keep movies that are not on the list(s), but unmonitor them in Radarr.
  - Remove Movie and Keep Files - Remove movies that are not on the list(s) from Radarr, but do not delete their files
  - Remove Movie and Delete Files - Remove movies that are not on the list(s) from Radarr and delete their files

## List Exclusions

- Import List Exclusion - This allows you to prune your list of movies you do not want to see again. An example of this is if your list just so happens to contain a movie that is in a foreign language and it is not likely for you to ever find this movie in your native language and do not want to watch it with subtitles. You can exclude a movie from being added in the future. However, in the list exclusion section you can add it back to the list so that when the list runs again it will be read to your library.

# Connect

> Information on supported connection types can be found at the [More Info (Supported)](/radarr/supported#notifications) page for this section
{.is-info}

## Connections

Connections are how you want Radarr to communicate with the outside world.

- By pressing the <kb>+</kb> button you will be presented with a new window which will allow you to configure many different endpoints

- A list of supported notifications & connections is located at the [More Info (Supported)](/radarr/supported#notifications) page

## Connection Triggers

- On Grab - Be notified when movies are available for download and has been sent to a download client
- On Import - Be notified when movies are successfully imported
- On Upgrade - Be notified when movies are upgraded to a better quality
- On Rename - Be notified when movies are renamed
- On Movie Added - Be notified when movies are added to Radarr's library to manage or monitor
- On Movie Delete - Be notified when movies are deleted
- On Movie File Delete - Be notified when movies files are deleted
- On Movie File Delete For Upgrade - Be notified when movie files are deleted for upgrades
- On Health Issue - Be notified on health check failures
  - Include Health Warnings - Be notified on health warnings in addition to errors.
- On Application Update - Be notified when Radarr gets updated to a new version

# Metadata

## Options

- Certification Country - Select the country to use for Movie Certifications (e.g. R (US) or 12A (UK))

## Metadata Consumers

> Information on supported metadata consumers can be found at the [More Info (Supported)](/radarr/supported#metadata) page for this section
{.is-info}

Here you can select the type of metadata that will be consumed by your media player

Kodi will be one of the most commonly used options here if that is the software that is being used. This will allow Radarr to create a NFO file as well as associated movie posters to be scraped into your player

# Tags

- The tag section in Radarr is used to link different aspects of Radarr. They are also useful for tracking which movies come from which lists.
- Tags are particularly useful for:

  - Delay Profiles
  - Restrictions
  - Indexers

- Tags can be used to link Delay Profiles, Indexers, and Restrictions and Movies together.
- For Example:
  - You only want a specific indexer to be used for a specific movie. You would create a tag and assign the movie and indexer that tag.
  - You want a specific Restrictions to only apply to a specific movie. You would create a tag and assign the Restrictions and Movie that tag.
  - This process is the same for Delay Profiles.

> A Movie will use both indexers that have matching tags and indexers that have have no tags.
{.is-warning}

> Note: Tags do not influence any "Custom Formats", "Quality Profiles" or any other aspect not mentioned above.
{.is-info}

# General

## Host

- Bind Address - Valid IPv4 address or '*' for all interfaces
  - 0.0.0.0 or `*` - any address can connect
  - 127.0.0.1 or localhost - only localhost applications can connect
  - Any other IP (e.g. 1.2.3.4) - only that IP (1.2.3.4) can connect
- Port Number - The port number that you are wanting to use to access the webUI for Radarr

> Note: If using Docker do not touch this setting.
{.is-warning}

- URL Base - For reverse proxy support, default is empty

> Note: If using a reverse proxy (example: mydomain.com/radarr) you would enter '/radarr' for URL Base.
{.is-info}

- Enable SSL - If you have SSL credentials and would like to secure communication to and from your Radarr enable this option.

> Note: Do not use this unless you know what you're doing.
{.is-warning}

## Security

- Authentication - How would you like to authenticate to access your Radarr instance
  - As of Radarr v5, Authentication is now mandatory. [See the Mandatory Auth FAQ entry for details.](/radarr/faq#forced-authentication)
  - ~~None - You have no authentication to access your Radarr. Typically if you're the only user of your network, do not have anybody on your network that would care to access your Radarr or your Radarr is not exposed to the web~~
  - Basic (Browser pop-up) - This option when accessing your Radarr will show a small pop-up allowing you to input a Username and Password
  - Forms (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Radarr
- API Key - This is how other programs would communicate or have Radarr communicate to other programs. This key if given to the wrong person with access could do all kinds of things to your library. This is why in the logs the API key is redacted
- Certificate Validation - Change how strict HTTPS certification validation is
  - Enabled - Validate all HTTPS certificates (recommended)
  - Disabled for Local Addresses - Validate all HTTPS certificates except those on localhost and the LAN
  - Disabled - Do not validate any HTTPS certificates
  
## Proxy

Proxy - This option allows you to run the information your Radarr pulls and searches for through a proxy. This can be useful if you're in a country that does not allow the downloading of Torrent files

- Use Proxy - Enable to use a Proxy
- Proxy Type - Select your proxy type (HTTPS, Socks4, or Socks5)
- Hostname - Enter your proxy hostname (Do not include http/https or any other protocol)
- Port - Enter your proxy port
- Username - Enter your proxy username if applicable
- Password - Enter your proxy password if applicable
- Ignored Addresses - Enter a comma-separated list of addresses that bypass the proxy
- Bypass Proxy for Local Addresses - Check the box to bypass the proxy for local addresses. Local requests are identified by the lack of a period (.) in the URI, as in <http://webserver/>, or access the local server, including <http://localhost>, <http://loopback>, or <http://127.0.0.1>. When this is unchecked, all Internet requests are made through the proxy server.

## Logging

- Log level - Probably one of the most useful troubleshooting tools
  - Info - This is the most basic way that Radarr gathers information this will include very minimal amount of information in the logs. This log file contains fatal, error, warn and info entries.
  - Debug - Debug will include all the information that Info includes plus more information that can be useful. This log files contains fatal, error, warn, info and debug entries
  - Trace - The most advance and detailed logging on Radarr, Trace will include all the information gathered by Info and Debug and more. This is the most common type of log that is going to be asked for when troubleshooting on Discord or Reddit. If you're needing help please select your log to Trace and redo the task that was giving you problems to capture the log. This log files contains fatal, error, warn, info, debug and trace entries.

## Analytics

- Analytics - Send anonymous usage and error information to Radarr's servers (Servarr). This includes information on your browser, which Radarr WebUI pages you use, error reporting as well as OS and runtime version. We will use this information to prioritize features and bug fixes.

## Updates

- (Advanced Option) Branch - This is the branch of Radarr that you are running on.
  - [Please see this FAQ entry for more information](/radarr/faq#how-do-i-update-radarr)
- Automatic - Automatically download and install updates. You will still be able to install from System: Updates. Note: Windows Users are always automatically updated.
- Mechanism - Use Radarr built-in updater or a script
  - Built-in - Use Radarr's own updater
  - Script - Have Radarr run the update script
  - Docker - Do not update Radarr from inside the Docker, instead pull a brand new image with the new update
- Script - Visible only when Mechanism is set to Script - Path to update script
- Update Process - Radarr will download the update file, verify its integrity and extract it to a temporary location and call the chosen method. The update process will be be run under the same user that Radarr is run under, it will need permissions to update the Radarr files as well as stop/start Radarr.
- Built-in - The built-in method will backup Radarr files and settings, stop Radarr, update the installation and Start Radarr, if your system will not handle the stopping of Radarr and will attempt to restart it automatically it may be best to use a script instead. In the event of failure the previous version of Radarr will be restarted.
- Script - The script should handle the the same as the built-in updater, if you need to handle stopping and starting services (upstart/launchd/etc) you will need to do that here.

## Backups

- The backup section allows you to tell Radarr how you would like for it to handle backups

- (Advanced Option) Folder - This allows you to select the backup location. In docker you will be limited to what you allow the container to see. Paths are relative to the appdata folder; if necessary, you can set an absolute path to backup outside of the appdata folder.
- (Advanced Option) Interval - How often would you like Radarr to make a backup
- (Advanced Option) Retention - How long would you like Radarr to hold on to each backup. After a new backup is made the oldest backup will be removed

> Manual backups are retained forever, stored in the same folder, and are named differently.
{.is-info}

# UI

## Calendar

- First Day of Week - Here you can select what you think the first day of the week should be.
- Week Column Header - Here you can select the header for the columns

## Movies

- Runtime Format - Select how to format runtimes as either hours & minutes or minutes

## Dates

- Short Date Format - How do you want Radarr to display short dates?
- Long Date Format - How do you want Radarr to display long format dates?
- Time Format - Do you want a 12hr or 24hr format?
- Show Relative Dates - Do you want Radarr to show relative (Today/Yesterday/etc) or absolute dates?

## Style

- Enable Color-Impaired Mode - Altered style to allow color-impaired users to better distinguish color coded information

## Language

- Movie Info Language - Select the Language for Radarr to display Movie Information in the UI
- UI Language - Select the Language for Radarr to use within the application UI
