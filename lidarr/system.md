---
title: Lidarr System
description: System information, logs, scheduled tasks, and status monitoring for Lidarr administration and troubleshooting
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, system, logs, administration, tasks, status
editor: markdown
dateCreated: 2021-06-14T21:36:28.225Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Status](#status)
  - [Health](#health)
    - [System Warnings](#system-warnings)
      - [Branch isn't a valid release branch](#branch-is-not-a-valid-release-branch)
      - [Update to .NET version](#update-to-net-version)
        - [Fixing Docker installs](#fixing-docker-installs)
        - [Fixing Standalone installs](#fixing-standalone-installs)
      - [Currently installed mono version is old and unsupported](#currently-installed-mono-version-is-old-and-unsupported)
      - [Currently installed SQLite version isn't supported](#currently-installed-sqlite-version-is-not-supported)
      - [New update is available](#new-update-is-available)
      - [Can't install update because startup folder is in an App Translocation folder (macOS)](#cannot-install-update-because-startup-folder-is-in-an-app-translocation-folder-macos)
      - [Can't install update because startup folder isn't writable by the user](#cannot-install-update-because-startup-folder-is-not-writable-by-the-user)
      - [Can't install update because UI folder isn't writable by the user](#cannot-install-update-because-ui-folder-is-not-writable-by-the-user)
      - [Updating won't be possible to prevent deleting AppData on Update](#updating-will-not-be-possible-to-prevent-deleting-appdata-on-update)
      - [Branch is for a previous version](#branch-is-for-a-previous-version)
      - [Couldn't connect to signalR](#could-not-connect-to-signalr)
        - [NGINX](#nginx)
        - [Apache](#apache)
        - [Caddy](#caddy)
      - [Failed to resolve the IP Address for the Configured Proxy Host](#failed-to-resolve-the-ip-address-for-the-configured-proxy-host)
      - [Proxy Failed Test](#proxy-failed-test)
      - [System Time is off by more than 1 day](#system-time-is-off-by-more-than-1-day)
      - [Mono Legacy TLS enabled](#mono-legacy-tls-enabled)
      - [Mono and x86 builds are ending](#mono-and-x86-builds-are-ending)
      - [FPcalc is missing](#fpcalc-is-missing)
      - [FPcalc needs updating](#fpcalc-needs-updating)
      - [API Key is too short](#api-key-is-too-short)
      - [Package Maintainer Message](#package-maintainer-message)
      - [Plugins failed to load](#plugins-failed-to-load)
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
      - [Download Folder Same as Library Folder](#download-folder-same-as-library-folder)
    - [Completed/Failed Download Handling](#completedfailed-download-handling)
      - [Completed Download Handling is disabled](#completed-download-handling-is-disabled)
      - [Download Client Removes Completed Downloads](#download-client-removes-completed-downloads)
    - [Indexers](#indexers)
      - [No indexers available with automatic search enabled, Lidarr won't provide any automatic search results](#no-indexers-available-with-automatic-search-enabled-lidarr-will-not-provide-any-automatic-search-results)
      - [No indexers available with RSS sync enabled, Lidarr won't grab new releases automatically](#no-indexers-available-with-rss-sync-enabled-lidarr-will-not-grab-new-releases-automatically)
      - [No indexers are enabled](#no-indexers-are-enabled)
    - [Enabled indexers don't support searching](#enabled-indexers-do-not-support-searching)
      - [No indexers Available with Interactive Search Enabled](#no-indexers-available-with-interactive-search-enabled)
      - [Indexers are unavailable due to failures](#indexers-are-unavailable-due-to-failures)
      - [Jackett All Endpoint Used](#jackett-all-endpoint-used)
        - [Solutions](#solutions)
      - [Invalid Indexer Download Client Setting](#invalid-indexer-download-client-setting)
      - [Redacted Configured as Gazelle Indexer](#redacted-configured-as-gazelle-indexer)
    - [Artist Folders](#artist-folders)
      - [Missing Root Folder](#missing-root-folder)
      - [Artist Mount is Read Only](#artist-mount-is-read-only)
      - [Artist Removed from MusicBrainz](#artist-removed-from-musicbrainz)
      - [Import List Missing Root Folder](#import-list-missing-root-folder)
      - [Lists are unavailable due to failures](#lists-are-unavailable-due-to-failures)
    - [Notifications](#notifications)
      - [Notifications are unavailable due to failures](#notifications-are-unavailable-due-to-failures)
    - [Recycling Bin](#recycling-bin)
      - [Cannot Write to Recycle Bin](#cannot-write-to-recycle-bin)
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

This page lists health check results. Lidarr runs these checks periodically and on certain events, and lists any warnings or errors here with advice on how to resolve them.

### System Warnings

#### Branch isn't a valid release branch

The branch you have set isn't a valid release branch. You won't receive updates. Please change to one of the [current release branches](/lidarr/faq#how-do-i-update-lidarr).

#### Update to .NET version

{#update-to-net-core-version}

- Newer versions of Lidarr target .NET6 or newer. Legacy mono builds end after the 1.0 release. You are running one of these legacy builds but your platform supports .NET.

##### Fixing Docker installs

- Re-pull your container

##### Fixing Standalone installs

- Back-Up your existing configuration before the next step.
- This should only happen on Linux hosts. Don't install .NET runtime or SDK from Microsoft.
- To remedy, download the correct build for your architecture and replace your existing binaries (application)
- In short you will need to delete your existing binaries (contents or folder of /opt/Lidarr) and replace with the contents of the .tar.gz you just downloaded.

> DON'T JUST EXTRACT THE DOWNLOAD OVER THE TOP OF YOUR EXISTING BINARIES.
> YOU MUST DELETE THE OLD ONES FIRST.
{.is-warning}

- The below is a community developed script to remove your mono installation and replace it with the .NET installation. Contributions and corrections are welcome.
- This assumes you are on the `master` Lidarr branch update the variable if needed
- This assumes that Lidarr runs as the user `lidarr` update the variables if needed
- This assumes you installed Lidarr at `/opt/Lidarr`; update the variables if needed

```bash
#!/bin/bash
## User Variables
installdir="/opt/Lidarr"
APPUSER="lidarr"
branch="master"
## /User Variables
app="lidarr"
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

- Lidarr uses .NET and requires Mono to run on old ARM processors. Please note that Mono builds are no longer supported after v1.0
- Lidarr requires at least Mono 5.20.
- The upgrade procedure for Mono varies per platform.

#### Currently installed SQLite version isn't supported

- Lidarr stores its data in an SQLite database. The SQLite3 library installed on your system is too old. Lidarr requires at least version 3.9.0. Note that Lidarr uses `libSQLite3.so`, which may not come with a SQLite3 upgrade package.

#### New update is available

- A new version of Lidarr is available. If autoupdating is enabled, Lidarr will install it automatically. Otherwise, go to `System => Updates` and press Install.

> This warning won't appear if your current version is less than 14 days old.
{.is-info}

#### Can’t install update because startup folder is in an App Translocation folder (macOS)

{#cannot-install-update-because-startup-folder-is-in-an-app-translocation-folder.}

- macOS has moved Lidarr’s startup folder into an App Translocation path. This prevents Lidarr from updating itself. Remove the quarantine attribute or move Lidarr out of the Translocation folder and re-launch it from its permanent location.

#### Can’t install update because startup folder isn’t writable by the user

- This means Lidarr will be unable to update itself. You’ll have to update Lidarr manually or set the permissions on Lidarr’s Startup directory (the installation directory) to allow Lidarr to update itself.

#### Can’t install update because UI folder isn’t writable by the user

- This means Lidarr will be unable to update itself. You’ll have to update Lidarr manually or set the permissions on Lidarr’s UI directory to allow Lidarr to update itself.

#### Updating won’t be possible to prevent deleting AppData on Update

- Lidarr detected that the AppData folder sits inside the directory that contains the Lidarr binaries. Normally it would be `C:\ProgramData` for Windows and `~/.config` for Linux.

- Please look at `System => Info` to see the current AppData & Startup directories.
- This means Lidarr will be unable to update itself without risking data loss.
- If you’re on linux, you’ll probably have to change the home directory for the user that's running Lidarr and copy the current contents of the `~/.config/Lidarr` directory to preserve your database.

#### Branch is for a previous version

- The update branch setup in `Settings => General` is for a previous version of Lidarr, so the instance won't see correct update information in the `System => Updates` feed and may not receive new updates when released.

#### Couldn't connect to signalR

- signalR drives the dynamic UI updates, so if your browser can't connect to signalR on your server you won’t see any real time updates in the UI.

- The most common occurrence of this is use of a reverse proxy or Cloudflare.
- Cloudflare needs websockets enabled.

##### NGINX

- Nginx requires the following addition to the location block for the app:

```none
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;
```

> Make sure you don't include `proxy_set_header Connection "Upgrade";` as suggested by the nginx documentation. THIS WON'T WORK
> See <https://github.com/aspnet/AspNetCore/issues/17081>
{.is-warning}

##### Apache

- For Apache2 reverse proxy, you need to enable the following modules: proxy, proxy_http, and proxy_wstunnel. Then, add this websocket tunnel directive to your vhost configuration:

```none
RewriteEngine On
RewriteCond %{HTTP:Upgrade} =websocket [NC]
RewriteRule /(.*) ws://127.0.0.1:8686/$1 [P,L]
```

##### Caddy

- For Caddy (V1) use this:
- Note: you will also need to add the websocket directive to your lidarr configuration

```none
 proxy /lidarr 127.0.0.1:8686 {
     websocket
     transparent
 }
```

#### Failed to resolve the IP Address for the Configured Proxy Host

{#proxy-failed-resolve-ip}

- Review your proxy settings and ensure they're accurate
- Ensure your proxy is up, running, and accessible

#### Proxy Failed Test

{#proxy-failed-test}

- Your configured proxy failed to test successfully, review the HTTP error provided and/or check logs for more details.

#### System Time is off by more than 1 day

{#system-time-off}

- System time is off by more than 1 day. Scheduled tasks may not run correctly until you correct the time
- Review your system time and ensure it's synced to an authoritative time server and accurate

#### Mono Legacy TLS enabled

- Mono 4.x tls workaround still enabled, consider removing `MONO_TLS_PROVIDER=legacy` environment option

#### Mono and x86 builds are ending

- The next build of the application won't support Mono or x86. If you are receiving this error then you are running the mono version of the application or the x86 version. Due to increasing difficulty supporting these legacy versions, support and releases for them have ended. Upgrade to a supported operating system that doesn't require x86 or Mono. You may also be able to explore using Docker for your needs.

#### FPcalc is missing

{#fpcalc-missing}

- Lidarr uses chromaprint audio fingerprinting to identify tracks. This depends on an external binary `fpcalc`. Audio fingerprinting has been disabled because `fpcalc` could not be found on your system.
- Ensure the fpcalc binary bundled with Lidarr is present and executable. Look for it in Lidarr's installation directory (for example `/opt/Lidarr/fpcalc`).
- On Linux, you may need to install `libchromaprint-tools` (Debian/Ubuntu) or the equivalent package for your distribution.

#### FPcalc needs updating

{#fpcalc-upgrade}

- Lidarr uses chromaprint audio fingerprinting to identify tracks. This depends on an external binary `fpcalc`. Lidarr v1 ships `fpcalc` for Windows, Linux, and macOS, but freeBSD requires you to provide it separately.
- Ensure the fpcalc binary bundled with Lidarr is executable (755 permissions). Look for it in Lidarr's installation directory (for example `/opt/Lidarr/fpcalc`). If it isn't executable, correct its permissions with the command below and restart Lidarr.
  - Note that the fix may need `sudo`, and your path to Lidarr's binary folder may differ depending on your environment.

```bash
chmod +x /opt/Lidarr/fpcalc
```

> The below information is for legacy v0.8.0 builds only.
{.is-info}

- To fix this on a native Linux instance, install the appropriate package using your package manager and confirm that fpcalc is on your PATH by running `which fpcalc` and checking that it returns the correct location:

| Distribution  |       Package        |
| :-----------: | :------------------: |
| Debian/Ubuntu | libchromaprint-tools |
| Fedora/CentOS |  chromaprint-tools   |
|     Arch      |     chromaprint      |
|   OpenSUSE    |  chromaprint-fpcalc  |
|   Synology    |     chromaprint      |

#### API Key is too short

{#invalid-api-key}

- Your Lidarr API key must be at least 20 characters long. Go to `Settings => General` and generate a new API key, or update the existing one to be at least 20 characters.

#### Package Maintainer Message

{#package-maintainer-message}

- Your package maintainer has provided a message. This may be an informational notice, a warning, or an error from the team that packages Lidarr for your platform.

#### Plugins failed to load

{#plugins-failed-to-load}

- One or more Lidarr plugins failed to load. Check the Lidarr log for details on which plugins failed and why.

> Plugins are only available on the develop (pre-release) branch and are not included in stable releases.
{.is-info}

### Download Clients

#### No download client is available

- Lidarr needs a configured and enabled download client to download media. Since Lidarr supports different download clients, you should determine which best matches your requirements. If you already have a download client installed, you should configure Lidarr to use it and create a category. See `Settings=>Download Client`.

#### Unable to communicate with download client

- Lidarr was unable to communicate with the configured download client. Please verify the download client is operational and double-check the URL. This could also point to an authentication error.
- This is typically due to improperly configured download client. Things you can typically check:
  - Your download client's IP Address - if it's all on the same bare metal machine, this is typically `127.0.0.1`
  - The Port number that your download client is using - these default to the standard port number, but if you've changed it you will need to enter the same one in Lidarr.
  - Ensure that SSL encryption isn't turned on if you're using both your Lidarr instance and your download client on a local network (that is, over plain HTTP). See the SSL FAQ entry for more information.

#### Download clients are unavailable due to failure

- One or more of your download clients isn't responding to requests made by Lidarr. Lidarr has temporarily stopped querying the download client on its normal 1-minute cycle, which is normally used to track active downloads and import finished ones. Lidarr will still attempt to send downloads to the client, but will likely fail.
- You should inspect `System=>Logs` to see what the reason is for the failures.
- If you no longer use this download client, disable it in Lidarr to prevent the errors.

#### Enable Completed Download Handling

- Lidarr requires Completed Download Handling to import files that your download client fetched. Enable it. (Completed Download Handling is on by default for new users.)

#### Docker bad remote path mapping

- This error is typically associated with bad docker paths within either your download client or Lidarr

- An example of bad (inconsistent) paths would be:
  - Download client:  `/mnt/user/downloads:/downloads`
  - Lidarr:   `/mnt/user/downloads:/data`
- In this example the download client places its downloads into `/downloads` and tells Lidarr when its complete that the finished music is in `/downloads`. Lidarr then comes along and says "Okay, cool, let me check in `/downloads`." Well, inside Lidarr you didn't configure a `/downloads` path, only a `/data` path so it throws this error.
- The easiest fix for this is CONSISTENCY - if you use one scheme in your download client, use it across the board.

- The Lidarr team recommends using `/data` as the base path.

  - Download client: `/mnt/user/data/downloads:/data/downloads`
  - Lidarr: `/mnt/user/data:/data`

- Within the download client, specify where in `/data` to place downloads. This varies by client, but you should be able to tell it "Yeah, download client, place my files into `/data/downloads/movies`" and since you used `/data` in Lidarr when the download client tells Lidarr it's done Lidarr will come along and say "Sweet, I have a `/data` and I also can see `/data/downloads/movies`, all is right in the world."
- For more detail, see the [Docker Guide](/docker-guide) and TRaSH's [Hard links and Instant Moves (Atomic-Moves)](https://trash-guides.info/hardlinks/) guide.
- If you're crossing operating systems or native and docker then you need a remote path map. See [TRaSH's Remote Path Guide for Radarr](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/) and [Sonarr](https://trash-guides.info/Sonarr/sonarr-remote-path-mapping/) for more information.

#### Downloading into Root Folder

{#downloads-in-root-folder}

- Within the application, the configured media library folder is the root folder. This isn't the root folder of a mount. Your download client has an incomplete or complete (or is moving completed downloads) into your root (library) folder.
- This frequently causes issues - including data loss - and you shouldn't do it. To fix this, change your download client so it isn't placing downloads within your root folder. Note that 'placing' also includes if your download client category points to your root folder or if NZBGet/SABnzbd have sort enabled and are sorting to your root folder.
- Please note that this check looks at all defined/configured root folders added not only root folders currently in use. In other words, the folder your download client downloads into or moves completed downloads to, shouldn't be the same folder you have configured as your root/library/final media destination folder in Lidarr.
- Find configured root folders (aka library folders) in [Settings => Media Management => Root Folders](/lidarr/settings/#root-folders)
- One example is if your downloads are going into `\data\downloads` then you have a root folder set as `\data\downloads`.
- It's suggested to use paths like `\data\media\` for your root folder/library and `\data\downloads\` for your downloads.
- Review the [Docker Guide](/docker-guide) and TRaSH's [Hard links and Instant Moves (Atomic-Moves) Guide](https://trash-guides.info/hardlinks/) for more information on the correct and optimal path setup. Note that the concepts apply for docker and non-docker

> Your download folder where your download client places the downloads and your root/library folder MUST be separate. Lidarr will import files from your download client's folder into your library. The download client shouldn't move anything or download anything to your library.
{.is-warning}

#### Bad Download Client Settings

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from windows to linux or linux to windows without a remote path map.

#### Bad Remote Path Mapping

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from windows to linux or linux to windows without a remote path map. See [TRaSH's Remote Path Guide](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/) for more information.

#### Permissions Error

- Lidarr (or the user lidarr is running as) can't access the location your download client is downloading files to. This is typically a permission issue.

#### Remote File was removed part way through processing

- A file accessible via a remote path map appears to have disappeared before processing completed.

#### Remote Path is Used and Import Failed

- Check your logs for more info. Refer to the [Troubleshooting Guides](/lidarr/troubleshooting).

#### Download Folder Same as Library Folder

{#download-folder-and-library-folder-not-different-folders}

- Your download client is configured to sort completed downloads into a folder that is the same as (or is inside) your Lidarr library/root folder. Sorting completed downloads into your library folder can cause issues. Disable sorting in your download client or choose a download destination that is separate from your library folder.

### Completed/Failed Download Handling

#### Completed Download Handling is disabled

- Lidarr requires `Completed Download Handling` to import files that your download client fetched. Enable it. (It's on by default for new users.)

#### Download Client Removes Completed Downloads

{#download-client-removes-completed-downloads}

- Your download client must keep its history of completed downloads until Lidarr imports them. If you disable history retention, Lidarr may not see the completed download before the client removes it. Configure your download client to keep (usenet) and pause, not remove, torrents after completion: **either indefinitely or for at least 14 days**.
  - Sabnzbd: Switches => Post Processing => Keep Jobs **must** be 14 days or greater OR Keep All History
- Lidarr can manage removing completed downloads from your client via the download client settings in Lidarr. This lets Lidarr clean up your download client history.

### Indexers

#### No indexers available with automatic search enabled, Lidarr won't provide any automatic search results

- None of your indexers allow automatic searches.
- Go into `Settings => Indexers`, select an indexer you'd like to allow Automatic Searches and then click save.

#### No indexers available with RSS sync enabled, Lidarr won't grab new releases automatically

- Lidarr uses the RSS feed to pick up new releases as they come along.
- To correct this issue, go to `Settings => Indexers`, select an indexer, and enable RSS Sync.

#### No indexers are enabled

- Lidarr requires indexers to discover new releases. See [Settings => Indexers](/lidarr/settings#indexers) for instructions on adding them.

### Enabled indexers don't support searching

- None of the indexers you have enabled support searching. This means Lidarr will only be able to find new releases via the RSS feeds. But searching for releases (either Automatic Search or Manual Search) will never return any results. The only way to fix this is to add another indexer.

#### No indexers Available with Interactive Search Enabled

- None of the indexers you have enabled support interactive searching. This means the application will only be able to find new releases via the RSS feeds or an automatic search.

#### Indexers are unavailable due to failures

- Errors occurred while Lidarr tried to use one of your indexers. To limit retries, Lidarr won't use the indexer for an increasing amount of time (up to 24h).
- Lidarr triggers this mechanism when it can't get a response from the indexer (DNS, proxy/VPN, authentication, or an indexer issue) or can't fetch the nzb/torrent file.
- Please inspect the logs to determine what kind of error causes the problem.
- You can prevent the warning by disabling the affected indexer.
- Run the Test on the indexer to force Lidarr to recheck the indexer, please note that the Health Check warning won't always disappear immediately.

#### Jackett All Endpoint Used

- The Jackett `/all` endpoint is convenient, but that's its only benefit. Everything else is potential problems, so add each tracker individually.
- [Jackett's own devs recommend against using /all.](https://github.com/Jackett/Jackett#aggregate-indexers)
- Using the `/all` endpoint has no advantages, only disadvantages:
  - you lose control over indexer specific settings (categories, search modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality results
  - you can't use indexer-specific categories (>= 100000).
  - slow indexers will slow down results
  - total results cap at 1000
  - if one of the trackers returns an error, Lidarr will disable it and you won't get any results.

##### Solutions

- Add each tracker in Jackett manually as an indexer in Lidarr
- Check out [Prowlarr](/prowlarr) which can sync indexers to Lidarr and is from the Servarr development team.
- Check out [NZBHydra2](https://github.com/theotherp/nzbhydra2) which can sync indexers to Lidarr. Don't use their single combined endpoint; use `multi` if you plan to use sync.

#### Invalid Indexer Download Client Setting

{#invalid-indexer-download-client-setting}

- One or more of your indexers have a download client specified that no longer exists or is no longer enabled. Go to `Settings => Indexers` and for each affected indexer, either clear the download client setting or set it to an enabled download client.

#### Redacted Configured as Gazelle Indexer

- You have configured the Redacted indexer using the generic Gazelle indexer type. Use the dedicated Redacted indexer type instead (`Settings => Indexers`). Using the correct indexer type ensures better compatibility and support.

### Artist Folders

#### Missing Root Folder

- This error is typically identified if an artist is looking for a root folder but that root folder is no longer available.
- This error may also be if a list is still pointed at a root folder but that root folder is no longer available.
- If you would like to remove this warning simply find the artist that's still using the old root folder and edit it to the correct root folder.

- Easiest way to find the problem artist is to:

  - Go to the Artist (Library) Tab
  - Create a custom filter with the old root folder path
  - Select mass edit on the top bar and from the Root Paths drop down select the new root path that you want to move these artists to.
  - Next you will receive a pop-up that states Would you like to move the Artist folders to 'root path' ? This will also state This will also rename the Artist folder per the Artist folder format in settings. Simply select No if you don't want Lidarr to move your files
  - Run the Check Health Task in System => Tasks

#### Artist Mount is Read Only

{#artist-mount-ro}

- A mount containing an artist folder is mounted as read-only. Lidarr cannot import files into a read-only mount. Check your mount configuration and ensure that Lidarr has write access to the artist folders listed in the health check message.

#### Artist Removed from MusicBrainz

- One or more artists in your library have been removed from MusicBrainz. Lidarr cannot update metadata for removed artists. Review the affected artists and either remove them from Lidarr or update them if the MusicBrainz data has moved to a different entry.

#### Import List Missing Root Folder

{#import-list-missing-root-folder}

- One or more of your import lists reference a root folder path that does not exist or is not configured in Lidarr. Go to `Settings => Import Lists` and update the affected list(s) to use a valid root folder.

#### Lists are unavailable due to failures

- Typically this simply means that Lidarr is no longer able to communicate via API or via logging in to your chosen list provider. Your best bet if the problem persists is to contact them to rule them out, as their systems may be overloaded from time to time.
- Review System => Events filtered for Warning (Warning & Errors) to see the historical failures or check logs for details.

- Review System => Events filtered for Warning (Warning & Errors) to see the historical failures or check logs for details.

### Notifications

#### Notifications are unavailable due to failures

{#notifications-are-unavailable-due-to-failures}

- One or more of your configured notification connections is failing. Lidarr will back off from attempting to contact the failing notification service and retry after a period of time. Review `System => Events` or your logs for more details on the failure.

### Recycling Bin

#### Cannot Write to Recycle Bin

{#cannot-write-recycle-bin}

- Lidarr cannot write to the configured Recycle Bin path. Check that the path exists and that Lidarr (or the user it runs as) has write permission to the directory.

## Disk Space

- This section will show you available disk space
- In Docker this can be tricky as it will typically show you the available space within your Docker image

## About

- This will tell you about your current install of Lidarr

## More Info

- [Home Page](https://lidarr.audio)
- [Reddit](https://www.reddit.com/r/lidarr)
- [Discord](https://lidarr.audio/discord)
- [Source](https://github.com/Lidarr/Lidarr)
- [Feature Requests](https://github.com/Lidarr/Lidarr/issues)

# Tasks

## Scheduled

- This page lists all scheduled tasks that Lidarr runs

  - Application Check Update - This runs on the displayed schedule in the UI, checking whether Lidarr is on the most current version and triggering the update script if needed. Settings=> Update

  > Note: If on Docker this won't update your container as you'll need to pull a new image.
{.is-warning}

  - Backup - This will run a backup of your Lidarr's database on a set schedule; find more details here. More information about backups is at System => Backups.
  - Check Health - Check Health will run on the displayed schedule in the UI checking the health of your Lidarr. To see a list of possible health related issues see the Wiki Entry on Health Checks.
  - Housekeeping - On the displayed schedule, Lidarr optimizes the database, removes orphaned records, and performs other routine maintenance tasks.
  - Import List Sync - On the displayed schedule in the UI this will run your Lists and import any possible new artists. Find more info about lists at Settings => Lists.
  - Messaging Cleanup - On the displayed schedule in the UI this cleans up those messages that appear in the bottom left corner of Lidarr
  - Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under Activity. Essentially pinging your download client to check for finished downloads.
  - Refresh Artist - This goes through and refreshes all the metadata for all monitored and unmonitored artists
  - Rescan Folders - This rescans all root folders for changes to the library on the displayed schedule.
  - Rss Sync - This will run the RSS Sync. Change this in Settings => Options. Find more information on the RSS function in the FAQ.

> You can run all these tasks manually outside their scheduled times by hitting the icon to the far right of each of the tasks.
{.is-info}

## Queue

- The queue will show you upcoming tasks as well as a history of recently run tasks and how long those tasks took.

# Backup

> If you're looking for how to back up or restore your Lidarr instance, see the [Lidarr backup FAQ](/lidarr/faq).
{.is-info}

The Backup section shows your previous backups (unless you have a fresh install with no backups yet).

Two options are available at the top of the screen:

- **Backup Now** - Triggers a manual backup of your Lidarr database.
- **Restore Backup** - Opens a screen to restore from a previous backup. Select **Choose File** to open a file dialog and choose a Lidarr zip backup.

If you have previous backups and want to download them, select a backup file to download it. To the right of each backup you have two options:

- **Restore** - Opens a confirmation window to restore from this backup.
- **Delete** - Deletes this backup.

# Updates

The update screen shows the five most recent updates and the version you're running.
It also displays the developer release notes for each version.

> A Maintenance Release contains bug fixes and other improvements. Take a look at the commit history for specifics.
{.is-info}

# Events

The events tab shows what has been happening within your Lidarr. Use it to diagnose minor issues. It doesn't replace Trace Logs discussed in Logging. Events equal INFO Logs.

- Components - This column tells you which Lidarr component triggered the event
- Message - This column shows the message the component sent.
- Gear Icon - This option lets you change how many Components/Messages appear per page (Default is 50)
- Options at the top of the page
  - Refresh - This option will refresh the current page, pulling a new events log
  - Clear - This will clear the current events log allowing you to start from fresh

# Log Files

This page will allow you to download and see what current log files are available for Lidarr

The top row has options to control your log files.

- The top row on the far left there's a dropdown that will allow you to switch from Log files and Updater Log Files
  - Log Files - The bread and butter of any support issue; find more on log files here.
  - Updater Log Files - This will show the log files associated with Lidarr's updater script

> If you're on docker this will be empty as you should be updating by downloading a new docker image
{.is-info}

- Refresh - This will refresh the current page and display any newly created logs
- Delete - This will clear all logs allowing you to start from fresh
- File Name - This will display the file name associated with the log
- Last Written - The local time Lidarr last wrote to this log file.
  - Lidarr uses rolling log files limited to 1MB each. The current log file is always lidarr.txt, for the other files lidarr.0.txt is the next newest (higher numbers are older) up to 51 log files total. This log file contains `fatal`, `error`, `warn`, and `info` entries.
  - With Debug log level enabled, lidarr.debug.txt rolling log files appear, up to 51 files. This log file contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It covers a ~40-hour window.
  - With Trace log level enabled, lidarr.trace.txt rolling log files appear, up to 51 files. This log file contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.
