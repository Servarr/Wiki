---
title: Whisparr System
description:
published: true
date: 2022-03-19T00:33:35.557Z
tags: whisparr, needs-love
editor: markdown
dateCreated: 2021-05-25T02:28:35.194Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Status](#status)
  - [Health](#health)
    - [System Warnings](#system-warnings)
      - [Branch is not a valid release branch](#branch-is-not-a-valid-release-branch)
      - [Update to .NET version](#update-to-net-version)
        - [Fixing Docker installs](#fixing-docker-installs)
        - [Fixing FreeBSD installs](#fixing-freebsd-installs)
        - [Fixing Standalone installs](#fixing-standalone-installs)
      - [Currently installed mono version is old and unsupported](#currently-installed-mono-version-is-old-and-unsupported)
      - [Currently installed SQLite version is not supported](#currently-installed-sqlite-version-is-not-supported)
      - [Database Failed Integrity Check](#database-failed-integrity-check)
      - [New update is available](#new-update-is-available)
      - [Cannot install update because startup folder is not writable by the user](#cannot-install-update-because-startup-folder-is-not-writable-by-the-user)
      - [Updating will not be possible to prevent deleting AppData on Update](#updating-will-not-be-possible-to-prevent-deleting-appdata-on-update)
      - [Branch is for a previous version](#branch-is-for-a-previous-version)
      - [Could not connect to signalR](#could-not-connect-to-signalr)
        - [Nginx](#nginx)
        - [Apache2](#apache2)
        - [Caddy](#caddy)
      - [Failed to resolve the IP Address for the Configured Proxy Host](#failed-to-resolve-the-ip-address-for-the-configured-proxy-host)
      - [Proxy Failed Test](#proxy-failed-test)
      - [System Time is off by more than 1 day](#system-time-is-off-by-more-than-1-day)
      - [MediaInfo Library Could not be Loaded](#mediainfo-library-could-not-be-loaded)
      - [PTP Indexer Settings Out of Date](#ptp-indexer-settings-out-of-date)
      - [Mono Legacy TLS enabled](#mono-legacy-tls-enabled)
      - [Mono and x86 builds are ending](#mono-and-x86-builds-are-ending)
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
      - [Remote File was removed part way through processing](#remote-file-was-removed-part-way-through-processing)
      - [Remote Path is Used and Import Failed](#remote-path-is-used-and-import-failed)
    - [Completed/Failed Download Handling](#completedfailed-download-handling)
      - [Completed Download Handling is disabled](#completed-download-handling-is-disabled)
    - [Indexers](#indexers)
      - [No indexers available with automatic search enabled, Whisparr will not provide any automatic search results](#no-indexers-available-with-automatic-search-enabled-whisparr-will-not-provide-any-automatic-search-results)
      - [No indexers available with RSS sync enabled, Whisparr will not grab new releases automatically](#no-indexers-available-with-rss-sync-enabled-whisparr-will-not-grab-new-releases-automatically)
      - [No indexers are enabled](#no-indexers-are-enabled)
    - [Enabled indexers do not support searching](#enabled-indexers-do-not-support-searching)
      - [No indexers available with Interactive Search Enabled](#no-indexers-available-with-interactive-search-enabled)
      - [Indexers are unavailable due to failures](#indexers-are-unavailable-due-to-failures)
      - [Jackett All Endpoint Used](#jackett-all-endpoint-used)
        - [Solutions](#solutions)
    - [Movie Folders](#movie-folders)
      - [Missing Root Folder](#missing-root-folder)
    - [Movies](#movies)
      - [Movie was removed from TMDb](#movie-was-removed-from-tmdb)
      - [Lists are unavailable due to failures](#lists-are-unavailable-due-to-failures)
    - [Notifications](#notifications)
    - [Discord as Slack Notification](#discord-as-slack-notification)
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

- This page contains a list of health checks errors. These health checks are periodically performed performed by Whisparr and on certain events. The resulting warnings and errors are listed here to give advice on how to resolve them.

### System Warnings

#### Branch is not a valid release branch

- The branch you have set is not a valid release branch. You will not receive updates. Please change to one of the [current release branches](/whisparr/faq#how-do-i-update-whisparr).

#### Update to .NET version

{#update-to-net-core-version}

- Newer versions of Whisparr are targeted for .NET6 or newer. We will no longer be providing legacy mono builds after version 3.2.2. You are running one of these legacy mono builds, but your platform supports .NET.

See the below entries for how to switch from unsupported, end-of-life mono versions to dotnet.

- [Fixing Docker installs](#fixing-docker-installs)
- [Fixing FreeBSD installs](#fixing-freebsd-installs)
- [Fixing Standalone installs](#fixing-standalone-installs)
{.links-list}

##### Fixing Docker installs

- Ensure your branch is correct for your provider and repull your container

##### Fixing FreeBSD installs

- Simply update the Whisparr Port with `pkg update && pkg upgrade`
- (Optional) Remove the mono package if you wish

##### Fixing Standalone installs

- Back-Up your existing configuration before the next step.
- This should only happen on Linux hosts. Do not install .NET runtime or SDK from Microsoft.
- To remedy, download the correct build for your architecture and replace your existing binaries (application)
- In short you will need to delete your existing binaries (contents or folder of /opt/Whisparr) and replace with the contents of the .tar.gz you just downloaded.

> DO NOT JUST EXTRACT THE DOWNLOAD OVER THE TOP OF YOUR EXISTING BINARIES.
> YOU MUST DELETE THE OLD ONES FIRST.
{.is-warning}

- The below is a community developed script to remove your mono installation and replace it with the .NET installation. Contributions and corrections are welcome.
- This assumes you are on the `master` Whisparr branch update the variable if needed
- This assumes that Whisparr runs as the user `whisparr` update the variables if needed
- This assumes Whisparr is installed at `/opt/Whisparr` update the variables if needed

```bash
#!/bin/bash
## User Variables
installdir="/opt/Whisparr"
APPUSER="whisparr"
branch="master"
## /User Variables
app="whisparr"
ARCH=$(dpkg --print-architecture)
# Stop \*arr
sudo systemctl stop $app
# get arch
dlbase="https://$app.servarr.com/v1/update/$branch/updatefile?os=linux&runtime=netcore"
case "$ARCH" in
"amd64") DLURL="${dlbase}&arch=x64" ;;
"armhf") DLURL="${dlbase}&arch=arm" ;;
"arm64") DLURL="${dlbase}&arch=arm64" ;;
*)
    echo_error "Arch not supported"
    exit 1
    ;;
esac
echo "Downloading..."
wget --content-disposition "$DLURL"
tar -xvzf ${app^}.*.tar.gz
echo "Installation files downloaded and extracted"
echo "Moving existing installation"
sudo mv "$installdir/" "$installdir.old/"
echo "Installing..."
sudo mv "${app^}" "$installdir"
sudo chown $APPUSER:$APPUSER -R $installdir
sudo sed -i "s|ExecStart=/usr/bin/mono --debug /opt/${app^}/${app^}.exe|ExecStart=/opt/${app^}/${app^}|g" /etc/systemd/system/$app.service
sudo sed -i "s|ExecStart=/usr/bin/mono /opt/${app^}/${app^}.exe|ExecStart=/opt/${app^}/${app^}|g" /etc/systemd/system/$app.service
sudo systemctl daemon-reload
echo "App Installed"
sudo rm -rf "$installdir.old/"
rm -rf "${app^}.*.tar.gz"
sudo systemctl start $app
```

#### Currently installed mono version is old and unsupported

- Whisparr is written in .NET and requires Mono to run on very old ARM processors. Mono 5.20 is the absolute minimum for Whisparr.
- The upgrade procedure for Mono varies per platform.

> Mono is no longer supported starting in Whisparr version 4.0
{.is-warning}

#### Currently installed SQLite version is not supported

- Whisparr stores its data in an SQLite database. The SQLite3 library installed on your system is too old. Whisparr requires at least version 3.9.0.

> Note that Whisparr uses `libSQLite3.so` which may or may not be contained in a SQLite3 upgrade package.
{.is-info}

#### Database Failed Integrity Check

- Your database(s) failed a [SQLite Pragma Integrity Check](https://www.sqlite.org/pragma.html#pragma_integrity_check) and have some corruption.
- If `Whisparr.db` is corrupt [please see this FAQ Entry](/whisparr/faq#i-am-getting-an-error-database-disk-image-is-malformed)
- If `logs.db` is corrupt: Stop Whisparr, delete `logs.db` and any `logs.wal` files.
- If both are corrupt, review the respective processes above.

#### New update is available

- Rejoice, the developers have released a new update. This generally means awesome new features and squashed piles of bugs (right?). Apparently you don’t have Auto-Updating enabled, so you’ll have to figure out how to update on your platform. Pressing the Install button on the System => Updates page is probably a good starting point.

> This warning will not appear if your current version is less than 14 days old
{.is-info}

#### Cannot install update because startup folder is not writable by the user

- This means Whisparr will be unable to update itself. You’ll have to update Whisparr manually or set the permissions on Whisparr’s Startup directory (the installation directory) to allow Whisparr to update itself.

#### Updating will not be possible to prevent deleting AppData on Update

- Whisparr detected that AppData folder for your Operating System is located inside the directory that contains the Whisparr binaries. Normally it would be C:\ProgramData for Windows and, ~/.config for linux.

- Please look at System => Info to see the current AppData & Startup directories.
- This means Whisparr will be unable to update itself without risking data-loss.
- If you’re on linux, you’ll probably have to change the home directory for the user that is running Whisparr and copy the current contents of the ~/.config/Whisparr directory to preserve your database.

#### Branch is for a previous version

- The update branch setup in Settings/General is for a previous version of Whisparr, therefore the instance will not see correct update information in the System/Updates feed and may not receive new updates when released.

#### Could not connect to signalR

- signalR drives the dynamic UI updates, so if your browser cannot connect to signalR on your server you won’t see any real time updates in the UI.
- The most common occurrence of this is use of a reverse proxy or cloudflare
- Cloudflare needs websockets enabled.

##### Nginx

- Nginx requires the following addition to the location block for the app:

```nginx
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;
```

> Make sure you do not include proxy_set_header Connection "Upgrade"; as suggested by the nginx documentation. THIS WILL NOT WORK
> See <https://github.com/aspnet/AspNetCore/issues/17081>
{.is-warning}

##### Apache2

For Apache2 reverse proxy, you need to enable the following modules: proxy, proxy_http, and proxy_wstunnel. Then, add this websocket tunnel directive to your vhost configuration:

```none
RewriteEngine On
RewriteCond %{HTTP:Upgrade} =websocket [NC]
RewriteRule /(.*) ws://127.0.0.1:6969/$1 [P,L]
```

If you have a reverse proxy under a subdirectory, the RewriteRule should include your basepath e.g.

```none
RewriteRule /whisparr/(.*) ws://127.0.0.1:6969/whisparr/$1 [P,L]
```

If Whisparr is not running on the same machine as your reverse proxy. Replace 127.0.0.1 with the appropriate IP address/DNS name of your Whisparr app.

##### Caddy

For Caddy (V1) use this:
Note: you will also need to add the websocket directive to your whisparr configuration

```none
 proxy /whisparr 127.0.0.1:6969 {
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

#### MediaInfo Library Could not be Loaded

- MediaInfo Library could not be loaded.

#### PTP Indexer Settings Out of Date

- The following PassThePopcorn indexers have deprecated settings and should be updated.

#### Mono Legacy TLS enabled

- Mono 4.x tls workaround still enabled, consider removing MONO_TLS_PROVIDER=legacy environment option

#### Mono and x86 builds are ending

- Mono and x86 builds will no longer be supported in the next build of the application. If you are receiving this error then you are running the mono version of the application or the x86 version. Unfortunately, due to increasing difficulty in development support for these legacy versions we will be discontinuing their support and thus releases for them going forward. Thus it is advised you upgrade to a supported Operating System that does not require neither x86 nor mono. You may also be able to explore using Docker for your needs.

### Download Clients

#### No download client is available

- A properly configured and enabled download client is required for Whisparr to be able to download media. Since Whisparr supports different download clients, you should determine which best matches your requirements. If you already have a download client installed, you should configure Whisparr to use it and create a category. See Settings => Download Client.

#### Unable to communicate with download client

- Whisparr was unable to communicate with the configured download client. Please verify if the download client is operational and double check the url. This could also indicate an authentication error.
- This is typically due to improperly configured download client. Things you can typically check:
  - Your download clients IP Address if its on the same bare metal machine this is typically 127.0.0.1
  - The Port number of that your download client is using these are filled out with the default port number but if you've changed it you will need to have the same one entered into Whisparr.
  - Ensure SSL encryption is not turned on if you're using both your Whisparr instance and your download client on a local network. See the SSL FAQ entry for more information.

#### Download clients are unavailable due to failure

- One or more of your download clients is not responding to requests made by Whisparr. Therefore Whisparr has decided to temporarily stop querying the download client on it’s normal 1 minute cycle, which is normally used to track active downloads and import finished ones. However, Whisparr will continue to attempt to send downloads to the client, but will in all likeliness fail.
- You should inspect System=>Logs to see what the reason is for the failures.
- If you no longer use this download client, disable it in Whisparr to prevent the errors.

#### Enable Completed Download Handling

- Whisparr requires Completed Download Handling to be able to import files that were downloaded by the download client. It is recommended to enable Completed Download Handling. (Completed Download Handling is enabled by default for new users.)

#### Docker bad remote path mapping

- This error is typically associated with bad docker paths within either your download client or Whisparr

- An example of this would be:
  - Download client: Download Path: /mnt/user/downloads:/downloads
  - Whisparr: Download Path: /mnt/user/downloads:/data
- Within this example the download client places its downloads into /downloads and therefore tells Whisparr when its complete that the finished movie is in /downloads. Whisparr then comes along and says "Okay, cool, let me check in /downloads" Well, inside Whisparr you did not allocate a /downloads path you allocated a /data path so it throws this error.
- The easiest fix for this is CONSISTENCY if you use one scheme in your download client, use it across the board.

- Team Whisparr is a big fan of simply using /data.
  - Download client: /mnt/user/data/downloads:/data/downloads
  - Whisparr: /mnt/user/data:/data

- Now within the download client you can specify where in /data you'd like to place your downloads, now this varies depending on the client but you should be able to tell it "Yeah download client place my files into." /data/torrents (or usenet)/movies and since you used /data in Whisparr when the download client tells Whisparr it's done Whisparr will come along and say "Sweet, I have a /data and I also can see /torrents (or usenet)/movies all is right in the world."
- There are many great write ups: our wiki [Docker Guide](/docker-guide) and TRaSH's [Hardlinks and Instant Moves (Atomic-Moves)](https://trash-guides.info/hardlinks/). Now these guides place heavy emphasis on Hardlinks and Atomic moves, but the general concept of containers and how path mapping works is the core of these discussions.

- See [TRaSH's Remote Path Guide](https://trash-guides.info/Whisparr/Whisparr-remote-path-mapping/) for more information.

#### Downloading into Root Folder

{#downloads-in-root-folder}

- Within the application, a root folder is defined as the configured media library folder. This is not the root folder of a mounted drive. You're downloading directly into your root (library) folder. This frequently causes issues and is not advised. To fix this change your download client so it is not placing downloads within your root folder. Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, should not be the same folder you have configured as your root/library/final media destination folder in the *arr application.
- Configured Root Folders (aka Library folders) can be found in [Settings => Media Management => Root Folders](/whisparr/settings/#root-folders)
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It is suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.

> Your download folder and your root/library folder MUST be separate
{.is-warning}

#### Bad Download Client Settings

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from windows to linux or linux to windows without a remote path map.

#### Bad Remote Path Mapping

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from windows to linux or linux to windows without a remote path map. See [TRaSH's Remote Path Guide](https://trash-guides.info/Whisparr/Whisparr-remote-path-mapping/) for more information.

#### Permissions Error

- Whisparr or the user whisparr is running as cannot access the location your download client is downloading files to. This is typically a permission issue.

#### Remote File was removed part way through processing

- A file accessible via a remote path map appears to have been removed prior to processing completing.

#### Remote Path is Used and Import Failed

- Check your logs for more info; Refer to our Troubleshooting Guides

### Completed/Failed Download Handling

#### Completed Download Handling is disabled

- (This warning is only generated for existing users before when the Completed Download Handling feature was implemented. This feature is disabled by default to ensure the system continued to operate as expected for current configurations.)
- It’s recommended to use Completed Download Handling since it provides better compatibility for the unpacking and post-processing logic of various download clients. With it, Whisparr will only import a download once the download client reports it as ready.
- If you wish to enable Completed Download Handling you should verify the following: * Warning: Completed Download Handling only works properly if the download client and Whisparr are on the same machine since it gets the path to be imported directly from the download client otherwise a remote map is needed.

### Indexers

#### No indexers available with automatic search enabled, Whisparr will not provide any automatic search results

- Simply put you do not have any of your indexers set to allow automatic searches
- Go into Settings => Indexers, select an indexer you'd like to allow Automatic Searches and then click save.

#### No indexers available with RSS sync enabled, Whisparr will not grab new releases automatically

- Whisparr uses the RSS feed to pick up new releases as they come along. More info on that here
- To correct this issue go to Settings => Indexers, select an indexer you have and enable RSS Sync

#### No indexers are enabled

- Whisparr requires indexers to be able to discover new releases. Please read the wiki on instructions how to add indexers.

### Enabled indexers do not support searching

- None of the indexers you have enabled support searching. This means Whisparr will only be able to find new releases via the RSS feeds. But searching for movies (either Automatic Search or Manual Search) will never return any results. Obviously, the only way to remedy it is to add another indexer.

#### No indexers available with Interactive Search Enabled

- None of the indexers you have enabled support interactive searching. This means the application will only be able to find new releases via the RSS feeds or an automatic search.

#### Indexers are unavailable due to failures

- Errors occurs while Whisparr tried to use one of your indexers. To limit retries, Whisparr will not use the indexer for an increasing amount of time (up to 24h).
- This mechanism is triggered if Whisparr was unable to get a response from the indexer (could be caused DNS, proxy/vpn connection, authentication, or an indexer issue), or unable to fetch the nzb/torrent file from the indexer. Please inspect the logs to determine what kind of error caused the problem.
- You can prevent the warning by disabling the affected indexer.
- Run the Test on the indexer to force Whisparr to recheck the indexer, please note that the Health Check warning will not always disappear immediately.

#### Jackett All Endpoint Used

- The Jackett /all endpoint is convenient, but that is its only benefit. Everything else is potential problems, so adding each tracker individually is now required.
- [Even Jackett's Devs says it should be avoided and should not be used.](https://github.com/Jackett/Jackett#aggregate-indexers)
- Using the /all endpoint has no advantages, only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - indexer specific categories (>= 100000) cannot be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000
  - if one of the trackers in /all returns an error, \*Arr will disable it and now you do not get any results.

##### Solutions

- Add each tracker in Jackett manually as an indexer in \*Arr
- Check out [Prowlarr](/prowlarr) which can sync indexers to \*Arr and from the Lidarr/Whisparr/Readarr development team.
- Check out [NZBHydra2](https://github.com/theotherp/nzbhydra2) which can sync indexers to \*Arr

### Movie Folders

#### Missing Root Folder

- This error is typically identified if a Movie is looking for a root folder but that root folder is no longer available.
- This error may also be if a list is still pointed at a root folder but that root folder is no longer available.
- If you would like to remove this warning simply find the Movie that is still using the old root folder and edit it to the correct root folder.

- Easiest way to find the problem movie is to:

  - Go to the Movies (Library) Tab
  - Create a custom filter with the old root folder path
  - Select mass edit on the top bar and from the Root Paths drop down select the new root path that you want these movie to be moved to.
  - Next you will receive a pop-up that states Would you like to move the Movie folders to 'root path' ? This will also state This will also rename the Movie folder per the Movie folder format in settings. Simply select No if the you do not want Lidarr to move your files
  - Run the Check Health Task in System => Tasks

### Movies

#### Movie was removed from TMDb

- The movie is linked to a TMDb Id that was deleted from TMDb, usually because it was a duplicate, wasn't a movie or changed ID for some other reason. Deleted movies will not receive any updates and should be corrected by the user to ensure continued functionality. Remove the movie from Whisparr without deleting the files, then try to re-add it. If it doesn't show up in a search, check Sonarr because it might be a TV miniseries like Stephen King's It.

- You can find and edit deleted movies by creating a custom filter using the following steps:

  1. Click Movies from the left menu
  1. Click the dropdown on Filter and select “Custom Filter”
  1. Enter a label, for example “Deleted Movies”
  1. Make the filter as follows: `Release Status` is `Deleted`
  1. Click save and select the newly created filter from the filter dropdown menu

#### Lists are unavailable due to failures

- Typically this simply means that Whisparr is no longer able to communicate via API or via logging in to your chosen list provider. Your best bet if the problem persists is to contact them in order to rule them out, as their systems maybe overloaded from time to time.

### Notifications

### Discord as Slack Notification

- You have Discord configured to use a Slack webhook. This is not advised and the native Discord functionality should be used instead. If you're receiving this that likely means you just configured this by following an outdated guide. Please advise the guide author to update their steps.

## Disk Space

- This section will show you available disk space
- In docker this can be tricky as it will typically show you the available space within your Docker image

## About

- This will tell you about your current install of Whisparr

## More Info

- Home Page: Whisparr's home page
- Wiki: You're here already
- Reddit: r/whisparr
- Discord: Join our discord
- Donations: If you're feeling generous and would like to donate click here
- Donations to Sonarr: If you're feeling generous and would like to donate to the project that started it all click here
- Source: GitHub
- Feature Requests: Got a great idea drop it here

# Tasks

## Scheduled

- This section lists all scheduled tasks that Whisparr runs

- Application Check Update - This will run every on the displayed schedule in the UI, checking to see if Whisparr is on the most current version then triggering the update script to update Whisparr. Settings=> Update

> Note: If on Docker this will not update your container as a new image will need to be downloaded.
{.is-warning}

- Backup - This will run a backup of your Whisparr's database on a set schedule more details on this can be found here. More information about backups can be found System => Backups.
- Check Health - Check Health will run on the displayed schedule in the UI checking the overall health of your Whisparr. To see a list of possible health related issues see the Wiki Entry on Health Checks.
- Clean Up Recycle Bin - The recycling bin will be cleared out on the displayed schedule in the UI. This will only be used if the recycling bin is set in File Management
- Housekeeping - On the displayed schedule in the UI this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
- Import List Sync - On the displayed schedule in the UI this will run your Lists and import any possible new movies. More info about lists can be found Settings => Lists.
- Messaging Cleanup - On the displayed schedule in the UI this cleans up those messages that appear in the bottom left corner of Whisparr
- Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under Activity. Essentially pinging your download client to check for finished downloads.
- Refresh Movie - This goes through and refreshes all the metadata for all monitored and unmonitored movies
- RSS Sync - This will run the RSS Sync. This can be changed in settings => options. More information on the RSS function can be found on our FAQ

> All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.
{.is-info}

## Queue

- The queue will show you running and upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

# Backup

> If you're looking for how to back/restore your Whisparr instance click [here](/whisparr/faq).
{.is-info}

- Within the Backup section you will be presented with previous backups (unless you have a fresh install that hasn't made any backups).

- Backup Now - This option will trigger a manual backup of your Whisparr's database
- Restore Backup - This will open a new screen to restore from a previous backup
  - By selecting Choose File this will prompt your browser to open a dialog box to restore from a Whisparr Zip backup

- If you have any previous backups and would like to download them from Whisparr to be placed in a non standard location you simply can select one of these files to download them
- Off to the right of each of the previous download you have two options.
  - Restore (Clock Icon) - To restore from a previous backup - This will open a new window to confirm you want to restore from this backup
  - Delete (Trashcan) - To delete a previous backup

# Updates

- The update screen will show the past 5 updates that have been made as well as the current version you are on.
- This page will also display the update notes from the Developers telling you what has been fixed or added to Whisparr (Rejoice!)

> A Maintenance Release contains bug fixes and other various improvements. Take a look at the commit history for specifics.
{.is-info}

# Events

- The events tab will show you what has been happening within your Whisparr. This can be used to diagnose some light issues. However, this does not replace Trace Logs discussed in Logging.

> Events are the equivalent of INFO Logs. {.is-info}

- Components - This column will tell you what component within Whisparr has been triggered
- Message - This column will tell you what message as been sent from the component from the previous column.
- Gear Icon - This option will allow you to change how many Components/Messages are displayed per page (Default is 50)
- Options at the top of the page
  - Refresh - This option will refresh the current page, pulling a new events log
  - Clear - This will clear the current events log allowing you to start from fresh

# Log Files

- This page will allow you to download and see what current log files are available for Whisparr

- On the top row there are several options to allow you to control your log files.

- The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
  - Log Files - The bread and butter of any support issue more on log files can be found here.
  - Updater Log Files - This will show the log files associated with Whisparr's updater script

> If you're on docker this will be empty as you should be updating by downloading a new docker image
{.is-info}

- Refresh - This will refresh the current page and display any newly created logs
- Delete - This will clear all logs allowing you to start from fresh
- File Name - This will display the file name associated with the log
- Last Written - This is the local time that this particular log file was written to.
  - Whisparr uses rolling log files limited to 1MB each. The current log file is always whisparr.txt, for the the other files whisparr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains `fatal`, `error`, `warn`, and `info` entries.
  - When Debug log level is enabled, additional whisparr.debug.txt rolling log files will be present, up to 51 files. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a ~40h period.
  - When Trace log level is enabled, additional whisparr.trace.txt rolling log files will be present, up to 51 files. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.
