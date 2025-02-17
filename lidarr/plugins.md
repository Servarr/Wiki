---
title: How Do I Install Plugins
description: Instructions on installing plugins in Lidarr
published: true
date: 2025-02-17T14:46:27.834Z
tags: lidarr, plugins
editor: markdown
dateCreated: 2025-01-18T16:05:16.687Z
---

# How Do I Install Plugins

## Plugin Branch

Lidarr plug-ins allow users to extend the capability of Lidarr to include new indexers and download clients, including peer-to-peer networks and common streaming services.

Plug-in capabilities are currently only available on the `plugins` branch.

> You cannot go back to a mainline Lidarr branch (master/develop/nightly) without restoring a database prior to the `plugins` branch
{.is-danger}

### Native Installs -Windows, Mac, and Linux

- Navigate to `/settings/general` 
- Show Advanced if not already enabled
- Scroll down to Updates. Type in `plugins`
- Save changes.
- Update Lidarr

### Docker

Update your Docker Compose file to use the following image, pull, and recreate your Lidarr container. 

#### Hotio

```yaml
image: ghcr.io/hotio/lidarr:pr-plugins
```

#### LinuxServer.io

```yaml
image: ghcr.io/linuxserver-labs/prarr:lidarr-plugins
```

- Once you have changed branches, navigate to `/system/plugins`. You will have the option to enter the URL of the GitHub repository containing the plugin. Enter the URL and select Install. You can observe the progress in the lower left corner. The installation will take several seconds depending your installation. 
- If `/system/plugins` does not appear in the menu, ensure that `/system/updates` shows that plugins has a status of `CurrentlyInstalled`.
- If the plugins rebase is older than the current version of lidarr you have installed, it won't install this way. Instead, you will need to download the plugins branch install file directly and install it over your lidarr setup. For Windows, the link is [here](https://lidarr.servarr.com/v1/update/plugins/updatefile?os=windows&runtime=netcore&arch=x64&installer=true).

After completing the installation, Lidarr needs to be restarted for the plugin to work properly. The restart procedure varies depending on the platform used.

> Plugin updates do not occur automatically 
{.is-info}

# Plugins

> Both plugins and this documentation are community-driven. There are no official recommendations at this time, and each plugin is supported by its developer.
{.is-info}

## ta264/deemix

[Deemix plugin by ta264](https://github.com/ta264/Lidarr.Plugin.Deemix)

This plugin enables Lidarr to search Deezer using Deemix. You must have a working Lidarr installation from the plugins branch, a working Deemix container, and an ARL from Deezer to use this plugin. In order to get FLAC files, your ARL would need to be for a hi-fi account type on Deezer.

[Deemix for Lidarr by Codefaux](https://github.com/codefaux/deemix-for-lidarr/)

## allquiet-hub/Lidarr.Plugin.Slskd

[Slskd (Soulseek) by Allquiet](https://github.com/allquiet-hub/Lidarr.Plugin.Slskd)

### Prerequisites 

This plugin enables Lidarr to search Soulseek using Slskd. You must have a working Lidarr installation from the plugins branch and a working Slskd installation to use this plugin.

To generate the Api Key necessary for the communication to the Slskd app follow the steps [here on the developer's respository](https://github.com/slskd/slskd/blob/master/docs/config.md#authentication)

### Configuration

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

## TrevTV/Lidarr.Plugin.Tidal

[Tidal by TrevTV](https://github.com/TrevTV/Lidarr.Plugin.Tidal)

## TrevTV/Lidarr.Plugin.Qobuz

[Qobuz by TrevTV](https://github.com/TrevTV/Lidarr.Plugin.Qobuz)

## TypNull/Tubifarry

[Tubifarry by TypeNull](https://github.com/TypNull/Tubifarry)

