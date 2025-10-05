---
title: Prowlarr Appdata Directory
description: Guide to Prowlarr's application data directory structure, configuration files, and backup recommendations
published: true
date: 2025-09-23T11:32:51.638Z
tags: prowlarr, appdata, configuration, directory, files, backup
editor: markdown
dateCreated: 2021-06-08T01:06:44.136Z
---

> Below are the default paths for the application data directory {.is-info}

> All instances of `$USER` are placeholders for the user the application is running under. {.is-warning}

# Windows

- `C:\ProgramData\Prowlarr`

# Linux

Unless otherwise specified Prowlarr will store it's application data in the home folder of the user Prowlarr is running under 

-`/home/$USER/.config/Prowlarr
- `~/.config/Prowlarr`

The installation instructions specify `/var/lib/prowlarr`

# MacOS (OSX)

{#os-x}

- `~/Library/Application Support/Prowlarr`
- `/Users/$USER/.config/Prowlarr`
- `~/.config/Prowlarr`

# Synology

- `/usr/local/Prowlarr/var/.config/Prowlarr`
- `/volume1/@appstore/Prowlarr/var/.config/Prowlarr`

# QNAP

- `/share/MD0_DATA/homes/admin/.config/Prowlarr`
- `/share/CACHEDEV1_DATA/Prowlarr_CONFIG`

# Docker

- `/config`
- This will vary based on where the user maps `/config` to on their host system

# Arguments

- The `-data=` argument forces the location of the AppData folder, so your startup command may be forcing a specific location. This is required when trying to run multiple instances. On Windows this would be `/data=`
- The `-nobrowser` argument refrains from launching/opening the browser on startup. On Windows this would be `/nobrowser`
