---
title: Lidarr Supported
description: List of supported music indexers, trackers, and download clients compatible with Lidarr
published: true
date: 2026-06-06T14:12:58.851Z
tags: lidarr, indexers, music, supported, download-clients, compatibility, trackers
editor: markdown
dateCreated: 2021-06-23T07:55:13.803Z
---

This page is the disambiguation target for all **More Info** links in the Lidarr UI. Each entry corresponds to a specific integration type.

> Lidarr includes these integrations natively. Add more download clients and indexers (including slskd, Deezer, Tidal, and others) via [plugins](/lidarr/plugins).
{.is-info}

## Download Clients

{#downloadclient}

- Deluge {#deluge}
  - Open-source, cross-platform BitTorrent client with a web UI and remote daemon.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Download Station {#torrentdownloadstation}
  - Synology NAS built-in download manager. Handles torrent downloads natively without a separate client.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Download Station {#usenetdownloadstation}
  - Synology NAS built-in download manager. Handles Usenet downloads natively without a separate client.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Flood {#flood}
  - Modern web UI for rTorrent (and other torrent backends) with a clean interface and real-time updates.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Hadouken {#hadouken}
  - Open-source BitTorrent client with a web UI.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- NZBGet {#nzbget}
  - Efficient, low-resource Usenet downloader. A common alternative to SABnzbd.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- NZBVortex {#nzbvortex}
  - Mac-native Usenet client.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Pneumatic {#pneumatic}
  - NZB client that drops files into a watch folder. Primarily used with Kodi.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- qBittorrent {#qbittorrent}
  - Popular open-source BitTorrent client with a web UI. Widely recommended as the default choice.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- rTorrent {#rtorrent}
  - Terminal-based BitTorrent client, often paired with the ruTorrent web UI.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- SABnzbd {#sabnzbd}
  - Open-source Usenet client. One of the most widely used Usenet downloaders.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Torrent Blackhole {#torrentblackhole}
  - Watches a folder for `.torrent` files. Use this if your torrent client doesn't have a direct API integration.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Transmission {#transmission}
  - Lightweight, cross-platform BitTorrent client with a web UI. Popular on Linux and NAS devices.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Usenet Blackhole {#usenetblackhole}
  - Watches a folder for `.nzb` files. Use this if your Usenet client doesn't have a direct API integration.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- uTorrent {#utorrent}
  - Avoid uTorrent. It's adware and has a history of including spyware. Most users choose qBittorrent.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Vuze {#vuze}
  - Java-based BitTorrent client with an advanced feature set including swarm merging and built-in search.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)

## Indexers

{#indexer}

### Usenet

- Newznab {#newznab}
  - Standardised API used by most Usenet indexing sites. Many presets are available, but all require an API key. Indexer aggregators like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can manage more than one Newznab indexer from a single interface.
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)

### Torrents

- FileList {#filelist}
  - Private torrent tracker with a broad content library.
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Gazelle API {#gazelle}
  - Used by Gazelle-based private trackers such as Redacted (formerly What.CD).
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Headphones VIP {#headphones}
  - Legacy music indexer aggregator from the Headphones era.
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- IP Torrents {#iptorrents}
  - Private tracker.
  > IP Torrents' native implementation doesn't support Search.
  {.is-info}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - Public Japanese torrent indexer. Covers anime, manga, and music.
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Redacted {#redacted}
  - Premier private music tracker. Requires an account with the Redacted community.
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Torrent RSS Feed {#torrentrssindexer}
  - Generic torrent RSS feed parser.
  > The RSS feed must contain a `pubdate`. The release size is recommended as well.
  {.is-info}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- TorrentLeech {#torrentleech}
  - Private tracker.
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Torznab {#torznab}
  - Standardised API for torrent indexers, based on the Newznab specification with torrent-specific extensions. Supports RSS feeds and backlog searching. Primarily provided by [Prowlarr](/prowlarr) and [Jackett](https://github.com/Jackett/Jackett).
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)

## Notifications

{#notification}

- Boxcar {#boxcar}
  - iOS push notification service.
- Custom Script {#customscript}
  - Runs a user-supplied script when a specified event occurs. See [Custom Scripts](/lidarr/custom-scripts) for the full list of available environment variables and example scripts.
- Discord {#discord}
  - Sends notifications to a Discord channel via webhook. One of the most commonly used notification integrations.
- Email {#email}
  - Sends notification emails. If you use Gmail, enable App Passwords under your Google account security settings rather than using your main password.
  > You can use a display nam
