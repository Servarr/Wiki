---
title: Prowlarr Appdata Directory
description: 
published: true
date: 2021-08-05T23:23:20.672Z
tags: prowlarr
editor: markdown
dateCreated: 2021-06-08T01:06:44.136Z
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

## Docker

`/config`
- This will very based on where the user maps `/config` to on their host system

## Argument

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On windows this would be `/nobrowser`
