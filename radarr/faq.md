---
title: Radarr FAQ
description: 
published: true
date: 2021-06-26T09:33:13.994Z
tags: radarr, needs-love
editor: markdown
dateCreated: 2021-05-16T20:44:27.778Z
---

## How does Radarr work?

- Radarr relies on RSS feeds to automate grabbing of releases as they are posted, for both new releases as well as previously released releases being released or re-released. The RSS feed is the latest releases from a site, typically between 50 and 100 releases, though some sites provide more and some less. The RSS feed is comprised of all releases recently available, including releases for requested media you do not follow, if you look at debug logs you will see these releases being processed, which is completely normal.
- Radarr enforces a minimum of 10 minutes on the RSS Sync interval and a maximum of 2 hours. 15 minutes is the minimum recommended by most indexers, though some do allow lower intervals and 2 hours ensures Radarr is checking frequently enough to not miss a release (even though it can page through the RSS feed on many indexers to help with that). Some indexers allow clients to perform an RSS sync more frequently than 10 minutes, in those scenarios we recommend using Radarr's Release-Push API endpoint along with an IRC announce channel to push releases to Radarr for processing which can happen in near real time and with less overhead on the indexer and Radarr as Radarr doesn’t need to request the RSS feed too frequently and process the same releases over and over.

## How does Radarr find movies?

- Radarr does *not* regularly search for movie files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted movies, then compares that with its list of movies that are missing or need to be upgraded. Any matches are downloaded. This lets Radarr cover a library of *any size* with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a movie, you will need to set the correct path, profile and monitoring status then use the Start search for missing movie checkbox. If the movie hasn't been released yet, you do not need to initiate a search.
- Put another way, Radarr will only find movies that are newly uploaded to your indexers. It will not actively try to find movies you want that were uploaded in the past.
- If you've already added the movie, but now you want to search for it, you have a few choices. You can go to the movie's page and use the search button, which will do a search and then automatically pick one. You can use the Search tab and see *all* the results, hand picking the one you want. Or you can use the filters of `Missing`, `Wanted`, or `Cut-off Unmet`.
- If Radarr has been offline for an extended period of time, Radarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Radarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed movies.

## What is Minimum Availability?

- **Announced**: Radarr shall consider movies available as soon as they are added to Radarr. This setting is recommended if you have good private trackers (or really good public ones, e.g. rarbg.to) that do not have fakes.
- **In Cinemas**: Radarr shall consider movies available as soon as movies hit cinemas. This option is not recommended.
- **Released**: Radarr shall consider movies available as soon as the blu-ray or streaming version is released. This option is recommended and likely should be combined with an Availability Delay of `-14` days.

## How are possible downloads compared?

- *Generally Quality Trumps All**

