---
title: Prowlarr Settings
description: 
published: true
date: 2021-11-29T18:56:06.579Z
tags: 
editor: markdown
dateCreated: 2021-06-06T15:04:48.057Z
---

This page will go through all the settings available in Prowlarr and how they work.  This is not meant to be a comprehensive "how to set up Prowlarr." If you want that, please use the [Quick Start](/prowlarr/quick-start-guide) page instead.

# Menu options

To get to the Settings page, please choose Settings from the left menu. The following sub-menu options will be available:

![settings_1_menu.png](/assets/prowlarr/settings_1_menu.png)

Also, note that for each individual settings page, there are some options at the top of the menu:

![settings_2_topmenu.png](/assets/prowlarr/settings_2_topmenu.png)

- Hide/Show advanced is important for any items that are marked below as `(Advanced Option)`, otherwise they will not show up. These menu items are shown in orange in the screenshots.

- You must save your changes before leaving the screen. You do that by clicking the disk icon. If you've made no changes, it will show "No Changes" and be grayed out, as shown above.

# Indexer Proxies

> Information on supported proxy types can be found [here](/prowlarr/supported#indexer-proxies)
{.is-info}

Here is where you can add proxies or Flaresolverr configurations for those indexers that require them.

Navigate to on `Settings` => `Indexer Proxies`, and then click the <kb>+<kb> to add a proxy.

![proxies.png](/assets/prowlarr/proxies.png)

- Name - Name of the Proxy in Prowlarr
- Tags - The tags for this proxy.  Proxies apply to all matching (same tag) indexers.  If blank this proxy applies to all indexers.

Proxy Specifc Settings and Supported Proxies:
  
- FlareSolverr
 - Host - the full host path (include http and the port) to your FlareSolverr instance
- HTTP
  - Host - the host address of your proxy
  - Port - the port of your proxy
  - Username - the username of your proxy
  - Password - the password of your proxy
- Socks4
  - Host - the host address of your proxy
  - Port - the port of your proxy
  - Username - the username of your proxy
  - Password - the password of your proxy
- Socks5
  - Host - the host address of your proxy
  - Port - the port of your proxy
  - Username - the username of your proxy
  - Password - the password of your proxy

# Applications

> Information on supported applications can be found [here](/prowlarr/supported#applications)
{.is-info}

Here is where you will add the applications that use Prowlarr (Radarr, Sonarr, Lidarr, Readarr, etc.) and how they stay in sync with Prowlarr.

Click on `Settings` => `Apps`, and then click the <kb>+<kb> to add an app.

![addapps.png](/assets/prowlarr/addapps.png)

All programs you can add are listed. You should only add programs you currently have installed, and if you have multiple instances of them, you should add each of them separately.

![addlidarr.png](/assets/prowlarr/addlidarr.png)

> Note: Indexers are synced based on the capibilities/categories they claim to support. If an indexer supports only `tv` categories it will be synced to Sonarr.
{.is-info}

- Name - Enter a name for this indexer.
- Sync Level - Select the sync level to use
  - `Add and Remove Only` - Sync the Indexer to the app when it is added or removed from Prowlarr. If the indexer is down at the time of sync - it will be removed.
  - `Full Sync` - Full Sync will keep your app and Prowlarr fully in sync. Any change made in Prowlarr is then synced to the other program. Any change made remotely will be overridden by Prowlarr on next sync.
  - `Disabled` - will keep indexers from syncing with the program entirely.
>`Full Sync` means Prowlarr will override any all including user selected categories. However, seed goals in \*Arrs are not currently factored in to this override.
{.is-danger}

- Tags - ~~If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry.~~

> **Note: Tags for apps are not yet functional**
{.is-warning}

- Prowlarr Server - Enter the Prowlarr server URL (including http, port, and baseurl if needed) as the app would access it here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you do not, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!{.is-info}

- Application Server -  Enter the App server URL (including http, port, and baseurl if needed) of your program here. Again, enter the full URL Base if used.

- API Key - Enter the API Key of your program here. For \*Arrs this can be found in Settings => General. You can get this from your program in the `Settings` => `General` tab, and copy/paste it here.
  
## Testing the Application

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each program you'd like to sync with Prowlarr. If it fails, you will need to check your log for the error (URL, API Key, etc.).

# Download Clients (Prowlarr Searches)

> Information on supported download clients can be found [here](/prowlarr/supported#download-clients)
{.is-info}

If you intend to do searches directly within Prowlarr, you need to add Download Clients. Otherwise, you do not need to add them here. For searches from your Apps, the download clients configured there are used instead.

> Prowlarr does not sync Download Clients to the Applications.
{.is-info}

Click on `Settings` => `Download Clients`, and then click the `+` to add a new download client. Your download client should already be configured to follow this guide.

![downloadclients.png](/assets/prowlarr/downloadclients.png)

- A list of supported download clients is located [here](/radarr/supported#downloadclient)

Select the download client you wish to add, and there will be a pop-up box to enter connection details.  These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.
  
> Client priority only matters when 2 of the same type (usenet or torrent) are added. 1 is the highest priority, and if multiple clients of the same type exist and have the same priority, Prowlarr will alternate between then.
{.is-info}

## Usenet Client Settings

- Name - The name of the download client within Prowlarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- API Key - the API key to authenticate to your client
- Username - the username to authenticate to your client (typically not needed)
- Password- the password to authenticate to your client (typically not needed)
- Category - the category within your download client that Prowlarr will use
- Priority - download client priority for added items
- Client Priority - Priority of the download client within Prowlarr. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

## Torrent Client Settings

- Name - The name of the download client within Prowlarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- Username - the username to authenticate to your client
- Password- the password to authenticate to your client
- Category - the category within your download client that Prowlarr will use
- Priority - download client priority for added items
- Initial State - Initial state for torrents
- Client Priority - Priority of the download client within Prowlarr. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

## Testing the Download Client

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each download client you'd like Prowlarr to use. If it fails, you will need to check your log for the error (connection, credentials, etc.).

# Notifications

> Information on supported notification providers can be found [here](/prowlarr/supported#notifications)
{.is-info}

Notifications are used for notifications from Prowlarr.

![settings_connect.png](/assets/prowlarr/settings_connect.png)

Click on `Settings` => `Notifications`, and then click the `+` to add a new connection.

There are many notification options available:

![settings_notifications.png](/assets/prowlarr/settings_notifications.png)

Each one has different configuration options. If you're using notifications within any of the Applications, these should be set up the same way.

# Tags

Here is where you can maintain any existing tags you've used.

Click on `Settings` => `Tags`. If you have any tags, they will appear here and you can delete them or edit them. If you have not applied tags anywhere in Prowlarr yet, this will show "no tags have been added yet" and there will be nothing to do in this page.

# General

Here is where you will change generalized application settings such as port and logging level.

Click on `Settings` => `General`.

> A lot of the options here can only be seen by clicking "Show Advanced" at the top of the screen. Any menu items in orange are hidden.
{.is-info}

## Host

![general_host.png](/assets/prowlarr/general_host.png)

- (Advanced Option) Bind Address - Leave this as `*` unless you need to change it.
- Port Number is the port that Prowlarr runs on. It must be unique and defaults to 9696.
- Enter a URL base here if you are using a reverse proxy.
- (Advanced Option) Check this box if you use an https address to connect to Prowlarr. If you are using `localhost` or an IP address, this should almost NEVER be checked.
- Check this box if you want a (default) browser window to be launched when Prowlarr starts.

## Security

![general_security.png](/assets/prowlarr/general_security.png)

- If you want to require a username/password, change this authentication box and enter them.
- Your API key is used by outside apps accessing Prowlarr.

> This is secret and should not be shared with anyone. If it gets shared, you should regenerate it and update your apps.
{.is-danger}

- This changes how certificate validation is performed.

## Proxy

![general_proxy.png](/assets/prowlarr/general_proxy.png)

- If you wish to use a proxy for all calls that Prowlarr makes, cehck the "Use Proxy" box.  When you do that, the next set of options will appear.
- Proxy Types supported are HTTP(s), Socks4, or Socks5.
- Hostname is the proxy hostname of your provider.
- Port is the port to use for proxy connections from your provider.
- Username is your proxy username from your provider.
- Password is your proxy password from your provider.
- If you want to bypass the proxy for some addresses, you can enter that list here.
- Check the box to bypass the proxy for local addresses.

## Logging

![general_logging.png](/assets/prowlarr/general_logging.png)

The default log level is `Info`. This is very basic logging. You can change it here for more detailed logging. Log files will rotate, so there is no danger of taking up too much space.

- `Info` logging is the minimum logging level. Good for day-to-day operations, but not sufficient for reporting errors to the development team.
- `Debug` logging is a mid-range logging level. Good for some error resolution, but still not extremely detailed.  Contains all Info level logging as well.
- `Trace` logging is extremely detailed, and what the Developers want when reporting errors. Due to the amount of logging done, a single log file may contain only a few minutes of logs. Contains all Debug and Info level logging as well.

## Analytics

![general_analytics.png](/assets/prowlarr/general_analytics.png)

Check the box to help the Prowlarr development team gather statistics on install types, version, browser, and other information so that they can prioritize development and fixes properly.

## Updates

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

## Backups

![general_backups.png](/assets/prowlarr/general_backups.png)

- (Advanced Option) Folder is the folder where backups are stored.
- (Advanced Option) Interval is the number of days between automatic backups.
- (Advanced Option) This is the number of backups that are retained before being cleaned up.

> Manual backups are retained forever, stored in the same folder, and are named differently. It's always advised to make a backup manually before doing anything like updates or branch changes.
{.is-info}
