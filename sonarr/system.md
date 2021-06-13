---
title: Sonarr System
description: 
published: true
date: 2021-06-13T05:58:54.342Z
tags: sonarr
editor: markdown
dateCreated: 2021-06-11T23:33:08.344Z
---

## Status

### Health

This page contains a list of health checks errors. These health checks are periodically performed performed by Sonarr and on certain events. The resulting warnings and errors are listed here to give advice on how to resolve them.

#### System Warnings

##### Currently installed .Net Framework is old and unsupported

Sonarr uses the .Net Framework. We need to build Sonarr against the lowest supported version still used by our users. Occasionally we increase the version we build against to be able to utilize new features. Apparently you haven't applied the appropriate Windows updates in a while and need to upgrade .Net to be able to use newer versions of Sonarr.

Upgrading the .Net Framework is very straightforward on Windows, although it often requires a restart. Please follow the instructions here.

##### Currently installed .Net Framework is supported but upgrading is recommended

Sonarr uses the .Net Framework. We need to build Sonarr against the lowest supported version still used by our users. Upgrading to newer versions allows us to build against newer versions and use new Framework features.

Upgrading the .Net Framework is very straightforward on Windows, although it often requires a restart. Please follow the instructions here.

##### Currently installed mono version is old and unsupported

Sonarr is written in .Net and requires Mono to run. Various versions of Sonarr have different minimum versions of Mono to operate correctly. The ideal version of Mono varies per platform.
Mono 5.8 is the absolute minimum for Sonarr, but Mono 5.20 is currently recommended.
The upgrade procedure for Mono varies per platform.

##### New update is available

Rejoice, the developers have released a new update. This generally means awesome new features and squashed piles of bugs (right?). Apparently you don�t have Auto-Updating enabled, so you�ll have to figure out how to update on your platform. Pressing the Install button on the System -> Updates page is probably a good starting point.

> This warning will not appear if your current version is less than 14 days old
{.is-info}

##### Cannot install update because startup folder is not writable by the user

This means Sonarr will be unable to update itself. You�ll have to update Sonarr manually or set the permissions on Sonarr�s Startup directory (the installation directory) to allow Sonarr to update itself.

##### Updating will not be possible to prevent deleting AppData on Update

Sonarr detected that AppData folder for your Operating System is located inside the directory that contains the Sonarr binaries. Normally it would be C:\ProgramData for Windows and, ~/.config for linux.

Please look at System -> Info to see the current AppData & Startup directories.
This means Sonarr will be unable to update itself without risking data-loss.
If you�re on linux, you�ll probably have to change the home directory for the user that is running Sonarr and copy the current contents of the ~/.config/Sonarr directory to preserve your database.

##### Failed to resolve the IP Address for the Configured Proxy Host

Review your proxy settings and ensure they are accurate
Ensure your proxy is up, running, and accessible

##### Proxy Failed Test

Your configured proxy failed to test successfully, review the HTTP error provided and/or check logs for more details.

##### System Time is off by more than 1 day

System time is off by more than 1 day. Scheduled tasks may not run correctly until the time is corrected
Review your system time and ensure it is synced to an authoritative time server and accurate

##### MediaInfo Library Could not be Loaded

MediaInfo Library could not be loaded.

##### Mono Legacy TLS enabled

Mono 4.x tls workaround still enabled, consider removing MONO_TLS_PROVIDER=legacy environment option

#### Download Clients

##### No download client is available

A properly configured and enabled download client is required for Sonarr to be able to download media. Since Sonarr supports different download clients, you should determine which best matches your requirements. If you already have a download client installed, you should configure Sonarr to use it and create a category. See Settings -> Download Client.

##### Unable to communicate with download client

Sonarr was unable to communicate with the configured download client. Please verify if the download client is operational and double check the url. This could also indicate an authentication error.
This is typically due to improperly configured download client. Things you can typically check:
Your download clients IP Address if its on the same bare metal machine this is typically 127.0.0.1
The Port number of that your download client is using these are filled out with the default port number but if you've changed it you'll need to have the same one entered into Sonarr.
Ensure SSL encryption is not turned on if you're using both your Sonarr instance and your download client on a local network. See the SSL FAQ entry for more information.

