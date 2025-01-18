---
title: How Do I Install Plugins
description: Instructions on installing plugins in Lidarr
published: true
date: 2025-01-18T16:31:41.474Z
tags: lidarr, plugins
editor: markdown
dateCreated: 2025-01-18T16:05:16.687Z
---

# How Do I Install Plugins

## Plugin Branch
Lidarr plug-ins allow users to extend the capability of Lidarr to include new indexers and download clients, including peer-to-peer networks and common streaming services.

Plug-in capabilities are currently only available on the `plugins` branch.

### Windows

- Navigate to `/settings/general` 
- Show Advanced if not already enabled
- Scroll down to Updates. Type in `plugins`
- Save changes.

### Docker

Update your Docker Compose file to use the following image and rebuild. 

```yaml
image: ghcr.io/hotio/lidarr:pr-plugins
```
 
Once you have changed branches, navigate to `/system/plugins`. You will have the option to enter the URL of the GitHub repository containing the plugin. Enter the URL and select Install. You can observe the progress in the lower left corner. The installation will take several seconds depending your installation. 

After completing the installation, Lidarr needs to be restarted for the plugin to work properly. The restart procedure varies depending on the platform used.

> Plugin updates do not occur automatically 
{.is-info}

## Supported Plugins

(blerb about plugins)

### Deemix

TBD

### Slskd

#### Prerequisites 
This plugin enables Lidarr to search Soulseek using Slskd. You must have a working Lidarr installation from the plugins branch and a working Slskd installation to use this plugin.

To generate the Api Key necessary for the communication to the Slskd app follow the steps here:
https://github.com/slskd/slskd/blob/master/docs/config.md#authentication

#### Configuration

##### Download Client

Once the plugin is installed, Slskd can be added as a download client. 
- Navigate to `/settings/downloadclients`, and select the plus button under Download clients. Slskd will appear at the bottom under the Other section.
- Enter the correct hostname.
- Enter the API key
- Select the Test button.
- If the Test returns a green checkmark, select Save.

#### Indexer

To search, Slskd must also be added as an Indexer. 
- Navigate to `/settings/indexers`, and select the plus button under Indexers. Slskd will appear at the bottom under the Other section.
- Enter the correct URL.
- Enter the API key
- Select the Test button.
  - The Indexer test will send a test search to slskd for "Silent Partner Chances".
- If the Test returns a green checkmark, select Save.

#### Delay Profile



### Verification

TBD

### Tidal

TBD

