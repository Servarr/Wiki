---
title: Lidarr Supported
description: 
published: true
date: 2022-01-07T19:44:46.260Z
tags: 
editor: markdown
dateCreated: 2021-06-23T07:55:13.803Z
---

> This page is a work in progress and requires additional effort.{.is-warning}

This page is the disambiguation page for all "supported" wiki links (i.e. typically `More Info` in the UI).

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
  - Due to uTorrent being adware and formerly spyware, it is not reconmended. Most users use qBittorrent.
- Vuze {#vuze}
  - [Refer to the Settings Page](/lidarr/settings#download-clients)

# Indexers

{#indexer}

## Usenet

- Newznab {#newznab}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can provide advanced capabilities such as stat tracking.

## Torrents

- FileList {#filelist}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Gazelle API {#gazelle}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Headphones VIP {#headphones}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- IP Torrents {#iptorrents}
  - Private Tracker
  > IP Torrents' native implementation does not support Search {.is-info}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- omgwtfnzbs {#omgwtfnzbs}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Rarbg {#rarbg}
  - Public Tracker
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
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API  specification is shared with nZEDb)
  - This is primarily only supported by [Prowlarr](/prowlarr) and [Jackett](https://github.com/Jackett/Jackett)
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)
- Waffles {#waffles}
  - [Refer to the Settings Page](/lidarr/settings#indexer-settings)

# Notifications

{#notification}

- Boxcar {#boxcar}
- Custom Script {#customscript}
  - This allows you to make a custom script for when a particular action happens this script will run. See [Custom Scripts](/lidarr/custom-scripts) for more details.
- Discord {#discord}
  - By far one of the most common ways to push notifications of actions happening on your Lidarr
- Email {#email}
  - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.

 > You can use a "pretty address" like `SomePrettyName <email@example.org>` {.is-info}

- Emby (Media Browser) {#mediabrowser}
- Gotify {#gotify}
- Join {#join}
- Kodi {#xbmc}
  - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customizable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. By adding Kodi as a connection you can update Kodi's library when a new song has been added to Lidarr.
- Mailgun {#mailgun}
- Notifiarr {#notifiarr}
  - See the entry on [Useful Tools - Notifiarr](/useful-tools#notifiarr-fka-discord-notifier)
- Plex Media Server {#plexserver}
  - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded episode is available.
- Prowl {#prowl}
- Pushbullet {#pushbullet}
- Pushover {#pushover}
- SendGrid {#sendgrid}
- Slack {#slack}
- Subsonic {#subsonic}
- Synology Indexer {#synologyindexer}
- Telegram {#telegram}
- Twitter {#twitter}
  - See this [Tips and Tricks entry](/useful-tools#twitter)
- Webhook {#webhook}

# Lists

{#importlist}

- Headphones {#headphonesimport}
- Last.fm Tag {#lastfmtag}
- Last.fm User {#lastfmuser}
- Lidarr {#lidarrimport}
- Lidarr Lists {#lidarrlists}
- MusicBrainz Series {#musicbrainzseries}
- Spotify Followed Artists {#spotifyfollowedartists}
- Spotify Playlists {#spotifyplaylist}
- Spotify Saved Albums {#spotifysavedalbums}

# Metadata

{#metadata}

- Kodi (XBMC) / Emby {#xbmcmetadata}
- Roksbox {#roksboxmetadata}
- WDTV {#wdtvmetadata}
