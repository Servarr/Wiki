---
title: Lidarr Custom Scripts
description: Guide for creating and implementing custom scripts for automation and integration in Lidarr
published: true
date: 2026-05-29T13:03:38.922Z
tags: lidarr, scripts, automation, custom, integration, hooks, api
editor: markdown
dateCreated: 2021-11-24T19:22:09.331Z
---

# Lidarr Custom Scripts

Lidarr can execute a custom script when it imports, renames, or retags an album, or when other events occur. Add scripts via **Settings → Connect → Custom Script**.

A custom script can be any executable accessible by the user Lidarr is running as: a shell script, PowerShell script, Python script, or compiled binary.

## Lidarr logs

Lidarr writes script output to the log files:

| Output | Log level | Log file |
|---|---|---|
| `stdout` | `Debug` | `config/logs/Lidarr.debug.txt` |
| `stderr` | `Info` | `config/logs/Lidarr.txt` |
| Script trigger | `Trace` | `config/logs/Lidarr.trace.txt` |

Enable **Debug** or **Trace** logging in **Settings → General → Logging** to see script output in the log files.

## Script requirements

- The script file must be executable by the user Lidarr runs as.
- On Linux/macOS: `chmod +x /path/to/your-script.sh`
- On Windows: `.ps1` files must be accessible; you must enable PowerShell script execution (`Set-ExecutionPolicy RemoteSigned`).
- The script must exit cleanly (exit code `0`) on the `Test` event, which Lidarr sends when you click **Test** in the connection settings. A non-zero exit code on Test will show an error, even though no real event fired.

## Environment variables

Lidarr passes data to your script through environment variables. The variables available depend on the event type, indicated by `Lidarr_EventType`.

> **Variable names are case-sensitive on Linux.** The exact names used by Lidarr are in Title_Case as shown in the tables below (for example, `Lidarr_EventType`, `Lidarr_Artist_Id`). Using lowercase versions (an older convention) won't work on Linux.
{.is-warning}

### Common variables (all events)

These three variables are present in every event.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | The event name: `Grab`, `AlbumDownload`, `Rename`, `TrackRetag`, `ArtistAdd`, `ArtistDeleted`, `AlbumDeleted`, `HealthIssue`, `HealthRestored`, `ApplicationUpdate`, `Test` |
| `Lidarr_InstanceName` | The Lidarr instance name (set in Settings → General) |
| `Lidarr_ApplicationUrl` | The configured application URL (set in Settings → General) |

### Grab

Fired when Lidarr sends a release to a download client.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `Grab` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Name` | Artist name |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type (for example, `Person`, `Group`) |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |
| `Lidarr_Release_AlbumCount` | Number of albums in this release |
| `Lidarr_Release_AlbumReleaseDates` | Comma-separated list of album release dates |
| `Lidarr_Release_AlbumTitles` | Pipe-separated list of album titles |
| `Lidarr_Release_AlbumOverviews` | Pipe-separated list of album overviews |
| `Lidarr_Release_AlbumMBIds` | Pipe-separated list of album MusicBrainz IDs |
| `Lidarr_Release_Title` | Release title as returned by the indexer |
| `Lidarr_Release_Indexer` | Indexer that found the release |
| `Lidarr_Release_Size` | Release size in bytes |
| `Lidarr_Release_Quality` | Quality name (for example, `FLAC`, `MP3-320`) |
| `Lidarr_Release_QualityVersion` | Quality revision version |
| `Lidarr_Release_ReleaseGroup` | Release group tag from the release title |
| `Lidarr_Release_IndexerFlags` | Indexer flags on the release |
| `Lidarr_Release_CustomFormat` | Pipe-separated list of matched custom format names |
| `Lidarr_Release_CustomFormatScore` | Total custom format score for this release |
| `Lidarr_Download_Client` | Name of the download client used |
| `Lidarr_Download_Client_Type` | Download client name (for example, `qBittorrent`, `SABnzbd`) |
| `Lidarr_Download_Id` | Download ID in the download client |

### On Import / On Upgrade

Fired after Lidarr has successfully imported a downloaded album into the library. `Lidarr_EventType` is `AlbumDownload` for both initial imports and upgrades.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `AlbumDownload` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Name` | Artist name |
| `Lidarr_Artist_Path` | Root path for this artist |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |
| `Lidarr_Album_Id` | Internal Lidarr ID for the album |
| `Lidarr_Album_Title` | Album title |
| `Lidarr_Album_Overview` | Album overview/description |
| `Lidarr_Album_MBId` | MusicBrainz release group ID |
| `Lidarr_AlbumRelease_MBId` | MusicBrainz release ID (specific pressing) |
| `Lidarr_Album_ReleaseDate` | Album release date |
| `Lidarr_Download_Client` | Name of the download client |
| `Lidarr_Download_Client_Type` | Download client name |
| `Lidarr_Download_Id` | Download ID in the download client |
| `Lidarr_AddedTrackPaths` | Pipe-separated list of imported track file paths |
| `Lidarr_DeletedPaths` | Pipe-separated list of file paths deleted/replaced during upgrade |
| `Lidarr_DeletedDateAdded` | Pipe-separated list of date-added values for deleted files |

