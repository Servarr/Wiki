---
title: Prowlarr Installation
description: 
published: true
date: 2021-06-06T03:33:41.644Z
tags: 
editor: markdown
dateCreated: 2021-05-24T05:07:51.882Z
---

# Windows

Prowlarr is supported natively on Windows. Prowlarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

> Prowlarr is in beta testing and does not have a formal stable release.
{.is-warning}
1. Download the latest version of Prowlarr from https://github.com/Prowlarr/Prowlarr/releases for your architecture
1. Run the installer
1. Browse to http://localhost:9696 to start using Prowlarr

# OSX
> Prowlarr is in beta testing and does not have a formal stable release.
{.is-warning}
  
1. Download the latest version of Prowlarr from https://github.com/Prowlarr/Prowlarr/releases
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
 ` wget --content-disposition 'http://prowlarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64'`
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

- [linuxserver/prowlarr](https://github.com/linuxserver/docker-prowlarr/tree/develop)
{.links-list}

# NGINX Reverse Proxy Configuration
> This assumes the default port of `9696` and that you set a baseurl of `prowlarr`
{.is-info}

```
location /prowlarr {
  proxy_pass        http://127.0.0.1:9696/prowlarr;
  proxy_set_header Host $proxy_host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_redirect off;

  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
}

  location /prowlarr/api { auth_request off;
  proxy_pass       http://127.0.0.1:9696/prowlarr/api;
}

  location ~ /prowlarr/[0-9]+/api { auth_request off;
  proxy_pass       http://127.0.0.1:9696/prowlarr/$1/api;
}

  location /prowlarr/Content { auth_request off;
    proxy_pass http://127.0.0.1:9696/prowlarr/Content;
 }
```