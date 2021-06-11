---
title: Sonarr FAQ
description:
published: true
date: 2021-06-09T18:22:49.248Z
tags: sonarr, troubleshooting, faq
editor: markdown
dateCreated: 2021-06-09T18:22:32.575Z
---
## How does Sonarr find episodes?

- Sonarr does *not* regularly search for episode files that are   missing or have not met their quality goals. Instead, it fairly   frequently queries your indexers and trackers for *all* the newly   posted episodes/newly uploaded releases, then compares that with its   list of episodes that are missing or need to be upgraded. Any   matches are downloaded. This lets Sonarr cover a library of *any   size* with just 24-100 queries per day (RSS interval of 15-60   minutes). If you understand this, you\'ll realize that it only covers the *future* though.
- So how do you deal with the present and past? When you\'re adding a show, you\'ll need to set the correct path, profile and monitoring status then use the Start search for missing checkbox. If the show has had no episodes and hasn\'t been released yet, you don\'t need to initiate a search.
- Put another way, Sonarr will only find releases that are newly uploaded to your indexers. It will not actively try to find releases uploaded in the past.
- If you\'ve already added the show, but now you want to search for it, you have a few choices. You can go to the show\'s page and use the search button, which will do a search and then automatically pick episode(s). You can search individual episodes or seasons automatically or manually. Or you can go to the [Wanted](sonarr/wanted) tab and search from there.
- If Sonarr has been offline for an extended period of time, Sonarr will attempt to page back to find the last release it processed in an attempt to avoid missing a release. As long as your indexer supports paging and it hasn\'t been too long Sonarr will be able to process the releases it would have missed and avoid you needing to perform a search for the missed episodes.

## Why didn't Sonarr grab an episode I was expecting?

