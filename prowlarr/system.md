---
title: Prowlarr System
description: 
published: true
date: 2021-08-24T02:43:10.308Z
tags: prowlarr, system
editor: markdown
dateCreated: 2021-08-03T21:21:08.969Z
---

## Status

### Health

This page contains a list of health checks errors. These health checks are periodically performed performed by Prowlarr and on certain events. The resulting warnings and errors are listed here to give advice on how to resolve them.

#### System Warnings

##### Branch is not a valid release branch

- The branch you have set is not a valid release branch. You will not receive updates. Please change to one of the current release branches.

##### Currently installed SQLite version is not supported

- Prowlarr stores its data in an SQLite database. The SQLite3 library installed on your system is too old. Prowlarr requires at least version 3.9.0. Note that Prowlarr uses `libSQLite3.so` which may or may not be contained in a SQLite3 upgrade package.

##### New update is available

- Rejoice, the developers have released a new update. This generally means awesome new features and squashed piles of bugs (right?). Apparently you don’t have Auto-Updating enabled, so you’ll have to figure out how to update on your platform. Pressing the Install button on the System => Updates page is probably a good starting point.

> This warning will not appear if your current version is less than 14 days old
{.is-info}

##### Cannot install update because startup folder is not writable by the user

- This means Prowlarr will be unable to update itself. You’ll have to update Prowlarr manually or set the permissions on Prowlarr’s Startup directory (the installation directory) to allow Prowlarr to update itself.

##### Updating will not be possible to prevent deleting AppData on Update

- Prowlarr detected that AppData folder for your Operating System is located inside the directory that contains the Prowlarr binaries. Normally it would be C:\ProgramData for Windows and, ~/.config for linux.

- Please look at System => Info to see the current AppData & Startup directories.
- This means Prowlarr will be unable to update itself without risking data-loss.
- If you’re on linux, you’ll probably have to change the home directory for the user that is running Prowlarr and copy the current contents of the ~/.config/Prowlarr directory to preserve your database.

##### Branch is for a previous version

- The update branch setup in Settings/General is for a previous version of Prowlarr, therefore the instance will not see correct update information in the System/Updates feed and may not receive new updates when released.

##### Could not connect to signalR

- signalR drives the dynamic UI updates, so if your browser cannot connect to signalR on your server you won’t see any real time updates in the UI.

- The most common occurrence of this is use of a reverse proxy or cloudflare
  - Cloudflare needs websockets enabled.
  - Nginx requires the following addition to the location block for the app:

```none
 proxy_http_version 1.1;
 proxy_set_header Upgrade $http_upgrade;
 proxy_set_header Connection $http_connection;
```

> Make sure you do not include proxy_set_header Connection "Upgrade"; as suggested by the nginx documentation. THIS WILL NOT WORK
> See <https://github.com/aspnet/AspNetCore/issues/17081>
{.is-warning}

- For Apache2 reverse proxy, you need to enable the following modules: proxy, proxy_http, and proxy_wstunnel. Then, add this websocket tunnel directive to your vhost configuration:

```none
RewriteEngine On
RewriteCond %{HTTP:Upgrade} =websocket [NC]
RewriteRule /(.*) ws://127.0.0.1:9696/$1 [P,L]
```

- For Caddy (V1) use this:

> Note: you will also need to add the websocket directive to your prowlarr configuration{.is-info}

```none
 proxy /prowlarr 127.0.0.1:9696 {
     websocket
     transparent
 }
```

##### Failed to resolve the IP Address for the Configured Proxy Host

- Review your proxy settings and ensure they are accurate
- Ensure your proxy is up, running, and accessible

##### Proxy Failed Test

- Your configured proxy failed to test successfully, review the HTTP error provided and/or check logs for more details.

##### System Time is off by more than 1 day

- System time is off by more than 1 day. Scheduled tasks may not run correctly until the time is corrected
- Review your system time and ensure it is synced to an authoritative time server and accurate

#### Download Clients

##### No download client is available

- A properly configured and enabled download client is required for Prowlarr to be able to download media. Since Prowlarr supports different download clients, you should determine which best matches your requirements. If you already have a download client installed, you should configure Prowlarr to use it and create a category. See Settings => Download Client.

##### Unable to communicate with download client

- Prowlarr was unable to communicate with the configured download client. Please verify if the download client is operational and double check the url. This could also indicate an authentication error.
- This is typically due to improperly configured download client. Things you can typically check:
- Your download clients IP Address if its on the same bare metal machine this is typically 127.0.0.1
- The Port number of that your download client is using these are filled out with the default port number but if you've changed it you will need to have the same one entered into Prowlarr.
- Ensure SSL encryption is not turned on if you're using both your Prowlarr instance and your download client on a local network. See the SSL FAQ entry for more information.

##### Download clients are unavailable due to failure

- One or more of your download clients is not responding to requests made by Prowlarr. Therefore Prowlarr has decided to temporarily stop querying the download client on it’s normal 1 minute cycle, which is normally used to track active downloads and import finished ones. However, Prowlarr will continue to attempt to send downloads to the client, but will in all likeliness fail.
- You should inspect System=>Logs to see what the reason is for the failures.
- If you no longer use this download client, disable it in Prowlarr to prevent the errors.

##### Bad Download Client Settings

- The location your download client is downloading files to is causing problems. Check the logs for further information. This may be permissions or attempting to go from Windows to Linux or Linux to Windows without a remote path map.

#### Indexers

##### No indexers are enabled

- Prowlarr requires indexers to be able to discover new releases. Please read the wiki instructions how to add indexers.

##### Indexers are unavailable due to failures

