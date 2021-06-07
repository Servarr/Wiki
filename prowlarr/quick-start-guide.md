---
title: Quick Start Guide
description: 
published: true
date: 2021-06-07T00:40:35.072Z
tags: 
editor: markdown
dateCreated: 2021-05-30T00:00:33.010Z
---

# Quick Start Guide
This guide should be used to get configured and running with the basics, and to give you an understanding of how the pieces work together.

## Indexers

The first thing to set up in Prowlarr is indexers. You will add each indexer individually to Prowlarr.

Click on `Indexers`, and then click the `+` to add a new indexer.

![addindexer.png](/assets/prowlarr/addindexer.png)

All indexers you can add (usenet and torrent) are listed, and you can type to partially match any existing entry. If the indexer you want to add doesn't exist in the list, you can add "Generic Newznab" (for usenet) or "Generic Torznab" (for torrents).

![addgeneric.png](/assets/prowlarr/addgeneric.png)

Some indexers have special settings, but most are standard as shown.

![addnewindexer.png](/assets/prowlarr/addnewindexer.png)

- Enter a name for this indexer.
- Check to enable this indexer. This setting syncs to your programs.
- If your indexer requires it, check the box to redirect download requests so it doesn't look like the request is coming from Prowlarr.
- App Profile is standard for now, as others do not exist.
- Enter the URL of this indexer's API.
- (Advanced Option) If the API Path is not /api, change it here.
- Enter the API Key from your profile page on the indexer's website here.
- (Advanced Option) If you need additional parameters for the indexer, enter them here.
- If you enter a date for VIP expiration here, Prowlarr will warn you 1 week before it expires.
- (Advanced Option) Enter an indexer priority here from 1 (highest) to 50 (lowest). If there are identical results on multiple indexers during a search, the indexer with the highest priority will get the download. This setting syncs to your programs.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each indexer you'd like Prowlarr to use. If it fails, you will need to check your log for the error (URL, API Key, etc.).

## Apps

After you've added your indexers, we then connect Prowlarr to your other *arr programs.

Click on `Settings` -> `Apps`, and then click the `+` to add an arr program.

![addapps.png](/assets/prowlarr/addapps.png)

All programs you can add are listed. You should only add programs you currently have installed, and if you have multiple instances of them, you should add each of them separately.

![addlidarr.png](/assets/prowlarr/addlidarr.png)

- Enter a name for this indexer.
- Select your sync level for this indexer. 

`Add and Remove Only` will only add or remove indexers when they are added or removed from Prowlarr, but edits within the indexer itself either in your app or in Prowlarr are not synced.

`Full Sync` will keep your app and Prowlarr fully in sync. If you make a change in either program, it is synced to the other program (and to any other program that has full sync selected!).

`Disabled` will keep indexers from syncing with the program entirely.

- If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry. Note that tags are not yet functional. This is future use.

- Enter the Prowlarr server URL here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you don't, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!

- Enter the URL of your program here. Again, enter the full URL Base if used.

- Enter the API Key of your program here. You can get this from your program in the Settings / General tab, and copy/paste it here.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each program you'd like to sync with Prowlarr. If it fails, you will need to check your log for the error (URL, API Key, etc.).

> When you save this, it's going to sync your indexers to the app. They are all added with the Name you've chosen plus (Prowlarr) after it.

![nzbgeek.png](/assets/prowlarr/nzbgeek.png)

You should then go into your program, and disable the non-Prowlarr version of the indexer. Once everything is running smoothly, you can delete those entries and leave just the (Prowlarr) versions in place.

> You should also go into your programs and check the categories for the Prowlarr indexers. Categories are not currently editable in Prowlarr, but are pushed over from a capabilities check.

## Download Clients (for In-Prowlarr searches only!)

> If you intend to do searches directly within Prowlarr, you need to add Download Clients. Otherwise, you do not need to add them here. For searches from your Apps, the download clients configured there are used instead.

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

- (Advanced Option) If you're using a reverse proxy, enter the URL Base for the download client.
- Enter a username if you have one to connect to your client.
- Enter a password if you have one to connect to your client.
- Enter a category to be used with the download client for when you do grabs DIRECTLY from Prowlarr.
- Enter a priority for when you do grabs DIRECTLY from Prowlarr.
- Check this box to add downloads in a Paused state.
- (Advanced Option) Enter the client priority.
>Client priority only matters when 2 of the same type (usenet or torrent) are added. 1 is the highest priority, and if multiple clients of the same type exist and have the same priority, Prowlarr will alternate between then.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each download client you'd like Prowlarr to use. If it fails, you will need to check your log for the error (connection, credentials, etc.).

That's it for the basics! You can then add notifications and other more advanced setup options as needed. Those are documented in the full Settings page.
