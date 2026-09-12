---
title: Lidarr and beets Integration
description: 
published: true
date: 2026-09-12T12:12:17.429Z
tags: lidarr, beets
editor: markdown
dateCreated: 2026-04-26T15:17:29.688Z
---

# Lidarr and beets Integration

This page describes how to run [beets](https://beets.io/) alongside Lidarr to write richer audio metadata than Lidarr alone provides. beets can pull from sources Lidarr doesn't support (AcoustID fingerprinting, lyrics services, ReplayGain analysis, and more) and write those values directly into file tags.

> **This is an advanced configuration.** This page doesn't explain how to use beets; it assumes you are already familiar with beets and its configuration. See the [beets documentation](https://beets.readthedocs.io/en/stable/) if you are new to it.
{.is-warning}

# MusicBrainz fields beets writes that Lidarr doesn't

Both Lidarr and beets pull from MusicBrainz, but beets exposes more of that data as tags. See the [Audio Tags Reference](/lidarr/audio-tags-reference) for the full list of what Lidarr already writes; this section covers only the MusicBrainz fields beets adds on top of that.

## Release and catalog identifiers

| Field | What it stores |
|---|---|
| `catalognum` | The release's catalog number |
| `asin` | Amazon Standard Identification Number |
| `barcode` | The release's barcode |

## Locale and script

| Field | What it stores |
|---|---|
| `script` | The writing system used for the release's titles |
| `language` | Release language |

## Artist naming

| Field | What it stores |
|---|---|
| `artist_credit` | The artist name exactly as credited on this specific release |
| `albumartist_credit` | The album artist name exactly as credited on this specific release |

Lidarr always writes the canonical MusicBrainz artist name. beets can capture the release-specific credit instead, which matters for artists whose credited name varies by release (translations, "feat." credits, stylized spellings).

## Disambiguation

| Field | What it stores |
|---|---|
| `releasegroupdisambig` | Disambiguation string at the release-group (album) level |

Lidarr writes only the release-level disambiguation, into MusicBrainz Album Comment. beets can additionally capture disambiguation at the release-group level, which is a separate MusicBrainz field.

## Multi-disc sets

| Field | What it stores |
|---|---|
| `disctitle` | Per-medium title, for box sets where each disc has its own subtitle |

## Classical and work metadata

Core beets fields since beets 1.5.0, not a plugin:

| Field | What it stores |
|---|---|
| `work` | The MusicBrainz Work title (the composition, distinct from the recording) |
| `mb_workid` | The Work's MBID |
| `work_disambig` | Disambiguation string for the work |

The separate [ParentWork plugin](https://beets.readthedocs.io/en/latest/plugins/parentwork.html) goes further, linking a recording back to a parent work, for example a symphony's third movement back to the symphony itself. Lidarr has no equivalent of any work-level metadata.

> AcoustID fingerprints, ReplayGain values, and lyrics aren't MusicBrainz data. They come from separate beets plugins pulling from other sources, covered by the patterns below.
{.is-info}

Three patterns follow. The first two differ in how persistent the beets configuration is and how much ongoing involvement beets has in managing the library. The third takes a different approach: instead of disabling Lidarr's own tag writing, it hooks beets to Lidarr's own MusicBrainz change-detection schedule.

# Prerequisites

## Install beets

Install beets on the system (or container) where it will run. beets is a Python application. See the [beets installation guide](https://beets.readthedocs.io/en/stable/guides/installation.html) for platform-specific instructions.

Platform notes:

- **Linux / macOS:** install via `pip` or your system package manager. The Lidarr process user must be able to invoke the `beet` executable.
- **Windows:** install via `pip` in a Python environment. Ensure the `beet` command is on the PATH for the user account Lidarr runs as.
- **Docker:** beets must be available inside the same container as Lidarr, or in a separate container that shares the library volume. If beets runs in a separate container, Pattern 1 scripts can invoke it via `docker exec` rather than calling `beet` directly. Custom images that bundle both Lidarr and beets in a single container are another option, but they add maintenance overhead when either application updates.

## Disable Lidarr's tag writing (Patterns 1 and 2 only)

Patterns 1 and 2 require that Lidarr doesn't overwrite tags after beets has written them. Set this before configuring either pattern:

**Settings → Metadata → Write Audio Tags → Write Tags: Never**

With this set, Lidarr won't write or rewrite audio file tags at any point. Beets becomes the sole tag writer. Lidarr continues to manage file names and folder structure via its naming templates. Lidarr delegates only tag content to beets.

> If you had **Write Tags** set to anything other than **Never**, consider running a beets pass over your existing library after changing this setting, since Lidarr tagged those files and they may have gaps that beets can fill.
{.is-info}

> **Pattern 3 does the opposite.** It requires Write Tags to stay enabled, since it uses Lidarr's own tag-writing schedule as its trigger. Skip this section if you're going straight to Pattern 3.
{.is-info}

# Pattern 1: Import script (stateless, per-import)

In this pattern, beets runs once per import triggered by a Lidarr Custom Script. It processes only the files that were just imported, writes enriched tags, and exits. beets has no persistent library database and doesn't take part in ongoing library management.

## How it works

Lidarr fires its **On Release Import / On Upgrade** event after it has moved and renamed the downloaded files into the library folder. A Custom Script registered in **Settings → Connect** receives the file paths via the `lidarr_addedtrackpaths` environment variable (pipe-separated). The script invokes beets against those files with a configuration that writes tags but doesn't move or copy anything.

> **Environment variable names are lowercase.** Lidarr passes them to your script already lowercased, regardless of how they're written in Lidarr's own source or UI. This matters on Linux and macOS, where environment variable names are case-sensitive; `$Lidarr_AddedTrackPaths` won't match what the script actually receives. See [Custom Scripts](/lidarr/custom-scripts#environment-variables) for the full explanation.
{.is-warning}

## Required beets configuration

Create a dedicated beets config file for this script. Don't reuse your personal beets config if you have one. The critical settings:

```yaml
# beets-import-script.yaml
library: /tmp/beets-lidarr-$$.db   # $$ = PID; unique per invocation, discarded after
directory: /tmp/beets-lidarr-tmp
import:
  move: no       # critical: Lidarr has already placed the files
  copy: no       # critical: same reason
  write: yes     # this is the point: write tags only
  quiet: yes
  timid: no
  autotag: yes
plugins:
  # list your desired plugins here, e.g.:
  # - acousticbrainz
  # - replaygain
  # - lyrics
```

> **`import.move` and `import.copy` must both be `no`.** If you enable either, beets will move or duplicate files that Lidarr has already placed in your library, resulting in duplicates or broken Lidarr tracking.
{.is-danger}

## Script examples

### Linux / macOS (shell)

Save as an executable shell script, for example, `/opt/scripts/beets-import.sh`:

```shell
#!/bin/bash
set -euo pipefail

BEETS_CONFIG="/opt/scripts/beets-import-script.yaml"

# Split the pipe-separated track paths and collect unique album directories
IFS='|' read -ra TRACKS <<< "$lidarr_addedtrackpaths"
declare -A SEEN_DIRS
DIRS=()
for track in "${TRACKS[@]}"; do
    dir="$(dirname "$track")"
    if [[ -z "${SEEN_DIRS[$dir]+_}" ]]; then
        SEEN_DIRS["$dir"]=1
        DIRS+=("$dir")
    fi
done

# Run beets against each album directory
for dir in "${DIRS[@]}"; do
    beet --config="$BEETS_CONFIG" import --quiet "$dir"
done
```

Make it executable: `chmod +x /opt/scripts/beets-import.sh`

### Windows (PowerShell)

Save as a `.ps1` file, for example, `C:\Scripts\beets-import.ps1`:

```powershell
$beetsConfig = "C:\Scripts\beets-import-script.yaml"

$trackPaths = $env:lidarr_addedtrackpaths -split '\|'
$albumDirs  = $trackPaths | ForEach-Object { Split-Path -Parent $_ } | Select-Object -Unique

foreach ($dir in $albumDirs) {
    & beet --config=$beetsConfig import --quiet $dir
}
```

> You may need to enable PowerShell script execution on the system: `Set-ExecutionPolicy RemoteSigned`. The script must be accessible and executable by the user account Lidarr runs as.
{.is-info}

## Registering the script in Lidarr

1. Go to **Settings → Connect → + Add Connection → Custom Script**.
2. Set **Name** to something descriptive, for example, `beets tag enrichment`.
3. Set **Path** to the full path of the script file.
4. Enable **On Release Import** and **On Upgrade**. Leave other triggers disabled unless you specifically want beets to run on those events.
5. Click **Test**. The script receives a test event and should exit cleanly without errors.

## Trade-offs

| | |
|---|---|
| **Benefit** | beets runs once at import time with any plugins you want, writing a full tag set that Lidarr wouldn't produce on its own. |
| **Benefit** | No persistent beets database to maintain or back up. |
| **Drawback** | Tags written at import time are never updated. If MusicBrainz data improves, or a plugin source updates its data (for example, updated ReplayGain values), the library files won't reflect it until you re-import or run beets manually. |
| **Drawback** | Lidarr's **Write Tags: Never** setting means files you imported before configuring beets won't have their tags updated automatically. Run a manual beets pass to backfill those. |

# Pattern 2: Side-by-side persistent beets

In this pattern, beets and Lidarr run concurrently against the same library folder. Lidarr owns file naming, folder structure, and download management. beets owns tag content, using a persistent library database and running on a schedule or on demand.

## How it works

beets watches or scans the library folder and writes enriched tags to files it finds there. It doesn't move, copy, or rename any files. Lidarr handles both. The two tools have separate duties: Lidarr controls the filesystem, beets controls the tag content.

## Critical beets configuration

The most important thing to get right is preventing beets from touching the file system. beets defaults to importing and organising music, which means it moves files unless you explicitly turn that off.

```yaml
# beets-persistent.yaml
library: /config/beets/library.db   # persistent; back this up
directory: /music                   # your Lidarr root folder
import:
  move: no       # critical
  copy: no       # critical
  write: yes
  quiet: yes
  timid: no
  autotag: yes
plugins:
  # your desired plugins
```

> **Test this configuration on a small set of files before pointing it at your full library.** Even with `move: no` and `copy: no`, some plugins or beets versions may behave in unexpected ways. Run `beet import --pretend` first to review what beets would do without committing any changes.
{.is-danger}

The `--pretend` flag is your safety net:

```shell
beet --config=/config/beets/beets-persistent.yaml import --pretend /music/some-artist
```

Review the output. Confirm that beets reports it will write tags but not move or copy files before running without `--pretend`.

## Keeping beets and Lidarr from fighting

Two scenarios where the tools can conflict:

**Lidarr renames files after beets has tagged them.** When Lidarr renames a file (for example, because you change a naming template), the file path changes but the tags beets wrote remain. beets' persistent database will have the old path and will treat the file as missing. Resolution: after a Lidarr rename, run `beet update` to resync the beets database to the new paths, then a `beet import` pass if you want to re-enrich the renamed files.

**Metadata refresh.** Lidarr periodically refreshes artist metadata from MusicBrainz and can overwrite file tags if Write Tags isn't set to Never. With **Write Tags: Never** set as described above, this doesn't occur.

## Trade-offs

| | |
|---|---|
| **Benefit** | beets maintains tags on an ongoing basis; as plugin data sources update, you can re-run beets to pull in new values. |
| **Benefit** | beets' persistent library enables more sophisticated queries, playlist generation, and plugin behaviour. |
| **Drawback** | Requires careful beets configuration to prevent file moves. One misconfiguration can disorganise a large library. |
| **Drawback** | Path changes caused by Lidarr renames require manual beets database reconciliation. |
| **Drawback** | Two tools maintaining state about the same files creates more moving parts to keep in sync. |

# Pattern 3: Trigger beets from Lidarr's own sync schedule

Patterns 1 and 2 both work around Lidarr's tag writer by disabling it. This pattern does the opposite: it leaves Lidarr's tag writer on and rides its own MusicBrainz change-detection as the trigger for beets. It's the closest beets equivalent to Lidarr's **All files, keep in sync with MusicBrainz** option, beets only runs against files Lidarr has just decided need rewriting, not the whole library on a blind timer.

## How it works

Lidarr's periodic artist refresh compares the local library against current MusicBrainz data. With **Tag Audio Files with Metadata** set to **All files, keep in sync with MusicBrainz**, any track whose metadata changed gets its tags rewritten, and Lidarr fires the **On Track Retag** event for that file. A Custom Script registered on **On Track Retag** receives the file's path via `lidarr_trackfile_path` and can invoke beets against it immediately after, layering beets' extra fields (see [MusicBrainz fields beets writes that Lidarr doesn't](#musicbrainz-fields-beets-writes-that-lidarr-doesnt) above) on top of whatever Lidarr just wrote.

The same event also fires on import and on manual retags, not only the periodic sync, since Lidarr publishes it every time it writes tags for any reason. One script covers all three triggers.

> **This pattern needs Write Tags left enabled**, the opposite of [Disable Lidarr's tag writing](#disable-lidarrs-tag-writing-patterns-1-and-2-only) above. Lidarr's own write always happens first; beets runs after and layers its fields on top. For the handful of fields both tools write (artist name, for example), beets' value wins, since it runs last.
{.is-warning}

## Beets configuration

Same configuration as [Pattern 1](#required-beets-configuration): `move: no`, `copy: no`, `write: yes`, `autotag: yes`.

## Script examples

### Linux / macOS (shell)

```shell
#!/bin/bash
set -euo pipefail

BEETS_CONFIG="/opt/scripts/beets-import-script.yaml"

dir="$(dirname "$lidarr_trackfile_path")"
beet --config="$BEETS_CONFIG" import --quiet "$dir"
```

### Windows (PowerShell)

```powershell
$beetsConfig = "C:\Scripts\beets-import-script.yaml"

$dir = Split-Path -Parent $env:lidarr_trackfile_path
& beet --config=$beetsConfig import --quiet $dir
```

> **On Track Retag fires once per file, not once per album.** A release-level metadata change can retag every track on an album in quick succession, each one invoking this script separately. If that matters for your library size, add a lock file or debounce so overlapping invocations against the same album directory don't collide.
{.is-info}

## Registering the script in Lidarr

1. Go to **Settings → Connect → + Add Connection → Custom Script**.
2. Set **Name** to something descriptive, for example, `beets retag enrichment`.
3. Set **Path** to the full path of the script file.
4. Enable **On Track Retag** only. Leave other triggers disabled unless you specifically want this same script running on those events too.
5. Click **Test**. The script receives a test event and should exit cleanly without errors.

## Trade-offs

| | |
|---|---|
| **Benefit** | No separate scheduler to maintain. Reuses Lidarr's own artist-refresh cadence as the trigger, and only runs beets against files that actually changed. |
| **Benefit** | One hook covers import, manual retag, and periodic MusicBrainz sync. Pattern 1 only covers import. |
| **Drawback** | Lidarr's write always happens first. If you want beets' choices (for example, its release-specific artist credit) to reliably win over Lidarr's canonical values, this ordering delivers that, but only after Lidarr has written its own value there first, every time. |
| **Drawback** | Fires once per file. An artist-wide metadata change can trigger many near-simultaneous beets invocations. |
| **Drawback** | Sync cadence is whatever Lidarr's own refresh interval is; you can't tune how often the check happens independently of Lidarr's settings. |

# See also

- [Custom Scripts](/lidarr/custom-scripts): environment variables available to scripts and how to register them
- [Settings: Metadata](/lidarr/settings#metadata): Write Tags setting and metadata consumer options
- [beets documentation](https://beets.readthedocs.io/en/stable/)
- [beets installation guide](https://beets.readthedocs.io/en/stable/guides/installation.html)