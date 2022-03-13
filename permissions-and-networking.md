---
title: Networking and Permissions Troubleshooting Guide
description: 
published: true
date: 2022-03-13T15:12:02.123Z
tags: troubleshooting
editor: markdown
dateCreated: 2021-11-13T21:09:50.099Z
---

# Network Troubleshooting

- Generally `curl` will be needed for much of the troubleshooting
- For SSL then `openssl` will be needed for troubleshooting

## SSL Issues

- curl does not validate SSL certificates like \*Arrs do, so openssl needs to be used

- Test the connection/site using openssl to see if the certificates are valid

```bash
openssl s_client -showcerts -connect <url>:443
```

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

## Windows Creating URL Reservations

- Use netsh to create the urlacl - the below example is for radarr which uses port `7878`

```bash
http add urlacl http://*:7878/ sddl=D:(A;;GX;;;S-1-1-0)
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

```bash
sudo netstat -tnlp | grep 'Radarr'
```
