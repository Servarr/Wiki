---
title: Lidarr Installation
description: Instructions and Guides for Installation of Lidarr
published: true
date: 2026-05-29T13:05:53.867Z
tags: lidarr, docker, installation, guide, scripts, setup
editor: markdown
dateCreated: 2021-05-24T05:12:27.036Z
---

# By Platform

[<i class="fab fa-windows" style="font-size: 3em;"></i>](/lidarr/installation/windows)&nbsp;&nbsp;&nbsp;&nbsp;[<i class="fab fa-linux" style="font-size: 3em;"></i>](/lidarr/installation/linux)&nbsp;&nbsp;&nbsp;&nbsp;[<i class="fab fa-apple" style="font-size: 3em;"></i>](/lidarr/installation/macos)&nbsp;&nbsp;&nbsp;&nbsp;[<i class="fab fa-freebsd" style="font-size: 3em;"></i>](/lidarr/installation/freebsd)&nbsp;&nbsp;&nbsp;&nbsp;[<i class="fab fa-docker" style="font-size: 3em;"></i>](/lidarr/installation/docker)

# Recommended Guides

- [Setup Reverse Proxy *Complete guide for reverse proxy setup with Nginx or Apache*](/lidarr/installation/reverse-proxy)
{.links-list}

# Post-install configuration

Small configuration tweaks that apply regardless of platform. For installation itself, use the platform links above.

## Disable browser-on-startup

{#disable-browser-launch}

By default Lidarr opens a browser window to its UI when it starts. Three ways to turn that off (pick whichever fits your setup):

- **Settings UI:** on most platforms, Settings → General has a **Launch Browser on Start** checkbox. Uncheck it and save. The checkbox isn't present on every platform (notably headless server builds), in which case use one of the options below.
- **Command-line flag:** add `-nobrowser` (Linux/macOS) or `/nobrowser` (Windows) to the Lidarr invocation. For systemd services, add the flag to the `ExecStart=` line in the unit file; for Windows services, edit the service command via `sc config` or directly in the registry. Docker containers never open a browser, so this flag is irrelevant there.
- **Config file:** stop Lidarr, open `config.xml` in the [AppData directory](/lidarr/appdata-directory), and set `<LaunchBrowser>False</LaunchBrowser>`. Start Lidarr.

Pick one. They don't stack.
