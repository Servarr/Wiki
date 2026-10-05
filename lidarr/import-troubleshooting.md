---
title: Lidarr Import Troubleshooting
description: Why a download finishes but Lidarr does not import it — match-quality thresholds, the manual-import path, and when human intervention is necessary
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, troubleshooting, plugins, import, matching
editor: markdown
dateCreated: 2026-04-20T13:06:15.307Z
---

# Import Troubleshooting

> The download finished, but Lidarr won't import it. This page covers the match-quality rules Lidarr applies to imports, why Lidarr can still reject an otherwise-valid file, when you need to intervene manually, and how to use manual import to force an outcome when the matcher can't.
{.is-info}

If you haven't imported anything yet and are setting up a fresh library, start with [Importing an Existing Library](/lidarr/importing-existing-library) instead. This page is for diagnosing imports that don't autocomplete, not for first-time setup.

## Supported file types

Lidarr only processes files with these extensions: `.mp2`, `.mp3`, `.m4a`, `.m4b`, `.m4p`, `.ogg`, `.oga`, `.opus`, `.wma`, `.wav`, `.wv`, `.flac`, `.ape`, `.aif`, `.aiff`, `.aifc`. Lidarr ignores any other extension entirely — it won't attempt to import, rename, or track it. If Lidarr isn't picking up your files at all, confirm they have a supported extension before troubleshooting further.

## Why Lidarr rejects an import

Every file Lidarr considers importing runs through a decision pipeline. For an import to succeed, the file must *pass every specification*. A single rejection reason anywhere in the pipeline stops the import. The pipeline is strict by design: incorrect imports are hard to undo, so Lidarr errs on the side of refusing rather than guessing.

The most common rejection category is **match quality** — Lidarr couldn't find a release that resembles the file well enough.

### The match-quality thresholds

Lidarr computes a normalised *distance* score between what it sees on disk (file tags, filenames, duration, track count) and each candidate release in its metadata. Lower distance = closer match. Lidarr converts the score to a similarity percentage for user-facing messages.

For a **new download**, Lidarr requires:

- **Album score:** at least 80% similarity (distance ≤ 0.20).
- **Worst track within the album:** at least 60% similarity (distance ≤ 0.40).

If the album scores 85% but one track inside it only matches at 50%, Lidarr rejects the whole import — that one poor track is enough to fail the album.

For **importing existing library files** (when you point Lidarr at a root folder you already had on disk), the rules are more lenient:

- **Album score:** still 80% — but Lidarr excludes `missing_tracks` and `unmatched_tracks` from the score. This is why an existing library can import successfully even if some files are missing or there are extras.

Standalone track imports outside the album context use a **60% similarity** threshold (distance ≤ 0.40).

