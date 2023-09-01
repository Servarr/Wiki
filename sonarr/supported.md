---
title: Sonarr Supported
description: 
published: true
date: 2023-09-01T16:44:31.667Z
tags: 
editor: markdown
dateCreated: 2021-06-23T07:55:33.769Z
---

> This page is a work in progress and requires additional effort. {.is-warning}

This page is the disambiguation page for all "supported" wiki links (i.e. typically `More Info` in the UI).

# Download Clients

{#downloadclient}

- Aria2 {#aria2}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Deluge {#deluge}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Download Station {#torrentdownloadstation}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Download Station {#usenetdownloadstation}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Flood {#flood}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Hadouken {#hadouken}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- NZBGet {#nzbget}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- NZBVortex {#nzbvortex}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Pneumatic {#pneumatic}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- qBittorrent {#qbittorrent}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- rTorrent {#rtorrent}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- SABnzbd {#sabnzbd}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Torrent Blackhole {#torrentblackhole}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Transmission {#transmission}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- Usenet Blackhole {#usenetblackhole}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
- uTorrent {#utorrent}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)
  - Due to uTorrent being adware and formerly spyware, it is not recommended. Most users use Qbittorrent
- Vuze {#vuze}
  - [Refer to the Settings Page](/sonarr/settings#download-clients)

# Indexers

{#indexer}

## Usenet

- Fanzub {#fanzub}
  - Usenet Indexer for Japanese Media (Anime) exclusively.
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- Newznab {#newznab}
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can provide advanced capabilities such as stat tracking.
- omgwtfnzbs {#omgwtfnzbs}
  - A defunct legacy implementation of a private usenet indexer. Use Newznab instead.
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)

## Torrents

- BroadcasTheNet (BTN) {#broadcasthenet}
  - Private Tracker
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- FileList {#filelist}
  - Private Tracker
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- HDBits {#hdbits}
  - Private Tracker
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- IP Torrents {#iptorrents}
  - Private Tracker
  > IP Torrents' native implementation does not support Search. Use it via Prowlarr or Jackett as torznab instead {.is-info}
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - Torrent Tracker for Japanese Media (Anime) exclusively.
  - Nyaa only supports search for Anime Series Types
  - Known Issues exist with the native Sonarr version
    - [Nyaa seeders/leechers not parsed properly anymore. #4614](https://github.com/Sonarr/Sonarr/issues/4614)
      - This can be fixed when / if [Pull Request #4637](https://github.com/Sonarr/Sonarr/pull/4637) is merged
  - > Nyaa frowns upon automation and frequently will ban your IP. {.is-warning}
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- Rarbg {#rarbg}
  - Public Tracker
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- Torrent RSS Feed {#torrentrssindexer}
  - Generic torrent RSS feed parser.
  > The RSS feed must contain a `pubdate`. The release size is recommended as well.
  {.is-info}
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- TorrentLeech {#torrentleech}
  - Private Indexer
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)
- Torznab {#torznab}
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API  specification is shared with nZEDb)
  - This is primarily only supported by [Prowlarr](/prowlarr) and [Jackett](https://github.com/Jackett/Jackett)
  - [Refer to the Settings Page](/sonarr/settings#indexer-settings)

> Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments, etc.
> Please review your tracker rules and etiquette, keep your community alive.
> We’re not responsible if your account is banned for disobeying rules or accruing Hit and Runs (HnRs)/low-ratio.
{.is-warning}

# Notifications

{#notification}

- Boxcar {#boxcar}
- Custom Script {#customscript}
  - This allows you to make a custom script for when a particular action happens this script will run. See [Custom Scripts](/sonarr/custom-scripts) for more details.
- Discord {#discord}
  - By far one of the most common ways to push notifications of actions happening on your Sonarr
  - Supported field types:
  `Overview, Rating, Genres, Quality, Group, Size, Links, Release, Poster, Fanart, CustomFormats, CustomFormatScore, Indexer`
- Email {#email}
  - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.

> You can use a "pretty address" like `SomePrettyName <email@example.org>` {.is-info}

- Emby {#mediabrowser}
- Gotify {#gotify}
- Join {#join}
- Kodi {#xbmc}
  - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customizable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. By adding Kodi as a connection you can update Kodi's library when a new episode has been added to Sonarr.
- Mailgun {#mailgun}
- Plex Home Theater {#plexhometheater}
  - Depreciated
- Plex Media Center {#plexclient}
  - Depreciated
- Plex Media Server {#plexserver}
  - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded episode is available.
  - This is rarely needed and is only required if Plex is unable to watch the file system for changes.
  - In the handful of situations where Plex is unable to watch the file system using ionotify - such as certain types of remote mounts and a handful of older network mounts - it is suggested to use the app plexautoscan rather than the Plex connection

> Note that this may trigger a full library scan for the library/root folder the series is in.  It is strongly suggested to use the native Plex functionality that just watches the file system or to use a tool like [plexautoscan](https://github.com/l3uddz/plex_autoscan)
{.is-warning}

- Prowl {#prowl}
- Pushbullet {#pushbullet}
- Pushcut {#pushcut}
- Pushover {#pushover}
- SendGrid {#sendgrid}
- Slack {#slack}
- Synology Indexer {#synologyindexer}
- Telegram {#telegram}
- Twitter {#twitter}
  - See this [Tips and Tricks entry](/useful-tools#twitter)
- Webhook {#webhook}

# Lists

{#importlist}

- Sonarr {#sonarrimport}
  - TRaSH has [a guide](https://trash-guides.info/Sonarr/Tips/Sync-2-radarr-sonarr/) for syncing two instances
- Plex Watchlist {#pleximport}
  - Simply add a Plex watchlist for the authenticated Plex user to Radarr. Note that it's required that your list contain shows on it.
  - To have multiple user's watchlists you'll need to add each user's lists and authenticate with their Plex user.
- Trakt List {#traktlistimport}
  - Username - Ensure you enter the actual username of the user and not the user's name
  - List - Ensure you use the list name as presented in the list URL
  - Example: `https://trakt.tv/users/some-user-name/lists/trakt-list-name?sort=rank,asc`
    - Username: `some-user-name`
    - List: `trakt-list-name`
- Trakt Popular List {#traktpopularimport}
- Trakt User {#traktuserimport}

> Trakt lists should contain shows, not individual episodes. Sonarr will only match and add shows.
{.is-info}

# Metadata

{#metadata}

- Kodi (XBMC) / Emby {#xbmcmetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Series Metadata - Create a `tvshow.nfo` with full series metadata
  - (Advanced Option) Series Metadata URL - Create tvshow.nfo with TheTVDb series URL
  - Episode Metadata - Create `<filename>.nfo` for each episode
  - Series Images - Create various Series images including posters and banners named as `poster.jpg` and `banner.jpg`
  - Season Images - Create various Season images including posters and banners named as `season##-poster.jpg` and `season##-banner.jpg`
  - Episode Images - Create various Episode images such as thumnbnails named as named as `<filename>-thumb.jpg`
- Roksbox {#roksboxmetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Episode Metadata - Create `Season##\<filename>.xml` for each episode
  - Series Images - Create `Series Title.jpg`
  - Season Images - Create `Season ##.jpg`
  - Episode Images - Create `Season##\<filename>.jpg`
- WDTV {#wdtvmetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Episode Metadata - Create `Season##\<filename>.xml` for each episode
  - Series Images - Create `folder.jpg`
  - Season Images - Create `Season ##\folder.jpg`
  - Episode Images - Create `Season##\<filename>.metathumb`
