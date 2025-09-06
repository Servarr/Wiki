---
title: Readarr Supported (Retired)
description: Supported features for the retired Readarr application
published: true
date: 2022-01-07T19:44:47.143Z
tags:
editor: markdown
dateCreated: 2021-06-23T07:55:28.684Z
---

# Announcement: Retirement of Readarr

We would like to announce that the [Readarr project](https://github.com/Readarr/Readarr) has been retired. This difficult decision was made due to a combination of factors: the project's metadata has become unusable, we no longer have the time to remake or repair it, and the community effort to transition to using Open Library as the source has stalled without much progress.

Third-party metadata mirrors exist, but as we're not involved with them at all, we cannot provide support for them. Use of them is entirely at your own risk. The most popular mirror appears to be [rreading-glasses](https://github.com/blampe/rreading-glasses).

Without anyone to take over Readarr development, we expect it to wither away, so we still encourage you to seek alternatives to Readarr.

## Key Points

- Effective Immediately: The retirement takes effect immediately. Please stay tuned for any possible further communications.
- Support Window: We will provide support during a brief transition period to help with troubleshooting non metadata related issues.
- Alternative Solutions: Users are encouraged to explore and adopt any other possible solutions as alternatives to Readarr.
- Opportunities for Revival: We are open to someone taking over and revitalizing the project. If you are interested, please get in touch.
- Gratitude: We extend our deepest gratitude to all the contributors and community members who supported Readarr over the years.

Thank you for being part of the Readarr journey. For any inquiries or assistance during this transition, please contact our team.

Sincerely,
The Servarr Team

> This page is a work in progress and requires additional effort.{.is-warning}

This page is the disambiguation page for all "supported" wiki links (i.e. typically `More Info` in the UI).

# Download Clients

{#downloadclient}

- Aria2 {#aria2}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Deluge {#deluge}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Download Station {#torrentdownloadstation}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Download Station {#usenetdownloadstation}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Flood {#flood}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Hadouken {#hadouken}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- NZBGet {#nzbget}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- NZBVortex {#nzbvortex}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Pneumatic {#pneumatic}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- qBittorrent {#qbittorrent}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- rTorrent {#rtorrent}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- SABnzbd {#sabnzbd}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Torrent Blackhole {#torrentblackhole}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Transmission {#transmission}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- Usenet Blackhole {#usenetblackhole}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
- uTorrent {#utorrent}
  - [Refer to the Settings Page](/readarr/settings#download-clients)
  - Due to uTorrent being adware and formerly spyware, it is not reconmended. Most users use qBittorrent
- Vuze {#vuze}
  - [Refer to the Settings Page](/readarr/settings#download-clients)

# Indexers

{#indexer}

## Usenet

- Newznab {#newznab}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can provide advanced capabilities such as stat tracking.
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
  > IP Torrents' native implementation does not support Search {.is-info}
  - [Refer to the Settings Page](/readarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - Torrent Tracker for Japanese Media (Anime) exclusively.
  > Nyaa frowns upon automation and frequently will ban your IP. {.is-info}
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

 > You can use a "pretty address" like `SomePrettyName <email@example.org>` {.is-info}

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

> Multiple GoodReads users may be added as separate lists. In addition to using an authenticated user other users can be added by enabling advanced options and entering the User ID, then clicking Authenticate with GoodReads to fetch the user's shelves.
{.is-info}

- GoodReads Owned Books {#goodreadsownedbooks}
  - (Advanced Option) User Id - Enter a userid here if it is not your userid you're added.
  - Bookshelves - Select which bookshelves to import from GoodReads
  - Authenticate with GoodReads - Click the button to authenticate with GoodReads.

> Multiple GoodReads users may be added as separate lists. In addition to using an authenticated user other users can be added by enabling advanced options and entering the User ID, then clicking Authenticate with GoodReads to fetch the user's shelves.
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
