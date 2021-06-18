---
title: Lidarr FAQ
description: 
published: true
date: 2021-06-18T00:33:47.146Z
tags: lidarr, needs-love, faq
editor: markdown
dateCreated: 2021-06-14T14:33:41.344Z
---

## How does Lidarr work?

- Lidarr relies on RSS feeds to automate grabbing of releases as they are posted, for both new releases as well as previously released releases being released or re-released. The RSS feed is the latest releases from a site, typically between 50 and 100 releases, though some sites provide more and some less. The RSS feed is comprised of all releases recently available, including releases for requested media you do not follow, if you look at debug logs you will see these releases being processed, which is completely normal.
- Lidarr enforces a minimum of 10 minutes on the RSS Sync interval and a maximum of 2 hours. 15 minutes is the minimum recommended by most indexers, though some do allow lower intervals and 2 hours ensures Lidarr is checking frequently enough to not miss a release (even though it can page through the RSS feed on many indexers to help with that). Some indexers allow clients to perform an RSS sync more frequently than 10 minutes, in those scenarios we recommend using Lidarr's Release-Push API endpoint along with an IRC announce channel to push releases to Lidarr for processing which can happen in near real time and with less overhead on the indexer and Lidarr as Lidarr doesn’t need to request the RSS feed too frequently and process the same releases over and over.

## How does Lidarr find releases?

- Lidarr does ''not'' regularly search for book files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for ''all'' the newly posted releases, then compares that with its list of releases that are missing or need to be upgraded. Any matches are downloaded. This lets Lidarr cover a library of ''any size'' with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you'll realize that it only covers the ''future'' though.
- So how do you deal with the present and past? When you're adding a book, you'll need to set the correct path, profile and monitoring status then use the Start search for missing book checkbox. If the book hasn't been released yet, you don't need to initiate a search.
- Put another way, Lidarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases you want that were uploaded in the past.
- If you've already added the book, but now you want to search for it, you have a few choices. You can go to the book's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see ''all'' the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Lidarr has been offline for an extended period of time, Lidarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Lidarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed releases.

## How are possible downloads compared?

`Generally Quality Trumps All`

The current logic [can be found here](https://github.com/Lidarr/Lidarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).

As of 2021-06-09 the logic is as follows:

- Quality
- Custom Preferred Word Score
- Protocol
- Indexer Priority
- Seeds/Peers (If Torrent)
- Album Count
- Age (If Usenet)
- Size

## Why can't I add a new release or artist to Lidarr?

## Why can't I add a various artists album?
Various Artists and other meta artists on Musicbrainz are due to the number of entries they provide.

## Why does Lidarr only show studio albums, How do I find singles or EPs?
Lidarr defaults to only bringing in studio albums for each artist. However, you can expand the album types per an artist, or for your entire library by utilizing Metadata Profiles.

## Can I add just an album?
​
​Not at the moment.
​
​## Can I download single tracks?
​
​Lidarr works by searching for and downloading full releases, therefore individual tracks cannot be downloaded unless they were released as a single by the artist.
​
​## Why doesn't artist X show up in search?
​
​Search is still a work in progress. Artists that don't show up in search may be added by searching for `lidarr:mbid` where `mbid` is the Musicbrainz ID of the artist.
​
​## Lidarr matched an album with too many tracks. How can I change the Album to the correct Release?
​
​Open the Album details page and select the Edit Icon in the top nav. There you can find a dropdown of all releases tied to that Album.
​
​## I'm having trouble importing my artists, what could it be?
​
​The artist import process just imports the Artist names and path locations, which are then stored in the database so that a) metadata can be retrieved and b) downloaded content can be put in the same location in future.  To this end, the user account that Lidarr runs under needs both read and write to your data directory.
​
​## I can't find a release in Lidarr but it is on MusicBrainz
​
​This is likely due to the release having an `unknown` release status.  Update MusicBrainz.
​
​## How often do Lidarr's and MusicBrainz databases sync?
​
​Every hour at 5 after the hour
​
​## How can I add missing artist images?
​
​Add art to fanart.tv and wait ~7+ days for it to clear through the cache. Then refresh the metadata.
​
​## How can I get missing album images? (Cover Art)
​
​Add coverart to musicbrainz and wait ~1hr+ for it to clear through the cache. Then refresh the metadata.
​
​## I'm having trouble importing my artists, what could it be?
​
​The artist import process just imports the Artist names and path locations, which are then stored in the database so that a) metadata can be retrieved and b) downloaded content can be put in the same location in future.  To this end, the user account that Lidarr runs under needs both read and write to your data directory.

## How can I rename my artist folders?

