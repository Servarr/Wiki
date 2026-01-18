---
title: Lidarr Plugins
description: Basic Setup and Details for Plugins beta Testing Branch
published: true
date: 2026-01-18T20:59:54.633Z
tags: lidarr, installation, plugins, configuration
editor: markdown
dateCreated: 2025-01-18T16:05:16.687Z
---

# Lidarr Plugins Branch

## What are plugins

Lidarr plugins allow users to extend the capability of Lidarr to include new indexers and download clients, including peer-to-peer networks and common streaming services.

Plug-in capabilities are now part of the main branch of Lidarr, but only in the `nightly` branch. Both Hotio and Linuxserver are updated.

> You cannot go back to a mainline Lidarr branch (master/develop) without restoring a database prior to the `plugins` or `nightly` branch. Errors will be relating to the protocol such as `Error parsing column 10 (Protocol=TorrentDownloadProtocol - String)` or being unable to enable torrent/usenet in a Delay Profile
{.is-danger}

### How To Install Plugins

### Native Installs -Windows, Mac, and Linux

- Navigate to `/settings/general`
- Show Advanced if not already enabled
- Scroll down to Updates. Type in `nightly`
- Save changes.
- Update Lidarr

### Docker

Update your Docker Compose file to use the following image, pull, and recreate your Lidarr container.

#### Hotio

```yaml
image: ghcr.io/hotio/lidarr:nightly
```

#### LinuxServer.io

```yaml
image: lscr.io/linuxserver/lidarr:nightly
```

### Manually Installing

- See the [Installation Docs](/lidarr/installation/) and simply change the branch in the url noted in the install docs from `master` to `nightly`, otherwise following the docs as-is.

### Post Install

- Once you have changed branches, navigate to `/system/plugins`. You will have the option to enter the URL of the GitHub repository containing the plugin. Enter the URL and select Install. You can observe the progress in the lower left corner. The installation will take several seconds depending your installation.
- If `/system/plugins` does not appear in the menu, ensure that `/system/updates` shows that plugins has a status of `Currently Installed`.

## Next Steps

- Install the plugin to Lidarr using the new Plugin Lidarr Page and the plugin's documentation.
- Restart Lidarr to complete plugin installation

> Plugin updates do not occur automatically
{.is-info}

# Plugins

> Both plugins and this documentation are community-driven. There are no official recommendations at this time, and each plugin is supported by its developer.
{.is-info}

## ta264/deemix

