---
title: Prowlarr MacOS Installation
description: MacOS installation guide for Prowlarr
published: true
date: 2025-09-15T02:43:44.795Z
tags: prowlarr, installation, macos
editor: markdown
dateCreated: 2023-07-03T20:11:30.382Z
---

# MacOS (OSX)

{#OSX}

> Prowlarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://prowlarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://prowlarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system architecture.
1. Open the archive and drag the Prowlarr icon to your Application folder.
1. Self-sign Prowlarr `codesign --force --deep -s - /Applications/Prowlarr.app && xattr -rd com.apple.quarantine /Applications/Prowlarr.app`
1. Start Prowlarr by double-clicking the icon or running `open /Applications/Prowlarr.app`
1. Browse to <http://localhost:9696> to start using Prowlarr

> Due to Apple Security Restrictions, the Application's Updater must be self-signed as well or you must manually install updates. This is primarily due to the Personal Information required by Apple to sign applications.
{.is-info}