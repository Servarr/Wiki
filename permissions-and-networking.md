---
title: Networking and Permissions Troubleshooting Guide
description: 
published: true
date: 2021-11-13T21:09:50.099Z
tags: troubleshooting
editor: markdown
dateCreated: 2021-11-13T21:09:50.099Z
---

# Network Troubleshooting 

## Not connectable IPv6 IP

- Test connecting with curl

```bash
curl -sv -6 "http://<url>:<port>/"
```