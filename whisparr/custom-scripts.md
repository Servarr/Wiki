---
title: Whisparr Custom Scripts
description: 
published: true
date: 2022-05-02T03:37:47.889Z
tags: needs-love, custom scripts, whisparr
editor: markdown
dateCreated: 2022-04-03T03:49:14.966Z
---

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Whisparr via the [Connect Settings](/whisparr/settings#connections).

# Overview

Whisparr can execute a custom script when movies are imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## Whisparr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Info`
- The trigger of the script will be logged in `Trace`

# Environment Variables

## On Grab

| Environment Variable                 | Details                                                                                      |
| ------------------------------------ | -------------------------------------------------------------------------------------------- |
| `whisparr_eventtype`                   | `Grab`                                                                                       |
| `whisparr_download_client`             | Download client (empty if unknown)                                                           |
| `whisparr_download_id`                 | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `whisparr_movie_id`                    | Internal ID of the movie                                                                     |
| `whisparr_movie_imdbid`                | IMDb ID for the movie (empty if unknown)                                                     |
| `whisparr_movie_in_cinemas_date`       | Cinema release date (empty if unknown)                                                       |
| `whisparr_movie_physical_release_date` | Physical release date (empty if unknown)                                                     |
| `whisparr_movie_title`                 | Title of the movie                                                                           |
| `whisparr_movie_tmdbid`                | TMDb ID for the movie                                                                        |
| `whisparr_movie_year`                  | Release year of the movie                                                                    |
| `whisparr_release_indexer`             | Indexer from which the release was grabbed                                                   |
| `whisparr_release_quality`             | Quality name of the release, as detected by Whisparr                                           |
| `whisparr_release_qualityversion`      | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `whisparr_release_releasegroup`        | Release group (empty if unknown)                                                             |
| `whisparr_release_size`                | Size of the release, as reported by the indexer                                              |
| `whisparr_release_title`               | Torrent/NZB title                                                                            |

## On Import/On Upgrade

| Environment Variable                 | Details                                                                                      |
| ------------------------------------ | -------------------------------------------------------------------------------------------- |
| `whisparr_eventtype`                   | `Download`                                                                                   |
| `whisparr_download_id`                 | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `whisparr_download_client`             | Download client                                                                              |
| `whisparr_isupgrade`                   | `True` when an existing file is upgraded, `False` otherwise                                  |
| `whisparr_movie_id`                    | Internal ID of the movie                                                                     |
| `whisparr_movie_imdbid`                | IMDb ID for the movie (empty if unknown)                                                     |
| `whisparr_movie_in_cinemas_date`       | Cinema release date (empty if unknown)                                                       |
| `whisparr_movie_path`                  | Full path to the movie                                                                       |
| `whisparr_movie_physical_release_date` | Physical release date (empty if unknown)                                                     |
| `whisparr_movie_title`                 | Title of the movie                                                                           |
| `whisparr_movie_tmdbid`                | TMDb ID for the movie                                                                        |
| `whisparr_movie_year`                  | Release year of the movie                                                                    |
| `whisparr_moviefile_id`                | Internal ID of the movie file                                                                |
| `whisparr_moviefile_relativepath`      | Path to the movie file, relative to the movie path                                           |
| `whisparr_moviefile_path`              | Full path to the movie file                                                                  |
| `whisparr_moviefile_quality`           | Quality name of the release, as detected by Whisparr                                           |
| `whisparr_moviefile_qualityversion`    | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `whisparr_moviefile_releasegroup`      | Release group (empty if unknown)                                                             |
| `whisparr_moviefile_scenename`         | Original release name (empty if unknown)                                                     |
| `whisparr_moviefile_sourcepath`        | Full path to the imported movie file                                                         |
| `whisparr_moviefile_sourcefolder`      | Full path to the folder the movie file was imported from                                     |
| `whisparr_deletedrelativepaths`        | `|`-delimited list of files that were deleted to import this file                            |
| `whisparr_deletedpaths`                | `|`-delimited list of full paths to files that were deleted to import this file              |

## On Rename

| Environment Variable                     | Details                                         |
| ---------------------------------------- | ----------------------------------------------- |
| `whisparr_eventtype`                       | `Rename`                                        |
| `whisparr_movie_id`                        | Internal ID of the movie                        |
| `whisparr_movie_title`                     | Title of the movie                              |
| `whisparr_movie_year`                      | Release year of the movie                       |
| `whisparr_movie_path`                      | Full path to the movie                          |
| `whisparr_movie_imdbid`                    | IMDb ID for the movie (empty if unknown)        |
| `whisparr_movie_tmdbid`                    | TMDb ID for the movie                           |
| `whisparr_movie_in_cinemas_date`           | Cinema release date (empty if unknown)          |
| `whisparr_movie_physical_release_date`     | Physical/Web release date (empty if unknown)    |
| `whisparr_moviefile_ids`                   | `,`-delimited list of file ID(s)                |
| `whisparr_moviefile_relativepaths`         | `|`-delimited list of relative path(s)          |
| `whisparr_moviefile_paths`                 | `|`-delimited list of path(s)                   |
| `whisparr_moviefile_previousrelativepaths` | `|`-delimited list of previous relative path(s) |
| `whisparr_moviefile_previouspaths`         | `|`-delimited list of previous path(s)          |

## On Health Check

| Environment Variable          | Details                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `whisparr_eventype`             | `HealthIssue`                                                |
| `whisparr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `whisparr_health_issue_message` | Message from the health issue                                |
| `whisparr_health_issue_type`    | Area that failed and triggered the health issue              |
| `whisparr_health_issue_wiki`    | Wiki URL (empty if does not exist)                           |

## On Application Update

| Environment Variable             | Details                               |
|--------------------------------- |-------------------------------------- |
| `whisparr_eventype`                | `ApplicationUpdate`                   |
| `whisparr_update_message`          | Message from Update                   |
| `whisparr_update_newversion`       | Version Whisparr updated to (string)    |
| `whisparr_update_previousversion`  | Version Whisparr updated from (string)  |

## On Test

When adding the script to Whisparr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `whisparr_eventtype`   | `Test`  |