- Library
- Mass Editor
- Select what artists need their folder renamed
- Change Root Folder to the same Root Folder that the artists currently exist in
- Select "Yes move files"

## How can I mass delete artists from the wanted list?

- Use Mass Editor -> Select artists you want to delete -> Delete

## Why doesn't Lidarr work behind a reverse proxy

- Lidarr uses .NET Core and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Lidarr:
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;

- Make sure you `do not` include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. `THIS WILL NOT WORK`
- [See this ASP.NET Core issue](https://github.com/aspnet/AspNetCore/issues/17081)
- If you are using a CDN like Cloudflare ensure websockets are enabled to allow websocket connections.

## How do I update Lidarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `develop` or `nightly`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch. **Lidarr does not yet have a stable release.**
  
- `develop` (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first. **Lidarr does not yet have a beta release.**

> On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` (Alpha/Unstable): The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

||`master` (stable)|`develop` (beta)|`nightly` (unstable) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/lidarr/nightly/VERSION.json)|
|---|---|---|---|
|[hotio](https://hotio.dev/containers/lidarr)|no stable release yet|no beta release yet|`hotio/lidarr:nightly`|

## Can I update Lidarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

If Native:

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

If Docker:

1. Repull your tag and update your container

## Can I switch between branches?

- You can (almost) always increase your risk.
- `master` can go to `develop` or `nightly`
- `develop` can go to `nightly`
- Check with the development team to see if you can switch from `nightly` to `master`; `nightly` to `develop`; or `develop` to `master` for your given build.
- Failure to follow these instructions may result in your Lidarr becoming unusable or throwing errors. You have been warned.
- The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.

## Help, Book Added, But Not Searched

- Neither Lidarr *actively* search for missing releases automatically. Instead, a periodic query of new posts is made to all indexers configured for RSS. When a wanted or cutoff unmet release shows up in that list, it gets downloaded. This means that until a release is posted (or reposted), it won’t get downloaded.
- If you’re adding an artist with releases that you want now, the best option is to check the “Start search for missing releases” box, to the left of the *Add Author* button. You can also go to the page for an artist you’ve added and click the magnifying glass *Search* button next to the release you want, or use the Wanted view to search for Missing or Cutoff Unmet releases.

## Book Imported, But Source File And Torrent Not Deleted

- Check if you have Completed Download Handling - Remove turned on. (This does not work if you are using rtorrent.)

- If you are using deluge make sure auto-managed is turned on. And that torrents get paused when they reach specified seeding quota.

## I am using a Pi and Raspbian and Lidarr will not launch

- Possible Solution:

Managed to fix the issue by installing the backport from debian repo. Generally not recommended to use backport in blanket upgrade mode. Installation of a single package may be ok but may also cause issues. So got to understand what you are doing.

Steps to fix:

First ensure you are running Raspbian buster e.g using `lsb_release -a`

Distributor ID: Raspbian

Description: Raspbian GNU/Linux 10 (buster)

Release: 10

Codename: buster

- If you are using buster:

 Add the line `deb http://deb.debian.org/debian buster-backports` main to `/etc/apt/sources.list`
 Run `apt-get update`
 `apt-get -t buster-backports install libseccomp2`

## Why are lists sync times so long and can I change it?

Lists never were nor are intended to be `add it now` they are `hey I want this, add it eventually` tools.

You can trigger a list refresh manually, script it and trigger it via the API, or add the releases directly to Lidarr.

This change was due to not have our server get killed by people updating lists every 10 minutes.

## Can I disable the refresh releases task

No, nor should you through any SQL hackery.  The refresh releases task queries the upstream Servarr proxy and checks to see if the metadata for each release (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Lidarr. If necessary, it will then update the applicable releases.

A common complaint is the Refresh task causes heavy I/O usage.  One setting that can cause issues is "Rescan Author Folder after Refresh".  If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`.  Do not change this to `Never` unless all changes to your library (new releases, upgrades, deletions etc) are done through Lidarr.  If you delete release files manually or a third party program, do not set this to `Never`.

## Why can’t see my files on a remote server?

- In short: the user is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is,  is running as a service, which causes one of two things:

  - Lidarr runs under the LocalService account by default which doesn’t have access to protected remote file shares.
    - **Solutions**
      - Run Lidarr’s service as another user that has access to that share
      - Open the Administrative Tools \> Services window on your Windows server.
        - Stop the service.
        - Open the Properties \> Log On dialog.
        - Change the service user account to the target user account.
      - Run Lidarr.exe using the Startup Folder

  - You’re using a mapped network drive (not a UNC path)
    - **Solutions**
      - Change your paths to UNC paths (`\\server\share`)
      - Run Lidarr.exe via the Startup Folder