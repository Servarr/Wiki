---
title: Sonarr MacOS Installation
description: MacOS installation guide for Sonarr
published: true
date: 2023-07-28T11:15:29.588Z
tags: sonarr
editor: markdown
dateCreated: 2023-07-03T20:13:29.890Z
---

# MacOS (OSX)

{#OSX}

> Sonarr is no longer compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://services.sonarr.tv/v1/download/main/latest?version=4&os=macos&installer=true)
1. Open the archive and drag the Sonarr icon to your Application folder.
1. Self-sign Sonarr `codesign --force --deep -s - /Applications/Sonarr.app && xattr -rd com.apple.quarantine /Applications/Sonarr.app`
1. Start Sonarr by double-clicking the icon or running `open /Applications/Sonarr.app`
1. Browse to <http://localhost:8989> to start using Sonarr

> Sonarr uses a bundled version of ffprobe for media file analysis and does not require ffprobe or ffmpeg to be installed on the system.  If Sonarr says Ffprobe is not found this can typically be fixed with a reinstall.
{.is-info}
