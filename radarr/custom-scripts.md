---
title: Radarr Custom Scripts
description: Guide for creating and implementing custom scripts for automation and integration in Radarr
published: true
date: 2025-08-12T13:58:51.517Z
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
| `radarr_download_client`             | Download client (empty if unknown)                                                           |
| `radarr_download_id`                 | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `radarr_movie_id`                    | Internal ID of the movie                                                                     |
| `radarr_movie_imdbid`                | IMDb ID for the movie (empty if unknown)                                                     |
| `radarr_movie_in_cinemas_date`       | Cinema release date (empty if unknown)                                                       |
| `radarr_movie_physical_release_date` | Physical release date (empty if unknown)                                                     |
| `radarr_movie_title`                 | Title of the movie                                                                           |
| `radarr_movie_tmdbid`                | TMDb ID for the movie                                                                        |
| `radarr_movie_year`                  | Release year of the movie                                                                    |
| `radarr_movie_tags`                  | Tags set for the movie                                                                       |
| `radarr_release_indexer`             | Indexer from which the release was grabbed                                                   |
| `radarr_indexerflags`                | Indexer flags associated with the release                                                    |
| `radarr_release_quality`             | Quality name of the release, as detected by Radarr                                           |
| `radarr_release_qualityversion`      | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `radarr_release_releasegroup`        | Release group (empty if unknown)                                                             |
| `radarr_release_size`                | Size of the release, as reported by the indexer                                              |
| `radarr_release_title`               | Torrent/NZB title                                                                            |

## On Import/On Upgrade

| Environment Variable                 | Details                                                                                      |
| ------------------------------------ | -------------------------------------------------------------------------------------------- |
| `radarr_eventtype`                   | `Download`                                                                                   |
| `radarr_download_id`                 | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `radarr_download_client`             | Download client                                                                              |
| `radarr_isupgrade`                   | `True` when an existing file is upgraded, `False` otherwise                                  |
| `radarr_movie_id`                    | Internal ID of the movie                                                                     |
| `radarr_movie_imdbid`                | IMDb ID for the movie (empty if unknown)                                                     |
| `radarr_movie_in_cinemas_date`       | Cinema release date (empty if unknown)                                                       |
| `radarr_movie_path`                  | Full path to the movie                                                                       |
| `radarr_movie_physical_release_date` | Physical release date (empty if unknown)                                                     |
| `radarr_movie_title`                 | Title of the movie                                                                           |
| `radarr_movie_tags`                  | Tags set for the movie                                                                       |
| `radarr_movie_tmdbid`                | TMDb ID for the movie                                                                        |
| `radarr_movie_year`                  | Release year of the movie                                                                    |
| `radarr_moviefile_id`                | Internal ID of the movie file                                                                |
| `radarr_moviefile_relativepath`      | Path to the movie file, relative to the movie path                                           |
| `radarr_moviefile_path`              | Full path to the movie file                                                                  |
| `radarr_moviefile_quality`           | Quality name of the release, as detected by Radarr                                           |
| `radarr_moviefile_qualityversion`    | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `radarr_moviefile_releasegroup`      | Release group (empty if unknown)                                                             |
| `radarr_moviefile_scenename`         | Original release name (empty if unknown)                                                     |
| `radarr_moviefile_sourcepath`        | Full path to the imported movie file                                                         |
| `radarr_moviefile_sourcefolder`      | Full path to the folder the movie file was imported from                                     |
| `radarr_deletedrelativepaths`        | \|-delimited list of files that were deleted to import this file                             |
| `radarr_deletedpaths`                | \|-delimited list of full paths to files that were deleted to import this file               |

## On Rename

| Environment Variable                     | Details                                        |
| ---------------------------------------- | ---------------------------------------------- |
| `radarr_eventtype`                       | `Rename`                                       |
| `radarr_movie_id`                        | Internal ID of the movie                       |
| `radarr_movie_title`                     | Title of the movie                             |
| `radarr_movie_tags`                      | Tags set for the movie                         |
| `radarr_movie_year`                      | Release year of the movie                      |
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

## On Health Check

| Environment Variable          | Details                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `radarr_eventtype`            | `HealthIssue`                                                |
| `radarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `radarr_health_issue_message` | Message from the health issue                                |
| `radarr_health_issue_type`    | Area that failed and triggered the health issue              |
| `radarr_health_issue_wiki`    | Wiki URL (empty if does not exist)                           |

## On Application Update

| Environment Variable            | Details                              |
| ------------------------------- | ------------------------------------ |
| `radarr_eventtype`              | `ApplicationUpdate`                  |
| `radarr_update_message`         | Message from Update                  |
| `radarr_update_newversion`      | Version Radarr updated to (string)   |
| `radarr_update_previousversion` | Version Radarr updated from (string) |

## On Test

When adding the script to Radarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `radarr_eventtype`   | `Test`  |