First, make sure you read and understand the section above called ["How does Sonarr find episodes?](#how-does-sonarr-find-episodes) Second, make sure at least one of your indexers has the episode you were expecting to be grabbed.

1. Click the 'Manual Search' icon next to the episode listing in Sonarr. Are there any results? If no, then either Sonarr is having trouble communicating with your indexers, or your indexers do not have the episode, or the episode is improperly named/categorized on the indexer.
1. **If there are results from step 1**, check next to them for red exclamation point icon. Hover over the icon to see why that release is not a candidate for automatic downloads. If every result has the icon, then no automatic download will occur.
1. **If there is at least one valid manual search result from step 2**, then an automatic download should have happened. If it didn't, the most likely reason is a temporary communication problem preventing an RSS Sync from your indexer. It is recommended to have several indexers set up for best results.
1. **If there is no manual result from a show, but you can find it when you browse your indexer's website** - This is a common problem that is most frequently caused by having an insufficient number of indexers. Different indexers index different content, and not all shows on your indexer may be tagged properly, which would cause Sonarr's search to fail. Having several indexers active is the best solution to this problem.

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

For the score of the on disk file: The existing name of the file and the \"scene name\" of the release are evaluated for preferred words. The ​​higher score of the two is taken.

How are preferred words included in renaming?

For Sonarr you can make use of the \`{Preferred Words}\` token in your renaming scheme. and also check mark \`Include Preferred when Renaming\` in the release profile. take a look [HERE](https://trash-guides.info/Sonarr/V3/Sonarr-recommended-naming-scheme/) for a recommended naming scheme examples for Sonarr. Using the tokens in your renaming scheme could help with download loop issues.

Preferred Words always upgrade a release even if the quality and/or language cutoff has been met.

## How does Sonarr handle scene numbering issues (American Dad!, etc)?

- **How Sonarr handles scene numbering issues**  - Sonarr relies on [TheXEM](http://thexem.de/), a community driven site that lets users create mappings of shows that the scene (the people that post the files) and TheTVDB (which typically follows the network's numbering). There are a number of shows on there already, but it is easy to add another and typically the changes are accepted within a couple days (if they're correct). TheXEM is used to correct differences in episode numbering (disagreement whether an episode is a special or not) as well as season number differences, such as episodes being released as S10E01, but TheTVDB listing that same episode as S2017E01.
- **Problematic Shows**  

> This by no means is an all inclusive list of shows that have known issues with scene mapping however, these are some common ones.
{.is-info}

- Typical Issue: Scene numbering does not match TVDb numbering so Sonarr doesn\'t work. Well enter [XEM](http://thexem.de) which creates a map for Sonarr to look at.  
- Scene releases double episodes in a single file since that is how they air but TVDb marks each episode individually.
- Scene uses a year for the season S2010 and TVDb uses S01.  
- [XEM](http://thexem.de) works in most cases and keeps it running smooth without you ever knowing. However as with most things, there will always be a *black sheep* and in this case there is a list of them.  
- This is an incomplete list of the known shows and how/why they\'re problematic:  
- American Dad
- Arrested Development
- Mythbusters
- Paw Patrol
- Double episode files vs single episode TVDb but also not all episodes are doubles so the map can get added wrong pointing to which ones are singles vs doubles
- Pawn Stars
- Pokémon
- On TheXem, [pokemon](http://thexem.de/xem/show/4638) is tracking \* dubbed\* episodes. So if you want subbed episodes, you may be out of luck. If certain release groups are following TVDB and not XEM mapping, please contact us on our discord and bring the release name and group name as exceptions can be added for groups who follow TVDB.
- **Possible resolutions:**
  1. TVDb adds alternate ordering to the API (Current status: Unlikely)
  1. XEM adds a map to allow for alternate orders that sonarr can use (Current status: Unlikely)
  1. Sonarr allows for disabling of XEM maps when doing manual searches (Current status: Unlikely)

- **Sonarr side effects:**  
- On top of the issues with the shows already, Sonarr also has some odd behavior so you may just need to overlook this as well.
Example:
  - American Dad is currently on S17 based on TVDb or S16 based on Scene at the time of this writing. So searching in sonarr for season 17 will **only** return S16 results because of the XEM map.

> If you have a tracker with S17 episodes (because they use P2P and not Scene), please contact us on our discord and bring the release name and group name as exceptions can be added for groups who follow TVDB.
{.is-info}

## Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?

Sonarr relies on being able to match titles, often the scene posts episodes using different titles, e.g. `CSI: Crime Scene Investigation` as just `CSI` so Sonarr can't match the names without some help. Sonarr maintains a list of problematic series which lets us solve this issue.
**For anime, it will need to be added to [thexem.de](https://thexem.de)**, for other series to request a new mapping see the steps below.

1. Make sure it hasn't already been requested. [Requested Mappings](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
1. Make a new request here: [Scene Mapping Request Form](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)

*Typically these are added within 1-2 days.*

*Again, do not request a mapping for Anime; use XEM for that.* Further information can be found with some of the XEM folks that hangout in our [\#XEM discord channel](https://discord.gg/an9rnEdWs5).

> The series \"Helt Perfekt\" with TVDB ids of `343189` and `252077` is difficult to automate due to TVDB having the same name for both shows, violating TVDB\'s own rules. The first entry for the series gets the name. Any future entries for the series must have the year as part of the series name. However, a scene exception as been added to map releases (case sensitive mapping) Helt Perfekt releases containing `NORWEGIAN` -\> `252077` and containing `SWEDISH` -\> `343189`
{.is-info}

## TVDB is updated why isn\'t Sonarr?

TVDB has a 24 hour cache on their API. Skyhook has a much smaller few hour cache on top of that. Sonarr only runs the Refresh Series task every 12 hours. Thus it typically takes 24 to 48 hours for a TVDB update to make it into Sonarr.

If you know a TVDB update was made more than 48 hours ago, then please come discuss on our [Discord](https://discord.gg/M6BvZn5).

## I see that feature/bug X was fixed, why can't I see it?

Sonarr consists of two main branches of code, `main` and `develop`.

- `main`is released periodically, when the `develop` branch is stable\
- `develop` is for pre-release testing and people willing to live on the edge. When a feature is marked as in `develop` it will only be available to users running the `develop` branch, once it has been move to live (in `main`) it is officially released.

## Episode Progress - How is it calculated?

There are two parts to the episode count, one being the number of episodes (Episode Count) and the other being the number of episodes with files (Episode File Count), each one uses slightly different logic to give you the overall progress for a series or season.

- Episode Count => Episode has already aired AND is monitored OR - Episode has a file
- Episode File Count => Episode has a file

If a series has 10 episodes that have all aired and you don't have any files for them you would have 0/10 episodes, if you unmonitored all the episodes in that series you would have 0/0 and if you got all the episodes for that series, regardless of if the episodes are monitored or not, you would have 10/10 episodes.

## How do I access Sonarr from another computer?

​​By default Sonarr doesn't listen to requests from all systems (when not run as administrator), it will only listen on localhost, this is due to how the Web Server Sonarr uses integrates with Windows (this also ​​applies for current alternatives). If Sonarr is run as an administrator ​​it will correctly register itself with Windows as well as open the ​​Firewall port so it can be accessed from other systems on your network. ​​Running as admin only needs to happen once (if you change the port it ​​will need to be re-run).
​​

## Why doesn't Sonarr automatically search for missing episodes?

​​There are two times when we would want to have missing episodes searched ​​for, when a new series with existing aired episodes is added and when ​​Sonarr has been offline and unable to find episodes as it normally ​​would. Endlessly searching for episodes that have aired that are missing ​​is a waste of resources, both in terms of local processing power and on ​​the indexers and in our experience catches users off guard, wasting ​​bandwidth.
​​
​​In v1 of Sonarr we had an opt in backlog search option, often people ​​would turn it on and then get a bunch of old episodes and ask us why, we ​​also had indexers ask why they saw an increase in API calls, which was ​​due to the backlog searching.
​​
​​In v2 we sat back and thought about it and realized the benefit is not ​​really there, we could try to throttle the searching, but that just ​​draws it out and still does the same thing; hammer the indexer with ​​useless requests. If the episode wasn't there the last time the search ​​was performed, why would it be there now? It would be if it was ​​reposted, but if it was reposted, the automatic process that gets new ​​episodes would see it was posted and act on it.
​​

## Why does Sonarr refresh series information so frequently?

​​ - Sonarr refreshes series and episode information in addition to rescanning the disk for files every 12 hours. This might seem aggressive, but is a very important process. The data refresh from our TVDB proxy is important, because new episode information is synced down, air dates, number of episodes, status (continuing/ended). Even shows that aren't airing are being updated with new information.
​​ - The disk scan is less important, but is used to check for new files that weren't sorted by Sonarr and detect deleted files.
​​ - The most time consuming portion is the information refresh (assuming reasonable disk access speed), larger shows take longer due to the number of episodes to process.
​​

## Why is there a number next to Activity?

​​ - This number shows the count of episodes in your download client's queue and the last 30 items in its history that have not yet been imported. If the number is blue it is operating normally and should import episodes when they complete. Yellow means there is a warning on one of the episodes. Red means there has been an error. In the case of yellow (warning) and red (error), you will need to look at the queue under Activity to see what the issue is (hover over the icon to get more details).
​​ - You need to remove the item from your download client's queue or history to remove them from Sonarr's queue.
​​

## I see log messages for shows I don't have/don't want

​​ - These messages are completely normal and come from the RSS feeds that Sonarr checks to see if there are episodes you do want, usually these only appear in debug/trace logging, but in the event of an problem processing an item you may see a warning or error. It is safe to ignore the warnings/errors as well since they are for shows you don't want, in the event it is for a show you want, open up a support thread on the forums.
​​

## Seeding torrents aren't deleted automatically

​​ - When a torrent that is still seeding is imported, it is copied or hard linked (if enabled and *possible*) so that the torrent client can continue seeding. In an ideal setup, the torrent download folder and the library folder will be on the same file system and *look like it* (Docker and network shares make this easy to get wrong), which makes hard links possible and minimizes wasted space.
​​ - In addition, you can configure your seed time/ratio goals in Sonarr or your download client, setup your download client to *pause* or *stop* when they're met and enable Remove under Completed and Failed Download Handler. That way, torrents that finish seeding will be removed from the download client by Sonarr.
​​

## Why can't I add a new series?

​​ - In the event that TheTVDB is unavailable Sonarr is unable to get search results and you will be unable to add any new series by searching. You may be able to add a new series by the TVDBID if you know what it is, the UI explains how to add it by an ID.
​​ - Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDB ID that does not have an English title. If no English title exist for that series on TheTVDB it will need to be added (if available).
​​ - The show must be a TV Series, and not a movie. It must also exist on TVDB. If it is on IMDB, TMDB, or anywhere else, but not on TVDB you cannot add the show.
​​ - The series must exist on TVDB
​​

## Why can't I add a new series when I know the TVDB ID?

​​ - Sonarr cannot add any series that does not have an English language title. If you try to add a series via TVDB ID that does not have an English title. If no English title exist for that series on TheTVDB it will need to be added (if available).
​​

## Sonarr won\'t work on Big Sur

​​Run `chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr`
​​

## My Custom Script stopped working after upgrading from v2

​​You were likely passing arguments in your connection\...that is not ​​supported.
​​
​​1.  Change your argument to be your path
​​2.  Make sure the shebang in your script maps to your pwsh path (if you don\'t have a shebang definition in there, add it)
​​3.  Make sure the pwsh script is executable
​​

## What\'s the different Series Types?

​​Most shows should be `Standard`. For daily shows which are typically ​​released with a date, `Daily` should be used. Finally, there is anime ​​where using `Anime` is *usually* right, but sometimes `Standard` can ​​work better, so try the *other* one if you're having issues. ​​
​​
Please note that if the series type is set to anime and none of your ​​enabled indexers have any anime categories configured then it ​​effectively skips the indexer and may appear that it is not searching. ​​

### Show Type Examples

​​
​​Below are some example release names for each show type. The specific ​​differentiating piece is noted in bold.
​​
​​**Daily**
​​
​​ - Some.Daily.Show.**2021.03.04**.1080p.HDTV.x264-DARKSPORT
​​ - A.Daily.Show.with.Some.Guy.**2021.03.03**.1080p.CC.WEB-DL.AAC2.0.x264-null
​​ - DailyShow.**2021.03.08**.720p.HDTV.x264-NTb
​​
​​**Standard**
​​
​​ - The.Show.**S20E03**.Episode.Title.Part.3.1080p.HULU.WEB-DL.DDP5.1.H.264-NTb
​​ - Another.Show.**S03E08**.1080p.WEB.H264-GGEZ
​​ - GreatShow.**S17E02**.1080p.HDTV.x264-DARKFLiX
​​
​​**Anime**
​​
​​ - Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
​​ - \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC) \[63B8AC67\]
​​ - \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]
​​

## How can I rename my series folders?

​# Series
​​
​​1.  Mass Editor
​​2.  Select what series need their folder renamed
​​3.  Change Root Folder to the same Root Folder that the series currently exist in
​​4.  Select \"Yes move files\"

## How do I update Sonarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `master` or `develop`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. This version will receive updates approximately monthly. On GitHub, this is the `master` branch.

- `develop` (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first. This version will receive updates either weekly or biweekly depending on development.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` (Alpha/Unstable): The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This is currently v3. This version is updated immediately.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:release`, `:latest`, `:nightly`, or `:develop` to the end of your container tag depending on who makes your builds.

||`master` (stable) ![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/sonarr/release/VERSION.json)|`develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/sonarr/nightly/VERSION.json)|
|---|---|---|
|[hotio](https://hub.docker.com/r/hotio/sonarr)|`hotio/sonarr:release`|`hotio/sonarr:nightly`|
|[LinuxServer.io](https://hub.docker.com/r/linuxserver/sonarr)|`linuxserver/sonarr:latest`|`linuxserver/sonarr:develop`|

## Can I update Sonarr inside my Docker container?

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

> You can (almost) always increase your risk.

- `master` can go to `develop` or `nightly`
- `develop` can go to `nightly`
- Check with the development team to see if you can switch from `nightly` to `master`; `nightly` to `develop`; or `develop` to `master` for your given build.
- Failure to follow these instructions may result in your Radarr becoming unusable or throwing errors. You have been warned.
  - The most common error is something like `Error parsing column 45 (Language=31 - Int64)` or other similar database errors around missing columns or tables.
- **May 28 2021 Update**
  - `3.2.1` has been released as master/stable
  - For those on nightly and are still on `3.2.1.5068` or lower you can safely downgrade to master
    - Same for those on develop.

## Help, my Mac says Sonarr cannot be opened because the developer cannot be verified

​​\* This is simple, please see this link for more information ​​[here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac) ​​![Developer Cannot be ​​verified](developer-cannot-be-verified.png "fig:Developer Cannot be verified"){width="2500"}
​​
​​## Help, my Mac says Sonarr.app is damaged and can't be opened
​​
​​That is either due to a corrupt download so try again or [security ​​issues, please see this related FAQ ​​entry.](#help_my_mac_says_Sonarr_cannot_be_opened_because_the_developer_cannot_be_verified "wikilink")
​​

## How do I request a feature for Sonarr?

​​This is an easy one click ​​[here](https://github.com/Sonarr/Sonarr/issues/new?assignees=&labels=feature+request&template=feature_request.md&title=)
​​

## I am getting an error: Database disk image is malformed

​​\* This means your SQLite database that stores most of the information ​​for Sonarr is corrupt.
​​
​​ -  - [Try restoring from a backup](#how_do_i_backup_restore_my_Sonarr "wikilink")  - You can follow [our instructions on this wiki.](Useful_Tools#Recovering_a_Corrupt_DB "wikilink")  - Alternatively, there is guide here to copy the contents from the corrupt database into a new one: <http://techblog.dorogin.com/2011/05/sqliteexception-database-disk-image-is.html>
​​
​​```{=html}
​​<!-- -->
​​```
​​ - This error may show if the database file is not writable by the user/group Sonarr is running as.
​​
​​```{=html}
​​<!-- -->
​​```
​​ - Another possible cause of you getting an error with your Database is that you\'re placing your database on a network drive (nfs or smb or something else not local). Simple answer to this is to not do this as SQLite and network drives not typically play nice together and will cause a malformed database eventually. **Sonarr\'s config folder must be on a local drive**. If you\'re trying to restore your database you can check out our Backup/Restore guide [here](#Restoring_from_Backup "wikilink").
​​
​​```{=html}
​​<!-- -->
​​```
​​ - If you are using mergerFS you need to remove `direct_io` as sqlite uses mmap which isn't supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)
​​

## I use Sonarr on a Mac and it suddenly stopped working. What happened?

​​Most likely this is due to a MacOS bug which caused one of the Sonarr ​​databases to be corrupted.
​​
​​[Follow these steps to ​​resolve](#i_am_getting_an_error_database_disk_image_is_malformed "wikilink")
​​
​​Then attempt to launch Sonarr and see if it works. If it does not work, ​​you\'ll need further support. Post in our
​​[reddit](http://reddit.com/r/Sonarr) or hop on
​​[discord](https://discord.gg/M6BvZn5) for help.
​​

## Why can't Sonarr see my files on a remote server?

​​In short: the user Sonarr is running as (if service) or under (if tray ​​app) cannot access the file path on the remote server. This can be for ​​various reasons, but the most common is, Sonarr is running as a service, ​​which causes one of two things:
​​
​​ - Sonarr runs under the LocalService account by default which doesn't have access to protected remote file shares.  - **Solutions:**  - Run Sonarr's service as another user that has access to that share  - Open the Administrative Tools \> Services window on your Windows server.  - Stop the Sonarr service.  - Open the Properties \> Log On dialog.  - Change the service user account to the target user account.  - Run Sonarr.exe using the Startup Folder
​​
​​```{=html}
​​<!-- -->
​​```
​​ - You're using a mapped network drive (not a UNC path)  - **Solutions:**  - Change your paths to UNC paths (`\\server\share`)  - Run Sonarr.exe via the Startup Folder
​​

## Mapped Network Drives vs UNC Paths

​​\* Using mapped network drives generally doesn't work very well, ​​especially when Sonarr is configured to run as a service. The better way ​​to set shares up is using UNC paths. So instead of `X:\Movies` use ​​`\\Server\Movies\`.
​​
​​ - A key point to remember is that Sonarr gets path information from the downloader, so you'll *also* need to setup NZBGet, SABNzbd or any other downloader to use UNC paths too.
​​

## How do I change from the Windows Service to a Tray App?

​​\# Shut Sonarr down
​​
​​1.  Run serviceuninstall.exe that\'s in the Sonarr directory
​​2.  Run Sonarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
​​3.  (Optional) Drop a shortcut to Sonarr.exe in the startup folder to auto-start on boot.
​​

## How do I Backup/Restore my Sonarr?

​​=== Backing up Sonarr ===
​​
​​ - **Using built-in backup**
​​
​​1.  Go to System: Backup in the Sonarr UI
​​2.  Click the Backup button
​​3.  Download the zip after the backup is created for safekeeping

​​ - Using file system directly
​​
​​1.  Find the location of the AppData directory for Sonarr  - Via the Sonarr UI go to System: About  - [Sonarr Appdata Directory](Sonarr_Appdata_Directory "wikilink")
​​2.  Stop Sonarr - This will prevent the database from being corrupted
​​3.  Copy the contents to a safe location
​​

### Restoring from Backup

​​
​​*Restoring to an OS that uses different paths won't work (Windows to ​​Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving ​​between OS X and Linux may work, since both use paths containing `/` ​​instead of `\` that Windows uses, but is not supported.*
​​
​​ - **Using zip backup**
​​
​​1.  Re-install Sonarr
​​2.  Run Sonarr
​​3.  Navigate to System \> Backup
​​4.  Select Restore Backup
​​5.  Select Choose File
​​6.  Select your backup zip file
​​7.  Select Restore
​​
​​ - **Using file system backup**
​​
​​1.  Re-install Sonarr
​​2.  Run Sonarr once to get the AppData directory location
​​3.  Stop Sonarr
​​4.  Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
​​5.  Restore from your backup
​​6.  Start Sonarr
​​7.  As long as the paths are the same, everything will pick up where it left off
​​
​​ - **Restore for Synology NAS**
​​
​​**CAUTION: Restoring on a Synology requires knowledge of Linux and Root ​​SSH access to the Synology Device.**
​​
​​1.  Re-install Sonarr\
​2.  Run Sonarr once to get the AppData directory location\
​​3.  Stop Sonarr\
​​4.  Connect to the Synology NAS through SSH and log in as root\
​​5.  Execute the following commands:

```shell rm -r /usr/local/Sonarr/var/.config/Sonarr/Sonarr.db*cp -f /tmp/Sonarr_backup/*/usr/local/Sonarr/var/.config/Sonarr/
```

​​6.  Update permissions on the files:

```shell cd /usr/local/Sonarr/var/.config/Sonarr/ chown -R Sonarr:users *chmod -R 0644*
```

 On some installations, the user is different: `chown -R sc-Sonarr:Sonarr *`
​​7.  Start Sonarr
​​

## Help I have locked myself out

To disable authentication (to reset your username or password) you will need need to edit `config.xml` which will be inside the [Radarr Appdata Directory](/radarr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Radarr
1. Radarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## Help I have forgotten my password

\* Please see steps listed above.
​​

## Jackett shows more results than Sonarr when manually searching

​​This is usually due to Sonarr searching Jackett differently than you do. ​​[See this troubleshooting article for further ​​information](/sonarr/troubleshooting#searches-indexers-and-trackers).
​​

## Weird UI Issues

​​

- If you experience any weird UI issues like the Library page not listing anything or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage] wiki article.

**Article Needed**
​​

## Web Interface Only Loads at localhost on Windows

​​\* If you can only reach your web interface at <http://localhost:8989/> ​​or <http://127.0.0.1:8989>, you need to run Sonarr as administrator at ​​least once, maybe even always.
​​

## Permissions

​​\* Sonarr will need to move files away from where the downloader puts ​​them into the final location, so this means that Sonarr will need to ​​read/write to both the source and the destination directory and files.
​​
​​ - On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to `775` and files to `664` both in your downloader and Sonarr. In umask notation, that would be `002`.
​​

## System & Logs loads forever

​​It\'s the easy-privacy blocklist. They basically block any url with ​​/api/log? in it. Look over the list and tell me if you think that ​​blocking all the urls in that list is a sensible idea, there are dozens ​​of urls in there that potentially break sites. You selected that in your ​​adblocker. Easy solution is to whitelist the domain Sonarr is running ​​on. But I still recommend checking the list.
​​

## Finding Cookies

​​Some sites cannot be logged into automatically and require you to login ​​manually then give the cookies to Sonarr to work. This page describes ​​how you do that.
​​
​​ - Chrome ![Chrome cookies](chrome_cookies.png "fig:Chrome cookies"){width="750"}
​​ - Firefox ![Firefox cookies](Firefox_cookies.png "fig:Firefox cookies"){width="750"}
​​

## Unpack Torrents

​​Most torrent clients doesn't come with the automatic handling of ​​compressed archives like their usenet counterparts. We recommend ​​[unpackerr](https://github.com/davidnewhall/unpackerr).
​​

## uTorrent is no longer working

- Ensure the Web UI is enabled

- Ensure that the Alt Listening Port (Advanced -> Web UI) is not the same as the Listening Port (Connections)

- We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

## Does Sonarr require a SABnzbd post-processing script to import downloaded episodes?

​​No. Sonarr will talk to your download client to determine where the ​​files have been downloaded and will import them automatically. If Sonarr ​​and your download client are on different machines you will need to use ​​Remote Path Mapping to link the remote path to a local one so Sonarr ​​knows where to find the files.
​​

## I got a pop-up that said config.xml was corrupt, what now?

​​Sonarr was unable to read your config file on start-up as it became ​​corrupted somehow. In order to get Sonarr back online, you will need to ​​delete `.xml` in your [\| AppData ​​Folder](Sonarr_Appdata_Directory "wikilink"), once deleted start Sonarr ​​and it will start on the default port (8989), you should now ​​re-configure any settings you configured on the General Settings page.
​​

## Invalid Certificate and other HTTPS or SSL issues

​​Your download client stopped working and you\'re getting an error like ​​\`Localhost is an invalid certificate\`?
​​
​​Sonarr now validates SSL certificates. If there is no SSL certificate ​​set in the download client, or you\'re using a self-signed https ​​certificate without the CA certificate added to your local certificate ​​store, then Sonarr will refuse to connect. Free properly signed ​​certificates are available from [let\'s ​​encrypt](https://letsencrypt.org/).
​​
​​If your download client and Sonarr are on the same machine there is no ​​reason to use HTTPS, so the easiest solution is to disable SSL for the ​​connection. Most would agree it\'s not required on a local network ​​either. It is possible to disable certificate validation in advanced ​​settings if you want to keep an insecure SSL setup.
​​

## VPNs, Jackett, and the \* ARRs

​​Unless you\'re in a repressive country like China, Australia or South ​​Africa, your torrent client is typically the only thing that needs to be ​​behind a VPN. Because the VPN endpoint is shared by many users, you can ​​and will experience rate limiting, DDOS protection, and ip bans from ​​various services each software uses.
​​
​​In other words, putting the \* Arrs (Lidarr, Radarr, Readarr, and ​​Sonarr) behind a VPN can and will make the applications unusable in some ​​cases due to the services not being accessible. **To be clear it is not ​​a matter if VPNs will cause issues with the \* Arrs, but when: image ​​providers will block you and cloudflare is in front of most of arr ​​servers (updates, metadata, etc.) and liable to block you too**
​​
​​In addition, some private trackers \* ban\* for browsing from a VPN, ​​which is how Jackett works. In some cases (i.e. certain UK ISPs) it may ​​be needed to use a VPN for public trackers, in which case you should ​​then be putting only Jackett behind the VPN. However, you should not do ​​that if you have private trackers without checking their rules first. ​​**Many private trackers will ban you for using or accessing them (i.e. ​​using Jackett) via a VPN.**
​​

## Jackett\'s /all Endpoint

​​The Jackett `/all` endpoint is convenient, but that is its only benefit. ​​Everything else is potential problems, so adding each tracker ​​individually is recommended.
​​
​​**May 2021 Update: It is likely Sonarr support will be phased out for ​​the jackett \`/all\` endpoint in the future due to the fact it only ​​causes issues.**
​​
​​[Even Jackett says it should be avoided and should not be ​​used.](https://github.com/Jackett/Jackett#aggregate-indexers)
​​
​​Using the all endpoint has no advantages (besides reduced management ​​overhead), only disadvantages:
​​
​​ - you lose control over indexer specific settings (categories, search modes, etc.)
​​ - mixing search modes (IMDB, query, etc.) might cause low-quality results
​​ - indexer specific categories (\>= 100000) can\'t be used.
​​ - slow indexers will slow down the overall result
​​ - total results are limited to 1000
​​
​​Adding each indexer separately It allows for fine tuning of categories ​​on a per indexer basis, which can be a problem with the `/all` end point ​​if using the wrong category causes errors on some trackers. In Sonarr, ​​each indexer is limited to 1000 results if pagination is supported or ​​100 if not, which means as you add more and more trackers to Jackett, ​​you're more and more likely to clip results. Finally, if*one* of the ​​trackers in `/all` returns an error, Sonarr will disable it and now you ​​don't get any results.
​​

## Why are there two files? \| Why is there a file left in downloads?

​​This is expected. This is how the Torrent Process works with Sonarr.
​​
​​1.  Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: movies, tv, series, music, ect.
​​2.  Sonarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client\'s API.
​​3.  Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Sonarr under the specific download client). When files are imported to your media folder Sonarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.  - Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Sonarr will fall back and copy the file.
​​4.  If the \"Completed Download Handling - Remove\" option is enabled in Sonarr\'s settings, Sonarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.
​​
