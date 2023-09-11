---
title: Radarr Tips and Tricks
description: 
published: true
date: 2023-09-11T07:07:49.175Z
tags: radarr, needs-love, tips-and-tricks
editor: markdown
dateCreated: 2021-08-14T15:12:58.934Z
---

# TRaSH's Custom Formats

- [TRasH has a guide](https://trash-guides.info/Radarr/) on how to use [Radarr => Settings => Custom Formats](/radarr/settings#custom-formats) as well as a shared repository of Custom Formats.

# Syncing Two Radarr Instances

- TRaSH has [a guide](https://trash-guides.info/Radarr/Tips/Sync-2-radarr-sonarr/) for syncing two instances

# Renaming Movie Folders

- [See this FAQ Entry](/radarr/faq#how-can-i-rename-my-movie-folders)

# Creating a Folder for Each Movie

- This is only needed to cleanup / organize and existing library to facilitate importing into Radarr. Below are a few different methods.

## Filebot

> Filebot is supported on Windows, Linux, and MacOS {.is-info}

- [Filebot](https://www.filebot.net/) is a fantastic utility for getting your movies organized in a way that Radarr can successfully parse. Version 4.7.9 can still be downloaded for free from a SourceForge mirror, but there are also paid versions in the Windows and Apple stores. On Linux, your distribution of choice may have a package for it, like in Arch’s AUR package or `.deb` files for Debian/Ubuntu from their download page. It has both a GUI and a CLI, so it should satisfy almost everyone.

- There is great help available, including their format expressions page. My personal suggestion is to use something like `{ny}\{fn}` if your files include useful details like quality, edition and/or group or `{ny}/{ny} [{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` if they don’t, which would yield `Movie (Year)/Movie (Year) [Bluray-1080p]` or `Movie (Year)/Movie (Year) [DVD-480p]` for example. Instead of Bluray, you could also use WEBDL if you’d rather your collection be considered that.

- To keep this pattern for future movies, you should set:

- [Settings => Media Management (Advanced Settings Shown) => Movie Naming](/radarr/settings#media-management)

  - File: `{Movie CleanTitle} {(Release Year)} {Edition Tags} {[Quality Title]}`
  - Folder: `{Movie CleanTitle} {(Release Year)}`

- Note: You can replace the spaces above with `.` or `_` if you prefer that naming format.

## Files 2 Folder

> Files 2 Folder is a Windows Application {.is-info}

[Files 2 Folder](http://www.dcmembers.com/skwire/download/files-2-folder/) can movie library orgainzed for import into Radarr. Simply extract the zip to your computer and run the .exe as administrator, then click yes to add it to your right click menu.

Once installed it is only a few clicks to organize all your files into their own folders.

1. Browse to your movie folder
1. Select all files and right click to bring up the menu
1. Select the `files 2 folder` option in the menu
1. In the Files 2 Folder window select `Move each file to individual subfolders based on their names`
1. Click OK
1. Wait a moment and all your files will be in their own folder.

## Linux Bash Script

The following script will take all `*.mkv` files within your selected folder and move them into a folder based on their name. Note that this does not go into subfolders within the starting/selected folder.

```shell
cd /path/to/your/movies/files/
find . -maxdepth 1 -type f -iname "*.mkv" -exec sh -c 'mkdir "${1%.*}" ; mv "${1%}" "${1%.*}" ' _ {} \;
```

## Windows Command Line

Drop to a command line in Windows (cmd.exe) `As Administrator`. Navigate to your movie folder. Run these two commands (copy/paste is fine, there is nothing to change):

`for %i in (*) do md "%~ni"`

This will create a folder for every file in the directory.

`for %i in (*) do move "%i" "%~ni"`

This will move all of your files into the new directories.

If you need to clean up empty directories, this command will do that:

`for /f "usebackq delims=" %d in ("dir /ad/b/s | sort /R") do rd "%d"`

## Windows Powershell

Alternatively in Windows you can run the following script in Powershell to iterate over each file in a directory, and move it to a folder with the same name.

```powershell
Get-ChildItem -File 
  | ForEach-Object {
    $dir = New-Item -ItemType Directory -Name $_.BaseName -Force
    $_ | Move-Item -Destination $dir
  }
```
