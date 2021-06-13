---
title: Prowlarr Indexers
description: 
published: true
date: 2021-06-13T05:27:17.272Z
tags: 
editor: markdown
dateCreated: 2021-06-06T11:45:31.974Z
---

This page will describe how to add and configure indexers in Prowlarr, and keep them synced with your other programs like Sonarr, Radarr, Lidarr, Readarr, etc.

## Adding an Indexer

To add an indexer, first click on `Indexers` on the left, then `Add Indexer` (the Plus symbol) at the top of the page.

![ind_1_addindexer.png](/assets/prowlarr/ind_1_addindexer.png)

Choose your indexer from the list, or type a partial name in the box to find your indexer. If your indexer is not listed, please use "Generic Newznab" (for usenet) or "Generic Torznab" (for torrents).

> This assumes your indexer supports standardized *znab formats. If it doesn't, then this will not work.
> If your indexer is not listed, you can request it be added in Discord, in the `#indexer-requests` channel.
{.is-info}

Once you've selected your indexer, there will be a pop-up containing further information you will need to configure it.

![ind_2_indexerconfig.png](/assets/prowlarr/ind_2_indexerconfig.png)

- Select a name for this indexer. When it syncs to your apps, it will add `(Prowlarr)` behind it.

- Check the box to enable this indexer.

- Check the box if a redirect is necessary. There are only a couple of indexers where this is required to avoid being banned.

- Select your App Profile here. These can be created in `Settings` -> `Apps`. The Standard one already exists, and looks like this:

![ind_3_settingsapps.png](/assets/prowlarr/ind_3_settingsapps.png)

- If you're adding a torrent indexer, you will need to choose what kind of download link to use.

- You may have to enter an API key, a session id, or other credentials from your indexer (usually found in your Profile Page or under Security), select search orders, or other options for your specific indexer.

- (Advanced Option) Select the indexer priority here from 1-50 (1 being highest). These priorities will sync to your apps.

Test your indexer, and if a green checkmark appears, you're okay to save it. When you save it, depending on your sync settings, it will be added to your apps automatically.
