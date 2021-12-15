---
title: Sonarr FAQ
description: 
published: true
date: 2021-12-12T22:07:51.416Z
tags: sonarr, needs-love, troubleshooting, faq
editor: markdown
dateCreated: 2021-06-09T18:39:33.208Z
---

# Sonarr Basics

## How does Sonarr find episodes?

- Sonarr does *not* regularly search for episode files that are missing or have not met their quality goals. Instead, it fairly frequently queries your indexers and trackers for *all* the newly posted episodes/newly uploaded releases, then compares that with its list of episodes that are missing or need to be upgraded. Any matches are downloaded. This lets Sonarr cover a library of *any size* with just 24-100 queries per day (RSS interval of 15-60 minutes). If you understand this, you will realize that it only covers the *future* though.
- So how do you deal with the present and past? When you're adding a show, you will need to set the correct path, profile and monitoring status then use the Start search for missing checkbox. If the show has had no episodes and hasn't been released yet, you do not need to initiate a search.
- Put another way, Sonarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases uploaded in the past.
- If you've already added the show, but now you want to search for it, you have a few choices. You can go to the show's page and use the search button, which will do a search and then automatically pick episode(s). You can search individual episodes or seasons automatically or manually. Or you can go to the [Wanted](/sonarr/wanted) tab and search from there.
- If Sonarr has been offline for an extended period of time, Sonarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn't been too long Sonarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed episodes.

## How are possible downloads compared?

>Generally Quality Trumps All
{-is.info}

