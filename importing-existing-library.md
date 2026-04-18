---
title: Importing an Existing Library
description: This page walks you through migrating an existing music library into Lidarr. It is intended for users who already have audio files on disk and want Lidarr to take over management of that library, rather than for users starting with an empty root folder.
published: true
date: 2026-04-18T16:54:14.510Z
tags: 
editor: markdown
dateCreated: 2026-04-18T16:54:14.510Z
---

# Importing an Existing Library

This page walks you through migrating an existing music library into Lidarr. It is intended for users who already have audio files on disk and want Lidarr to take over management of that library, rather than for users starting with an empty root folder.

If you are setting Lidarr up for the first time and do not already have files, use the [Quick Start](/lidarr/quick-start-guide) instead. If you are not sure whether Lidarr is a good fit for the library you have, read [Concepts — Is Lidarr right for your library?](/lidarr/concepts#is-lidarr-right-for-your-library) first; importing a library Lidarr cannot model will waste a lot of time.

> **The automated import is scheduled, cannot be stopped once started, and can take hours on large libraries.** Do not add a `Root Folder` that contains existing files until you have read this page in full.
{.is-danger}

## Before you start

Lidarr uses an automated process to scan a `Root Folder`, match the files it finds against MusicBrainz metadata, and add the resulting `Release Artists` and `Releases` to your library. For that to work, a few things need to be true about the library you're importing.

- **Your files must match Lidarr's data model.** Lidarr manages `Releases` (albums, EPs, singles, broadcasts) attributed to a single `Release Artist`. Loose collections, multi-artist folders that aren't compilations, and libraries of DJ mixes or beat packs will not import well. See [Concepts](/lidarr/concepts#is-lidarr-right-for-your-library).
- **Your files must be organized per artist and per release.** Lidarr's scanner expects a folder structure it can map to `Release Artist` → `Release` → tracks. A single folder with thousands of files in it will not work.
- **Your files must be tagged.** Tags are what Lidarr uses to match files to MusicBrainz records. Untagged or poorly tagged files either fail to import or import against the wrong `Release`.

If one or more of these isn't true today, you have two options: fix it before import, or leave the problematic portion of your library outside Lidarr and import only the parts that conform. Both are legitimate choices; see [Concepts](/lidarr/concepts).

> See the FAQ entries [How does Lidarr work?](/lidarr/faq#how-does-lidarr-work) and [How does Lidarr find releases?](/lidarr/faq#how-does-lidarr-find-releases) for the scheduling model and how searches are triggered. Lidarr does not continuously crawl indexers.
{.is-info}

## Preparing your existing files

For the automated import to succeed, files should be structured and tagged before you point Lidarr at them. The amount of work here depends entirely on how clean your library already is.

### Folder structure

The recommended structure is:

```
<Root Folder>/<Release Artist>/<Release>/<Track>
```

For example:

```
/music/Bob Dylan/Blood on the Tracks/01 - Tangled Up in Blue.flac
/music/Bob Dylan/Blood on the Tracks/02 - Simple Twist of Fate.flac
```

This layout, combined with proper tags, gives recognition rates of 95% or better in both Lidarr and most downstream media players. Flat layouts (one folder containing many releases), grouped-by-year layouts, or layouts that split discs into separate folders will all cause mismatches or import failures.

Disc-subfolder layouts (`.../Release/CD1/...`, `.../Release/CD2/...`) are a common trap: Lidarr expects all tracks for a release to live under the release folder, so consolidate or flatten disc subfolders before importing.

### Tagging

Tagging is where most import failures come from. Lidarr leans on MusicBrainz identifiers where they exist, and falls back to text matching on artist, album, and track fields where they don't — so the quality and consistency of your tags directly determines the quality of the import.

Recommended tagging tools:

- **[MusicBrainz Picard](https://picard.musicbrainz.org/)** — the canonical MusicBrainz tagger. Writes MusicBrainz Release, Recording, and Artist IDs directly into your tags. Strongly preferred if you want the cleanest match in Lidarr.
- **[Beets](https://beets.io/)** — command-line, scriptable, strong at bulk cleanup and folder renaming in the same pass.
- **MusicBee, MediaMonkey, JRiver** — GUI library managers that can batch-retag; less MusicBrainz-native than Picard but workable.

Most of these tools will rename folders and restructure files at the same time as retagging, which means a single pass can fix both the structure and the tags. Associating MusicBrainz Release IDs with each file during this pass is the single biggest thing you can do to improve import accuracy.

> Detailed use of Picard, Beets, and similar tools is beyond the scope of this wiki. See those projects' own documentation.
{.is-info}

## Pre-import considerations

Once your files are structured and tagged, check the following before pointing Lidarr at them. A failed import of a large library is expensive to recover from.

- **System architecture.** 64-bit is strongly recommended. Large-library imports are RAM- and compute-intensive. 32-bit builds are supported but noticeably slower.
- **System memory.** 4 GB minimum, 8 GB recommended. The import process plus an open browser tab will comfortably use 2–4 GB on a mid-sized library.
- **Release size.** `Releases` with very large track or disc counts dominate import time. As a rule of thumb, pull releases over ~25 discs or ~250 tracks out of the root folder and import them manually after the bulk pass.
- **Artists with many releases.** A single `Release Artist` with thousands of `Releases` in MusicBrainz will slow the scan substantially, even if only a handful of them are on your disk. This is rarely a blocker but is worth knowing about if the scan seems stuck on a particular artist.
- **Time budget.** A reasonable estimate is one hour per ~500 properly tagged `Releases`, heavily dependent on disk speed, network latency to the metadata service, and system performance. Plan for an overnight run on large libraries.
- **Metadata propagation.** If you've recently edited or added records on MusicBrainz, those changes may not have reached Lidarr's metadata source yet — propagation typically takes hours to days. See [Concepts — Dependence on MusicBrainz](/lidarr/concepts#dependence-on-musicbrainz).
- **Back up first.** Take a snapshot of your library (or at least of the tag state) before running the import. Lidarr does not rewrite tags during the import scan itself, but if you have automatic file-renaming or tag-writing enabled in settings, behaviour diverges from a read-only scan.

## Begin import

With files prepared and the pre-import checks done, the actual import is triggered by adding the library folder as a `Root Folder`. Lidarr starts scanning as soon as the folder is saved.

1. Go to **Settings → Media Management** and click **Add (+)** under **Root Folders**.
2. Fill in the add-root-folder dialog:
   - **Name** — a friendly label for this root folder.
   - **Path** — the filesystem path to the library you prepared. The Lidarr user must have read and write access.
   - **Monitor*** — the default monitoring option for newly imported `Releases` (e.g. all, future, latest, none). This applies to every artist and release created by the import; you can change individual artists afterwards.
   - **Quality Profile*** — the default quality profile assigned to each imported artist. Used later to decide which `Releases` are cutoff-met and what Lidarr will search for.
   - **Metadata Profile*** — the default metadata profile. Controls which `Release` types (studio albums, EPs, singles, etc.) are visible on each imported artist.
3. Save the root folder. Lidarr begins scanning the path immediately.

The three asterisked fields above become the defaults for every artist the import creates. You can change them on a per-artist basis later, but it is much less work to pick the right defaults up front than to batch-update hundreds of artists afterwards. In particular, `Metadata Profile` has the biggest downstream effect — a too-narrow profile will silently hide `Releases` that exist on disk.

### What Lidarr does during the scan

1. Walks the root folder, building an inventory of files grouped by folder.
2. Reads tags from each file and groups them by `Release` (using MusicBrainz IDs where present, falling back to artist/album text matching).
3. For each group, queries the metadata service for the matching `Release Artist` and `Release`.
4. Adds the `Release Artist` to the library, then adds the matched `Releases`, then links the existing files to their `Release` tracks.
5. Files that don't match anything are left on disk but not added to the library. They are not deleted.

> **The scan cannot be stopped partway through.** If you realise something is wrong (wrong path, wrong metadata profile, etc.) you can either let the scan finish and clean up afterwards, or stop Lidarr and remove the root folder before restarting — but there is no in-app cancel button.
{.is-warning}

### Watching progress

- **Activity → Queue** shows in-progress downloads; the import scan itself appears under **System → Tasks** → *Rescan Folders* and related tasks.
- **System → Events** logs each `Release Artist` as it's added.
- A busy scan will push CPU and disk I/O noticeably; this is expected. Importing against a spinning disk over SMB/NFS is the most common reason scans take many hours.

## After import

Once the scan finishes, plan on a review pass. Even a well-prepared library will produce a small number of mismatches, and finding them early is cheaper than discovering them weeks later when Lidarr downloads the "missing" half of a mis-linked `Release`.

- **Check the library view** for artists with zero monitored `Releases`. Usually means the metadata profile filtered everything out; widen the profile or change it for that artist.
- **Look for wrong-release matches.** Pick a few albums at random and verify the tracklist on the artist page matches what you have on disk. Mismatches most commonly appear with re-releases, remasters, and region-specific pressings — the text match picked a different `Release` than the one you own. Use the **Manual Import** or **Search for MusicBrainz ID** workflow to re-link.
- **Handle skipped files.** Files that weren't imported are still on disk. If you want them managed, fix their tags (usually a Picard pass) and run *Rescan Folders* from **System → Tasks**. If you don't want them managed, leave them or move them out of the root folder.
- **Unmonitor or remove noise.** Rip-artifact files (`folder.jpg`, `*.nfo`, stray `.txt` files) are harmless. Duplicates and pre-import backup copies are worth cleaning up now so they don't confuse later searches.

## Troubleshooting

Most import problems are MusicBrainz data problems or tag problems, not Lidarr bugs. See the [FAQ](/lidarr/faq) for specific failure modes — including artists that can't be added, releases missing from MusicBrainz, and what to do when an import refuses to match a file you're sure you've tagged correctly.

If a `Release` or `Release Artist` you expect is genuinely missing from MusicBrainz, you can add or correct it upstream: see [How To Contribute](https://musicbrainz.org/doc/How_to_Contribute). Once upstream propagation completes (hours to days), refresh the affected artist inside Lidarr and rescan.

## See also

- [Concepts](/lidarr/concepts) — the `Release` and `Artist` model that drives import behavior
- [Quick Start](/lidarr/quick-start-guide) — install and first download, if you don't already have a library
- [FAQ](/lidarr/faq) — common import and metadata issues
- [Settings](/lidarr/settings) — detailed reference for every option referenced on this page
