---
title: Radarr Quick Start Guide
description: 
published: true
date: 2021-06-05T21:16:47.933Z
tags: 
editor: markdown
dateCreated: 2021-05-17T01:51:10.479Z
---

## Setup Guide

In this guide we will try to explain the basic setup you need to do to get started with Radarr.

> For a more detailed breakdown of all the setting check [Radarr ->Settings](Radarr_Settings "wikilink") We will cover the following options.
{.is-info}
> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you'll need to enable those to make them visible.
{.is-warning}

### Startup

After installation and starting up, you open a browser and go to `http://{your_ip_here}:7878`

![Radarr-start.png](/assets/radarr/Radarr-start.png)

### Media Management

First we’re going to take a look at the `Media Management` settings where we can setup our preferred naming and file management settings.

`Settings` =\> `Media Management`

![Radarr-settings-mm.png](/assets/radarr/Radarr-settings-mm.png)

#### Movie Naming

![Radarr-settings-mm-movie-naming.png](/assets/radarr/Radarr-settings-mm-movie-naming.png)

1. Enable/Disable Renaming of your movies (as opposed to leaving the names that are currently there or as they were when you downloaded them).
2. If you want illegal characters replaced or removed (`\ / : * ? " < > | ~ ## % & + { }`).
3. This setting will dictate how Radarr handles colons within the movie file.
4. Here you will select the naming convention for the actual movie files.
5. *(Advanced Option) This is where you will set the naming convention for the folder that contains the video file.*