The current logic [can be found here](https://github.com/Sonarr/Sonarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs#L31-L40s).
***As of 2021-06-09 the logic is as follows***

1. Quality
1. Language
1. Preferred Word Score
1. Protocol
1. Episode Count
1. Episode Number
1. Indexer Priority
1. Seeds/Peers (If Torrent)
1. Age (If Usenet)
1. Size

## Preferred Words FAQs

For the score of the on disk file: The existing name of the file and the "scene name" of the release are evaluated for preferred words. The ​​higher score of the two is taken.

How are preferred words included in renaming?

For Sonarr you can make use of the `{Preferred Words}` token in your renaming scheme and also enable`Include Preferred when Renaming` in the release profile. take a look [HERE](https://trash-guides.info/Sonarr/V3/Sonarr-recommended-naming-scheme/) for a recommended naming scheme examples for Sonarr. Using the tokens in your renaming scheme could help with download loop issues.

As of recent builds, you can now also include Preferred Words on a Release Profile basis `{Preferred Words:<Release Profile Name>}`

Preferred Words always upgrade a release even if the quality and/or language cutoff has been met.

## How do I change from the Windows Service to a Tray App?

1. Shut Sonarr down
1. Run serviceuninstall.exe that's in the Sonarr directory
1. Run Sonarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
1. (Optional) Drop a shortcut to Sonarr.exe in the startup folder to auto-start on boot.

## How do I Backup/Restore my Sonarr?

### Backing up Sonarr

#### Using built-in backup

- Go to System => Backup in the Sonarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### Using file system directly

- Find the location of the AppData directory for Sonarr  
  - Via the Sonarr UI go to System => About  
  - [Sonarr Appdata Directory](/sonarr/appdata-directory)
- Stop Sonarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.
{.is-warning}

#### Using zip backup

- Re-install Sonarr
- Run Sonarr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### Using file system backup

- Re-install Sonarr
- Find the location of the AppData directory for Sonarr  
  - Running Sonarr once and via the UI go to System => About  
  - [Sonarr Appdata Directory](/sonarr/appdata-directory)
- Stop Sonarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Sonarr
- As long as the paths are the same, everything will pick up where it left off

- **Restore for Synology NAS**

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.
{.is-warning}

- Re-install Sonarr
- Find the location of the AppData directory for Sonarr  
  - Running Sonarr once and via the UI go to System => About  
  - [Sonarr Appdata Directory](/sonarr/appdata-directory)
- Stop Sonarr
- Connect to the Synology NAS through SSH and log in as root  

> On some installations, the user is different than the below commands: `chown -R sc-Sonarr:Sonarr *` {.is-info}

- Execute the following commands:

```shell
rm -r /usr/local/Sonarr/var/.config/Sonarr/Sonarr.db
cp -f /tmp/Sonarr_backup/* /usr/local/Sonarr/var/.config/Sonarr/
```

- Update permissions on the files:

 ```shell
cd /usr/local/Sonarr/var/.config/Sonarr/
chown -R Sonarr:users *
chmod -R 0644 *
```

- Start Sonarr

## Help I have locked myself out

{#help-i-have-forgotten-my-password}

To disable authentication (to reset your username or password) you will need need to edit `config.xml` which will be inside the [Sonarr Appdata Directory](/sonarr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Sonarr
1. Sonarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## Why are there two files? \| Why is there a file left in downloads?

This is expected. Below is how the Torrent Process works.

1. Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, etc.
1. Sonarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
1. Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within under the specific download client). When files are imported to your media folder will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
1. If the "Completed Download Handling - Remove Completed" option is enabled in Sonarr's settings, Sonarr will delete the original file and torrent from your download client, but only if the download client reports that seeding is complete and torrent is stopped.

> Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then will fall back and copy the file. {.is-info}

## I see that feature/bug X was fixed, Why can I not see it?

Sonarr consists of two main branches of code, `main` and `develop`.

- `main`is released periodically, when the `develop` branch is stable
- `develop` is for pre-release testing and people willing to live on the edge. When a feature is marked as in `develop` it will only be available to users running the `develop` branch, once it has been move to live (in `main`) it is officially released.

## Episode Progress - How is it calculated?

- There are two parts to the episode count, one being the number of episodes (Episode Count) and the other being the number of episodes with files (Episode File Count), each one uses slightly different logic to give you the overall progress for a series or season.

  - Episode Count => Episode has already aired AND is monitored OR - Episode has a file
  - Episode File Count => Episode has a file

- If a series has 10 episodes that have all aired and you do not have any files for them you would have 0/10 episodes, if you unmonitored all the episodes in that series you would have 0/0 and if you got all the episodes for that series, regardless of if the episodes are monitored or not, you would have 10/10 episodes.

## How do I access Sonarr from another computer?

- By default Sonarr doesn't listen to requests from all systems (when not run as administrator), it will only listen on localhost, this is due to how the Web Server Sonarr uses integrates with Windows (this also applies for current alternatives). If Sonarr is run as an administrator it will correctly register itself with Windows as well as open the Firewall port so it can be accessed from other systems on your network. Running as admin only needs to happen once (if you change the port it will need to be re-run).

## Why doesn't Sonarr automatically search for missing episodes?

- There are two times when we would want to have missing episodes searched for, when a new series with existing aired episodes is added and when  Sonarr has been offline and unable to find episodes as it normally would. Endlessly searching for episodes that have aired that are missing is a waste of resources, both in terms of local processing power and on the indexers and in our experience catches users off guard, wasting bandwidth.

- In v1 of Sonarr we had an opt in backlog search option, often people would turn it on and then get a bunch of old episodes and ask us why, we also had indexers ask why they saw an increase in API calls, which was due to the backlog searching.

- In v2 we sat back and thought about it and realized the benefit is not really there, we could try to throttle the searching, but that just draws it out and still does the same thing; hammer the indexer with useless requests. If the episode wasn't there the last time the search was performed, why would it be there now? It would be if it was reposted, but if it was reposted, the automatic process that gets new episodes would see it was posted and act on it.

## Why does Sonarr refresh series information so frequently?

- Sonarr refreshes series and episode information in addition to rescanning the disk for files every 12 hours. This might seem aggressive, but is a very important process. The data refresh from our TVDb proxy is important, because new episode information is synced down, air dates, number of episodes, status (continuing/ended). Even shows that aren't airing are being updated with new information.
- The disk scan is less important, but is used to check for new files that weren't sorted by Sonarr and detect deleted files.
- The most time consuming portion is the information refresh (assuming reasonable disk access speed), larger shows take longer due to the number of episodes to process.

> It is not possible to disable this task. If this task is running for long enough that you feel it's the problem, something else is going on that needs to be solved instead of stopping this task.
{.is-warning}

## Why is there a number next to Activity?

- This number shows the count of episodes in your download client's queue and the last 60 items in its history that have not yet been imported. If the number is blue it is operating normally and should import episodes when they complete. Yellow means there is a warning on one of the episodes. Red means there has been an error. In the case of yellow (warning) and red (error), you will need to look at the queue under Activity to see what the issue is (hover over the icon to get more details).
- You need to remove the item from your download client's queue or history to remove them from Sonarr's queue.

## What's the different Series Types?

- Most shows should be `Standard`. For daily shows which are typically released with a date, `Daily` should be used. Finally, there is anime where using `Anime` is *usually* right, but sometimes `Standard` can work better, so try the *other* one if you're having issues.

- Please note that if the series type is set to anime and if none of your enabled indexers have any anime categories configured then it effectively skips the indexer and may appear that it is not searching.

- Please note that not all indexers support season/episode (standard) searches.

### Series Types

- **Anime** - Episodes released using an absolute episode number
- **Daily** - Episodes released daily or less frequently that use year-month-day (2017-05-25)
- **Standard** - Episodes released with SxxEyy pattern

### Series Type Examples

Below are some example release names for each show type. The specific differentiating piece is noted in bold.

#### Daily

- Some.Daily.Show.**2021.03.04**.1080p.HDTV.x264-DARKSPORT
- A.Daily.Show.with.Some.Guy.**2021.03.03**.1080p.CC.WEB-DL.AAC2.0.x264-null
- DailyShow.**2021.03.08**.720p.HDTV.x264-NTb

#### Standard

- The.Show.**S20E03**.Episode.Title.Part.3.1080p.HULU.WEB-DL.DDP5.1.H.264-NTb
- Another.Show.**S03E08**.1080p.WEB.H264-GGEZ
- GreatShow.**S17E02**.1080p.HDTV.x264-DARKFLiX

#### Anime

- Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
- \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC) \[63B8AC67\]
- \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]

## How can I rename my series folders?

1. Series
1. Mass Editor
1. Select what series need their folder renamed
1. Change Root Folder to the same Root Folder that the series currently exist in
1. Select "Yes move files"

> If you are using Plex, this will trigger re-detection of intros, thumbnails, chapters, and preview metadata.
{.is-warning}

## How do I update Sonarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `main` or `develop`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- main - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/sonarr/release/VERSION.json) - (Default/Stable): This has been tested by users on nightly (`develop`) branch and it's not known to have any major issues. This branch should be used by the majority of users. On GitHub, this is the `main` branch.
- develop - ![Current Develop/Nightly](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/sonarr/nightly/VERSION.json) -  (Alpha/Unstable) : This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch.

> **Warning: You may not be able to go back to `main` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-danger}