##### Download clients are unavailable due to failure

One or more of your download clients is not responding to requests made by Sonarr. Therefore Sonarr has decided to temporarily stop querying the download client on it�s normal 1 minute cycle, which is normally used to track active downloads and import finished ones. However, Sonarr will continue to attempt to send downloads to the client, but will in all likeliness fail.
You should inspect System->Logs to see what the reason is for the failures.
If you no longer use this download client, disable it in Sonarr to prevent the errors.

##### Enable Completed Download Handling

Sonarr requires Completed Download Handling to be able to import files that were downloaded by the download client. It is recommended to enable Completed Download Handling.
(Completed Download Handling is enabled by default for new users.)

##### Downloading into Root Folder

Within the application, a root folder is defined as the configured media library folder. You're downloading directly into your root (library) folder. This frequently causes issues and is not advised. To fix this change your download client so it is not placing downloads within your root folder. Please note that this check looks at all defined/configured root folders added not only root folders currently in use.

#### Completed/Failed Download Handling

##### Completed Download Handling is disabled

(This warning is only generated for existing users before when the Completed Download Handling feature was implemented. This feature is disabled by default to ensure the system continued to operate as expected for current configurations.)
It�s recommended to use Completed Download Handling since it provides better compatibility for the unpacking and post-processing logic of various download clients. With it, Sonarr will only import a download once the download client reports it as ready.
If you wish to enable Completed Download Handling you should verify the following: * Warning: Completed Download Handling only works properly if the download client and Sonarr are on the same machine since it gets the path to be imported directly from the download client otherwise a remote map is needed.

#### Indexers

##### No indexers available with automatic search enabled, Sonarr will not provide any automatic search results

Simply put you do not have any of your indexers set to allow automatic searches
Go into Settings > Indexers, select an indexer you'd like to allow Automatic Searches and then click save.

##### No indexers available with RSS sync enabled, Sonarr will not grab new releases automatically

So Sonarr uses the RSS feed to pick up new releases as they come along. More info on that here
To correct this issue go to Settings > Indexers, select an indexer you have and enable RSS Sync

##### No indexers are enabled

Sonarr requires indexers to be able to discover new releases. Please read the wiki on instructions how to add indexers.

#### Enabled indexers do not support searching

None of the indexers you have enabled support searching. This means Sonarr will only be able to find new releases via the RSS feeds. But searching for series (either Automatic Search or Manual Search) will never return any results. Obviously, the only way to remedy it is to add another indexer.

##### No indexers avaiable with Interactive Search Enabled

None of the indexers you have enabled support interactive searching. This means the application will only be able to find new releases via the RSS feeds or an automatic search.

##### Indexers are unavailable due to failures

Errors occurs while Sonarr tried to use one of your indexers. To limit retries, Sonarr will not use the indexer for an increasing amount of time (up to 24h).
This mechanism is triggered if Sonarr was unable to get a response from the indexer (could be dns, connection, authentication or indexer issue), or unable to fetch the nzb/torrent file from the indexer. Please inspect the logs to determine what kind of error causes the problem.
You can prevent the warning by disabling the affected indexer.
Run the Test on the indexer to force Sonarr to recheck the indexer, please note that the Health Check warning will not always disappear immediately.

#### Media

##### Series Removed from TheTVDB

The affected series were removed from TheTVDB, this usually happens because it is a duplicate or considered part of a different series. To correct you will need to remove the affected series and add the correct series.

##### Lists are unavailable due to failures

Typically this simply means that Sonarr is no longer able to communicate via API or via logging in to your chosen list provider. Your best bet if the problem persists is to contact them in order to rule them out, as their systems maybe overloaded from time to time.

### Disk Space

This section will show you available disk space
In docker this can be tricky as it will typically show you the available space within your Docker image

### About

This will tell you about your current install of Sonarr

### More Info

Home Page: Sonarr's home page
Wiki: You're here already
Reddit: r/sonarr
Discord: Join our discord
Donations: If you're feeling generous and would like to donate click here
Donations to Sonarr: If you're feeling generous and would like to donate to the project that started it all click here
Source: GitHub
Feature Requests: Got a great idea drop it here

