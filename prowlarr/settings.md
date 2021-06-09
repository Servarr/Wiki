---
title: Settings
description: 
published: true
date: 2021-06-09T03:19:23.696Z
tags: 
editor: markdown
dateCreated: 2021-06-06T15:04:48.057Z
---

This page will go through all the settings available in Prowlarr and how they work.  This is not meant to be a comprehensive "how to set up Prowlarr." If you want that, please use the [Quick Start](/prowlarr/quick-start-guide) page instead.

## Menu options

To get to the Settings page, please choose Settings from the left menu. The following sub-menu options will be available:

![settings_1_menu.png](/assets/prowlarr/settings_1_menu.png)

Also, note that for each individual settings page, there are some options at the top of the menu:

![settings_2_topmenu.png](/assets/prowlarr/settings_2_topmenu.png)

- Hide/Show advanced is important for any items that are marked below as `(Advanced Option)`, otherwise they will not show up. These menu items are shown in orange in the screenshots.

- You must save your changes before leaving the screen. You do that by clicking the disk icon. If you've made no changes, it will show "No Changes" and be grayed out, as shown above.

## Applications

Here is where you will add the applications that use Prowlarr (Radarr, Sonarr, Lidarr, Readarr, etc.) and how they stay in sync with Prowlarr.

Click on `Settings` -> `Apps`, and then click the `+` to add an arr program.

![addapps.png](/assets/prowlarr/addapps.png)

All programs you can add are listed. You should only add programs you currently have installed, and if you have multiple instances of them, you should add each of them separately.

![addlidarr.png](/assets/prowlarr/addlidarr.png)

- Enter a name for this indexer.
- Select your sync level for this indexer.

`Add and Remove Only` - When it is added or removed from Prowlarr, it will update this remote application.

`Full Sync` - When anything changes in this remote application, Prowlarr will keep it in sync. An example would be to delete from this remote application means Prowlarr will put it back.
>Currently Prowlarr is the true source so any in-app Customizations will be overridden.
{.is-warning}

`Disabled` will keep indexers from syncing with the program entirely.

- If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry. 
> NOTE that tags are NOT YET FUNCTIONAL!
{.is-warning}

- Enter the Prowlarr server URL here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you don't, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!
{.is-info}

- Enter the URL of your program here. Again, enter the full URL Base if used.

- Enter the API Key of your program here. You can get this from your program in the `Settings` / `General` tab, and copy/paste it here.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each program you'd like to sync with Prowlarr. If it fails, you will need to check your log for the error (URL, API Key, etc.).

## Download Clients (Prowlarr Searches)

> If you intend to do searches directly within Prowlarr, you need to add Download Clients. Otherwise, you do not need to add them here. For searches from your Apps, the download clients configured there are used instead.
{.is-info}

> Note: Prowlarr does not sync Download Clients to the Applications.
{.is-info}

Click on `Settings` -> `Download Clients`, and then click the `+` to add a new download client. Your download client should already be configured to follow this guide.

![downloadclients.png](/assets/prowlarr/downloadclients.png)

Prowlarr supports integration with the following Usenet download clients:

![usenetclients.png](/assets/prowlarr/usenetclients.png)

And the following Torrent clients:

![torrentclients.png](/assets/prowlarr/torrentclients.png)

Select the download client you wish to add, and there will be a pop-up box to enter connection details.  These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.

![nzbget.png](/assets/prowlarr/nzbget.png)

- Put in a friendly name for the client entry
- Click to enable or disable this download client
- Enter the hostname or IP address of the download client
- Enter the port of the download client
- Check this box if you use SSL to connect to your client.

> If this is an IP address or localhost, you DO NOT HAVE SSL. DO NOT CHECK THIS BOX.
{.is-info}

- (Advanced Option) If you're using a reverse proxy, enter the URL Base for the download client.
- Enter a username if you have one to connect to your client.
- Enter a password if you have one to connect to your client.
- Enter a category to be used with the download client for when you do grabs DIRECTLY from Prowlarr.
- Enter a priority for when you do grabs DIRECTLY from Prowlarr.
- Check this box to add downloads in a Paused state.
- (Advanced Option) Enter the client priority.

>Client priority only matters when 2 of the same type (usenet or torrent) are added. 1 is the highest priority, and if multiple clients of the same type exist and have the same priority, Prowlarr will alternate between then.
{.is-info}

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each download client you'd like Prowlarr to use. If it fails, you will need to check your log for the error (connection, credentials, etc.).

## Connect

Connections are used for notifications from Prowlarr.

![settings_connect.png](/assets/prowlarr/settings_connect.png)

Click on `Settings` -> `Connect`, and then click the `+` to add a new connection.

There are many notification options available:

