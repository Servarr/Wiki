---
title: Radarr Supported
description: 
published: true
date: 2023-09-01T16:45:41.479Z
tags: 
editor: markdown
dateCreated: 2021-06-23T07:55:24.002Z
---

# Table of Contents

> This page is a work in progress and requires additional effort.{.is-warning}

This page is the disambiguation page for all `supported` wiki links (i.e. typically "more info" in the UI).

# Download Clients

{#downloadclient}

- Aria2 {#aria2}
  - [Refer to the Settings Page](/radarr/settings#download-clients)
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
  - Due to utorrent being adware and formerly spyware, it is not recommended. Most users use Qbittorrent.
- Vuze {#vuze}
  - [Refer to the Settings Page](/radarr/settings#download-clients)

# Indexers

{#indexer}

## Usenet

- Newznab {#newznab}
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
  - Newznab is a standardized API used by many usenet indexing sites. Many presets are available, but all require an API key to be accessible.
  - Indexer Applications like [Prowlarr](/prowlarr) and [NZBHydra2](https://github.com/theotherp/nzbhydra2) can provide advanced capabilities such as stat tracking.
- omgwtfnzbs {#omgwtfnzbs}
  - A defunct legacy implementation of a private usenet indexer. Use Newznab instead.
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)

## Torrents

- FileList {#filelist}
  - Private Tracker
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- HDBits {#hdbits}
  - Private Tracker
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- IP Torrents {#iptorrents}
  - Private Tracker
  > IP Torrents' native implementation does not support Search. Use it via Prowlarr or Jackett as torznab instead {.is-info}
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- Nyaa {#nyaa}
  - Torrent Tracker for Japanese Media (Anime) exclusively.
  > Nyaa frowns upon automation and frequently will ban your IP. {.is-info}
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- Pass The Popcorn (PTP) {#passthepopcorn}
  - Private Tracker
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- Rarbg {#rarbg}
  - Public Tracker
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- Torrent RSS Feed {#torrentrssindexer}
  - Generic torrent RSS feed parser.
  > The RSS feed must contain a `pubdate`. The release size is recommended as well.
  {.is-info}
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- TorrentPotato {#torrentpotato}
  - A legacy Couchpotato pre-Torznab format.
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)
- Torznab {#torznab}
  - Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent RSS feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same API  specification is shared with nZEDb)
  - This is primarily only supported by [Prowlarr](/prowlarr) and [Jackett](https://github.com/Jackett/Jackett)
  - [Refer to the Settings Page](/radarr/settings#indexer-settings)

> Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments, etc.
> Please review your tracker rules and etiquette, keep your community alive.
> We're not responsible if your account is banned for disobeying rules or accruing Hit and Runs (HnRs)/low-ratio.
{.is-warning}

# Notifications

{#notification}

- Boxcar {#boxcar}
- Custom Script {#customscript}
  - This allows you to make a custom script for when a particular action happens this script will run. See [Custom Scripts](/radarr/custom-scripts) for more details.
- Discord {#discord}
  - By far one of the most common ways to push notifications of actions happening on your Radarr
- Email {#email}
  - Simply send yourself or somebody you want to annoy with email. If you're using Gmail, you need to enable less secure apps. If you're using Gmail and have 2-factor authentication enabled you need to use an App Specific password.

> You can use a "pretty address" like `SomePrettyName <email@example.org>` {.is-info}

- Emby {#mediabrowser}
- Gotify {#gotify}
- Join {#join}
- Kodi {#xbmc}
  - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customizable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community. By adding Kodi as a connection you can update Kodi's library when a new movie has been added to Radarr.
- Mailgun {#mailgun}
- Notifiarr {#notifiarr}
  - See the entry on [Useful Tools - Notifiarr](/useful-tools#notifiarr-fka-discord-notifier)
- Plex Media Server {#plexserver}
  - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded movie is available.
  - This is rarely needed and is only required if Plex is unable to watch the file system for changes.
  - In the handful of situations where Plex is unable to watch the file system using ionotify - such as certain types of remote mounts and a handful of older network mounts - it is suggested to use the app plexautoscan rather than the Plex connection
- A use a tool like [plexautoscan](https://github.com/l3uddz/plex_autoscan) is another option.

- Prowl {#prowl}
- Pushbullet {#pushbullet}
- Pushcut {#pushcut}
- Pushover {#pushover}
- SendGrid {#sendgrid}
- Slack {#slack}
- Synology Indexer {#synologyindexer}
- Telegram {#telegram}
- Trakt {#trakt}
- Twitter {#twitter}
  - See this [Tips and Tricks entry](/useful-tools#twitter)
- Webhook {#webhook}

# Lists

{#importlist}

- CouchPotato {#couchpotatoimport}
- Custom Lists {#radarrlistimport}
- IMDb Lists {#imdblistimport}
  - To add your IMDb Watchlist, go to your list and click edit. Make sure privacy setting is set to public. In the address bar you will find the `lsxxxxxx` number that you will need to enter into Radarr

    1. Go to your IMDB List Settings
    1. Ensure Privacy is set to `Public` (i.e. `Disabled)`
    1. Use the `ls` number within the URL

  ![imdb-list-ls.png](/assets/radarr/imdb-list-ls.png)
- Plex Watchlist {#plex}
  - Requires: v4.1.0.6176+
  - Simply add a Plex watchlist for the authenticated Plex user to Radarr. Note that it's required that your list contain movies on it.
  - To have multiple user's watchlists you'll need to add each user's lists and authenticate with their Plex user.
- Radarr {#radarrimport}
  - TRaSH has [a guide](https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/) for syncing two instances
- RSS List {#rssimport}
- StevenLu Custom {#stevenluimport}
	- Allows you to create custom movies lists in json format.
  	Your feed requires for each movie either a `title` or an `imdb_id`, both can be provided.
  		> Note that `imdb_id` is safer than `title` as it does not require a broad search
    Here is a sample valid json : 
      ```
      [
          {
            "title": "The Wastetown",
            "poster_url": "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/6J32RMp8uko8CUEM3rYP962hQun.jpg",
            "imdb_id": "tt22889064"
          },
          {
            "title": "Wild Sunflowers",
            "poster_url": "https://www.themoviedb.org/t/p/w300_and_h450_bestv2/tHK4c0UZKrqkmXZ2HJeGNhNetRz.jpg",
            "imdb_id": "tt13774830"
          }
      ]
      ```
      - Additional keys can be added in items (will be ignored)
      - For an empty list just return an empty json array `[]`
- StevenLu List {#stevenlu2import}
- TMDb Collection {#tmdbcollectionimport}
  - Collection Lists are no longer supported in Radarr v4.2 and have been migrated to collections within Radarr. See the [Collections](/radarr/library#collections) section for more details.
- TMDb Company {#tmdbcompanyimport}
- TMDb Keyword {#tmdbkeywordimport}
- TMDb List {#tmdblistimport}
- TMDb Person {#tmdbpersonimport}
  - If the TMDb Person url is `https://www.themoviedb.org/person/500-tom-cruise` then the Person ID is `500`
- TMDb Popular {#tmdbpopularimport}
  - Top uses <https://developers.themoviedb.org/3/movies/get-top-rated-movies>
  - Popular uses <https://developers.themoviedb.org/3/movies/get-popular-movies>
  - Theaters  uses <https://developers.themoviedb.org/3/movies/get-now-playing>
  - Upcoming uses <https://developers.themoviedb.org/3/movies/get-upcoming>
- TMDb User {#tmdbuserimport}
- Trakt List {#traktlistimport}
  - Username - Ensure you enter the actual username of the user and not the user's name
  - List - Ensure you use the list name as presented in the list URL
  - Example: `https://trakt.tv/users/some-user-name/lists/trakt-list-name?sort=rank,asc`
    - Username: `some-user-name`
    - List: `trakt-list-name`
- Trakt Popular List {#traktpopularimport}
- Trakt User {#traktuserimport}
  - This type should be used when using your own watchlist

# Metadata

{#metadata}

- Emby (Legacy) {#mediabrowsermetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Enable metadata file creation for this metadata type
- Kodi (XBMC) / Emby {#xbmcmetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create a `<filename>.nfo` with the movie metadata
  - (Advanced Option) Movie Metadata URL - Create `movie.nfo` with TMDb and IMDb movie URLs
  - Metadata Language - Select the language Radarr should use to write the metadata if available in that language
  - Movie Images - Create various Season images including posters and banners
  - Use Movie.nfo - Write the nfo file as `movie.nfo` rather than the default
  - Collection Name - Radarr will write the collection name to the .nfo file
- Roksbox {#roksboxmetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create xml file for each movie
  - Movie Images - Create `Movie.jpg`
- WDTV {#wdtvmetadata}
  - Enable - Enable metadata file creation for this metadata type
  - Movie Metadata - Create `<filename>.xml` for each episode
  - Movie Images - Create `folder.jpg`