- Note: If your install is through Docker append `:release`, `:latest`, `:nightly`, or `:develop` to the end of your container tag depending on who makes your builds.

|                                                                    | `main` (stable) ![Current Main/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/sonarr/release/VERSION.json) | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/sonarr/nightly/VERSION.json) |
| ------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [hotio](https://hotio.dev/containers/sonarr)                       | `cr.hotio.dev/hotio/sonarr:release`                                                                                                                                                                                            | `cr.hotio.dev/hotio/sonarr:nightly`                                                                                                                                                                                              |
| [LinuxServer.io](https://docs.linuxserver.io/images/docker-sonarr) | `lscr.io/linuxserver/sonarr:latest`                                                                                                                                                                               | `lscr.io/linuxserver/sonarr:develop`                                                                                                                                                                                |

### Installing a newer version

If Native:

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

If Docker:

1. Repull your tag and update your container

## Can I update Sonarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

## Can I switch from `develop` back to `main`?

- See the entry below

## Can I switch between branches?

> You can (almost) always increase your risk.{.is-info}

- `main` can go to `develop`
- See below or otherwise check with the development team to see if you can switch from `develop` to `main` for your given build.
- Failure to follow these instructions may result in your Sonarr becoming unusable or throwing errors. You have been warned.
  - The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.
- **October 8 2021 Update**
  - `3.0.6.1342` has been released as main/stable
  - For those on develop and are still on `3.0.6.1343` or lower you can safely downgrade to main
  - If you are on a newer version you *may be stuck* on nightly/develop until a new stable release is cut.  If you have a backup from prior to upgrading past the version noted above, you can reinstall and restore the backup. Check with the development team to see if you can safely downgrade.

## How do I request a feature for Sonarr?

- This is an easy one click [add a feature request on our GitHub](https://github.com/Sonarr/Sonarr/)

# Sonarr and Series Issues + Metadata

## How does Sonarr handle scene numbering issues (American Dad!, etc)?

### How Sonarr handles scene numbering issues

- Sonarr relies on [TheXEM](http://thexem.info/), a community driven site that lets users create mappings of shows that the scene (the people that post the files) and TheTVDb (which typically follows the network's numbering). There are a number of shows on there already, but it is easy to add another and typically the changes are accepted within a couple days (if they're correct). TheXEM is used to correct differences in episode numbering (disagreement whether an episode is a special or not) as well as season number differences, such as episodes being released as S10E01, but TheTVDb listing that same episode as S2017E01.
- XEM typically fixes the issues when release groups' numbering does not match TVDb numbering so Sonarr doesn't work. Well enter [XEM](http://thexem.info) which creates a map for Sonarr to look at.  
- Releases double episodes in a single file since that is how they air but TVDb marks each episode individually.
- Release groups use a year for the season S2010 and TVDb uses S01.  
- [XEM](http://thexem.info) works in most cases and keeps it running smooth without you ever knowing. However as with most things, there will always be a *problematic exceptions* and in this case there is a list of them.

> Certain indexers or release groups may follow TVDb rather than `Scene` (i.e. XEM). If this is observered, please submit them via the scene mapping form. Make sure it hasn't already been requested: [Requested Mappings](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0) and Make a new request here: [Scene Mapping Request Form](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform){.is-info}

### Problematic Shows

> This by no means is an all inclusive list of shows that have known issues with scene mapping; however, these are some common ones.
{.is-info}

- This is an incomplete list of the known shows and how/why they're problematic:  
- American Dad {#problemshow-americandad}
  - American Dad is currently on S18 based on TVDb or S17 based on Scene at the time of this writing. So searching in Sonarr for season 18 will **only** return S17 results because of the XEM map.
  > If you have an indexer / release groups with S18 episodes, please submit them via the scene mapping form. Make sure it hasn't already been requested: [Requested Mappings](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0) and Make a new request here: [Scene Mapping Request Form](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform){.is-info}
- Arrested Development {#problemshow-arresteddevelopment}
- Kitchen Nightmares (US) {#problemshow-kitchennightmaresus}
- Mythbusters {#problemshow-mythbusters}
- Paw Patrol {#problemshow-pawpatrol}
  - Double episode files vs single episode TVDb but also not all episodes are doubles so the map can get added wrong pointing to which ones are singles vs doubles
- Pawn Stars {#problemshow-pawnstars}
- Pokémon {#problemshow-pokemon}
  - On TheXem, [pokemon](http://thexem.info/xem/show/4638) is tracking *dubbed* episodes. So if you want subbed episodes, you may be out of luck. If certain release groups are following TVDb and not XEM mapping, please please submit them via the scene mapping form. Make sure it hasn't already been requested: [Requested Mappings](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0) and Make a new request here: [Scene Mapping Request Form](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)
- La Casa de Papel / Money Heist  {#problemshow-moneyheist}
  - TVDb has the original airing order from the Spanish network, but Netflix bought the rights and re-cut the series into a different episode count. This is causing "season 5" to be imported over existing "season 3" episodes. [Additional information can be found on this reddit thread](https://old.reddit.com/r/sonarr/comments/pdrr6l/money_heist_mess/)

## Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?

There can be multiple reasons why Sonarr is not able to find or import episodes for a particular series:

- Sonarr does not use aliases from TVDb.

- Sonarr relies on being able to match titles, often the uploaders name episodes using different titles, e.g. `CSI: Crime Scene Investigation` is posted just `CSI` thus Sonarr cannot match the names without some help. These are handled by the Scene Mapping that the Sonarr Team maintains.

- **For anime, it will need to be added to [thexem.info](https://thexem.info)**, for other series to request a new mapping see the steps below.

1. Make sure it hasn't already been requested. [Requested Mappings](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
1. Make a new request here: [Scene Mapping Request Form](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)

- *Typically these are added within 1-5 days.*

- *Again, do not request a mapping for Anime; use XEM for that.* Further information can be found with some of the XEM folks that hangout in our [\#XEM discord channel](https://discord.gg/an9rnEdWs5).

- > The series "Helt Perfekt" with TVDb ids of `343189` and `252077` is difficult to automate due to TVDb having the same name for both shows, violating TVDb's own rules. The first entry for the series gets the name. Any future entries for the series must have the year as part of the series name. However, a scene exception as been added to map releases (case sensitive mapping) Helt Perfekt releases containing `NORWEGIAN` -\> `252077` and containing `SWEDISH` -\> `343189`
{.is-info}

## TVDb is updated why isn't Sonarr?

{#tvdb}

- TVDb has a 24 hour cache on their API. TVDb's API then needs to populate through their CDN cache which takes several hours. Sonarr's Skyhook has a much smaller few hour cache on top of that. Additionally, Sonarr only runs the Refresh Series task every 12 hours. This task can be manually ran from System => Tasks; "Update All" from the Series Index, or manually ran for a specific series on that series's page.

- Therefore for a change on TVDb to get into Sonarr automatically it will typically take between 36 and 48 hours (24 + ~3 + ~3 + 12)

- If a series or episodes are missing on TVDb, they'll take 36 to 48 hours from when they're added to populate into your Sonarr instance.

{#missing-episodes}

- If you know a TVDb update was made more than 48 hours ago, then please come discuss on our [Discord](https://discord.gg/M6BvZn5).

## Why can I not add a new series?

- In the event that TheTVDb is unavailable Sonarr is unable to get search results and you will be unable to add any new series by searching. You may be able to add a new series by the TVDbID if you know what it is, the UI explains how to add it by an ID.
- Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDb ID that does not have an English title. If no English title exist for that series on TheTVDb it will need to be added (if available).
- The show must be a TV Series, and not a movie. It must also exist on TVDb. If it is on IMDB, TMDB, or anywhere else, but not on TVDb you cannot add the show.
- The series must exist on TVDb
- Certain series may actually be considered continuations are and seasons in their primary series.
  - Some series/seasons known are:
  - [Dexter New Blood was Season 9](https://thetvdb.com/series/dexter/seasons/official/9) but it is now [it's own series](https://thetvdb.com/series/dexter-new-blood)

## Why can I not add a new series when I know the TVDb ID?

- Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDb ID that does not have an English title. If no English title exist for that series on TheTVDb it will need to be added (if available).

# Sonarr Common Problems

## Episode does not have an absolute number

- The episode(s) on TVDb do not have an absolute number assigned.  Update the series on TVDb if required and then wait the 36-48 hours for the update to clear TVDb's internal cache and load into Sonarr

## System & Logs loads forever

- It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Sonarr is running on. But I still recommend checking the list.

## Weird UI Issues

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](/useful-tools#clearing-cookies-and-local-storage) wiki article.

## Web Interface Only Loads at localhost on Windows

- If you can only reach your web interface at <http://localhost:8989/> or <http://127.0.0.1:8989>, you need to run Sonarr as administrator at least once.

## uTorrent is no longer working

- Ensure the Web UI is enabled

- Ensure that the Alt Listening Port (Advanced => Web UI) is not the same as the Listening Port (Connections)

- We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

## Does Sonarr require a SABnzbd post-processing script to import downloaded episodes?

- No. Sonarr will talk to your download client to determine where the files have been downloaded and will import them automatically. If Sonarr and your download client are on different machines you will need to use Remote Path Mapping to link the remote path to a local one so Sonarr knows where to find the files.

## I got a pop-up that said config.xml was corrupt, what now?

- Sonarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Sonarr back online, you will need to delete `.xml` in your [AppData Folder](/sonarr/appdata-directory) once deleted start Sonarr and it will start on the default port (8989), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

- Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

- Sonarr now validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Sonarr will refuse to connect. Free properly signed certificates are available from [let's encrypt](https://letsencrypt.org/).

- If your download client and Sonarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` => `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Sonarr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Sonarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## VPNs, Jackett, and the \*ARRs

- Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

- In other words, putting the  \*Arrs (Lidarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of arr servers (updates, metadata, etc.) and liable to block you too**

- In addition, some private trackers **ban** for browsing from a VPN, which is how Jackett works. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Jackett behind the VPN. However, you should not do that if you have private trackers without checking their rules first. **Many private trackers will ban you for using or accessing them (i.e. using Jackett) via a VPN.**

## I see log messages for shows I do not have/do not want

- These messages are completely normal and come from the RSS feeds that Sonarr checks to see if there are episodes you do want, usually these only appear in debug/trace logging, but in the event of an problem processing an item you may see a warning or error. It is safe to ignore the warnings/errors as well since they are for shows you do not want, in the event it is for a show you want, open up a support thread on the forums.

## Seeding torrents aren't deleted automatically

- When a torrent that is still seeding is imported, it is copied or hard linked (if enabled and *possible*) so that the torrent client can continue seeding. In an ideal setup, the torrent download folder and the library folder will be on the same file system and *look like it* (Docker and network shares make this easy to get wrong), which makes hard links possible and minimizes wasted space.
- In addition, you can configure your seed time/ratio goals in Sonarr or your download client, setup your download client to *pause* or *stop* when they're met and enable Remove under Completed and Failed Download Handler. That way, torrents that finish seeding will be removed from the download client by Sonarr.

## Help, my Mac says Sonarr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac)
[![Developer Cannot be verified](/assets/general/faq_1_mac.png)]

## Help, my Mac says Sonarr.app is damaged and cannot be opened

- That is either due to a corrupt download so try again or [security issues, please see this related FAQ entry.](#help-my-mac-says-sonarr-cannot-be-opened-because-the-developer-cannot-be-verified)

## I am getting an error: Database disk image is malformed

- This means your SQLite database that stores most of the information for Sonarr is corrupt.
- Try the [sqlite3 `.recover` command](https://www.sqlite.org/cli.html#recover_data_from_a_corrupted_database)
- If your sqlite does not have `.recover` or you wish a more GUI friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db)
- [Try restoring from a backup](#how-do-i-backup-and-restore-sonarr)

- This error may show if the database file is not writable by the user/group Sonarr is running as.

- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local).**SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you're trying to restore your database you can check out our Backup/Restore guide [here](#how-do-i-backup-and-restore-sonarr).

- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use Sonarr on a Mac and it suddenly stopped working. What happened?

- Most likely this is due to a MacOS bug which caused one of the Sonarr databases to be corrupted.
- [Follow these steps to resolve](#i-am-getting-an-error-database-disk-image-is-malformed)
- Then attempt to launch Sonarr and see if it works. If it does not work, you will need further support. Post in our [reddit](http://reddit.com/r/Sonarr) or hop on [discord](https://discord.gg/M6BvZn5) for help.

## Why can Sonarr not see my files on a remote server?

- In short: the user Sonarr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is, Sonarr is running as a service, which causes one of two things:

### Sonarr runs under the LocalService account by default which doesn't have access to protected remote file shares

- Run Sonarr's service as another user that has access to that share
- Open the Administrative Tools \> Services window on your Windows server.
- Stop the Sonarr service.
- Open the Properties \> Log On dialog.
- Change the service user account to the target user account.
- Run Sonarr.exe using the Startup Folder

### You're using a mapped network drive (not a UNC path)

- Change your paths to UNC paths (`\\server\share`)
- Run Sonarr.exe via the Startup Folder

## Mapped Network Drives vs UNC Paths

- Using mapped network drives generally doesn't work very well, especially when Sonarr is configured to run as a service. The better way to set shares up is using UNC paths. So instead of `X:\TV` use `\\Server\TV`.

- A key point to remember is that Sonarr gets path information from the downloader, so you will *also* need to setup NZBGet, SABNzbd or any other downloader to use UNC paths too.

## Sonarr will not work on Big Sur

Run

```shell
chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr
```

## My Custom Script stopped working after upgrading from v2

- You were likely passing arguments in your connection\...that is not supported.
- To correct this:
  1. Change your argument to be your path
  1. Make sure the shebang in your script maps to your pwsh path (if you do not have a shebang definition in there, add it)
  1. Make sure the pwsh script is executable

# Sonarr Searching & Downloading Common Problems

## Why didn't Sonarr grab an episode I was expecting?

First, make sure you read and understand the section above called ["How does Sonarr find episodes?](#how-does-sonarr-find-episodes) Second, make sure at least one of your indexers has the episode you were expecting to be grabbed.

1. Click the 'Manual Search' icon next to the episode listing in Sonarr. Are there any results? If no, then either Sonarr is having trouble communicating with your indexers, or your indexers do not have the episode, or the episode is improperly named/categorized on the indexer.
1. **If there are results from step 1**, check next to them for red exclamation point icon. Hover over the icon to see why that release is not a candidate for automatic downloads. If every result has the icon, then no automatic download will occur.
1. **If there is at least one valid manual search result from step 2**, then an automatic download should have happened. If it didn't, the most likely reason is a temporary communication problem preventing an RSS Sync from your indexer. It is recommended to have several indexers set up for best results.
1. **If there is no manual result from a show, but you can find it when you browse your indexer's website** - This is a common problem that is most frequently caused by having an insufficient number of indexers. Different indexers index different content, and not all shows on your indexer may be tagged properly, which would cause Sonarr's search to fail. Having several indexers active is the best solution to this problem.

## Why wont Sonarr import a TBA episode?

- On TVDb, when episode names are unknown they'll be titled TBA and there is a 24 hour cache on the TVDb API. Typically, changes to the TVDb website take 24-48 hours to reach Sonarr due to TVDb cache (24 hours), skyhook cache (a few hours), and the series refresh interval (every 12 hours). The [Episode Title Required setting](/sonarr/settings#importing) in Sonarr controls import behavior when the title is TBA, but after 24 hours the release will be imported even if the title is still TBA. There is also no automatic follow up renaming of TBA titled files. Note that the TBA timer is calculated from the episode airdate and time, not from when you've grabbed it or the upload time.

## Sonarr says Unknown Series on Searches or Imports

- See the [Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?](/sonarr/faq#why-cant-sonarr-import-episode-files-for-series-x-why-cant-sonarr-find-releases-for-series-x) entry

## Jackett's /all Endpoint

{#jackett-all-endpoint}

- The Jackett `/all` endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is strongly recommended.  Alternatively, you may wish to check out the Jackett & NZBHydra2 alternative [Prowlarr](/prowlarr)

- **May 2021 Update: It is likely \*Arr support will be phased out for the jackett `/all` endpoint in the future due to the fact it only causes issues.**

- [Even Jackett says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)

- Using the `/all` endpoint has no advantages (besides reduced management overhead), only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000

- Note that using NZBHydra2 as a single aggregate entry has the same issues as Jackett's `/all`

- Add each indexer separately. This allows for fine tuning of categories on a per indexer basis, which can be a problem with the `/all` end point if using the wrong category causes errors on some trackers. In \*Arr, each indexer is limited to 1000 results if pagination is supported or 100 if not, which means as you add more and more trackers to Jackett, you're more and more likely to clip results. Finally, if *one* of the trackers in `/all` returns an error, \*Arr will disable it and now you do not get any results.

## Jackett shows more results than Sonarr when manually searching

This is usually due to Sonarr searching Jackett differently than you do. [See this troubleshooting article for further information](/sonarr/troubleshooting#searches-indexers-and-trackers).

## Finding Cookies

- Some sites cannot be logged into automatically and require you to login manually then give the cookies to Sonarr to work. [Please see this article for details.](/useful-tools#finding-cookies)

## Unpack Torrents

- Most torrent clients doesn't come with the automatic handling of compressed archives like their usenet counterparts. We recommend [unpackerr](https://github.com/davidnewhall/unpackerr).

## Permissions

- Sonarr will need to move files away from where the downloader puts them into the final location, so this means that Sonarr will need to read/write to both the source and the destination directory and files.
- On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and Sonarr. In umask notation, that would be `002`.
