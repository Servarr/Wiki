---
title: FAQ
description: 
published: true
date: 2021-06-06T14:28:18.939Z
tags: 
editor: markdown
dateCreated: 2021-06-05T13:59:03.261Z
---
## Can I add any (generic) Torznab or Newznab indexer?

Yes.

`Indexers` -> `Add Indexer` (Plus Button) -> `Generic Torznab` or `Generic Newznab`

## Can I update Prowlarr inside my Docker container?

Technically, yes. But you should absolutely not. It is a primary philosophy of Docker. Database issues can be caused for Prowlarr if you upgrade your installation inside to the most recent nightly, then update the docker container itself which might downgrade to an older version.

## Help, my Mac says Prowlarr cannot be opened because the developer cannot be verified

This is simple, please see this link for more information [here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac)

![faq_1_mac.png](/faq_1_mac.png)

## Help, my Mac says Prowlarr.app is damaged and can’t be opened

That is either due to a corrupt download (so try again), or security issues answered just above this.

## How do I request a feature for Prowlarr?

To request a feature for Prowlarr, first search on Github to ensure no similar request exists, then [click here](https://github.com/Prowlarr/Prowlarr/issues/new?assignees=&labels=feature+request&template=feature_request.md&title=) to add your request.

## I am getting an error: Database disk image is malformed

This means your SQLite database that stores most of the information for Prowlarr is corrupt.

- Try restoring from a backup
- You can follow our instructions on [this wiki](https://wiki.servarr.com/Useful_Tools#Recovering_a_Corrupt_DB).
- Alternatively, [this guide](http://techblog.dorogin.com/2011/05/sqliteexception-database-disk-image-is.html) tells you how to copy the contents from the corrupt database into a new one.

This error may show if the database file is not writable by the user/group Prowlarr is running as.

Another possible cause of you getting an error with your Database is that you're placing your database on a network drive (nfs or smb or something else not local). Simple answer to this is to not do this as SQLite and network drives not typically play nice together and will cause a malformed database eventually. **Prowlarr's config folder must be on a local drive.**

If you are using mergerFS you need to remove `direct_io` as sqlite uses mmap which isn’t supported by direct_io as explained in the mergerFS docs [here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs).

## I use Prowlarr on a Mac and it suddenly stopped working. What happened?

Most likely this is due to a MacOS bug which caused the Prowlarr database to be corrupted. Please check the FAQ entry for restoring a corrupt database.

## Why can’t Prowlarr see my files on a remote server?

In short: the user Prowlarr is running as (if service) or under (if tray app) cannot access the file path on the remote server. This can be for various reasons, but the most common is, Prowlarr is running as a service, which causes one of two things:

Prowlarr runs under the LocalService account by default which doesn’t have access to protected remote file shares.

Solutions:

- Run Prowlarr’s service as another user that has access to that share
- Open the Administrative Tools > Services window on your Windows server.
- Stop the Prowlarr service.
- Open the Properties > Log On dialog.
- Change the service user account to the target user account.
- Run Prowlarr.exe using the Startup Folder

You’re using a mapped network drive (not a UNC path)

Solutions:

- Change your paths to UNC paths (\\server\share)
- Run Prowlarr.exe via the Startup Folder
- Mapped Network Drives vs UNC Paths

Using mapped network drives generally doesn’t work very well, especially when Prowlarr is configured to run as a service. The better way to set shares up is using UNC paths. So instead of X:\Movies use \\Server\Movies\.

A key point to remember is that Prowlarr gets path information from the downloader, so you’ll also need to setup NZBGet, SABNzbd or any other downloader to use UNC paths too.

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

## Jackett shows more results than Prowlarr when manually searching

This is usually due to Prowlarr searching Jackett differently than you do. See this troubleshooting article for further information.

## Weird UI Issues

If you experience any weird UI issues like a certain view or sort not working, try viewing in a Chrome Incognito Window or Firefox Private Window. If it works fine there, clear your browser cache and cookies for your specific ip/domain.

## Web Interface Only Loads at localhost on Windows

If you can only reach your web interface at `http://localhost:9696/` or `http://127.0.0.1:9696`, you need to run Prowlarr as Administrator at least once, maybe even always.

## Permissions

Prowlarr will need to move files away from where the downloader puts them into the final location, so this means that Prowlarr will need to read/write to both the source and the destination directory and files.
On Linux, where best practices have services running as their own user, this will probably mean using a shared group and setting folder permissions to 775 and files to 664 both in your downloader and Prowlarr. In umask notation, that would be 002.
System & Logs loads forever

It's the easy-privacy blocklist. They basically block any url with /api/log? in it. Look over the list and tell me if you think that blocking all the urls in that list is a sensible idea, there are dozens of urls in there that potentially break sites. You selected that in your adblocker. Easy solution is to whitelist the domain Sonarr is running on. But I still recommend checking the list.

## Finding Cookies

Some sites cannot be logged into automatically and require you to login manually then give the cookies to Prowlarr to work. This page describes how you do that.

Chrome

![faq_2_cookies.png](/faq_2_cookies.png)

Firefox

![faq_3_cookies.png](/faq_3_cookies.png)

## Unpack Torrents

Most torrent clients don’t come with the automatic handling of compressed archives like their usenet counterparts. We recommend [unpackerr](https://github.com/davidnewhall/unpackerr).

## uTorrent is no longer working

- Ensure the Web UI is enabled

![faq_4_utorrent.png](/faq_4_utorrent.png)

- Turn on Web UI

![faq_5_utorrent.png](/faq_5_utorrent.png)

- Ensure that the Alt Listening Port (Advanced -> Web UI) is not the same as the Listening Port (Connections). We'd suggest changing the Web UI Alt Listening Port so as to not mess with any port forwarding for connections.

![faq_6_utorrent.png](/faq_6_utorrent.png)

## I got a pop-up that said config.xml was corrupt, what now?

Prowlarr was unable to read your config file on start-up as it became corrupted somehow. In order to get Prowlarr back online, you will need to delete `.xml` in your AppData Folder, once deleted start Prowlarr and it will start on the default port (9696), you should now re-configure any settings you configured on the General Settings page.

## Invalid Certificate and other HTTPS or SSL issues

Your download client stopped working and you're getting an error like `Localhost is an invalid certificate`?

Prowlarr now validates SSL certificates. If there is no SSL certificate set in the download client, or you're using a self-signed https certificate without the CA certificate added to your local certificate store, then Prowlarr will refuse to connect. Free properly signed certificates are available from let's encrypt.

If your download client and Prowlarr are on the same machine there is no reason to use HTTPS, so the easiest solution is to disable SSL for the connection. Most would agree it's not required on a local network either. It is possible to disable certificate validation in advanced settings if you want to keep an insecure SSL setup.

## VPNs, Prowlarr, and the * ARRs

Unless you're in a repressive country like China, Australia or South Africa, your torrent client is typically the only thing that needs to be behind a VPN. Because the VPN endpoint is shared by many users, you can and will experience rate limiting, DDOS protection, and ip bans from various services each software uses.

In other words, putting the *Arrs (Lidarr, Radarr, Readarr, and Sonarr) behind a VPN can and will make the applications unusable in some cases due to the services not being accessible. To be clear it is not a matter if VPNs will cause issues with the* Arrs, but when: image providers will block you and cloudflare is in front of most of arr servers (updates, metadata, etc.) and liable to block you too.

In addition, some private trackers ban for browsing from a VPN, which is how Prowlarr works. In some cases (i.e. certain UK ISPs) it may be needed to use a VPN for public trackers, in which case you should then be putting only Prowlarr behind the VPN. However, you should not do that if you have private trackers without checking their rules first. Many private trackers will ban you for using or accessing them (i.e. using Prowlarr) via a VPN.

## Can I use flaresolverr indexers?

At the moment, indexers that use cloudflare and captchas are not supported with a flaresolverr solution. If you want to use those, you will need to continue to use your existing method of connection.

## Prowlarr won't sync to Sonarr

Prowlarr only talks to Sonarr V3. V3 is the current branch, which everyone should be running. If you have not upgraded, you should do so immediately. V2 is reaching EOL, and it is fully expected that some integration doesn't work with V2, Prowlarr included.
