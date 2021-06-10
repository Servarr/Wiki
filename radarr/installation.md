---
title: Radarr Installation
description: 
published: true
date: 2021-06-07T17:25:48.937Z
tags: 
editor: markdown
dateCreated: 2021-05-17T01:14:47.863Z
---

## Windows

Radarr is supported natively on Windows. Radarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Radarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

1. Download the latest version of Radarr from <https://radarr.video/#downloads-v3-windows> for your architecture
1. Run the installer
1. Browse to <http://localhost:7878> to start using Radarr

## OSX

1. Download the latest version of Radarr from <https://radarr.video/#downloads-v3-macos>
1. Open the archive and drag the Radarr icon to your Application folder.
1. Browse to <http://localhost:7878> to start using Radarr

### Linux
  
You'll need to install the binaries using the below commands.
> Note: This assumes you will run as the user `radarr` and group `media`.
> This will download the `x64` copy of radarr and install it into `/opt`
{.is-info}

- Ensure you have the required perquisite packages:

```bash
sudo apt install curl mediainfo sqlite3
```

- Download the correct binaries for your architecture.
 `wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'`
  - AMD64 use `arch=x64`
  - ARM use `arch=arm`
  - ARM64 use `arch=arm64`
- Uncompress the files: `tar -xvzf Radarr*.linux*.tar.gz`
- Move the files to `/opt/` `sudo mv Radarr/ /opt`
- Ensure ownership of the binary directory.
  `sudo chown radarr:radarr /opt/Radarr`
- Configure systemd so radarr can autostart at boot.

> The below systemd creation script will use a data directory of `/data/.config/Radarr`.  For the default data directory of `/home/$USER/.config/Radarr` simply remove the `-data` argument
{.is-warning}

```bash
    cat > /etc/systemd/system/radarr.service << EOF
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=radarr
Group=media
Type=simple

ExecStart=/opt/Radarr/Radarr -nobrowser -data=/data/.config/Radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```

- Reload systemd: `systemctl -q daemon-reload`
- Enable the Radarr service: `systemctl enable --now -q radarr`

## Docker

The Radarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Radarr Docker image.

### Avoid Common Pitfalls

#### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Radarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Movie.2018/`, but in the Radarr container that might be at `/downloads/My.Movie.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/movies` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Radarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Radarr web UI (Settings › Download Clients).

#### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Radarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Radarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

### Install Radarr

To install and use these Docker images, you'll need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/radarr](https://hotio.dev/containers/radarr/)
- [linuxserver/radarr](https://docs.linuxserver.io/images/docker-radarr)
{.links-list}

## NGINX Reverse Proxy Configuration

> This assumes the default port of `7878` and that you set a baseurl of `radarr`
{.is-info}

```nginx
location /radarr {
  proxy_pass        http://127.0.0.1:7878/radarr;
  proxy_set_header Host $proxy_host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto $scheme;
  proxy_redirect off;

  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
}
  location /radarr/api { auth_request off;
  proxy_pass       http://127.0.0.1:7878/radarr/api;
}

  location /radarr/Content { auth_request off;
    proxy_pass http://127.0.0.1:7878/radarr/Content;
 }
```
