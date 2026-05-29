---
title: Lidarr Supported
description: List of supported music indexers, trackers, and download clients compatible with Lidarr
published: true
date: 2026-05-29T13:06:38.772Z
tags: lidarr, indexers, music, supported, download-clients, compatibility, trackers
editor: markdown
dateCreated: 2021-06-23T07:55:13.803Z
---

This page is the disambiguation target for all **More Info** links in the Lidarr UI. Each entry corresponds to a specific integration type.

> These integrations are built into Lidarr. More download clients and indexers (including slskd, Deezer, Tidal, and others) can be added via [plugins](/lidarr/plugins).
{.is-info}

# Download Clients

{#downloadclient}

- Deluge {#deluge}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Download Station {#torrentdownloadstation}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Download Station {#usenetdownloadstation}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Flood {#flood}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Hadouken {#hadouken}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- NZBGet {#nzbget}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- NZBVortex {#nzbvortex}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Pneumatic {#pneumatic}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- qBittorrent {#qbittorrent}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- rTorrent {#rtorrent}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- SABnzbd {#sabnzbd}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Torrent Blackhole {#torrentblackhole}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Transmission {#transmission}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- Usenet Blackhole {#usenetblackhole}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
- uTorrent {#utorrent}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
  - Due to uTorrent being adware and formerly spyware, it isn't recommended. Most users use qBittorrent.
- Vuze {#vuze}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)

# Indexers

{#indexer}

## Usenet

- Newznab {#newznab}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
  - Newznab is a standardised API used by many Usenet indexing sites. Many presets are available, but all require an API key. Indexer aggregators like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can manage more than one Newznab indexer from a single interface.

## Torrents

- FileList {#filelist}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Gazelle API {#gazelle}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
  - Used by Gazelle-based private trackers such as Redacted (formerly What.CD).
- Headphones VIP {#headphones}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- IP Torrents {#iptorrents}
  - Private Tracker
  > IP Torrents' native implementation doesn't support Search.
  {.is-info}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Redacted {#redacted}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Torrent RSS Feed {#torrentrssindexer}
  - Generic torrent RSS feed parser.
  > The RSS feed must contain a `pubdate`. The release size is recommended as well.
  {.is-info}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- TorrentLeech {#torrentleech}
  - Private Indexer
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Torznab {#torznab}
  - Torznab is a standardised API for torrent indexers, based on the Newznab specification with torrent-specific extensions. It supports both RSS feeds and backlog searching. Torznab is primarily supported by [Prowlarr](/prowlarr) and [Jackett](https://github.com/Jackett/Jackett).
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)

# Notifications

{#notification}

- Boxcar {#boxcar}
- Custom Script {#customscript}
  - Runs a user-supplied script when a specified event occurs. See [Custom Scripts](/lidarr/custom-scripts) for the full list of available environment variables and example scripts.
- Discord {#discord}
  - Sends notifications to a Discord channel via webhook. One of the most commonly used notification integrations.
- Email {#email}
  - Sends notification emails. If you use Gmail, enable App Passwords under your Google account security settings rather than using your main password.
  > You can use a display name with the address: `Your Name <email@example.com>`
  {.is-info}
- Emby (Media Browser) {#mediabrowser}
  - Notifies an Emby server to refresh its music library after a track is imported or upgraded.
- Gotify {#gotify}
- Join {#join}
- Kodi {#xbmc}
  - Notifies a Kodi instance to refresh its music library after a track is imported or upgraded. Kodi is a free, open-source media centre application.
- Mailgun {#mailgun}
- Notifiarr {#notifiarr}
  - See [Notifiarr](/useful-tools#notifiarr-fka-discord-notifier)
- Plex Media Server {#plexserver}
  - Notifies a Plex Media Server to refresh its music library after a track is imported or upgraded.
- Prowl {#prowl}
- Pushbullet {#pushbullet}
- Pushover {#pushover}
- SendGrid {#sendgrid}
- Slack {#slack}
- Subsonic {#subsonic}
- Synology Indexer {#synologyindexer}
- Telegram {#telegram}
- Webhook {#webhook}

# Lists

{#importlist}

- Headphones {#headphonesimport}
  - [More Info](https://github.com/rembo10/headphones)
- Last.fm Tag {#lastfmtag}
- Last.fm User {#lastfmuser}
- Lidarr {#lidarrimport}
  - Sync monitored artists from another Lidarr instance.
- Lidarr Lists {#lidarrlists}
- MusicBrainz Series {#musicbrainzseries}
  - [More Info](https://musicbrainz.org/doc/Series)
- Spotify Followed Artists {#spotifyfollowedartists}
- Spotify Playlists {#spotifyplaylist}
- Spotify Saved Albums {#spotifysavedalbums}

# Metadata

{#metadata}

- Kodi (XBMC) / Emby {#xbmcmetadata}
  - Generates `.nfo` sidecar files for artist and album folders, compatible with Kodi and Emby/Jellyfin.
- Roksbox {#roksboxmetadata}
- WDTV {#wdtvmetadata}
