---
title: Lidarr Installation
description: 
published: true
date: 2021-08-03T21:15:06.242Z
tags: lidarr
editor: markdown
dateCreated: 2021-05-24T05:12:27.036Z
---

## Windows

Lidarr is supported natively on Windows. Lidarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Lidarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Lidarr\config.xml is denied -- or you use mapped network drives. This gives Lidarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Lidarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:8686> to start using Lidarr

- [Windows x64 Installer](https://lidarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://lidarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Lidarr manually using the [x64 .zip download](https://lidarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

## MacOS (OSX)

{#OSX}

> Lidarr not compatible with OSX versions < 10.13 (High Sierra) due to netcore incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://lidarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Lidarr icon to your Application folder.
1. Browse to <http://localhost:8686> to start using Lidarr

## Linux

### Debian/Ubuntu

You'll need to install the binaries using the below commands.

> This will download the `x64` copy of lidarr and install it into `/opt`
{.is-info}

- Ensure you have the required perquisite packages: You'll need curl, mediainfo, chromaprint, and sqlite.

```shell
sudo apt install curl mediainfo sqlite3 libchromaprint-tools
```

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Lidarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Lidarr/ /opt
```

> This assumes you have created the user and will run as the user `lidarr` and group `media`.  You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Lidarr.
{.is-warning}

- Ensure ownership of the binary directory.

```shell
sudo chown lidarr:media /opt/Lidarr
```

- Configure systemd so Lidarr can autostart at boot.

> The below systemd creation script will use a data directory of `/data/.config/Lidarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Lidarr` simply remove the `-data` argument
{.is-warning}

```shell
cat << EOF | sudo tee /etc/systemd/system/lidarr.service > /dev/null
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
Restart=always
[Install]
WantedBy=multi-user.target
EOF
```

- Reload systemd:

```shell
sudo systemctl -q daemon-reload
```

- Enable the Lidarr service:

```shell
sudo systemctl enable --now -q lidarr
```

## Docker

The Lidarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Lidarr Docker image.

### Avoid Common Pitfalls

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

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/lidarr](https://hotio.dev/containers/lidarr/)
- [linuxserver/lidarr](https://docs.linuxserver.io/images/docker-lidarr)
{.links-list}

## Reverse Proxy Configuration

Sample config examples for configuring Lidarr to be accessible through a reverse proxy.

> These examples assumes the default port of `8686` and that you set a baseurl of `lidarr`. It also assumes your web server i.e nginx and Lidarr running on the same server accessible at `localhost`. If not, use the host IP address or a FDQN instead for the proxy pass.
{.is-info}

### NGINX

```none
location /lidarr {
  proxy_pass        http://127.0.0.1:8686/lidarr;
  proxy_set_header Host $host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Host $host;
  proxy_set_header X-Forwarded-Proto https;
  proxy_redirect off;

  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
}
  location /lidarr/api { auth_request off;
  proxy_pass       http://127.0.0.1:8686/lidarr/api;
}

  location /lidarr/Content { auth_request off;
    proxy_pass http://127.0.0.1:8686/lidarr/Content;
 }
```

### Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `lidarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /lidarr>
  ProxyPass http://127.0.0.1:8686/lidarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:8686/lidarr
</Location>
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/lidarr/api/`
- `/lidarr/Content/`
