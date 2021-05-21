<noinclude> <templatedata> {

`   "params": {`  
`       "ARRNAME": {`  
`           "description": "Name of Application",`  
`           "example": "Radarr",`  
`           "type": "string",`  
`           "required": true`  
`       },`  
`       "ARRDISCORD": {`  
`           "description": "Link to App Discord",`  
`           "example": "`<https://discord.gg/r5wJPt9>`",`  
`           "type": "url",`  
`           "required": true`  
`       },`  
`       "ARRPORT": {`  
`           "description": "Application Default Port",`  
`           "example": "7878",`  
`           "type": "string",`  
`           "required": true`  
`       }`  
`   }`

} </templatedata> </noinclude>

# General FAQs

## Can I update  inside my Docker container?

<span id="can_i_update_{{{ARRNAME}}}_inside_my_docker_container"><small>[anchor](#can_i_update_{{{ARRNAME}}}_inside_my_docker_container "wikilink")</small></span>  
\* *Technically, yes.* **But you should absolutely not.** It is a
primary philosophy of Docker. Database issues can be caused for  if you
upgrade your installation inside to the most recent nightly, then update
the docker container itself which might downgrade to an older version.

## Help, My Mac says  cannot be opened because the developer cannot be verified

<span id="help_my_mac_says_{{{ARRNAME}}}_cannot_be_opened_because_the_developer_cannot_be_verified"><small>[anchor](#help_my_mac_says_{{{ARRNAME}}}_cannot_be_opened_because_the_developer_cannot_be_verified "wikilink")</small></span>  
\* This is simple, please see this link for more information
[here](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac)
![Developer Cannot be verified](developer-cannot-be-verified.png
"Developer Cannot be verified")

## Help, My Mac says .app is damaged and can’t be opened

That is either due to a corrupt download so try again or [security
issues, please see this related FAQ
entry.](#help_my_mac_says_{{{ARRNAME}}}_cannot_be_opened_because_the_developer_cannot_be_verified "wikilink")

## How do I request a feature for ?

<span id="how_do_i_request_a_feature_for_{{{ARRNAME}}}"><small>[anchor](#how_do_i_request_a_feature_for_{{{ARRNAME}}} "wikilink")</small></span>  
This is an easy one click
\[<https://github.com/>//issues/new?assignees=\&labels=feature+request\&template=feature\_request.md\&title=
here\]

## I am getting an error: Database disk image is malformed

<span id="i_am_getting_an_error_database_disk_image_is_malformed"><small>[anchor](#i_am_getting_an_error_database_disk_image_is_malformed "wikilink")</small></span>  
\* This means your SQLite database that stores most of the information
for  is corrupt.

  -   - [Try restoring from a
        backup](#how_do_i_backup_restore_my_{{{ARRNAME}}} "wikilink")
      - You can follow [our instructions on this
        wiki.](Useful_Tools#Recovering_a_Corrupt_DB "wikilink")
      - Alternatively, there is guide here to copy the contents from the
        corrupt database into a new one:
        <http://techblog.dorogin.com/2011/05/sqliteexception-database-disk-image-is.html>

<!-- end list -->

  - This error may show if the database file is not writable by the
    user/group  is running as.

<!-- end list -->

  - Another possible cause of you getting an error with your Database is
    that you're placing your database on a network drive (nfs or smb or
    something else not local). Simple answer to this is to not do this
    as SQLite and network drives not typically play nice together and
    will cause a malformed database eventually. **'s config folder must
    be on a local drive**. If you're trying to restore your database you
    can check out our Backup/Restore guide
    [here](#Restoring_from_Backup "wikilink").

<!-- end list -->

  - If you are using mergerFS you need to remove `direct_io` as sqlite
    uses mmap which isn’t supported by `direct_io` as explained in the
    mergerFS [docs
    here](https://github.com/trapexit/mergerfs#plex-doesnt-work-with-mergerfs)

## I use  on a Mac and it suddenly stopped working. What happened?

<span id="i_use_{{{ARRNAME}}}_on_a_mac_and_it_suddenly_stopped_working_what_happened"><small>[anchor](#i_use_{{{ARRNAME}}}_on_a_mac_and_it_suddenly_stopped_working_what_happened "wikilink")</small></span>  
Most likely this is due to a MacOS bug which caused one of the 
databases to be corrupted.

[Follow these steps to
resolve](#i_am_getting_an_error_database_disk_image_is_malformed "wikilink")

Then attempt to launch  and see if it works. If it does not work, you'll
need further support. Post in our \[<http://reddit.com/r/> reddit\] or
hop on \[ discord\] for help.

## Why can’t  see my files on a remote server?

<span id="why_cant_{{{ARRNAME}}}_see_my_files_on_a_remote_server"><small>[anchor](#why_cant_{{{ARRNAME}}}_see_my_files_on_a_remote_server "wikilink")</small></span>  
In short: the user  is running as (if service) or under (if tray app)
cannot access the file path on the remote server. This can be for
various reasons, but the most common is,  is running as a service, which
causes one of two things:

  -  runs under the LocalService account by default which doesn’t have
    access to protected remote file shares.
      - **Solutions:**
          - Run ’s service as another user that has access to that share
              - Open the Administrative Tools \> Services window on your
                Windows server.
              - Stop the  service.
              - Open the Properties \> Log On dialog.
              - Change the service user account to the target user
                account.
          - Run .exe using the Startup Folder

<!-- end list -->

  - You’re using a mapped network drive (not a UNC path)
      - **Solutions:**
          - Change your paths to UNC paths (`\\server\share`)
          - Run .exe via the Startup Folder

## Mapped Network Drives vs UNC Paths

<span id="mapped_network_drives_vs_unc_paths"><small>[anchor](#mapped_network_drives_vs_unc_paths "wikilink")</small></span>  
\* Using mapped network drives generally doesn’t work very well,
especially when  is configured to run as a service. The better way to
set shares up is using UNC paths. So instead of `X:\Movies` use
`\\Server\Movies\`.

  - A key point to remember is that  gets path information from the
    downloader, so you’ll *also* need to setup NZBGet, SABNzbd or any
    other downloader to use UNC paths too.

## How do I change from the Windows Service to a Tray App?

<span id="how_do_i_change_from_a_service_to_tray_app"><small>[anchor](#how_do_i_change_from_a_service_to_tray_app "wikilink")</small></span>  
\# Shut  down

1.  Run serviceuninstall.exe that's in the  directory
2.  Run .exe as an administrator once to give it proper permissions and
    open the firewall. Once complete, then you can close it and run it
    normally.
3.  (Optional) Drop a shortcut to .exe in the startup folder to
    auto-start on boot.

## How do I Backup/Restore my ?

<span id="how_do_i_backup_restore_my_{{{ARRNAME}}}"><small>[anchor](#how_do_i_backup_restore_my_{{{ARRNAME}}} "wikilink")</small></span>  
\=== Backing up  ===

  - **Using built-in backup**

<!-- end list -->

1.  Go to System: Backup in the  UI
2.  Click the Backup button
3.  Download the zip after the backup is created for safekeeping

<center>

![Backup ](how-do-i-backup-restore-my-{{{ARRNAME}}}.gif "Backup ")

</center>

  - Using file system directly

<!-- end list -->

1.  Find the location of the AppData directory for 
      - Via the  UI go to System: About
      - [{{{ARRNAME}}} Appdata
        Directory]({{{ARRNAME}}}_Appdata_Directory "wikilink")
2.  Stop  - This will prevent the database from being corrupted
3.  Copy the contents to a safe location

### Restoring from Backup

*Restoring to an OS that uses different paths won’t work (Windows to
Linux, Linux to Windows, Windows to OS X or OS X to Windows), moving
between OS X and Linux may work, since both use paths containing `/`
instead of `\` that Windows uses, but is not supported.*

  - **Using zip backup**

<!-- end list -->

1.  Re-install 
2.  Run 
3.  Navigate to System \> Backup
4.  Select Restore Backup
5.  Select Choose File
6.  Select your backup zip file
7.  Select Restore

<center>

![{{{ARRNAME}}}-restore-using-zip-backup.gif]({{{ARRNAME}}}-restore-using-zip-backup.gif
"{{{ARRNAME}}}-restore-using-zip-backup.gif")

</center>

  - **Using file system backup**

<!-- end list -->

1.  Re-install 
2.  Run  once to get the AppData directory location
3.  Stop 
4.  Delete the contents of the AppData directory **(Including the
    .db-wal/.db-journal files if they exist)**
5.  Restore from your backup
6.  Start 
7.  As long as the paths are the same, everything will pick up where it
    left off

<!-- end list -->

  - **Restore for Synology NAS**

**CAUTION: Restoring on a Synology requires knowledge of Linux and Root
SSH access to the Synology Device.**

1.  Re-install   
2.  Run  once to get the AppData directory location  
3.  Stop   
4.  Connect to the Synology NAS through SSH and log in as root  
5.  Execute the following commands:
        rm -r /usr/local/{{{ARRNAME}}}/var/.config/{{{ARRNAME}}}/{{{ARRNAME}}}.db*
        cp -f /tmp/{{{ARRNAME}}}_backup/* /usr/local/{{{ARRNAME}}}/var/.config/{{{ARRNAME}}}/
6.  Update permissions on the files:
        cd /usr/local/{{{ARRNAME}}}/var/.config/{{{ARRNAME}}}/
        chown -R {{{ARRNAME}}}:users *
        chmod -R 0644 *
    On some installations, the user is different: `chown -R sc-``:`` 
    * `
7.  Start 

## Help I have locked my self out

<span id="help_i_have_locked_my_self_out"><small>[anchor](#help_i_have_locked_my_self_out "wikilink")</small></span>  
To disable authentication (to reset your username or password) you will
need need to edit `config.xml` which will be inside the [{{{ARRNAME}}}
Appdata Directory]({{{ARRNAME}}}_Appdata_Directory "wikilink").

1.  Open config.xml in a text editor
2.  Find the authentication method line will be

<!-- end list -->

  -   
    <AuthenticationMethod>`Basic`</AuthenticationMethod>  
    or
    <AuthenticationMethod>`Forms`</AuthenticationMethod>

<!-- end list -->

1.  Change the `AuthenticationMethod` line to
    <AuthenticationMethod>`None`</AuthenticationMethod>
2.  Restart 
3.   will now be accessible without a password, you should go the
    `Settings: General` in the  UI and set your username and password

## Help I have forgotten my password

<span id="help_i_have_forgotten_my_password"><small>[anchor](#help_i_have_forgotten_my_password "wikilink")</small></span>  
\* Please see steps listed in
[here](#help_i_have_locked_my_self_out "wikilink").

## Jackett shows more results than  when manually searching

<span id="jackett_shows_more_results_than_{{{ARRNAME}}}_when_manually_searching"><small>[anchor](#jackett_shows_more_results_than_{{{ARRNAME}}}_when_manually_searching "wikilink")</small></span>  
This is usually due to  searching Jackett differently than you do. [ See
this troubleshooting article for further
information]({{{ARRNAME}}}_Troubleshooting#Searches_Indexers_and_Trackers "wikilink").

## Weird UI Issues

<span id="weird_ui_issues"><small>[anchor](#wweird_ui_issues "wikilink")</small></span>  
\* If you experience any weird UI issues like the Library page not
listing anything or a certain view or sort not working, try viewing in a
Chrome Incognito Window or Firefox Private Window. If it works fine
there, clear your browser cache and cookies for your specific ip/domain.
For more information, see the [Clear Cache Cookies and Local
Storage](Clear_Cache_Cookies_and_Local_Storage "wikilink") wiki article.

## Web Interface Only Loads at localhost on Windows

<span id="web_interace_only_loads_at_localhost_on_windows"><small>[anchor](#web_interace_only_loads_at_localhost_on_windows "wikilink")</small></span>  
\* If you can only reach your web interface at <http://localhost>:/ or
<http://127.0.0.1>:, you need to run  as administrator at least once,
maybe even always.

## Permissions

<span id="permissions"><small>[anchor](#permissions "wikilink")</small></span>  
\*  will need to move files away from where the downloader puts them
into the final location, so this means that  will need to read/write to
both the source and the destination directory and files.

  - On Linux, where best practices have services running as their own
    user, this will probably mean using a shared group and setting
    folder permissions to `775` and files to `664` both in your
    downloader and . In umask notation, that would be `002`.

## System & Logs loads forever

<span id="system_and_logs_loads_forever"><small>[anchor](#system_and_logs_loads_forever "wikilink")</small></span>  
It's the easy-privacy blocklist. They basically block any url with
/api/log? in it. Look over the list and tell me if you think that
blocking all the urls in that list is a sensible idea, there are dozens
of urls in there that potentially break sites. You selected that in your
adblocker. Easy solution is to whitelist the domain Sonarr is running
on. But I still recommend checking the list.

## Finding Cookies

<span id="finding_cookies"><small>[anchor](#finding_cookies "wikilink")</small></span>  
Some sites cannot be logged into automatically and require you to login
manually then give the cookies to  to work. This page describes how you
do that.

  - Chrome ![Chrome cookies](chrome_cookies.png "Chrome cookies")
  - Firefox ![Firefox cookies](Firefox_cookies.png "Firefox cookies")

## Unpack Torrents

<span id="unpack_torrents"><small>[anchor](#unpack_torrents "wikilink")</small></span>  
Most torrent clients doesn’t come with the automatic handling of
compressed archives like their usenet counterparts. We recommend
[unpackerr](https://github.com/davidnewhall/unpackerr).

## uTorrent is no longer working

<span id="utorrent_is_no_longer_working"><small>[anchor](#utorrent_is_no_longer_working "wikilink")</small></span>  

1.  Ensure the Web UI is enabled

![Turn on Web UI](Utorrent-webui-setting.png "Turn on Web UI")

<li>

Ensure that the Alt Listening Port (Advanced -\> Web UI) is not the same
as the Listening Port (Connections)

</li>

<li>

We'd suggest changing the Web UI Alt Listening Port so as to not mess
with any port forwarding for connections.

</li>

![utorrent-webui-settings2.png](utorrent-webui-settings2.png
"utorrent-webui-settings2.png")  
![utorrent-webui-settings3.png](utorrent-webui-settings3.png
"utorrent-webui-settings3.png")

</ol>

## Does  require a SABnzbd post-processing script to import downloaded episodes?

<span id="does_{{{ARRNAME}}}_require_a_sabnzbd_post_processing_script_to_import_downloaded_episodes"><small>[anchor](#does_{{{ARRNAME}}}_require_a_sabnzbd_post_processing_script_to_import_downloaded_episodes "wikilink")</small></span>  
No.  will talk to your download client to determine where the files have
been downloaded and will import them automatically. If  and your
download client are on different machines you will need to use Remote
Path Mapping to link the remote path to a local one so  knows where to
find the files.

## I got a pop-up that said config.xml was corrupt, what now?

<span id="i_got_a_pop-up_that_said_config.xml_was_corrupt_what_now"><small>[anchor](#i_got_a_pop-up_that_said_config.xml_was_corrupt_what_now "wikilink")</small></span>  
was unable to read your config file on start-up as it became corrupted
somehow. In order to get  back online, you will need to delete `.xml` in
your [| AppData Folder]({{{ARRNAME}}}_Appdata_Directory "wikilink"),
once deleted start  and it will start on the default port (), you should
now re-configure any settings you configured on the General Settings
page.

## Invalid Certificate and other HTTPS or SSL issues

<span id="invalid_certificate_and_other_https_or_ssl_issues"><small>[anchor](#invalid_certificate_and_other_https_or_ssl_issues "wikilink")</small></span>  
Your download client stopped working and you're getting an error like
\`Localhost is an invalid certificate\`?

now validates SSL certificates. If there is no SSL certificate set in
the download client, or you're using a self-signed https certificate
without the CA certificate added to your local certificate store, then 
will refuse to connect. Free properly signed certificates are available
from [let's encrypt](https://letsencrypt.org/).

If your download client and  are on the same machine there is no reason
to use HTTPS, so the easiest solution is to disable SSL for the
connection. Most would agree it's not required on a local network
either. It is possible to disable certificate validation in advanced
settings if you want to keep an insecure SSL setup.

## VPNs, Jackett, and the \* ARRs

<span id="vpns_jackett_and_the_arrs"><small>[anchor](#vpns_jackett_and_the_arrs "wikilink")</small></span>  
Unless you're in a repressive country like China, Australia or South
Africa, your torrent client is typically the only thing that needs to be
behind a VPN. Because the VPN endpoint is shared by many users, you can
and will experience rate limiting, DDOS protection, and ip bans from
various services each software uses.

In other words, putting the \* Arrs (Lidarr, Radarr, Readarr, and
Sonarr) behind a VPN can and will make the applications unusable in some
cases due to the services not being accessible. **To be clear it is not
a matter if VPNs will cause issues with the \* Arrs, but when: image
providers will block you and cloudflare is in front of most of arr
servers (updates, metadata, etc.) and liable to block you too**

In addition, some private trackers \* ban\* for browsing from a VPN,
which is how Jackett works. In some cases (i.e. certain UK ISPs) it may
be needed to use a VPN for public trackers, in which case you should
then be putting only Jackett behind the VPN. However, you should not do
that if you have private trackers without checking their rules first.
**Many private trackers will ban you for using or accessing them (i.e.
using Jackett) via a VPN.**

## Jackett's /all Endpoint

<span id="jackett_all_endpoint"><small>[anchor](#jackett_all_endpoint "wikilink")</small></span>  
The Jackett `/all` endpoint is convenient, but that is its only benefit.
Everything else is potential problems, so adding each tracker
individually is recommended.

**May 2021 Update: It is likely  support will be phased out for the
jackett \`/all\` endpoint in the future due to the fact it only causes
issues.**

[Even Jackett says it should be avoided and should not be
used.](https://github.com/Jackett/Jackett#aggregate-indexers)

Using the all endpoint has no advantages (besides reduced management
overhead), only disadvantages:

  - you lose control over indexer specific settings (categories, search
    modes, etc.)
  - mixing search modes (IMDB, query, etc.) might cause low-quality
    results
  - indexer specific categories (\>= 100000) can't be used.
  - slow indexers will slow down the overall result
  - total results are limited to 1000

Adding each indexer separately It allows for fine tuning of categories
on a per indexer basis, which can be a problem with the `/all` end point
if using the wrong category causes errors on some trackers. In , each
indexer is limited to 1000 results if pagination is supported or 100 if
not, which means as you add more and more trackers to Jackett, you’re
more and more likely to clip results. Finally, if *one* of the trackers
in `/all` returns an error,  will disable it and now you don’t get any
results.

## Why are there two files? | Why is there a file left in downloads?

<span id="two_files"><small>[anchor](#two_files "wikilink")</small></span>  
This is expected. This is how the Torrent Process works with .

1.   will send a download request to your client, and associate it with
    a label or category name that you have configured in the download
    client settings. Examples: movies, tv, series, music, ect.
2.   will monitor your download clients active downloads that use that
    category name. This monitoring occurs via your download client's
    API.
3.  Completed files are left in their original location to allow you to
    seed the file (ratio or time can be adjusted in the download client
    or from within  under the specific download client). When files are
    imported to your media folder  will hardlink the file if supported
    by your setup or copy if not hardlinks are not supported.
      - Hardlinks are enabled by default. A hardlink will allow not use
        any additional disk space. The file system and mounts must be
        the same for your completed download directory and your media
        library. If the hardlink creation fails or your setup does not
        support hardlinks then  will fall back and copy the file.
4.  If the "Completed Download Handling - Remove" option is enabled in
    's settings,  will delete the original file and torrent from your
    client, but only if the client reports that seeding is complete and
    torrent is stopped.
