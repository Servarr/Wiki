---
title: Sonarr Quick Start Guide
description: 
published: true
date: 2024-07-19T20:16:08.572Z
tags: sonarr, needs-love
editor: markdown
dateCreated: 2021-09-03T19:14:22.283Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Quick Start Setup Guide](#quick-start-setup-guide)
- [Startup](#startup)
- [Media Management](#media-management)
  - [Episode Naming](#episode-naming)
  - [Importing](#importing)
  - [Root Folders](#root-folders)
- [Profiles](#profiles)
- [Indexers](#indexers)
- [Download Clients](#download-clients)
  - [Usenet](#usenet)
  - [BitTorrent](#bittorrent)
- [How to import your existing organized media library](#how-to-import-your-existing-organized-media-library)
  - [Import episodes](#import-episodes)
    - [Importing Existing Media](#importing-existing-media)
    - [No match found](#no-match-found)
    - [Fix faulty folder name after import](#fix-faulty-folder-name-after-import)
- [Add New Series](#add-new-series)

# Quick Start Setup Guide

> This page is still in progress and not complete. Contributions are welcome

> For a more detailed breakdown of all the settings, check [Sonarr =>Settings](/sonarr/settings)
{.is-info}

In this guide we will try to explain the basic setup you need to do to get started with Sonarr. We're going to skip some options that you may see on the screen. If you want to dive deeper into those, please see the appropriate page in the FAQ and docs for a full explanation.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you will need to click `Show Advanced` at the top of the page to make them visible.
{.is-warning}

# Startup

After installation and starting up, you open a browser and go to `http://{your_ip_here}:8989`

![qs_startup.png](/assets/sonarr/qs_startup.png)

# Media Management

First we’re going to take a look at the `Media Management` settings where we can setup our preferred naming and file management settings.

Click on `Settings` => `Media Management` on the left menu.

## Episode Naming

![qs_episodenaming.png](/assets/sonarr/qs_episodenaming.png)

- Check the box to enable Rename Episodes.
- Decide on your Standard, Daily, and Anime episode naming conventions. You should review the recommended naming conventions [here](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/).

> If you choose not to include quality/resolution or release group, this is information you cannot regain later. It is highly recommended that you include those in your naming scheme.
{.is-info}

## Importing

![mm_importing.png](/assets/sonarr/mm_importing.png)

- (Advanced Option) If you want TBA episodes to be imported immediately, change Episode Title Required to "Never".
- (Advanced Option) Enable `Use Hardlinks instead of Copy` more info how and why with examples [TRaSH's Hardlinks Guide](https://trash-guides.info/hardlinks).
- Check the box to import extra files, and add at least `.srt` to the list.

## Root Folders

Here we will add the root folder that Sonarr will be using to import your existing organized media library and where Sonarr will be importing (copy/hardlink/move) your media after your download client has downloaded it. This is the folder where your series and episodes are stored for your media player to play them. It is NOT where you download files to!

> \* Non-Windows Users: If you're using an NFS mount ensure `nolock` is enabled.
> \* If you're using an SMB mount ensure `nobrl` is enabled.
{.is-warning}

> **The user and group you configured Sonarr to run as must have read & write access to this location.**
{.is-info}

> **Your download folder and media folder can’t be the same location**
{.is-danger}

Don’t forget to save your changes!

# Profiles

`Settings` => `Profiles`

We recommend you to create your own profiles and only select the Quality Sources you actually want. However, there are several prefilled quality profiles available to choose from as well, if one of those fits. If you need more information about Profiles, please see the [appropriate wiki page](/sonarr/settings#profiles) for that section.

# Indexers

`Settings` => `Indexers`

Here you’ll be adding the indexer/trackers that you’ll be using to actually download any of your files.

Once you’ve clicked the <kb>+</kb> button to add a new indexer, you’ll be presented with a new window with many different options. For the purposes of this wiki Sonarr considers both Usenet Indexers and Torrent Trackers as “Indexers”.

There are two sections here: Usenet and Torrents. Based upon what download client you’ll be using you’ll want to select the type of indexer you’ll be going with.

Most usenet indexers require an API key, which can be found in your Profile page on the indexer's website.

Most torrent trackers require [Prowlarr](/prowlarr) or Jackett to be used in Sonarr

Add at least one indexer in order for Sonarr to work properly.

> See the [settings page](/sonarr/settings#indexers) and at the [More Info (Supported)](/sonarr/supported#indexers) page for this section for more information.
{.is-info}

# Download Clients

`Settings` => `Download Clients`

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

> See the [settings page](/sonarr/settings#download-clients), at the [More Info (Supported)](/sonarr/supported#download-clients) page for this section, and [TRaSH's Download Client Guides](https://trash-guides.info/Downloaders/) for more information.
{.is-info}

## {.tabset}

### Usenet

{#usenet}

- Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Sonarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Sonarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Sonarr
- Sonarr will scan that completed file location for files that Sonarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Sonarr will fall back and copy the file then delete from the source which is IO intensive.
- If the "Completed Download Handling - Remove" option is enabled in Sonarr's settings leftover files from the download will be sent to your trash or recycling via a request to your client to delete/remove the release.

### BitTorrent

{#bittorrent}

- Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Sonarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Sonarr under the specific download client). When files are imported to your media folder Sonarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. [A hardlink will allow not use any additional disk space.](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/) The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Sonarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Sonarr's settings, Sonarr will delete the torrent from your client and ask the client to remove the torrent data, but only if the client reports that seeding is complete and torrent is stopped (paused on completion).

# How to import your existing organized media library

> Note that Sonarr does not regularly search for Episodes.  See the FAQ Entry for details to understand how Sonarr works.
[How does Sonarr find episodes?](/sonarr/faq#how-does-sonarr-find-episodes)
{.is-info}

After setting up your profiles/quality sizes and added your indexers and download client(s) it’s time to import your existing organized media library.

Coming soon - Contributions Welcome

## Importing Existing Media

Depending how well your existing series folders are named, Sonarr will try to match it with the correct series. You should review this list carefully before importing.

Library Import is only to be used on an existing organized library and shall not be used on a download folder or to ad-hoc import media.

1. Navigate to Library Import
1. Read and understand the Library Import Help Text
1. Select or add the root (library) folder to import series from
1. Review Sonarr's mapping/matching of Series Folders to TVDb series
1. Set your monitoring settings and quality profile as appropriate
1. Click Start Import

### No match found

1. Search the series name or TVDbId in the series selection box
1. See [this FAQ entry](/sonarr/faq#why-can-i-not-add-a-series) if the series cannot be found

### Fix faulty folder name after import

1. Remove the Series from Sonarr
1. Library Import
1. Ensure the series is mapped correctly

# Add New Series

[Refer to the Library Page for additional information](/sonarr/library#add-new)

# Import Episodes

- Use Wanted => Manual Import to import episode files to their series folders on an ad-hoc basis
- Use Manage Episodes on a series' page to remap or map existing episode files in a series folder
