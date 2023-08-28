---
title: Prowlarr FAQ
description: Prowlarr FAQ
published: true
date: 2023-08-28T19:29:30.585Z
tags: prowlarr, faq
editor: markdown
dateCreated: 2021-11-03T03:01:18.079Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Forced Authentication](#forced-authentication)
  - [How do I reset Stats?](#how-do-i-reset-stats)
  - [Category Not Available or Missing](#category-not-available-or-missing)
  - [Can I add any (generic) Torznab or Newznab indexer?](#can-i-add-any-generic-torznab-or-newznab-indexer)
  - [Can I add any (generic) Torrent RSS Feed?](#can-i-add-any-generic-torrent-rss-feed)
  - [Can I use flaresolverr indexers?](#can-i-use-flaresolverr-indexers)
  - [How can I add an indexer that is down or not functional?](#how-can-i-add-an-indexer-that-is-down-or-not-functional)
  - [Prowlarr will not sync to Sonarr](#prowlarr-will-not-sync-to-sonarr)
  - [Prowlarr will not sync X Indexer to App](#prowlarr-will-not-sync-x-indexer-to-app)
  - [What \*Arr Indexer Settings are Compared for App Full Sync](#what-arr-indexer-settings-are-compared-for-app-full-sync)
  - [How do I update Prowlarr?](#how-do-i-update-prowlarr)
    - [Can I update Prowlarr inside my Docker container?](#can-i-update-prowlarr-inside-my-docker-container)
    - [Installing a newer version](#installing-a-newer-version)
      - [Native](#native)
      - [Docker](#docker)
  - [Can I switch from `nightly` back to `develop`?](#can-i-switch-from-nightly-back-to-develop)
  - [Can I switch between branches?](#can-i-switch-between-branches)
  - [Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified](#help-my-mac-says-prowlarr-cannot-be-opened-because-the-developer-cannot-be-verified)
  - [Help, my Mac says Prowlarr.app is damaged and can’t be opened](#help-my-mac-says-prowlarrapp-is-damaged-and-cant-be-opened)
  - [How do I request a feature for Prowlarr?](#how-do-i-request-a-feature-for-prowlarr)
  - [I am getting an error: Database disk image is malformed](#i-am-getting-an-error-database-disk-image-is-malformed)
  - [I use Prowlarr on a Mac and it suddenly stopped working. What happened?](#i-use-prowlarr-on-a-mac-and-it-suddenly-stopped-working-what-happened)
  - [How do I change from the Windows Service to a Tray App?](#how-do-i-change-from-the-windows-service-to-a-tray-app)
  - [How do I Backup/Restore Prowlarr?](#how-do-i-backuprestore-prowlarr)
    - [Backing up Prowlarr](#backing-up-prowlarr)
      - [Using built-in backup](#using-built-in-backup)
      - [Using file system directly](#using-file-system-directly)
    - [Restoring from Backup](#restoring-from-backup)
      - [Using zip backup](#using-zip-backup)
      - [Using file system backup](#using-file-system-backup)
      - [File System Restore on Synology NAS](#file-system-restore-on-synology-nas)
  - [WebUI only Loads at localhost on Windows](#webui-only-loads-at-localhost-on-windows)
  - [Finding Cookies](#finding-cookies)
  - [uTorrent is no longer working](#utorrent-is-no-longer-working)
  - [I got a pop-up that said config.xml was corrupt, what now?](#i-got-a-pop-up-that-said-configxml-was-corrupt-what-now)
  - [Invalid Certificate and other HTTPS or SSL issues](#invalid-certificate-and-other-https-or-ssl-issues)
  - [Help I have locked myself out](#help-i-have-locked-myself-out)
  - [Weird UI Issues](#weird-ui-issues)
  - [VPNs, Prowlarr, and the \*ARRs](#vpns-jackett-and-the-arrs)
  - [How do I stop the browser from launching on startup?](#how-do-i-stop-the-browser-from-launching-on-startup)
  - [Can I easily add all indexers at once?](#can-i-easily-add-all-indexers-at-once)
  
## Forced Authentication

If Prowlarr is exposed so that the UI can be accessed from outside your local network then you should have some form of authentication method enabled in order to access the UI. This is also increasingly required by Trackers and Indexers.

As of Prowlarr v1, Authentication is Mandatory.

### Authentication Method

- `Basic` (Browser pop-up) - This option when accessing your Prowlarr will show a small pop-up allowing you to input a Username and Password
- `Forms` (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Prowlarr
- `External` - Configurable via Config File Only
  - If you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](/prowlarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost value will be used**

### Authentication Required

- If you do not expose the app externally and/or do not wish to have auth required for local (e.g. LAN) access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`
  
## How do I reset Stats?

- To reset your stats and clear history do the following:

1. History => Options
1. Set History Cleanup to `1`. This will keep only through yesterday's History and Stats
1. Navigate to System => Tasks
1. Run the `Clean Up History` Task
1. Run the `Housekeeping` Task
1. Return to History => Options
1. Set History Cleanup to your desired retention period for History and Stats

## Category Not Available or Missing

- Please note that custom/non-standard indexer specific categories are mapped to standard ones, so searching will standard ones will incorporate all custom ones. Review your specific Indexer's category mapping definition for details.

## Can I add any (generic) Torrent RSS Feed?

Yes. Use "TorrentRSS".

The following attributes are mandatory:

- guid
- title
- infohash
- enclosure or link

The following attributes are optional, but recommended:

- size
- pubDate

## Can I add any (generic) Torznab or Newznab indexer?

- Yes.
- Go to `Indexers` => `Add Indexer` (<kb>+</kb>) => `Generic Torznab` or `Generic Newznab`

## Can I use flaresolverr indexers?

- Yes.

1. Configure your flaresolverr instance by adding it as a proxy in [Settings => Indexers](/prowlarr/settings#indexer-proxies)
1. Add a tag to the created flaresovlerr proxy
1. Add the same tag to your [Indexer](/prowlarr/indexers)

> The tags must match & Cloudflare must be detected for Flaresolverr to be used. A Flaresolverr proxy is disabled if no tags are used.
{.is-warning}

> [See TRaSH's Guides on "How to setup Flaresolverr"](https://trash-guides.info/Prowlarr/prowlarr-setup-flaresolverr/) for more details
{.is-info}

## How can I add an indexer that is down or not functional?

- Follow then standard steps to add the indexer noting thr following changes.
- Uncheck (Disable) the `Enabled` box
- Press `Save`
- Press `Save` again to trigger a force save
- Edit the Indexer (Wrench Icon)
- Check (Enable) the `Enabled` box
- Press `Save`
- Press `Save` again to trigger a force save

## Prowlarr will not sync to Sonarr

- Prowlarr only supports Sonarr v3+
- Sonarr v2 (fka nzbdrone) is not supported by Prowlarr nor supported in general and has been end-of-life since March 2021

## Prowlarr will not sync X Indexer to App

- Prowlarr only syncs if Add and Remove or Full Sync is enabled for the app.
- Only in instances where an App and Indexer have matching tags or no tags at all will an indexer be synced to an app
- Indexers are synced based on the capabilities/categories they claim to support.
  - If an indexer supports only TV categories it will not be synced to Lidarr, Radarr, and Readarr.
- A given indexer will only be synced to Sonarr "Supported" Categories can be selected as an advanced setting on a per app basis.
- Indexers will not be attempted to be synced if the specific Categories supported by the Indexer are not selected in Settings => Application => {App} => Sync Categories (Advanced Settings) and logs will not show any indication of a sync attempt.
- The most common cause for this is that the \*Arrs only accept indexers whose test queries return results containing at least one of the configured categories. In other words, if you're syncing to an App and your indexer's empty query does not return results with any release within the categories configured for the App then it will be unable to add the indexer to \*Arr.
- The specific error will be be an HTTP 400 from \*Arr stating `Query successful, but no results in the configured categories were returned from your indexer. This may be an issue with the indexer or your indexer category settings.`
  - Possibly that indexer simply cannot be used with that \*Arr. This is common for attempting to use public trackers or usenet indexers with Readarr and Lidarr.
  - Adjust the categories synced in the advanced settings for the \*Arr application within Prowlarr
    - Note that certain Trackers - primarily "crappy" public trackers - require one to select and sync the `8000 - Other` category. This is often - but not always - noted within the Tracker's details within Prowlarr.
  - Try again later
  - If the issue persist you may have a corrupted database. Check your logs for instances of `Database disk image is malformed` or `Error creating main database`. See [this heading](https://wiki.servarr.com/prowlarr/faq#i-am-getting-an-error-database-disk-image-is-malformed) for possible solutions.

## What \*Arr Indexer Settings are Compared for App Full Sync

- App/Prowlarr: Indexer Name
- App/Prowlarr: Enable/Disable RSS
- App/Prowlarr: Enable/Disable Auto Search
- App/Prowlarr: Enable/Disable Interactive Search
- App/Prowlarr: Indexer Priority
- App/Prowlarr: API Key
- App/Prowlarr: Url
- App/Prowlarr: Baseurl
- App/Prowlarr: Port
- App/Prowlarr: Categories
- App/Prowlarr: Seed Ratio and Seed Time
- App/Prowlarr: Minimum Seeders
- App/Prowlarr: *Any Other Settings configurable/controlled in Prowlarr*
- Prowlarr: Implementation (e.g. YML or C#)

With Full Sync enabled, if any of the above change between the \*Arr App and Prowlarr then the Indexer will be Synced and Updated in \*Arr.

## How do I update Prowlarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `master`, `develop`, or `nightly`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` - ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/master/changes) -    (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch.

- `develop` - ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/develop/changes) -  (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first after nightly. It can be considered semi-stable, but is still `beta`.

> On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` - ![Current Nightly/Unstable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/nightly/changes) -  (Alpha/Unstable): This is the bleeding edge. It is released as soon as code is committed and passes all automated tests. This build may have not been used by us or other users yet. There is no guarantee that it will even run in some cases. This branch is only recommended for advanced users. Issues and self investigation are expected in this branch.  ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-danger}

- Note: If your install is through Docker append `:latest`, `:testing`, `:develop`, or `:nightly` to the end of your container tag depending on who makes your builds.

|                                                                      | `master` (stable) ![Current Master/Stable](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/master/changes) | `develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/develop/changes) | `nightly` (unstable) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/nightly/changes) |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [hotio](https://hotio.dev/containers/prowlarr)                       | `latest`                                                                                                                                                                                                             | `testing`                                                                                                                                                                                                            | `nightly`                                                                                                                                                                                                                 |
| [LinuxServer.io](https://docs.linuxserver.io/images/docker-prowlarr) | `latest`                                                                                                                                                                                                             | `develop`                                                                                                                                                                                                            | `nightly`                                                                                                                                                                                                                 |

### Can I update Prowlarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

#### Native

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

#### Docker

1. Repull your tag and update your container

## Can I switch from `nightly` back to `develop`?

## Can I switch between branches?

- If version is identical you can switch, otherwise check with the development team to see if you can switch from `nightly` to `develop`; or `develop` to `nightly` for your given build.
- Failure to follow these instructions may result in your Prowlarr becoming unusable or throwing errors. You have been warned
  - The most common errors are database errors around missing columns or tables.

## Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified

- This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac)
- Alternatively, you may need to self-sign Prowlarr `codesign --force --deep -s - /Applications/Prowlarr.app && xattr -rd com.apple.quarantine`

![faq_1_mac.png](/assets/general/faq_1_mac.png)

## Help, my Mac says Prowlarr.app is damaged and can’t be opened

That is either due to a corrupt download (so try again), or security issues answered just above this.

## How do I request a feature for Prowlarr?

To request a feature for Prowlarr, first search on GitHub to ensure no similar request exists, then [click here](https://github.com/Prowlarr/Prowlarr/issues/new?assignees=&labels=feature+request&template=feature_request.md&title=) to add your request.

## I am getting an error: Database disk image is malformed

- **Errors of `Error creating log database` indicate issues with logs.db**
  - This can quickly be resolved by renaming or removing the database. The logs database contains unimportant information regarding commands history and update install history, and Info, Warn, and Error entries
- **Errors of `Error creating main database` or generic `database disk image is malformed` with no specified database indicate issues with prowlarr.db**
  - Continue with the steps noted below
- This means your SQLite database that stores most of the information for Prowlarr is corrupt. Your options are to try (a) backup(s), try recovering the existing database, try recovering the backup(s), or if all else fails starting over with a fresh new database.
- This error may show if the database file is not writable by the user/group \*Arr is running as. Permissions being the cause will likely only be an issue for new installs, migrated installs to a new server, if you recently modified your appdata directory permissions, or if you changed the user and group \*Arr run as.
- Your best and first option is to [try restoring from a backup](#how-do-i-backuprestore-my-prowlarr)
- You can also try recovering your database. This is typically the only option for when this issue occurs after an update. Try the [sqlite3 `.recover` command](/useful-tools#recovering-a-corrupt-db)
  - If your sqlite does not have `.recover` or you wish a more GUI (i.e. Windows) friendly way then follow [our instructions on this wiki.](/useful-tools#recovering-a-corrupt-db-ui)
- Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). **SQLite is designed for situations where the data and application coexist on the same machine.** Thus your \*Arr AppData Folder (/config mount for docker) MUST be on local storage. [SQLite and network drives not play nice together and will cause a malformed database eventually](https://www.sqlite.org/draft/useovernet.html).
- If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by `direct_io` as explained in the mergerFS [docs here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use Prowlarr on a Mac and it suddenly stopped working. What happened?

- Most likely this is due to a MacOS bug which caused the Prowlarr database to be corrupted. Please check the FAQ entry for restoring a corrupt database.

## How do I change from the Windows Service to a Tray App?

- Shut Prowlarr down
- Run serviceuninstall.exe that's in the Prowlarr directory
- Run Prowlarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
- (Optional) Drop a shortcut to Prowlarr.exe in the startup folder to auto-start on boot.

## How do I Backup/Restore Prowlarr?

### Backing up Prowlarr

#### Using built-in backup

- Go to System => Backup in the Prowlarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

#### Using file system directly

- Find the location of the AppData directory for Prowlarr  
  - Via the Prowlarr UI go to System => About  
  - [Prowlarr Appdata Directory](/prowlarr/appdata-directory)
- Stop Prowlarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

### Restoring from Backup

> Restoring to an OS that uses different paths will not work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing `/` instead of `\` that Windows uses, but is not supported. You'll need to manually edit all paths in the database.
{.is-warning}

#### Using zip backup

- Re-install Prowlarr (if applicable / not already installed)
- Run Prowlarr
- Navigate to System => Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

#### Using file system backup

- Re-install Prowlarr (if applicable / not already installed)
- Find the location of the AppData directory for Prowlarr  
  - Running Prowlarr once and via the UI go to System => About  
  - [Prowlarr Appdata Directory](/prowlarr/appdata-directory)
- Stop Prowlarr
- Delete the contents of the AppData directory **(Including the .db-wal/.db-journal files if they exist)**
- Restore from your backup
- Start Prowlarr
- As long as the paths are the same, everything will pick up where it left off

#### File System Restore on Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.
{.is-warning}

- Re-install Prowlarr (if applicable / not already installed)
- Find the location of the AppData directory for Prowlarr  
  - Running Prowlarr once and via the UI go to System => About  
  - [Prowlarr Appdata Directory](/prowlarr/appdata-directory)
- Stop Prowlarr
- Connect to the Synology NAS through SSH and log in as root  

> On some installations, the user is different than the below commands: `chown -R sc-Prowlarr:Prowlarr *` {.is-info}

- Execute the following commands:

    ```shell
        rm -r /usr/local/Prowlarr/var/.config/Prowlarr/Prowlarr.db
        cp -f /tmp/Prowlarr_backup/* /usr/local/Prowlarr/var/.config/Prowlarr/
    ```

- Update permissions on the files:

    ```shell
        cd /usr/local/Prowlarr/var/.config/Prowlarr/
        chown -R Prowlarr:users *
        chmod -R 0644 *
    ```

- Start Prowlarr

## WebUI only Loads at localhost on Windows

If you can only reach your web interface at `http://localhost:9696/` or `http://127.0.0.1:9696`, you need to run Prowlarr as Administrator at least once, maybe even always.

## Finding Cookies

Some sites cannot be logged into automatically and require you to login manually then give the cookies to Prowlarr to work. [Please see this article for details.](/useful-tools#finding-cookies)

## uTorrent is no longer working

- Ensure the Web UI is enabled

![faq_4_utorrent.png](/assets/general/faq_4_utorrent.png)

- Turn on Web UI

![faq_5_utorrent.png](/assets/general/faq_5_utorrent.png)

- Ensure that the Alt Listening Port (Advanced => Web UI) is not the same as the Listening Port (Connections). We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

![faq_6_utorrent.png](/assets/general/faq_6_utorrent.png)

## I got a pop-up that said config.xml was corrupt, what now?

Prowlarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Prowlarr back online, you will need to delete `.xml` in your AppData Folder, once deleted start Prowlarr and it will start on the default port (9696), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

Prowlarr validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Prowlarr will refuse to connect. Free properly signed certificates are available from let's encrypt.

If your download client and Prowlarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## Help I have locked myself out

{#help-i-have-forgotten-my-password}

To disable authentication (to reset your forgotten username or password) you will need need to edit `config.xml` which will be inside the [Prowlarr Appdata Directory](/prowlarr/appdata-directory)

1. Open config.xml in a text editor
1. Find the authentication method line will be
`<AuthenticationMethod>Basic</AuthenticationMethod>` or `<AuthenticationMethod>Forms</AuthenticationMethod>`
1. Change the `AuthenticationMethod` line to `<AuthenticationMethod>None</AuthenticationMethod>`
1. Restart Prowlarr
1. Prowlarr will now be accessible without a password, you should go the `Settings: General` in the UI and set your username and password

## Weird UI Issues

- If you experience any weird UI issues or a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain. For more information, see the [Clear Cache Cookies and Local Storage](/useful-tools#clearing-cookies-and-local-storage) wiki article.

## VPNs, Jackett, and the \*ARRs

- Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.
- In other words, putting the  \*Arrs (Lidarr, Prowlarr, Radarr, Readarr, and Lidarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible.

> **To be clear it is not a matter if VPNs will cause issues with the \*Arrs, but when: image providers will block you and cloudflare is in front of most of \*Arr servers (updates, metadata, etc.) and liable to block you too**
{.is-warning}

- **Many private trackers will ban you for using or accessing them (i.e. using Jackett or Prowlarr) via a VPN.**

### Use of a VPN

- If a VPN is required and Docker is used it is recommended to use Hotio or Binhex's Download Client + VPN Containers.
- If a VPN is required and Docker is not used your VPN client ***must*** support split tunneling so only the required (Download Client) apps are behind the VPN.
- Many issues with accessing trackers can be resolved by using Google or Cloudflare's DNS servers in lieu of your ISP's DNS servers.
- In some cases (i.e. UK ISPs) you may need to put your torrent download client behind a VPN and Jackett/Prowlarr as follows:
  - put Jackett behind the VPN and ensure split tunneling allows local access
  - for Prowlarr configure your vpn client to provide a proxy and add the proxy in Settings => Indexers. Give the proxy a tag and any indexers that need to use it the same tag.
    - If absolutely required and if your vpn does not provide a way to create a proxy you may put Prowlarr behind the VPN and ensure split tunneling allows local access.

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` => `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Prowlarr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Prowlarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.

## Can I easily add all indexers at once?

No. This would not be a good thing to do, and this functionality will not be added. It is much better to choose your indexers wisely, pay attention to the stats to remove indexers that are too slow or not producing grabs. Proper pruning and maintenance of your indexers will result in much better results overall, and quicker results on searches from your apps.
