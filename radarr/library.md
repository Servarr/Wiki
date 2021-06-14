---
title: Radarr Library
description: 
published: true
date: 2021-06-11T04:37:57.248Z
tags: radarr
editor: markdown
dateCreated: 2021-05-25T01:24:18.386Z
---

## Movies

- Library View
  - Update All - Update metadata for all movies, refresh posters, rescan movie folders, and rescan movie files (if enabled)
  - Refresh & Scan - Refresh the currently viewed movie's metadata and rescan it's folder
  - RSS Sync - Refresh the RSS feed from your Indexers and see if anything new has been posted to be grabbed
  - Search All / Search Filtered - Search all movies in the current view
  - Manual Import (Movie Index) - Manually import a movie file for a movie you have added to Radarr from any folder that Radarr can access.
  - Manual Import (Movie) - Manually import a movie file for a movie you have added to Radarr from the assigned movie's folder.
  - Movie Editor / Movie Index - Toggle between Mass Editor mode and Movie Index (Library) Mode
  - Options - Change display options
  - View Toggle View Type
  - Table - Tabular View
  - Posters - Display Posters (Similar to Plex)
  - Overview - Display overview information and the poster; the most detailed view
  - Sort - Sort the current view
  - Filter - Filter the current view
    - Wanted - Movie is missing, monitored, and available
    - Missing - Movie is missing and monitored

## Add New

![radarr-add-new-empty.png](/assets/radarr/radarr-add-new-empty.png)

- So you're looking to add a new movie this is the page that you'll be wanting to do that from.
  - You'll find the how to on going through that in our [Quick Start Guide](/radarr/quick-start-guide)
- Below the search field you can also find the Import Existing Movies button. If that is the case for you you can find great infomration on that also in our [Quick Start Guide](/radarr/quick-start-guide)

## Library Import

Information about importing your media Coming Soon - Contributions are Welcome.

## Discover
  
Discover shows recommended Movies.

- If you don't have (a/any) list(s) then it will show the top 90 most recommended movies based on the TMDb movies recommended for the movies in your library in addition to the 10 recommendations from your most recent additions.

>Tip: You can disable Radarr recommended movies and view only movies from your lists in `Options`
{.is-info}

- If you have (a) list(s) then it will show the recommendations noted above AND entries from your list(s)
- Tip: Change the `Filter` to `New Non-Excluded` to only show movies that are not in your library.

![radarr-discover-empty.png](/assets/radarr/radarr-discover-empty.png)

- Chances are that if you have a new installation without any movies
    added you're going to have a view very similar to this. In order to
    have Radarr suggest any new movies to you you'll need to add
    something in order to give it a direction to suggest. You have
    several options:
    1. Click on the [Add New Movie](/radarr/library#add-new) button to add movies by hand.
    1. Click on the [Import Existing Library](/radarr/library#library-import) button to import an existing library that you have collected
    1. Click on the [Add Lists](Radarr_Settings#Lists) button to add a list to Radarr
         - Some additional information about lists found [here](/radarr/faq#what_are_Lists_and_what_can_they_do_for_me?)

![radarr-discover-add-new-movies.png](/assets/radarr/radarr-discover-add-new-movies.png)

- Once You've added a movie by one of the three options listed above you'll be presented with different movies to discover.
    1. Here you can select what movies you want to add to your library
    1. Here if you're feeling extra crazy you can select all the movies that are on this list
    1. Select what root path you'd like for these movies to go to once they are imported
    1. Select what availability you'd like the movie to have before it is grabbed
    1. Select any quality profiles you have already built ([More info](/radarr/settings#quality-profiles))
    1. Do you want Radarr to monitor this movie for any upgrades in quality
    1. Would you like Radarr to go out and Automatically search for this moive after you add it?
    1. Do you want Radarr to exclude this/these movies from any lists that would be imported ([More info](/radarr/settings#list-exclusion))
    1. Finally Add the movie. This will add the entry into your library.
