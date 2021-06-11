---
title: Prowlarr FAQ
description:
published: true
date: 2021-06-09T23:04:19.147Z
tags:
editor: markdown
dateCreated: 2021-06-05T13:59:03.261Z
---

## Can I add any (generic) Torznab or Newznab indexer?

Yes.

`Indexers` -> `Add Indexer` (Plus Button) -> `Generic Torznab` or `Generic Newznab`

## How do I update Prowlarr?

- Go to Settings and then the General tab and show advanced settings (use the toggle by the save button).

1. Under the Updates section change the branch name to `develop` or `nightly`
1. Save

*This will not install the bits from that branch immediately, it will happen during the next update.*

- `master` (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch. **Prowlarr does not yet have a stable release.**

- `develop` (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first.

> On GitHub, this is a snapshot of the `develop` branch at a specific point in time.
{.is-warning}

- `nightly` (Alpha/Unstable): The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.

> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:testing`, `:develop`, or `:nightly` to the end of your container tag depending on who makes your builds.

||`master` (stable) <!--![Current Master/Latest](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/prowlarr/release/VERSION.json)-->|`develop` (beta) ![Current Develop/Beta](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/prowlarr/testing/VERSION.json)|`nightly` (unstable) ![Current Nightly/Alpha](https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=&query=%24.version&url=https://raw.githubusercontent.com/hotio/prowlarr/nightly/VERSION.json)|
|---|---|---|---|
|[hotio](https://hub.docker.com/r/hotio/prowlarr)|no stable release yet|`hotio/prowlarr:testing`|`hotio/prowlarr:nightly`|
|[LinuxServer.io](https://hub.docker.com/r/linuxserver/prowlarr)|no stable release yet|`linuxserver/prowlarr:develop`|`linuxserver/prowlarr:nightly`|

## Can I update Prowlarr inside my Docker container?

- *Technically, yes.* **But you absolutely should not.** It is a primary philosophy of Docker. Database issues can arise if you upgrade your installation inside to the most recent `nightly`, but then update the Docker container itself (possibly downgrading to an older version).

### Installing a newer version

If Native:

1. Go to System and then the Updates tab
1. Newer versions that are not yet installed will have an update button next to them, clicking that button will install the update.

If Docker:

1. Repull your tag and update your container

## Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified

This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac)

![faq_1_mac.png](/assets/general/faq_1_mac.png)

## Help, my Mac says Prowlarr.app is damaged and can’t be opened

That is either due to a corrupt download (so try again), or security issues answered just above this.

## How do I request a feature for Prowlarr?

To request a feature for Prowlarr, first search on GitHub to ensure no similar request exists, then [click here](https://github.com/Prowlarr/Prowlarr/issues/new?assignees=&labels=feature+request&template=feature_request.md&title=) to add your request.

## I am getting an error: Database disk image is malformed

This means your SQLite database that stores most of the information for Prowlarr is corrupt.

- Try restoring from a backup
- You can follow our instructions on [this wiki](https://wiki.servarr.com/Useful_Tools#Recovering_a_Corrupt_DB).
- Alternatively, [this guide](http://techblog.dorogin.com/2011/05/SQLiteexception-database-disk-image-is.html) tells you how to copy the contents from the corrupt database into a new one.

This error may show if the database file is not writable by the user/group Prowlarr is running as.

Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). Simple answer to this is to not do this as SQLite and network drives not typically play nice together and will cause a malformed database eventually. **Prowlarr's config folder must be on a local drive.**

If you are using mergerFS you need to remove `direct_io` as SQLite uses mmap which isn’t supported by direct_io as explained in the mergerFS docs [here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs).

## I use Prowlarr on a Mac and it suddenly stopped working. What happened?

Most likely this is due to a MacOS bug which caused the Prowlarr database to be corrupted. Please check the FAQ entry for restoring a corrupt database.

## How do I change from the Windows Service to a Tray App?

- Shut Prowlarr down
- Run serviceuninstall.exe that's in the Prowlarr directory
- Run Prowlarr.exe as an administrator once to give it proper permissions and open the firewall. Once complete, then you can close it and run it normally.
- (Optional) Drop a shortcut to Prowlarr.exe in the startup folder to auto-start on boot.

## How do I Backup/Restore my Prowlarr?

Backing up Prowlarr

Using built-in backup

- Go to System: Backup in the Prowlarr UI
- Click the Backup button
- Download the zip after the backup is created for safekeeping

Using file system directly

- Find the location of the AppData directory for Prowlarr (Via the Prowlarr UI go to System: About)
- Stop Prowlarr - This will prevent the database from being corrupted
- Copy the contents to a safe location

Restoring from Backup

Restoring to an OS that uses different paths won’t work (Windows to Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving between OS X and Linux may work, since both use paths containing / instead of \ that Windows uses, but is not supported.

Using zip backup

- Re-install Prowlarr
- Run Prowlarr
- Navigate to System > Backup
- Select Restore Backup
- Select Choose File
- Select your backup zip file
- Select Restore

Using file system backup

- Re-install Prowlarr
- Run Prowlarr once to get the AppData directory location
- Stop Prowlarr
- Delete the contents of the AppData directory (Including the .db-wal/.db-journal files if they exist)
- Restore from your backup
- Start Prowlarr

As long as the paths are the same, everything will pick up where it left off.

Restore for Synology NAS

> CAUTION: Restoring on a Synology requires knowledge of Linux and Root SSH access to the Synology Device.

- Re-install Prowlarr
- Run Prowlarr once to get the AppData directory location
- Stop Prowlarr
- Connect to the Synology NAS through SSH and log in as root
- Execute the following commands:

`rm -r /usr/local/{{{ARRNAME}}}/var/.config/{{{ARRNAME}}}/{{{ARRNAME}}}.db*`
`cp -f /tmp/{{{ARRNAME}}}_backup/* /usr/local/{{{ARRNAME}}}/var/.config/{{{ARRNAME}}}/`

Update permissions on the files:

`cd /usr/local/{{{ARRNAME}}}/var/.config/{{{ARRNAME}}}/`
`chown -R {{{ARRNAME}}}:users *`
`chmod -R 0644 *`

On some installations, the user is different:

`chown -R sc-Prowlarr:Prowlarr *`

Start Prowlarr

## Help I have locked myself out

To disable authentication (to reset your username or password) you will need need to edit config.xml which will be inside the Prowlarr Appdata Directory.

Open config.xml in a text editor, and find the authentication method. The line will be

`<AuthenticationMethod>Basic</AuthenticationMethod>`
or
`<AuthenticationMethod>Forms</AuthenticationMethod>`

Change the AuthenticationMethod line to
`<AuthenticationMethod>None</AuthenticationMethod>`

Restart Prowlarr

Prowlarr will now be accessible without a password, and then you can go to `Settings: General` in the Prowlarr UI and set your username and password again.

## Weird UI Issues

If you experience any weird UI issues like a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain.

## Web Interface Only Loads at localhost on Windows

If you can only reach your web interface at `http://localhost:9696/` or `http://127.0.0.1:9696`, you need to run Prowlarr as Administrator at least once, maybe even always.

## Finding Cookies

Some sites cannot be logged into automatically and require you to login manually then give the cookies to Prowlarr to work. This page describes how you do that.

Chrome

![faq_2_cookies.png](/assets/general/faq_2_cookies.png)

Firefox

![faq_3_cookies.png](/assets/general/faq_3_cookies.png)

## uTorrent is no longer working

- Ensure the Web UI is enabled

![faq_4_utorrent.png](/assets/general/faq_4_utorrent.png)

- Turn on Web UI

![faq_5_utorrent.png](/assets/general/faq_5_utorrent.png)

- Ensure that the Alt Listening Port (Advanced -> Web UI) is not the same as the Listening Port (Connections). We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

![faq_6_utorrent.png](/assets/general/faq_6_utorrent.png)

## I got a pop-up that said config.xml was corrupt, what now?

Prowlarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Prowlarr back online, you will need to delete `.xml` in your AppData Folder, once deleted start Prowlarr and it will start on the default port (9696), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

Prowlarr now validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Prowlarr will refuse to connect. Free properly signed certificates are available from let's encrypt.

If your download client and Prowlarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## VPNs, Prowlarr, and the * ARRs

Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

In other words, putting the *Arrs (Lidarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. To be clear it is not a matter if VPNs will cause issues with the* Arrs, but when: image providers will block you and cloudflare is in front of most of *arr servers (updates, metadata, etc.) and liable to block you too.

In addition, some private trackers ban for browsing from a VPN, which is how Prowlarr works. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Prowlarr behind the VPN. However, you should not do that if you have private trackers without checking their rules first. Many private trackers will ban you for using or accessing them (i.e. using Prowlarr) via a VPN.

## Can I use flaresolverr indexers?

At the moment, indexers that use cloudflare and captchas are not supported with a flaresolverr solution. If you want to use those, you will need to continue to use your existing method of connection.

## Prowlarr won't sync to Sonarr

Prowlarr only talks to Sonarr V3. V3 is the current branch, which everyone should be running. If you have not upgraded, you should do so immediately. V2 is reaching EOL, and it is fully expected that some integration doesn't work with V2, Prowlarr included.

## How do I stop the browser from launching on startup?

Depending on your OS, there are multiple possible ways.

- In `Settings` -> `General` on some OS'es, there is a checkbox to launch the browser on startup.
- When invoking Prowlarr, you can add `-nobrowser` (*nix) or `/nobrowser` (Windows) to the arguments.
- Stop Prowlarr and edit the config.xml file, and change `<LaunchBrowser>True</LaunchBrowser>` to `<LaunchBrowser>False</LaunchBrowser>`.