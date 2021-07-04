---
title: Lidarr Quick Start
description: 
published: true
date: 2021-07-04T23:54:33.295Z
tags: 
editor: markdown
dateCreated: 2021-06-13T06:14:53.615Z
---

> This page is still in progress and not complete. Items to be updated are denoted with //

# Quick Start Guide

In this guide we will explain the basic steps to begin working with Lidarr. This guide assumes that you have already installed the application. Installation instructions can be found [here](/lidarr/installation). We will focus on the minimum setup/options to get a working configuration. There are additional setup and considerations if any of the following situations apply:

- Existing library or files
- Improper use case
- Improper folder structure
- Improper or extremely complicated tagging
- Loose collection of files
- Specialty based music libraries: Classical, Singles, Electronic

If any of the above situations apply please refer to the Quick Start - Advanced section.

This guide is broken into sections. It is recommended to read the whole guide to have a complete understanding but you can jump to specific sections for immediate concerns. Use the outline to the left to quickly jump.

# Concept

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

## Releases (Metadata)

Lidarr has selected the `Release Standard` of music media management. This means that for the system to work properly all media running through the system will need to be a release.

Examples of Releases:

- Album
- EP
- Single
- Broadcast

Every item to be managed must have a correlating release in the 3rd party data service.

> Releases must exist in the 3rd party services to be managed in Lidarr.

## Artist (Metadata)

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

# First Start

After installation and starting Lidarr, you access by opening a browser and go to `http://{your_ip_here}:8686`

![lidarr_qs_startup.png](/assets/lidarr/quick-start-guide/lidarr_qs_startup.png)

There are two options shown on the startup screen but we will not be utilizing those initially.

# Settings

We will be using the default configuration of settings to configure Lidarr. This will utilize the existing Profiles, Quality, Tags, etc.

> For a more detailed breakdown of all the settings, check [Lidarr ->Settings](/lidarr/settings)
{.is-info}

## Media Management

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

## Profiles

`Settings` > `Profiles`

Profile settings will stay at their default values.

## Quality

`Settings` > `Quality`

Quality settings will stay at their default values.

## Indexers

`Settings` > `Indexers`

This section sets the indexer/trackers that you’ll be using to find downloadable media files.

Click on `Add (+)` of `Indexers`. You’ll be presented with a new window with many different options. Lidarr considers both Usenet Indexers and Torrent Trackers as `Indexers`.

Add at least one `Indexer` in order for Lidarr to properly find available files.

Understanding the configuration/concepts behind `Indexers` are beyond the scope of this guide. The internet holds a wealth of information available.

## Download Clients

`Settings` => `Download Clients`

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups, there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

Add at least one `Download Client` in order for Lidarr to properly download files found by the indexer.

Understanding the installation/concepts behind `Download Client's` are beyond the scope of this guide. The internet holds a wealth of information available.

# First Artist

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

![lidarr_qs_dylan.png](/assets/lidarr/lidarr_qs_dylan.png)

> Don't like the metadata downloaded? - Contribute to make it better!
{.is-info}


# First Download/Import

Finally time to download/import your first `Release`! 

//


# // Quick Start - Advanced

## How to import your existing organized media library

Coming soon

- Monitor * - This sets the default monitoring option (`Releases`) for the `Root Folder`.
- Quality Profile * - This sets the default quality option for the `Root Folder`.
- Metadata Profile * - This sets the default metadata option for the `Root Folder`.