![settings_notifications.png](/assets/prowlarr/settings_notifications.png)

Each one has different configuration options. If you're using notifications within any of the Applications, these should be set up the same way.

## Tags

Here is where you can maintain any existing tags you've used.

Click on `Settings` -> `Tags`. If you have any tags, they will appear here and you can delete them or edit them. If you have not applied tags anywhere in Prowlarr yet, this will show "no tags have been added yet" and there will be nothing to do in this page.

> Note that tags are not yet functional in Prowlarr!
{.is-warning}

## General

Here is where you will change generalized application settings such as port and logging level.

Click on `Settings` -> `General`.

> A lot of the options here can only be seen by clicking "Show Advanced" at the top of the screen. Any menu items in orange are hidden.
{.is-info}

### Host

![general_host.png](/assets/prowlarr/general_host.png)

- (Advanced Option) Bind Address - Leave this as `*` unless you need to change it.
- Port Number is the port that Prowlarr runs on. It must be unique and defaults to 9696.
- Enter a URL base here if you are using a reverse proxy.
- (Advanced Option) Check this box if you use an https address to connect to Prowlarr. If you are using `localhost` or an IP address, this should almost NEVER be checked.
- Check this box if you want a (default) browser window to be launched when Prowlarr starts.

### Security

![general_security.png](/assets/prowlarr/general_security.png)

- If you want to require a username/password, change this authentication box and enter them.
- Your API key is used by outside apps accessing Prowlarr.

> This is secret and should not be shared with anyone. If it gets shared, you should regenerate it and update your apps.
{.is-danger}

- This changes how certificate validation is performed.

### Proxy

![general_proxy.png](/assets/prowlarr/general_proxy.png)

- If you wish to use a proxy for all calls that Prowlarr makes, cehck the "Use Proxy" box.  When you do that, the next set of options will appear.
- Proxy Types supported are HTTP(s), Socks4, or Socks5.
- Hostname is the proxy hostname of your provider.
- Port is the port to use for proxy connections from your provider.
- Username is your proxy username from your provider.
- Password is your proxy password from your provider.
- If you want to bypass the proxy for some addresses, you can enter that list here.
- Check the box to bypass the proxy for local addresses.

### Logging

![general_logging.png](/assets/prowlarr/general_logging.png)

The default log level is `Info`. This is very basic logging. You can change it here for more detailed logging. Log files will rotate, so there is no danger of taking up too much space.

- `Info` logging is the minimum logging level. Good for day-to-day operations, but not sufficient for reporting errors to the dev team.
- `Debug` logging is a mid-range logging level. Good for some error resolution, but still not extremely detailed.  Contains all Info level logging as well.
- `Trace` logging is extremely detailed, and what the devs want when reporting errors. Due to the amount of logging done, a single log file may contain only a few minutes of logs. Contains all Debug and Info level logging as well.

### Analytics

![general_analytics.png](/assets/prowlarr/general_analytics.png)

Check the box to help the Prowlarr dev team gather statistics on install types, version, browser, and other information so that they can prioritize development and fixes properly.

### Updates

![general_updates.png](/assets/prowlarr/general_updates.png)

Select the development branch you would like to use here. (Advanced Option) Valid options are `master`, `develop`, and `nightly` and possibly other temporary testing branches as the dev group determines.

- <span style="color:#00ff00">master</span> (Default/Stable): It has been tested by users on the develop and nightly branches and it’s not known to have any major issues. On GitHub, this is the `master` branch. **Prowlarr does not yet have a stable release.**
  
- <span style="color:#00ff00">develop</span> (Beta): This is the testing edge. Released after tested in nightly to ensure no immediate issues. New features and bug fixes released here first.

> **Warning: You may not be able to go back to `master` after switching to this branch.** On GitHub, this is a snapshot of the `develop` branch at a point in time.
{.is-warning}

- <span style="color:#00ff00">nightly</span> (Nightly): The bleeding edge. Released as soon as code is committed and passed all automated tests. ***Use this branch only if you know what you are doing and are willing to get your hands dirty to recover a failed update.*** This version is updated immediately.
  
> **Warning: You may not be able to go back to `develop` after switching to this branch.** On GitHub, this is the `develop` branch.
{.is-warning}

- Note: If your install is through Docker append `:testing`, `:develop`, or `:nightly` to the end of your container tag depending on who makes your builds.

### Backups

![general_backups.png](/assets/prowlarr/general_backups.png)

- (Advanced Option) Folder is the folder where backups are stored.
- (Advanced Option) Interval is the number of days between automatic backups.
- (Advanced Option) This is the number of backups that are retained before being cleaned up.

> Manual backups are retained forever, stored in the same folder, and are named differently. It's always advised to make a backup manually before doing anything like updates or branch changes.
{.is-info}