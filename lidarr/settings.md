---
title: Lidarr Settings
description: 
published: true
date: 2022-07-24T14:21:19.994Z
tags: lidarr, needs-love, settings
editor: markdown
dateCreated: 2021-06-14T21:36:07.513Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Settings](#settings)
- [Download Clients](#download-clients)
  - [Overview](#overview)
  - [Download Client Processes](#download-client-processes)
  - [Usenet](#usenet)
  - [BitTorrent](#bittorrent)
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
  - [Import Lists](#import-lists-1)
  - [Import List Exclusions](#import-list-exclusions)
  - [Adding an Import List](#adding-an-import-list)
- [Connections](#connections)
- [Tags](#tags)
- [General](#general)
  - [Updates](#updates)

# Settings

This page is a work in progress and contributions - based on the other \*Arr pages are both welcome and strongly encouraged.

# Download Clients

> Information on supported download clients can be found at the [More Info (Supported)](/lidarr/supported#download-clients) page for this section
{.is-info}

## Overview

- Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn't one right setup and everyone's setup can be a little different. But there are many wrong setups.

## Download Client Processes

## Usenet

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Lidarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Lidarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Lidarr
- Lidarr will scan that completed file location for files that Lidarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hard links and atomic moves then Lidarr will fall back and copy the file then delete from the source which is IO intensive.
- If the "Completed Download Handling - Remove" option is enabled in Lidarr's settings leftover files from the download will be sent to your trash or recycling via a request to your client to delete/remove the release.

## BitTorrent

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Lidarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Lidarr under the specific download client). When files are imported to your media folder Lidarr will hardlink the file if supported by your setup or copy if not hard links are not supported.
- Hard links are enabled by default. [A hardlink will allow not use any additional disk space.](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/) The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hard links then Lidarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Lidarr's settings, Lidarr will delete the torrent from your client and ask the client to remove the torrent data, but only if the client reports that seeding is complete and torrent is stopped (paused on completion).

## Download Clients

Click on `Settings =>`Download Clients`, and then click the <kb>+</kb> to add a new download client. Your download client should already be configured and running.

### Supported Download Clients

- A list of supported download clients is located at the [More Info (Supported)](/lidarr/supported#downloadclient) page for this section

Select the download client you wish to add, and there will be a pop-up box to enter connection details. These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.

### Usenet Client Settings

- Name - The name of the download client within Lidarr
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

### Torrent Client Settings

- Name - The name of the download client within Lidarr
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
- (Advanced Option) - Priority of the download client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority. 1 is highest priority and 50 is lowest priority

### Torrent Client Remove Download Compatibility

- Lidarr is only able to set the seed ratio/time on clients that support setting this value via their API when the torrent is added. Seed goals can be set globally in the client itself or per tracker in \*Arr settings for each indexer. See the table below for client compatibility.

|      Client       |       Ratio        |                                   Time                                   |
| :---------------: | :----------------: | :----------------------------------------------------------------------: |
|       Aria2       | :white_check_mark: |                                   :x:                                    |
|      Deluge       | :white_check_mark: |                                   :x:                                    |
| Download Station  |        :x:         |                                   :x:                                    |
|       Flood       | :white_check_mark: |                            :white_check_mark:                            |
|     Hadouken      |        :x:         |                                   :x:                                    |
|    qBittorrent    | :white_check_mark: |                            :white_check_mark:                            |
|     rTorrent      | :white_check_mark: |                            :white_check_mark:                            |
| Torrent Blackhole |        :x:         |                                   :x:                                    |
|   Transmission    | :white_check_mark: | ![Idle Limit](https://img.shields.io/badge/Supported-Idle%20Limit*-blue) |
|     uTorrent      | :white_check_mark: |                            :white_check_mark:                            |
|       Vuze        | :white_check_mark: |                            :white_check_mark:                            |

> ![Idle Limit](https://img.shields.io/badge/Supported-Idle%20Limit*-blue) - Transmission internally has an Idle Time check, but Lidarr compares it with the seeding time if the idle limit is set on a per-torrent basis. This is done as workaround to Transmission’s api limitations.{.is-info}

## Completed Download Handling

- Completed Download Handling is how Lidarr imports media from your download client to your series folders.

- Enable (Advanced Global Setting) - Automatically import completed downloads from the download client
- Remove (Per Client Setting) - Remove completed downloads when finished (usenet) or stopped/complete (torrents)
  - For torrents this requires your download client to pause upon hitting the seed goals. It also requires the seed goals to be supported by Lidarr per the above table. Torrents must also stay in the same category.

### Remove Completed Downloads

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
- Lidarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Lidarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
- Lidarr will scan that completed file location for video files. It will parse the video file name to match it to an episode. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
- Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

- Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Lidarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
- If the "Completed Download Handling - Remove" option is enabled in settings, Lidarr will ask the torrent client to delete the original file and torrent, but this will only occur if the client reports that seeding is complete, the torrent is in the same category (i.e. not using a post-import category), the seed goal reached is supported by Lidarr, and torrent is paused (stopped).

### Failed Download Handling

- Failed Download Handling is only compatible with SABnzbd and NZBGet.
- Failed Downloading Handling does not apply to Torrents nor are there plans to add such functionality.

- There are several components that make up the failed download handling process:

- Check Downloader:
  - Queue - Check your downloader's queue for password-protected (encrypted) releases marked as a failure
  - History - Check your downloader's history for failure (e.g. not enough blocks to repair, or extraction failed)
- When Lidarr finds a failed download it starts processing them and does a few things:
  - Adds a failed event to Lidarr's history
  - Removes the failed download from Download Client to free space and clear downloaded files (optional)
  - Starts searching for a replacement file (optional)
  - Blocklisting (fka 'Blacklisting') allows automatic skipping of nzbs when they fail, this means that nzb will not be automatically downloaded by Lidarr ever again (You can still force the download via a manual search).
  - There are 2 advanced options (on 'Download Client' settings page) that control the behavior of failed downloading in Lidarr, at this time, they are all on by default.

- Redownload - Controls whether or not Lidarr will search for the same file after a failure
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

> Information on supported list types can be found at the [More Info (Supported)](/lidarr/supported#lists) page for this section
{.is-info}

Import lists allow you to add items to Lidarr from Spotify or Last .fm. This has the potential to add a lot of unexpected items to your Lidarr database, so please use it with care.

<!-- ![importlists.png](/assets/readarr/importlists.png) -->

## Import Lists

This shows you the lists you currently have, and allows you to add new lists. Adding lists is covered below in more detail.

## Import List Exclusions

Anything on here has been excluded from being added by lists, and will never be added from any list. You can remove items from this by clicking on it.

## Adding an Import List

After clicking the <kb>+</kb>, choose what kind of list you'd like to add:

<!-- ![addlist.png](/assets/readarr/addlist.png) -->

In this instance, we're going to add a Spotify Saved Albums list.

<!-- ![bookshelflist.png](/assets/readarr/bookshelflist.png) -->

- Name - Enter a name for this list.
- Enable Automatic Add - If enabled have anything on the list automatically add to Lidarr.

> This is going to add ALL ALBUMS from that artist to Lidarr!

- Monitor - Select your monitoring level for things added. Valid options are `None`, `Specific Album`, and `All Artist Albums`. All albums are added to Lidarr, but will be monitored or unmonitored based on this selection.
- Root Folder - Choose the root folder for artists added from this list
- Monitor New Albums - Choose what Lidarr should do with future albums of the added artist. Valid options are `All Albums`, `None`, `New`.
- Quality Profile - Choose your quality profile for artists added from this list
- Metadata Profile - Choose your metadata profile for artists added from this list
- Lidarr Tags - Choose what tags apply for artists added from this list

> It is highly recommended that you add a descriptive tag here. Otherwise, you will not know what list added these items to Lidarr, and once they're added you can never get this information again! This info is not logged!

Lists sync by default every 24 hours, but can be triggered manually from the `System` => `Tasks` page. You cannot automate this process any quicker than that.

# Connections

> Information on supported connection types can be found at the [More Info (Supported)](/lidarr/supported#notifications) page for this section
{.is-info}

# Tags

- The tag section in Lidarr is used to link different aspects of Lidarr.
- Tags are particularly useful for:

  - Delay Profiles
  - Release Profiles
  - Indexers

- Tags can be used to link Delay Profiles, Release Profiles, Indexers and Artists/Albums together.
- For Example:
  - You want a specific Artist/Album to only use a specific indexer. You would create a tag and assign the Artist/Album and indexer that tag.
  - You want a specific Release Profile to only use a specific Delay Profile. You would create a tag and assign the Release Profile and Delay Profile that tag.

> Note: Tags do not influence any "Quality Profiles", "Metadata Profiles" or any other aspect not mentioned above.
{.is-info}

# General

## Updates

- (Advanced Option) Branch - This is the branch of Lidarr that you are running on.
  - [Please see this FAQ entry for more information](/lidarr/faq#how-do-i-update-lidarr)
- Automatic - Automatically download and install updates. You will still be able to install from System: Updates. Note: Windows Users are always automatically updated.
- Mechanism - Use Lidarr built-in updater or a script
  - Built-in - Use Lidarr's own updater
  - Script - Have Lidarr run the update script
  - Docker - Do not update Lidarr from inside the Docker, instead pull a brand new image with the new update
- Script - Visible only when Mechanism is set to Script - Path to update script
- Update Process - Lidarr will download the update file, verify its integrity and extract it to a temporary location and call the chosen method. The update process will be be run under the same user that Lidarr is run under, it will need permissions to update the Lidarr files as well as stop/start Lidarr.
- Built-in - The built-in method will backup Lidarr files and settings, stop Lidarr, update the installation and Start Lidarr, if your system will not handle the stopping of Lidarr and will attempt to restart it automatically it may be best to use a script instead. In the event of failure the previous version of Lidarr will be restarted.
- Script - The script should handle the the same as the built-in updater, if you need to handle stopping and starting services (upstart/launchd/etc) you will need to do that here.