[Deemix plugin by ta264](https://github.com/ta264/Lidarr.Plugin.Deemix)

This plugin enables Lidarr to search Deezer using Deemix. You must have a working Lidarr installation from the plugins branch, a working Deemix container, and an ARL from Deezer to use this plugin. In order to get FLAC files, your ARL would need to be for a hi-fi account type on Deezer.

[Deemix](https://github.com/bambanah/deemix)

## allquiet-hub/Lidarr.Plugin.Slskd

[Slskd (Soulseek) by Allquiet](https://github.com/allquiet-hub/Lidarr.Plugin.Slskd)

### Prerequisites

This plugin enables Lidarr to search Soulseek using Slskd. You must have a working Lidarr installation from the plugins branch and a working Slskd installation to use this plugin.

To generate the Api Key necessary for the communication to the Slskd app follow the steps [here on the developer's repository](https://github.com/slskd/slskd/blob/master/docs/config.md#authentication)

### Post-Install Configuration

#### Download Client

Once the plugin is installed, Slskd can be added as a download client.

- Navigate to `/settings/downloadclients`, and select the <kb>+</kb> button under Download clients. Slskd will appear at the bottom under the Other section.
- Enter the correct hostname.
- Enter the API key
- Select the Test button.
- If the Test returns a green checkmark, select Save.

### Indexer

To search, Slskd must also be added as an Indexer.

- Navigate to `/settings/indexers`, and select the <kb>+</kb> button under Indexers. Slskd will appear at the bottom under the Other section.
- Enter the correct URL.
- Enter the API key.
- Enter a '0' (Key) and your Soulseek username (Value) for 'Ignored Users'.
- Select the Test button.
  - The Indexer test will send a test search to slskd for "Silent Partner Chances".
- If the Test returns a green checkmark, select Save.

### Delay Profile

- Navigate to `settings/profiles` and scroll down to Delay Profiles
- Select the wrench icon on the right side of the profile you wish to use slskd with. Most installations will only have a Default profile.
- Select the Slskd protocol, and select Save.

### Verification

Slskd is now available for both automatic and interactive searches. During Lidarr search operations you can view the slskd `/searches` as they occur and monitor `/downloads`.

## lucapolesel/Lidarr.Plugin.Slskd

[Slskd (Soulseek) by lucapolesel](https://github.com/lucapolesel/Lidarr.Plugin.Slskd)

## TrevTV

TrevTV develops specialized Lidarr plugins for direct music platform integration.

### Deezer

[Deezer by TrevTV](https://github.com/TrevTV/Lidarr.Plugin.Deezer) is a Lidarr plugin that provides direct Deezer integration:

- **Indexer & Download Client**: Searches and downloads from Deezer without intermediaries like Deemix
- **Flexible Auth**: Automatic ARL selection or manual entry

### Tidal

[Tidal by TrevTV](https://github.com/TrevTV/Lidarr.Plugin.Tidal) is a Lidarr plugin for Tidal integration:

- **OAuth2 Authentication**: Secure token-based login flow
- **FFmpeg Conversion**: Optional audio processing
- *Note: Shows only estimated file sizes*

### Qobuz

[Qobuz by TrevTV](https://github.com/TrevTV/Lidarr.Plugin.Qobuz) is a Lidarr plugin for Qobuz integration:

- **Dual Authentication**: Email/MD5 password or user token login
- **Hi-Res Handling**: Automatically falls back to 96kHz when needed

### Configuration Essentials

1. **Delay Profiles**: All plugins require Delay Profile activation
2. **Lyrics Support**:
   - Enable `.lrc` file support in:
     - Each plugin's download client settings
     - Lidarr's Media Management → "Import Extra Files" (add `lrc`)
3. **Docker Requirements**:
   - FFmpeg required for Tidal conversions
   - Custom app IDs may be needed for Qobuz authentication

## TypNull/Tubifarry

[Tubifarry by TypNull](https://github.com/TypNull/Tubifarry) is a *multi-feature* plugin that extends Lidarr's capabilities with these key functions:

### Core Features

- **YouTube Music Downloader**:
  - Downloads music from YouTube (requires cookies/trusted sessions for reliability)
  - Optional FFmpeg audio extraction (recommended for compatibility)
- **Soulseek Integration**:
  - Slskd support as both indexer and download client

### Toolbox Additions

- **Soundtrack Importer**: Fetches soundtracks from Sonarr/Radarr via *Arr-Soundtracks* import list
- **Queue Cleaner**: Auto-manages failed imports (blocklist/rename/retry)
- **Codec Tinker**: Converts audio formats using FFmpeg rules (e.g., `wav→flac`, `AAC→MP3`)
- **Lyrics Fetcher**: Adds time-synced lyrics (.lrc files or embedded metadata)
- **Search Sniper**: Automates batch searching of large wanted lists
- **MetaMix**: Aggregates metadata from different sources (experimental)

### Branches

- Certain features are exclusively available on specific branches.
- To install these:
  1. First ensure you have the stable version installed.
  2. Then switch to your desired branch using its URL.
- *Example:* The development version can be found at:
  `https://github.com/TypNull/Tubifarry/tree/develop`

> See the [Tubifarry README](https://github.com/TypNull/Tubifarry) for advanced configuration, troubleshooting, and feature deep-dives.
{.is-info}
