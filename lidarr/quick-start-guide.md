---
title: Lidarr Quick Start
description: 
published: true
date: 2021-10-24T06:10:08.958Z
tags: 
editor: markdown
dateCreated: 2021-06-13T06:14:53.615Z
---

> This page is still in progress and not complete. Items to be updated are denoted with //

## Quick Start Guide

In this guide we will explain the basic steps to begin working with Lidarr. This guide assumes that you have already installed the application. Installation instructions can be found [here](/lidarr/installation). We will focus on the minimum setup/options to get a working configuration. There are additional setup and considerations if any of the following situations apply:

- Existing library or files
- Improper use case
- Improper folder structure
- Improper or extremely complicated tagging
- Loose collection of files
- Specialty based music libraries: Classical, Singles, Electronic

If any of the above situations apply please refer to the Quick Start - Advanced section.

This guide is broken into sections. It is recommended to read the whole guide to have a complete understanding but you can jump to specific sections for immediate concerns. Use the outline to the left to quickly jump.

## Concept

To properly use Lidarr the underlying concepts must be understood. At a high level it follows the principles of the other Arr applications. Lidarr acts as a music library management system, data aggregator and automation platform for finding and downloading media.

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

Lidarr has selected the `Release` standard of music media management. This means that for the system to work properly all media being processed by the system will need to be a `Release`.

Examples of Releases:

- Album
- EP
- Single
- Broadcast

Every item to be managed must have a correlating `Release` in the 3rd party data service.

> `Releases` must exist in the 3rd party services to be managed in Lidarr.

### Artist (Metadata)

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

This list could go on and on. Once again all `Releases` are correlated with a `Artist`. You must find (steps later in this guide) and use the proper `Artist` to download a `Release`.

> `Release Artists` must exist in the 3rd party services to be managed in Lidarr.

## First Start

After installation and starting Lidarr, you access by opening a browser and go to `http://{your_ip_here}:8686`

![lidarr_qs_startup.png](/assets/lidarr/quick-start-guide/lidarr_qs_startup.png)

There are two options shown on the startup screen but we will not be utilizing those initially.

## Settings

We will be using the default configuration of settings to configure Lidarr. This will utilize the existing Profiles, Quality, Tags, etc.

> For a more detailed breakdown of all the settings, check [Lidarr > Settings](/lidarr/settings)
{.is-info}

### Media Management

First we’re going to take a look at the `Media Management` where we will set the `Root Folder`.  This will be the location that the media files will be stored in.

Click on `Settings` > `Media Management` on the left menu.

![lidarr_qs_mediamanagement.png](/assets/lidarr/quick-start-guide/lidarr_qs_mediamanagement.png)

Click on `Add (+)` of the `Root Folders`.

You'll be presented with the following window:

![lidarr_qs_rootfolder.png](/assets/lidarr/quick-start-guide/lidarr_qs_rootfolder.png)

- **Name** - This is the `Friendly Name` of the storage location.
- **Path** - This is the actual `Path` to the data storage location. The system/user must have the proper permissions to this storage path. This folder cannot be your download location!

Leave the other options at their defaults.

> If utilizing a `Root Folder` with existing files. Review the Quick Start - Advanced section for considerations.
{.is-warning}

> Your `Root Folder` and `Download Folder` cannot be the same location!
{.is-danger}

### Profiles

`Settings` > `Profiles`

Profile settings will stay at their default values.

### Quality

`Settings` > `Quality`

Quality settings will stay at their default values.

### Indexers

`Settings` > `Indexers`

This section sets the indexer/trackers that you’ll be using to find downloadable media files.

Click on `Add (+)` of `Indexers`. You’ll be presented with a new window with many different options. Lidarr considers both Usenet Indexers and Torrent Trackers as `Indexers`.

Add at least one `Indexer` in order for Lidarr to properly find available files.

Understanding the configuration/concepts behind `Indexers` are beyond the scope of this guide. The internet holds a wealth of information on the subject.

