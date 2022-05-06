---
title: Synology Packages
description: 
published: true
date: 2022-05-06T18:01:22.347Z
tags: 
editor: markdown
dateCreated: 2022-05-06T13:45:19.731Z
---

# Synology Packages

The Servarr Team now creates and maintains Synology Packages

## DSM 7.X

To be written

### Bubblewrap installation on DSM 7

> Bubblewrap allows us to run programs in a basic container so that we can use new enough libraries to run .NET 6.
{.is-info}

- Due to the restrictions in DSM 7.0+, a few manual steps are required after installation

1. [Login to your Synology via SSH and elevate to `root`](https://kb.synology.com/en-global/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)
1. Execute 
```bash
chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```