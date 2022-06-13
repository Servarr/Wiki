---
title: Sonarr Custom Scripts
description: 
published: true
date: 2022-06-13T15:52:03.477Z
tags: sonarr, needs-love, custom scripts
editor: markdown
dateCreated: 2021-06-16T15:55:53.999Z
---

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Sonarr via the [Connect Settings](/sonarr/settings#connections).

# Overview

Sonarr can execute a custom script when an episode is newly imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## Sonarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Info`
- The trigger of the script will be logged in `Trace`

# Environment Variables

## On Grab

| Environment Variable                    | Details                                                                                      |
| --------------------------------------- | -------------------------------------------------------------------------------------------- |
| `sonarr_eventtype`                      | `Grab`                                                                                       |
| `sonarr_series_id`                      | Internal ID of the series                                                                    |
| `sonarr_series_title`                   | Title of the series                                                                          |
| `sonarr_series_tvdbid`                  | TVDB ID for the series                                                                       |
| `sonarr_series_tvmazeid`                | TVMaze ID for the series                                                                     |
| `sonarr_series_imdbid`                  | IMDB ID for the series (empty if unknown)                                                    |
| `sonarr_series_type`                    | Type of the series (`Anime`, `Daily`, or `Standard`)                                         |
| `sonarr_release_episodecount`           | Number of episodes in the release                                                            |
| `sonarr_release_seasonnumber`           | Season number from release                                                                   |
| `sonarr_release_episodenumbers`         | Comma-delimited list of episode numbers                                                      |
| `sonarr_release_absoluteepisodenumbers` | Comma-delimited list of absolute episode numbers                                             |
| `sonarr_release_episodeairdates`        | Comma-delimited list of air dates from original network                                      |
| `sonarr_release_episodeairdatesutc`     | Comma-delimited list of air dates in UTC                                                     |
| `sonarr_release_episodetitles`          | `\|`-delimited list of episode titles                                                        |
| `sonarr_release_title`                  | Torrent/NZB title                                                                            |
| `sonarr_release_indexer`                | Indexer from which the release was grabbed                                                   |
| `sonarr_release_size`                   | Size of the release, as reported by the indexer                                              |
| `sonarr_release_quality`                | Quality name of the release, as detected by Sonarr                                           |
| `sonarr_release_qualityversion`         | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `sonarr_release_releasegroup`           | Release group (empty if unknown)                                                             |
| `sonarr_download_client`                | Download client                                                                              |
| `sonarr_download_id`                    | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |

## On Import/On Upgrade

| Environment Variable                    | Details                                                                                      |
| --------------------------------------- | -------------------------------------------------------------------------------------------- |
| `sonarr_eventtype`                      | `Download`                                                                                   |
| `sonarr_isupgrade`                      | `True` when an existing file is upgraded, `False` otherwise                                  |
| `sonarr_series_id`                      | Internal ID of the series                                                                    |
| `sonarr_series_title`                   | Title of the series                                                                          |
| `sonarr_series_path`                    | Full path to the series                                                                      |
| `sonarr_series_tvdbid`                  | TVDB ID for the series                                                                       |
| `sonarr_series_tvmazeid`                | TVMaze ID for the series                                                                     |
| `sonarr_series_imdbid`                  | IMDB ID for the series (empty if unknown)                                                    |
| `sonarr_series_type`                    | Type of the series (`Anime`, `Daily`, or `Standard`)                                         |
| `sonarr_episodefile_id`                 | Internal ID of the episode file                                                              |
| `sonarr_episodefile_episodecount`       | Number of episodes in the file                                                               |
| `sonarr_episodefile_relativepath`       | Path to the episode file, relative to the series path                                        |
| `sonarr_episodefile_path`               | Full path to the episode file                                                                |
| `sonarr_episodefile_episodeids`         | Internal ID(s) of the episode file                                                           |
| `sonarr_episodefile_seasonnumber`       | Season number of episode file                                                                |
| `sonarr_episodefile_episodenumbers`     | Comma-delimited list of episode numbers                                                      |
| `sonarr_episodefile_episodeairdates`    | Comma-delimited list of air dates from original network                                      |
| `sonarr_episodefile_episodeairdatesutc` | Comma-delimited list of air dates in UTC                                                     |
| `sonarr_episodefile_episodetitles`      | `\|`-delimited list of episode titles                                                        |
| `sonarr_episodefile_quality`            | Quality name of the episode file, as detected by Sonarr                                      |
| `sonarr_episodefile_qualityversion`     | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `sonarr_episodefile_releasegroup`       | Release group (empty if unknown)                                                             |
| `sonarr_episodefile_scenename`          | Original release name (empty if unknown)                                                     |
| `sonarr_episodefile_sourcepath`         | Full path to the imported episode file                                                       |
| `sonarr_episodefile_sourcefolder`       | Full path to the folder the episode file was imported from                                   |
| `sonarr_download_client`                | Download client                                                                              |
| `sonarr_download_id`                    | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `sonarr_deletedrelativepaths`           | `\|`-delimited list of files that were deleted to import this file                           |
| `sonarr_deletedpaths`                   | `\|`-delimited list of full paths of files that were deleted to import this file             |

## On Rename

| Environment Variable     | Details                                              |
| ------------------------ | ---------------------------------------------------- |
| `sonarr_eventtype`       | `Rename`                                             |
| `sonarr_series_id`       | Internal ID of the series                            |
| `sonarr_series_title`    | Title of the series                                  |
| `sonarr_series_path`     | Full path to the series                              |
| `sonarr_series_tvdbid`   | TVDB ID for the series                               |
| `sonarr_series_tvmazeid` | TVMaze ID for the series                             |
| `sonarr_series_imdbid`   | IMDB ID for the series (empty if unknown)            |
| `sonarr_series_type`     | Type of the series (`Anime`, `Daily`, or `Standard`) |

## On Episode File Delete

| Environment Variable                    | Details                                                                          |
| --------------------------------------- | -------------------------------------------------------------------------------- |
| `sonarr_eventtype`                      | `EpisodeFileDelete`                                                              |
| `sonarr_series_id`                      | Internal ID of the series                                                        |
| `sonarr_series_title`                   | Title of the series                                                              |
| `sonarr_series_path`                    | Full path to the series                                                          |
| `sonarr_series_tvdbid`                  | TVDB ID for the series                                                           |
| `sonarr_series_tvmazeid`                | TVMaze ID for the series                                                         |
| `sonarr_series_imdbid`                  | IMDB ID for the series (empty if unknown)                                        |
| `sonarr_series_type`                    | Type of the series (`Anime`, `Daily`, or `Standard`)                             |
| `sonarr_episodefile_id`                 | Internal ID of the episode file                                                  |
| `sonarr_episodefile_episodecount`       | Number of episodes in the file                                                   |
| `sonarr_episodefile_relativepath`       | Path to the episode file, relative to the series' path                           |
| `sonarr_episodefile_path`               | Full path to the episode file                                                    |
| `sonarr_episodefile_episodeids`         | Internal ID(s) of the episode file                                               |
| `sonarr_episodefile_seasonnumber`       | Season number of episode file                                                    |
| `sonarr_episodefile_episodenumbers`     | Comma-delimited list of episode numbers                                          |
| `sonarr_episodefile_episodeairdates`    | Comma-delimited list of air dates from original network                          |
| `sonarr_episodefile_episodeairdatesutc` | Comma-delimited list of air dates in UTC                                         |
| `sonarr_episodefile_episodetitles`      | `\|`-delimited list of episode titles                                            |
| `sonarr_episodefile_quality`            | Quality name of the episode file, as detected by Sonarr                          |
| `sonarr_episodefile_qualityversion`     | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions |
| `sonarr_episodefile_releasegroup`       | Release group (empty if unknown)                                                 |
| `sonarr_episodefile_scenename`          | Original release name (empty if unknown)                                         |

## On Series Delete

| Environment Variable         | Details                                                                  |
| ---------------------------- | ------------------------------------------------------------------------ |
| `sonarr_eventtype`           | `SeriesDelete`                                                           |
| `sonarr_series_id`           | Internal ID of the series                                                |
| `sonarr_series_title`        | Title of the series                                                      |
| `sonarr_series_path`         | Full path to the series                                                  |
| `sonarr_series_tvdbid`       | TVDB ID for the series                                                   |
| `sonarr_series_imdbid`       | IMDB ID for the series (empty if unknown)                                |
| `sonarr_series_type`         | Type of the series (`Anime`, `Daily`, or `Standard`)                     |
| `sonarr_series_deletedfiles` | `True` when the delete files option has been selected, otherwise `False` |

## On Health Issue

| Environment Variable          | Details                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `sonarr_eventype`             | `HealthIssue`                                                |
| `sonarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `sonarr_health_issue_message` | Message from the health issue                                |
| `sonarr_health_issue_type`    | Area that failed and triggered the health issue              |
| `sonarr_health_issue_wiki`    | Wiki URL (empty if does not exist)                           |

## On Application Update

| Environment Variable             | Details                               |
|--------------------------------- |-------------------------------------- |
| `sonarr_eventype`                | `ApplicationUpdate`                   |
| `sonarr_update_message`          | Message from Update                   |
| `sonarr_update_newversion`       | Version Sonarr updated to (string)    |
| `sonarr_update_previousversion`  | Version Sonarr updated from (string)  |

## On Test

When adding the script to Sonarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `sonarr_eventtype`   | `Test`  |
