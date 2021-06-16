---
title: Sonarr Settings
description: 
published: true
date: 2021-06-16T03:14:40.219Z
tags: sonarr, needs-love, settings
editor: markdown
dateCreated: 2021-06-11T23:29:12.300Z
---

## Media Management

> Some of these settings are only visible through `Show Advanced Settings` which is on the top bar under the search bar{.is-info}

### Episode Naming

- `Rename Episodes` - If unchecked, Sonarr will use the existing file name if renaming is disabled.
- `Replace Illegal Characters` - If unchecked, Sonarr will remove them instead.
  - Example: `\` `#` `/` `$` `*` `<` `>` just to name a few

#### Standard Episode Format

- Here you will select the naming convention for your standard episodes. Click on the `?` to bring up the `File Name Tokens` dialog box.

- Dropdown Box (upper right corner)
  - Left Box - Space Handling
    - `Space ( )` - Use spaces in naming (Default)
    - `Period (.)` - Use periods in lieu of spaces in naming
    - `Underscore (_)` - Use underscores in lieu of spaces in naming
    - `Dash (-)` - Use dashes in lieu of spaces in naming
  - Right Box - Case Handling
    - `Default Case` - Make title uppercase and lowercase (~camelcase) (Default)
    - `Uppercase` - Make title all uppercase
    - `Lowercase` - Make title all lowercase

#### Series Naming

- `{Series Title}` = Series Name!
- `{Series CleanTitleYear}` = Series Title 2010
- `{Series TitleFirstCharacter}` = S
- `{Series CleanTitle}` = Series Title
- `{Series TitleThe}` = Series Title, The
- `{Series TitleYear}` = Series Title (2010)
- `{Series Year}` = (2010)

#### Series IDs

- `{ImdbId}` = tt12345
- `{Tmdbid}` = 123456
- `{TvMazeId}`= 54321

#### Seasons

- `{season:0}` = 1
- `{season:00}` =  01

#### Episodes

- `{episode:0}` = 1
- `{episode:00}` = 01

#### Air Date

- `{Air-Date}` = 2020-09-03
- `{Air Date}` = 2020 09 03

#### Episode Title

- `{Episode Title}` = Episode Title
- `{Episode CleanTitle}` =  Episode Title

#### Quality

- `{Quality Full}` = HDTV 720p Proper
- `{Quality Title}` = HDTV 720p

#### Media Info

- `{MediaInfo Simple}` = x264 DTS
- `{MediaInfo VideoCodec}` = x264
- `{MediaInfo AudioChannels}` = 5.1
- `{MediaInfo SubtitleLanguages}` = [EN]
- `{MediaInfo VideoBitDepth}` = 8
- `{MediaInfo Full}` = x264 DTS [EN+DE]
- `{MediaInfo AudioCodec}` = DTS
- `{MediaInfo AudioLanguages}` = [EN+DE]
- `{MediaInfo VideoCodec}` = x264
- `{MediaInfo VideoDynamicRange}` = HDR

> `MediaInfo Full`, `AudioLanguages`, and `SubtitleLanguages` support a `:EN+DE` suffix allowing you to filter the languages included in the filename. Use `-DE` to exclude specific languages. Appending `+` (e.g.: `:EN+`) will output `[EN]`,`[EN+--]` or `[--]` depending on excluded languages. For example `{MediaInfo Full:EN+DE}`.
{.is-info}

#### Other

- `{Release Group}` = Rls Grp
- `{Preferred Words}` = iNTERNAL
> Preferred words will be the word or words that were the literal matches of any preferred words you have. The above example would be a preferred word of `iNTERNAL` or similarly a preferred word of `/\b(amzn|amazon)\b(?=[ ._-]web[ ._-]?(dl|rip)\b)/i` would return `AMZN` or `Amazon`
{.is-info}

#### Original

- `{Original Title}` = Series.Title.S01E01.HDTV.x264.EVOLVE
- `{Original Filename}` = Series.title.s01e01hdtv.x264.EVOLVE

> `Original Title` is the release name and it is what is suggested to be used.
{.is-info}

>`Original Filename` is not recommended. It is the literal original filename and may be obfuscated `t1i0p3s7i8yuti`.{.is-warning}

#### Daily Episode Format

Here you will select the naming convention for your daily episodes. Click on the `?` to bring up the `File Name Tokens` dialog box.

