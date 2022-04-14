---
title: Radarr Library
description: 
published: true
date: 2022-03-17T12:55:49.087Z
tags: radarr
editor: markdown
dateCreated: 2021-05-25T01:24:18.386Z
---

# Movies

## Library View

- Update All - Update metadata for all movies, refresh posters, rescan movie folders, and rescan movie files (if enabled)
- Refresh & Scan - Refresh the currently viewed movie's metadata and rescan its folder
- RSS Sync - Refresh the RSS feed from your Indexers and see if anything new has been posted to be grabbed
- Search All / Search Filtered / Search Selected - Search all movies or selected movies in the current view
- Manual Import (Movie Index) - Manually import a movie file for a movie you have added to Radarr from any folder that Radarr can access
  - Move Automatically -  Automatically attempt to match a file to a Movie in Radarr and import by moving it.
  - Interactive Import -  Review all files within the path and attempt to match to a Movie in Radarr allowing the user to review the results. Move or Copy/Hardlink is a selectable option in the bottom left corner.
- Manual Import (Movie) - Manually import a movie file for a movie you have added to Radarr from the assigned movie's folder
  - Move Automatically -  Automatically attempt to match a file to a Movie in Radarr and import by moving it.
  - Interactive Import -  Review all files within the path and attempt to match to a Movie in Radarr allowing the user to review the results. Move or Copy/Hardlink is a selectable option in the bottom left corner.
- Movie Editor / Movie Index - Toggle between Mass Editor mode and Movie Index (Library) mode
- Options - Change display options
- View - Toggle View Type
  - Table - Tabular View (list view)
  - Posters - Display Posters (similar to Plex)
  - Overview - Display overview information and the poster (detailed view)
- Sort - Sort the current view

### Filters

- Filter - Filter the current view
  - Monitored Only - Titles being monitored for updates.
  - Unmonitored - Titles NOT being monitored for updates.
  - Missing - In the database, but missing from the filesystem.
  - Wanted - In the database, monitored, missing, but should be available.
  - Cut-off Unmet - Title on filesystem, but still monitoring for wanted quality.
  - Custom Filters
    - Monitored (boolean)
    - Considered Available (boolean)
    - Minimum Availability (Enum)
      - Announced
      - In Cinemas
      - Released
    - Title \[contains\] (String)
    - Release Status (Enum)
      - TBA
      - Announced
      - In Cinemas
      - Released
      - Deleted
    - Studio (Enum Studios)
    - Collection (Enum Collections)
    - Quality Profile (Enum QualityProfiles)
    - Added (static DateTime, relative TimeDelta)
    - Year (Int)
    - In Cinemas (static DateTime, relative TimeDelta)
    - Physical Release (static DateTime, relative TimeDelta)
    - Digital Release (static DateTime, relative TimeDelta)
    - Runtime (Int)
    - Path \[contains\] (String)
    - Size on Disk (Int)
    - Genres \[contains\] (Enum Genres)
    - TMDB Rating (Float)
    - TMDB Votes (Int)
    - Certification (Enum Rating (PG-13, R, etc))
    - Tags \[contain\] (Enum Tags)

# Add New

![radarr-add-new-empty.png](/assets/radarr/radarr-add-new-empty.png)

- If you're looking to add a new movie, this is the page that you will be wanting to do that from.
  - You'll find the how-to in our [Quick Start Guide](/radarr/quick-start-guide).
- Below the search field, you can also find the Import Existing Movies button. If that is the case for you, you can find great information on that also in our [Quick Start Guide](/radarr/quick-start-guide).
- If you get an error of "path is already configured", [see this FAQ entry](/radarr/faq#path-is-already-configured-for-an-existing-movie).

# Library Import

Library Import allows you to import existing organized movies and each movie's file via existing files in the path directory. This is especially useful when making a new Radarr instance and wanting to keep your existing movies.

- Library import is for adding and importing an existing organized library of movies into Radarr.
- Library Import cannot be used for:
  - Importing files from a download folder
  - Adding or Importing one or more files that are not properly named and organized in their own Movie Folder within your root folder or a folder you wish to add as a root folder
  - Any other uses that are not adding a movie to Radarr and importing the movie and its file from the root (library) folder that was input to Library Import
- If you get an error of "path is already configured", [see this FAQ entry](/radarr/faq#path-is-already-configured-for-an-existing-movie).
  
> It is required that movie folders and files have the year in their name to be imported and parsed.{.is-warning}

> \* Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.
> \* If you're using an SMB mount ensure `nobrl` is enabled.
{.is-warning}

> **The user and group you configured Radarr to run as must have read & write access to this location.** {.is-info}

> Your download client downloads to a download folder and Radarr imports it to your media folder (final destination) that your media server uses.
{.is-info}

> **Your download folder and media folder can’t be the same location**
{.is-danger}

# Discover

Discover shows recommended Movies

- If you do not have list(s), it will show the top 90 most recommended movies based on the TMDb movies recommended for the movies in your library in addition to the 10 recommendations from your most recent additions.

> Tip: You can disable Radarr recommended movies and view only movies from your lists in `Options`.{.is-info}

- If you have list(s), it will show the recommendations noted above AND entries from your list(s).

> Tip: Change the `Filter` to `New Non-Excluded` to only show movies that are not in your library.{.is-info}

![radarr-discover-empty.png](/assets/radarr/radarr-discover-empty.png)

- Chances are that your Discover recommendations will be sparse if you have a new installation with few or no movies. You will need to add library content to fuel recommendation direction. You have several options:
  1. Click on the [Add New Movie](/radarr/library#add-new) button to add movies by hand.
  1. Click on the [Import Existing Library](/radarr/library#library-import) button to import an existing library.
  1. Click on the [Add Lists](/radarr/settings#lists) button to add a list to Radarr. Additional information about lists can be found at the following page [supported](/radarr/faq#what-are-lists-and-what-can-they-do-for-me).

![radarr-discover-add-new-movies.png](/assets/radarr/radarr-discover-add-new-movies.png)

- Once you've added a movie by one of the three options listed above, you will be presented with different movies to discover.
    1. Here you can select what movies you want to add to your library
    1. Here you can select all the movies that are on this list if you're feeling extra crazy
    1. Select what root path you'd like for these movies to go to once they are imported
    1. Select what availability you'd like the movie to have before it is grabbed
    1. Select any quality profiles you have already built ([More info](/radarr/settings#quality-profiles))
    1. Do you want Radarr to monitor this movie for any upgrades in quality?
    1. Would you like Radarr to automatically search for this movie after you add it?
    1. Do you want Radarr to exclude these movies from any lists that would be imported? ([More info](/radarr/settings#list-exclusion))
    1. Finally, Add the movie to your library.
