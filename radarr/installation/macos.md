---
title: Radarr MacOS Installation
description: MacOS installation guide for Radarr
published: true
date: 2023-07-28T09:08:51.541Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:12:05.036Z
---

# MacOS (OSX)

{#OSX}

> Radarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://radarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://radarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system architecture. architecture.
1. Open the archive and drag the Radarr icon to your Application folder.
1. Self-sign Radarr `codesign --force --deep -s - /Applications/Radarr.app && xattr -rd com.apple.quarantine /Applications/Radarr.app`
1. Start Radarr by double-clicking the icon or running `open /Applications/Radarr.app`
1. Browse to <http://localhost:7878> to start using Radarr

> Radarr uses a bundled version of ffprobe for media file analysis and does not require ffprobe or ffmpeg to be installed on the system.  If Radarr says Ffprobe is not found this can typically be fixed with a reinstall.
{.is-info}
