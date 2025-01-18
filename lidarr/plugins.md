---
title: How Do I Install Plugins
description: Instructions on installing plugins in Lidarr
published: true
date: 2025-01-18T16:05:16.687Z
tags: lidarr, plugins
editor: markdown
dateCreated: 2025-01-18T16:05:16.687Z
---

# How Do I Install Plugins

Lidarr plug-ins allow users to extend the capability of Lidarr to include new indexers and download clients, including peer-to-peer networks and common streaming services.

Plug-in capabilities are currently only available on the `plugins` branch.

## Windows

- Navigate to `/settings/general` 
- Show Advanced if not already enabled
- Scroll down to Updates. Type in `plugins`
- Save changes.

## Docker

Update your Docker Compose file to use the following image.

```yaml
image: ghcr.io/hotio/lidarr:pr-plugins
```
 
Once you have changed branches, navigate to `/system/plugins`. You will have the option to enter the URL of the GitHub repository containing the plugin.

