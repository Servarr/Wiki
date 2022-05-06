---
title: Synology Packages
description: 
published: true
date: 2022-05-06T17:49:17.272Z
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

1. Log in via ssh
1. Execute 
```bash
sudo chown root:root /volume1/@appstore/bubblewrap/bin/bwrap
sudo chmod u+s /volume1/@appstore/bubblewrap/bin/bwrap
```