### Rename

Fired after Lidarr renames one or more track files for an artist.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `Rename` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Name` | Artist name |
| `Lidarr_Artist_Path` | Root path for this artist |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |
| `Lidarr_TrackFile_Ids` | Comma-separated list of internal track file IDs Lidarr renamed |
| `Lidarr_TrackFile_Paths` | Pipe-separated list of new (current) paths after rename |
| `Lidarr_TrackFile_PreviousPaths` | Pipe-separated list of old paths before rename |

### Track Retag

Fired after Lidarr rewrites tags on one or more track files.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `TrackRetag` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Name` | Artist name |
| `Lidarr_Artist_Path` | Root path for this artist |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |
| `Lidarr_Album_Id` | Internal Lidarr ID for the album |
| `Lidarr_Album_Title` | Album title |
| `Lidarr_Album_Overview` | Album overview/description |
| `Lidarr_Album_MBId` | MusicBrainz release group ID |
| `Lidarr_AlbumRelease_MBId` | MusicBrainz release ID |
| `Lidarr_Album_ReleaseDate` | Album release date |
| `Lidarr_TrackFile_Id` | Internal track file ID |
| `Lidarr_TrackFile_TrackCount` | Number of tracks in this file |
| `Lidarr_TrackFile_Path` | Path to the track file |
| `Lidarr_TrackFile_TrackIds` | Comma-separated list of internal track IDs |
| `Lidarr_TrackFile_TrackNumbers` | Comma-separated list of track numbers |
| `Lidarr_TrackFile_TrackTitles` | Pipe-separated list of track titles |
| `Lidarr_TrackFile_Quality` | Quality name |
| `Lidarr_TrackFile_QualityVersion` | Quality revision version |
| `Lidarr_TrackFile_ReleaseGroup` | Release group tag |
| `Lidarr_TrackFile_SceneName` | Scene name of the source release |
| `Lidarr_Tags_Diff` | JSON diff of tag changes |
| `Lidarr_Tags_Scrubbed` | Whether Lidarr scrubbed existing tags (`True`/`False`) |

### Artist Added

Fired when you add an artist to Lidarr.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `ArtistAdd` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Title` | Artist name |
| `Lidarr_Artist_Path` | Root path for this artist |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |

### Artist Deleted

Fired when you remove an artist from Lidarr.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `ArtistDeleted` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Title` | Artist name |
| `Lidarr_Artist_Path` | Path Lidarr used for this artist |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |
| `Lidarr_Artist_DeletedFiles` | Whether files on disk were also deleted (`True`/`False`) |

### Album Deleted

