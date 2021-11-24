---
title: Sonarr Activity
description: 
published: true
date: 2021-11-19T02:21:40.322Z
tags: sonarr
editor: markdown
dateCreated: 2021-06-11T23:32:31.144Z
---

# Activity

The activity tab is where you can see past and present activities that Sonarr has done.  Including imports, deletes, upgrades, grabs, and failures.

# Queue

The queue shows all items the application can recognize that is in the specified download client's category (Settings => Download Client => Category). To view all releases Options => Show Unknown. This is not stored anywhere within the application, but is updated via your Download Client's API responses.

At the top of the page is `Manual Import` which allows you to abritrarily import media files from any destination Sonarr can access for series that already exist in Sonarr.  

- Move Automatically will attempt to automatically match the files to series/episodes in Sonarr and will move - not copy nor hardlink - them to your library folder
- Interactive Import will allow you to review the matches and adjust various specifications as needed.  It provides the option (bottom left corner) to `Move` or `Copy/Hardlink` your files.  Be sure to choose the correct option for your needs.
  
  > If a directory has more than 100 files in it then Sonarr will not recursively search the directory nor attempt to parse and match the files. {.is-info}

More information about the Queue section Coming Soon - Contributions are Welcome.

# History

The history tab shows all things that have left the queue by way of the task being finished/ended.  This includes imports, failures, grabs, deletes, and upgrades.

# Blocklist

> Blocklist is formerly known as 'Blacklist' {.is-info}

The blocklist feature (accessible via selecting an "Unwanted" file, or one needing human attention, and deleting it, you are able to check the "Blocklist" box), allows you to tell Sonarr to no longer allow this release (not applicable to duplicate releases) and to search for a different one, that fits your filters (exactly like normally searching).
