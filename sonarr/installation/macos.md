---
title: Sonarr MacOS Installation
description: MacOS installation guide for Sonarr
published: true
date: 2023-07-03T20:23:52.657Z
tags: sonarr
editor: markdown
dateCreated: 2021-07-10T16:07:37.425Z
---

# MacOS (OSX)

{#OSX}

> Sonarr will eventually be no longer compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://services.sonarr.tv/v1/download/main/latest?version=3&os=macos&installer=true)
1. Open the archive and drag the Sonarr icon to your Application folder.
1. Self-sign Sonarr `codesign --force --deep -s - /Applications/Sonarr.app && xattr -rd com.apple.quarantine`
1. Browse to <http://localhost:8989> to start using Sonarr
