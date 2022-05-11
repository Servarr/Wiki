---
title: Synology Packages
description: 
published: true
date: 2022-05-11T00:11:02.572Z
tags: 
editor: markdown
dateCreated: 2022-05-06T13:45:19.731Z
---

# Synology Packages

- The Servarr Team now creates and maintains Synology Packages
- Installation instructions are noted below for the specific DSM versions
- ToDo - add blurb/instructions for migrating from SynoComm package
- ToDo - add blurb or link to identify NAS Architecture / Package

## DSM 6.x

- The Lidarr, Prowlarr, Radarr, Readarr, and Sonarr packages should _just work_.
- Download the release for your NAS's archetecture from [the Servarr Syno Package GitHub](https://github.com/Servarr/spksrc/releases) and [manually install it](https://kb.synology.com/en-us/DSM/tutorial/How_to_install_applications_with_Package_Center#x_anchor_id6) via package manager.

## DSM 7.x

- The Lidarr, Prowlarr, Radarr, and Readar packages should _just work_ for most architectures.
  - A NAS with `comcerto2k` requires additional steps
- The Sonarr package requires additional steps for all architectures.

> For NAS with `comcerto2k` (all packages) and Sonarr (all NAS architectures), you first need to install the Bubblewrap package and perform the manual step it guides you through.
{.is-warning}

- Once the one-time bubblewrap setup is complete, you can install / upgrade the other packages as normal.

### Bubblewrap Installation on DSM 7

Bubblewrap allows us to run programs in a basic container so that we can use new enough libraries to run .NET 6.

Due to the restrictions in DSM 7.0+, some manual setup is required after installation

## Recommended option

1. Create a scheduled task:
	- User: `root`
  	- Event: `Boot-up`
1. For the `Run Command` enter:

```bash
chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```

![create_task1.png](/assets/synology/create_task1.png)

![create_task2.png](/assets/synology/create_task2.png)

## Advanced option

1. [Login to your Synology via SSH and elevate to `root`](https://kb.synology.com/en-global/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)
1. Execute 

```bash
chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```