> If you want a recommended naming scheme and examples take a look [TRaSH's Recommended Naming Schemes](https://trash-guides.info/Radarr/Radarr-recommended-naming-scheme/).
{.is-info}

#### Importing

![Radarr-settings-mm-importing.png](/assets/radarr/Radarr-settings-mm-importing.png)

1. *(Advanced Option) Enable `Use Hardlinks instead of Copy` more info how and why with examples [TRaSH's Hardlinks Guide](https://trash-guides.info/hardlinks).*
1. *(Advanced Option) Import matching extra files (subtitles, nfo, etc) after importing a file.*

#### File Management

![Radarr-settings-mm-fm.png](/assets/radarr/Radarr-settings-mm-fm.png)

1. Movies deleted from disk are automatically unmonitored in Radarr.
    - You may want to delete a movie but do not want Radarr to re-download the movie. You would use this option.
1. *(Advanced Option) Designate a location for deleted files to go to (just in case you want to retrieve them before the bin is taken out).*
1. *(Advanced Option) This is how old a given file can be before it is deleted permanently.*

#### Root Folders

![Radarr-settings-mm-root-folder.png](/assets/radarr/Radarr-settings-mm-root-folder.png)

Here we will add the root folder that Radarr will be using to import your existing organized media library and where Radarr will be importing (copy/hardlink/move) your media after your download client has downloaded it.

> Your download client downloads to a download folder and Radarr imports it to your media folder (final destination) that your media server uses.
{.is-info}
> **Your download folder and media folder can’t be the same location**
{.is-danger}

Don’t forget to save your changes

### Profiles

`Settings` =\> `Profiles`

![Radarr-settings-profiles.png](/assets/radarr/Radarr-settings-profiles.png)

Here you’ll be allowed to set profiles for which you can have for the quality of movie you’re looking to download Here you'll be allowed to set profiles for the quality of movie you're looking to download

More info [Settings -> Profiles](https://wiki.servarr.com/Radarr_Settings#Profiles).

We recommend you to create your own profiles and only select the Quality Sources you actually want.

> More info [Settings -> Profiles](https://wiki.servarr.com/Radarr_Settings#Profiles).
> To see what the difference is between the Quality Sources look [at our Quality Definitions](https://wiki.servarr.com/Radarr_Settings#Qualities_Defined).
{.is-info}

### Quality

`Settings` =\> `Quality`

![Radarr-settings-quality.png](/assets/radarr/Radarr-settings-quality.png)

Here you’re able to change/fine tune the min and max size of your wanted media files (when using usenet keep in mind the RAR/PAR2 files)

> If you need some help with what to use for a Quality Settings check [TRaSH's size recommendations](https://trash-guides.info/Radarr/Radarr-Quality-Settings-File-Size/) for a tested example.
{.is-info}

### Indexers

`Settings` =\> `Indexers`

![Radarr-settings-indexers.png](/assets/radarr/Radarr-settings-indexers.png)

Here you’ll be adding the indexer/tracker that you’ll be using to actually download any of your files.

Once you’ve clicked the `+` button to add a new indexer you’ll be presented with a new window with many different options. For the purposes of this wiki Radarr considers both Usenet Indexers and Torrent Trackers as “Indexers”.

There are two sections here: Usenet and Torrents. Based upon what download client you’ll be using you’ll want to select the type of indexer you’ll be going with.

> More information on Indexers and Trackers can be found [on our definitions page](https://wiki.servarr.com/Definitions#Indexers.2FTrackers)
{.is-info}

### Download Clients

`Settings` =\> `Download Clients`

![Radarr-settings-download-clients.png](/assets/radarr/Radarr-settings-download-clients.png)

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

### {.tabset}

#### Usenet

1. Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
        -   Examples: movies, tv, series, music, ect.
1. Radarr will monitor your download clients active downloads that use that category name. It monitors this via your download client’s API.
1. When the download is completed, Radarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Radarr
1. Radarr will scan that completed file location for files that Radarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
1. Leftover files from the download will be sent to your trash or recycling.

#### BitTorrent

1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Radarr under the specific download client). When files are imported to your media folder by default Radarr will copy the file, which uses twice the disk space.
1. An advanced option to hardlink can be enabled (Settings > Media Management > Importing) which will attempt to hardlink the media to your Series folder. A hardlink will allow not use any additional disk space. If the hardlink creation fails, Radarr will fall back to the default behavior and copy the file.
1. If the “Completed Download Handling - Remove” option is enabled in Radarr’s settings, Radarr} will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

### How to import your existing organized media library

After setting up your profiles/quality sizes and added your indexers and download client(s) it’s time to import your existing organized media library.

`Movies`

![Radarr-movies.png](/assets/radarr/Radarr-movies.png)

Select `Import Existing Movies` or select `Import` from the sidebar.

#### Import movies

![Radarr-movies-import.png](/assets/radarr/Radarr-movies-import.png)

Select the root path you added earlier [in the root folders section.](#root-folders "wikilink")

##### Importing Existing Media

![Radarr-importing-existing.png](/assets/radarr/Radarr-importing-existing.png)

Depending how well you got your existing movie folders named Radarr will try to match it with the correct movie as seen at Nr.5 If all your movies are in a single directrly follow this [guide](https://wiki.servarr.com/Radarr_Tips_and_Tricks#Create_a_Folder_for_Each_Movie)

1. Your movie folder name.
1. How you want the movie to be added to Radarr.
    >
    > - Yes = Radarr will monitor the RSS feed for the movie in your library that you do not have (yet) or upgrade the existing movie to a better quality.
    > - No = Radarr will not monitor the RSS feed, any upgrades or new movies will be ignored and have to be manually done.
    >
1. When will Radarr consider a movie is available.

    > - **Announced**: Radarr shall consider movies available as soon as they are added to Radarr. This setting is *recommended* if you have good private trackers (or really good public ones, e.g. rarbg.to) that do not have fakes.
    > - **InCinemas**: Radarr shall consider movies available as soon as movies they hit cinemas. This option is *not recommended*.
    > - **Physical / Web**: Radarr shall consider movies available as soon as the Blu-ray is released. This option is *recommended* if your indexers contain fakes often.

1. Select your preferred profile to use.
1. What Radarr thinks the movie matched for. (if you got to many wrong matched you might need to name your folders better).
1. Mass select Monitor status.
1. Mass select Minimum Availability.
1. Mass select Quality Profile.
1. Start Importing your existing media library.

##### No match found

If you’re getting a error like this

![Radarr-importing-existing-no-match.png](/assets/radarr/Radarr-importing-existing-no-match.png)

Then you probably made a mistake with your movie folder naming.

To fix this issue you can try the following

Expand the error message

![Radarr-importing-existing-no-match-expand.png](/assets/radarr/Radarr-importing-existing-no-match-expand.png)

and check on the [themoviedb](https://www.themoviedb.org/) if the year or title matches. in this example you will notice that the year is wrong and you can fix it by changing the year and click on the refresh icon.

![radarr-importing-existing-no-match-expand-refresh.png](/assets/radarr/radarr-importing-existing-no-match-expand-refresh.png)

Or you can just use the tmdb:id or imdb:id and then select the found movie if matched.

![Radarr-importing-existing-no-match-expand-tmdb.png](/assets/radarr/Radarr-importing-existing-no-match-expand-tmdb.png)

![Radarr-importing-existing-no-match-expand-imdb.png](/assets/radarr/Radarr-importing-existing-no-match-expand-imdb.png)

##### Fix faulty folder name after import

![Radarr-wrong-folder-name.png](/assets/radarr/Radarr-wrong-folder-name.png)

You will notice after the fix we did during the import that the folder name still has the wrong year in it. To fix this we’re going to do a little magic trick.

Go to you movie overview

`Movies`

On the top click on `Movie Editor`

![Radarr-movie-editor.png](/assets/radarr/Radarr-movie-editor.png)

After activating it you select the movie(s) from where you want to have the folder(s) to be renamed.

![Radarr-movie-editor-select.png](/assets/radarr/Radarr-movie-editor-select.png)

1. If you want all your movie folders renamed to your folder naming scheme you set earlier [movie naming section](#movie-naming "wikilink").
2. Select the movie(s) from where you want to have the folder(s) to be renamed.
3. Choose the same `Root Folder`

A new popup will be shown

![Radarr-movie-editor-move-files-yes.png](/assets/radarr/Radarr-movie-editor-move-files-yes.png)

Select `Yes, Move the files`

Then Magic

![Radarr-correct-folder-name.png](/assets/radarr/Radarr-correct-folder-name.png)

As you can see the folder has been renamed to the correct year following your naming scheme.

### How to add a movie

After you imported your existing well organized media library it’s time to add the movies you want.

`Movies` =\> `Add New`

![Radarr-add-new.png](/assets/radarr/Radarr-add-new.png)

Type in the box the movie you want or use the tmdb:id or imdb:id.

When typing out the movie name you will see it will start showing you results.

![Radarr-movie-search.png](/assets/radarr/Radarr-movie-search.png)

When you see the movie you want click on it.

![Radarr-movie-add.png](/assets/radarr/Radarr-movie-add.png)

1. Radarr will add the Root Folder you’ve setup [in the root folders section](#root-folders "wikilink")
2. How you want the movie to be added to Radarr.
    >
    > - Yes = Radarr will monitor the RSS feed for the movie in your library that you do not have (yet) or upgrade the existing movie to a better quality.
    > - No = Radarr will not monitor the RSS feed, any upgrades or new movies will be ignored and have to be manually done.
    >
3. When Radarr shall consider a movie is available..
    >
    > - **Announced**: Radarr shall consider movies available as soon as they are added to Radarr. This setting is *recommended* if you have good private trackers (or really good public ones, e.g. rarbg.to) that do not have fakes.
    > - **InCinemas**: Radarr shall consider movies available as soon as movies they hit cinemas. This option is *not recommended*.
    > - **Physical / Web**: Radarr shall consider movies available as soon as the Blu-ray is released. This option is *recommended* if your indexers contain fakes often.
    >
4. Select your preferred profile to use.
5. Here you can add certain tags for advanced uasage.
6. Make sure you enable this if you want Radarr search for the missing movie when added to Radarr [more info](https://wiki.servarr.com/Radarr_FAQ#How_does_Radarr_find_movies.3F)
7. Click on `Add Movie` to add the movie to Radarr.
