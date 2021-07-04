---
title: Lidarr Quick Start
description: 
published: true
date: 2021-07-04T21:57:29.295Z
tags: 
editor: markdown
dateCreated: 2021-06-13T06:14:53.615Z
---

> This page is still in progress and not complete. Items to be updated are denoted with //

## Quick Start Guide

In this guide we will explain the basic steps to begin working with Lidarr. This guide assumes that you have already installed. Installation instructions can be found [here](/lidarr/installation). We will focus on the minimum setup/options to get a working configuration. There are additional setup and considerations if any of the following situations apply:

- Existing library or files
- Improper use case
- Improper folder structure
- Improper or extremely complicated tagging
- Loose collection of files
- Specialty based music libraries: Classical, Singles, Electronic

If any of the above situations apply please refer to the following section: 
//*(Link to QS Advanced section)*


This guide is broken into sections. It is recommended to read the whole guide to have a complete understanding but you can jump to specific sections for immediate concerns. Use the outline to the left to quickly jump.

## Concept

To properly use Lidarr the underlying concepts must be understood. At a high level it follows the principles of the other Arr applications. It acts as a music library management system, data aggregator and automation platform.

From there the deviation is pretty substantial. Music library management is a very complicated process as there are many competing variables that impede the process. Unlike Movie or TV Show management there are not a consistent set of standards for music tagging, naming or storage. This has been further complicated by the changing methods of music distribution from physical media to electronic. Finally the opinions on how to handle this management are wide and varied.

Lidarr utilizes information from data aggregation services to properly tag and manage the music library. This third party data represents media in defined categories and types.

> If the data does not exist in the 3rd party services it can NOT be managed by Lidarr. 
Details are below to participate and contribute.
{.is-warning}

The main service utilized is [MusicBrainz](https://musicbrainz.org/). This is free service that is community driven and ultimately exists and survives on your contributions and participation. Release creation and contribution is beyond the scope of this guide. Instructions can be found here: [How To Contribute](https://musicbrainz.org/doc/How_to_Contribute)

Ultimately the data is defined by the 3rd party data standards. If the standards do not align with your use case - **Lidarr may not be the proper solution**. Other applications for the management of your media may include:

[Beets Media Management](https://beets.io/)
[MusicBrainz Picard](https://picard.musicbrainz.org/)
[Music Bee](https://getmusicbee.com/)

These implementations may be used in tandem with Lidarr but this is beyond the scope of this guide.

### Releases (Metadata)

Lidarr has selected the `Release Standard` of music media management. This means that for the system to work properly all media running through the system will need to be a release.

Examples of Releases:

- Album
- EP
- Single
- Broadcast

Every item to be managed must have a correlating release in the 3rd party data service.

> Releases must exist in the 3rd party services to be managed in Lidarr.

### Artist

Artists are exactly what are to be expected the `Release Artist`. Unfortunately artist naming, styling, changes over time, user preferences and other reasons have convoluted what constitutes this `Release Artist`.

Examples of correct and incorrect "Artists":

- Bob Dylan
- BOB DYLAN
- The Bob Dylan
- Bob Dylan, The
- Bob Dylan & the Band
- Bob Dylan feat. The Band
- The Band featuring Bob Dylan
- ...

This list could go on and on. All releases are correlated with a artist. You must find and use the proper artist for a release. 

> Artists must exist in the 3rd party services to be managed in Lidarr. 

## 1st Start

After installation and starting Lidarr, you access by opening a browser and go to `http://{your_ip_here}:8686`

//![qs_startup.png](/assets/lidarr/lidarr_qs_startup.png)

There are two options shown on the startup screen but we will not be utilizing those initially. Configure settings to begin utilizing Lidarr.

## Settings

We will be using the default configuration of settings to configure Lidarr. This will utilize the existing Profiles, Quality, Tags, etc.

> For a more detailed breakdown of all the settings, check [Lidarr ->Settings](/lidarr/settings)
{.is-info}

### Media Management

First we’re going to take a look at the `Media Management` where we will set the `Root Folder`. This will be the location that the media files will be stored in.

Click on `Settings` > `Media Management` on the left menu.

//![lidarr_qs_mediamanagement.png](/assets/lidarr/lidarr_qs_mediamanagement.png)

Click on `Add (+)` of the `Root Folders`.

You'll be presented with the following window:

//![lidarr_qs_rootfolder.png](/assets/lidarr/lidarr_qs_rootfolder.png)



> If utilizing a `Root Folder` with existing files. Review the Advanced QuickStart for considerations
{.is-warning}

> Your `Root Folder` and `Download Folder` cannot be the same location!
{.is-danger}

### Profiles

//////////////////////////////////// Everything Past this point - Under Construction

### Episode Naming

![qs_episodenaming.png](/assets/lidarr/lidarr_qs_episodenaming.png)

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

### Download Clients

`Settings` => `Download Clients`

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups, there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

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

//We're going to skip some options that you may see on the screen. If you want to dive deeper into those, please see the appropriate page in the FAQ for a full explanation.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you will need to click `Show Advanced` at the top of the page to make them visible.
{.is-warning}

//If you are not seeing a release in Lidarr it's possible that it has not been added to the data service.
