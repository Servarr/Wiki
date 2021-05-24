---
title: Prowlarr Installation
description: 
published: true
date: 2021-05-24T05:13:00.901Z
tags: 
editor: markdown
dateCreated: 2021-05-24T05:07:51.882Z
---

# Windows

> Prowlarr does not support Windows XP
{.is-danger}

> At this time Windows 7 should still work, but we will not maintain Windows 7 support. Note that KB2533623 and Microsoft Visual C++ 2015 Redistributable Update 3 are needed to run net5 apps on Windows 7
{.is-warning}

Prowlarr is supported natively on Windows. Prowlarr can be installed on Windows as Windows Service or system tray application.
> Prowlarr is in beta testing and does not have a formal stable release.
{.is-warning}
1. Download the latest version of Prowlarr from https://prowlarr.com/#downloads-v1-windows for your architecture
1. Run the installer
1. Browse to http://localhost:9696 to start using Prowlarr

# OSX
> Prowlarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
1. Download the latest version of Prowlarr from https://prowlarr.com/#downloads-v1-macos
1. Open the archive and drag the Prowlarr icon to your Application folder.
1. Browse to http://localhost:9696 to start using Prowlarr
# Linux
> Prowlarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
You'll need to install the binaries using the below commands.
> Note: This assumes you will run as the user `prowlarr` and group `prowlarr`.
> This will download the `x64` copy of prowlarr and install it into `/opt`
{.is-info}
- Ensure you have the required prequisite packages: `sudo apt install curl sqlite3`
- Download the correct binaries for your architecture.
 ` wget --content-disposition 'http://prowlarr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'`
  - AMD64 use `arch=x64` 
  - ARM use `arch=arm`
  - ARM64 use `arch=arm64`
- Uncompress the files: `tar -xvzf Prowlarr*.linux*.tar.gz`
- Move the files to `/opt/` `sudo mv Prowlarr/ /opt`
- Ensure ownership of the binary directory.
  `sudo chown prowlarr:prowlarr /opt/Prowlarr`
- Configure systemd so Prowlarr can autostart at boot.
```
    cat > /etc/systemd/system/prowlarr.service << EOF
[Unit]
Description=Prowlarr Daemon
After=syslog.target network.target
[Service]
User=prowlarr
Group=prowlarr
Type=simple

ExecStart=/opt/Prowlarr/Prowlarr -nobrowser -data=/data/.config/Prowlarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```
- Reload systemd: `systemctl -q daemon-reload`
- Enable the Prowlarr service: `systemctl enable --now -q prowlarr`

  
# Docker
> Prowlarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
The Prowlarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.


> For a more detailed explanation of docker and suggested practices, see [The Best Docker Setup and Docker Guide](/Docker-Guide) wiki article.
{.is-info}

## Install Prowlarr
There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/prowlarr](https://hotio.dev/containers/prowlarr/)
{.links-list}