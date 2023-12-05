---
title: Synology Packages
description: Servarr Synology Packages
published: true
date: 2023-12-05T13:35:37.363Z
tags: lidarr, prowlarr, synology, radarr,readarr,sonarr
editor: markdown
dateCreated: 2022-05-06T13:45:19.731Z
---

- [Servarr Synology Packages](#servarr-synology-packages)
- [DSM 6.x](#dsm-6x)
- [DSM 7.x](#dsm-7x)
  - [Bubblewrap Installation on DSM 7.X](#bubblewrap-installation-on-dsm-7x)
    - [Simple Bubblewrap Installation](#simple-bubblewrap-installation)
    - [Manual Bubblewrap Installation](#manual-bubblewrap-installation)

# Servarr Synology Packages

> These packages can be considered "beta". They are not maintained/developed by the Servarr team. No support is available for the packages. Use at your own risk.
{.is-danger}

- The Servarr Team now creates and maintains Synology Packages
- Installation instructions are noted below for the specific DSM versions

> Generally the existing SynoCommunity versions are not compatible with the Servarr versions without some hoop jumping. This means it would be required to delete the old package after doing a [backup of your database *the link is for a Radarr example, but the instructions/concepts are the same*](/radarr/faq#how-do-i-backuprestore-radarr). Which can be done through the web interface of the \*Arr app.
{.is-warning}

> SynoCommunity has a list of [NAS by Architecture](https://github.com/SynoCommunity/spksrc/wiki/Architecture-per-Synology-model) which will assist you in identifying the correct package.
{.is-info}

# DSM 6.x

- The Lidarr-Official, Prowlarr-Official, Radarr-Official, Readarr-Official, and Sonarr packages should *just work*.
- Note that the standalone Mono package from the SynoCommunity is not required anymore, it currently is bundled within our package.
- Download the release of the application for your NAS's architecture from [the Servarr Synology Package GitHub](https://github.com/Servarr/spksrc/releases) and [manually install the package](https://kb.synology.com/en-us/DSM/tutorial/How_to_install_applications_with_Package_Center#x_anchor_id6) via package manager.

# DSM 7.x

- The Lidarr-Official, Prowlarr-Official, Radarr-Official, and Readarr-Official packages should *just work* for most architectures.
  - Note that a NAS with `comcerto2k` requires additional steps for Lidarr, Prowlarr, Radarr, and Readarr; [see the instructions](#bubblewrap-installation-on-dsm-7x).
- Note that the Sonarr package requires additional steps for **all** architectures.
- Note that the standalone Mono package from the SynoCommunity is not required anymore, it currently is bundled within our package.

> For NAS running on a `comcerto2k` (*all packages*) and Sonarr (*all NAS architectures*), you will need to install the Bubblewrap package and perform the manual steps noted. **Bubblewrap must be installed prior to attempting to install the \*Arr Packages**
{.is-warning}

- Download the release of Bubblewrap for your NAS's architecture from [the Servarr Synology Package GitHub](https://github.com/Servarr/spksrc/releases) and [manually install the package](https://kb.synology.com/en-us/DSM/tutorial/How_to_install_applications_with_Package_Center#x_anchor_id6) via package manager.
- Complete the below Bubblewrap Installation Steps for DSM 7.X
- Once Bubblewrap is installed, you may download the release of the application for your NAS's architecture from [the Servarr Synology Package GitHub](https://github.com/Servarr/spksrc/releases) and [manually install the package](https://kb.synology.com/en-us/DSM/tutorial/How_to_install_applications_with_Package_Center#x_anchor_id6) via package manager.

## Bubblewrap Installation on DSM 7.X

Bubblewrap allows us to run programs in a basic container so that we can use new enough libraries to run .NET6.

> **Due to the restrictions in DSM 7.0+, some manual setup is required after installation.**
{.is-danger}

### Simple Bubblewrap Installation

1. Create a triggered task within DSM:

- User: `root`
  - Event: `Boot-up`

1. For the `Run Command` enter:

```bash
chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```

1. Save triggered task, and run it once.

![triggered_task.png](/assets/synology/triggered_task.png)

![create_task1.png](/assets/synology/create_task1.png)

![create_task2.png](/assets/synology/create_task2.png)

![run_task.png](/assets/synology/run_task.png)

### Manual Bubblewrap Installation

1. [Login to your Synology via SSH and elevate to `root`](https://kb.synology.com/en-global/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)
1. Execute following commands:

```bash
sudo chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
```

```bash
chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```
