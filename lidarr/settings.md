---
title: Lidarr Settings
description: 
published: true
date: 2021-10-24T06:15:52.793Z
tags: lidarr, needs-love, settings
editor: markdown
dateCreated: 2021-06-14T21:36:07.513Z
---

## Settings

This page is a work in progress.

## Download Clients

> Information on supported download clients can be found [here](/lidarr/supported#download-clients)
{.is-info}

### Overview

- Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn't one right setup and everyone's setup can be a little different. But there are many wrong setups.

### Download Client Processes

### Usenet

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Lidarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Lidarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Lidarr
- Lidarr will scan that completed file location for files that Lidarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Lidarr will fall back and copy the file then delete from the source which is IO intensive.
- If the "Completed Download Handling - Remove" option is enabled in Lidarr's settings leftover files from the download will be sent to your trash or recycling via a request to your client to delete/remove the release.

### BitTorrent

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Lidarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Lidarr under the specific download client). When files are imported to your media folder Lidarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Lidarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Lidarr's settings, Lidarr will delete the torrent from your client and qsk the client to remove the torrent data, but only if the client reports that seeding is complete and torrent is stopped (paused on completion).

### Download Clients

Click on `Settings =>`Download Clients`, and then click the <kb>+</kb> to add a new download client. Your download client should already be configured and running.

#### Supported Download Clients

- A list of supported download clients is located [here](/Lidarr/supported#downloadclient)

Select the download client you wish to add, and there will be a pop-up box to enter connection details.  These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.

#### Usenet Client Settings

- Name - The name of the download client within Lidarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- API Key - the API key to authenticate to your client
- Username - the username to authenticate to your client (typically not needed)
- Password- the password to authenticate to your client (typically not needed)
- Category - the category within your download client that Lidarr will use
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Client Priority - Priority of the download Client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

#### Torrent Client Settings

- Name - The name of the download client within Lidarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- Username - the username to authenticate to your client
- Password- the password to authenticate to your client
- Category - the category within your download client that Lidarr will use
- Post-Import Category - the category to set after the release is downloaded and imported. Please note that this breaks completed download handling removal.
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Initial State - Initial state for torrents
- Client Priority - Priority of the download Client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

#### Torrent Client Remove Download Compatibility

- Lidarr is only able to set the seed ratio/time on clients that support setting this value via their API when the torrent is added. See the table below for client compatibility.

|      Client       | Ratio |     Time     |
| :---------------: | :---: | :----------: |
|      Deluge       |  Yes  |      No      |
|     Hadouken      |  No   |      No      |
|    qBittorrent    |  Yes  |     Yes      |
|     rTorrent      |  No   |      No      |
| Torrent Blackhole |  No   |      No      |
| Download Station  |  No   |      No      |
|   Transmission    |  Yes  | *Idle Limit* |
|     uTorrent      |  Yes  |     Yes      |
|       Vuze        |  Yes  |     Yes      |

> *Idle Limit* - Transmission internally has an Idle Time check, but Lidarr compares it with the seeding time if the idle limit is set on a per-torrent basis. This is done as workaround to Transmission’s api limitations.{.is-info}

### Completed Download Handling

- Completed Download Handling is how Lidarr imports media from your download client to your series folders.

- Enable (Advanced Global Setting) - Automatically import completed downloads from the download client
- Remove (Per Client Setting) - Remove completed downloads when finished (usenet) or stopped/complete (torrents)
  - For torrents this requires your download client to pause upon hitting the seed goals.  It also requires the seed goals to be supported by Lidarr per the above table.  Torrents must also stay in the same category.

#### Remove Completed Downloads

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
- Lidarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Lidarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
- Lidarr will scan that completed file location for video files. It will parse the video file name to match it to an episode. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
- Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

- Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Lidarr will attempt to hardlink the file or fall back to copy (use double space) if hardlinks are not supported.
- If the "Completed Download Handling - Remove" option is enabled in settings, Lidarr will ask the torrent client to delete the original file and torrent, but this will only occur if the client reports that seeding is complete, the seed goal reached is supported by Lidarr, and torrent is paused (stopped).

#### Failed Download Handling

- Failed Download Handling is only compatible with SABnzbd and NZBGet.
- Failed Downloading Handling does not apply to Torrents nor is their plans to add such functionality.

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
- Remove - Whether or not the download should automatically be removed from Download Client when the failure is detected

### Remote Path Mappings

- Remote Path Mapping acts as a dumb find Remote Path and replace with Local Path This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

- One of our amazing community members have created [an excellent guide](https://trash-guides.info/Lidarr/Lidarr-remote-path-mapping/) to help you out if you think remote path mapping is what will work for you here

## Connections

> Information on supported connection types can be found [here](/lidarr/supported#notifications)
{.is-info}

## Tags

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

## General

### Updates

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
