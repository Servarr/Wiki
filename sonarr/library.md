---
title: Sonarr Library
description: Manage your TV series collection, monitor status, and organize media in Sonarr
published: true
date: 2022-10-28T17:18:11.116Z
tags: sonarr, library, series, management, collection, organization
editor: markdown
dateCreated: 2021-06-11T23:31:01.289Z
---

# Series

The series page shows your entire library and allows you to select individual series (however, searching can be more efficient in large libraries) and make searches for specific series, as well as being able to edit them. It also allows you to filter your series.

# Filters

The filters options allows you to narrow your series down and is incredibly helpful. It can be used to see release dates, names, episode counts, disk size counts, and too much more to list, including custom filters, to fit your every need. These can also be used in the mass editor.

# Add New

The add new feature allows you to add a new series for Sonarr to monitor and download.

- Root Folder - The selected [root/library folder](/sonarr/settings#root-folders) in Sonarr for this series to use
- Monitor - How do you want the series monitored initially?
  - All Episodes - Monitor all episodes except specials
  - Future Episodes - Monitor episodes that have not aired yet
  - Missing Episodes - Monitor episodes that do not have files or have not aired yet
  - Existing Episodes - Monitor episodes that have files
  - First Season - Monitor all episodes of the first season; all other seasons will be ignored
  - Latest Season - Monitor all episodes of the latest season and future seasons
  - None - No episodes will be monitored
- Quality Profile - The [quality profile](/sonarr/settings#quality-profiles) to use for this series
- Series Type - Which Series Type to use for this series; this changes how searches occur [See the FAQ entry for more info](/sonarr/faq#whats-the-different-series-types)
- Season Folder - Enable or disable creation and usage of Season folders for this series
- Tags - Used to assign series to release profiles, delay profiles, indexers, or just to organize your series
- [ ] Start search for missing episodes - based on your selected monitor settings, search for all missing and monitored episodes in this series
- [ ] Start search for cutoff unmet episodes - based on your selected monitor settings and only applicable if you have existing files for your episodes in the series folder, search for all existing and monitored episodes in this series that do not meet or exceed your quality profile's cutoff

# Library Import

Library Import allows you to import existing, organized series and episode files into Sonarr via existing files in the path directory. This is especially useful when making a new Sonarr instance and wanting to keep your existing series.

- Library import is for adding and importing an existing organized library of  series into Sonarr.

- Library Import cannot be used for:
  - Importing files from a download folder
  - Adding or Importing one or more files that are not properly named and organized in their own Series Folder within your root folder or a folder you wish to add as a root folder
  - Any other uses that are not adding a series or episode to Sonarr and importing the series and its file(s) from the root (library) folder that was input to Library Import

> \* Non-Windows: If you're using an NFS mount ensure `nolock` is enabled.
> \* If you're using an SMB mount ensure `nobrl` is enabled.
{.is-warning}

> **The user and group you configured Sonarr to run as must have read & write access to this location.** {.is-info}

> Your download client downloads to a download folder and Sonarr imports it to your media folder (final destination) that your media server uses.
{.is-info}

> **Your download folder and media folder can’t be the same location**
{.is-danger}

# Mass Editor

The mass editor allows you to edit series en masse. You can change any of the previous settings made when you added the series.

# Season Pass

This shows information about how many seasons every series has and how many episodes in each season are missing.
