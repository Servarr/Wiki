---
title: Lidarr Custom Scripts
description: Guide for creating and implementing custom scripts for automation and integration in Lidarr
published: true
date: 2023-04-09T23:23:38.475Z
tags: lidarr, scripts, automation, custom, integration, hooks, api
editor: markdown
dateCreated: 2021-11-24T19:22:09.331Z
---

If you're looking to trigger a custom script, you can find more details on this page. Scripts are added to Lidarr via the [Connect Settings](/lidarr/settings#connections).

# Overview

Lidarr can execute a custom script when an episode is newly imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

A custom script can be any executable accessible by the user Lidarr is running as.

## Lidarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug` in config/logs/Lidarr.debug.txt
- Script `stderr` output will be logged as `Info`  in config/logs/Lidarr.txt
- The trigger of the script will be logged in `Trace` in config/logs/Lidarr.trace.txt

# Environment Variables

Environment Variables vary based on the event type. The sections below indicate the variables available for each.

> [The sections below need cleanup, organizing, and details enhanced. View the source code here](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/Notifications/CustomScript/CustomScript.cs)
{.is-info}

## Grab

| Environment Variable               | Details                                                              |
| ---------------------------------- | -------------------------------------------------------------------- |
| `lidarr_eventtype`                 | Grab                                                                 |
| `lidarr_artist_id`                 | `artist.Id`                                                          |
| `lidarr_artist_name`               | `artist.Metadata.Value.Name`                                         |
| `lidarr_artist_mbid`               | `artist.Metadata.Value.ForeignArtistId`                              |
| `lidarr_artist_type`               | `artist.Metadata.Value.Type`                                         |
| `lidarr_release_albumcount`        | `remoteAlbum.Albums.Count`                                           |
| `lidarr_release_albumreleasedates` | Comma separated list of album release dates                          |
| `lidarr_release_albumtitles`       | Pipe separated list of album titles                                  |
| `lidarr_release_albummbids`        | Pipe separated list of album external service IDs (e.g. MusicBrainz) |
| `lidarr_release_title`             | `remoteAlbum.Release.Title`                                          |
| `lidarr_release_indexer`           | `remoteAlbum.Release.Indexer`                                        |
| `lidarr_release_size`              | `remoteAlbum.Release.Size`                                           |
| `lidarr_release_quality`           | `remoteAlbum.ParsedAlbumInfo.Quality.Quality.Name`                   |
| `lidarr_release_qualityversion`    | `remoteAlbum.ParsedAlbumInfo.Quality.Revision.Version`               |
| `lidarr_release_releasegroup`      | `releaseGroup`                                                       |
| `lidarr_download_client`           | `message.DownloadClient`                                             |
| `lidarr_download_id`               | `message.DownloadId`                                                 |

## On Import / On Upgrade

| Environment Variable       | Details                                  |
| -------------------------- | ---------------------------------------- |
| `lidarr_eventtype`         | AlbumDownload                            |
| `lidarr_artist_id`         | `artist.Id`                              |
| `lidarr_artist_name`       | `artist.Metadata.Value.Name`             |
| `lidarr_artist_path`       | `artist.Path`                            |
| `lidarr_artist_mbid`       | `artist.Metadata.Value.ForeignArtistId`  |
| `lidarr_artist_type`       | `artist.Metadata.Value.Type`             |
| `lidarr_album_id`          | `album.Id`                               |
| `lidarr_album_title`       | `album.Title`                            |
| `lidarr_album_mbid`        | `album.ForeignAlbumId`                   |
| `lidarr_albumrelease_mbid` | `release.ForeignReleaseId`               |
| `lidarr_album_releasedate` | `album.ReleaseDate`                      |
| `lidarr_download_client`   | `message.DownloadClient`                 |
| `lidarr_download_id`       | `message.DownloadId`                     |
| `lidarr_addedtrackpaths`   | Pipe separated list of added track paths |
| `lidarr_deletedpaths`      | Pipe separated list of deleted files     |

## Rename

| Environment Variable | Details                                 |
| -------------------- | --------------------------------------- |
| `lidarr_eventtype`   | Rename                                  |
| `lidarr_artist_id`   | `artist.Id`                             |
| `lidarr_artist_name` | `artist.Metadata.Value.Name`            |
| `lidarr_artist_path` | `artist.Path`                           |
| `lidarr_artist_mbid` | `artist.Metadata.Value.ForeignArtistId` |
| `lidarr_artist_type` | `artist.Metadata.Value.Type`            |

## Track Retag

| Environment Variable              | Details                                 |
| --------------------------------- | --------------------------------------- |
| `lidarr_eventtype`                | TrackRetag                              |
| `lidarr_artist_id`                | `artist.Id`                             |
| `lidarr_artist_name`              | `artist.Metadata.Value.Name`            |
| `lidarr_artist_path`              | `artist.Path`                           |
| `lidarr_artist_mbid`              | `artist.Metadata.Value.ForeignArtistId` |
| `lidarr_artist_type`              | `artist.Metadata.Value.Type`            |
| `lidarr_album_id`                 | `album.Id`                              |
| `lidarr_album_title`              | `album.Title`                           |
| `lidarr_album_mbid`               | `album.ForeignAlbumId`                  |
| `lidarr_albumrelease_mbid`        | `release.ForeignReleaseId`              |
| `lidarr_album_releasedate`        | `album.ReleaseDate`                     |
| `lidarr_trackfile_id`             | `trackFile.Id`                          |
| `lidarr_trackfile_trackcount`     | `trackFile.Tracks.Value.Count`          |
| `lidarr_trackfile_path`           | `trackFile.Path`                        |
| `lidarr_trackfile_tracknumbers`   | Comma separated list of track numbers   |
| `lidarr_trackfile_tracktitles`    | Pipe separated list of track titles     |
| `lidarr_trackfile_quality`        | `trackFile.Quality.Quality.Name`        |
| `lidarr_trackfile_qualityversion` | `trackFile.Quality.Revision.Version`    |
| `lidarr_trackfile_releasegroup`   | `trackFile.ReleaseGroup`                |
| `lidarr_trackfile_scenename`      | `trackFile.SceneName`                   |
| `lidarr_tags_diff`                | `message.Diff.ToJson()`                 |
| `lidarr_tags_scrubbed`            | `message.Scrubbed`                      |

## Health Issue

| Environment Variable          | Details                                 |
| ----------------------------- | --------------------------------------- |
| `lidarr_eventtype`            | HealthIssue                             |
| `lidarr_health_issue_level`   | `nameof(healthCheck.Type)`              |
| `lidarr_health_issue_message` | `healthCheck.Message`                   |
| `lidarr_health_issue_type`    | `healthCheck.Source.Name`               |
| `lidarr_health_issue_wiki`    | Wiki URL for the health issue help page |

## On Test

When adding the script to Lidarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `lidarr_eventtype`   | Test    |