- The current logic [can be found here](https://github.com/Radarr/Radarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs).
***As of 2021-06-26 the logic is as follows***

1. Quality
1. Custom Format Score
1. Protocol
1. Indexer Priority
1. Indexer Flags
1. Peers (If Torrent)
1. Age (If Usenet)
1. Size

## What are Lists and what can they do for me?

- Lists are a part of Radarr that allow you to follow a given list creator.

- Let's say that you follow a given list creator on Trakt/TMDb and really like their Marvel Cinematic Universe film section and want to watch every movie on their list. You look in your Radarr and realize that you do not have those movies. Well instead of searching one by one and adding those lists and then searching your indexers for those movies. You can do this all at once with a List. The Lists can be set to import all the movies on that curators list as well as be set to automatically assign a quality profile, automatically add, and automatically monitor that movie.

> **CAUTION:** If done improperly lists can wreak havoc on your library by adding many movies you have no intention of watching. Make certain you are familiar with the list before you click save.
{.is-warning}

- It's suggested that physically look at the list before you even go to Radarr.

## Why did the GUI / UI Change? Can it be changed back?

- Radarr is a fork of [Sonarr](/sonarr) which has the new UI.

- No it cannot be changed back to be like v0.2. No it will not be changed back.
- You may, however, check out [Theme Park](https://github.com/gilbN/theme.park)

## Where did Wanted and Cut-off Unmet go?

- Movie Index (AKA 'Movies') -> Filter (top right corner) -> `Wanted` and `Cut-off Unmet`
  - Wanted - Movie is missing, monitored, and available
  - Missing - Movie is missing and monitored

![radarr-filter-cutoff-wanted.png](/assets/radarr/radarr-filter-cutoff-wanted.png)

## Why can I not add a new movie to Radarr?

- Radarr uses [The Movie Database (TMDb)](http://themoviedb.org) for movie information and images like fanart, banners and backgrounds. Generally, there are a few reasons why you may not be able to add a movie:
  - TMDb doesn't like special characters to be used when searching for movies through the API (which Radarr uses), so try searching a translated name, and/or without special characters.
  - You can also add by TMDb ID or, if TMDb has it, the IMDb ID
  - The movie hasn't been added to TMDb yet, follow their [guide](https://www.themoviedb.org/bible/new_content#59f7933c9251413e93000006) to get it added.

## Can all my movie files be stored in one folder?

- Not yet and the reason is that Radarr is a fork of [Sonarr](/sonarr), where every show has a folder. This limitation is a known pain point for many users and will maybe come in a future version.

- If you're looking to moving all your movies from one folder to individual folders check Create a Folder for Each Movie **LINK NEEDED TO TIPS AND TRICKS**

## Can I put all my movies in my library into one folder?

- We get asked this a lot. There are no plans to support `\data\Movies\Movie1.mkv`, `\data\Movies\Movie2.mkv`, etc.

- The [Custom Folder GitHub Issue](https://github.com/Radarr/Radarr/issues/153) technically covers this request, but it is no guarantee that all movie files in one folder will be implemented at that time.

- A slight hack-ish solution is noted below. Please note that you mustn't trigger a rescan or it will show as missing and regardless the movie will never be upgraded.

  - Use a Custom Script
    - the script should be triggered on import
    - it should be designed to move the file whenever you want it
    - it then needs to call the Radarr API and change the movie to unmonitored.

## How can I rename my movie folders?

1. Movies
1. Movie Editor
1. Select what movies need their folder renamed
1. Change Root Folder to the same Root Folder that the movies currently exist in
1. Select "Yes move files"

## Movie File and Folder Naming

- Currently, Radarr requires that each movie be in a folder with the format containing at minimum `Movie Title (Year)/`, optionally `_` or `.` are valid separators. To facilitate correct quality and resolution identification during import, a file name like `Movie Title (Year) [Quality-Resolution].ext` is best, again `_` or `.` are valid separators too.

  - A useful tool for making these changes to your collection is [filebot](http://www.filebot.net/#download) which has paid version in both the Apple and Windows stores, but can be found for free on their legacy [SourceForge](https://sourceforge.net/projects/filebot/files/latest/download) site. It has both a GUI and CLI, so you can use whatever you’re comfortable with. For the above example, `{ny}` expands to `Name (Year)` and `{vf}` gives the resolution like `1080p`. There is nothing to infer quality, so you can fake it using `{ny}/{ny} [{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` which will name anything lower than 720p to `[DVD-572p]` and greater or equal to 720p like `[Bluray-1080p]`.

- See Create a Folder for Each Movie **LINK NEEDED TO TIPS AND TRICKS** for more details.

## Movie Folders Named Incorrectly

- Even if your movies are in folders already, the folders may not be named correctly. The folder name should be `Movie Title (Year)`, having the title and year in the folder’s name is critical right now.

  - Examples that will work well:
    - `/mnt/Movies/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - `/mnt/Kid Movies/Frozen (2013)/Frozen (2013) [Bluray-1080p].mkv`
  - Examples that will work, but will require manual management:
    - By letters: `/mnt/Movies/A-D/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - By rating: `/mnt/Movies/R/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - By genre: `/mnt/Movies/Crime, Drama, Sci-Fi/A Clockwork Orange (1971)/A Clockwork Orange (1971) [Bluray-1080p].mkv`
    - These examples will require manual management when the movie is added. Each of the examples will have many root directories, like `A-D` and `E-G` in the first letter example, `R` and `PG-13` in the rating example and you can guess at the variety of genre folders. When adding a new movie, the correct base folder will need to be selected for this format to work.
  - Examples that won’t work:
    - Single folder: `/mnt/Kid Movies/Frozen (2013) [Bluray-1080p].mkv`
      - At this time, movies simply have to be in a folder named after the movie. There is no way around this until development work is done to add this feature.
    - **Movie** Folder Naming Formats from v0.2 that include **File** properties in the **movie folder** name such as ``{Movie.Title}.{Release Year}.{Quality.Full}-{MediaInfo.Simple}{`Release.Group}`` will not work in v3.
      - Folders are related to the movie and independent of the file. Additionally, this will break with the planned multiple files per movie support.
      - The other reason it was removed was it caused frequent confusion, database corruption, and generally was only half baked.
  - The Create a Folder for Each Movie **LINK NEEDED TO TIPS AND TRICKS** is a great source for making sure your file and folder structure will work great.

## How can I mass delete movies from the wanted list?

- Use Movie Editor -> Select movies you want to delete -> Delete

## Why doesn't Radarr work behind a reverse proxy

- Starting with V3 Radarr has switched to .NET Core and a new webserver. In order for SignalR to work, the UI buttons to work, database changes to take, and other items. It requires the following addition to the location block for Radarr:

```none
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade; 
proxy_set_header Connection $http_connection;
```

- Make sure you **do not** include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. **THIS WILL NOT WORK**
- [See this ASP.NET Core issue](https://github.com/aspnet/AspNetCore/issues/17081)
- If you are using a CDN like Cloudflare ensure websockets are enabled to allow websocket connections.

## How do I update Radarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `master` or `develop`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/radarr/release/VERSION.json) - (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. This version will receive updates approximately monthly. On GitHub, this is the `master` branch.

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/radarr/testing/VERSION.json) - (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first. This version will receive updates either weekly or biweekly depending on development.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/radarr/nightly/VERSION.json) - (Alpha/Unstable) : The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This is currently v4. This version is updated immediately.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:release`, `:latest`, `:testing`, or `:develop` to the end of your container tag depending on who makes your builds.

| |`master` (stable) ![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/radarr/release/VERSION.json)|`develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/radarr/testing/VERSION.json)|
|---|---|---|
|[hotio](https://hotio.dev/containers/radarr)|`hotio/radarr:release`|`hotio/radarr:testing`|
|[LinuxServer.io](https://docs.linuxserver.io/images/docker-radarr)|`linuxserver/radarr:latest`|`linuxserver/radarr:develop`|

## Can I update Radarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

If Native:

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

If Docker:

1. Repull your tag and update your container

## Can I switch from `nightly` back to `develop`?

- See the entry below

## Can I switch between branches?

> You can (almost) always increase your risk.{.is-info}

- `master` can go to `develop` or `nightly`
- `develop` can go to `nightly`
- Check with the development team to see if you can switch from `nightly` to `master`; `nightly` to `develop`; or `develop` to `master` for your given build.
- Failure to follow these instructions may result in your Radarr becoming unusable or throwing errors. You have been warned.
  - The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.
- **June 26 2021 Update**
  - `3.2.2.5080` has been released as master/stable
  - For those on nightly and are still on `4.0.0.5100` or lower you can safely downgrade to master
  - For those on develop and are still on `3.2.2.5080` or lower you can safely downgrade to master

## How does Radarr handle foreign movies or foreign titles?

- Radarr uses both Alt Titles and Translations for parsing and searching. Search will use the Original Title, English Title, and Translated Title from whatever languages you have preferred (in profile and CFs). Parsing should look for a match in all Translations and Alt Titles.
- To get a movie in a foreign language set your Profile Language to Original (Movie's Original Language), a specific language for that profile, or any and use custom formats to determine which language to grab.
- Note that this does not include any indexer languages specified as multi.

## How does Radarr handle "multi" in names?

- Radarr by default assumes multi is english and french unless specified in your indexer's advanced settings in Radarr.

- Note that multi definitions only help for release parsing and not for foreign titles or movies searches.

## Help, Movie Added, But Not Searched

- Neither Radarr nor Sonarr *actively* search for missing movies automatically. Instead, a periodic query of new posts is made to all indexers configured for RSS. When a wanted or cutoff unmet movie shows up in that list, it gets downloaded. This means that until a movie is posted (or reposted), it won’t get downloaded.
- If you’re adding a movie that you want now, the best option is to check the “Start search for missing movie” box, to the left of the *Add Movie* (**1**) button. You can also go to the page for a movie you’ve added and click the magnifying glass “Search” (**2**) button or use the Wanted view to search for Missing or Cutoff Unmet movies.

"Add and Search for movie" (on add) **IMAGE NEEDED**
"Add and Search for movie" (on select via index) **IMAGE NEEDED**

## Root path for movies imported from lists becomes “C:” or other weird paths
  
- Sometimes you can get a problem that movies that are imported from your lists, gets imported with the root path set to “C:” or other weird paths.

- This is a known issue for when the root path is either not setup during the creation of the list, or if the root path has been deleted after the list was created. Note that this problem can still occur even if the list is **edited** and the correct root path is set.

- Use the Movie Editor to fix paths of existing movies.

## Movie Imported, But Source File And Torrent Not Deleted

\* Check if you have Completed Download Handling - Remove turned on. (This does not work if you are using rtorrent.)

![Settings \> Download Clients](Remove_turned_on.png "Settings \> Download Clients")

- If you are using deluge make sure auto-managed is turned on. And that torrents get paused when they reach specified seeding quota.

## My Custom Script stopped working after upgrading from v0.2

You were likely passing arguments in your connection and that is not supported.

1. Change your argument to be your path
2. Make sure the shebang in your script maps to your pwsh path (if you do not have a shebang definition in there, add it)
3. Make sure the pwsh script is executable

## I am using a Pi and Raspbian and Radarr will not launch

Raspbian has a version of libseccomp2 that is too old to support running a docker container based on Ubuntu 20.04, which both hotio and LinuxServer use as their base for v3. You either need to use `--privileged`, update libseccomp2 from Ubuntu or get a better OS (We recommend Ubuntu 20.04 arm64)

**Possible Solution:**

Managed to fix the issue by installing the backport from debian repo. Generally not recommended to use backport in blanket upgrade mode. Installation of a single package may be ok but may also cause issues. So got to understand what you are doing.

Steps to fix:

First ensure you are running Raspbian buster e.g using `lsb_release -a`

> Distributor ID: Raspbian
> Description: Raspbian GNU/Linux 10 (buster)
> Release: 10
> Codename: buster

- If you are using buster:
  - Run the following to add the backports to your sources

  ```shell
   echo "deb <http://deb.debian.org/debian> buster-backports main" | sudo tee /etc/apt/sources.list.d/buster-backports.list
   ```

  - Install the backport of libseccomp2

  ```shell
  sudo apt update && sudo apt-get -t buster-backports install libseccomp2
  ```

## Why are lists sync times so long and can I change it?

- Lists never were nor are intended to be `add it now` they are `hey i want this, add it eventually` tools

- You can trigger a list refresh manually, script it and trigger it via the API, add the movies to Radarr, use Ombi, or any similar app that adds them right away

- This change was due to not have our server get killed by people updating lists every 10 minutes.

## Can I disable the refresh movies task

- No, nor should you through any SQL hackery. The refresh movies task queries the upstream Servarr proxy and checks to see if the metadata for each movie (ids, cast, summary, rating, translations, alt titles, etc.) has updated compared to what is currently in Radarr. If necessary, it will then update the applicable movies.

- A common complaint is the Refresh task causes heavy I/O usage. This is partly due to the setting "Analyze video files" which is advised to be enabled if you use tdarr or otherwise externally modify your files. If you do not you can safely disable "Analyze video files" to reduce some I/O. The other setting is "Rescan Movie Folder after Refresh". If your disk I/O usage spikes during a Refresh then you may want to change the Rescan setting to `Manual`. Do not change this to `Never` unless all changes to your library (new movies, upgrades, deletions etc) are done through Radarr. If you delete movie files manually or via Plex or another third party program, do not set this to `Never`.

## Help, My Mac says Radarr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac) ![Developer Cannot be verified](developer-cannot-be-verified.png "Developer Cannot be verified")

## Help, My Mac says Radarr.app is damaged and can’t be opened

- That is either due to a corrupt download so try again or [security issues, please see this related FAQ entry.](#help-my-mac-says-radarr-cannot-be-opened-because-the-developer-cannot-be-verified)

## How do I request a feature for Radarr?

- This is an easy one [click here](https://github.com/Radarr/Radarr/issues)

## I am getting an error: Database disk image is malformed

- This means your SQLite database that stores most of the information for is corrupt.

- [Try restoring from a backup](#how-do-i-backup-and-restore-radarr)
- You can follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db)
- Alternatively, there is guide here to copy the contents from the corrupt database into a new one: <http://techblog.dorogin.com/2011/05/SQLiteexception-database-disk-image-is.html>

- This error may show if the database file is not writable by the user/group Radarr is running as.

- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). Simple answer to this is to not do this as SQLite and network drives not typically play nice together and will cause a malformed database eventually. The config folder must be on a local drive**. If you're trying to restore your database you can check out our Backup/Restore guide [here](#restoring-from-backup).

  - If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use Radarr on a Mac and it suddenly stopped working. What happened?

- Most likely this is due to a MacOS bug which caused one of the databases to be corrupted.

- See the above database is malformed entry.

- Then attempt to launch and see if it works. If it does not work, you will need further support. Post in our [subreddit /r/radarr](http://reddit.com/r/radarr) or hop on [our discord](https://radarr.video/discord) for help.

## Why can’t I see my files on a remote server?

- In short: the user is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is,  is running as a service, which causes one of two things:

  - Radarr runs under the LocalService account by default which doesn’t have access to protected remote file shares.
    - **Solutions**
      - Run Radarr’s service as another user that has access to that share
      - Open the Administrative Tools \> Services window on your Windows server.
        - Stop the service.
        - Open the Properties \> Log On dialog.
        - Change the service user account to the target user account.
      - Run Radarr.exe using the Startup Folder

  - You’re using a mapped network drive (not a UNC path)
    - **Solutions**
      - Change your paths to UNC paths (`\\server\share`)
      - Run Radarr.exe via the Startup Folder

## Mapped Network Drives vs UNC Paths

- Using mapped network drives generally doesn’t work very well, especially when is configured to run as a service. The better way to set shares up is using UNC paths. So instead of `X:\Movies` use `\\Server\Movies`.

  - A key point to remember is that gets path information from the downloader, so you’ll *also* need to setup NZBGet, SABNzbd or any other downloader to use UNC paths too.

## How do I change from the Windows Service to a Tray App?

1. Shut down Radarr
1. Run serviceuninstall.exe that's in the Radarr directory
1. Run `Radarr.exe` as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
1. (Optional) Drop a shortcut to .exe in the startup folder to auto-start on boot.

## How do I Backup/Restore Radarr ?

### Backing up

#### Using built-in backup

1. Go to System: Backup in the UI
1. Click the Backup button
1. Download the zip after the backup is created for safekeeping

#### Using file system directly

1. Find the location of the AppData directory for Radarr
      - Via the UI go to System \> About
      - [Radarr Appdata Directory](/radarr/appdata-directory)
1. Stop  - This will prevent the database from being corrupted
1. Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths won’t work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.
{.is-warning}

#### Using zip backup

1. Re-install Radarr
1. Run Radarr
1. Navigate to System \> Backup
1. Select Restore Backup
1. Select Choose File
1. Select your backup zip file
1. Select Restore

#### Using file system backup

1. Re-install Radarr
1. Run Radarr once to get the AppData directory location
1. Stop Radarr
1. Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
1. Restore from your backup
1. Start Radarr
1. As long as the paths are the same, everything will pick up where it left off

- **Restore for Synology NAS**

**CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.**

1. Re-install Radarr  
1. Run once to get the AppData directory location  
1. Stop Radarr
1. Connect to the Synology NAS through SSH and log in as root  
1. Execute the following commands:

    ```shell
        rm -r /usr/local/Radarr/var/.config/Radarr/Radarr.db*
        cp -f /tmp/Radarr_backup/* /usr/local/Radarr/var/.config/Radarr/
    ```

1. Update permissions on the files:

    ```shell
        cd /usr/local/Radarr/var/.config/Radarr/
        chown -R Radarr:users *
        chmod -R 0644 *
    ```

    On some installations, the user is different: `chown -R sc-``:``  *`
1. Start

## Help I have locked my self out

To disable authentication (to reset your username or password) you will need need to edit `config.xml` which will be inside the [Radarr Appdata Directory](/radarr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Radarr
1. Radarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## Help I have forgotten my password

\* Please see steps listed above.

## Jackett shows more results than when manually searching
  
This is usually due to searching Jackett differently than you do. See our [troubleshooting](/radarr/troubleshooting)Troubleshooting Article for more information.

## Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage] wiki article.
**Article Needed**

## Web Interface Only Loads at localhost on Windows

- If you can only reach your web interface at <http://localhost:7878/> or <http://127.0.0.1:7878/>, you need to run as administrator at least once.

## Permissions

- Radarr will need to move files away from where the downloader puts them into the final location, so this means that will need to read/write to both the source and the destination directory and files.

- On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and . In umask notation, that would be `002`.

## System & Logs loads forever

- It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Sonarr is running on. But I still recommend checking the list.

## Finding Cookies

- Some sites cannot be logged into automatically and require you to login manually then give the cookies to to work. This page describes how you do that.

  - [Chrome cookies](https://developer.chrome.com/docs/devtools/storage/cookies/)
  - [Firefox cookies](https://developer.mozilla.org/en-US/docs/Tools/Storage_Inspector/Cookies)

## Unpack Torrents

- Most torrent clients doesn’t come with the automatic handling of compressed archives like their usenet counterparts. We recommend [unpackerr](https://github.com/davidnewhall/unpackerr).

## uTorrent is no longer working

- Ensure the Web UI is enabled

- Ensure that the Alt Listening Port (Advanced -> Web UI) is not the same as the Listening Port (Connections)

- We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

## Does Radarr require a SABnzbd post-processing script to import downloaded episodes?

No. Radarr will talk to your download client to determine where the files have been downloaded and will import them automatically. If and your download client are on different machines you will need to use Remote Path Mapping to link the remote path to a local one so knows where to find the files.

## I got a pop-up that said config.xml was corrupt, what now?

- Radarr was unable to read your config file on start-up as it became corrupted somehow. In order to get back online, you will need to delete `.xml` in your [appdata-directory](/radarr/appdata-directory), once deleted start and it will start on the default port (), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

- Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

- Radarr now validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then will refuse to connect. Free properly signed certificates are available from [let's encrypt](https://letsencrypt.org/).

- If your download client and are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## VPNs, Jackett, and the * ARRs

- Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

- In other words, putting the  *Arrs (Lidarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. **To be clear it is not a matter if VPNs will cause issues with the Arrs, but when: image providers will block you and cloudflare is in front of most of arr servers (updates, metadata, etc.) and liable to block you too**

- In addition, some private trackers **ban** for browsing from a VPN, which is how Jackett works. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Jackett behind the VPN. However, you should not do that if you have private trackers without checking their rules first. **Many private trackers will ban you for using or accessing them (i.e. using Jackett) via a VPN.**

## Jackett's /all Endpoint

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is recommended.

- **May 2021 Update: It is likely Sonarr support will be phased out for the jackett `/all` endpoint in the future due to the fact it only causes issues.**

- [Even Jackett says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

- Using the `/all` endpoint has no advantages (besides reduced management overhead), only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000

- Adding each indexer separately It allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In Sonarr, each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you're more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error, Sonarr will disable it and now you do not get any results.

## Why are there two files? | Why is there a file left in downloads?

This is expected. This is how the Torrent Process works with .

1. Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Radarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.

- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file.

1. If the "Completed Download Handling - Remove Completed" option is enabled in Sonarr's settings, Sonarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped.
