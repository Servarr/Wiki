---
title: Sonarr Custom Scripts
description: Guide for creating and implementing custom scripts for automation and integration
published: true
date: 2026-06-07T00:00:00.000Z
tags: sonarr, scripts, automation, custom, integration, hooks, api
editor: markdown
dateCreated: 2021-06-16T15:55:53.999Z
---

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Sonarr via the [Connect Settings](/sonarr/settings#connections).

# Overview

Sonarr can execute a custom script when an episode is newly imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## Sonarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Error`
- The trigger of the script will be logged in `Trace`

# Environment Variables

## On Grab

| Environment Variable                    | Details                                                                                      |
| --------------------------------------- | -------------------------------------------------------------------------------------------- |
| `sonarr_eventtype`                      | `Grab`                                                                                       |
| `sonarr_instancename`                   | Instance name of the Sonarr installation                                                     |
| `sonarr_applicationurl`                 | URL of the Sonarr application                                                                |
| `sonarr_series_id`                      | Internal ID of the series                                                                    |
| `sonarr_series_title`                   | Title of the series                                                                          |
| `sonarr_series_titleslug`               | Common formatted title slug of the series                                                    |
| `sonarr_series_tvdbid`                  | TVDB ID for the series                                                                       |
| `sonarr_series_tvmazeid`                | TVMaze ID for the series                                                                     |
| `sonarr_series_tmdbid`                  | TMDB ID for the series                                                                       |
| `sonarr_series_imdbid`                  | IMDB ID for the series (empty if unknown)                                                    |
| `sonarr_series_type`                    | Type of the series (`Anime`, `Daily`, or `Standard`)                                         |
| `sonarr_series_year`                    | Year of the series                                                                           |
| `sonarr_series_originallanguage`        | Original language of the series                                                              |
| `sonarr_series_genres`                  | `\|`-delimited list of genres                                                                |
| `sonarr_series_tags`                    | `\|`-delimited list of tags                                                                  |
| `sonarr_release_episodecount`           | Number of episodes in the release                                                            |
| `sonarr_release_seasonnumber`           | Season number from release                                                                   |
| `sonarr_release_episodenumbers`         | Comma-delimited list of episode numbers                                                      |
| `sonarr_release_absoluteepisodenumbers` | Comma-delimited list of absolute episode numbers                                             |
| `sonarr_release_episodeairdates`        | Comma-delimited list of air dates from original network                                      |
| `sonarr_release_episodeairdatesutc`     | Comma-delimited list of air dates in UTC                                                     |
| `sonarr_release_episodetitles`          | `\|`-delimited list of episode titles                                                        |
| `sonarr_release_episodeoverviews`       | `\|`-delimited list of episode overview descriptions                                         |
| `sonarr_release_title`                  | Torrent/NZB title                                                                            |
| `sonarr_release_indexer`                | Indexer from which the release was grabbed                                                   |
| `sonarr_release_indexerflags`           | Indexer flags for the release (e.g. `Freeleech`)                                             |
| `sonarr_release_size`                   | Size of the release, as reported by the indexer (in bytes)                                   |
| `sonarr_release_quality`                | Quality name of the release, as detected by Sonarr                                           |
| `sonarr_release_qualityversion`         | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `sonarr_release_releasegroup`           | Release group (empty if unknown)                                                             |
| `sonarr_release_releasetype`            | Release type (`SingleEpisode`, `SeasonPack`)                                                 |
| `sonarr_release_customformat`           | `\|`-delimited list of custom formats                                                        |
| `sonarr_release_customformatscore`      | Numerical score of the custom formats of the release                                         |
| `sonarr_download_client`                | Download client                                                                              |
| `sonarr_download_client_type`           | Download client type                                                                         |
| `sonarr_download_id`                    | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |

## On Import/On Upgrade

| Environment Variable                              | Details                                                                                      |
| ------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `sonarr_eventtype`                                | `Download`                                                                                   |
| `sonarr_instancename`                             | Instance name of the Sonarr installation                                                     |
| `sonarr_applicationurl`                           | URL of the Sonarr application                                                                |
| `sonarr_isupgrade`                                | `True` when an existing file is upgraded, `False` otherwise                                  |
| `sonarr_series_id`                                | Internal ID of the series                                                                    |
| `sonarr_series_title`                             | Title of the series                                                                          |
| `sonarr_series_titleslug`                         | Common formatted title slug of the series                                                    |
| `sonarr_series_path`                              | Full path to the series                                                                      |
| `sonarr_series_tvdbid`                            | TVDB ID for the series                                                                       |
| `sonarr_series_tvmazeid`                          | TVMaze ID for the series                                                                     |
| `sonarr_series_tmdbid`                            | TMDB ID for the series                                                                       |
| `sonarr_series_imdbid`                            | IMDB ID for the series (empty if unknown)                                                    |
| `sonarr_series_type`                              | Type of the series (`Anime`, `Daily`, or `Standard`)                                         |
| `sonarr_series_year`                              | Year of the series                                                                           |
| `sonarr_series_originallanguage`                  | Original language of the series                                                              |
| `sonarr_series_genres`                            | `\|`-delimited list of genres                                                                |
| `sonarr_series_tags`                              | `\|`-delimited list of tags                                                                  |
| `sonarr_episodefile_id`                           | Internal ID of the episode file                                                              |
| `sonarr_episodefile_episodecount`                 | Number of episodes in the file                                                               |
| `sonarr_episodefile_relativepath`                 | Path to the episode file, relative to the series path                                        |
| `sonarr_episodefile_path`                         | Full path to the episode file                                                                |
| `sonarr_episodefile_episodeids`                   | Internal ID(s) of the episode file                                                           |
| `sonarr_episodefile_seasonnumber`                 | Season number of episode file                                                                |
| `sonarr_episodefile_episodenumbers`               | Comma-delimited list of episode numbers                                                      |
| `sonarr_episodefile_episodeairdates`              | Comma-delimited list of air dates from original network                                      |
| `sonarr_episodefile_episodeairdatesutc`           | Comma-delimited list of air dates in UTC                                                     |
| `sonarr_episodefile_episodetitles`                | `\|`-delimited list of episode titles                                                        |
| `sonarr_episodefile_episodeoverviews`             | `\|`-delimited list of episode overview descriptions                                         |
| `sonarr_episodefile_quality`                      | Quality name of the episode file, as detected by Sonarr                                      |
| `sonarr_episodefile_qualityversion`               | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions             |
| `sonarr_episodefile_releasegroup`                 | Release group (empty if unknown)                                                             |
| `sonarr_episodefile_scenename`                    | Original release name (empty if unknown)                                                     |
| `sonarr_episodefile_sourcepath`                   | Full path to the imported episode file                                                       |
| `sonarr_episodefile_sourcefolder`                 | Full path to the folder the episode file was imported from                                   |
| `sonarr_episodefile_mediainfo_audiochannels`      | Number of audio channels                                                                     |
| `sonarr_episodefile_mediainfo_audiocodec`         | Audio codec of the episode file                                                              |
| `sonarr_episodefile_mediainfo_audiolanguages`     | Audio languages of the episode file (distinct, space/slash-delimited)                       |
| `sonarr_episodefile_mediainfo_languages`          | Audio languages of the episode file (space/slash-delimited)                                  |
| `sonarr_episodefile_mediainfo_height`             | Video height of the episode file                                                             |
| `sonarr_episodefile_mediainfo_width`              | Video width of the episode file                                                              |
| `sonarr_episodefile_mediainfo_subtitles`          | Subtitle languages of the episode file (space/slash-delimited)                              |
| `sonarr_episodefile_mediainfo_videocodec`         | Video codec of the episode file                                                              |
| `sonarr_episodefile_mediainfo_videodynamicrangetype` | Dynamic range type of the episode file (e.g. `HDR`, `SDR`)                               |
| `sonarr_episodefile_customformat`                 | `\|`-delimited list of custom formats                                                        |
| `sonarr_episodefile_customformatscore`            | Numerical score of the custom formats of the episode file                                    |
| `sonarr_download_client`                          | Download client                                                                              |
| `sonarr_download_client_type`                     | Download client type                                                                         |
| `sonarr_download_id`                              | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `sonarr_release_indexer`                          | Indexer from which the release was grabbed                                                   |
| `sonarr_release_size`                             | Size of the release, as reported by the indexer (in bytes)                                   |
| `sonarr_release_title`                            | Torrent/NZB title                                                                            |
| `sonarr_release_releasetype`                      | Release type (`SingleEpisode`, `SeasonPack`)                                                 |
| `sonarr_deletedrelativepaths`                     | `\|`-delimited list of files that were deleted to import this file                           |
| `sonarr_deletedpaths`                             | `\|`-delimited list of full paths of files that were deleted to import this file             |
| `sonarr_deleteddateadded`                         | `\|`-delimited list of dates the deleted files were added (only set when upgrading)          |
| `sonarr_deletedrecyclebinpaths`                   | `\|`-delimited list of recycle bin paths for deleted files (only set when upgrading)         |

## On Import Complete

| Environment Variable                    | Details                                                                                      |
| --------------------------------------- | -------------------------------------------------------------------------------------------- |
| `sonarr_eventtype`                      | `Download`                                                                                   |
| `sonarr_instancename`                   | Instance name of the Sonarr installation                                                     |
| `sonarr_applicationurl`                 | URL of the Sonarr application                                                                |
| `sonarr_series_id`                      | Internal ID of the series                                                                    |
| `sonarr_series_title`                   | Title of the series                                                                          |
| `sonarr_series_titleslug`               | Common formatted title slug of the series                                                    |
| `sonarr_series_path`                    | Full path to the series                                                                      |
| `sonarr_series_tvdbid`                  | TVDB ID for the series                                                                       |
| `sonarr_series_tvmazeid`                | TVMaze ID for the series                                                                     |
| `sonarr_series_tmdbid`                  | TMDB ID for the series                                                                       |
| `sonarr_series_imdbid`                  | IMDB ID for the series (empty if unknown)                                                    |
| `sonarr_series_type`                    | Type of the series (`Anime`, `Daily`, or `Standard`)                                         |
| `sonarr_series_year`                    | Year of the series                                                                           |
| `sonarr_series_originallanguage`        | Original language of the series                                                              |
| `sonarr_series_genres`                  | `\|`-delimited list of genres                                                                |
| `sonarr_series_tags`                    | `\|`-delimited list of tags                                                                  |
| `sonarr_episodefile_ids`                | `\|`-delimited list of internal IDs of the imported episode files                           |
| `sonarr_episodefile_count`              | Number of episode files imported                                                             |
| `sonarr_episodefile_relativepaths`      | `\|`-delimited list of relative paths of the episode files                                   |
| `sonarr_episodefile_paths`              | `\|`-delimited list of full paths of the episode files                                       |
| `sonarr_episodefile_episodeids`         | Comma-delimited list of internal episode IDs                                                 |
| `sonarr_episodefile_seasonnumber`       | Season number of the episodes                                                                |
| `sonarr_episodefile_episodenumbers`     | Comma-delimited list of episode numbers                                                      |
| `sonarr_episodefile_episodeairdates`    | Comma-delimited list of air dates from original network                                      |
| `sonarr_episodefile_episodeairdatesutc` | Comma-delimited list of air dates in UTC                                                     |
| `sonarr_episodefile_episodetitles`      | `\|`-delimited list of episode titles                                                        |
| `sonarr_episodefile_episodeoverviews`   | `\|`-delimited list of episode overview descriptions                                         |
| `sonarr_episodefile_qualities`          | `\|`-delimited list of quality names for each episode file                                   |
| `sonarr_episodefile_qualityversions`    | `\|`-delimited list of quality versions for each episode file                                |
| `sonarr_episodefile_releasegroups`      | `\|`-delimited list of release groups for each episode file                                  |
| `sonarr_episodefile_scenenames`         | `\|`-delimited list of original release names for each episode file                          |
| `sonarr_download_client`                | Download client                                                                              |
| `sonarr_download_client_type`           | Download client type                                                                         |
| `sonarr_download_id`                    | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `sonarr_release_group`                  | Release group of the import                                                                  |
| `sonarr_release_quality`                | Quality name of the release                                                                  |
| `sonarr_release_qualityversion`         | Quality version of the release                                                               |
| `sonarr_release_indexer`                | Indexer from which the release was grabbed                                                   |
| `sonarr_release_size`                   | Size of the release, as reported by the indexer (in bytes)                                   |
| `sonarr_release_title`                  | Torrent/NZB title                                                                            |
| `sonarr_release_releasetype`            | Release type (`SingleEpisode`, `SeasonPack`)                                                 |
| `sonarr_sourcepath`                     | Full path to the source of the import                                                        |
| `sonarr_sourcefolder`                   | Full path to the folder containing the source of the import                                  |
| `sonarr_destinationpath`                | Full path to the destination of the import                                                   |
| `sonarr_destinationfolder`              | Full path to the destination folder of the import                                            |

## On Rename

| Environment Variable                      | Details                                                      |
| ----------------------------------------- | ------------------------------------------------------------ |
| `sonarr_eventtype`                        | `Rename`                                                     |
| `sonarr_instancename`                     | Instance name of the Sonarr installation                     |
| `sonarr_applicationurl`                   | URL of the Sonarr application                                |
| `sonarr_series_id`                        | Internal ID of the series                                    |
| `sonarr_series_title`                     | Title of the series                                          |
| `sonarr_series_titleslug`                 | Common formatted title slug of the series                    |
| `sonarr_series_path`                      | Full path to the series                                      |
| `sonarr_series_tvdbid`                    | TVDB ID for the series                                       |
| `sonarr_series_tvmazeid`                  | TVMaze ID for the series                                     |
| `sonarr_series_tmdbid`                    | TMDB ID for the series                                       |
| `sonarr_series_imdbid`                    | IMDB ID for the series (empty if unknown)                    |
| `sonarr_series_type`                      | Type of the series (`Anime`, `Daily`, or `Standard`)         |
| `sonarr_series_year`                      | Year of the series                                           |
| `sonarr_series_originallanguage`          | Original language of the series                              |
| `sonarr_series_genres`                    | `\|`-delimited list of genres                                |
| `sonarr_series_tags`                      | `\|`-delimited list of tags                                  |
| `sonarr_episodefile_ids`                  | Comma-delimited list of internal IDs of the renamed files    |
| `sonarr_episodefile_relativepaths`        | `\|`-delimited list of new relative paths of renamed files   |
| `sonarr_episodefile_paths`                | `\|`-delimited list of new full paths of renamed files       |
| `sonarr_episodefile_previousrelativepaths`| `\|`-delimited list of old relative paths of renamed files   |
| `sonarr_episodefile_previouspaths`        | `\|`-delimited list of old full paths of renamed files       |

## On Episode File Delete

| Environment Variable                    | Details                                                                          |
| --------------------------------------- | -------------------------------------------------------------------------------- |
| `sonarr_eventtype`                      | `EpisodeFileDelete`                                                              |
| `sonarr_instancename`                   | Instance name of the Sonarr installation                                         |
| `sonarr_applicationurl`                 | URL of the Sonarr application                                                    |
| `sonarr_episodefile_deletereason`       | Reason for the deletion (`MissingFromDisk`, `Manual`, `Upgrade`, `NoLinkedEpisodes`) |
| `sonarr_series_id`                      | Internal ID of the series                                                        |
| `sonarr_series_title`                   | Title of the series                                                              |
| `sonarr_series_titleslug`               | Common formatted title slug of the series                                        |
| `sonarr_series_path`                    | Full path to the series                                                          |
| `sonarr_series_tvdbid`                  | TVDB ID for the series                                                           |
| `sonarr_series_tvmazeid`                | TVMaze ID for the series                                                         |
| `sonarr_series_tmdbid`                  | TMDB ID for the series                                                           |
| `sonarr_series_imdbid`                  | IMDB ID for the series (empty if unknown)                                        |
| `sonarr_series_type`                    | Type of the series (`Anime`, `Daily`, or `Standard`)                             |
| `sonarr_series_year`                    | Year of the series                                                               |
| `sonarr_series_originallanguage`        | Original language of the series                                                  |
| `sonarr_series_genres`                  | `\|`-delimited list of genres                                                    |
| `sonarr_series_tags`                    | `\|`-delimited list of tags                                                      |
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
| `sonarr_episodefile_episodeoverviews`   | `\|`-delimited list of episode overview descriptions                             |
| `sonarr_episodefile_quality`            | Quality name of the episode file, as detected by Sonarr                          |
| `sonarr_episodefile_qualityversion`     | `1` is the default, `2` is for proper, and `3`+ could be used for anime versions |
| `sonarr_episodefile_releasegroup`       | Release group (empty if unknown)                                                 |
| `sonarr_episodefile_scenename`          | Original release name (empty if unknown)                                         |

## On Series Add

| Environment Variable             | Details                                                      |
| -------------------------------- | ------------------------------------------------------------ |
| `sonarr_eventtype`               | `SeriesAdd`                                                  |
| `sonarr_instancename`            | Instance name of the Sonarr installation                     |
| `sonarr_applicationurl`          | URL of the Sonarr application                                |
| `sonarr_series_id`               | Internal ID of the series                                    |
| `sonarr_series_title`            | Title of the series                                          |
| `sonarr_series_titleslug`        | Common formatted title slug of the series                    |
| `sonarr_series_path`             | Full path to the series                                      |
| `sonarr_series_tvdbid`           | TVDB ID for the series                                       |
| `sonarr_series_tvmazeid`         | TVMaze ID for the series                                     |
| `sonarr_series_tmdbid`           | TMDB ID for the series                                       |
| `sonarr_series_imdbid`           | IMDB ID for the series (empty if unknown)                    |
| `sonarr_series_type`             | Type of the series (`Anime`, `Daily`, or `Standard`)         |
| `sonarr_series_year`             | Year of the series                                           |
| `sonarr_series_originallanguage` | Original language of the series                              |
| `sonarr_series_genres`           | `\|`-delimited list of genres                                |
| `sonarr_series_tags`             | `\|`-delimited list of tags                                  |

## On Series Delete

| Environment Variable             | Details                                                                  |
| -------------------------------- | ------------------------------------------------------------------------ |
| `sonarr_eventtype`               | `SeriesDelete`                                                           |
| `sonarr_instancename`            | Instance name of the Sonarr installation                                 |
| `sonarr_applicationurl`          | URL of the Sonarr application                                            |
| `sonarr_series_id`               | Internal ID of the series                                                |
| `sonarr_series_title`            | Title of the series                                                      |
| `sonarr_series_titleslug`        | Common formatted title slug of the series                                |
| `sonarr_series_path`             | Full path to the series                                                  |
| `sonarr_series_tvdbid`           | TVDB ID for the series                                                   |
| `sonarr_series_tvmazeid`         | TVMaze ID for the series                                                 |
| `sonarr_series_tmdbid`           | TMDB ID for the series                                                   |
| `sonarr_series_imdbid`           | IMDB ID for the series (empty if unknown)                                |
| `sonarr_series_type`             | Type of the series (`Anime`, `Daily`, or `Standard`)                     |
| `sonarr_series_year`             | Year of the series                                                       |
| `sonarr_series_originallanguage` | Original language of the series                                          |
| `sonarr_series_genres`           | `\|`-delimited list of genres                                            |
| `sonarr_series_tags`             | `\|`-delimited list of tags                                              |
| `sonarr_series_deletedfiles`     | `True` when the delete files option has been selected, otherwise `False` |

## On Health Issue

| Environment Variable          | Details                                                      |
| ----------------------------- | ------------------------------------------------------------ |
| `sonarr_eventtype`            | `HealthIssue`                                                |
| `sonarr_instancename`         | Instance name of the Sonarr installation                     |
| `sonarr_applicationurl`       | URL of the Sonarr application                                |
| `sonarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `sonarr_health_issue_message` | Message from the health issue                                |
| `sonarr_health_issue_type`    | Area that failed and triggered the health issue              |
| `sonarr_health_issue_wiki`    | Wiki URL (empty if does not exist)                           |

## On Health Restored

| Environment Variable              | Details                                                      |
| --------------------------------- | ------------------------------------------------------------ |
| `sonarr_eventtype`                | `HealthRestored`                                             |
| `sonarr_instancename`             | Instance name of the Sonarr installation                     |
| `sonarr_applicationurl`           | URL of the Sonarr application                                |
| `sonarr_health_restored_level`    | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `sonarr_health_restored_message`  | Message from the health issue                                |
| `sonarr_health_restored_type`     | Area that previously failed and triggered the health issue   |
| `sonarr_health_restored_wiki`     | Wiki URL (empty if does not exist)                           |

## On Application Update

| Environment Variable            | Details                              |
| ------------------------------- | ------------------------------------ |
| `sonarr_eventtype`              | `ApplicationUpdate`                  |
| `sonarr_instancename`           | Instance name of the Sonarr installation |
| `sonarr_applicationurl`         | URL of the Sonarr application        |
| `sonarr_update_message`         | Message from Update                  |
| `sonarr_update_newversion`      | Version Sonarr updated to (string)   |
| `sonarr_update_previousversion` | Version Sonarr updated from (string) |

## On Manual Interaction Required

| Environment Variable             | Details                                                                                      |
| -------------------------------- | -------------------------------------------------------------------------------------------- |
| `sonarr_eventtype`               | `ManualInteractionRequired`                                                                  |
| `sonarr_instancename`            | Instance name of the Sonarr installation                                                     |
| `sonarr_applicationurl`          | URL of the application                                                                       |
| `sonarr_series_id`               | Internal ID of the series                                                                    |
| `sonarr_series_title`            | Title of the series                                                                          |
| `sonarr_series_titleslug`        | Common formatted title slug of the series                                                    |
| `sonarr_series_path`             | Full path to the series                                                                      |
| `sonarr_series_tvdbid`           | TVDB ID of the series                                                                        |
| `sonarr_series_tvmazeid`         | TVMaze ID of the series                                                                      |
| `sonarr_series_tmdbid`           | TMDB ID of the series                                                                        |
| `sonarr_series_imdbid`           | IMDB ID of the series (empty if unknown)                                                     |
| `sonarr_series_type`             | Type of the series (`Anime`, `Daily`, or `Standard`)                                         |
| `sonarr_series_year`             | Year of the series                                                                           |
| `sonarr_series_originallanguage` | Original language of the series                                                              |
| `sonarr_series_genres`           | Genres of the series                                                                         |
| `sonarr_series_tags`             | Tags of the series                                                                           |
| `sonarr_download_client`         | Download client name                                                                         |
| `sonarr_download_client_type`    | Download client type                                                                         |
| `sonarr_download_id`             | Hash of the torrent/NZB file (used to uniquely identify the download in the download client) |
| `sonarr_download_size`           | Download size                                                                                |
| `sonarr_download_title`          | Download title                                                                               |

## On Test

When adding the script to Sonarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `sonarr_eventtype`   | `Test`  |
| `sonarr_instancename` | Instance name of the Sonarr installation |
| `sonarr_applicationurl` | URL of the Sonarr application |