- (An) Error(s) occur(s) while Prowlarr tried to use one of your indexers. To limit retries, Prowlarr will not use the indexer for an increasing amount of time (up to 24h).
- This mechanism is triggered if Prowlarr was unable to get a response from the indexer (could be caused DNS, proxy/vpn connection, authentication, or an indexer issue), or unable to fetch the nzb/torrent file from the indexer. Please inspect the logs to determine what kind of error causes the problem.
- You can prevent the warning by disabling the affected indexer.
- Run the Test on the indexer to force Prowlarr to recheck the indexer, please note that the Health Check warning will not always disappear immediately.

##### Indexer VIP Expiring

- Your VIP subscription or benefits to your indexer expire within the next 7 days or less based on the expiration date you configured for your indexer in Prowlarr.

##### Indexer VIP Expired

- Your VIP subscription or benefits to your indexer have expired based on the expiration date you configured into for indexer in Prowlarr.

#### Applications

##### Applications are unavailable due to failures

- (An) Error(s) occur(s) while Prowlarr tried to use one of your applications. To limit retries, Prowlarr will not use the application for an increasing amount of time (up to 24h).
- This mechanism is triggered if Prowlarr was unable to get a response from the application (could be dns, connection, authentication, or application issue). Please inspect the logs to determine what kind of error causes the problem.
- Prowlarr will be unable to sync to the application and it is more than likely the application will be unable to use Prowlarr's indexers.
- You can prevent the warning by disabling the affected application.
- Run the Test on the application to force Prowlarr to recheck the application, please note that the Health Check warning will not always disappear immediately.

### Disk Space

This section will show you available disk space
In docker this can be tricky as it will typically show you the available space within your Docker image

### About

This will tell you about your current install of Prowlarr

### More Info

Home Page: Prowlarr's home page
Wiki: You're here already
Reddit: r/prowlarr
Discord: Join our discord
Donations: If you're feeling generous and would like to donate click here
Donations to Sonarr: If you're feeling generous and would like to donate to the project that started it all click here
Source: GitHub
Feature Requests: Got a great idea drop it here

## Tasks

### Scheduled

This page lists all scheduled tasks that Prowlarr runs

- Application Check Update - This will run every on the displayed schedule in the UI, checking to see if Prowlarr is on the most current version then triggering the update script to update Prowlarr. Settings=> Update

> Note: If on Docker this will not update your container as a new image will need to be downloaded.
{.is-warning}

- Backup - This will run a backup of your Prowlarr's database on a set schedule more details on this can be found here. More information about backups can be found System => Backups.
- Check Health - Check Health will run on the displayed schedule in the UI checking the overall health of your Prowlarr. To see a list of possible health related issues see the Wiki Entry on Health Checks.
- Housekeeping - On the displayed schedule in the UI this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
- Messaging Cleanup - On the displayed schedule in the UI this cleans up those messages that appear in the bottom left corner of Prowlarr
  
> All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.
{.is-info}

### Queue

The queue will show you upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

## Backup

> This section will be more tailored to the buttons and overall point of the page.
> However, if you're looking for how to back/restore your Prowlarr instance [see our FAQ](/prowlarr/faq).
{.is-info}

Within the Backup section you will be presented with previous backups (unless you have a fresh install that hasn't made any backups).
  
Here you will have two options at the top of the screen

- Backup Now - This option will trigger a manual backup of your Prowlarr's database
- Restore Backup - This will open a new screen to restore from a previous backup
By selecting Choose File this will prompt your browser to open a dialog box to restore from a Prowlarr Zip backup
  
Finally if you have any previous backups and would like to download them from Prowlarr to be placed in a non standard location you simply can select one of these files to download them
Off to the right of each of the previous download you have two options.

- One - To restore from a previous backup - This will open a new window to confirm you want to restore from this backup
- Two - To delete a previous backup

## Updates

The update screen will show the past 5 updates that have been made as well as the current version you are on.
This page will also display the update notes from the Developers telling you what has been fixed or added to Prowlarr (Rejoice!)
  
> A Maintenance Release contains bug fixes and other various improvements. Take a look at the commit history for specifics.
{.is-info}

## Events

The events tab will show you what has been happening within your Prowlarr. This can be used to diagnose some light issues. However, this does not replace Trace Logs discussed in Logging. Events are the equivalent of INFO Logs.

- Components - This column will tell you what component within Prowlarr has been triggered
- Message - This column will tell you what message as been sent from the component from the previous column.
- Gear Icon - This option will allow you to change how many Components/Messages are displayed per page (Default is 50)
- Options at the top of the page
  - Refresh - This option will refresh the current page, pulling a new events log
  - Clear - This will clear the current events log allowing you to start from fresh

## Log Files

This page will allow you to download and see what current log files are available for Prowlarr

On the top row there are several options to allow you to control your log files.

- The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
  - Log Files - The bread and butter of any support issue more on log files can be found here.
  - Updater Log Files - This will show the log files associated with Prowlarr's updater script

> If you're on docker this will be empty as you should be updating by downloading a new docker image
{.is-info}

- Refresh - This will refresh the current page and display any newly created logs
- Delete - This will clear all logs allowing you to start from fresh
- File Name - This will display the file name associated with the log
- Last Written - This is the local time that this particular log file was written to.
  - Prowlarr uses rolling log files limited to 1MB each. The current log file is always prowlarr.txt, for the the other files prowlarr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains `fatal`, `error`, `warn`, and `info` entries.
  - When Debug log level is enabled, additional prowlarr.debug.txt rolling log files will be present, up to 51 files. This log files contains `fatal`, `error`, `warn`, `info`, and `debug` entries. It usually covers a ~40h period.
  - When Trace log level is enabled, additional prowlarr.trace.txt rolling log files will be present, up to 51 files. This log files contains `fatal`, `error`, `warn`, `info`, `debug`, and `trace` entries. Due to trace verbosity it only covers a couple of hours at most.
