---
title: Lidarr Supported
description: List of supported music indexers, trackers, and download clients compatible with Lidarr
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, indexers, music, supported, download-clients, compatibility, trackers
editor: markdown
dateCreated: 2021-06-23T07:55:13.803Z
---

This page is the disambiguation target for all **More Info** links in the Lidarr UI. Each entry corresponds to a specific integration type.

> Lidarr includes these integrations natively. Add more download clients and indexers (including slskd, Deezer, Tidal, and others) via [plugins](/lidarr/plugins).
{.is-info}

## Download Clients

{#downloadclient}

- Aria2 {#aria2}
  - Open-source, multi-protocol download utility supporting HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink.
  - [Refer to the Settings Page](/lidarr/settings#download-clients)
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
- Freebox Download {#torrentfreeboxdownload}
  - Download client built into Free's Freebox home router/gateway.
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

- Apprise {#apprise}
  - Allows notifications to be sent to many popular notification services via a single interface.
- Custom Script {#customscript}
  - Runs a user-supplied script when a specified event occurs. See [Custom Scripts](/lidarr/custom-scripts) for the full list of available environment variables and example scripts.
- Discord {#discord}
  - Sends notifications to a Discord channel via webhook. One of the most commonly used notification integrations.
- Email {#email}
  - Sends notification emails. If you use Gmail, enable App Passwords under your Google account security settings rather than using your main password.
  > You can use a display name with the address: `Your Name <email@example.com>`
  {.is-info}
- Emby / Jellyfin {#mediabrowser}
  - Notifies an Emby or Jellyfin server to refresh its music library after a track is imported or upgraded.
- Gotify {#gotify}
  - Self-hosted push notification server.
- Join {#join}
  - Push notification service for Android devices.
- Kodi {#xbmc}
  - Notifies a Kodi instance to refresh its music library after a track is imported or upgraded. Kodi is a free, open-source media centre application.
- Mailgun {#mailgun}
  - Transactional email API service for sending notification emails.
- Notifiarr {#notifiarr}
  - See [Useful Tools — Notifiarr](/useful-tools#notifiarr-fka-discord-notifier)
- ntfy.sh {#ntfy}
  - Self-hostable push notification service with a simple HTTP API.
- Plex Media Server {#plexserver}
  - Notifies a Plex Media Server to refresh its music library after a track is imported or upgraded.
- Prowl {#prowl}
  - iOS push notification service.
- Pushbullet {#pushbullet}
  - Cross-platform notification and file sharing service.
- Pushcut {#pushcut}
  - iOS app for automation and notifications.
- Pushover {#pushover}
  - Simple push notification service for mobile devices.
- SendGrid {#sendgrid}
  - Transactional email API service for sending notification emails.
- Signal {#signal}
  - Sends notifications via the Signal messaging app. Requires a running [Signal-CLI](https://github.com/AsamK/signal-cli) instance.
- Simplepush {#simplepush}
  - Simple push notification service requiring no account.
- Slack {#slack}
  - Sends notifications to a Slack channel via webhook.
- Subsonic {#subsonic}
  - Notifies a Subsonic-compatible server to update its music library.
- Synology Indexer {#synologyindexer}
  - Triggers a Synology NAS media indexer scan after a track is imported or upgraded.
- Telegram {#telegram}
  - Sends notifications to a Telegram chat or channel via a bot.
- Twitter {#twitter}
  - Posts notifications to a Twitter account.
- Webhook {#webhook}
  - Sends an HTTP POST request to a configured URL when events occur.

## Lists

{#importlist}

- Custom List {#customlist}
  - Import artists from a manually maintained list.
- Headphones {#headphonesimport}
  - Import artists from a [Headphones](https://github.com/rembo10/headphones) instance.
- Last.fm Tag {#lastfmtag}
  - Import artists via a Last.fm genre or style tag.
- Last.fm User {#lastfmuser}
  - Import artists from a Last.fm user's listening history or loved tracks.
- Lidarr {#lidarrimport}
  - Sync monitored artists from another Lidarr instance.
- Lidarr Lists {#lidarrlists}
  - Import artists from curated Lidarr community lists.
- MusicBrainz Series {#musicbrainzseries}
  - Import artists belonging to a [MusicBrainz Series](https://musicbrainz.org/doc/Series).
- Spotify Followed Artists {#spotifyfollowedartists}
  - Import artists you follow on Spotify.
- Spotify Playlists {#spotifyplaylist}
  - Import artists from your Spotify playlists.
- Spotify Saved Albums {#spotifysavedalbums}
  - Import artists from your Spotify saved albums.

## Metadata

{#metadata}

- Kodi (XBMC) / Emby {#xbmcmetadata}
  - Generates `.nfo` sidecar files for artist and album folders, compatible with Kodi and Emby/Jellyfin.
- Roksbox {#roksboxmetadata}
  - Generates metadata files compatible with Roksbox media players.
- WDTV {#wdtvmetadata}
  - Generates metadata files compatible with WD TV media players.
