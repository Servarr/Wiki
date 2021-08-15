---
title: Sonarr Appdata Directory
description: 
published: true
date: 2021-08-05T23:25:06.437Z
tags: 
editor: markdown
dateCreated: 2021-06-09T15:53:57.860Z
---

## Windows

`C:\ProgramData\Sonarr`

## Linux

Unless otherwise specified Sonarr will store it's application data in the home folder of the user Sonarr is running under `/home/$USER/.config/Sonarr` (`~/.config/Sonarr`)

> For apt based installs, it defaults to `/var/lib/Sonarr`
{.is-info}

## OS X

`/Users/$USER/.config/Sonarr (~/.config/Sonarr)`

## Synology

`/usr/local/Sonarr/var/.config/Sonarr`

`/volume1/@appstore/Sonarr/var/.config/Sonarr`

## QNAP

`/share/MD0_DATA/homes/admin/.config/Sonarr`

`/share/CACHEDEV1_DATA/Sonarr_CONFIG`

## Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

## Argument

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On windows this would be `/nobrowser`
