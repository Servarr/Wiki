---
title: Prowlarr Appdata Directory
description: 
published: true
date: 2021-10-09T16:16:01.218Z
tags: prowlarr, appdata
editor: markdown
dateCreated: 2021-06-08T01:06:44.136Z
---

> Below are the default paths for the application data directiory {.is-info}

> All instances of `$USER` are placeholders for the user the application is running under. {.is-warning}

## Windows

`C:\ProgramData\Prowlarr`

## Linux

Unless otherwise specified Prowlarr will store it's application data in the home folder of the user Prowlarr is running under `/home/$USER/.config/Prowlarr` or `~/.config/Prowlarr`

The installation instructions specify `/var/lib/prowlarr`

## MacOS (OSX)

{#os-x}

`/Users/$USER/.config/Prowlarr` or `~/.config/Prowlarr`

## Synology

`/usr/local/Prowlarr/var/.config/Prowlarr`

`/volume1/@appstore/Prowlarr/var/.config/Prowlarr`

## QNAP

`/share/MD0_DATA/homes/admin/.config/Prowlarr`

`/share/CACHEDEV1_DATA/Prowlarr_CONFIG`

## Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

## Arguments

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On Windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`
