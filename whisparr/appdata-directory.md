---
title: Whisparr Appdata Directory
description:
published: true
date: 2021-11-24T19:23:52.023Z
tags: whisparr, appdata
editor: markdown
dateCreated: 2021-05-25T02:34:50.549Z
---

> Below are the default paths for the application data directiory {.is-info}

> All instances of `$USER` are placeholders for the user the application is running under. {.is-warning}

# Windows

`C:\ProgramData\Whisparr`

# Linux

Unless otherwise specified Whisparr will store it's application data in the home folder of the user Whisparr is running under `/home/$USER/.config/Whisparr` or `~/.config/Whisparr`

The installation instructions specify `/var/lib/whisparr`

# MacOS (OSX)

{#os-x}

`/Users/$USER/.config/Whisparr` or `~/.config/Whisparr`

# Synology

`/usr/local/Whisparr/var/.config/Whisparr`

`/volume1/@appstore/Whisparr/var/.config/Whisparr`

# QNAP

`/share/MD0_DATA/homes/admin/.config/Whisparr`

`/share/CACHEDEV1_DATA/Whisparr_CONFIG`

# Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

# Arguments

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On Windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`
