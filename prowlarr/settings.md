---
title: Prowlarr Settings
description: 
published: true
date: 2022-05-15T14:28:08.121Z
tags: 
editor: markdown
dateCreated: 2021-06-06T15:04:48.057Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Menu options](#menu-options)
- [Indexer Proxies](#indexer-proxies)
  - [Proxy Settings](#proxy-settings)
  - [FlareSolverr Proxy Settings](#flaresolverr-proxy-settings)
  - [HTTP Proxy Settings](#http-proxy-settings)
  - [Socks4 Proxy Settings](#socks4-proxy-settings)
  - [Socks5 Proxy Settings](#socks5-proxy-settings)
- [Applications](#applications)
  - [Application Settings](#application-settings)
  - [Testing the Application](#testing-the-application)
- [Download Clients (Prowlarr Searches)](#download-clients-prowlarr-searches)
  - [Usenet Client Settings](#usenet-client-settings)
  - [Torrent Client Settings](#torrent-client-settings)
  - [Testing the Download Client](#testing-the-download-client)
- [Notifications](#notifications)
  - [Connections](#connections)
  - [Notification Triggers](#notification-triggers)
- [Tags](#tags)
- [General](#general)
  - [Host](#host)
  - [Security](#security)
  - [Proxy](#proxy)
  - [Logging](#logging)
  - [Analytics](#analytics)
  - [Updates](#updates)
  - [Backups](#backups)
- [UI](#ui)
  - [Dates](#dates)
  - [Style](#style)
  - [Language](#language)
  
This page will go through all the settings available in Prowlarr and how they work. This is not meant to be a comprehensive "how to set up Prowlarr." If you want that, please use the [Quick Start](/prowlarr/quick-start-guide) page instead.

# Menu options

To get to the Settings page, please choose Settings from the left menu. The following sub-menu options will be available:

![settings_1_menu.png](/assets/prowlarr/settings_1_menu.png)

Also, note that for each individual settings page, there are some options at the top of the menu:

![settings_2_topmenu.png](/assets/prowlarr/settings_2_topmenu.png)

- Hide/Show advanced is important for any items that are marked below as `(Advanced Option)`, otherwise they will not show up. These menu items are shown in orange in the screenshots.

- You must save your changes before leaving the screen. You do that by clicking the disk icon. If you've made no changes, it will show "No Changes" and be grayed out, as shown above.

# Indexer Proxies

> Information on supported proxy types can be found at the following page [supported](/prowlarr/supported#indexer-proxies)
{.is-info}

Here is where you can add proxies or Flaresolverr configurations for those indexers that require them.

Navigate to on `Settings` => `Indexer Proxies`, and then click the <kb>+</kb> to add a proxy.

![proxies.png](/assets/prowlarr/proxies.png)

## Proxy Settings
  
- Name - Name of the Proxy in Prowlarr
- Tags - The tags for this proxy. Proxies apply to all matching (same tag) indexers. If blank this proxy applies to all indexers.

## FlareSolverr Proxy Settings

- Host - the full host path (include http and the port) to your FlareSolverr instance
- (Advanced Setting) Request Timeout (seconds) - the [FlareSolver Request `maxTimeout` value](https://github.com/FlareSolverr/FlareSolverr#-requestget) Prowlarr should use for FlareSolverr requests. Must be between `1` second and `180` seconds (Default: `60` seconds)

> \* A FlareSolverr Proxy will only be used for requests if and only if Cloudflare is detected by Prowlarr
> \* A FlareSolverr Proxy will only be used for requests if and only if the Proxy and the Indexer have matching tags
> \* **A Flaresolverr Proxy configured without any tags or has no indexers with matching tags it will be disabled.**
{.is-info}

## HTTP Proxy Settings

- Host - the host address of your proxy
- Port - the port of your proxy
- Username - the username of your proxy
- Password - the password of your proxy

## Socks4 Proxy Settings

- Host - the host address of your proxy
- Port - the port of your proxy
- Username - the username of your proxy
- Password - the password of your proxy

## Socks5 Proxy Settings

- Host - the host address of your proxy
- Port - the port of your proxy
- Username - the username of your proxy
- Password - the password of your proxy

# Applications

> Information on supported applications can be found at the following page [supported](/prowlarr/supported#applications)
{.is-info}

Here is where you will add the applications that use Prowlarr (Radarr, Sonarr, Lidarr, Readarr, etc.) and how they stay in sync with Prowlarr.

- Click on `Settings` => `Apps`, and then click the <kb>+</kb> to add an app.
- Sync App Indexers - Trigger a sync of all indexers to all applications
- Test All Apps - Trigger a test of all applications
  
![addapps.png](/assets/prowlarr/addapps.png)

All programs you can add are listed. You should only add programs you currently have installed, and if you have multiple instances of them, you should add each of them separately.

![addlidarr.png](/assets/prowlarr/addlidarr.png)

> Note: Indexers are synced based on the capabilities/categories they claim to support. If an indexer supports only `tv` categories it will not be synced to Lidarr, Radarr, and Readarr. It will only be synced to Sonarr "Supported" Categories can be selected as an advanced setting on a per app basis. **Also note that the \*Arrs only accept indexers whose test queries return results containing at least one of the configured categories.**
{.is-info}

## Application Settings

Application Settings are where Sync Profiles are configured

- Name - Enter a name for this App.
- Sync Level - Select the sync level to use
  - `Add and Remove Only` - When indexers are added or removed from Prowlarr, it will update this remote app. If the indexer is down at the time of sync - it will be disabled on the remote app.
  - `Full Sync` - Full Sync will keep this app's indexers fully in sync. Changes made to indexers in Prowlarr are then synced to this app. Any change made to indexers remotely within this app will be overridden by Prowlarr on the next sync. A list of factors used to compare and determine if a sync should occur can be found in the [FAQ](/prowlarr/faq#what-arr-indexer-settings-are-compared-for-app-full-sync)
  - `Disabled` - will keep indexers from syncing with the program entirely.

> `Full Sync` means Prowlarr will override any all including user selected categories. However, tags in \*Arrs are not currently factored in to this comparison to trigger a sync. However, [just about every other factor of changes](/prowlarr/faq#what-arr-indexer-settings-are-compared-for-app-full-sync) will trigger a sync and overwrite all settings in \*Arr
{.is-danger}

- Tags - If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry.
- Prowlarr Server - Enter the Prowlarr server URL (including http, port, and baseurl if needed) as the app would access it here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you do not, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!{.is-info}

- Application Server -  Enter the App server URL (including http, port, and baseurl if needed) of your program here. Again, enter the full URL Base if used.
- API Key - Enter the API Key of your program here. For \*Arrs this can be found in Settings => General. You can get this from your program in the `Settings` => `General` tab, and copy/paste it here.
- (Advanced Setting) Sync Categories - Select the categories to sync to this app. Indexers that support these categories will be synced.
  
## Testing the Application

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each program you'd like to sync with Prowlarr. If it fails, you will need to check your log for the error (URL, API Key, etc.).

## Sync Profiles

Configure the sync profiles for to use for (an) application(s)

> You can have different settings per app by creating multiple instances of the indexer
{.is-info}

- Name - Unique name of the Sync Profile
- Enable RSS - For Indexers with this profile, Enable RSS Searches/Queries for the \*Arr App
- Enable Interactive Search - For Indexers with this profile, Enable Interactive (Manual) Searches for the \*Arr App
- Enable Automatic Search - For Indexers with this profile, Enable Automatic Searches for the \*Arr App
- Minimum Seeders - For Indexers with this profile, the minimum seeders required for \*Arr to grab a torrent

# Download Clients (Prowlarr Searches)

{#download-clients}

> Information on supported download clients can be found at the following page [supported](/prowlarr/supported#download-clients)
{.is-info}

If you intend to do searches directly within Prowlarr, you need to add Download Clients. Otherwise, you do not need to add them here. For searches from your Apps, the download clients configured there are used instead.

> Prowlarr does not sync Download Clients to the Applications.
{.is-info}

Click on `Settings` => `Download Clients`, and then click the <kb>+</kb> to add a new download client. Your download client should already be configured to follow this guide.

![downloadclients.png](/assets/prowlarr/downloadclients.png)

Select the download client you wish to add, and there will be a pop-up box to enter connection details. These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.
  
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
- Port - The port of your download client; this is typically the webgui port
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- Username - the username to authenticate to your client
- Password- the password to authenticate to your client
- Category - the category within your download client that Prowlarr will use
- Priority - download client priority for added items
- Initial State - Initial state for torrents (Qbittorrent Only: Forced bypasses all seed thresholds)
- Client Priority - Priority of the download client within Prowlarr. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

## Testing the Download Client

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each download client you'd like Prowlarr to use. If it fails, you will need to check your log for the error (connection, credentials, etc.).

# Notifications

> Information on supported notification providers can be found at the following page [supported](/prowlarr/supported#notifications)
{.is-info}

## Connections

Connections are how you want Prowlarr to communicate with the outside world.

- By pressing the <kb>+</kb> button you will be presented with a new window which will allow you to configure many different endpoints

- A list of supported notifications and connections is located [here](/prowlarr/supported#notifications)

## Notification Triggers

- On Health Issue - Be notified on health check failures
  - Include Health Warnings - Be notified on health warnings in addition to errors.
- On Application Update - Be notified when Prowlarr gets updated to a new version

# Tags

- The tag section in Prowlarr is used to link different aspects of Prowlarr.
- Tags are particularly useful for:
  - Enabling Flaresolverr Proxy for use with an indexer; Note that Flaresolverr Proxies are disabled without a tag
  - Enabling a HTTP or SOCKS Proxy for use with an indexer
  - Specifying Indexers to certain apps

# General

Here is where you will change generalized application settings such as port and logging level.

Click on `Settings` => `General`.

> A lot of the options here can only be seen by clicking "Show Advanced" at the top of the screen. Any menu items in orange are only shown when show advanced is enabled.
{.is-info}

## Host

![general_host.png](/assets/prowlarr/general_host.png)

- (Advanced Option) Bind Address - Leave this as `*` unless you need to change it. The IPv4 address/host on the system Prowlarr will listen on. (default: `*`)
  - Note that `*` is any/all addresses
- Port Number - the port that Prowlarr runs on. It must be unique. (default: 9696)
- BaseUrl - Enter a URL base here if you are using a reverse proxy. (restart required) (default: blank)
- (Advanced Option) Instance Name - Name to use for Browser Tab and SysLog (if enabled) (restart required) (default: Prowlarr)
- (Advanced Option) Use SSL - Check this box if you use an https address to connect to Prowlarr. If you are using `localhost` or an IP address, this should almost NEVER be checked. (default: false)
- Launch Browser (Windows Only) - Check this box if you want a browser window to be launched when Prowlarr starts. (default: yes)

## Security

![general_security.png](/assets/prowlarr/general_security.png)

- Authentication - How would you like to authenticate to access your Prowlarr instance
  - None - You have no authentication to access your Prowlarr. Typically if you're the only user of your network, do not have anybody on your network that would care to access your Radarr or your Radarr is not exposed to the web
  - Basic (Browser pop-up) - This option when accessing your Prowlarr will show a small pop-up allowing you to input a Username and Password
  - Forms (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Prowlarr
- API Key - API key is used by outside apps accessing Prowlarr. This is secret and should not be shared with anyone. If it gets shared, you should regenerate it and update your apps.
- Certificate Validation - Change how strict HTTPS certification validation is
  - Enabled - Validate all HTTPS certificates (recommended)
  - Disabled for Local Addresses - Validate all HTTPS certificates except those on localhost and the LAN
  - Disabled - Do not validate any HTTPS certificates

## Proxy

![general_proxy.png](/assets/prowlarr/general_proxy.png)

Proxy - This option allows you to run the information your Prowlarr pulls and searches for through a proxy. This can be useful if you're in a country that does not allow the downloading of Torrent files

- Use Proxy - Enable to use a Proxy
- Proxy Type - Select your proxy type (HTTPS, Socks4, or Socks5)
- Hostname - Enter your proxy hostname (Do not include http/https or any other protocol)
- Port - Enter your proxy port
- Username - Enter your proxy username if applicable
- Password - Enter your proxy password if applicable
- Ignored Addresses - Enter a comma-separated list of addresses that bypass the proxy
- Bypass Proxy for Local Addresses - Check the box to bypass the proxy for local addresses.

## Logging

![general_logging.png](/assets/prowlarr/general_logging.png)

The default log level is `Info`. This is very basic logging. You can change it here for more detailed logging. Log files will rotate, so there is no danger of taking up too much space.

- Log level - Probably one of the most useful troubleshooting tools
  - Info - This is the most basic way that Prowlarr gathers information this will include very minimal amount of information in the logs. This log file contains fatal, error, warn and info entries.
  - Debug - Debug will include all the information that Info includes plus more information that can be useful. This log files contains fatal, error, warn, info and debug entries
  - Trace - The most advance and detailed logging on Prowlarr, Trace will include all the information gathered by Info and Debug and more. This is the most common type of log that is going to be asked for when troubleshooting on Discord or Reddit. If you're needing help please select your log to Trace and redo the task that was giving you problems to capture the log. This log files contains fatal, error, warn, info, debug and trace entries.

## Analytics

![general_analytics.png](/assets/prowlarr/general_analytics.png)

- Analytics - Send anonymous usage and error information to Prowlarr's servers (Servarr). This includes information on your browser, which Prowlarr WebUI pages you use, error reporting as well as OS, runtime version, and related information. We will use this information to prioritize features and bug fixes.

## Updates

![general_updates.png](/assets/prowlarr/general_updates.png)

- (Advanced Option) Branch - This is the branch of Prowlarr that you are running on.
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

- (Advanced Option) Folder - This allows you to select the backup location. In docker you will be limited to what you allow the container to see. Paths are relative to the appdata folder; if necessary, you can set an absolute path to backup outside of the appdata folder.
- (Advanced Option) Interval - How often would you like Prowlarr to make a backup
- (Advanced Option) Retention - How long would you like Prowlarr to hold on to each backup. After a new backup is made the oldest backup will be removed

> Manual backups are retained forever, stored in the same folder, and are named differently.
{.is-info}

# UI

## Dates

- Short Date Format - How do you want Prowlarr to display short dates?
- Long Date Format - How do you want Prowlarr to display long format dates?
- Time Format - Do you want a 12hr or 24hr format?
- Show Relative Dates - Do you want Prowlarr to show relative (Today/Yesterday/etc) or absolute dates?

## Style

- Theme - Select the color theme Prowlarr should use inspired by [Theme.Park](https://github.com/GilbN/theme.park)
- Enable Color-Impaired Mode - Altered style to allow color-impaired users to better distinguish color coded information

## Language

- UI Language - Select the Language for Prowlarr to use within the application UI
