---
title: Radarr Custom Scripts
description: Guide for creating and implementing custom scripts for automation and integration in Radarr
published: true
date: 2026-06-07T00:00:00.000Z
tags: radarr, scripts, automation, custom, integration, hooks, api
editor: markdown
dateCreated: 2021-06-16T15:55:44.765Z
---

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Radarr via the [Connect Settings](/radarr/settings#connections).

# Overview

Radarr can execute a custom script when movies are imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## Radarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Info`
- The trigger of the script will be logged in `Trace`

# Environment Variables

## On Grab

| Environment Variable                 | Details                                                                                      |
| ------------------------------------ | -------------------------------------------------------------------------------------------- |
| `radarr_eventtype`                   | `Grab`                                                                                       |
| `radarr_instancename`                | Instance name from Settings > General                                                        |
| `radarr_applicationurl`              | Application URL from Settings > General                                                      |
| `radarr_movie_id`                    | Internal ID of the movie                                                                     |
| `radarr_movie_title`                 | Title of the movie                                                                           |
| `radarr_movie_year`                  | Release year of the movie                                                                    |
| `radarr_movie_originallanguage`      | Original language of the movie (ISO 639-2 three-letter code)                                 |
| `radarr_movie_genres`                | \|-delimited list of genres for the movie                                                    |
| `radarr_movie_tags`                  | Tags set for the movie                                                                       |
| `radarr_movie_imdbid`                | IMDb ID for the movie (empty if unknown)                                                     |
| `radarr_movie_tmdbid`                | TMDb ID for the movie                                                                        |
| `radarr_movie_in_cinemas_date`       | Cinema release date (empty if unknown)                                                       |
| `radarr_movie_physical_release_date` | Physical release date (empty if unknown)                                                     |
| `radarr_movie_overview`              | Overview/description of the movie                                                            |
| `radarr_release_title`               | Torrent/NZB title                                                                            |
| `radarr_release_indexer`             | Indexer from which the release was grabbed                                                   |
| `radarr_release_size`                | Size of the release, as reported by the indexer                                              |
| `radarr_release_releasegroup`        | Release group (empty if unknown)                                                             |
| `radarr_release_quality`             | Quality name of the release, as detected by Radarr                                           |
| `radarr_release_qualityversion`      | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `radarr_indexerflags`                | Indexer flags associated with the release                                                    |
| `radarr_release_customformat`        | \|-delimited list of custom formats for the release                                          |
| `radarr_release_customformatscore`   | Custom format score for the release                                                          |
| `radarr_download_client`             | Download client (empty if unknown)                                                           |
| `radarr_download_client_type`        | Download client type (empty if unknown)                                                      |
| `radarr_download_id`                 | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |

## On Import/On Upgrade

| Environment Variable                          | Details                                                                                      |
| --------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `radarr_eventtype`                            | `Download`                                                                                   |
| `radarr_instancename`                         | Instance name from Settings > General                                                        |
| `radarr_applicationurl`                       | Application URL from Settings > General                                                      |
| `radarr_isupgrade`                            | `True` when an existing file is upgraded, `False` otherwise                                  |
| `radarr_movie_id`                             | Internal ID of the movie                                                                     |
| `radarr_movie_title`                          | Title of the movie                                                                           |
| `radarr_movie_year`                           | Release year of the movie                                                                    |
| `radarr_movie_originallanguage`               | Original language of the movie (ISO 639-2 three-letter code)                                 |
| `radarr_movie_genres`                         | \|-delimited list of genres for the movie                                                    |
| `radarr_movie_tags`                           | Tags set for the movie                                                                       |
| `radarr_movie_path`                           | Full path to the movie                                                                       |
| `radarr_movie_imdbid`                         | IMDb ID for the movie (empty if unknown)                                                     |
| `radarr_movie_tmdbid`                         | TMDb ID for the movie                                                                        |
| `radarr_movie_in_cinemas_date`                | Cinema release date (empty if unknown)                                                       |
| `radarr_movie_physical_release_date`          | Physical release date (empty if unknown)                                                     |
| `radarr_movie_overview`                       | Overview/description of the movie                                                            |
| `radarr_moviefile_id`                         | Internal ID of the movie file                                                                |
| `radarr_moviefile_relativepath`               | Path to the movie file, relative to the movie path                                           |
| `radarr_moviefile_path`                       | Full path to the movie file                                                                  |
| `radarr_moviefile_quality`                    | Quality name of the release, as detected by Radarr                                           |
| `radarr_moviefile_qualityversion`             | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `radarr_moviefile_releasegroup`               | Release group (empty if unknown)                                                             |
| `radarr_moviefile_scenename`                  | Original release name (empty if unknown)                                                     |
| `radarr_moviefile_sourcepath`                 | Full path to the imported movie file                                                         |
| `radarr_moviefile_sourcefolder`               | Full path to the folder the movie file was imported from                                     |
| `radarr_moviefile_mediainfo_audiochannels`    | Number of audio channels in the movie file                                                   |
| `radarr_moviefile_mediainfo_audiocodec`       | Audio codec of the movie file                                                                |
| `radarr_moviefile_mediainfo_audiolanguages`   | Audio languages in the movie file (distinct, space/slash-delimited)                          |
| `radarr_moviefile_mediainfo_languages`        | Audio languages in the movie file (space/slash-delimited)                                    |
| `radarr_moviefile_mediainfo_height`           | Video height in pixels                                                                       |
| `radarr_moviefile_mediainfo_width`            | Video width in pixels                                                                        |
| `radarr_moviefile_mediainfo_subtitles`        | Subtitle languages in the movie file (space/slash-delimited)                                 |
| `radarr_moviefile_mediainfo_videocodec`       | Video codec of the movie file                                                                |
| `radarr_moviefile_mediainfo_videodynamicrangetype` | Dynamic range type of the video (e.g. HDR, DV)                                         |
| `radarr_moviefile_customformat`               | \|-delimited list of custom formats for the movie file                                       |
| `radarr_moviefile_customformatscore`          | Custom format score for the movie file                                                       |
| `radarr_release_indexer`                      | Indexer from which the release was grabbed (empty if unknown)                                |
| `radarr_release_size`                         | Size of the release (empty if unknown)                                                       |
| `radarr_release_title`                        | Torrent/NZB title (empty if unknown)                                                         |
| `radarr_download_client`                      | Download client                                                                              |
| `radarr_download_client_type`                 | Download client type                                                                         |
| `radarr_download_id`                          | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `radarr_deletedrelativepaths`                 | \|-delimited list of files that were deleted to import this file (only if upgrade)           |
| `radarr_deletedpaths`                         | \|-delimited list of full paths to files that were deleted to import this file (only if upgrade) |
| `radarr_deleteddateadded`                     | \|-delimited list of dates the deleted files were added (only if upgrade)                    |
| `radarr_deletedrecyclebinpaths`               | \|-delimited list of recycle bin paths for deleted files (only if upgrade; empty if not moved to recycle bin) |

## On Rename

| Environment Variable                     | Details                                        |
| ---------------------------------------- | ---------------------------------------------- |
| `radarr_eventtype`                       | `Rename`                                       |
| `radarr_instancename`                    | Instance name from Settings > General          |
| `radarr_applicationurl`                  | Application URL from Settings > General        |
| `radarr_movie_id`                        | Internal ID of the movie                       |
| `radarr_movie_title`                     | Title of the movie                             |
| `radarr_movie_year`                      | Release year of the movie                      |
| `radarr_movie_originallanguage`          | Original language of the movie (ISO 639-2 three-letter code) |
| `radarr_movie_genres`                    | \|-delimited list of genres for the movie      |
| `radarr_movie_tags`                      | Tags set for the movie                         |
| `radarr_movie_path`                      | Full path to the movie                         |
| `radarr_movie_imdbid`                    | IMDb ID for the movie (empty if unknown)       |
| `radarr_movie_tmdbid`                    | TMDb ID for the movie                          |
| `radarr_movie_in_cinemas_date`           | Cinema release date (empty if unknown)         |
| `radarr_movie_physical_release_date`     | Physical/Web release date (empty if unknown)   |
| `radarr_moviefile_ids`                   | `,`-delimited list of file ID(s)               |
| `radarr_moviefile_relativepaths`         | \|-delimited list of relative path(s)          |
| `radarr_moviefile_paths`                 | \|-delimited list of path(s)                   |
| `radarr_moviefile_previousrelativepaths` | \|-delimited list of previous relative path(s) |
| `radarr_moviefile_previouspaths`         | \|-delimited list of previous path(s)          |

## On Movie Added

| Environment Variable            | Details                                                      |
| ------------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`              | `MovieAdded`                                                 |
| `radarr_instancename`           | Instance name from Settings > General                        |
| `radarr_applicationurl`         | Application URL from Settings > General                      |
| `radarr_movie_id`               | Internal ID of the movie                                     |
| `radarr_movie_title`            | Title of the movie                                           |
| `radarr_movie_year`             | Release year of the movie                                    |
| `radarr_movie_originallanguage` | Original language of the movie (ISO 639-2 three-letter code) |
| `radarr_movie_genres`           | \|-delimited list of genres for the movie                    |
| `radarr_movie_tags`             | Tags set for the movie                                       |
| `radarr_movie_path`             | Full path to the movie                                       |
| `radarr_movie_imdbid`           | IMDb ID for the movie (empty if unknown)                     |
| `radarr_movie_tmdbid`           | TMDb ID for the movie                                        |
| `radarr_movie_addmethod`        | Method used to add the movie (e.g. `Manual`, `List`, `Api`)  |

## On Movie Delete

| Environment Variable            | Details                                                      |
| ------------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`              | `MovieDelete`                                                |
| `radarr_instancename`           | Instance name from Settings > General                        |
| `radarr_applicationurl`         | Application URL from Settings > General                      |
| `radarr_movie_id`               | Internal ID of the movie                                     |
| `radarr_movie_title`            | Title of the movie                                           |
| `radarr_movie_year`             | Release year of the movie                                    |
| `radarr_movie_originallanguage` | Original language of the movie (ISO 639-2 three-letter code) |
| `radarr_movie_genres`           | \|-delimited list of genres for the movie                    |
| `radarr_movie_tags`             | Tags set for the movie                                       |
| `radarr_movie_path`             | Full path to the movie                                       |
| `radarr_movie_imdbid`           | IMDb ID for the movie (empty if unknown)                     |
| `radarr_movie_tmdbid`           | TMDb ID for the movie                                        |
| `radarr_movie_overview`         | Overview/description of the movie                            |
| `radarr_movie_deletedfiles`     | `True` if files were deleted with the movie, `False` otherwise |
| `radarr_movie_folder_size`      | Size of the movie file (only present if files were deleted)  |

## On Movie File Delete

| Environment Variable            | Details                                                      |
| ------------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`              | `MovieFileDelete`                                            |
| `radarr_instancename`           | Instance name from Settings > General                        |
| `radarr_applicationurl`         | Application URL from Settings > General                      |
| `radarr_moviefile_deletereason` | Reason for deletion                                          |
| `radarr_movie_id`               | Internal ID of the movie                                     |
| `radarr_movie_title`            | Title of the movie                                           |
| `radarr_movie_year`             | Release year of the movie                                    |
| `radarr_movie_originallanguage` | Original language of the movie (ISO 639-2 three-letter code) |
| `radarr_movie_genres`           | \|-delimited list of genres for the movie                    |
| `radarr_movie_tags`             | Tags set for the movie                                       |
| `radarr_movie_path`             | Full path to the movie                                       |
| `radarr_movie_imdbid`           | IMDb ID for the movie (empty if unknown)                     |
| `radarr_movie_tmdbid`           | TMDb ID for the movie                                        |
| `radarr_movie_overview`         | Overview/description of the movie                            |
| `radarr_moviefile_id`           | Internal ID of the movie file                                |
| `radarr_moviefile_relativepath` | Path to the movie file, relative to the movie path           |
| `radarr_moviefile_path`         | Full path to the movie file                                  |
| `radarr_moviefile_size`         | Size of the movie file                                       |
| `radarr_moviefile_quality`      | Quality name of the release, as detected by Radarr           |
| `radarr_moviefile_qualityversion` | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions |
| `radarr_moviefile_releasegroup` | Release group (empty if unknown)                             |
| `radarr_moviefile_scenename`    | Original release name (empty if unknown)                     |

## On Health Check

| Environment Variable          | Details                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`            | `HealthIssue`                                                |
| `radarr_instancename`         | Instance name from Settings > General                        |
| `radarr_applicationurl`       | Application URL from Settings > General                      |
| `radarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `radarr_health_issue_message` | Message from the health issue                                |
| `radarr_health_issue_type`    | Area that failed and triggered the health issue              |
| `radarr_health_issue_wiki`    | Wiki URL (empty if does not exist)                           |

## On Health Restored

| Environment Variable              | Details                                                      |
| --------------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`                | `HealthRestored`                                             |
| `radarr_instancename`             | Instance name from Settings > General                        |
| `radarr_applicationurl`           | Application URL from Settings > General                      |
| `radarr_health_restored_level`    | Type of health issue that was restored (`Ok`, `Notice`, `Warning`, or `Error`) |
| `radarr_health_restored_message`  | Message from the health issue that was restored              |
| `radarr_health_restored_type`     | Area that triggered the health issue that was restored       |
| `radarr_health_restored_wiki`     | Wiki URL (empty if does not exist)                           |

## On Application Update

| Environment Variable            | Details                              |
| ------------------------------- | ------------------------------------ |
| `radarr_eventtype`              | `ApplicationUpdate`                  |
| `radarr_instancename`           | Instance name from Settings > General |
| `radarr_applicationurl`         | Application URL from Settings > General |
| `radarr_update_message`         | Message from Update                  |
| `radarr_update_newversion`      | Version Radarr updated to (string)   |
| `radarr_update_previousversion` | Version Radarr updated from (string) |

## On Manual Interaction Required

| Environment Variable            | Details                                                      |
| ------------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`              | `ManualInteractionRequired`                                  |
| `radarr_instancename`           | Instance name from Settings > General                        |
| `radarr_applicationurl`         | Application URL from Settings > General                      |
| `radarr_movie_id`               | Internal ID of the movie                                     |
| `radarr_movie_title`            | Title of the movie                                           |
| `radarr_movie_year`             | Release year of the movie                                    |
| `radarr_movie_originallanguage` | Original language of the movie (ISO 639-2 three-letter code) |
| `radarr_movie_genres`           | \|-delimited list of genres for the movie                    |
| `radarr_movie_tags`             | Tags set for the movie                                       |
| `radarr_movie_path`             | Full path to the movie                                       |
| `radarr_movie_imdbid`           | IMDb ID for the movie (empty if unknown)                     |
| `radarr_movie_tmdbid`           | TMDb ID for the movie                                        |
| `radarr_movie_overview`         | Overview/description of the movie                            |
| `radarr_download_client`        | Download client (empty if unknown)                           |
| `radarr_download_client_type`   | Download client type (empty if unknown)                      |
| `radarr_download_id`            | Download ID (empty if unknown)                               |
| `radarr_download_size`          | Total size of the download item                              |
| `radarr_download_title`         | Title of the download item                                   |

## On Test

When adding the script to Radarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable    | Details                               |
| ----------------------- | ------------------------------------- |
| `radarr_eventtype`      | `Test`                                |
| `radarr_instancename`   | Instance name from Settings > General |
| `radarr_applicationurl` | Application URL from Settings > General |
