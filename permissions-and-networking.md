---
title: Networking and Permissions Troubleshooting Guide
description: 
published: true
date: 2021-11-26T22:12:12.855Z
tags: troubleshooting
editor: markdown
dateCreated: 2021-11-13T21:09:50.099Z
---

# Network Troubleshooting

- Generally `curl` will be needed for much of the troubleshooting

## Not connectable IPv6 IP

- Test connecting with curl

```bash
curl -sv -6 "http://<url>:<port>/"
```

## Windows Check Ports In Use

- Use netsh to get a list of ports in use and what is using them

```bash
netstat -ab
```

## Windows Check URL Reservations

- Use netsh to get a list of what ports and urls apps are bound to and listening on

```bash
netsh http show urlacl
```

## Linux Check Ports in Use

- Use netstat to locate ports in use / what port an app is on

```bash
sudo netstat -tnlp | grep <:port or app>
```

### Examples

- Port `8989`

```bash
sudo netstat -tnlp | grep ':8989'
```

- App named `Radarr`