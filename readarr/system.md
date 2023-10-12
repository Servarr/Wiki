---
title: Readarr System
description: 
published: true
date: 2023-10-12T15:55:28.302Z
tags: readarr, needs-love, system
editor: markdown
dateCreated: 2021-06-20T19:54:43.262Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Status](#status)
  - [Health](#health)
    - [System Warnings](#system-warnings)
      - [Branch is not a valid release branch](#branch-is-not-a-valid-release-branch)
      - [Currently installed SQLite version is not supported](#currently-installed-sqlite-version-is-not-supported)
      - [New update is available](#new-update-is-available)
      - [Cannot install update because startup folder is not writable by the user](#cannot-install-update-because-startup-folder-is-not-writable-by-the-user)
      - [Updating will not be possible to prevent deleting AppData on Update](#updating-will-not-be-possible-to-prevent-deleting-appdata-on-update)
      - [Branch is for a previous version](#branch-is-for-a-previous-version)
      - [Could not connect to signalR](#could-not-connect-to-signalr)
        - [Nginx](#nginx)
      - [Failed to resolve the IP Address for the Configured Proxy Host](#failed-to-resolve-the-ip-address-for-the-configured-proxy-host)
      - [Proxy Failed Test](#proxy-failed-test)
      - [System Time is off by more than 1 day](#system-time-is-off-by-more-than-1-day)
    - [Download Clients](#download-clients)
      - [No download client is available](#no-download-client-is-available)
      - [Unable to communicate with download client](#unable-to-communicate-with-download-client)
      - [Download clients are unavailable due to failure](#download-clients-are-unavailable-due-to-failure)
      - [Enable Completed Download Handling](#enable-completed-download-handling)
      - [Docker bad remote path mapping](#docker-bad-remote-path-mapping)
      - [Downloading into Root Folder](#downloading-into-root-folder)
      - [Bad Download Client Settings](#bad-download-client-settings)
      - [Bad Remote Path Mapping](#bad-remote-path-mapping)
      - [Permissions Error](#permissions-error)
      - [Author Mount is Read Only](#author-mount-is-read-only)
      - [Remote File was removed part way through processing](#remote-file-was-removed-part-way-through-processing)
      - [Remote Path is Used and Import Failed](#remote-path-is-used-and-import-failed)
    - [Completed/Failed Download Handling](#completedfailed-download-handling)
      - [Completed Download Handling is disabled](#completed-download-handling-is-disabled)
      - [Download Client Removes Completed Downloads](#download-client-removes-completed-downloads)
    - [Indexers](#indexers)
      - [No indexers available with automatic search enabled, Readarr will not provide any automatic search results](#no-indexers-available-with-automatic-search-enabled-readarr-will-not-provide-any-automatic-search-results)
      - [No indexers available with RSS sync enabled, Readarr will not grab new releases automatically](#no-indexers-available-with-rss-sync-enabled-readarr-will-not-grab-new-releases-automatically)
      - [No indexers are enabled](#no-indexers-are-enabled)
    - [Enabled indexers do not support searching](#enabled-indexers-do-not-support-searching)
      - [No indexers available with Interactive Search Enabled](#no-indexers-available-with-interactive-search-enabled)
      - [Indexers are unavailable due to failures](#indexers-are-unavailable-due-to-failures)
      - [Jackett All Endpoint Used](#jackett-all-endpoint-used)
        - [Solutions](#solutions)
    - [Book Folders](#book-folders)
      - [Missing Root Folder](#missing-root-folder)
    - [Import Lists](#import-lists)
      - [Import Lists are unavailable due to failures](#import-lists-are-unavailable-due-to-failures)
  - [Disk Space](#disk-space)
  - [About](#about)
  - [More Info](#more-info)
- [Tasks](#tasks)
  - [Scheduled](#scheduled)
  - [Queue](#queue)
- [Backup](#backup)
- [Updates](#updates)
- [Events](#events)
- [Log Files](#log-files)

# Status

## Health

- This page contains a list of health checks errors. These health checks are periodically performed performed by Readarr and on certain events. The resulting warnings and errors are listed here to give advice on how to resolve them.

### System Warnings

#### Branch is not a valid release branch

- The branch you have set is not a valid release branch. You will not receive updates. Please change to one of the [current release branches](/readarr/faq#how-do-i-update-readarr)

#### Currently installed SQLite version is not supported

- Readarr stores its data in an SQLite database. The SQLite3 library installed on your system is too old. Readarr requires at least version 3.9.0. Note that Readarr uses `libSQLite3.so` which may or may not be contained in a SQLite3 upgrade package.

> Note that Readarr uses `libSQLite3.so` which may or may not be contained in a SQLite3 upgrade package.
{.is-info}

#### New update is available

Rejoice, the developers have released a new update. This generally means awesome new features and squashed piles of bugs (right?). Apparently you don’t have Auto-Updating enabled, so you’ll have to figure out how to update on your platform. Pressing the Install button on the System => Updates page is probably a good starting point.

> This warning will not appear if your current version is less than 14 days old
{.is-info}

#### Cannot install update because startup folder is not writable by the user

- This means Readarr will be unable to update itself. You’ll have to update Readarr manually or set the permissions on Readarr’s Startup directory (the installation directory) to allow Readarr to update itself.

#### Updating will not be possible to prevent deleting AppData on Update

- Readarr detected that AppData folder for your Operating System is located inside the directory that contains the Readarr binaries. Normally it would be C:\ProgramData for Windows and, ~/.config for linux.

- Please look at System => Info to see the current AppData & Startup directories.
- This means Readarr will be unable to update itself without risking data-loss.
- If you’re on linux, you’ll probably have to change the home directory for the user that is running Readarr and copy the current contents of the ~/.config/Readarr directory to preserve your database.

#### Branch is for a previous version

- The update branch setup in Settings/General is for a previous version of Readarr, therefore the instance will not see correct update information in the System/Updates feed and may not receive new updates when released.

#### Could not connect to signalR

- signalR drives the dynamic UI updates, so if your browser cannot connect to signalR on your server you won’t see any real time updates in the UI.

- The most common occurrence of this is use of a reverse proxy or cloudflare
- Cloudflare needs websockets enabled.

##### Nginx

- Nginx requires the following addition to the location block for the app:

```none
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;
```

> Make sure you do not include proxy_set_header Connection "Upgrade"; as suggested by the nginx documentation. THIS WILL NOT WORK
> See <https://github.com/aspnet/AspNetCore/issues/17081>
{.is-warning}

For Apache2 reverse proxy, you need to enable the following modules: proxy, proxy_http, and proxy_wstunnel. Then, add this websocket tunnel directive to your vhost configuration:

```none
RewriteEngine On
RewriteCond %{HTTP:Upgrade} =websocket [NC]
RewriteRule /(.*) ws://127.0.0.1:8787/$1 [P,L]
```

For Caddy (V1) use this:
Note: you will also need to add the websocket directive to your readarr configuration

```none
 proxy /readarr 127.0.0.1:8787 {
     websocket
     transparent
 }
```

#### Failed to resolve the IP Address for the Configured Proxy Host

- Review your proxy settings and ensure they are accurate
- Ensure your proxy is up, running, and accessible

#### Proxy Failed Test

- Your configured proxy failed to test successfully, review the HTTP error provided and/or check logs for more details.

#### System Time is off by more than 1 day

- System time is off by more than 1 day. Scheduled tasks may not run correctly until the time is corrected
- Review your system time and ensure it is synced to an authoritative time server and accurate

### Download Clients

#### No download client is available

- A properly configured and enabled download client is required for Readarr to be able to download media. Since Readarr supports different download clients, you should determine which best matches your requirements. If you already have a download client installed, you should configure Readarr to use it and create a category. See Settings => Download Client.

#### Unable to communicate with download client

- Readarr was unable to communicate with the configured download client. Please verify if the download client is operational and double check the url. This could also indicate an authentication error.
- This is typically due to improperly configured download client. Things you can typically check:
- Your download clients IP Address if its on the same bare metal machine this is typically 127.0.0.1
- The Port number of that your download client is using these are filled out with the default port number but if you've changed it you will need to have the same one entered into Readarr.
- Ensure SSL encryption is not turned on if you're using both your Readarr instance and your download client on a local network. See the SSL FAQ entry for more information.

#### Download clients are unavailable due to failure

{#download-clients-are-unavailable-due-to-failures}

- One or more of your download clients is not responding to requests made by Readarr. Therefore Readarr has decided to temporarily stop querying the download client on it’s normal 1 minute cycle, which is normally used to track active downloads and import finished ones. However, Readarr will continue to attempt to send downloads to the client, but will in all likeliness fail.
- You should inspect System=>Logs to see what the reason is for the failures.
- If you no longer use this download client, disable it in Readarr to prevent the errors.

#### Enable Completed Download Handling

- Readarr requires Completed Download Handling to be able to import files that were downloaded by the download client. It is recommended to enable Completed Download Handling.
- (Completed Download Handling is enabled by default for new users.)

#### Docker bad remote path mapping

- This error is typically associated with bad docker paths within either your download client or Readarr

- An example of this would be:
  - Download client: Download Path: /mnt/user/downloads:/downloads
  - Readarr: Download Path: /mnt/user/downloads:/data
- Within this example the download client places its downloads into /downloads and therefore tells Readarr when its complete that the finished book is in /downloads. Readarr then comes along and says "Okay, cool, let me check in /downloads" Well, inside Readarr you did not allocate a /downloads path you allocated a /data path so it throws this error.
- The easiest fix for this is CONSISTENCY if you use one scheme in your download client, use it across the board.

- Team Readarr is a big fan of simply using /data.
  - Download client: /mnt/user/data/downloads:/data/downloads
  - Readarr: /mnt/user/data:/data

- Now within the download client you can specify where in /data you'd like to place your downloads, now this varies depending on the client but you should be able to tell it "Yeah download client place my files into." /data/torrents (or usenet)/books and since you used /data in Readarr when the download client tells Readarr it's done Readarr will come along and say "Sweet, I have a /data and I also can see /torrents (or usenet)/books all is right in the world."
- There are many great write ups: our wiki [Docker Guide](/docker-guide) and TRaSH's [Hardlinks and Instant Moves (Atomic-Moves)](https://trash-guides.info/hardlinks/). Now these guides place heavy emphasis on Hardlinks and Atomic moves, but the general concept of containers and how path mapping works is the core of these discussions.

- If you're crossing operating systems or native and docker then you need a remote path map. See [TRaSH's Remote Path Guide for Radarr but the concept is the same for all \*Arrs](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/) for more information.

- If you are getting this error with Calibre then Redarr is unable to access Calibre's Library.  The resolution is the same - correct the inconsistent mounts for your containers.  Alternatively, create a remote path mapping to map the Calibre Library path to the Readarr accessible path.  A remote path map is only ever needed if crossing operating systems or servers.  If everything is in Docker it is preferred to correct your mounts instead.

#### Downloading into Root Folder

{#downloads-in-root-folder}

- Within the application, a root folder is defined as the configured media library folder. This is not the root folder of a mount. Your download client has an incomplete or complete (or is moving completed downloads) into your root (library) folder.
- This frequently causes issues - including data loss - and should not be done. To fix this change your download client so it is not placing downloads within your root folder. Note that 'placing' also includes if your download client category is set to your root folder or if NZBGet/SABnzbd have sort enabled and are sorting to your root folder.
- Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, should not be the same folder you have configured as your root/library/final media destination folder in the *arr application.
- Configured Root Folders (aka Library folders) can be found in [Settings => Media Management => Root Folders](/readarr/settings/#root-folders)
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It is suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.
- Review our [Docker Guide](/docker-guide) and TRaSH's [Hardlinks and Instant Moves (Atomic-Moves) Guide](https://trash-guides.info/hardlinks/) for more information on the correct and optimal path setup. Note that the concepts apply for docker and non-docker

> Your download folder where your download client places the downloads and your root/library folder MUST be separate. \*Arr will import the file(s) from your download client's folder into your library. The download client should not move anything or download anything to your library.
{.is-warning}

#### Bad Download Client Settings

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from windows to linux or linux to windows without a remote path map.

#### Bad Remote Path Mapping

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from windows to linux or linux to windows without a remote path map. See [TRaSH's Remote Path Guide](https://trash-guides.info/Readarr/Readarr-remote-path-mapping/) for more information.

#### Permissions Error

- Readarr or the user readarr is running as cannot access the location your download client is downloading files to. This is typically a permission issue.

#### Author Mount is Read Only

{#author-mount-ro}

- Mount containing a author path is mounted read-only. Check your mount settings and ownership/permissions.

#### Remote File was removed part way through processing

- A file accessible via a remote path map appears to have been removed prior to processing completing.

#### Remote Path is Used and Import Failed

- Check your logs for more info; Refer to our Troubleshooting Guides

### Completed/Failed Download Handling

#### Completed Download Handling is disabled

- (This warning is only generated for existing users before when the Completed Download Handling feature was implemented. This feature is disabled by default to ensure the system continued to operate as expected for current configurations.)
- It’s recommended to use Completed Download Handling since it provides better compatibility for the unpacking and post-processing logic of various download clients. With it, Readarr will only import a download once the download client reports it as ready.
- If you wish to enable Completed Download Handling you should verify the following: * Warning: Completed Download Handling only works properly if the download client and Readarr are on the same machine since it gets the path to be imported directly from the download client otherwise a remote map is needed.

#### Download Client Removes Completed Downloads

{#download-client-removes-completed-downloads}

- It's required that your download client retain its history of completed downloads until Readarr has imported them. If history retention is disabled then \*Arr may not see the completed download before it is removed from the download client. Your download client should be set to keep (usenet) and pause not remove (torrents) downloads after completion: **either indefinitely or for at least 14 days**.
  - Sabnzbd: Switches => Post Processing => Keep Jobs **must** be set to 14 days or greater OR be set to Keep All History
- Removing completed downloads from your client can be managed by Readarr and enabled via the download client settings in \*Arr. Thus \*Arr can ensure that your download client history is cleaned up.

### Indexers

#### No indexers available with automatic search enabled, Readarr will not provide any automatic search results

- Simply put you do not have any of your indexers set to allow automatic searches
- Go into Settings => Indexers, select an indexer you'd like to allow Automatic Searches and then click save.

#### No indexers available with RSS sync enabled, Readarr will not grab new releases automatically

- So Readarr uses the RSS feed to pick up new releases as they come along. More info on that here
- To correct this issue go to Settings => Indexers, select an indexer you have and enable RSS Sync

#### No indexers are enabled

- Readarr requires indexers to be able to discover new releases. Please read the wiki on instructions how to add indexers.

### Enabled indexers do not support searching

- None of the indexers you have enabled support searching. This means Readarr will only be able to find new releases via the RSS feeds. But searching for books (either Automatic Search or Manual Search) will never return any results. Obviously, the only way to remedy it is to add another indexer.

#### No indexers available with Interactive Search Enabled

- None of the indexers you have enabled support interactive searching. This means the application will only be able to find new releases via the RSS feeds or an automatic search.

#### Indexers are unavailable due to failures

- Errors occurs while Readarr tried to use one of your indexers. To limit retries, Readarr will not use the indexer for an increasing amount of time (up to 24h).
- This mechanism is triggered if Readarr was unable to get a response from the indexer (could be caused DNS, proxy/vpn connection, authentication, or an indexer issue), or unable to fetch the nzb/torrent file from the indexer. Please inspect the logs to determine what kind of error causes the problem.
- You can prevent the warning by disabling the affected indexer.
- Run the Test on the indexer to force Readarr to recheck the indexer, please note that the Health Check warning will not always disappear immediately.

#### Jackett All Endpoint Used

- The Jackett /all endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is now required.
- [Even Jackett's Devs says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)
- Using the /all endpoint has no advantages, only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (\>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000
  - if one of the trackers in /all returns an error, \*Arr will disable it and now you do not get any results.

##### Solutions

- Add each tracker in Jackett manually as an indexer in \*Arr
- Check out [Prowlarr](/prowlarr) which can sync indexers to \*Arr and from the Lidarr/Radarr/Readarr development team.
- Check out [NZBHydra2](https://github.com/theotherp/nzbhydra2) which can sync indexers to \*Arr. But do not use their single aggregate endpoint and use `multi` if sync will be used.

### Book Folders

#### Missing Root Folder

- This error is typically identified if a Author is looking for a root folder but that root folder is no longer available.
- This error may also be if a list is still pointed at a root folder but that root folder is no longer available.
- If you would like to remove this warning simply find the album that is still using the old root folder and edit it to the correct root folder.

- Easiest way to find the problem author is to:

  - Go to the Author (Library) Tab
  - Create a custom filter with the old root folder path
  - Select mass edit on the top bar and from the Root Paths drop down select the new root path that you want these author to be moved to.
  - Next you will receive a pop-up that states Would you like to move the Author folders to 'root path' ? This will also state This will also rename the Author folder per the Author folder format in settings. Simply select No if the you do not want Lidarr to move your files
  - Run the Check Health Task in System => Tasks

### Import Lists

#### Import Lists are unavailable due to failures

- Typically this simply means that Readarr is no longer able to communicate via API or via logging in to your chosen list provider. Your best bet if the problem persists is to contact them in order to rule them out, as their systems maybe overloaded from time to time.

## Disk Space

- This section will show you available disk space
- In docker this can be tricky as it will typically show you the available space within your Docker image

## About

- This will tell you about your current install of Readarr

## More Info

- Home Page: Readarr's home page
- Wiki: You're here already
- Reddit: r/readarr
- Discord: Join our discord
- Donations: If you're feeling generous and would like to donate click here
- Donations to Sonarr: If you're feeling generous and would like to donate to the project that started it all click here
- Source: GitHub
- Feature Requests: Got a great idea drop it here

# Tasks

## Scheduled

- This section lists all scheduled tasks that Readarr runs

- Application Check Update - This will run every on the displayed schedule in the UI, checking to see if Readarr is on the most current version then triggering the update script to update Readarr. Settings=> Update

> Note: If on Docker this will not update your container as a new image will need to be downloaded.
{.is-warning}

- Backup - This will run a backup of your Readarr's database on a set schedule more details on this can be found here. More information about backups can be found System => Backups.
- Check Health - Check Health will run on the displayed schedule in the UI checking the overall health of your Readarr. To see a list of possible health related issues see the Wiki Entry on Health Checks.
- Housekeeping - On the displayed schedule in the UI this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
- Import List Sync - On the displayed schedule in the UI this will run your Lists and import any possible new books. More info about lists can be found Settings => Lists.
- Messaging Cleanup - On the displayed schedule in the UI this cleans up those messages that appear in the bottom left corner of Readarr
- Refresh Author - This goes through and refreshes all authors in your Library.
- Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under Activity. Essentially pinging your download client to check for finished downloads.
- Rescan folders - This scans all book folders to see if a book exists or not, and updates the status of it appropriately.
- RSS Sync - This will run the RSS Sync. This can be changed in settings => options. More information on the RSS function can be found on our FAQ
  
> All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.
{.is-info}

## Queue

The queue will show you running and upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

# Backup

> If you're looking for how to back/restore your Readarr instance click [here](/readarr/faq).
{.is-info}

- Within the Backup section you will be presented with previous backups (unless you have a fresh install that hasn't made any backups).
  
- Backup Now - This option will trigger a manual backup of your Readarr's database
- Restore Backup - This will open a new screen to restore from a previous backup
  - By selecting Choose File this will prompt your browser to open a dialog box to restore from a Readarr Zip backup
  
- If you have any previous backups and would like to download them from Readarr to be placed in a non standard location you simply can select one of these files to download them
- Off to the right of each of the previous download you have two options.
  - Restore (Clock Icon) - To restore from a previous backup - This will open a new window to confirm you want to restore from this backup
  - Delete (Trashcan) - To delete a previous backup

# Updates

- The update screen will show the past 5 updates that have been made as well as the current version you are on.
- This page will also display the update notes from the Developers telling you what has been fixed or added to Readarr (Rejoice!)
  
> A Maintenance Release contains bug fixes and other various improvements. Take a look at the commit history for specifics.
{.is-info}

# Events

- The events tab will show you what has been happening within your Readarr. This can be used to diagnose some light issues. However, this does not replace Trace Logs discussed in Logging.

> Events are the equivalent of INFO Logs. {.is-info}

- Components - This column will tell you what component within Readarr has been triggered
- Message - This column will tell you what message as been sent from the component from the previous column.
- Gear Icon - This option will allow you to change how many Components/Messages are displayed per page (Default is 50)
- Options at the top of the page
  - Refresh - This option will refresh the current page, pulling a new events log
  - Clear - This will clear the current events log allowing you to start from fresh

# Log Files

- This page will allow you to download and see what current log files are available for Readarr

- On the top row there are several options to allow you to control your log files.

- The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
  - Log Files - The bread and butter of any support issue more on log files can be found here.
  - Updater Log Files - This will show the log files associated with Readarr's updater script

> If you're on docker this will be empty as you should be updating by downloading a new docker image
{.is-info}

- Refresh - This will refresh the current page and display any newly created logs
- Delete - This will clear all logs allowing you to start from fresh
- File Name - This will display the file name associated with the log
- Last Written - This is the local time that this particular log file was written to.
  - Readarr uses rolling log files limited to 1MB each. The current log file is always readarr.txt, for the the other files readarr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains `fatal`, `error`, `warn`, and `info` entries.
  - When Debug log level is enabled, additional readarr.debug.txt rolling log files will be present, up to 51 files. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a ~40h period.
  - When Trace log level is enabled, additional readarr.trace.txt rolling log files will be present, up to 51 files. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.
