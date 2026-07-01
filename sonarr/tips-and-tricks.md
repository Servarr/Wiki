---
title: Sonarr Tips and Tricks
description: Advanced tips, optimization techniques, and workflow improvements for experienced Sonarr users
published: true
date: 2026-06-27T00:00:00.000Z
tags: tips, tricks, optimization, workflow, advanced, sonarr
editor: markdown
dateCreated: 2021-08-14T15:15:35.157Z
---

# TRaSH's Custom Formats

- [TRaSH has a guide](https://trash-guides.info/Sonarr/sonarr-collection-of-custom-formats/) on how to use [Sonarr => Settings => Custom Formats](/sonarr/settings#custom-formats-2) as well as a shared repository of Custom Formats.

# Syncing Two Sonarr Instances

- TRaSH has [a guide](https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/) on how to sync two (or more) instances

# Renaming Series Folders

- If you change your Series Folder Format after Sonarr has already created folders, Sonarr does not rename the existing folders automatically. See [this FAQ entry](/sonarr/faq#rename-folders) for the steps to trigger a rename.

# Creating a Folder for Each Series

- This is only needed to clean up / organize an existing library to facilitate importing into Sonarr. Below are a few different methods.

## Filebot

> Filebot is supported on Windows, Linux, and MacOS {.is-info}

- [Filebot](https://www.filebot.net/) is a fantastic utility for getting your episodes organized in a way that Sonarr can successfully parse. Version 4.7.9 can still be downloaded for free from a SourceForge mirror, but there are also paid versions in the Windows and Apple stores. On Linux, your distribution of choice may have a package for it, like in Arch's AUR package or `.deb` files for Debian/Ubuntu from their download page. It has both a GUI and a CLI, so it should satisfy almost everyone.

- There is great help available, including their format expressions page. Filebot's TV format expressions can produce a `Series Name (Year)/Season XX/` layout that Sonarr parses cleanly.

- To keep this pattern for future imports, you should set:

- [Settings => Media Management (Advanced Settings Shown) => Series Folder Format](/sonarr/settings#media-management)

  - Series Folder: `{Series TitleYear}`
  - Season Folder: `Season {season:00}`

- Note: You can adjust the tokens above using any of the [series naming tokens](/sonarr/settings#series-folder-format) that Sonarr supports.

## Linux Bash Script

The following script will take all video files within your selected folder and move each into a folder based on the series portion of its name. Note that this does not go into subfolders within the starting/selected folder. Sort the resulting folders before importing — this is a starting point, not a parser.

```shell
cd /path/to/your/episode/files/
find . -maxdepth 1 -type f \( -iname "*.mkv" -o -iname "*.mp4" \) -exec sh -c 'mkdir "${1%.*}" ; mv "${1%}" "${1%.*}" ' _ {} \;
```

## Windows Powershell

Alternatively in Windows you can run the following script in Powershell to iterate over each file in a directory, and move it to a folder with the same name.

```powershell
Get-ChildItem -File
  | ForEach-Object {
    $dir = New-Item -ItemType Directory -Name $_.BaseName -Force
    $_ | Move-Item -Destination $dir
  }
```