## Tasks

### Scheduled

This page lists all scheduled tasks that Sonarr runs

- Application Check Update - This will run every on the displayed schedule in the UI, checking to see if Sonarr is on the most current version then triggering the update script to update Sonarr. Settings-> Update

> Note: If on Docker this will not update your container as a new image will need to be downloaded.
{.is-warning}

- Backup - This will run a backup of your Sonarr's database on a set schedule more details on this can be found here. More information about backups can be found System -> Backups.
- Check Health - Check Health will run on the displayed schedule in the UI checking the overall health of your Sonarr. To see a list of possible health related issues see the Wiki Entry on Health Checks.
- Clean Up Recycle Bin - The recycling bin will be cleared out on the displayed schedule in the UI. This will only be used if the recycling bin is set in File Management
- Housekeeping - On the displayed schedule in the UI this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
- Import List Sync - On the displayed schedule in the UI this will run your Lists and import any possible new series. More info about lists can be found Settings -> Lists.
- Messaging Cleanup - On the displayed schedule in the UI this cleans up those messages that appear in the bottom left corner of Sonarr
- Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under Activity. Essentially pinging your download client to check for finished downloads.
- Refresh Series - This goes through and refreshes all the metadata for all monitored and unmonitored series
- Rss Sync - This will run the RSS Sync. This can be changed in settings -> options. More information on the RSS function can be found on our FAQ
  
> All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.
{.is-info}

### Queue

The queue will show you upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

## Backup

> This section will be more tailored to the buttons and overall point of the page.
> However, if you're looking for how to back/restore your Sonarr instance click [here](/sonarr/faq).
{.is-info}

Within the Backup section you'll be presented with previous backups (unless you have a fresh install that hasn't made any backups).
  
Here you'll have two options at the top of the screen

- Backup Now - This option will trigger a manual backup of your Sonarr's database
- Restore Backup - This will open a new screen to restore from a previous backup
By selecting Choose File this will prompt your browser to open a dialog box to restore from a Sonarr Zip backup
  
Finally if you have any previous backups and would like to download them from Sonarr to be placed in a non standard location you simply can select one of these files to download them
Off to the right of each of the previous download you have two options.

- One - To restore from a previous backup - This will open a new window to confirm you want to restore from this backup
- Two - To delete a previous backup

## Updates

The update screen will show the past 5 updates that have been made as well as the current version you are on.
This page will also display the update notes from the Devs telling you what has been fixed or added to Sonarr (Rejoice!)
  
> A Maintenance Release contains bug fixes and other various improvements. Take a look at the commit history for specifics.
{.is-info}

## Events

The events tab will show you what has been happening within your Sonarr. This can be used to diagnose some light issues. However, this does not replace Trace Logs discussed in Logging. Events are the equivalent of INFO Logs.

- Components - This column will tell you what component within Sonarr has been triggered
- Message - This column will tell you what message as been sent from the component from the previous column.
- Gear Icon - This option will allow you to change how many Components/Messages are displayed per page (Default is 50)
- Options at the top of the page
  - Refresh - This option will refresh the current page, pulling a new events log
  - Clear - This will clear the current events log allowing you to start from fresh

## Log Files

This page will allow you to download and see what current log files are available for Sonarr

On the top row there are several options to allow you to control your log files.

- The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
  - Log Files - The bread and butter of any support issue more on log files can be found here.
  - Updater Log Files - This will show the log files associated with Sonarr's updater script

> If you're on docker this will be empty as you should be updating by downloading a new docker image
{.is-info}

- Refresh - This will refresh the current page and display any newly created logs
- Delete - This will clear all logs allowing you to start from fresh
- File Name - This will display the file name associated with the log
- Last Written - This is the local time that this particular log file was written to.
  - Sonarr uses rolling log files limited to 1MB each. The current log file is always sonarr.txt, for the the other files sonarr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains fatal, error, warn, and info entries.
  - When Debug log level is enabled, additional sonarr.debug.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, and debug entries. It usually covers a ~40h period.
  - When Trace log level is enabled, additional sonarr.trace.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, debug, and trace entries. Due to trace verbosity it only covers a couple of hours at most.
