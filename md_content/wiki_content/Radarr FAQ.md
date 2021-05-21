## How does Radarr work?

<span id="how_does_radarr_work"><small>[anchor](#how_does_radarr_work "wikilink")</small></span>  
<span id="How_does_Radarr_work"><small>[alt-anchor](#How_does_Radarr_work "wikilink")</small></span>  
\* Radarr relies on RSS feeds to automate grabbing of releases as they
are posted, for both new releases as well as previously released
releases being released or re-released. The RSS feed is the latest
releases from a site, typically between 50 and 100 releases, though some
sites provide more and some less. The RSS feed is comprised of all
releases recently available, including releases for requested media you
do not follow, if you look at debug logs you will see these releases
being processed, which is completely normal.

  - Radarr enforces a minimum of 10 minutes on the RSS Sync interval and
    a maximum of 2 hours. 15 minutes is the minimum recommended by most
    indexers, though some do allow lower intervals and 2 hours ensures
    Radarr is checking frequently enough to not miss a release (even
    though it can page through the RSS feed on many indexers to help
    with that). Some indexers allow clients to perform an RSS sync more
    frequently than 10 minutes, in those scenarios we recommend using
    Radarr's Release-Push API endpoint along with an IRC announce
    channel to push releases to Radarr for processing which can happen
    in near real time and with less overhead on the indexer and Radarr
    as Radarr doesn’t need to request the RSS feed too frequently and
    process the same releases over and over.

## How does Radarr find movies?

<span id="how_does_radarr_find_movies"><small>[anchor](#how_does_radarr_find_movies "wikilink")</small></span>  
\* Radarr does *not* regularly search for movie files that are missing
or have not met their quality goals. Instead, it fairly frequently
queries your indexers and trackers for *all* the newly posted movies,
then compares that with its list of movies that are missing or need to
be upgraded. Any matches are downloaded. This lets Radarr cover a
library of *any size* with just 24-100 queries per day (RSS interval of
15-60 minutes). If you understand this, you'll realize that it only
covers the *future* though.

  - So how do you deal with the present and past? When you're adding a
    movie, you'll need to set the correct path, profile and monitoring
    status then use the Start search for missing movie checkbox. If the
    movie hasn't been released yet, you don't need to initiate a search.
  - Put another way, Radarr will only find movies that are newly
    uploaded to your indexers. It will not actively try to find movies
    you want that were uploaded in the past.
  - If you've already added the movie, but now you want to search for
    it, you have a few choices. You can go to the movie's page and use
    the search button, which will do a search and then automatically
    pick one. You can use the Search tab and see *all* the results, hand
    picking the one you want. Or you can use the filters of `Missing`,
    `Wanted`, or `Cut-off Unmet`.
  - If Radarr has been offline for an extended period of time, Radarr
    will attempt to page back to find the last release it processed in
    an attempt to avoid missing a release. As long as your indexer
    supports paging and it hasn't been too long Radarr will be able to
    process the releases it would have missed and avoid you needing to
    perform a search for the missed movies.

## How are possible downloads compared?

<span id="how_are_possible_downloads_compared"><small>[anchor](#how_are_possible_downloads_compared "wikilink")</small></span>  
**Generally Quality Trumps All**

The current logic [can be found
here](https://github.com/Radarr/Radarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).
***As of 1/19/2021 the logic is as follows***

1.  Quality
2.  Custom Format Score
3.  Protocol
4.  Indexer Priority
5.  Indexer Flags
6.  Peers (If Torrent)
7.  Age (If Usenet)
8.  Size

## What are Lists and what can they do for me?

<span id="what_are_lists_and_what_can_they_do_for_me"><small>[anchor](#what_are_lists_and_what_can_they_do_for_me "wikilink")</small></span>  
\* Lists are a part of Radarr that allow you to follow a given list
creator.

  - Let's say that you follow a given list creator on Trakt/TMDb and
    really like their Marvel Cinematic Universe film section and want to
    watch every movie on their list. You look in your Radarr and realize
    that you don't have those movies. Well instead of searching one by
    one and adding those lists and then searching your indexers for
    those movies. You can do this all at once with a List. The Lists can
    be set to import all the movies on that curators list as well as be
    set to automatically assign a quality profile, automatically add,
    and automatically monitor that movie.
  - **CAUTION:** If lists are done improperly they will absolutely wreck
    your library with a bunch of trash you have no intention of
    watching. So make sure of what you're importing before you click
    save.
  - ie. physically look at the list before you even go to Radarr.

## With the release of Radarr V3, what release should I download?

<span id="with_the_release_of_radarr_v3_what_release_should_i_download"><small>[anchor](#with_the_release_of_radarr_v3_what_release_should_i_download "wikilink")</small></span>  
Please see better information
[here](Radarr_FAQ#How_do_I_update_Radarr? "wikilink")

## Why did the GUI / UI Change? Can it be changed back?

<span id="why_did_the_gui_ui_change"><small>[anchor](#why_did_the_gui_ui_change "wikilink")</small></span>  
\* Radarr is a fork of [Sonarr](Sonarr "wikilink") which has the new UI.

  - No it cannot be changed back. No it will not be changed back.
  - You may, however, check out [Theme
    Park](https://github.com/gilbN/theme.park)

<span id="Where_did_Wanted_and_Cut_off_Unmet_go"></span>

## Where did Wanted and Cut-off Unmet go?

<span id="where_did_wanted_and_cutoff_unmet_go"><small>[anchor](#where_did_wanted_and_cutoff_unmet_go "wikilink")</small></span>  
\* Movie Index (AKA 'Movies') -\> Filter (top right corner) -\> `Wanted`
and `Cut-off Unmet` ![This is where wanted and Cut-off Unmet
went](radarr-where-did-wanted-and-cutoff-unmet-go.png
"This is where wanted and Cut-off Unmet went")

## Why can't I add a new movie to Radarr?

<span id="why_cant_i_add_a_new_movie_to_radarr"><small>[anchor](#why_cant_i_add_a_new_movie_to_radarr "wikilink")</small></span>  
\* Radarr uses [The Movie Database (TMDb)](http://themoviedb.org) for
movie information and images like fanart, banners and backgrounds.
Generally, there are a few reasons why you may not be able to add a
movie:

  - TMDb doesn't like special characters to be used when searching for
    movies through the API (which Radarr uses), so try searching a
    translated name, and/or without special characters.
  - You can also add by TMDb ID or, if TMDb has it, the IMDb ID
  - The movie hasn't been added to TMDb yet, follow their
    [guide](https://www.themoviedb.org/bible/new_content#59f7933c9251413e93000006)
    to get it added.

## Can all my movie files be stored in one folder?

<span id="can_all_my_movie_files_be_stored_in_one_folder"><small>[anchor](#can_all_my_movie_files_be_stored_in_one_folder "wikilink")</small></span>  
\* Not yet and the reason is that Radarr is a fork of
[Sonarr](Sonarr "wikilink"), where every show has a folder. This
limitation is a known pain point for many users and will maybe come in a
future version.

  -   
    If you're looking to moving all your movies from one folder to
    individual folders check
    [here](Radarr_Tips_and_Tricks#Create_a_Folder_for_Each_Movie "wikilink")

## Can I put all my movies in my library into one folder

<span id="can_I_disable_the_refresh_movies_task"><small>[anchor](Radarr_FAQ#Can_I_put_all_my_movies_in_my_library_into_one_folder "wikilink")</small></span>

We get asked this a lot. There are no plans to support
`\data\Movies\Movie1.mkv`, `\data\Movies\Movie2.mkv`, etc.

The [Custom Folder GitHub
Issue](https://github.com/Radarr/Radarr/issues/153) technically covers
this request, but it is no guarantee that all movie files in one folder
will be implemented at that time.

A slight hack-ish solution is noted below. Please note that you mustn't
trigger a rescan or it will show as missing and regardless the movie
will never be upgraded.

  - Use a Custom Script
      - the script should be triggered on import
      - it should be designed to move the file whenever you want it
      - it then needs to call the Radarr API and change the movie to
        unmonitored.

## How can I rename my movie folders?

<span id="how_can_i_rename_my_movie_folders"><small>[anchor](#how_can_i_rename_my_movie_folders "wikilink")</small></span>  
\# Movies

1.  Movie Editor
2.  Select what movies need their folder renamed
3.  Change Root Folder to the same Root Folder that the movies currently
    exist in
4.  Select "Yes move files"

## Movie File and Folder Naming

<span id="movie_file_and_folder_naming"><small>[anchor](#movie_file_and_folder_naming "wikilink")</small></span>  
\* Currently, Radarr requires that each movie be in a folder with the
format containing at minimum `Movie Title (Year)/`, optionally `_` or
`.` are valid separators. To facilitate correct quality and resolution
identification during import, a file name like `Movie Title (Year)
[Quality-Resolution].ext` is best, again `_` or `.` are valid separators
too.

  - A useful tool for making these changes to your collection is
    [filebot](http://www.filebot.net/#download) which has paid version
    in both the Apple and Windows stores, but can be found for free on
    their legacy
    [SourceForge](https://sourceforge.net/projects/filebot/files/latest/download)
    site. It has both a GUI and CLI, so you can use whatever you’re
    comfortable with. For the above example, `{ny}` expands to `Name
    (Year)` and `{vf}` gives the resolution like `1080p`. There is
    nothing to infer quality, so you can fake it using `{ny}/{ny}
    [{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` which will name anything
    lower than 720p to `[DVD-572p]` and greater or equal to 720p like
    `[Bluray-1080p]`.

See [Create a Folder for Each
Movie](Radarr_Tips_and_Tricks#Create_a_Folder_for_Each_Movie "wikilink")
for more details.

## Movie Folders Named Incorrectly

<span id="movie_folders_named_incorrectly"><small>[anchor](#movie_folders_named_incorrectly "wikilink")</small></span>  
\* Even if your movies are in folders already, the folders may not be
named correctly. The folder name should be `Movie Title (Year)`, having
the title and year in the folder’s name is critical right now.

  - Examples that will work well:
      - `/mnt/Movies/A Clockwork Orange (1971)/A Clockwork Orange (1971)
        [Bluray-1080p].mkv`
      - `/mnt/Kid Movies/Frozen (2013)/Frozen (2013) [Bluray-1080p].mkv`
  - Examples that will work, but will require manual management:
      - By letters: `/mnt/Movies/A-D/A Clockwork Orange (1971)/A
        Clockwork Orange (1971) [Bluray-1080p].mkv`
      - By rating: `/mnt/Movies/R/A Clockwork Orange (1971)/A Clockwork
        Orange (1971) [Bluray-1080p].mkv`
      - By genre: `/mnt/Movies/Crime, Drama, Sci-Fi/A Clockwork Orange
        (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
      - These examples will require manual management when the movie is
        added. Each of the examples will have many root directories,
        like `A-D` and `E-G` in the first letter example, `R` and
        `PG-13` in the rating example and you can guess at the variety
        of genre folders. When adding a new movie, the correct base
        folder will need to be selected for this format to work.
  - Examples that won’t work:
      - Single folder: `/mnt/Kid Movies/Frozen (2013)
        [Bluray-1080p].mkv`
          - At this time, movies simply have to be in a folder named
            after the movie. There is no way around this until
            development work is done to add this feature.
      - **Movie** Folder Naming Formats from v0.2 that include **File**
        properties in the **movie folder** name such as
        ``{Movie.Title}.{Release
        Year}.{Quality.Full}-{MediaInfo.Simple}{`Release.Group}`` will
        not work in v3.
          - Folders are related to the movie and independent of the
            file. Additionally, this will break with the planned
            multiple files per movie support.
          - The other reason it was removed was it caused frequent
            confusion, database corruption, and generally was only half
            baked.
  - The [Create a Folder for Each
    Movie](Radarr_Tips_and_Tricks#Create_a_Folder_for_Each_Movie "wikilink")
    is a great source for making sure your file and folder structure
    will work great.

## How can I mass delete movies from the wanted list?

<span id="how_can_i_mass_delete_movies_from_the_wanted_list"><small>[anchor](#how_can_i_mass_delete_movies_from_the_wanted_list "wikilink")</small></span>  
\* Use Movie Editor -\> Select movies you want to delete -\> Delete

## Why doesn't Radarr work behind a reverse proxy

<span id="why_doesnt_radarr_work_behind_an_nginx_reverse_proxy"><small>[anchor](#why_doesnt_radarr_work_behind_an_nginx_reverse_proxy "wikilink")</small></span>  
\* Starting with V3 Radarr has switched to .NET Core and a new
webserver. In order for SignalR to work, the UI buttons to work,
database changes to take, and other items. It requires the following
addition to the location block for Radarr:

`proxy_http_version 1.1;`  
`proxy_set_header Upgrade $http_upgrade;`  
`proxy_set_header Connection $http_connection;`

  - Make sure you **do not** include `proxy_set_header Connection
    "Upgrade";` as suggested by the nginx documentation. **THIS WILL NOT
    WORK**
  - [See this ASP.NET Core
    issue](https://github.com/aspnet/AspNetCore/issues/17081)
  - If you are using a CDN like Cloudflare ensure websockets are enabled
    to allow websocket connections.

## How do I update Radarr?

<span id="how_do_i_update_my_radarr"><small>[anchor](#how_do_i_update_my_radarr "wikilink")</small></span>  
\# Go to Settings and then the General tab and show advanced settings
(use the toggle by the save button).

1.  Under the Development section change the branch name to `master` or
    `develop`
2.  Save

*This will not install the bits from that branch immediately, it will
happen during the next update.*

  - <span style="color:#00ff00">master</span> (Default/Stable): It has
    been tested by users on the develop and nightly branches and it’s
    not known to have any major issues. This is currently v3. This
    version will receive updates approximately monthly. On GitHub, this
    is the `master` branch.
  - <span style="color:#00ff00">develop</span> (Beta): This is the
    testing edge. Released after tested in nightly to ensure no
    immediate issues. New features and bug fixes released here first.
    This is currently v3. This version will receive updates either
    weekly or biweekly depending on development. **Warning: You may not
    be able to go back to `master` after switching to this branch.** On
    GitHub, this is a snapshot of the `develop` branch at a point in
    time.
  - <span style="color:#00ff00">nightly</span> (Nightly): The bleeding
    edge. Released as soon as code is committed and passed all automated
    tests. ***Use this branch only if you know what you are doing and
    are willing to get your hands dirty to recover a failed update.***
    This is currently v3. This version is updated immediately.
    **Warning: You may not be able to go back to `master` after
    switching to this branch.** On GitHub, this is the `develop` branch.

<!-- end list -->

  - Note: If your install is through Docker append `:release`,
    `:latest`, or `:testing` to the end of your container tag depending
    on who makes your builds.

| Current Versions | master                                                                                                                                                                                                           | develop                                                                                                                                                                                                         | nightly                                                                                                                                                                                                          |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|                  | [Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhotio%2Fradarr%2Frelease%2FVERSION.json) | [Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhotio%2Fradarr%2Ftesting%2FVERSION.json) | [Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhotio%2Fradarr%2Fnightly%2FVERSION.json) |

<center>

| Release Channel Type                                          | Branch: master (stable) (v3.1) | Branch: develop (beta) (v3.1) | Branch: nightly (unstable) (v3.2)            |
| ------------------------------------------------------------- | ------------------------------ | ----------------------------- | -------------------------------------------- |
| [hotio](https://hub.docker.com/r/hotio/radarr)                | `hotio/radarr:release`         | `hotio/radarr:testing`        | If you have to ask, you should not be on it. |
| [LinuxServer.io](https://hub.docker.com/r/linuxserver/radarr) | `linuxserver/radarr:latest`    | `linuxserver/radarr:develop`  | If you have to ask, you should not be on it. |

</center>

### Installing a newer version

If Native:

1.  Go to System and then the Updates tab
2.  Newer versions that are not yet installed will have an update button
    next to them, clicking that button will install the update.

If Docker:

1.  Repull your tag and update your container

## Can I switch from nightly back to develop?

<span id="can_i_switch_from_nightly_back_to_develop"><small>[anchor](#can_i_switch_from_nightly_back_to_develop "wikilink")</small></span>  
[See this related
question](Radarr_FAQ#Can_I_switch_between_branches? "wikilink")

## Can I switch between branches?

<span id="can_i_switch_between_branches"><small>[anchor](#can_i_switch_between_branches "wikilink")</small></span>  
\* You can (almost) always increase your risk.

  - `master` can go to `develop` or `nightly`
  - `develop` can go to `nightly`
  - Check with the development team to see if you can switch from
    `nightly` to `master`; `nightly` to `develop`; or `develop` to
    `master` for your given build.
  - Failure to follow these instructions may result in your Radarr
    becoming unusable or throwing errors. You have been warned.
      - The most common error is something like `Error parsing column 45
        (Language=31 - Int64)` or other similar database errors around
        missing columns or tables.

<!-- end list -->

  - **May 4 2021 Update**
      - `3.1.1` has been released as master/stable
      - For those on nightly and are still on `3.1.1.4948` or lower you
        can safely downgrade to master
          - Same for develop.
      - For those who are on nightly and are updated to `3.1.1.4957`,
        `3.2.0.4960`, or newer; you cannot downgrade as there was a DB
        migration in `3.1.1.4957` and you'd need to rollback your
        database to the backup prior to that update in order to jump to
        master

## How does radarr handle foreign movies or foreign titles?

<span id="how_does_radarr_handle_foreign_movies_or_foreign_titles"><small>[anchor](#how_does_radarr_handle_foreign_movies_or_foreign_titles "wikilink")</small></span>  
\* Radarr uses both Alt Titles and Translations for parsing and
searching. Search will use the Original Title, English Title, and
Translated Title from whatever languages you have preferred (in profile
and CFs). Parsing should look for a match in all Translations and Alt
Titles.

  - To get a movie in a foreign language set your Profile Language to
    Original (Movie's Original Language), a specific language for that
    profile, or any and use custom formats to determine which language
    to grab.
  - Note that this does not include any indexer languages specified as
    multi.

## How does radarr handle "multi" in names?

<span id="how_does_radarr_handle_multi_in_names"><small>[anchor](#how_does_radarr_handle_multi_in_names "wikilink")</small></span>  
\* Radarr by default assumes multi is english and french unless
specified in your indexer's advanced settings in Radarr.

  - Note that multi definitions only help for release parsing and not
    for foreign titles or movies searches.

## Help, Movie Added, But Not Searched

<span id="help_movie_added_but_not_searched"><small>[anchor](#help_movie_added_but_not_searched "wikilink")</small></span>  

  - Neither Radarr nor Sonarr *actively* search for missing movies
    automatically. Instead, a periodic query of new posts is made to all
    indexers configured for RSS. When a wanted or cutoff unmet movie
    shows up in that list, it gets downloaded. This means that until a
    movie is posted (or reposted), it won’t get downloaded.
  - If you’re adding a movie that you want now, the best option is to
    check the “Start search for missing movie” box, to the left of the
    *Add Movie* (**1**) button. You can also go to the page for a movie
    you’ve added and click the magnifying glass “Search” (**2**) button
    or use the Wanted view to search for Missing or Cutoff Unmet movies.

![Add and Search for movie](start_search_for_missing_movie.png
"Add and Search for movie") ![|thumb|none|750px|altt=Search selected
movie|Search selected movie](Search_selected_movie.png
"|thumb|none|750px|altt=Search selected movie|Search selected movie")

## Root path for movies imported from lists becomes “C:” or other weird paths

<span id="root_path_for_movies_imported_from_lists_become_c_or_other_weird_paths"><small>[anchor](#root_path_for_movies_imported_from_lists_become_c_or_other_weird_paths "wikilink")</small></span>  
\* Sometimes you can get a problem that movies that are imported from
your lists, gets imported with the root path set to “C:” or other weird
paths.

  - This is a known issue for when the root path is either not setup
    during the creation of the list, or if the root path has been
    deleted after the list was created. Note that this problem can still
    occur even if the list is **edited** and the correct root path is
    set.

<!-- end list -->

  - Use the Movie Editor to fix paths of existing movies.

## Movie Imported, But Source File And Torrent Not Deleted

<span id="movie_imported_but_source_file_and_torrent_not_deleted"><small>[anchor](#movie_imported_but_source_file_and_torrent_not_deleted "wikilink")</small></span>  
\* Check if you have Completed Download Handling - Remove turned on.
(This does not work if you are using rtorrent.)

![Settings \> Download Clients](Remove_turned_on.png
"Settings \> Download Clients")

  - If you are using deluge make sure auto-managed is turned on. And
    that torrents get paused when they reach specified seeding quota.

## My Custom Script stopped working after upgrading from v0.2

<span id="my_custom_script_stopped_working_after_upgrading_from_v0.2"><small>[anchor](#my_custom_script_stopped_working_after_upgrading_from_v0.2 "wikilink")</small></span>  
You were likely passing arguments in your connection...that is not
supported.

1.  Change your argument to be your path
2.  Make sure the shebang in your script maps to your pwsh path (if you
    don't have a shebang definition in there, add it)
3.  Make sure the pwsh script is executable

## I am using a Pi and Raspbian and Radarr will not launch

<span id="i_am_using_a_pi_and_raspbian_and_radarr_will_not_launch"><small>[anchor](#i_am_using_a_pi_and_raspbian_and_radarr_will_not_launch "wikilink")</small></span>  
Raspbian has a version of libseccomp2 that is too old to support running
a docker container based on Ubuntu 20.04, which both hotio and
LinuxServer use as their base for v3. You either need to use
`--privileged`, update libseccomp2 from Ubuntu or get a better OS (We
recommend Ubuntu 20.04 arm64)

**Possible Solution:**

Managed to fix the issue by installing the backport from debian repo.
Generally not recommended to use backport in blanket upgrade mode.
Installation of a single package may be ok but may also cause issues. So
got to understand what you are doing.

Steps to fix:

First ensure you are running Raspbian buster e.g using `lsb_release -a`

Distributor ID: Raspbian

Description: Raspbian GNU/Linux 10 (buster)

Release: 10

Codename: buster

*If you are using buster:*

<code>`` Add the line `deb http://deb.debian.org/debian buster-backports` main to `/etc/apt/sources.list` ``  
`Run apt-get update`  
`apt-get -t buster-backports install libseccomp2`</code>

## Why are lists sync times so long and can I change it?

<span id="why_are_lists_sync_times_so_long_and_can_i_change_it"><small>[anchor](#why_are_lists_sync_times_so_long_and_can_i_change_it "wikilink")</small></span>

Lists never were nor are intended to be `add it now` they are `hey i
want this, add it eventually` tools

You can trigger a list refresh manually, script it and trigger it via
the API, add the movies to radarr, use Ombi, or any similar app that
adds them right away

This change was due to not have our server get killed by people updating
lists every 10 minutes.

## Why doesn't Radarr work behind an nginx reverse proxy

[See this
section](Radarr_FAQ#Why_doesn.27t_Radarr_work_behind_a_reverse_proxy "wikilink")

## Can I disable the refresh movies task

<span id="can_I_disable_the_refresh_movies_task"><small>[anchor](#can_I_disable_the_refresh_movies_task "wikilink")</small></span>

No, nor should you through any SQL hackery. The refresh movies task
queries the upstream Servarr proxy and checks to see if the metadata for
each movie (ids, cast, summary, rating, translations, alt titles, etc.)
has updated compared to what is currently in Radarr. If necessary, it
will then update the applicable movies.

A common complaint is the Refresh task causes heavy I/O usage. This is
partly due to the setting "Analyze video files" which is advised to be
enabled if you use tdarr or otherwise externally modify your files. If
you don't you can safely disable "Analyze video files" to reduce some
I/O. The other setting is "Rescan Movie Folder after Refresh". If your
disk I/O usage spikes during a Refresh then you may want to change the
Rescan setting to `Manual`. Do not change this to `Never` unless all
changes to your library (new movies, upgrades, deletions etc) are done
through Radarr. If you delete movie files manually or via Plex or
another third party program, do not set this to `Never`.
