---
title: Lidarr Installation
description: 
published: true
date: 2021-05-24T05:13:10.368Z
tags: 
editor: markdown
dateCreated: 2021-05-24T05:12:27.036Z
---

# Windows

> Lidarr does not support Windows XP
{.is-danger}

> At this time Windows 7 should still work, but we will not maintain Windows 7 support. Note that KB2533623 and Microsoft Visual C++ 2015 Redistributable Update 3 are needed to run net5 apps on Windows 7
{.is-warning}

Lidarr is supported natively on Windows. Lidarr can be installed on Windows as Windows Service or system tray application.
> Lidarr is in beta testing and does not have a formal stable release.
{.is-warning}
1. Download the latest version of Lidarr from https://lidarr.com/#downloads-v1-windows for your architecture
1. Run the installer
1. Browse to http://localhost:8686 to start using Lidarr

# OSX
> Lidarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
1. Download the latest version of Lidarr from https://lidarr.com/#downloads-v1-macos
1. Open the archive and drag the Lidarr icon to your Application folder.
1. Browse to http://localhost:8686 to start using Lidarr
# Linux
> Lidarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
You'll need to install the binaries using the below commands.
> Note: This assumes you will run as the user `lidarr` and group `lidarr`.
> This will download the `x64` copy of lidarr and install it into `/opt`
{.is-info}
- Ensure you have the required prequisite packages: `sudo apt install curl sqlite3 libchromaprint-tools`
- Download the correct binaries for your architecture.
 ` wget --content-disposition 'http://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'`
  - AMD64 use `arch=x64` 
  - ARM use `arch=arm`
  - ARM64 use `arch=arm64`
- Uncompress the files: `tar -xvzf Lidarr*.linux*.tar.gz`
- Move the files to `/opt/` `sudo mv Lidarr/ /opt`
- Ensure ownership of the binary directory.
  `sudo chown lidarr:lidarr /opt/Lidarr`
- Configure systemd so Lidarr can autostart at boot.
```
    cat > /etc/systemd/system/lidarr.service << EOF
[Unit]
Description=Lidarr Daemon
After=syslog.target network.target
[Service]
User=lidarr
Group=lidarr
Type=simple

ExecStart=/opt/Lidarr/Lidarr -nobrowser -data=/data/.config/Lidarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```
- Reload systemd: `systemctl -q daemon-reload`
- Enable the Lidarr service: `systemctl enable --now -q lidarr`

  
# Docker
> Lidarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
The Lidarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.


> For a more detailed explanation of docker and suggested practices, see [The Best Docker Setup and Docker Guide](/Docker-Guide) wiki article.
{.is-info}

## Install Lidarr
There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/lidarr](https://hotio.dev/containers/lidarr/)
- [linuxserver/lidarr](https://docs.linuxserver.io/images/docker-lidarr)
{.links-list}