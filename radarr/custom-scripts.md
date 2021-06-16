---
title: Radarr Custom Scripts
description: 
published: true
date: 2021-06-16T01:07:18.984Z
tags: radarr, custom scripts, needs-love
editor: markdown
dateCreated: 2021-06-16T01:28:36.350Z
---

## Custom Post Processing Scripts

If you're looking to trigger a custom script in your download client to
tell Radarr when to update, you can find more details below. Scripts are
added to Radarr via the [Connect Settings](/radarr/settings#connections) page.

### Overview

Radarr can execute a custom script when new movies are imported or a
movie is renamed and depending on which action occurred, the parameters
will be different. They are passed to the script through environment
variables which allows for more flexibility in what is sent to the
script and in no particular order.

### Environment Variables

#### On Grab

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| radarr_eventtype                  | Grab                              |
+-----------------------------------+-----------------------------------+
| radarr_download_client            | NZB/Torrent downloader client,    |
|                                   | empty if missing                  |
+-----------------------------------+-----------------------------------+
| radarr_download_id                | The hash of the torrent/NZB file  |
|                                   | downloaded (used to uniquely      |
|                                   | identify the download in the      |
|                                   | download client), empty if        |
|                                   | missing                           |
+-----------------------------------+-----------------------------------+
| radarr_movie_id                   | Internal ID of the movie          |
+-----------------------------------+-----------------------------------+
| radarr_movie_imdbid               | IMDb ID for the movie, empty if   |
|                                   | missing                           |
+-----------------------------------+-----------------------------------+
| radarr_movie_in_cinemas_date      | Cinema release date, empty if     |
|                                   | missing                           |
+-----------------------------------+-----------------------------------+
| r                                 | Physical release date, empty if   |
| adarr_movie_physical_release_date | missing                           |
+-----------------------------------+-----------------------------------+
| radarr_movie_title                | Title of the movie                |
+-----------------------------------+-----------------------------------+
| radarr_movie_tmdbid               | TMDb ID for the movie             |
+-----------------------------------+-----------------------------------+
| radarr_movie_year                 | Release year of the movie         |
+-----------------------------------+-----------------------------------+
| radarr_release_indexer            | Indexer where the release was     |
|                                   | grabbed, empty if missing         |
+-----------------------------------+-----------------------------------+
| radarr_release_quality            | Quality name from Radarr          |
+-----------------------------------+-----------------------------------+
| radarr_release_qualityversion     | 1 is the default, 2 for proper,   |
|                                   | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| radarr_release_releasegroup       | Release Group, empty if missing   |
+-----------------------------------+-----------------------------------+
| radarr_release_size               | Size of the release reported by   |
|                                   | the indexer                       |
+-----------------------------------+-----------------------------------+
| radarr_release_title              | NZB/Torrent title                 |
+-----------------------------------+-----------------------------------+

#### On Download/On Upgrade

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| radarr_eventtype                  | Download                          |
+-----------------------------------+-----------------------------------+
| radarr_download_id                | The hash of the torrent/NZB file  |
|                                   | downloaded (used to uniquely      |
|                                   | identify the download in the      |
|                                   | download client), empty if        |
|                                   | missing                           |
+-----------------------------------+-----------------------------------+
| radarr_download_client            | NZB/Torrent downloader client,    |
|                                   | empty if missing                  |
+-----------------------------------+-----------------------------------+
| radarr_isupgrade                  | `True` when an existing file is   |
|                                   | upgraded, otherwise `False`       |
+-----------------------------------+-----------------------------------+
| radarr_movie_id                   | Internal ID of the movie          |
+-----------------------------------+-----------------------------------+
| radarr_movie_imdbid               | IMDb ID for the movie             |
+-----------------------------------+-----------------------------------+
| radarr_movie_in_cinemas_date      | Cinema release date, empty if     |
|                                   | missing                           |
+-----------------------------------+-----------------------------------+
| radarr_movie_physical_release_date| Physical release date, empty if missing|
+-----------------------------------+-----------------------------------+
| radarr_movie_path                 | Full path to the movie            |
+-----------------------------------+-----------------------------------+
| radarr_movie_title                | Title of the movie                |
+-----------------------------------+-----------------------------------+
| radarr_movie_tmdbid               | TMDb ID for the movie             |
+-----------------------------------+-----------------------------------+
| radarr_movie_year                 | Release year of the movie         |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_id               | Internal ID of the movie file     |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_relativepath     | Path to the movie file relative   |
|                                   | to the movie' path                |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_path             | Full path to the movie file       |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_quality          | Quality name from Radarr          |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_qualityversion   | 1 is the default, 2 for proper,   |
|                                   | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_releasegroup     | Release group, empty if missing   |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_scenename        | Original release name, empty if   |
|                                   | missing                           |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_sourcepath       | Full path to the movie file that  |
|                                   | was imported                      |
+-----------------------------------+-----------------------------------+
| radarr_moviefile_sourcefolder     | Full path to the folder the movie |
|                                   | file was imported from            |
+-----------------------------------+-----------------------------------+
| radarr_deletedrelativepaths       | \| separated list of files that   |
|                                   | were deleted to import this file  |
+-----------------------------------+-----------------------------------+
| radarr_deletedpaths               | \| separated list of full paths   |
|                                   | for files that were deleted to    |
|                                   | import this file                  |
+-----------------------------------+-----------------------------------+

#### On Rename

  Environment Variable                 Details
  ------------------------------------ -----------------------------------------
  radarr_eventtype                     Rename
  radarr_movie_id                      Internal ID of the movie
  radarr_movie_imdbid                  IMDb ID for the movie, empty if missing
  radarr_movie_in_cinemas_date         Cinema release date, empty if missing
  radarr_movie_path                    Full path to the movie
  radarr_movie_physical_release_date   Physical release date, empty if missing
  radarr_movie_title                   Title of the movie
  radarr_movie_tmdbid                  TMDb ID for the movie
  radarr_movie_year                    Release year of the movie

#### On Health Check

  Environment Variable          Details
  ----------------------------- ------------------------------------------------------
  radarr_eventype               HealthIssue
  radarr_health_issue_level     the type of health issue: Ok, Notice, Warning, Error
  radarr_health_issue_message   the message from the health issue
  radarr_health_issue_type      the area that failed and triggered the health issue
  radarr_health_issue_wiki      the wiki url, empty if does not exist

#### On Test

When adding the script to Radarr and run 'Test' the script will be
invoked with the following parameters. The script should be able to
gracefully ignore any other eventtype

  Environment Variable   Details
  ---------------------- ---------
  radarr_eventtype       Test
