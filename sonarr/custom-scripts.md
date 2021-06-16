---
title: Sonarr Custom Scripts
description: 
published: true
date: 2021-06-16T01:07:19.984Z
tags: sonarr
editor: markdown
dateCreated: 2021-06-16T01:28:37.350Z
---

## Custom Post Processing Scripts {#custom_post_processing_scripts}

If you're looking to trigger a custom script in your download client to
tell Sonarr when to update, you can find more details here. Scripts are
added to Sonarr via the [Connect
Settings](/sonarr/settings#connections)

### Overview

Sonarr can execute a custom script when an episode is newly imported or
renamed and depending on the action, different parameters are supplied.
They are passed to the script through environment variables which allows
for more flexibility in what is sent to the script and in no particular
order.

### Environment Variables {#environment_variables}

##### On Grab {#on_grab}

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| sonarr_eventtype                  | Grab                              |
+-----------------------------------+-----------------------------------+
| sonarr_series_id                  | Internal ID of the series         |
+-----------------------------------+-----------------------------------+
| sonarr_series_title               | Title of the series               |
+-----------------------------------+-----------------------------------+
| sonarr_series_tvdbid              | TVDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr_series_tvmazeid            | TVMaze ID for the series          |
+-----------------------------------+-----------------------------------+
| sonarr_series_imdbid              | IMDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr_series_type                | Type of the series, Anime, Daily  |
|                                   | or Standard                       |
+-----------------------------------+-----------------------------------+
| sonarr_release_episodecount       | Number of episodes in the release |
+-----------------------------------+-----------------------------------+
| sonarr_release_seasonnumber       | Season number from release        |
+-----------------------------------+-----------------------------------+
| sonarr_release_episodenumbers     | , separated list of episode       |
|                                   | numbers                           |
+-----------------------------------+-----------------------------------+
| sona                              | , separated list of absolute      |
| rr_release_absoluteepisodenumbers | episode numbers                   |
+-----------------------------------+-----------------------------------+
| sonarr_release_episodeairdates    | , separated list of Air date from |
|                                   | original network                  |
+-----------------------------------+-----------------------------------+
| sonarr_release_episodeairdatesutc | , separated list of Air Date with |
|                                   | Time in UTC                       |
+-----------------------------------+-----------------------------------+
| sonarr_release_episodetitles      | \| separated list of episode      |
|                                   | titles                            |
+-----------------------------------+-----------------------------------+
| sonarr_release_title              | NZB/Torrent title                 |
+-----------------------------------+-----------------------------------+
| sonarr_release_indexer            | Indexer where the release was     |
|                                   | grabbed                           |
+-----------------------------------+-----------------------------------+
| sonarr_release_size               | Size of the release reported by   |
|                                   | the indexer                       |
+-----------------------------------+-----------------------------------+
| sonarr_release_quality            | Quality name of the release as    |
|                                   | detected by Sonarr                |
+-----------------------------------+-----------------------------------+
| sonarr_release_qualityversion     | 1 is the default, 2 for proper,   |
|                                   | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| sonarr_release_releasegroup       | Release Group, will be empty if   |
|                                   | it is unknown                     |
+-----------------------------------+-----------------------------------+
| sonarr_download_client            | download client, will be empty if |
|                                   | it is unknown                     |
+-----------------------------------+-----------------------------------+
| sonarr_download_id                | The hash of the torrent/NZB file  |
|                                   | downloaded (used to uniquely      |
|                                   | identify the download in the      |
|                                   | download client)                  |
+-----------------------------------+-----------------------------------+

#### On Download/On Upgrade {#on_downloadon_upgrade}

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| sonarr_eventtype                  | Download                          |
+-----------------------------------+-----------------------------------+
| sonarr_isupgrade                  | `True` when an an existing file   |
|                                   | is upgraded, otherwise `False`    |
+-----------------------------------+-----------------------------------+
| sonarr_series_id                  | Internal ID of the series         |
+-----------------------------------+-----------------------------------+
| sonarr_series_title               | Title of the series               |
+-----------------------------------+-----------------------------------+
| sonarr_series_path                | Full path to the series           |
+-----------------------------------+-----------------------------------+
| sonarr_series_tvdbid              | TVDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr_series_tvmazeid            | TVMaze ID for the series          |
+-----------------------------------+-----------------------------------+
| sonarr_series_imdbid              | IMDB ID for the series, empty if  |
|                                   | not available                     |
+-----------------------------------+-----------------------------------+
| sonarr_series_type                | Type of the series, Anime, Daily  |
|                                   | or Standard                       |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_id             | Internal ID of the episode file   |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodecount   | Number of episodes in the file    |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_relativepath   | Path to the episode file relative |
|                                   | to the series' path               |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_path           | Full path to the episode file     |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodeIDs     | Internal ID(s) of the episode     |
|                                   | file                              |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_seasonnumber   | Season number of episode file     |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodenumbers | , separated list of episode       |
|                                   | numbers                           |
+-----------------------------------+-----------------------------------+
| s                                 | , seperated list of Air dates     |
| onarr_episodefile_episodeairdates | from original network             |
+-----------------------------------+-----------------------------------+
| sona                              | , seperated list of Air Date with |
| rr_episodefile_episodeairdatesutc | Time in UTC                       |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodetitles  | \| separated list of episode      |
|                                   | titles                            |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_quality        | Quality name of the Episode from  |
|                                   | Sonarr                            |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_qualityversion | 1 is the default, 2 for proper,   |
|                                   | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_releasegroup   | Release group, will be empty if   |
|                                   | unknown                           |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_scenename      | Original release name, will be    |
|                                   | empty if unknown                  |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_sourcepath     | Full path to the episode file     |
|                                   | that was imported from            |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_sourcefolder   | Full path to the folder the       |
|                                   | episode file was imported from    |
+-----------------------------------+-----------------------------------+
| sonarr_download_client            | download client, will be empty if |
|                                   | it is unknown                     |
+-----------------------------------+-----------------------------------+
| sonarr_download_id                | The hash of the torrent/NZB file  |
|                                   | downloaded (used to uniquely      |
|                                   | identify the download in the      |
|                                   | download client)                  |
+-----------------------------------+-----------------------------------+
| sonarr_deletedrelativepaths       | \| separated list of files that   |
|                                   | were deleted to import this file  |
+-----------------------------------+-----------------------------------+
| sonarr_deletedpaths               | \| separated list of full paths   |
|                                   | for files that were deleted to    |
|                                   | import this file                  |
+-----------------------------------+-----------------------------------+

#### On Rename {#on_rename}

  Environment Variable     Details
  ------------------------ ------------------------------------------------
  sonarr_eventtype         Rename
  sonarr_series_id         Internal ID of the series
  sonarr_series_title      Title of the series
  sonarr_series_path       Full path to the series
  sonarr_series_tvdbid     TVDB ID for the series
  sonarr_series_tvmazeid   TVMaze ID for the series
  sonarr_series_imdbid     IMDB ID for the series, empty if not available
  sonarr_series_type       Type of the series, Anime, Daily or Standard

#### On Episode File Delete {#on_episode_file_delete}

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| sonarr_eventtype                  | EpisodeDeleted                    |
+-----------------------------------+-----------------------------------+
| sonarr_series_id                  | Internal ID of the series         |
+-----------------------------------+-----------------------------------+
| sonarr_series_title               | Title of the series               |
+-----------------------------------+-----------------------------------+
| sonarr_series_path                | Full path to the series           |
+-----------------------------------+-----------------------------------+
| sonarr_series_tvdbid              | TVDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr_series_tvmazeid            | TVMaze ID for the series          |
+-----------------------------------+-----------------------------------+
| sonarr_series_imdbid              | IMDB ID for the series, empty if  |
|                                   | not available                     |
+-----------------------------------+-----------------------------------+
| sonarr_series_type                | Type of the series, Anime, Daily  |
|                                   | or Standard                       |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_id             | Internal ID of the episode file   |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodecount   | Number of episodes in the file    |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_relativepath   | Path to the episode file relative |
|                                   | to the series' path               |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_path           | Full path to the episode file     |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodeIDs     | Internal ID(s) of the episode     |
|                                   | file                              |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_seasonnumber   | Season number of episode file     |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodenumbers | , separated list of episode       |
|                                   | numbers                           |
+-----------------------------------+-----------------------------------+
| s                                 | , seperated list of Air dates     |
| onarr_episodefile_episodeairdates | from original network             |
+-----------------------------------+-----------------------------------+
| sona                              | , seperated list of Air Date with |
| rr_episodefile_episodeairdatesutc | Time in UTC                       |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_episodetitles  | \| separated list of episode      |
|                                   | titles                            |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_quality        | Quality name of the Episode from  |
|                                   | Sonarr                            |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_qualityversion | 1 is the default, 2 for proper,   |
|                                   | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_releasegroup   | Release group, will be empty if   |
|                                   | unknown                           |
+-----------------------------------+-----------------------------------+
| sonarr_episodefile_scenename      | Original release name, will be    |
|                                   | empty if unknown                  |
+-----------------------------------+-----------------------------------+

#### On Series Delete {#on_series_delete}

  Environment Variable         Details
  ---------------------------- --------------------------------------------------------------------------
  sonarr_eventtype             SeriesDeleted
  sonarr_series_id             Internal ID of the series
  sonarr_series_title          Title of the series
  sonarr_series_path           Full path to the series
  sonarr_series_tvdbid         TVDB ID for the series
  sonarr_series_imdbid         IMDB ID for the series
  sonarr_series_type           Type of the series, Anime, Daily or Standard
  sonarr_series_deletedfiles   `True` when the delete files option has been selected, otherwise `False`

#### On Health Issue {#on_health_issue}

  Environment Variable          Details
  ----------------------------- ------------------------------------------------------
  sonarr_eventype               HealthIssue
  sonarr_health_issue_level     the type of health issue: Ok, Notice, Warning, Error
  sonarr_health_issue_message   the message from the health issue
  sonarr_health_issue_type      the area that failed and triggered the health issue
  sonarr_health_issue_wiki      the wiki url, empty if does not exist

#### On Test {#on_test}

When adding the script to Sonarr and run 'Test' the script will be
invoked with the following parameters. The script should be able to
gracefully ignore any other eventtype

  Environment Variable   Details
  ---------------------- ---------
  sonarr_eventtype       Test