Fired when you remove an album from Lidarr.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `AlbumDeleted` |
| `Lidarr_Artist_Id` | Internal Lidarr ID for the artist |
| `Lidarr_Artist_Name` | Artist name |
| `Lidarr_Artist_Path` | Root path for this artist |
| `Lidarr_Artist_MBId` | MusicBrainz artist ID |
| `Lidarr_Artist_Type` | Artist type |
| `Lidarr_Artist_Genres` | Pipe-separated list of genres |
| `Lidarr_Artist_Tags` | Pipe-separated list of tag labels |
| `Lidarr_Album_Id` | Internal Lidarr ID for the album |
| `Lidarr_Album_Title` | Album title |
| `Lidarr_Album_Overview` | Album overview/description |
| `Lidarr_Album_MBId` | MusicBrainz release group ID |
| `Lidarr_Album_ReleaseDate` | Album release date |
| `Lidarr_Artist_DeletedFiles` | Whether files on disk were also deleted (`True`/`False`) |

### Health Issue

Fired when Lidarr detects a health check failure.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `HealthIssue` |
| `Lidarr_Health_Issue_Level` | Severity level: `Ok`, `Notice`, `Warning`, or `Error` |
| `Lidarr_Health_Issue_Message` | Human-readable description of the issue |
| `Lidarr_Health_Issue_Type` | Name of the health check that fired |
| `Lidarr_Health_Issue_Wiki` | Wiki URL of this health issue, if one exists |

### Health Restored

Fired when a failing health check returns to a healthy state.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `HealthRestored` |
| `Lidarr_Health_Restored_Level` | Previous severity level |
| `Lidarr_Health_Restored_Message` | Description of the check that recovered |
| `Lidarr_Health_Restored_Type` | Name of the health check |
| `Lidarr_Health_Restored_Wiki` | Wiki URL of this health check |

### Application Update

Fired after Lidarr updates itself to a new version.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `ApplicationUpdate` |
| `Lidarr_Update_Message` | Update changelog message |
| `Lidarr_Update_NewVersion` | Version that was just installed |
| `Lidarr_Update_PreviousVersion` | Version Lidarr replaced |

### On Test

When you click **Test** in Settings → Connect, Lidarr calls the script with only the common variables set. Your script must exit cleanly (`0`) on this event.

| Environment Variable | Details |
|---|---|
| `Lidarr_EventType` | `Test` |

## Example scripts

The examples below cover the most common starting points. All shell examples check `Lidarr_EventType` and exit early on the `Test` event. This is the recommended pattern for any script that does real work.

### Log all variables to a file (shell)

The simplest useful script: dumps every `Lidarr_*` variable to a log file. Run this when you're building a new script and want to see exactly what data is available for a given event.

Save as an executable `.sh` file:

```shell
#!/bin/sh
# Dump all Lidarr environment variables to a log file.
# Useful for inspecting what's available before writing a real script.

LOG="/tmp/lidarr-events.log"

echo "---" >> "$LOG"
echo "$(date -Iseconds)  event=$Lidarr_EventType" >> "$LOG"
env | grep '^Lidarr_' | sort >> "$LOG"
```

Make it executable: `chmod +x /path/to/log-events.sh`

### Log all variables to a file (PowerShell)

```powershell
$logFile = "C:\Temp\lidarr-events.log"
$timestamp = Get-Date -Format "o"

Add-Content -Path $logFile -Value "---"
Add-Content -Path $logFile -Value "$timestamp  event=$env:Lidarr_EventType"

Get-ChildItem env: |
    Where-Object { $_.Name -like 'Lidarr_*' } |
    Sort-Object Name |
    ForEach-Object { Add-Content -Path $logFile -Value "$($_.Name)=$($_.Value)" }
```

### Discord webhook on import (shell)

Sends a message to a Discord channel when an album finishes importing.

