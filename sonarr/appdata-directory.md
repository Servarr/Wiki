---
title: Sonarr Appdata Directory
description: 
published: true
date: 2021-10-09T16:12:14.666Z
tags: 
editor: markdown
dateCreated: 2021-06-09T15:53:57.860Z
---

> Below are the default paths for the application data directiory {.is-info}

> All instances of `$USER` are placeholders for the user the application is running under. {.is-warning}

## Windows

`C:\ProgramData\Sonarr`

## Linux

Unless otherwise specified Sonarr will store it's application data in the home folder of the user Sonarr is running under `/home/$USER/.config/Sonarr` (`~/.config/Sonarr`)

> For apt repo based installs, it defaults to `/var/lib/Sonarr`
{.is-info}

## OS X

`/Users/$USER/.config/Sonarr (~/.config/Sonarr)`

## Synology

If you are using the SynoCommunity package for Sonarr, this is where you should expect to find your appdata. If you are using Docker on your Synology NAS, look below in the Docker section.

### DSM 7 and above

`/volume1/@appdata/nzbdrone/.config/Sonarr`

### DSM 6 and below

`/volume1/@appstore/nzbdrone/.config/Sonarr`

> SynoCommunity still uses the original package name `nzbdrone` for the underlying package name {.is-info}

## QNAP

`/share/MD0_DATA/homes/admin/.config/Sonarr`

`/share/CACHEDEV1_DATA/Sonarr_CONFIG`

## Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

## Argument

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On windows this would be `/nobrowser`
