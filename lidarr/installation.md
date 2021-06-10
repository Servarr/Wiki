---
title: Lidarr Installation
description: 
published: true
date: 2021-06-07T17:26:33.385Z
tags: Lidarr
editor: markdown
dateCreated: 2021-05-24T05:12:27.036Z
---

## Windows

Lidarr is supported natively on Windows. Lidarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

1. Download the latest version of Lidarr from <https://lidarr.com/#downloads-v1-windows> for your architecture
2. Run the installer
3. Browse to <http://localhost:8686> to start using Lidarr

## OSX

1. Download the latest version of Lidarr from <https://lidarr.com/#downloads-v1-macos>
1. Open the archive and drag the Lidarr icon to your Application folder.
1. Browse to <http://localhost:8686> to start using Lidarr

## Linux

You'll need to install the binaries using the below commands.
> Note: This assumes you will run as the user `lidarr` and group `media`.
> This will download the `x64` copy of lidarr and install it into `/opt`
{.is-info}

- Ensure you have the required perquisite packages: You'll need curl, mediainfo, chromaprint, and sqlite.

```shell
sudo apt install curl mediainfo sqlite3 libchromaprint-tools
```

- Download the correct binaries for your architecture.

```shell
wget --content-disposition 'http://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
```

- AMD64 use `arch=x64`
- ARM use `arch=arm`
- ARM64 use `arch=arm64`
- Uncompress the files:

```shell
tar -xvzf Lidarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Lidarr/ /opt
```

- Ensure ownership of the binary directory.

```shell
sudo chown lidarr:lidarr /opt/Lidarr
```

- Configure systemd so Lidarr can autostart at boot.

> The below systemd creation script will use a data directory of `/data/.config/Lidarr`.  For the default data directory of `/home/$USER/.config/Lidarr` simply remove the `-data` argument
{.is-warning}

```shell
cat > /etc/systemd/system/lidarr.service << EOF
[Unit]
Description=Lidarr Daemon
After=syslog.target network.target
[Service]
User=lidarr
Group=media
Type=simple

ExecStart=/opt/Lidarr/Lidarr -nobrowser -data=/data/.config/Lidarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```

- Reload systemd:

```shell
systemctl -q daemon-reload
```

- Enable the Radarr service:

```shell
systemctl enable --now -q lidarr
```

## Docker

The Lidarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Lidarr Docker image.

### 1. Avoid Common Pitfalls

#### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Lidarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Music.2018/`, but in the Lidarr container that might be at `/downloads/My.Music.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/music` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Lidarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Lidarr web UI (Settings › Download Clients).

#### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Lidarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Lidarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

### Install Lidarr

There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/lidarr](https://hotio.dev/containers/lidarr/)
- [linuxserver/lidarr](https://docs.linuxserver.io/images/docker-lidarr)
{.links-list}