> These aren't configuration values — they're constants in the Lidarr source code. See [Where this lives in the source](#where-this-lives-in-the-source) below.
{.is-info}

### What goes into the distance score

The distance score is a weighted combination of how well each field matches. Lidarr adapts the weights from [beets' default configuration](https://beets.readthedocs.io/), with MusicBrainz IDs as the strongest signals:

| Signal | Weight | Notes |
| --- | --- | --- |
| `recording_id` | 10.0 | MusicBrainz Recording MBID. If present and correct, imports almost always succeed. |
| `album_id` | 5.0 | MusicBrainz Release MBID. |
| `artist` | 3.0 | Artist name (Levenshtein distance after normalisation). |
| `album` | 3.0 | Album/release title (same). |
| `track_title` | 3.0 | Per-track title. |
| `track_artist` | 2.0 | Per-track artist (matters for compilations). |
| `track_length` | 2.0 | Duration in seconds. |
| `tracks` | 2.0 | Track-count agreement. |
| `source` | 2.0 | Source medium (digital / CD / vinyl / etc). |
| `media_count`, `media_format`, `year`, `track_index` | 1.0 each | |
| `unmatched_tracks` | 0.9 | Penalty for files that don't map to any MB track. |
| `missing_tracks` | 0.6 | Penalty for MB tracks with no corresponding file. |
| `country`, `label`, `catalog_number`, `album_disambiguation` | 0.5 each | Tiebreakers, not primary signals. |

The practical takeaway: **MusicBrainz Recording IDs and Release IDs are the dominant signals**. Files tagged with correct MBIDs (by MusicBrainz Picard, for example) almost always import. Files without MBIDs rely on artist/album/title matching and are far more sensitive to tag quality.

## The fingerprinting fallback

If the best candidate release is still worse than threshold, Lidarr can attempt to identify the files by acoustic fingerprint instead of tags. This is the fallback path that sometimes rescues imports where the tags are wrong or missing.

Fingerprinting kicks in when any of the following is true:

- Album distance is worse than 0.15 (below ~85% match).
- Extra local files exist that don't map to MB tracks.
- MB tracks exist with no corresponding file.
- The worst track's distance is worse than 0.40 (below 60% match).

Whether Lidarr allows fingerprinting depends on the **Allow Fingerprinting** setting under Settings → Media Management:

- `Never` — Lidarr never fingerprints.
- `For new imports only` — fingerprint new downloads only (default on most installs).
- `Always` — fingerprint even on library imports.

Fingerprinting is slower than tag-based matching and hits an external service. If downloads consistently land in a state where fingerprinting runs but doesn't rescue them, the files likely don't exist in MusicBrainz at all. No fingerprint match is possible for a release that isn't in the database.

## When to intervene manually

The automatic matcher can't handle some situations, no matter how you tune the settings. For these cases, manual import is the expected path, not a workaround.

### The release isn't in MusicBrainz

Lidarr only imports against releases that exist at MusicBrainz (via the metadata server). If the specific pressing or edition you have isn't in MusicBrainz, the matcher has nothing to match *to*. Two options:

- Use **manual import** and point Lidarr at an existing release in the same release group (a different pressing). Lidarr attaches the files to that release — the metadata shown in Lidarr will match the attached release, not what's on disk.
- Add the missing release to MusicBrainz (see [Metadata Troubleshooting → Updating MusicBrainz](/lidarr/metadata-troubleshooting#updating-musicbrainz)) and re-import once it propagates.

### The release exists but is missing tracks

Some MB releases have incomplete track lists. If your files have 12 tracks and the MB release only lists 10, `unmatched_tracks` applies a significant penalty (weight 0.9) and the import can fail even with otherwise-good metadata. The fix is either to complete the MB release or to manually import.

### Untagged or badly tagged files

Without tags, Lidarr matches on the filename and duration only. This works for well-named files (`01 - Artist - Album - Track.flac`) but breaks on generic filenames (`track01.mp3`). Run a tagger — [MusicBrainz Picard](https://picard.musicbrainz.org/) is the reference tool — before asking Lidarr to import.

### Plugin-added content types

The nightly branch supports third-party plugins for indexers and download clients — streaming services, peer-to-peer networks, and other sources. See [Plugins](/lidarr/plugins) for the install path and current compatibility notes.

Content pulled through plugins sometimes doesn't fit Lidarr's core import model cleanly. Single tracks, partial releases, streaming-service rips, and per-track purchases are common plugin outputs that the core matcher wasn't designed to handle. The tag data may be correct for the source but incomplete against a MusicBrainz release group, and the automatic matcher won't resolve it. Manual import is the expected path for these cases until the plugin-specific import flows mature — it isn't a workaround, it's the intended workflow.

## Import list items: How a list entry becomes an album

Import lists (Spotify, Last.fm, Trakt, etc.) feed entries into Lidarr that Lidarr must resolve to a MusicBrainz release group before it can add anything. The resolution depends on whether the list provides an MBID:

- **If the list item has a MusicBrainz album (release group) ID**, Lidarr does a direct lookup by that ID. No ambiguity — the ID selects exactly one release group.
- **If the list item is only a title string** (common with Spotify and Last.fm, which don't expose MBIDs), Lidarr asks the Servarr metadata server to search for an album matching that title and artist, and takes **whichever result the server returns first**. The client does no re-ranking. The metadata server decides the ordering.

This matters because MusicBrainz distinguishes singles from albums at the release-group level. A track called *Blinding Lights* exists on both the "Blinding Lights" single release group and the *After Hours* album release group. When the server ranks the single above the album, the list entry resolves to the single. Ranking factors include track-count match, exact title match, locale, and other server criteria.

Practical consequences:

- A track you expect to see under its album may get added under the single's release group instead.
- Lidarr isn't designed to manage a library of single-track release groups; a library that has drifted into lots of singles is hard to reason about later.
- If you want a specific album to be the canonical entry, add it directly from the artist's discography in Lidarr rather than relying on a list's title-based resolution. The discography view shows release groups unambiguously.

No user-facing setting biases the metadata server's ordering — it's an upstream decision.

## Using manual import

Manual import is the override path when the automatic matcher can't resolve a file. Two entry points:

- **Activity → Queue →** the download appears there with a reason. From the row, choose **Manual Import**.
- **Wanted → Missing → Manual Import** and point it at the folder on disk.

The manual-import dialog lets you pick:

- The artist (if the matcher got the artist wrong).
- The album (if the matcher picked the wrong release group).
- The specific release within the release group (pressing, format, region).
- Per-track mappings when the dialog can't automatically align tracks.

Manual import **bypasses the specification pipeline entirely**. When you click Import, Lidarr doesn't re-run match-quality, free-space, not currently unpacking, upgrade-or-not, or any other specification. Lidarr treats the decisions as approved by your choices. The rejections shown inside the manual-import dialog are informational, to help you decide what to import. They aren't blockers once you commit.

The only checks still enforced at manual-import time are at the filesystem and database level:

- The target artist's folder must sit under a configured root folder. If Lidarr can't find the destination path inside any root folder, Lidarr rejects the file with *Destination artist folder X isn't in a Root Folder*.
- The track must not already exist in the import batch (per-run dedup).
- The destination path must not already exist on disk (otherwise: *Failed to import track, Destination already exists*).
- Filesystem permissions must allow the move or copy.
- The artist and album must exist in the DB or be addable from MusicBrainz. If Lidarr can't resolve or add the MBID the dialog selected, the import fails with *Failed to add missing album* / *Failed to add missing artist*.

If manual import fails, the reason will be one of the above — a filesystem or DB failure, not a match-quality rejection.

## Controlling which pressing gets matched

{#controlling-which-pressing-gets-matched}

Lidarr's automatic import matcher picks the MusicBrainz release (pressing) that scores closest to the files on disk. It doesn't prefer one pressing over another based on format (CD / Digital Media / Vinyl). The `media_format` signal has a low weight in the distance model and only penalises releases whose format is `Unknown` in MusicBrainz. If you want Lidarr to match a specific pressing rather than whichever one scored closest, you have three options.

**Option 1 — Tag with the correct MusicBrainz Release MBID.** The `album_id` distance signal (weight 5.0) is the second-strongest signal in the model after Recording IDs. If your files carry the `MusicBrainz Album Id` tag set to the Release MBID for the pressing you want, the automatic matcher will select it. Use [MusicBrainz Picard](https://picard.musicbrainz.org/), [beets](https://beets.io/), or [Harmony](https://harmony.pulsewidth.org.uk/) to write the tag before the import runs. Make sure you use the **Release MBID**, not the Release Group MBID — those are different IDs.

**Option 2 — Use manual import and pick the pressing.** The manual-import dialog lets you select the specific release within a release group. Once you choose a pressing and click Import, that pressing becomes the attached release for those files. No tags need changing. See [Using manual import](#using-manual-import) above for the two entry points.

**Option 3 — Switch the active release on the album page.** Each album in Lidarr has a currently active release. You can change it by going to the album page, clicking **Edit**, and selecting a different release from the dropdown. After saving, a new import triggered from Activity → Queue or a manual import will match against that release.

> None of these options work retroactively on files Lidarr has already imported and is tracking. For already-imported files, use manual import to re-import with a different pressing selection, which overwrites the attached release in the database.
{.is-info}

For background on why format preference isn't automatic and the open feature request on this, see [FAQ → Can Lidarr prefer a specific pressing or format during import?](/lidarr/faq#can-lidarr-prefer-a-specific-pressing-or-format-during-import).

## Where this lives in the source

For advanced readers who want to verify the rules or trace a specific rejection, the relevant code lives under [`src/NzbDrone.Core/MediaFiles/TrackImport/`](https://github.com/Lidarr/Lidarr/tree/develop/src/NzbDrone.Core/MediaFiles/TrackImport) in the Lidarr source tree:

- **Thresholds:**
  - [`Specifications/CloseAlbumMatchSpecification.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/MediaFiles/TrackImport/Specifications/CloseAlbumMatchSpecification.cs) — album-level and worst-track thresholds (0.20 and 0.40).
  - [`Specifications/CloseTrackMatchSpecification.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/MediaFiles/TrackImport/Specifications/CloseTrackMatchSpecification.cs) — standalone track threshold (0.40).
- **Scoring model:**
  - [`Identification/Distance.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/MediaFiles/TrackImport/Identification/Distance.cs) — weighted field contributions; comment at the top notes that Lidarr adapts the weights from beets' defaults.
- **Identification flow and fingerprinting:**
  - [`Identification/IdentificationService.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/MediaFiles/TrackImport/Identification/IdentificationService.cs) — `Identify()` implements the four-step flow (group → candidates → best match → fingerprint if worse than threshold); `ShouldFingerprint()` documents when fingerprinting triggers.
- **Other specifications that can also reject an automatic import** (these don't run for manual import):
  - `AlreadyImportedSpecification.cs`, `AlbumUpgradeSpecification.cs`, `FreeSpaceSpecification.cs`, `MoreTracksSpecification.cs`, `NoMissingOrUnmatchedTracksSpecification.cs`, `NotUnpackingSpecification.cs`, `ReleaseWantedSpecification.cs`, `SameTracksImportSpecification.cs`, `UpgradeSpecification.cs`.
- **Manual-import flow:**
  - [`Manual/ManualImportService.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/MediaFiles/TrackImport/Manual/ManualImportService.cs) — `Execute()` builds `LocalTrack` objects from user choices and creates approved `ImportDecision`s directly, bypassing the specification pipeline. The only pre-import rejection is the root-folder check.
  - [`ImportApprovedTracks.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/MediaFiles/TrackImport/ImportApprovedTracks.cs) — the post-approval path. Handles the remaining checks (dedup, filesystem, artist/album add) for both automatic and manual imports.
- **Import-list resolution:**
  - [`src/NzbDrone.Core/ImportLists/ImportListSyncService.cs`](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/ImportLists/ImportListSyncService.cs) — `MapAlbumReport()` takes `.FirstOrDefault()` from the metadata-server search for title-only list entries. Direct MBID lookups go through `SkyHookProxy.SearchForNewAlbum` with a `lidarr:<mbid>` query.
- **Tests:** fixtures under [`src/NzbDrone.Core.Test/MediaFiles/TrackImport/`](https://github.com/Lidarr/Lidarr/tree/develop/src/NzbDrone.Core.Test/MediaFiles/TrackImport) — `IdentificationServiceFixture.cs`, `AlbumDistanceFixture.cs`, `TrackDistanceFixture.cs`, and `ImportDecisionMakerFixture.cs` are the most useful starting points for understanding how specific cases score.

## See also

- [Importing an Existing Library](/lidarr/importing-existing-library) — the fresh-install import walkthrough
- [Metadata Troubleshooting](/lidarr/metadata-troubleshooting) — for problems where the release is missing or wrong at MusicBrainz
- [FAQ](/lidarr/faq) — shorter answers that didn't fit this page
- [MusicBrainz Picard](https://picard.musicbrainz.org/) — tag files with MBIDs before importing for a dramatically higher success rate
