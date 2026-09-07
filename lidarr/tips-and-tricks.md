---
title: Lidarr Tips and Tricks
description: Advanced tips, optimization techniques, and workflow improvements for experienced Lidarr users
published: true
date: 2026-07-02T16:57:06.791Z
tags: lidarr, tips, tricks, optimization, workflow, advanced, advanced tips
editor: markdown
dateCreated: 2021-08-14T15:15:51.656Z
---

# Lidarr Tips and Tricks

Recipes and workarounds for things that come up often enough to be worth documenting, but don't fit the install / troubleshoot / FAQ shape. Most of this is library-management content: filling in gaps in metadata, bulk-editing the library, and backup/restore hygiene.

For setup recipes (reverse proxy, VPN, Docker compose, hardlinks) see the [TRaSH Guides](https://trash-guides.info/) — they cover those topics in more depth than this wiki does.

## Folder structure

### Separating download folders from your library

Your download folder and music library root folder can't be the same location. Mixing them causes imports to fail or loop — Lidarr can't tell a finished download from something already in the library.

Keep two locations separate:

```text
/data/
  downloads/          ← download client writes here
  music/              ← Lidarr root folder (your library)
```

On import, Lidarr moves (or hardlinks) files from `downloads/` into `music/`. The copy in `downloads/` stays owned by the download client. The copy in `music/` is what Lidarr manages.

> For hardlinks to work — which avoids any extra disk space during import — both paths must be on the same physical filesystem. If `downloads/` and `music/` are on different drives or volumes, Lidarr will copy instead of hardlink. See [Concepts → Hardlinks and completed downloads](/lidarr/concepts#hardlinks-and-completed-downloads).
{.is-info}

### Multiple download clients

If you're running more than one download client — say, a Usenet client alongside a torrent client — give each its own subfolder under `downloads/` and set a matching category in Lidarr:

```text
/data/
  downloads/
    usenet/           ← SABnzbd / NZBGet category: "lidarr"
    torrents/         ← qBittorrent / Deluge category: "lidarr"
  music/
```

In **Settings → Download Clients**, set each client's **Category** to a unique value (for example, `lidarr`) and make sure the download client itself uses the same category name. Lidarr only watches items in the configured category — anything outside it's invisible. This keeps clients from stepping on each other and prevents apps that share a client from grabbing each other's downloads.

> Radarr, Sonarr, and Lidarr can share the same download client as long as each application uses a different category. Never point two applications at the same category — they will fight over each other's downloads.
{.is-info}

> **Why `downloads/` instead of TRaSH's flat layout?** TRaSH Guides places `torrents/` and `usenet/` as peer directories next to `media/` at the top level. This layout groups them under a single `downloads/` parent instead. The reason is that Lidarr's ecosystem tends to involve more download sources than just torrents and Usenet — slskd, deemix, manual imports, and others are all common additions. Grouping them keeps the top level clean as that list grows. The TRaSH principle that actually matters — keeping everything under one filesystem root so hardlinks work — hasn't changed. See [this r/Lidarr post](https://www.reddit.com/r/Lidarr/comments/1sm8jb8/path_structure_for_multiple_download_clients_in/) for a fuller breakdown.
{.is-info}

### Remote path mapping

When Lidarr and your download client run in separate containers or machines, the path the client reports may not match what Lidarr sees. Use **Settings → Download Clients → Remote Path Mappings** to translate between the two. See [Troubleshooting → Remote Path Mapping](/lidarr/troubleshooting#remote-path-mapping) for the full explanation.

## Library maintenance

### Missing artist images

Lidarr doesn't reach out to any image service directly. Artist images come through the Servarr metadata server, which looks each artist up by MusicBrainz ID against two providers, in order:

1. **fanart.tv** — queried first, for all of banner, fanart (background), logo, and poster art.
2. **TheAudioDB** — used only to fill in whichever of those four image types fanart.tv didn't have. It never overrides a fanart.tv result.

MusicBrainz itself isn't in this path. An artist can have a complete MusicBrainz entry and still show no image in Lidarr if neither fanart.tv nor TheAudioDB has artwork for that MBID.

If an artist is showing no image or a wrong image:

1. Check the artist's page on [fanart.tv](https://fanart.tv/) and [TheAudioDB](https://www.theaudiodb.com/) directly. If neither has artwork for that artist, there's nothing for the metadata server to serve, and nothing for Lidarr to render. Both sites accept community-submitted artwork if you want to fix it at the source.
2. Wait for the metadata refresh to propagate. Lidarr's copy of metadata refreshes hourly from the Servarr metadata server; the metadata server's own cache of fanart.tv / TheAudioDB results has its own propagation window measured in hours, sometimes longer.
3. Trigger an artist refresh in Lidarr once you believe upstream has updated (Artist page → Refresh button, or Library → Artist Editor → Update).

> Lidarr has no "upload an image locally" option. Everything it displays has to exist upstream at fanart.tv or TheAudioDB — uploading art to MusicBrainz's Cover Art Archive won't fix a missing artist image, since that only feeds album cover art (see [Missing album images](#missing-album-images) below).
{.is-info}

### Missing album images

{#missing-album-images}

Lidarr pulls album cover art from MusicBrainz's [Cover Art Archive](https://coverartarchive.org/) via the Servarr metadata server.

1. Open the release group on MusicBrainz and check whether cover art is present in the Cover Art Archive.
2. If not, you can upload a cover yourself — MusicBrainz has a [Cover Art guideline](https://musicbrainz.org/doc/Cover_Art) covering acceptable sources and quality.
3. After upload, allow an hour for the metadata server cache to pick it up, then refresh the album in Lidarr.

Lidarr picks up covers uploaded directly to the Cover Art Archive faster than other metadata corrections. CAA has a more direct path into the metadata server than MusicBrainz entity data does.

### Mass delete artists

Use **Library → Artist Editor** (formerly "Mass Editor"):

1. Select the artists to remove (Shift-click for ranges; Ctrl/Cmd-click for individual additions).
2. Click **Delete** at the bottom of the screen.
3. Choose whether to also delete files on disk.
   - *Remove from Lidarr only* keeps your files; use this when you added the artist by mistake but want to keep the music.
   - *Remove from Lidarr and delete files* is destructive and irreversible. Make sure you have a backup first if in doubt.

The same flow works for bulk changes that aren't deletion — root folder moves, quality profile swaps, monitoring toggles — via the other bulk-action buttons at the bottom of Artist Editor.

### Renaming or moving files outside Lidarr

{#renaming-moving-outside-lidarr}

Lidarr tracks every managed file by its absolute path. That path is stored in the `TrackFile` table in `lidarr.db`. There is no content hash, inode, or fingerprint involved in ongoing tracking after import -- the path is the only handle Lidarr has on a file.

When you rename or move a file or folder at the OS level, Lidarr does not learn about it. The database still points to the old path. The next time Lidarr scans that folder -- whether triggered manually, by a refresh, or by the scheduled daily rescan -- `DiskScanService` walks the directory tree and passes the list of files on disk to `MediaFileTableCleanupService.Clean()`. That method compares the database records against the files it found:

```csharp
// src/NzbDrone.Core/MediaFiles/MediaFileTableCleanupService.cs
var missingFiles = dbFiles.ExceptBy(x => x.Path, filesOnDisk, x => x, PathEqualityComparer.Instance).ToList();

_mediaFileService.DeleteMany(missingFiles, DeleteMediaFileReason.MissingFromDisk);

var orphanedTracks = _trackService.GetTracksByFileId(missingFiles.Select(x => x.Id));
orphanedTracks.ForEach(x => x.TrackFileId = 0);
_trackService.SetFileIds(orphanedTracks);
```

Anything at the old path is gone from the database. The tracks that referenced those files have their `TrackFileId` reset to zero, which means they are now unmatched. From Lidarr's perspective, those tracks are missing and unimported.

If the album is monitored and Lidarr finds a release for it during an RSS sync, `DeletedTrackFileSpecification` checks whether track files that exist in the database are present on disk. If **Unmonitor Deleted Tracks** is enabled in **Settings → Media Management**, Lidarr treats the absence as a deletion and skips the release until the next disk scan clears the stale records. After that scan, the tracks appear missing and Lidarr may queue a search for them:

```csharp
// src/NzbDrone.Core/DecisionEngine/Specifications/RssSync/DeletedTrackFileSpecification.cs
_logger.Debug("Files for this album exist in the database but not on disk, will be unmonitored on next diskscan. skipping.");
return Decision.Reject("Artist is not monitored");
```

The result is that an external rename can cause Lidarr to re-download content you already have.

#### What Lidarr does internally

When you rename through the Lidarr UI, `RenameTrackFileService` calls `TrackFileMovingService.MoveTrackFile()`, which moves the file on disk and immediately updates the database path:

```csharp
// src/NzbDrone.Core/MediaFiles/TrackFileMovingService.cs
trackFile.Path = destinationFilePath;
```

`_mediaFileService.Update(trackFile)` then writes the new path to the database. The move and the database update happen in the same operation.

For artist folder moves, `MoveArtistService` transfers the folder on disk and publishes an `ArtistMovedEvent`. `MediaFileService` handles that event by rewriting the path prefix for every track file under the old folder:

```csharp
// src/NzbDrone.Core/MediaFiles/MediaFileService.cs
var newPath = $"{message.DestinationPath}{file.Path.AsSpan(message.SourcePath.Length)}";
file.Path = newPath;
```

None of this happens when the move is done outside Lidarr.

#### How to rename and move safely

To rename files: go to **Settings → Media Management**, enable **Rename Tracks**, and set your naming format. Then open the artist page, click the rename button (or use **Library → Artist Editor** for bulk operations). Lidarr renames the files and updates the database in one step.

To move an artist folder to a different root folder: go to **Library → Artist Editor**, select the artists, and use the **Root Folder** bulk action. Choose **Yes, move the files** when prompted.

To move a file to a different location on the same volume without a UI option: use the recycle bin and re-import. Delete the track file record in Lidarr (from the album page, track file menu) so the track is marked missing, move the file where you want it, then use **Manual Import** to re-import it from the new location.

#### Recovery if you already renamed outside Lidarr

If the rename has already happened and the next disk scan has not yet run, you can sometimes recover by renaming back before the scan fires. If the scan has already run and the records are gone:

1. Make sure the files are in a location Lidarr can see (inside a configured root folder or accessible via the file browser).
2. Go to **Activity → Manual Import** and point it at the folder containing the renamed files.
3. Lidarr will attempt to match the files to albums and re-import them. If automatic matching fails, use the manual match controls to assign the correct album and release.

After a successful manual import, Lidarr creates new track file records at the current path and the tracks are no longer considered missing.

> **If you have a large library and renamed many folders outside Lidarr**, running a full disk scan before manual import may be faster than importing folder by folder. Go to **System → Tasks** and trigger **Rescan Artist Folders**, or use **Library → Artist Editor → Update** to run a rescan across all artists. Lidarr will discard the stale records and then re-match any files it finds at the new paths that still conform to the expected folder structure.
{.is-info}

## Custom Formats

Custom formats let you score releases by source, release group, and other title characteristics so Lidarr can prefer or avoid them automatically. The examples below are a useful starting point for a FLAC-focused library. Import each block via **Settings → Custom Formats → Import**.

### Quality definitions for FLAC

Before setting up custom format scoring, consider tightening the FLAC quality definition to filter out single-file CUE+FLAC rips. These present as one large file rather than individually split tracks.

In **Settings → Quality**, set the FLAC row to:

| | Min | Preferred | Max |
| --- | --- | --- | --- |
| FLAC | 0 | 895 | 1400 |
| FLAC 24bit | 0 | 895 | 1495 |

The Max value rejects releases whose computed bitrate exceeds a realistic ceiling for split-track FLAC, which catches most CUE+single-file rips without affecting normal releases.

### Example custom formats

#### Preferred Groups

Boosts releases from groups known for consistent quality and accurate tagging.

```json
{
  "name": "Preferred Groups",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "DeVOiD",
      "implementation": "ReleaseGroupSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\bDeVOiD\\b" }
    },
    {
      "name": "PERFECT",
      "implementation": "ReleaseGroupSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\bPERFECT\\b" }
    },
    {
      "name": "ENRiCH",
      "implementation": "ReleaseGroupSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\bENRiCH\\b" }
    }
  ]
}
```

#### CD

Tags releases identified as a CD source.

```json
{
  "name": "CD",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "CD",
      "implementation": "ReleaseTitleSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\bCD\\b" }
    }
  ]
}
```

#### WEB

Tags releases identified as a web (streaming) source.

```json
{
  "name": "WEB",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "WEB",
      "implementation": "ReleaseTitleSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\bWEB\\b" }
    }
  ]
}
```

#### Lossless

Tags releases that identify themselves as lossless. Useful on Usenet where filenames are less predictable.

```json
{
  "name": "Lossless",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "Lossless",
      "implementation": "ReleaseTitleSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\blossless\\b" }
    }
  ]
}
```

#### Vinyl

Tags releases from a vinyl source, for libraries that want to avoid or specifically seek out vinyl rips.

```json
{
  "name": "Vinyl",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "Vinyl",
      "implementation": "ReleaseTitleSpecification",
      "negate": false,
      "required": false,
      "fields": { "value": "\\bVinyl\\b" }
    }
  ]
}
```

### Suggested scoring

After creating the formats, assign scores in **Settings → Profiles → [your profile] → Custom Formats**. The table below implements a setup that requires releases to match at least one positive format before Lidarr will grab them, prefers CD over WEB, and actively avoids vinyl.

| Custom Format | Score |
| --- | --- |
| Preferred Groups | 100 |
| CD | 10 |
| Lossless | 10 |
| WEB | 5 |
| Vinyl | -10000 |

Set **Minimum Custom Format Score** to `1` in the profile. This means a release must match at least one of CD, Lossless, WEB, or Preferred Groups before Lidarr will grab it — Lidarr skips releases with no recognised source tag entirely.

> Scoring is subjective and depends on your indexers and sources. Treat these values as a starting point, not a prescription.
{.is-info}

## Testing release title parsing

{#testing-release-title-parsing}

Two ways to check how Lidarr will parse a release name before building profiles around it:

**In Lidarr:** Go to **Settings → Custom Formats** and use the **Test Parsing** button. Enter a release title and Lidarr shows the parsed fields (source, quality, release group, etc.) alongside which custom formats match and their combined score.

**Via the Servarr Discord bot:** In the `#bot-spam` channel on the [Servarr Discord](https://lidarr.audio/discord), run `/parser lidarr <release title>` — for example, `/parser lidarr Artist.Album.2022.FLAC-GROUP`. The bot replies with the same parsed breakdown. Any user who donates to Servarr becomes a Donatarr and can use the parser bot.

Both tools give the same parser output. Use either when writing a custom format specification, debugging a release that isn't scoring as expected, or confirming a release group pattern matches before adding it to a profile.

## Backup and restore

{#backup-restore}

Lidarr's entire state lives in its [AppData directory](/lidarr/appdata-directory). Backing up means capturing that directory at rest. Restoring means putting it back in place with matching permissions and paths. There's nothing in the database that's meaningful without the matching `config.xml` and vice-versa — back up the whole folder, not individual files.

### Backing up

Two ways to do it. Use whichever fits your workflow.

**Built-in backup (zip):**

1. System → Backup in the Lidarr UI.
2. Click **Backup**.
3. Download the zip that appears in the backup list.

This captures the database, config, and everything needed to restore. The backup excludes the logs folder and the MediaCover cache, both of which are regenerable.

**Filesystem copy:**

1. Stop Lidarr. This is the only way to guarantee the database is in a consistent state — SQLite's WAL can leave a running database in a state that's safe for the running process but not safe to copy.
2. Copy the entire AppData directory to a safe location. Include `.db-wal` and `.db-journal` siblings of `lidarr.db` if they exist.
3. Start Lidarr.

Filesystem backup is the right choice if you want to use existing backup tooling (Borg, restic, Duplicati, ZFS snapshots, etc.) — don't try to snapshot a live SQLite file.

### Restoring

> **Cross-OS restores aren't supported.** Windows ↔ Linux and Windows ↔ macOS won't work because the path separators differ. Linux ↔ macOS may work since both use `/`, but isn't officially supported. If you need to move between OSes, expect to edit every path in the database by hand.
{.is-warning}

**From a built-in zip backup:**

1. Install Lidarr if it isn't installed yet.
2. Start Lidarr.
3. System → Backup → **Restore Backup**.
4. Choose the zip file.
5. Click **Restore**.

**From a filesystem copy:**

1. Install Lidarr if needed and start it once so the AppData directory gets created in the expected place.
2. Stop Lidarr.
3. Delete the contents of the AppData directory, including any `.db-wal` / `.db-journal` files.
4. Copy your backup into place.
5. Start Lidarr.

As long as the root folder paths in the backup are still valid on the destination machine, Lidarr will pick up where it left off.

### Restore on Synology NAS

> CAUTION: this procedure requires root SSH access and is unnecessary on most systems. Use it only if the standard filesystem restore fails due to Synology's package-user permissions model.
{.is-warning}

1. Install Lidarr via the SPK package if it isn't installed.
2. Find the AppData directory — `/usr/local/Lidarr/var/.config/Lidarr/` by default.
3. Stop Lidarr.
4. SSH to the NAS as root.
5. Replace the database and restore:

   ```shell
   rm -r /usr/local/Lidarr/var/.config/Lidarr/Lidarr.db
   cp -f /tmp/Lidarr_backup/* /usr/local/Lidarr/var/.config/Lidarr/
   ```

6. Fix ownership and permissions:

   ```shell
   cd /usr/local/Lidarr/var/.config/Lidarr/
   chown -R Lidarr:users *
   chmod -R 0644 *
   ```

   > On some SynoCommunity versions the user is `sc-Lidarr` rather than `Lidarr` — `chown -R sc-Lidarr:Lidarr *`. Check who owns the existing files before the restore if you aren't sure.
   {.is-info}

7. Start Lidarr.

## See also

- [FAQ](/lidarr/faq) — the questions that come up most often
- [Concepts](/lidarr/concepts) — the model Lidarr uses to manage music
- [Metadata Troubleshooting](/lidarr/metadata-troubleshooting) — when MusicBrainz data is missing or stale
- [Import Troubleshooting](/lidarr/import-troubleshooting) — when downloads finish but don't import
- [Troubleshooting](/lidarr/troubleshooting) — general runtime issues
- [TRaSH Guides](https://trash-guides.info/) — community recipes for media server setups
