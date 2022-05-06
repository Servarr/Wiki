---
title: Synology Packages
description: 
published: true
date: 2022-05-06T18:06:08.401Z
tags: 
editor: markdown
dateCreated: 2022-05-06T13:45:19.731Z
---

# Synology Packages

The Servarr Team now creates and maintains Synology Packages

## DSM 6.x

The packages should "just work", download from github and install via package manager

## DSM 7.x

The Radarr, Lidarr, Readarr and Prowlarr apps should just work (unless you are on a `comcerto2k` NAS).

For `comcerto2k` (all packages) and Sonarr (all NAS versions), you first need to install the Bubblewrap package and perform the manual step it guides you through.

Once the one-time bubblewrap setup is complete, you can install / upgrade the other packages as normal.

### Bubblewrap installation on DSM 7

Bubblewrap allows us to run programs in a basic container so that we can use new enough libraries to run .NET 6.

Due to the restrictions in DSM 7.0+, some manual setup is required after installation:

1. [Login to your Synology via SSH and elevate to `root`](https://kb.synology.com/en-global/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)
1. Execute 
```bash
chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```