See [Standard Episode Format](/sonarr/settings#standard-episode-format) for more info about this dialog box.

### Anime Episode Format

Here you will select the naming convention for your anime series. Click on the `?` to bring up the `File Name Tokens` dialog box.

See [Standard Episode Format](/sonarr/settings#standard-episode-format) for more info about this dialog box.

> Typically anime is aired in an absolute order also known as production order. Usually this is shown as `e001`, `e002...e104`, `e105`, etc. When a series is set to use `Anime` this setting will pull the absolute order from `TheTVDB` which is usually one continuous season. An example of this can be seen here{.is-info}

#### Absolute Episode Number

- `{absolute:0}` = 1
- `{absolute:00}` = 01
- `{absolute:000}` =001

### Series Folder Format

Here you will set the naming convention for the folder that contains the season folders or episode files. Click on the `?` to bring up the `File Name Tokens` dialog box.

#### Series Naming

- `{Series Title}` = Series Name!
- `{Series CleanTitleYear}` = Series Title 2010
- `{Series TitleFirstCharacter}` = S
- `{Series CleanTitle}` = Series Title
- `{Series TitleThe}` = Series Title, The
- `{Series TitleYear}` = Series Title (2010)
- `{Series Year}` = (2010)

#### Series IDs

- `{ImdbId}` = tt12345
- `{Tmdbid}` = 123456
- `{TvMazeId}` = 54321

### Season Folder Format

#### Seasons

- `{season:0}` = 1
- `{season:00}` = 01

### Folders

- `Create Empty Media folders` - Create missing series folders during disk scan
- `Delete Empty Folders` - Delete empty series and season folders during disk scan and when episode files are deleted

### Importing

- `Episode Title Required` - Prevent importing for up to 24 hours if the episode title is in the naming format and the episode title is TBA. After 24 hours the release will be imported even if still TBA.
  - `Always` - Always wait up to 24 hours for a title prior to importing if the episode is TBA
  - `Only for Bulk Season Release`s - Only if a season pack or bulk release is found wait up to 24 hours for a title prior to importing if the episode is TBA.
  - `Never` - Do not delay importing if the episode is TBA.
- `Skip Free Space Check` - Use when Sonarr is unable to detect free space from your series root folder
- `Minimum Free Space` - Toggling this will prevent import if it would leave less than this amount of disk space available
- `Use Hard links instead of Copy` - Use Hard links when trying to copy files from torrents that are still being seeded 
  - For more information on this click [here](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/)
 > Occasionally, file locks may prevent renaming files that are being seeded. You may temporarily disable seeding and use Sonarr's rename function as a work around.{.is-warning}
- `Import Extra Files` - Import matching extra files (subtitles, nfo, etc) after importing a file

#### File Management

- `Unmonitor Deleted Episodes` - Episodes deleted from disk are automatically unmonitored in Sonarr
- `Download Proper & Repacks` - Whether or not to automatically upgrade to Propers/Repacks. Use `Do not Prefer` to sort by preferred word score over propers/repacks
  - `Prefer and Upgrade` - Rank repacks and propers higher than non-repacks and non-propers. Treat new repacks and propers as upgrade to current releases.
  - `Do Not Upgrade Automatically` - Rank repacks and propers higher than non-repacks and non-propers. Do not treat new repacks and propers as upgrade to current releases.
  - `Do Not Prefer` - Effectively this ignores repacks and propers. You'll need to manage any preference for those with Release Profiles (Preferred Words).
    -  For more information on propers and repacks click [here](https://trash-guides.info/Sonarr/Sonarr-Release-Profile-RegEx/#propers-and-repacks)
> Use preferred words for automatic upgrades to propers/repacks {.is-info}
- `Analyse video files` - Extract file information such as resolution, runtime and codec information from files. This requires Sonarr to read parts of the file which may cause high disk or network activity during scans.
- `Rescan Series Folder after Refresh` - Rescan the series folder after refreshing the series
  - `Always` - This will rescan series folder based upon Tasks Schedule
  - `After Manual Refresh` - You will have to manually rescan the disk
  - `Never` - Just as it says, never rescan the series folder.
- `Change File Date` - Change file date on import/rescan
  - `None` - Sonarr will not change the date that shows in your given file browser
  - `Local Release` - The date the video was aired locally
  - `UTC Release date` - The date the video was released based upon the UTC
- `Recycling Bin` - Episode files will go here when deleted instead of being permanently deleted
- `Recycling Bin Cleanup` - This is how old a given file can be before it is deleted permanently
> Files in the recycle bin older than the selected number of days will be cleaned up automatically {.is-warning}

#### Permissions

- `Set Permissions` - Should `chmod` be run when files are imported/renamed?
  - `chmod Folder` - Octal, applied during import/rename to media folders and files (without execute bits)
> The drop down box has a preset list of very commonly used permissions that can be used. However, you can manually enter a folder octal if you wish.
{.is-info}

> This only works if the user running `Sonarr` is the owner of the file. It's better to ensure the download client sets the permissions properly.{.is-warning}

- `chown Group` - Group name or GID. Use GID for remote file systems

> This only works if the user running `Sonarr` is the owner of the file. It's better to ensure the download client sets the permissions properly.{.is-warning}

#### Root Folders

- `Path` - This shows the path to your media library
- `Free Space` - This is the free space being reported to Sonarr from the system
- `Unmapped Folders` - These are folders that do not have a Series associated to it
>The `X` at the end will remove this root path{.is-warning}
- `Add Root Folder` - This allows you to select a root path for a place to either place new imported downloads into this folder or to allow Sonarr to scan existing media.

## Profiles

### Quality Profiles

- Here you'll be allowed to set profiles for which you can have for the quality of series you're looking to download.
- When selecting an existing profile or adding an additional profile a new window will appear

> Note: The quality with the blue box will be the quality that is set for
{.is-info}

- Upgrade Until (basically the cutoff)
- Name - Here you'll select a UNIQUE name for the profile to which you are creating
- Upgrades allowed - If you tell Sonarr to download a Web 1080p as it is the first release of a specific episode then later somebody is able to upload a Bluray-1080p then with this selected Sonarr will automatically upgrade to the better quality

> Note: This is only if you have Bluray-1080p higher than Web 1080p within the Qualities section
{.is-info}

- Qualities - For definitions for qualities please click here
- Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases, Prime example of this is WebDL and WebRip as these are very similar and typically have similar bitrates. When editing the groups you can change the preference within each of the groups.
- Qualities higher in the list are more preferred. Qualities within the same group are equal. Only checked qualities are wanted

> Note: By default the qualities are set from lowest (bottom) to highest (top)
{.is-info}

### Language Profiles

- Here you'll be allowed to set profiles for which you can have for the language of series you're looking to download.

> Please note that the priority / order does matter even if the language is not wanted (selected).
{.is-info}

- Name - Select a unique name for this given profile
- Upgrades allowed - If you tell Sonarr download a Chinese version as it is the first release of a specific series then later somebody is able to upload an English version then with this selected Sonarr will automatically upgrade to the better quality

> Note: This is only valid if English is higher in the language list than Chinese and both are selected
{.is-info}

- Languages - Languages higher in the list are more preferred. Only checked languages are wanted

### Delay Profiles

- Delay profiles allow you to reduce the number of releases that will be downloaded for an Episode, by adding a delay while Sonarr will continue to watch for releases that better match your preferences.
- Protocol - This will either be Usenet or Torrent depending on which download protocol you're using
- Usenet Delay - Set by the number of minutes you'll want to wait before the download to start
- Torrent Delay - Set by the number of minutes you'll want to wait before the download to start
- Bypass if Highest Quality - Bypass the delay profile if the highest quality for that Episode is found and grab once the first instance of the highest ranked quality is found. Otherwise wait for the best quality release until the end of the delay period.
- Tags - This is where you'll select any relevant tags that you'll be using for this scheme
- Wrench icon - This will allow you to edit the delay profile
- Plus icon - Create a new profile

#### Uses

Some media will receive half a dozen different releases of varying quality in the hours after a release, and without delay profiles Sonarr might try to download all of them. With delay profiles, Sonarr can be configured to ignore the first few hours of releases.

Delay profiles are also helpful if you want to emphasize one protocol (Usenet or BitTorrent) over the other. (See Example 3)

##### How Delay Profiles Work

The timer begins as soon as Sonarr detects an Episode has a release available. This release will show up in your Queue with a clock icon to indicate that it is under a delay. Please note that the clock starts from the releases uploaded time and not from the time Sonarr sees it.

During the delay period, any new releases that become available will be noted by Sonarr. When the delay timer expires, Sonarr will download the single release which best matches your quality preferences.

The timer period can be different for Usenet and Torrents. Each profile can be associated with one or more tags to allow you to customize which shows have which profiles. A delay profile with no tag is considered the default and applies to all shows that do not have a specific tag.

> NOTE: Delay profiles start from the timestamp that the indexer report the release was uploaded. This means that any content older than the number of minutes you have set are not impacted in any way by your delay profile, and will be downloaded immediately. In addition, any manual searches for content (non-RSS feed searches) will ignore delay profile settings.
{.is-info}

###### Examples

- For each example, assume the user has the follow quality profile active: HDTV 720p and above are allowed WebDL 720p is the quality cutoff * WebDL 1080p is the highest ranked quality

- Example 1

  - In this simple example, the profile is set with a 120 minute (two hour) delay for both Usenet and Torrent.

  - At 11:00pm the first release for an Episode is detected by Sonarr and it was uploaded at 10:50pm and the 120 minute clock begins. At 12:50am, Sonarr will evaluate any releases it has found in the past two hours, and download the best one, which is WebDL 720p.

  - At 3:00am another release is found, which is WebDL 720p that was added to your indexer at 2:46am. Another 120 minute clock begins. At 4:46am the best-available release is downloaded. Since the quality cutoff is now reached, the Episode no longer is upgradable and Sonarr will stop looking for new releases.

  - At any point, if a WebDL 1080p release is found, it will be downloaded immediately because it is the highest-ranking quality. If there is a delay timer currently active it will be cancelled.

- Example 2

  - This example has different timers for Usenet and Torrents. Assume a 120 minute timer for Usenet and a 180 minute timer for BitTorrent.

  - At 11:00pm the first release for an Episode is detected by Sonarr and both timers begin. The release was added to the indexer at 10:15pm At 12:15am, Sonarr will evaluate any releases, and if there are any acceptable Usenet releases, the best one will be downloaded and both timers will end. If not, Sonarr will wait until 12:15am and download the best release, regardless of which source it came from.

- Example 3

  - A common use for delay profiles is to emphasize one protocol over another. For example, you might only want to download a BitTorrent release if nothing has been uploaded to Usenet after a certain amount of time.

  - You could set a 60 minute timer for BitTorrent, and a 0 minute timer for Usenet.

  - If the first release that is detected is from Usenet, Sonarr will download it immediately.

  - If the first release is from BitTorrent, Sonarr will set a 60 minute timer. If any qualifying Usenet release is detected during that timer, the BitTorrent release will be ignored and the Usenet release will be grabbed.

### Release Profiles

- Not all releases are created equal, each release group has their own way of packaging and encoding their material. Here you'll be able to select the preferred releases you're looking for

> Tip: You can use regex (default case sensitive) in the must contain, must not contain, and preferred words values
{.is-info}

- Enable Profile - Toggling this given profile on or off
- Must Contain - The release must contain at least one of these terms (case insensitive)
- Must Not Contain - The release will be rejected if it contains one or more of terms (case insensitive)
- Preferred - Here you can select a given term and give it a score.
  - Let's say you're looking for releases with a specific grouping of words. Let's say you want to tell Sonarr that you want Repacks or Propers over regular releases. Here you'll put the word Repack in one of the fields and give it a value (say 100) but, you're also looking for DTS-HD audio so you'll put that in there and also give it a score (say 100 again). When Sonarr goes through and looks at all the releases from the RSS feed and it comes across a release that has both Repack and DTS-HD that will give it a score of 200. Which is much higher than all the others that don't have either of those words. This tells Sonarr that this has a higher score and it will be the first file picked for download.
- Include Preferred when Renaming - When utilizing the {Preferred Words} tag in the naming scheme
- Indexer - Specify what indexer the profile applies to.
  - This is useful if you only want specific releases from a given indexer/tracker
- Tags - With giving this release profile a tag you'll be able to tag a given series to have it play by the rules set here. If you leave this field blank these rules will apply to all series

## Quality

### Quality Table Meanings

- Title - The name of the Quality in the GUI (configurable)
- Max - The maximum Megabytes per Minute (MB/min) a quality can have.
- Megabytes Per Minute - Self Explanatory
- Min - The minimum Megabytes per Minute (MB/min) a quality can have.
- Preferred - The preferred Megabytes per Minute (MB/min) a quality can have.
- Quality - The scene quality name (hardcoded)
- Size Limit - Self Explanatory

### Qualities Defined

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

## Indexers

- Once you're here you'll be adding the indexer/tracker that you'll be using to actually download any of your files. If you're curious on how Sonarr works with your indexer/tracker click here

### Supported Indexers

#### Usenet

- Newznab
  - Newznab is a standardized API used by many usenet indexing sites.
Many presets are available, but all require an API key to be accessible.
    - Omgwtfnzbs - This indexer also supports newznab and is available as one of the above presets. [Website](https://omgwtfnzbs.me/)
    - Fanzub - Indexer for Japanese media (Anime) exclusively.[Website](http://fanzub.com/)

- Torrents
  - BroadcastheNet - Private Tracker - [Website](https://broadcasthe.net/)
  - Filelist - Private Tracker - [Website](https://filelist.io)
  - HDBits - Private tracker - [Website](https://hdbits.org/)
  - IPTorrents - Private tracker, no search api. -[Website](http://www.iptorrents.com/)
  - Nyaa - Torrent Indexer for Japanese media (Anime) exclusively. - [Website](http://www.nyaa.si/)
  - Rarbg - [Website](https://rarbg.to)
  - Torrent RSS Feed - Generic torrent RSS feed parser.
  > NOTE: The RSS feed must contain a pubdate. The release size is recommended as well.
  {.is-info}
  - Torrentleech - Private Indexer - [Website](http://torrentleech.org/)

  - Torznab
    - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent rss feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same api specification is shared with nZEDb)
    - This is primarily only supported by [Jackett](https://github.com/Jackett/Jackett) and [Prowlarr](/prowlarr)

> Important/Disclaimer: Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments and all. Please review your tracker rules and etiquette, keep your community alive.
We’re not responsible if your account is banned for disobeying rules or accruing HnRs/low-ratio.
{.is-warning}

#### Indexer Settings

- Once you've clicked the + button to add a new indexer you'll be presented with a new window with many different options. For the purposes of this wiki Readarr considers both Usenet Indexers and Torrent Trackers as "Indexers".

- There are two sections here: Usenet and Torrents. Based upon what download client you'll be using you'll want to select the type of indexer you'll be going with.

##### Usenet Indexer Configuration

- Newznab - Here you'll find presets of popular usenet indexers (that are pre-filled out, all you'll need is your API key which is provided by the usenet indexer of your choice) along with the ability to create a custom Indexer
- An excellent software that works with usenet and integrates quite well with Sonarr is [NZBHydra2](https://github.com/theotherp/nzbhydra2/) or [Prowlarr](/prowlarr) which integrates with both Usenet and Torrents
- Regardless of if you select a pre filled out indexer or a custom indexer setup you'll be presented with a new window to input all your settings
- Choose from the presets or add a custom indexer (such as NZBHydra2)
- Name - The name of the indexer in Sonarr
- Enable RSS - If enabled, use this indexer to watch for files that are wanted and missing or have not yet reached their cutoff.
- Enable Automatic Search - If enabled, use this indexer for automatic searches including Search on Add
- Enable Interactive Search - If enabled, use this indexer for manual interactive searches.
- URL - The indexer provided URL of the indexer such as <https://api.nzbgeek.info>.
- API Path - The indexer provided path to the api. This is typically `/api`
- API Key - The indexer provided key to access the API.
- Categories - Default categories will be used unless edited. It is likely these default categories are suboptimal. Upon editing this setting, Sonarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
- Anime Categories - The categories that Sonarr will use for Anime searches No categories will be used unless edited. Upon editing this setting, Sonarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
- Additional Parameters - Additional Newznab parameters to add to the query link
- Indexer Priority - Priority of this indexer to prefer one indexer over another in release tiebreaker scenarios. 1 is highest priority and 50 is lowest priority.

##### Torrent Tracker Configuration

- As with Usenet there are an assortment of prefilled out Torrent tracker information. If you are not a member of any of these these specific trackers they will not do you any good.
- One of the best and simplest ways to utilize Torrent trackers with Sonarr is to utilize a second program such as [Jackett](https://github.com/Jackett/Jackett) or [Prowlarr](/prowlarr). These software pair well with Sonarr as a search indexer that houses all your information and sends it to Sonarr.
- Torznab - This option will set you up with a Jackett preset, if you utilize multiple trackers you'll need to have each entry have a unique name
- Torznab Indexer
- Choose from the presets or add a custom indexer (such as Jackett)
- Name - The name of the indexer in Sonarr
- Enable RSS - If enabled, use this indexer to watch for files that are wanted and missing or have not yet reached their cutoff.
- Enable Automatic Search - If enabled, use this indexer for automatic searches including Search on Add
- Enable Interactive Search - If enabled, use this indexer for manual interactive searches.
- URL - The indexer provided URL of the indexer such as <http://localhost:9117/jackett/api/v2.0/indexers/torrentdb/results/torznab/>.
- API Path - The indexer provided path to the api. This is typically `/api`
- API Key - The indexer provided key to access the API.
- Categories - Default categories will be used unless edited. It is likely these default categories are suboptimal. Upon editing this setting, Sonarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
- Anime Categories - The categories that Sonarr will use for Anime searches No categories will be used unless edited. Upon editing this setting, Sonarr queries the indexer for its available categories and displays them in a selectable a list. The stale defaults will clear as soon as a category is toggled.
- Additional Parameters - Additional Torznab parameters to add to the query link
- Minimum Seeders - The minimum number of seeders required for a release from this tracker to be grabbed.
- Seed Ratio - If empty, use the download client default. Otherwise, the minimum seed ratio required for your download client to meet for releases from this indexer prior to it being paused by your client and removed by Sonarr (Requires Completed Download Handling - Remove enabled)
- Seed Time - If empty, use the download client default. Otherwise, the minimum seed time in minutes required for your download client to meet for releases from this indexer prior to it being paused by your client and removed by Sonarr (Requires Completed Download Handling - Remove enabled)
- Seed Time - If empty, use the download client default. Otherwise, the minimum seed time in minutes required for your download client to meet for season pack releases from this indexer prior to it being paused by your client and removed by Sonarr (Requires Completed Download Handling - Remove enabled)
- Indexer Priority - Priority of this indexer to prefer one indexer over another in release tiebreaker scenarios. 1 is highest priority and 50 is lowest priority.

#### Options

- Minimum Age - Usenet only: Minimum age in minutes of NZBs before they are grabbed. Use this to give new releases time to propagate to your usenet provider.
- Retention - Usenet only: Set to zero to set for unlimited retention
- Maximum Size - Maximum size for a release to be grabbed in MB. Set to zero to set to unlimited
- RSS Sync interval - Interval in minutes. Set to zero to disable (this will stop all automatic release grabbing) Minimum: 10 minutes Maximum: 120 minutes
  - Please see [How does Sonarr find episodes?](/sonarr/faq#how-does-sonarr-find-episodes) for a better understanding of how RSS Sync will help you
  - Note: If Sonarr has been offline for an extended period of time, Sonarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn’t been too long will be able to process the releases it would have missed and avoid you needing to perform a search for the missed releases.

## Download Clients

### Overview

- Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn't one right setup and everyone's setup can be a little different. But there are many wrong setups.

### Download Clients

#### Usenet Process

- Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, ect.
- Sonarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Sonarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Sonarr
- Sonarr will scan that completed file location for files that Sonarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Sonarr will fall back and copy the file then delete from the source which is IO intensive.

#### Usenet Client Settings

- Name - The name of the download client within Sonarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- API Key - the API key to authenticate to your client
- Username - the username to authenticate to your client (typically not needed)
- Password- the password to authenticate to your client (typically not needed)
- Category - the category within your download client that Sonarr will use
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Client Priority - Priority of the download Client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

#### Torrent Process

- Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, ect.
- Sonarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Sonarr under the specific download client). When files are imported to your media folder Sonarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Sonarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Sonarr's settings, Sonarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

#### Torrent Client Settings

- Name - The name of the download client within Sonarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- Username - the username to authenticate to your client
- Password- the password to authenticate to your client
- Category - the category within your download client that Sonarr will use
- Post-Import Category - the category to set after the release is downloaded and imported. Please note that this breaks completed download handling removal.
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Initial State - Initial state for torrents
- Client Priority - Priority of the download Client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

### Completed Download Handling

- Completed Download Handling is how Sonarr imports media from your download client to your series folders. Many common issues are related to bad Docker paths and/or other Docker permissions issues.

- Enable - Automatically import completed downloads from the download client
- Remove - Remove completed downloads when finished (usenet) or stopped/complete (torrents)

#### Remove Completed Downloads

- Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
- Sonarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Sonarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
- Sonarr will scan that completed file location for video files. It will parse the video file name to match it to an episode. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
- Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

- Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Sonarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
- If the "Completed Download Handling - Remove" option is enabled in settings, Sonarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

#### Failed Download Handling

- Failed Download Handling is compatible with SABnzbd and NZBGet.

- There are a couple components that make up the failed download handling process:

- Check Downloader:
  - Queue - Check your downloader's queue for password-protected (encrypted) releases
  - History - Check your downloader's history for failure (eg. not enough to repair, or extraction failed)
- When Sonarr finds a failed download it starts processing them and does a few things:
  - Adds a failed event to Sonarr's history
  - Removes the failed download from Download Client to free space and clear downloaded files (optional)
  - Starts searching for a replacement file (optional)
  - Blacklisting allows automatic skipping of nzbs when they fail, this means that nzb will not be automatically downloaded by Sonarr ever again (You can still force the download via a manual search).
  - There are 2 advanced options (on 'Download Client' settings page) that control the behavior of failed downloading in Sonarr, at this time, they are all on by default.

- Redownload - Controls whether or not Sonarr will search for the same file after a failure
- Remove - Whether or not the download should automatically be removed from Download Client when the failure is detected

### Remote Path Mappings

- Remote Path Mapping acts as a dumb find Remote Path and replace with Local Path This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

- One of our amazing community members have created [an excellent guide](https://trash-guides.info/Sonarr/Sonarr-remote-path-mapping/) to help you out if you think remote path mapping is what will work for you here

## Import Lists

### Lists

Import lists are a part of Sonarr that allow you to follow a given list creator. Let's say that you follow a given list creator on Trakt/TMDb and really like their ArrowVerse Collection section and want to watch every show on their list. You look in your Sonarr and realize that you don't have those series. Well instead of searching one by one and adding those items and then searching your indexers for those series. You can do this all at once with a List. The Lists can be set to import all the series on that curator's list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that series.

CAUTION: If lists are done improperly they will absolutely wreck your library with a bunch of trash you have no intention of watching. So make sure of what you're importing before you click save. ie. physically look at the list before you even go to Sonarr.

Here you can select the + button to open a new pop up window
From this new window you are presented with many different options to set up your list from many different list providers. As stated before be careful when doing lists. It is highly recommended to not select the Search on add button before you're absolutely sure the list you select/setup is adding the series that you're looking for.
Once you've selected the list provider that you're looking to pull from (such as IMDb, IMDb, Trakt) You'll be presented with a new window.
Most of the lists settings are fairly self explanatory, some lists require you to authenticate with the provider such as Trakt (requiring you to have an account with Trakt.tv

### List Exclusions

Import List Exclusion - This allows you to prune your list of movies you don't want to see again. An example of this is if your list just so happens to contain a movie that is in a foreign language and it is not likely for you to ever find this movie in your native language and do not want to watch it with subtitles. You can exclude a movie from being added in the future. However, in the list exclusion section you can add it back to the list so that when the list runs again it will be readded to your library.

## Connect

### Connections

Connections are how you want Sonarr to communicate with the outside world.

By pressing the + button you'll be presented with a new window which will allow you to configure many different endpoints
There are many different endpoints
Boxcar
Custom Scripts - This allows you to make a custom script for when a particular action happens this script will run
Discord - By far one of the most common ways to push notifications of actions happening on your Sonarr
Email - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.
You can use a "pretty address" like SomePrettyName <email@example.org
Emby
Gotify
Join
Kodi - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.
By adding Kodi as a connection you can update Kodi's library when a new episode has been added to Sonarr
Plex Home Theater
Plex Media Center
Plex Media Server - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded episode is available
Prowl
Pushbullet
Pushover
Sendgrid
Slack
Synology Indexer
Telegram
Trakt
Twitter
Connection Triggers
On Grab - Be notified when episodes are available for download and has been sent to a download client
On Import - Be notified when episodes are successfully imported
On Upgrade - Be notified when episodes are upgraded to a better quality
On Rename - Be notified when episodes are renamed
On Series Delete - Be notified when series are deleted
On Episode File Delete - Be notified when episodes files are deleted
On Episode File Delete For Upgrade - Be notified when episode files are deleted for upgrades
On Health Issue - Be notified on health check failures
Include Health Warnings - Be notified on health warnings in addition to errors.

## Metadata

### Metadata

Here you can select the type of metadata that will be consumed by your media player

Kodi will be one of the most commonly used options here if that is the software that is being used. This will allow Sonarr to create a NFO file as well as associated movie posters to be scraped into your player

## Tags

The tag section is for Sonarr is simply used to see what tags you have used and what seriess have that tag associated to it.
Tags can be useful to limit certain aspects of Sonarr to a specific series

## General

### Host

- Binding Address - Valid IP4 address or '*' for all interfaces
  - 0.0.0.0 or* - any address can connect
  - 127.0.0.1 or localhost - only localhost applications can connect
  - Any other IP (e.g. 1.2.3.4) - only that IP (1.2.3.4) can connect
- Port Number - The port number that you are wanting to use to access the webUI for Sonarr

> Note: If using Docker do not touch
{.is-warning}

- URL Base - For reverse proxy support, default is empty

> Note: If using a reverse proxy (example: mydomain.com/sonarr) you would enter '/sonarr' for URL Base.
{.is-info}

- Enable SSL - If you have SSL credentials and would like to secure communication to and from your Sonarr enable this option.

> Note: do not mess with unless you know what you're doing
{.is-warning}

### Security

- Authentication - How would you like to authenticate to access your Sonarr instance
  - None - You have no authentication to access your Sonarr. Typically if you're the only user of your network, do not have anybody on your network that would care to access your Sonarr or your Sonarr is not exposed to the web
  - Basic (Browser pop-up) - This option when accessing your Sonarr will show a small pop-up allowing you to input a Username and Password
  - Forms (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Sonarr
- API Key - This is how other programs would communicate or have Sonarr communicate to other programs. This key if given to the wrong person with access could do all kinds of things to your library. This is why in the logs the API key is redacted
- Certificate Validation - Change how strict HTTPS certification validation is

### Proxy

- Proxy - This option allows you to run the information your Sonarr pulls and searches for through a proxy. This can be useful if you're in a country that does not allow the downloading of Torrent files

### Logging

- Log level - Probably one of the most useful troubleshooting tools
  - Info - This is the most basic way that Sonarr gathers information this will include very minimal amount of information in the logs. This log file contains fatal, error, warn and info entries.
  - Debug - Debug will include all the information that Info includes plus more information that can be useful. This log files contains fatal, error, warn, info and debug entries
  - Trace - The most advance and detailed logging on Sonarr, Trace will include all the information gathered by Info and Debug and more. This is the most common type of log that is going to be asked for when troubleshooting on Discord or Reddit. If you're needing help please select your log to Trace and redo the task that was giving you problems to capture the log. This log files contains fatal, error, warn, info, debug and trace entries.

### Analytics

- Analytics - Send anonymous usage and error information to Sonarr's servers (SkyHook). This includes information on your browser, which Sonarr WebUI pages you use, error reporting as well as OS and runtime version. We will use this information to prioritize features and bug fixes.

### Updates

- Branch - This is the branch of Sonarr that you are running on. Please see Github for available branches and version information. These branches only apply to V3.
  - `main` (Stable): This has been tested by users on nightly branch and it's not known to have any major issues. This branch should be used by the majority of users.
  - `develop` (Nightly) : This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch.
  - `phantom-develop` (v3-preview): This is EOL and the built-in updater will automatically update to main.
- Automatic - Automatically download and install updates. You will still be able to install from System: Updates. Note: Windows Users are always automatically updated.
- Mechanism - Use Sonarr built-in updater or a script
  - Built-in - Use Sonarr's own updater
  - Script - Have Sonarr run the update script
  - Docker - Do not update Sonarr from inside the Docker, instead pull a brand new image with the new update
  - Apt - Set by the Debian/Ubuntu package when updating is managed exclusively via Apt
- Script - Visible only when Mechanism is set to Script - Path to update script
- Update Process - Sonarr will download the update file, verify its integrity and extract it to a temporary location and call the chosen method. The update process will be be run under the same user that Sonarr is run under, it will need permissions to update the Sonarr files as well as stop/start Sonarr.
- Built-in - The built-in method will backup Sonarr files and settings, stop Sonarr, update the installation and Start Sonarr, if your system will not handle the stopping of Sonarr and will attempt to restart it automatically it may be best to use a script instead. In the event of failure the previous version of Sonarr will be restarted.
- Script - The script should handle the the same as the built-in updater, if you need to handle stopping and starting services (upstart/launchd/etc) you will need to do that here.

### Backups

- The backup section allows you to tell Sonarr how you would like for it to handle backups

- Folder - This allows you to select the backup location. In docker you will be limited to what you allow the container to see. Paths are relative to the appdata folder; if necessary, you can set an absolute path to backup outside of the appdata folder.
- Interval - How often would you like Sonarr to make a backup
- Retention - How long would you like Sonarr to hold on to each backup. After a new backup is made the oldest backup will be removed

## UI

### Calendar
- First Day of Week - Here you can select what you think the first day of the week should be.
- Week Column Header - Here you can select the header for the columns

### Dates
- Short Date Format - How do you want Sonarr to display short dates?
- Long Date Format - How do you want Sonarr to display long format dates?
- Time Format - Do you want a 12hr or 24hr format?
- Show Relative Dates - Do you want Sonarr to show relative (Today/Yesterday/etc) or absolute dates?
### Style
- Enable Color-Impaired Mode - Altered style to allow color-impaired users to better distinguish color coded information
