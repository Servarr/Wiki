---
title: Lidarr MacOS Installation
description: MacOS installation guide for Lidarr
published: true
date: 2025-09-15T02:42:39.920Z
tags: lidarr, installation, macos
editor: markdown
dateCreated: 2023-07-03T20:10:53.957Z
---

# MacOS (OSX)

{#OSX}

> Lidarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://lidarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://lidarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system architecture.
1. Open the archive and drag the Lidarr icon to your Application folder.
1. Self-sign Lidarr `codesign --force --deep -s - /Applications/Lidarr.app && xattr -rd com.apple.quarantine /Applications/Lidarr.app`
1. Start Lidarr by double-clicking the icon or running `open /Applications/Lidarr.app`
1. Browse to <http://localhost:8686> to start using Lidarr

> Due to Apple Security Restrictions, the Application's Updater must be self-signed as well or you must manually install updates. This is primarily due to the Personal Information required by Apple to sign applications.
{.is-info}
