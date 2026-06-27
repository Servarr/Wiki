---
title: Sonarr Wanted
description: Managing wanted episodes, manual searches, and download monitoring in Sonarr's Wanted section
published: true
date: 2026-06-07T00:00:00.000Z
tags: wanted, episodes, search, monitoring, missing, sonarr
editor: markdown
dateCreated: 2021-06-10T01:40:02.329Z
---

# Wanted

The Wanted => Missing section contains a list of the episodes you have marked to monitor that are missing from your disk (haven't been downloaded yet).

> This will only include episodes completely missing from your disk, not episodes which exist on disk, but have their cutoff profile unmet.
{.is-info}

- "Search Selected" / "Search All" - When episodes are selected, this button searches only the selected episodes with your indexers. When no episodes are selected, it searches all current missing episodes. Once "Search All" is confirmed, a dialog box will pop up with a warning letting you know how many episodes will be searched for; this is particularly helpful to know if your indexers limit your API calls.

- "Unmonitor Selected" / "Monitor Selected" - When viewing monitored episodes, selecting certain episodes and clicking this button will unmonitor them. When viewing unmonitored episodes, this button will monitor the selected episodes.

- Filter - The filter button (top right) lets you toggle between viewing Monitored and Unmonitored missing episodes.

> This search process cannot be canceled once started without restarting Sonarr.
{.is-info}

At the top of the page is `Manual Import` which allows you to arbitrarily import media files from any destination Sonarr can access for series that already exist in Sonarr.

- Move Automatically will attempt to automatically match the files to series/episodes in Sonarr and will move - not copy nor hard link - them to your library folder
- Interactive Import will allow you to review the matches and adjust various specifications as needed. It provides the option (bottom left corner) to `Move` or `Copy/Hardlink` your files. Be sure to choose the correct option for your needs.

  > If a directory has more than 100 files in it then Sonarr will not recursively search the directory nor attempt to parse and match the files. {.is-info}

# Cutoff Unmet

The Wanted => Cutoff Unmet section contains a list of the episodes that have not yet reached their cut off. The cut off is set within your profiles

The cut off is where you essentially tell Sonarr that the quality of the video file is good enough for you and you no longer wish for Sonarr to keep searching for better.

There are a couple of options available to you on this page
![wanted-cut-off-unmet.png](/assets/sonarr/wanted-cut-off-unmet.png)

1. Search Selected / Search All - When episodes are selected, this button performs an automatic search for upgrades to only the selected files. When no episodes are selected, it searches all cutoff unmet episodes. This can be resource-intensive depending on the size of your list.
1. Unmonitor Selected / Monitor Selected - When viewing monitored episodes, selecting certain episodes and clicking this button will unmonitor them so Sonarr no longer looks for upgrades. When viewing unmonitored episodes, this button will re-monitor the selected episodes.
1. Filter - The filter button (top right) lets you toggle between viewing Monitored and Unmonitored cutoff unmet episodes.
