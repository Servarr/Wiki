---
title: Settings
description: 
published: true
date: 2021-06-06T15:08:17.882Z
tags: 
editor: markdown
dateCreated: 2021-06-06T15:04:48.057Z
---

# Settings

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

`Add and Remove Only` will only add or remove indexers when they are added or removed from Prowlarr, but edits within the indexer itself either in your app or in Prowlarr are not synced.

`Full Sync` will keep your app and Prowlarr fully in sync. If you make a change in either program, it is synced to the other program (and to any other program that has full sync selected!).

`Disabled` will keep indexers from syncing with the program entirely.

- If you have added a tag to your indexer during setup, only indexers with this tag will be used for this program entry.

- Enter the Prowlarr server URL here.

> Note that if you're using a reverse proxy, you need to add the URL Base to this! If you don't, then when the indexers sync they will be broken, and if you've selected Add and Remove Only, it will not get fixed when you edit it!

- Enter the URL of your program here. Again, enter the full URL Base if used.

- Enter the API Key of your program here. You can get this from your program in the `Settings` / `General` tab, and copy/paste it here.

Test your entry. If a green check-mark appears, you can save your entry, and repeat as necessary for each program you'd like to sync with Prowlarr. If it fails, you will need to check your log for the error (URL, API Key, etc.).