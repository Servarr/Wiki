---
title: Sonarr Quick Start Guide
description: 
published: true
date: 2021-08-22T01:48:45.019Z
tags: sonarr
editor: markdown
dateCreated: 2021-06-11T23:30:27.958Z
---

## Quick Start Setup Guide

> This page is still in progress and not complete.

> For a more detailed breakdown of all the settings, check [Sonarr ->Settings](/sonarr/settings) We will cover the following options.
{.is-info}

In this guide we will try to explain the basic setup you need to do to get started with Sonarr. We're going to skip some options that you may see on the screen. If you want to dive deeper into those, please see the appropriate page in the FAQ for a full explanation.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you will need to click `Show Advanced` at the top of the page to make them visible.
{.is-warning}

## Startup

After installation and starting up, you open a browser and go to `http://{your_ip_here}:8989`

![qs_startup.png](/assets/sonarr/qs_startup.png)

## Media Management

First we’re going to take a look at the `Media Management` settings where we can setup our preferred naming and file management settings.

Click on `Settings` => `Media Management` on the left menu.

### Episode Naming

![qs_episodenaming.png](/assets/sonarr/qs_episodenaming.png)

- Check the box to enable Rename Episodes.
- Decide on your Standard, Daily, and Anime episode naming conventions. You should review the recommended naming conventions [here](https://trash-guides.info/Sonarr/Sonarr-recommended-naming-scheme/).

> If you choose not to include quality/resolution or release group, this is information you cannot regain later. It is highly recommended that you include those in your naming scheme.

### Importing

![mm_importing.png](/assets/sonarr/mm_importing.png)

- (Advanced Option) If you want TBA episodes to be imported immediately, change Episode Title Required to "Never".
- (Advanced Option) Enable `Use Hardlinks instead of Copy` more info how and why with examples [TRaSH's Hardlinks Guide](https://trash-guides.info/hardlinks).
- Check the box to import extra files, and add at least `.srt` to the list.

### Root Folders

Here we will add the root folder that Sonarr will be using to import your existing organized media library and where Sonarr will be importing (copy/hardlink/move) your media after your download client has downloaded it. This is the folder where your series and episodes are stored for your media player to play them. It is NOT where you download files to!

> **Your download folder and media folder can’t be the same location**
{.is-danger}

Don’t forget to save your changes!

## Profiles

`Settings` => `Profiles`

We recommend you to create your own profiles and only select the Quality Sources you actually want. However, there are several pre-filled quality profiles available to choose from as well, if one of those fits. If you need more information about Profiles, please see the appropriate wiki page for that section.

## Indexers

`Settings` => `Indexers`

Here you’ll be adding the indexer/trackers that you’ll be using to actually download any of your files.

Once you’ve clicked the `+` button to add a new indexer, you’ll be presented with a new window with many different options. For the purposes of this wiki Sonarr considers both Usenet Indexers and Torrent Trackers as “Indexers”.

There are two sections here: Usenet and Torrents. Based upon what download client you’ll be using you’ll want to select the type of indexer you’ll be going with.

Most usenet indexers require an API key, which can be found in your Profile page on the indexer's website.

Add at least one indexer in order for Sonarr to work properly.

[More Info](/sonarr/supported#indexers)

### Download Clients

`Settings` => `Download Clients`

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups, there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

[More Info](/sonarr/supported#download-clients)

### {.tabset}

#### Usenet

1. Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
        -   Examples: movies, tv, series, music, ect.
1. Sonarr will monitor your download clients active downloads that use that category name. It monitors this via your download client’s API.
1. When the download is completed, Sonarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Sonarr.
1. Sonarr will scan that completed file location for files that Sonarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
1. Leftover files from the download will be sent to your trash or recycling.

#### BitTorrent

1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Sonarr under the specific download client). When files are imported to your media folder by default Sonarr will copy the file, which uses twice the disk space.
1. An advanced option to hardlink can be enabled (Settings > Media Management > Importing) which will attempt to hardlink the media to your Series folder. A hardlink will allow not use any additional disk space. If the hardlink creation fails, Sonarr will fall back to the default behavior and copy the file.
1. If the “Completed Download Handling - Remove” option is enabled in Sonarr’s settings, Sonarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

## How to import your existing organized media library

After setting up your profiles/quality sizes and added your indexers and download client(s) it’s time to import your existing organized media library.

Coming soon

### Import episodes

Coming soon

#### Importing Existing Media

Depending how well your existing series folders are named, Sonarr will try to match it with the correct series. You should review this list carefully before importing.

Coming soon

#### No match found

Coming Soon

#### Fix faulty folder name after import

Coming Soon