### Download Clients

`Settings` => `Download Clients`

![Lidarr-settings-download-clients.png](/assets/lidarr/Lidarr-settings-download-clients.png)

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

#### {.tabset}

##### Usenet

{#usenet}

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. 
  - Examples: movies, tv, series, music, etc.
- Lidarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Lidarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Lidarr
- Lidarr will scan that completed file location for files that Lidarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Lidarr will fall back and copy the file then delete from the source which is IO intensive.
- If the "Completed Download Handling - Remove" option is enabled in Lidarr's settings leftover files from the download will be sent to your trash or recycling via a request to your client to delete/remove the release.

##### BitTorrent

{#bittrrent}

- Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. 
  - Examples: movies, tv, series, music, etc.
- Lidarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Lidarr under the specific download client). When files are imported to your media folder Lidarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Lidarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Lidarr's settings, Lidarr will delete the torrent from your client and qsk the client to remove the torrent data, but only if the client reports that seeding is complete and torrent is stopped (paused on completion).

## First Artist

If following this guide and your `Root Folder` did not have any media files you will need to add an `Artist`.

`Library` > `Add New`

![lidarr_qs_addnew.png](/assets/lidarr/quick-start-guide/lidarr_qs_addnew.png)

This will link to the search screen to find an artist. Search and select the `Artist` you want to add. This will bring up the "Add new Artist" window.

![lidarr_qs_addnewdylan.png](/assets/lidarr/quick-start-guide/lidarr_qs_addnewdylan.png)

We will utilize the default selections. Which should include:

- Root Folder - The folder you created
- Monitor - None
- Quality Profile - Any
- Tags - (empty)
- Start search for missing albums - Unchecked

This will kick off the `Artist` metadata download. This will take some time depending on the amount of data to gather. Remember this information comes 3rd party sources and is only as complete as what the community has contributed.

Click the newly added `Artist`. (Bob Dylan in this example)

> The default `Metadata Profile` is in use the only `Releases` shown will be of the type `Studio Albums`.

![lidarr_qs_dylan.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylan.png)

> Don't like the metadata downloaded? - Contribute to make it better!
{.is-info}

## First Download/Import

Finally time to download/import your first `Release`!

Find the `Release` that you are looking to add to your library. Select the Manual Search (human) icon next to the release.

![lidarr_qs_dylanrelease.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylanrelease.png)

This will bring up the `Release` selection window. This windows will display the results of the `Indexer` query or simply put the search results of available downloads.

> The default `Quality Profile` allows any file type. The default `Release Profile` allows all downloads. For a detailed breakdown of these advanced settings, check [Lidarr > Settings](/lidarr/settings)

![lidarr_qs_dylandownload.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylandownload.png)

Review the download window for the various provided information:

1. Title - This is the name of the download as returned by the `Indexer`.
1. Quality - This is quality as determined by Lidarr utilizing the title.
1. The warning indicators will give a description of why the download has failed the Lidarr checks. In the example the search returned "Wrong Album".

When you have reviewed select the download icon (number 4) to download the available `Release`.

If configured properly the download will be sent to your `Download Client`.

The download will be added to the `Queue` and will go through the various states of your type of `Download Client`.

Finally the download will be imported to your `Root Folder`. If everything is successful it should appear as below.

![lidarr_qs_dylansucess.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylansuccess.png)

You can find your downloaded files in your `Root Folder` and are able to consume utlizing your media player of choice.

![lidarr_qs_dylanfolder.png](/assets/lidarr/quick-start-guide/lidarr_qs_dylanfolder.png)

## Quick Start - Advanced

This advanced section is intended for setups that may have special considerations. Review if any apply to your configuration and potentially save some headache.

>The following sections will assist with common pitfalls and problems.
{.is-warning}

### Lidarr Use Case

As stated ealier in the Concept section. Lidarr should not be used if your intended use does not match Lidarr's management system of `Releases`. Lidarr will NOT work with the following use cases:

- Loose collection of files - Files from multiple artists (Not Compilations) or multiple `Releases`
- Specialty based music libraries: Classical, Singles, Electronic

#### Loose Files

Low to no curation of loose files will not work with Lidarr. Best to not attempt utilizing these files with Lidarr.

#### Speciality Libraries

Speciality libraries create unique issues for any management system. These situations may work with Lidarr but it may require extensive work on your part, pretty much foregoing the automations built in. For example:

- **Classical Music** - Usually has extensive tagging requirements or desires. `Releases` metadata will likely not exist or be incorrect.
- **Singles** - Singles may not be actual `Releases`. 3rd party data services will return no metadata. They will not be automated and Lidarr will not be able to apply management.
- **Electronic** - This does NOT apply to `Releases` in the Electronic genre. This is in relation to libraries of mixes, beats, samples etc. (Beatport). 3rd party data sources do not recognize these as `Releases`. They will not be automated and Lidarr will not be able to apply management.

### Importing existing library or files

> Automated Import is a scheduled process and cannot be stopped once started
Do NOT add a `Root Folder` with existing files until you have reviewed this section in full
{.is-warning}

Lidarr utilizes an automated system of adding `Release Artists` and `Releases` located in your `Root Folder`.

If Lidarr's use case matches and you do not have unique or speciality libraries. You can proceed with importing your existing library.

It is imperative that your existing library files are structured and follow Lidarrs management system of `Releases`. This means the following will not work:

- Improper folder structure - Files located in a singular folder - Refer to Preparing>Folder Structure section
- Improper or extremely complicated tagging - Refer to Preparing>Tagging section

#### Preparing your existing files

For the automated process to work your files must be prepped to make sure this flows efficiently or works at all.

##### Folder Structure

It is recommended to follow the standard folder structure:

\Root Folder\Release Artist\Release\XX - Track

This when combined with proper tags will allow for almost 95% or greater recognition by media players.

##### Tagging

Tagging can be a complicated procedure. The amount of files and how they are currently tagged will determine the amount of effort required.

The recommended methods for tagging your files include:

- MusicBrainz Picard
- Beets
- MusicBee, MediaMonkey, JRiver

Use of these applications is beyond the scope of this guide but it is preferable to associate MusicBrainz Release ID's as part of the tagging process.

> Most tagging software is capable of Folder Structure & Renaming while properly tagging files.
{.is-info}

#### Pre-Import Considerations

Once files are properly tagged and named the following items should be verified to ensure that the process will complete successfully:

- **System Architecture** - Recommended x64 / 64 Bit - Importing large libraries requires the system to access large amounts of RAM and compute more efficiently. x86 / 32 Bit is supported but will not be as efficient and take substantially more time.
- **System Memory Requirement (RAM)** - Minimum 4GB, Recommended 8GB - The import process is memory intensive and having Lidarr importing and a browser open will result in substantial amounts of RAM usage.
- **`Release` Disc/Track Limits** - Releases that have substantial amounts of tracks or discs should be removed from the import process. They can be manually imported utilizing the built in procedures. There is no exact limit but to be safe releases larger then 25 discs or 250 tracks should be removed.
- **`Release Artist` with many `Releases`** - Lidarrs automated process compares releases to your files. Though not likely to fail, having these files go through the automated procedure will result in a substantial increase in import time. There are singular artists with 1000's of releases.
- **Time** - The automated import procedure takes time. A resonable estimation would be 1 hour for 500 properly tagged `Releases`. This is highly variable based on your storage, internet speed and system performance.

#### Begin Import

//

Coming soon

- Monitor * - This sets the default monitoring option (`Releases`) for the `Root Folder`.
- Quality Profile * - This sets the default quality option for the `Root Folder`.
- Metadata Profile * - This sets the default metadata option for the `Root Folder`.
