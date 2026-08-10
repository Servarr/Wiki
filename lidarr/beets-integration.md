---
title: Lidarr and beets Integration
description:
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, beets
editor: markdown
dateCreated: 2026-04-26T15:17:29.688Z
---

# Lidarr and beets Integration

This page describes how to run [beets](https://beets.io/) alongside Lidarr to write richer audio metadata than Lidarr alone provides. beets can pull from sources Lidarr doesn't support (AcoustID fingerprinting, lyrics services, ReplayGain analysis, and more) and write those values directly into file tags.

> **This is an advanced configuration.** This page doesn't explain how to use beets; it assumes you are already familiar with beets and its configuration. See the [beets documentation](https://beets.readthedocs.io/en/stable/) if you are new to it.
{.is-warning}

Two patterns follow. They differ in how persistent the beets configuration is and how much ongoing involvement beets has in managing the library.

# Prerequisites

## Install beets

Install beets on the system (or container) where it will run. beets is a Python application. See the [beets installation guide](https://beets.readthedocs.io/en/stable/guides/installation.html) for platform-specific instructions.

Platform notes:

- **Linux / macOS:** install via `pip` or your system package manager. The Lidarr process user must be able to invoke the `beet` executable.
- **Windows:** install via `pip` in a Python environment. Ensure the `beet` command is on the PATH for the user account Lidarr runs as.
- **Docker:** beets must be available inside the same container as Lidarr, or in a separate container that shares the library volume. If beets runs in a separate container, Pattern 1 scripts can invoke it via `docker exec` rather than calling `beet` directly. Custom images that bundle both Lidarr and beets in a single container are another option, but they add maintenance overhead when either application updates.

## Disable Lidarr's tag writing

Both patterns require that Lidarr doesn't overwrite tags after beets has written them. Set this before configuring either pattern:

**Settings → Metadata → Write Audio Tags → Write Tags: Never**

With this set, Lidarr won't write or rewrite audio file tags at any point. Beets becomes the sole tag writer. Lidarr continues to manage file names and folder structure via its naming templates. Lidarr delegates only tag content to beets.

> If you had **Write Tags** set to anything other than **Never**, consider running a beets pass over your existing library after changing this setting, since Lidarr tagged those files and they may have gaps that beets can fill.
{.is-info}

# Pattern 1: Import script (stateless, per-import)

In this pattern, beets runs once per import triggered by a Lidarr Custom Script. It processes only the files that were just imported, writes enriched tags, and exits. beets has no persistent library database and doesn't take part in ongoing library management.

## How it works

Lidarr fires its **On Release Import / On Upgrade** event after it has moved and renamed the downloaded files into the library folder. A Custom Script registered in **Settings → Connect** receives the file paths via the `Lidarr_AddedTrackPaths` environment variable (pipe-separated). The script invokes beets against those files with a configuration that writes tags but doesn't move or copy anything.

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
IFS='|' read -ra TRACKS <<< "$Lidarr_AddedTrackPaths"
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

$trackPaths = $env:Lidarr_AddedTrackPaths -split '\|'
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
| --- | --- |
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
| --- | --- |
| **Benefit** | beets maintains tags on an ongoing basis; as plugin data sources update, you can re-run beets to pull in new values. |
| **Benefit** | beets' persistent library enables more sophisticated queries, playlist generation, and plugin behaviour. |
| **Drawback** | Requires careful beets configuration to prevent file moves. One misconfiguration can disorganise a large library. |
| **Drawback** | Path changes caused by Lidarr renames require manual beets database reconciliation. |
| **Drawback** | Two tools maintaining state about the same files creates more moving parts to keep in sync. |

# See also

- [Custom Scripts](/lidarr/custom-scripts): environment variables available to scripts and how to register them
- [Settings: Metadata](/lidarr/settings#metadata): Write Tags setting and metadata consumer options
- [beets documentation](https://beets.readthedocs.io/en/stable/)
- [beets installation guide](https://beets.readthedocs.io/en/stable/guides/installation.html)