```shell
#!/bin/sh
set -euo pipefail

# Exit cleanly on Test events
if [ "$Lidarr_EventType" = "Test" ]; then
    echo "Test event received. Exiting."
    exit 0
fi

# Only act on import events
if [ "$Lidarr_EventType" != "AlbumDownload" ]; then
    exit 0
fi

WEBHOOK_URL="https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"

MESSAGE="**$Lidarr_Artist_Name** - $Lidarr_Album_Title imported ($Lidarr_Release_Quality)"

curl -s -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}"
```

Replace `YOUR_WEBHOOK_URL` with your Discord webhook URL. In Discord, open channel settings → Integrations → Webhooks to create one.

> The message string above doesn't escape special characters. If your artist or album names can contain double-quotes or backslashes, use `jq` to build the JSON payload instead of constructing it manually.
{.is-info}

### Discord webhook on import (PowerShell)

```powershell
if ($env:Lidarr_EventType -eq "Test") { exit 0 }
if ($env:Lidarr_EventType -ne "AlbumDownload") { exit 0 }

$webhookUrl = "https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"
$message    = "**$env:Lidarr_Artist_Name** - $env:Lidarr_Album_Title imported ($env:Lidarr_Release_Quality)"

$body = @{ content = $message } | ConvertTo-Json
Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $body
```

### Trigger a Plex library scan on import (shell)

Tells Plex to scan the imported artist's folder after Lidarr finishes importing. Replace the placeholders with your Plex server URL and token.

```shell
#!/bin/sh
set -euo pipefail

if [ "$Lidarr_EventType" = "Test" ]; then exit 0; fi
if [ "$Lidarr_EventType" != "AlbumDownload" ]; then exit 0; fi

PLEX_URL="http://localhost:32400"
PLEX_TOKEN="YOUR_PLEX_TOKEN"
PLEX_SECTION_ID="YOUR_MUSIC_SECTION_ID"

# URL-encode the artist path for the Plex API
ENCODED_PATH=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$Lidarr_Artist_Path")

curl -s -X GET \
    "$PLEX_URL/library/sections/$PLEX_SECTION_ID/refresh?path=$ENCODED_PATH&X-Plex-Token=$PLEX_TOKEN"
```

To find your section ID, open `http://your-plex-server:32400/library/sections?X-Plex-Token=YOUR_TOKEN` in a browser and look for the music library. Find your Plex token in Plex Web → Settings → Troubleshooting → Get an Online Media Token.

> If Plex and Lidarr run in separate Docker containers, `localhost` won't reach the Plex container. Use the Plex container's name or IP on the shared Docker network instead.
{.is-info}

### Notify on health issues (shell)

Sends an alert when Lidarr raises a health warning or error. Useful for monitoring an unattended server.

```shell
#!/bin/sh
set -euo pipefail

if [ "$Lidarr_EventType" = "Test" ]; then exit 0; fi
if [ "$Lidarr_EventType" != "HealthIssue" ]; then exit 0; fi

# Only alert on Warning or Error, not Notice
if [ "$Lidarr_Health_Issue_Level" = "Ok" ] || [ "$Lidarr_Health_Issue_Level" = "Notice" ]; then
    exit 0
fi

WEBHOOK_URL="https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"
MESSAGE=":warning: Lidarr health issue [$Lidarr_Health_Issue_Level]: $Lidarr_Health_Issue_Message"

curl -s -X POST "$WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}"
```

## External resources

- [Lidarr/Lidarr: CustomScript.cs](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/Notifications/CustomScript/CustomScript.cs): the authoritative source for all environment variables, event types, and their values
- [RandomNinjaAtk/arr-scripts](https://github.com/RandomNinjaAtk/arr-scripts): extended container scripts for the LinuxServer.io Lidarr Docker image, covering automated downloads, format conversion, and beets pre-matching

## See also

- [Settings: Connect](/lidarr/settings#connections): where you register scripts in the Lidarr UI
- [Beets Integration](/lidarr/beets-integration): using a custom script to invoke beets for tag enrichment after import
