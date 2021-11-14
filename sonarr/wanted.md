---
title: Sonarr Wanted
description: 
published: true
date: 2021-07-10T16:08:10.024Z
tags: sonarr, needs-love, wanted
editor: markdown
dateCreated: 2021-06-10T01:40:02.329Z
---

## Wanted

The Wanted => Missing section contains a list of the episodes you have marked to monitor that are missing from your disk (haven't been downloaded yet).

> This will only include episodes completely missing from your disk, not episodes which exist on disk, but have their cutoff profile unmet.
{.is-info}

- "Search Selected" - Here you can select certain episodes if you wish to search for them with your indexers

- "Unmonitor Selected" - Here you can select certain episodes and unmonitor them if you're no longer interested in them.

- "Search All" - Selecting here will send a search to all of your indexers for all current missing episodes. Once pressed, a dialog box will pop up with a warning to you, letting you know how many episodes will be searched for; this is particularly helpful to know if your indexers limit your api calls.

> This search process cannot be canceled once started without restarting Sonarr.
{.is-info}

## Cutoff Unmet

The Wanted => Cutoff Unmet section contains a list of the episodes that have not yet reached their cut off. The cut off is set within your profiles

The cut off is where you essentially tell Sonarr that the quality of the video file is good enough for you and you no longer wish for Sonarr to keep searching for better.

There are a couple of options available to you on this page
![wanted-cut-off-unmet.png](/assets/sonarr/wanted-cut-off-unmet.png)

1. Search Selected - By selecting episodes on your list you can perform an Automatic search to try to see if there are any upgrades to your existing files.
1. Unmonitor Selected - By selecting certain episodes on your list you can tell Sonarr to no longer look for any upgrades by Unmonitoring that episode.
1. Seach All - This can be dangerous (depending on how big your list is) as you're telling Sonarr to search every file that hasn't met the cut off. This can be useful if you do not have a massive list.
1. Filter - This will allow you to filter out your results. This is useful if you're wanting to search a specific set of episodes or series
