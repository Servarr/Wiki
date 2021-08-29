---
title: Lidarr Settings
description: 
published: true
date: 2021-08-15T01:10:44.868Z
tags: lidarr, needs-love, settings
editor: markdown
dateCreated: 2021-06-14T21:36:07.513Z
---

## Settings

This page is a work in progress.

## Connections

This section lists the values that can be used for a custom on-event script, if you want to be able to perform some work outside of Lidarr.

> Testing will execute the script with the `EventType` set to `Test`, ensure your script handles this correctly!
{.is-warning}

OnGrab

- Lidarr_EventType => "Grab"
- Lidarr_Artist_Id => artist.Id.ToString()
- Lidarr_Artist_Name => artist.Metadata.Value.Name
- Lidarr_Artist_MBId => artist.Metadata.Value.ForeignArtistId
- Lidarr_Artist_Type => artist.Metadata.Value.Type
- Lidarr_Release_AlbumCount => remoteAlbum.Albums.Count.ToString()
- Lidarr_Release_AlbumReleaseDates => string.Join(", => remoteAlbum.Albums.Select(e => e.ReleaseDate))
- Lidarr_Release_AlbumTitles => string.Join("| => remoteAlbum.Albums.Select(e => e.Title))
- Lidarr_Release_AlbumMBIds => string.Join("| => remoteAlbum.Albums.Select(e => e.ForeignAlbumId))
- Lidarr_Release_Title => remoteAlbum.Release.Title
- Lidarr_Release_Indexer => remoteAlbum.Release.Indexer ?? string.Empty
- Lidarr_Release_Size => remoteAlbum.Release.Size.ToString()
- Lidarr_Release_Quality => remoteAlbum.ParsedAlbumInfo.Quality.Quality.Name
- Lidarr_Release_QualityVersion => remoteAlbum.ParsedAlbumInfo.Quality.Revision.Version.ToString()
- Lidarr_Release_ReleaseGroup => releaseGroup ?? string.Empty
- Lidarr_Download_Client => message.DownloadClient ?? string.Empty
- Lidarr_Download_Id => message.DownloadId ?? string.Empty

OnReleaseImport

- Lidarr_EventType => "AlbumDownload"
- Lidarr_Artist_Id => artist.Id.ToString()
- Lidarr_Artist_Name => artist.Metadata.Value.Name
- Lidarr_Artist_Path => artist.Path
- Lidarr_Artist_MBId => artist.Metadata.Value.ForeignArtistId
- Lidarr_Artist_Type => artist.Metadata.Value.Type
- Lidarr_Album_Id => album.Id.ToString()
- Lidarr_Album_Title => album.Title
- Lidarr_Album_MBId => album.ForeignAlbumId
- Lidarr_AlbumRelease_MBId => release.ForeignReleaseId
- Lidarr_Album_ReleaseDate => album.ReleaseDate.ToString()
- Lidarr_Download_Client => message.DownloadClient ?? string.Empty
- Lidarr_Download_Id => message.DownloadId ?? string.Empty
- Lidarr_AddedTrackPaths => string.Join("| => message.TrackFiles.Select(e => e.Path))
- Lidarr_DeletedPaths => string.Join("| => message.OldFiles.Select(e => e.Path))

OnRename

- Lidarr_EventType => "Rename"
- Lidarr_Artist_Id => artist.Id.ToString()
- Lidarr_Artist_Name => artist.Metadata.Value.Name
- Lidarr_Artist_Path => artist.Path
- Lidarr_Artist_MBId => artist.Metadata.Value.ForeignArtistId
- Lidarr_Artist_Type => artist.Metadata.Value.Type

OnTrackRetag

- Lidarr_EventType => "TrackRetag"
- Lidarr_Artist_Id => artist.Id.ToString()
- Lidarr_Artist_Name => artist.Metadata.Value.Name
- Lidarr_Artist_Path => artist.Path
- Lidarr_Artist_MBId => artist.Metadata.Value.ForeignArtistId
- Lidarr_Artist_Type => artist.Metadata.Value.Type
- Lidarr_Album_Id => album.Id.ToString()
- Lidarr_Album_Title => album.Title
- Lidarr_Album_MBId => album.ForeignAlbumId
- Lidarr_AlbumRelease_MBId => release.ForeignReleaseId
- Lidarr_Album_ReleaseDate => album.ReleaseDate.ToString()
- Lidarr_TrackFile_Id => trackFile.Id.ToString()
- Lidarr_TrackFile_TrackCount => trackFile.Tracks.Value.Count.ToString()
- Lidarr_TrackFile_Path => trackFile.Path
- Lidarr_TrackFile_TrackNumbers => string.Join(", => trackFile.Tracks.Value.Select(e => e.TrackNumber))
- Lidarr_TrackFile_TrackTitles => string.Join("| => trackFile.Tracks.Value.Select(e => e.Title))
- Lidarr_TrackFile_Quality => trackFile.Quality.Quality.Name
- Lidarr_TrackFile_QualityVersion => trackFile.Quality.Revision.Version.ToString()
- Lidarr_TrackFile_ReleaseGroup => trackFile.ReleaseGroup ?? string.Empty
- Lidarr_TrackFile_SceneName => trackFile.SceneName ?? string.Empty
- Lidarr_Tags_Diff => message.Diff.ToJson()
- Lidarr_Tags_Scrubbed => message.Scrubbed.ToString()

OnHealthIssue

- Lidarr_EventType => "HealthIssue"
- Lidarr_Health_Issue_Level => nameof(healthCheck.Type)
- Lidarr_Health_Issue_Message => healthCheck.Message
- Lidarr_Health_Issue_Type => healthCheck.Source.Name
- Lidarr_Health_Issue_Wiki => healthCheck.WikiUrl.ToString() ?? string.Empty

## General

### Updates

### Updates

- (Advanced Option) Branch - This is the branch of Lidarr that you are running on.
  - [Please see this FAQ entry for more information](/lidarr/faq#how-do-i-update-lidarr)
- Automatic - Automatically download and install updates. You will still be able to install from System: Updates. Note: Windows Users are always automatically updated.
- Mechanism - Use Lidarr built-in updater or a script
  - Built-in - Use Lidarr's own updater
  - Script - Have Lidarr run the update script
  - Docker - Do not update Lidarr from inside the Docker, instead pull a brand new image with the new update
- Script - Visible only when Mechanism is set to Script - Path to update script
- Update Process - Lidarr will download the update file, verify its integrity and extract it to a temporary location and call the chosen method. The update process will be be run under the same user that Lidarr is run under, it will need permissions to update the Lidarr files as well as stop/start Lidarr.
- Built-in - The built-in method will backup Lidarr files and settings, stop Lidarr, update the installation and Start Lidarr, if your system will not handle the stopping of Lidarr and will attempt to restart it automatically it may be best to use a script instead. In the event of failure the previous version of Lidarr will be restarted.
- Script - The script should handle the the same as the built-in updater, if you need to handle stopping and starting services (upstart/launchd/etc) you will need to do that here.
