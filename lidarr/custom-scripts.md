---
title: Lidarr Custom Scripts
description: 
published: true
date: 2021-10-09T00:05:40.648Z
tags: lidarr, needs-love, custom scripts
editor: markdown
dateCreated: 2021-06-23T06:41:39.234Z
---

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Lidarr via the [Connect Settings](/lidarr/settings#connections).

## Overview

Lidarr can execute a custom script.

## Environment Variables

> [The below table needs cleanup and organizing. View the source code here](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/Notifications/CustomScript/CustomScript.cs)
{.is-info}

| Environment Variable              | Details                                                               |
|---------------------------------- |---------------------------------------------------------------------- |
| Lidarr_EventType                  | Grab                                                                  |
| Lidarr_Artist_Id                  | artist.Id.ToString())                                                 |
| Lidarr_Artist_Name                | artist.Metadata.Value.Name)                                           |
| Lidarr_Artist_MBId                | artist.Metadata.Value.ForeignArtistId)                                |
| Lidarr_Artist_Type                | artist.Metadata.Value.Type)                                           |
| Lidarr_Release_AlbumCount         | remoteAlbum.Albums.Count.ToString())                                  |
| Lidarr_Release_AlbumReleaseDates  | string.Join(",", remoteAlbum.Albums.Select(e => e.ReleaseDate)))      |
| Lidarr_Release_AlbumTitles        | string.Join("", remoteAlbum.Albums.Select(e => e.Title)))             |
| Lidarr_Release_AlbumMBIds         | string.Join("", remoteAlbum.Albums.Select(e => e.ForeignAlbumId)))    |
| Lidarr_Release_Title              | remoteAlbum.Release.Title)                                            |
| Lidarr_Release_Indexer            | remoteAlbum.Release.Indexer                                           |
| Lidarr_Release_Size               | remoteAlbum.Release.Size.ToString())                                  |
| Lidarr_Release_Quality            | remoteAlbum.ParsedAlbumInfo.Quality.Quality.Name)                     |
| Lidarr_Release_QualityVersion     | remoteAlbum.ParsedAlbumInfo.Quality.Revision.Version.ToString())      |
| Lidarr_Release_ReleaseGroup       | releaseGroup                                                          |
| Lidarr_Download_Client            | message.DownloadClient                                                |
| Lidarr_Download_Id                | message.DownloadId                                                    |
| Lidarr_EventType                  | AlbumDownload                                                         |
| Lidarr_Artist_Id                  | artist.Id.ToString())                                                 |
| Lidarr_Artist_Name                | artist.Metadata.Value.Name)                                           |
| Lidarr_Artist_Path                | artist.Path)                                                          |
| Lidarr_Artist_MBId                | artist.Metadata.Value.ForeignArtistId)                                |
| Lidarr_Artist_Type                | artist.Metadata.Value.Type)                                           |
| Lidarr_Album_Id                   | album.Id.ToString())                                                  |
| Lidarr_Album_Title                | album.Title)                                                          |
| Lidarr_Album_MBId                 | album.ForeignAlbumId)                                                 |
| Lidarr_AlbumRelease_MBId          | release.ForeignReleaseId)                                             |
| Lidarr_Album_ReleaseDate          | album.ReleaseDate.ToString())                                         |
| Lidarr_Download_Client            | message.DownloadClient                                                |
| Lidarr_Download_Id                | message.DownloadId                                                    |
| Lidarr_AddedTrackPaths            | string.Join("", message.TrackFiles.Select(e => e.Path)))              |
| Lidarr_DeletedPaths               | string.Join("", message.OldFiles.Select(e => e.Path)))                |
| Lidarr_EventType                  | Rename                                                                |
| Lidarr_Artist_Id                  | artist.Id.ToString())                                                 |
| Lidarr_Artist_Name                | artist.Metadata.Value.Name)                                           |
| Lidarr_Artist_Path                | artist.Path)                                                          |
| Lidarr_Artist_MBId                | artist.Metadata.Value.ForeignArtistId)                                |
| Lidarr_Artist_Type                | artist.Metadata.Value.Type)                                           |
| Lidarr_EventType                  | TrackRetag                                                            |
| Lidarr_Artist_Id                  | artist.Id.ToString())                                                 |
| Lidarr_Artist_Name                | artist.Metadata.Value.Name)                                           |
| Lidarr_Artist_Path                | artist.Path)                                                          |
| Lidarr_Artist_MBId                | artist.Metadata.Value.ForeignArtistId)                                |
| Lidarr_Artist_Type                | artist.Metadata.Value.Type)                                           |
| Lidarr_Album_Id                   | album.Id.ToString())                                                  |
| Lidarr_Album_Title                | album.Title)                                                          |
| Lidarr_Album_MBId                 | album.ForeignAlbumId)                                                 |
| Lidarr_AlbumRelease_MBId          | release.ForeignReleaseId)                                             |
| Lidarr_Album_ReleaseDate          | album.ReleaseDate.ToString())                                         |
| Lidarr_TrackFile_Id               | trackFile.Id.ToString())                                              |
| Lidarr_TrackFile_TrackCount       | trackFile.Tracks.Value.Count.ToString())                              |
| Lidarr_TrackFile_Path             | trackFile.Path)                                                       |
| Lidarr_TrackFile_TrackNumbers     | string.Join(",", trackFile.Tracks.Value.Select(e => e.TrackNumber)))  |
| Lidarr_TrackFile_TrackTitles      | string.Join("", trackFile.Tracks.Value.Select(e => e.Title)))         |
| Lidarr_TrackFile_Quality          | trackFile.Quality.Quality.Name)                                       |
| Lidarr_TrackFile_QualityVersion   | trackFile.Quality.Revision.Version.ToString())                        |
| Lidarr_TrackFile_ReleaseGroup     | trackFile.ReleaseGroup                                                |
| Lidarr_TrackFile_SceneName        | trackFile.SceneName                                                   |
| Lidarr_Tags_Diff                  | message.Diff.ToJson())                                                |
| Lidarr_Tags_Scrubbed              | message.Scrubbed.ToString())                                          |
| Lidarr_EventType                  | HealthIssue                                                           |
| Lidarr_Health_Issue_Level         | nameof(healthCheck.Type))                                             |
| Lidarr_Health_Issue_Message       | healthCheck.Message)                                                  |
| Lidarr_Health_Issue_Type          | healthCheck.Source.Name)                                              |
| Lidarr_Health_Issue_Wiki          | healthCheck.WikiUrl.ToString()                                        |
| Lidarr_EventType                  | Test                                                                  |
