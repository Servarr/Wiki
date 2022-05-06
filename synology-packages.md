---
title: Synology Packages
description: 
published: true
date: 2022-05-06T15:45:07.653Z
tags: 
editor: markdown
dateCreated: 2022-05-06T13:45:19.731Z
---

# Synology packages

## Bubblewrap installation on DSM 7
Bubblewrap allows us to run programs in a basic container so that we can use new enough libraries to run .NET 6.

Due to the restrictions in DSM 7.0, some manual steps are required after installation

1. Log in via ssh
1. Execute 
```
BWRAP=/volume1/@appstore/bubblewrap/bin/bwrap && sudo chown root:root $BWRAP && sudo chmod u+s $BWRAP
```