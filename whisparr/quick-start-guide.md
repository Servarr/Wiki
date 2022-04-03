---
title: Whisparr Quick Start Guide
description:
published: true
date: 2022-03-08T10:31:15.441Z
tags: whisparr, quickstart
editor: markdown
dateCreated: 2021-06-20T20:05:44.814Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Quick Start Setup Guide](#quick-start-setup-guide)
- [Startup](#startup)
- [Media Management](#media-management)
  - [Movie Naming](#movie-naming)
  - [Importing](#importing)
  - [File Management](#file-management)
  - [Root Folders](#root-folders)
- [Profiles](#profiles)
- [Quality](#quality)
- [Indexers](#indexers)
- [Download Clients](#download-clients)
  - [{.tabset}](#tabset)
    - [Usenet](#usenet)
    - [BitTorrent](#bittorrent)
- [How to import your existing organized media library](#how-to-import-your-existing-organized-media-library)
  - [Import movies](#import-movies)
  - [Importing Existing Media](#importing-existing-media)
    - [No match found](#no-match-found)
    - [Fix faulty folder name after import](#fix-faulty-folder-name-after-import)
  - [How to add a movie](#how-to-add-a-movie)

# Quick Start Setup Guide

> This page is still in progress and not complete.

> For a more detailed breakdown of all the settings, check [Whisparr =>Settings](/whisparr/settings)
{.is-info}

In this guide we will try to explain the basic setup you need to do to get started with Whisparr. We're going to skip some options that you may see on the screen. If you want to dive deeper into those, please see the appropriate page in the FAQ and docs for a full explanation.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you will need to click `Show Advanced` at the top of the page to make them visible.
{.is-warning}

# Startup

After installation and starting up, you open a browser and go to `http://{your_ip_here}:6969`

![Whisparr-start.png](/assets/whisparr/Whisparr-start.png)

# Media Management

First we’re going to take a look at the `Media Management` settings where we can setup our preferred naming and file management settings.

`Settings` => `Media Management`

![Whisparr-settings-mm.png](/assets/whisparr/Whisparr-settings-mm.png)

## Movie Naming

![Whisparr-settings-mm-movie-naming.png](/assets/whisparr/Whisparr-settings-mm-movie-naming.png)

1. Enable/Disable Renaming of your movies (as opposed to leaving the names that are currently there or as they were when you downloaded them).
2. If you want illegal characters replaced or removed (`\ / : * ? " < > | ~ # % & + { }`).
3. This setting will dictate how Whisparr handles colons within the movie file.
4. Here you will select the naming convention for the actual movie files.
5. *(Advanced Option) This is where you will set the naming convention for the folder that contains the video file.*

> If you want a recommended naming scheme and examples take a look [TRaSH's Recommended Naming Schemes](https://trash-guides.info/Whisparr/Whisparr-recommended-naming-scheme/).
{.is-info}

## Importing

![Whisparr-settings-mm-importing.png](/assets/whisparr/Whisparr-settings-mm-importing.png)

1. *(Advanced Option) Enable `Use Hardlinks instead of Copy` more info how and why with examples [TRaSH's Hardlinks Guide](https://trash-guides.info/hardlinks).*
1. *(Advanced Option) Import matching extra files (subtitles, nfo, etc) after importing a file.*

## File Management

![Whisparr-settings-mm-fm.png](/assets/whisparr/Whisparr-settings-mm-fm.png)

1. Movies deleted from disk are automatically unmonitored in Whisparr.
    - You may want to delete a movie but do not want Whisparr to re-download the movie. You would use this option.
1. *(Advanced Option) Designate a location for deleted files to go to (just in case you want to retrieve them before the bin is taken out).*
1. *(Advanced Option) This is how old a given file can be before it is deleted permanently.*

## Root Folders

![Whisparr-settings-mm-root-folder.png](/assets/whisparr/Whisparr-settings-mm-root-folder.png)

Here we will add the root folder that Whisparr will be using to import your existing organized media library and where Whisparr will be importing (copy/hardlink/move) your media after your download client has downloaded it.

> \* Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.
> \* If you're using an SMB mount ensure `nobrl` is enabled.
{.is-warning}

> **The user and group you configured Whisparr to run as must have read & write access to this location.** {.is-info}

> Your download client downloads to a download folder and Whisparr imports it to your media folder (final destination) that your media server uses.
{.is-info}

> **Your download folder and media (library / root) folder can’t be the same location**
{.is-danger}

Don’t forget to save your changes

# Profiles

`Settings` => `Profiles`

![Whisparr-settings-profiles.png](/assets/whisparr/Whisparr-settings-profiles.png)

Here you’ll be allowed to configure profiles for which you can have for the quality, preferred language, and custom format scoring of a movie you’re looking to download.

We recommend you to create your own profiles and only select the Quality Sources and Languages you actually want.

For more information on foreign titles and languages see [this FAQ entry](/whisparr/faq#how-does-whisparr-handle-foreign-movies-or-foreign-titles)

> More info at [Settings => Profiles](/whisparr/settings#profiles).
> To see what the difference is between the Quality Sources look [at our Quality Definitions](/whisparr/settings#qualities-defined).
{.is-info}

# Quality

`Settings` => `Quality`

![Whisparr-settings-quality.png](/assets/whisparr/Whisparr-settings-quality.png)

Here you’re able to change/fine tune the min and max size of your wanted media files (when using Usenet keep in mind the RAR/PAR2 files)

> If you need some help with what to use for a Quality Settings check [TRaSH's size recommendations](https://trash-guides.info/Whisparr/Whisparr-Quality-Settings-File-Size/) for a tested example.
{.is-info}

# Indexers

`Settings` => `Indexers`

![Whisparr-settings-indexers.png](/assets/whisparr/Whisparr-settings-indexers.png)

Here you’ll be adding the indexer/tracker that you’ll be using to actually download any of your files.

Once you’ve clicked the `+` button to add a new indexer you’ll be presented with a new window with many different options. For the purposes of this wiki Whisparr considers both Usenet Indexers and Torrent Trackers as “Indexers”.

There are two sections here: Usenet and Torrents. Based upon what download client you’ll be using you’ll want to select the type of indexer you’ll be going with.

# Download Clients

`Settings` => `Download Clients`

![Whisparr-settings-download-clients.png](/assets/whisparr/Whisparr-settings-download-clients.png)

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and to have read & write access to the location the download client reports files the client downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

> See the [settings page](/whisparr/settings#download-clients), [the supported clients page](/whisparr/supported#download-clients), and [TRaSH's Download Client Guides](https://trash-guides.info/Downloaders/) for more information. {.is-info}

## {.tabset}

### Usenet

{#usenet}

- Whisparr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Whisparr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Whisparr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Whisparr
- Whisparr will scan that completed file location for files that Whisparr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Whisparr will fall back and copy the file then delete from the source which is IO intensive.
- If the "Completed Download Handling - Remove" option is enabled in Whisparr's settings leftover files from the download will be sent to your trash or recycling via a request to your client to delete/remove the release.

### BitTorrent

{#bittorrent}

- Whisparr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Whisparr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Whisparr under the specific download client). When files are imported to your media folder Whisparr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Whisparr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Whisparr's settings, Whisparr will delete the torrent from your client and qsk the client to remove the torrent data, but only if the client reports that seeding is complete and torrent is stopped (paused on completion).

# How to import your existing organized media library

After setting up your profiles/quality sizes and added your indexers and download client(s) it’s time to import your existing organized media library.

`Movies`

![Whisparr-movies.png](/assets/whisparr/Whisparr-movies.png)

Select `Import Existing Movies` or select `Import` from the sidebar.

## Import movies

![Whisparr-movies-import.png](/assets/whisparr/Whisparr-movies-import.png)

Select the root path you added earlier [in the root folders section.](#root-folders)

## Importing Existing Media

![Whisparr-importing-existing.png](/assets/whisparr/Whisparr-importing-existing.png)

Depending how well you got your existing movie folders named Whisparr will try to match it with the correct movie as seen at Nr.5 If all your movies are in a single directory follow this [guide](/whisparr/tips-and-tricks#creating-a-folder-for-each-movie)

1. Your movie folder name.
1. How you want the movie to be added to Whisparr.

    > - Yes = Whisparr will monitor the RSS feed for the movie in your library that you do not have (yet) or upgrade the existing movie to a better quality.
    > - No = Whisparr will not monitor the RSS feed, any upgrades or new movies will be ignored and have to be manually done.

1. When will Whisparr consider a movie is available.

    > - **Announced**: Whisparr shall consider movies available as soon as they are added to Whisparr. This setting is *recommended* if you have good private trackers that do not have fakes.
    > - **In Cinemas**: Whisparr shall consider movies available as soon as movies they hit cinemas. This option is *not recommended*.
    > - **Released**: Whisparr shall consider movies available as soon as the Blu-ray is released. This option is *recommended* if your indexers contain fakes often.

1. Select your preferred profile to use.
1. What Whisparr thinks the movie matched for. (if you got to many wrong matched you might need to name your folders better).
1. Mass select Monitor status.
1. Mass select Minimum Availability.
1. Mass select Quality Profile.
1. Start Importing your existing media library.

### No match found

If you’re getting a error like this

![Whisparr-importing-existing-no-match.png](/assets/whisparr/Whisparr-importing-existing-no-match.png)

Then you probably made a mistake with your movie folder naming.

To fix this issue you can try the following

Expand the error message

![Whisparr-importing-existing-no-match-expand.png](/assets/whisparr/Whisparr-importing-existing-no-match-expand.png)

and check on the [themoviedb](https://www.themoviedb.org/) if the year or title matches. in this example you will notice that the year is wrong and you can fix it by changing the year and click on the refresh icon.

![whisparr-importing-existing-no-match-expand-refresh.png](/assets/whisparr/whisparr-importing-existing-no-match-expand-refresh.png)

Or you can just use the tmdb:id or imdb:id and then select the found movie if matched.

![Whisparr-importing-existing-no-match-expand-tmdb.png](/assets/whisparr/Whisparr-importing-existing-no-match-expand-tmdb.png)

![Whisparr-importing-existing-no-match-expand-imdb.png](/assets/whisparr/Whisparr-importing-existing-no-match-expand-imdb.png)

### Fix faulty folder name after import

![Whisparr-wrong-folder-name.png](/assets/whisparr/Whisparr-wrong-folder-name.png)

You will notice after the fix we did during the import that the folder name still has the wrong year in it. To fix this we’re going to do a little magic trick.

Go to you movie overview

`Movies`

On the top click on `Movie Editor`

![Whisparr-movie-editor.png](/assets/whisparr/Whisparr-movie-editor.png)

After activating it you select the movie(s) from where you want to have the folder(s) to be renamed.

![Whisparr-movie-editor-select.png](/assets/whisparr/Whisparr-movie-editor-select.png)

1. If you want all your movie folders renamed to your folder naming scheme you set earlier [movie naming section](#movie-naming).
2. Select the movie(s) from where you want to have the folder(s) to be renamed.
3. Choose the same `Root Folder`

A new popup will be shown

![Whisparr-movie-editor-move-files-yes.png](/assets/whisparr/Whisparr-movie-editor-move-files-yes.png)

Select `Yes, Move the files`

Then Magic

![Whisparr-correct-folder-name.png](/assets/whisparr/Whisparr-correct-folder-name.png)

As you can see the folder has been renamed to the correct year following your naming scheme.

## How to add a movie

After you imported your existing well organized media library it’s time to add the movies you want.

`Movies` => `Add New`

![Whisparr-add-new.png](/assets/whisparr/Whisparr-add-new.png)

Type in the box the movie you want or use the tmdb:id or imdb:id.

When typing out the movie name you will see it will start showing you results.

![Whisparr-movie-search.png](/assets/whisparr/Whisparr-movie-search.png)

When you see the movie you want click on it.

![Whisparr-movie-add.png](/assets/whisparr/Whisparr-movie-add.png)

1. Whisparr will add the Root Folder you’ve setup [in the root folders section](#root-folders)
2. How you want the movie to be added to Whisparr.

    > - Yes = Whisparr will monitor the RSS feed for the movie in your library that you do not have (yet) or upgrade the existing movie to a better quality.
    > - No = Whisparr will not monitor the RSS feed, any upgrades or new movies will be ignored and have to be manually done.{.is-info}
    >
3. When Whisparr shall consider a movie is available..

    > - **Announced**: Whisparr shall consider movies available as soon as they are added to Whisparr. This setting is *recommended* if you have good private trackers that do not have fakes.
    > - **In Cinemas**: Whisparr shall consider movies available as soon as movies they hit cinemas. This option is *not recommended*.
    > - **Released**: Whisparr shall consider movies available as soon as the Blu-ray is released. This option is *recommended* if your indexers contain fakes often.

4. Select your preferred profile to use.
5. Here you can add certain tags for advanced usage.
6. Make sure you enable this if you want Whisparr search for the missing movie when added to Whisparr [more info](/whisparr/faq#how-does-whisparr-find-movies)
7. Click on `Add Movie` to add the movie to Whisparr.

- If you get an error of "path is already configured" [see this FAQ entry](/whisparr/faq#path-is-already-configured-for-an-existing-mqovie)
