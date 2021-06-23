---
title: Radarr Appdata Directory
description: 
published: true
date: 2021-06-23T03:07:17.623Z
tags: radarr
editor: markdown
dateCreated: 2021-05-25T02:34:50.549Z
---

## Windows

`C:\ProgramData\Radarr`

## Linux

Unless otherwise specified Radarr will store it's application data in the home folder of the user Radarr is running under `/home/$USER/.config/Radarr` (`~/.config/Radarr`)

`/var/lib/Radarr`

## OS X

`/Users/$USER/.config/Radarr (~/.config/Radarr)`

## Synology

`/usr/local/Radarr/var/.config/Radarr`

`/volume1/@appstore/Radarr/var/.config/Radarr`

## QNAP

`/share/MD0_DATA/homes/admin/.config/Radarr`

`/share/CACHEDEV1_DATA/Radarr_CONFIG`

## Argument

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On windows this would be `/nobrowser`
