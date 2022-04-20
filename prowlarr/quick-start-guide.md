---
title: Prowlarr Quick Start Guide
description: 
published: true
date: 2022-04-20T13:11:12.102Z
tags: prowlarr, quickstart
editor: markdown
dateCreated: 2021-05-30T00:00:33.010Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Indexers](#indexers)
- [Apps](#apps)
  - [Application Settings](#application-settings)
- [Download Clients](#download-clients)
  - [Usenet Client Settings](#usenet-client-settings)
  - [Torrent Client Settings](#torrent-client-settings)
  - [Testing the Download Client](#testing-the-download-client)
- [Setup Complete](#setup-complete)

> This page is still in progress and not complete.

> For a more detailed breakdown of all the settings, check [Prowlarr =>Settings](/prowlarr/settings)
{.is-info}

In this guide we will try to explain the basic setup you need to do to get started with Prowlarr. We're going to skip some options that you may see on the screen. If you want to dive deeper into those, please see the appropriate page in the FAQ and docs for a full explanation.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you will need to click `Show Advanced` at the top of the page to make them visible.
{.is-warning}

# Indexers

The first thing to set up in Prowlarr is indexers. You will add each indexer individually to Prowlarr.

Click on `Indexers`, and then click the `+` to add a new indexer.

![addindexer.png](/assets/prowlarr/addindexer.png)

All indexers you can add (usenet and torrent) are listed, and you can type to partially match any existing entry. If the indexer you want to add doesn't exist in the list, you can add "Generic Newznab" (for usenet) or "Generic Torznab" (for torrents).

![addgeneric.png](/assets/prowlarr/addgeneric.png)

Some indexers have special settings, but most are standard as shown.

![addnewindexer.png](/assets/prowlarr/addnewindexer.png)

- Name - Enter a name for this indexer.
- Enable - Check to enable this indexer. This setting syncs to your programs.
- Redirect - If your indexer requires it, check the box to redirect download requests so it doesn't look like the request is coming from Prowlarr. This is only needed for one or two Indexers.
- App Profile - Select your App Profiles as created in [Settings => Apps => App Profiles](/prowlarr/settings#app-profiles)
- URL - Enter or Select the URL of this indexer's API.
- (Advanced Option) If the API Path is not /api, change it here.
- Enter the API Key from your profile page on the indexer's website here.
- (Advanced Option) If you need additional parameters for the indexer, enter them here.
- If you enter a date for VIP expiration here, Prowlarr will warn you 1 week before it expires.
- (Advanced Option) Enter an indexer priority here from 1 (highest) to 50 (lowest). If there are identical results on multiple indexers during a search, the indexer with the highest priority will get the download. This setting syncs to your programs.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each indexer you'd like Prowlarr to use. If it fails, you will need to check your log for the error (URL, API Key, etc.).

# Apps

After you've added your indexers, we then connect Prowlarr to your other apps.

Click on `Settings` => `Apps`, and then click the `+` to add a supported app.

![addapps.png](/assets/prowlarr/addapps.png)

All programs you can add are listed. You should only add programs you currently have installed, and if you have multiple instances of them, you must add each of them separately.

> Currently supported Apps can be found at the following page [supported](/prowlarr/supported#applications)
{.is-info}

When you add an app, you will need to enter values in the pop-up screen:

![addlidarr.png](/assets/prowlarr/addlidarr.png)

> Note: Indexers are synced based on the capabilities/categories they claim to support. If an indexer supports only `tv` categories it will not be synced to Lidarr, Radarr, and Readarr. It will only be synced to Sonarr "Supported" Categories can be selected as an advanced setting on a per app basis. **Also note that the \*Arrs only accept indexers whose test queries return results containing at least one of the configured categories.
{.is-info}

## Application Settings

- Name - Enter a name for this App.
- Sync Level - Select the sync level to use
  - `Add and Remove Only` - When indexers are added or removed from Prowlarr, it will update this remote app. If the indexer is down at the time of sync - it will be disabled on the remote app.
  - `Full Sync` - Full Sync will keep this app's indexers fully in sync. Changes made to indexers in Prowlarr are then synced to this app. Any change made to indexers remotely within this app will be overridden by Prowlarr on the next sync. A list of factors used to compare and determine if a sync should occur can be found in the [FAQ](/prowlarr/faq#what-arr-indexer-settings-are-compared-for-app-full-sync)
  - `Disabled` - will keep indexers from syncing with the program entirely.

> `Full Sync` means Prowlarr will override any all including user selected categories. However, seed goals and tags in \*Arrs are not currently factored in to this comparison to trigger a sync. However, [just about every other factor of changes](/prowlarr/faq#what-arr-indexer-settings-are-compared-for-app-full-sync) will trigger a sync and overwrite all settings in \*Arr
{.is-danger}

- Tags - ~~If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry.~~

> **Tags for apps are not yet functional**
{.is-warning}

- Prowlarr Server - Enter the Prowlarr server URL (including http, port, and baseurl if needed) as the app would access it here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you do not, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!{.is-info}

- Application Server -  Enter the App server URL (including http, port, and baseurl if needed) of your program here. Again, enter the full URL Base if used.

- API Key - Enter the API Key of your program here. For \*Arrs this can be found in Settings => General. You can get this from your program in the `Settings` => `General` tab, and copy/paste it here.

- (Advanced Setting) Sync Categories - Select the categories to sync to this app. Indexers that support these categories will be synced.

> When you save this, it's going to sync your indexers to the app. They are all added with the Name you've chosen for your indexer plus (Prowlarr) after it. e.g. `{Indexer Name} (Prowlarr)`
{.is-info}

![nzbgeek.png](/assets/prowlarr/nzbgeek.png)

You should then go into your program, and disable the non-Prowlarr version of the indexer. Once everything is running smoothly, you can delete those entries and leave just the (Prowlarr) versions in place.

You may wish to go into your programs and check the categories for the Prowlarr indexers. Default categories to be mapped into the App are configurable as an advanced setting for the App in Prowlarr.

> **Please note that custom/non-standard indexer specific categories are mapped to standard ones, so searching will standard ones will incorporate all custom ones**
{.is-info}

# Download Clients

> If you intend to do searches directly within Prowlarr, you need to add Download Clients. Otherwise, you do not need to add them here. For searches from your Apps, the download clients configured there are used instead. {.is-info}

> Download clients are for Prowlarr in-app searches only and do not sync to apps. There are no plans to add any such functionality. {.is-danger}

Click on `Settings` => `Download Clients`, and then click the `+` to add a new download client. Your download client should already be configured to follow this guide.

![downloadclients.png](/assets/prowlarr/downloadclients.png)

> Currently supported Download Clients can be found at the following page [supported](/prowlarr/supported#downloadclient)
{.is-info}

Select the download client you wish to add, and there will be a pop-up box to enter connection details. These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.
![nzbget.png](/assets/prowlarr/nzbget.png)

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
- Initial State - Initial state for torrents (Qbittorrent Only: Forced bypasses all seed thresholds)
- Client Priority - Priority of the download client within Prowlarr. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

## Testing the Download Client

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each download client you'd like Prowlarr to use. If it fails, you will need to check your log for the error (connection, credentials, etc.).

# Setup Complete

That's it for the basics! You can then add notifications and other more advanced setup options as needed. Those are documented in the full Settings page.
