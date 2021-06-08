---
title: Prowlarr Appdata Directory
description: 
published: true
date: 2021-05-25T02:34:55.107Z
tags: Prowlarr
editor: markdown
dateCreated: 2021-05-25T02:34:50.549Z
---

## Windows

`C:\ProgramData\Prowlarr`

## Linux

Unless otherwise specified Prowlarr will store it's application data in the home folder of the user Prowlarr is running under `/home/$USER/.config/Prowlarr` (`~/.config/Prowlarr`)

`/var/lib/Prowlarr`

## OS X

`/Users/$USER/.config/Prowlarr (~/.config/Prowlarr)`

## Synology

`/usr/local/Prowlarr/var/.config/Prowlarr`

`/volume1/@appstore/Prowlarr/var/.config/Prowlarr`

## QNAP

`/share/MD0_DATA/homes/admin/.config/Prowlarr`

`/share/CACHEDEV1_DATA/Prowlarr_CONFIG`

## Argument

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On windows this would be `/nobrowser`
