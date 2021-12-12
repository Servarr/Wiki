---
title: Readarr Supported
description: 
published: true
date: 2021-12-12T02:35:15.690Z
tags: 
editor: markdown
dateCreated: 2021-06-23T07:55:28.684Z
---

> This page is a work in progress and requires additional effort.{.is-warning}

This page is the disambaguation page for all "supported" wiki links (i.e. typically more info in the UI).

# Download Clients

{#downloadclient}

- Deluge {#deluge}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Download Station {#torrentdownloadstation}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Download Station {#usenetdownloadstation}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Flood {#flood}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Hadouken {#hadouken}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- NZBGet {#nzbget}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- NZBVortex {#nzbvortex}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Pneumatic {#pneumatic}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- qBittorrent {#qbittorrent}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- rTorrent {#rtorrent}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- SABnzbd {#sabnzbd}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Torrent Blackhole {#torrentblackhole}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Transmission {#transmission}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- Usenet Blackhole {#usenetblackhole}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
- uTorrent {#utorrent}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
  - Due to utorrent being adware and formerly spyware, it is not reconmended. Most users use Qbitorrent
- Vuze {#vuze}
  - [Refer to the Settings Page](/radarr/settings#download-clients)

# Indexers

{#indexer}

## Usenet

- Newznab {#newznab}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can provide advanced capabilites such as stat tracking.
- omgwtfnzbs {#omgwtfnzbs}
  - A Private usenet indexer
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)

## Torrents

- FileList {#filelist}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- Gazelle API {#gazelle}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- IP Torrents {#iptorrents}
  - Private Tracker
  - > Does not support Search {.is-info}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- Rarbg {#rarbg}
  - Public Tracker
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- Torrent RSS Feed {#torrentrssindexer}
  - Generic torrent RSS feed parser.
  > The RSS feed must contain a `pubdate`. The release size is recommended as well.
  {.is-info}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- TorrentLeech {#torrentleech}
  - Private Indexer
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- Torznab {#torznab}
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API  specification is shared with nZEDb)
  - This is primarily only supported by [Prowlarr](/prowlarr) and [Jackett](https://github.com/Jackett/Jackett)
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)

# Notifications

{#notification}

- Boxcar {#boxcar}
- Custom Script {#customscript}
  - This allows you to make a custom script for when a particular action happens this script will run. See [Custom Scripts](/readarr/custom-scripts) for more details.
- Discord {#discord}
  - By far one of the most common ways to push notifications of actions happening on your Readarr
- Email {#email}
  - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.
  - > You can use a "pretty address" like `SomePrettyName <email@example.org>` {.is-info}
- GoodReads Bookshelves {#goodreadsbookshelf}
- GoodReads Owned Books {#goodreadsownedbooks}
- Gotify {#gotify}
- Join {#join}
- Mailgun {#mailgun}
- Notifiarr {#notifiarr}
  - See the entry on [Useful Tools - Notifiarr](/useful-tools#notifiarr-fka-discord-notifier)
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

- GoodReads Bookshelves {#goodreadsbookshelf}
  - (Advanced Option) User Id - Enter a userid here if it is not your userid you're added.
  - Bookshelves - Select which bookshelves to import from GoodReads
  - Authenticate with GoodReads - Click the button to authenticate with GoodReads.

> Multiple GoodReads users may be added as separate lists. In addition to using an authenticated user other users can be added by enabling advanced options and entering the User ID, then clicking Authetnicate with GoodReads to fetch the user's shelves.
{.is-info}

- GoodReads Owned Books {#goodreadsownedbooks}
  - (Advanced Option) User Id - Enter a userid here if it is not your userid you're added.
  - Bookshelves - Select which bookshelves to import from GoodReads
  - Authenticate with GoodReads - Click the button to authenticate with GoodReads.

> Multiple GoodReads users may be added as separate lists. In addition to using an authenticated user other users can be added by enabling advanced options and entering the User ID, then clicking Authetnicate with GoodReads to fetch the user's shelves.
{.is-info}

- GoodReads Lists {#goodreadslistimportlist}
  - List ID - Enter the GoodReads public List ID to add as a list
- GoodReads Series {#goodreadsseriesimportlist}
  - Series ID - Enter the GoodReads Series ID to add as a list
- LazyLibrarian {#lazylibrarianimport}
  - Url - URL of your LazyLibrarian Instance
  - API Key - API Key of your LazyLibrarian Instance
- Readarr {#readarrimport}
  - Full Url - Full URL of the Readarr instance to import from e.g. `http://localhost:8787/readarr`
  - API Key - API Key of the Readarr Instance to import from
  - Profiles - Profiles from the Readarr instance to import from
  - Tags - Tags from the Readarr instance to import from

# Metadata

{#metadata}

- Calibre {#calibre}
  - [Refer to the Settings page](/readarr/settings#write-metadata-to-book-files)
- Audio Tagging  #audiotagging}
  - [Refer to the Settings page](/readarr/settings#write-metadata-to-book-files)
