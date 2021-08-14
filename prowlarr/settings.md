---
title: Prowlarr Settings
description: 
published: true
date: 2021-08-11T19:38:43.523Z
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
## Indexers

Here is where you can add proxies or Flaresolverr configurations for those indexers that require them.

Click on `Settings` -> `Indexers`, and then click the `+` to add a proxy.

![proxies.png](/assets/prowlarr/proxies.png)

Configuring HTTP, SOCKS4, or SOCKS5 proxies are all the same. Enter a name, the hostname/port/userid/password of your proxy server into the appropriate boxes. If you want this to apply to only a specific subset of your indexers, then enter a TAG name here (and then apply that TAG to your indexers you want it to apply to).

Configuring a Flaresolverr server requires you to enter the hostname:port of your Flaresolver installation (which can be found [here](https://github.com/FlareSolverr/FlareSolverr)). Again, applying a TAG allows you to only use Flaresolverr on those indexers which require its use.

## Applications

Here is where you will add the applications that use Prowlarr (Radarr, Sonarr, Lidarr, Readarr, etc.) and how they stay in sync with Prowlarr.

Click on `Settings` -> `Apps`, and then click the `+` to add an *arr program.

![addapps.png](/assets/prowlarr/addapps.png)

All programs you can add are listed. You should only add programs you currently have installed, and if you have multiple instances of them, you should add each of them separately.

![addlidarr.png](/assets/prowlarr/addlidarr.png)

- Enter a name for this indexer.
- Select your sync level for this indexer.

> Note: Indexers are synced based on the capibilities/categories they claim to support. If an indexer supports only `tv` categories it will be synced to Sonarr.
{.is-info}

`Add and Remove Only` - When it is added or removed from Prowlarr, it will update your app.

`Full Sync` - Full Sync will keep your app and Prowlarr fully in sync. Any change made in Prowlarr is then synced to the other program (and to any other program that has Full Sync selected!) Any change made remotely will be overridden by Prowlarr on next sync.
>`Full Sync` means Prowlarr will override any in-app customizations including user selected categories.
{.is-danger}

`Disabled` will keep indexers from syncing with the program entirely.

- ~~If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry.~~

> **Note: tags are not yet functional**
{.is-warning}

- Enter the Prowlarr server URL here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you do not, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!
{.is-info}

- Enter the URL of your program here. Again, enter the full URL Base if used.

- Enter the API Key of your program here. You can get this from your program in the `Settings` / `General` tab, and copy/paste it here.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each program you'd like to sync with Prowlarr. If it fails, you will need to check your log for the error (URL, API Key, etc.).

## Download Clients (Prowlarr Searches)

> If you intend to do searches directly within Prowlarr, you need to add Download Clients. Otherwise, you do not need to add them here. For searches from your Apps, the download clients configured there are used instead.
{.is-info}
---
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

> Client priority only matters when 2 of the same type (usenet or torrent) are added. 1 is the highest priority, and if multiple clients of the same type exist and have the same priority, Prowlarr will alternate between then.
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

- `Info` logging is the minimum logging level. Good for day-to-day operations, but not sufficient for reporting errors to the development team.
- `Debug` logging is a mid-range logging level. Good for some error resolution, but still not extremely detailed.  Contains all Info level logging as well.
- `Trace` logging is extremely detailed, and what the Developers want when reporting errors. Due to the amount of logging done, a single log file may contain only a few minutes of logs. Contains all Debug and Info level logging as well.

### Analytics

![general_analytics.png](/assets/prowlarr/general_analytics.png)

Check the box to help the Prowlarr development team gather statistics on install types, version, browser, and other information so that they can prioritize development and fixes properly.

### Updates

![general_updates.png](/assets/prowlarr/general_updates.png)

- Branch - This is the branch of Prowlarr that you are running on.
  - [Please see this FAQ entry for more information](/prowlarr/faq#how-do-i-update-prowlarr)
- Automatic - Automatically download and install updates. You will still be able to install from System: Updates. Note: Windows Users are always automatically updated.
- Mechanism - Use Prowlarr built-in updater or a script
  - Built-in - Use Prowlarr's own updater
  - Script - Have Prowlarr run the update script
  - Docker - Do not update Prowlarr from inside the Docker, instead pull a brand new image with the new update
- Script - Visible only when Mechanism is set to Script - Path to update script
- Update Process - Prowlarr will download the update file, verify its integrity and extract it to a temporary location and call the chosen method. The update process will be be run under the same user that Prowlarr is run under, it will need permissions to update the Prowlarr files as well as stop/start Prowlarr.
- Built-in - The built-in method will backup Prowlarr files and settings, stop Prowlarr, update the installation and Start Prowlarr, if your system will not handle the stopping of Prowlarr and will attempt to restart it automatically it may be best to use a script instead. In the event of failure the previous version of Prowlarr will be restarted.
- Script - The script should handle the the same as the built-in updater, if you need to handle stopping and starting services (upstart/launchd/etc) you will need to do that here.

### Backups

![general_backups.png](/assets/prowlarr/general_backups.png)

- (Advanced Option) Folder is the folder where backups are stored.
- (Advanced Option) Interval is the number of days between automatic backups.
- (Advanced Option) This is the number of backups that are retained before being cleaned up.

> Manual backups are retained forever, stored in the same folder, and are named differently. It's always advised to make a backup manually before doing anything like updates or branch changes.
{.is-info}
