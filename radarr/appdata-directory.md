---
title: Radarr Appdata Directory
description: Guide to Radarr application data directory structure, configuration files, and data management
published: true
date: 2023-05-09T17:51:34.896Z
tags: radarr, appdata, configuration, directory, files, data, structure
editor: markdown
dateCreated: 2021-05-25T02:34:50.549Z
---

> Below are the default paths for the application data directory {.is-info}

> All instances of `$USER` are placeholders for the user the application is running under. {.is-warning}

# Windows

`C:\ProgramData\Radarr`

# Linux

Unless otherwise specified Radarr will store it's application data in the home folder of the user Radarr is running under `/home/$USER/.config/Radarr` or `~/.config/Radarr`

The installation instructions specify `/var/lib/radarr`

# MacOS (OSX)

{#os-x}

`/Users/$USER/.config/Radarr` or `~/.config/Radarr`

# Synology

`/usr/local/Radarr/var/.config/Radarr`

`/volume1/@appstore/Radarr/var/.config/Radarr'

'/volume1/@appdata/radarr/.config/Radarr'

# QNAP

`/share/MD0_DATA/homes/admin/.config/Radarr`

`/share/CACHEDEV1_DATA/Radarr_CONFIG`

# Docker

`/config`

- This will vary based on where the user maps `/config` to on their host system

# Arguments

The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On Windows this would be `/data=`

The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`
