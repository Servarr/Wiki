---
title: Readarr Installation
description: 
published: true
date: 2021-08-10T17:16:08.013Z
tags: readarr
editor: markdown
dateCreated: 2021-05-25T00:22:15.328Z
---

## Windows

Readarr is supported natively on Windows. Readarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Readarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Readarr\config.xml` is denied -- or you use mapped network drives. This gives Readarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

> Readarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}

1. Download the latest version of Readarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:8787> to start using Readarr

- [Windows x64 Installer](https://readarr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://readarr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Readarr manually using the [x64 .zip download](https://readarr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

## MacOS (OSX)

{#OSX}

> Readarr not compatible with OSX versions < 10.13 (High Sierra) due to netcore incompatibilities.
{.is-warning}

> Readarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}

1. Download the [MacOS App](https://readarr.servarr.com/v1/update/nightly/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Readarr icon to your Application folder.
1. Browse to <http://localhost:8787> to start using Readarr

## Linux

### Debian / Ubuntu

> Readarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}

You'll need to install the binaries using the below commands.

> The steps below will download the `x64` copy of readarr and install it into `/opt`
{.is-warning}

- Ensure you have the required perquisite packages:

```shell
sudo apt install curl sqlite3
```

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://readarr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Readarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Readarr/ /opt
```

> This assumes you have created the user and will run as the user `readarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Readarr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell
sudo chown -R readarr:readarr /opt/Readarr
```

- Configure systemd so readarr can autostart at boot.

> The below systemd creation script will use a data directory of `/data/.config/Readarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Readarr` simply remove the `-data` argument
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/readarr.service > /dev/null
[Unit]
Description=Readarr Daemon
After=syslog.target network.target
[Service]
User=readarr
Group=media
Type=simple

ExecStart=/opt/Readarr/Readarr -nobrowser -data=/data/.config/Readarr/
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

- Enable the Readarr service:

```shell
sudo systemctl enable --now -q readarr
```

## Docker

The Readarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Readarr Docker image.

### Avoid Common Pitfalls

#### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Readarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Book.2018.epub/`, but in the Readarr container that might be at `/downloads/My.Book.2018.epub/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/books` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Readarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your books would be in `/data/Books`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Readarr web UI (Settings › Download Clients).

#### Calibre Integration

When installing Readarr, you can choose to use Calibre integration or not. This choice can only be made during installation, and if you choose not to utilize Calibre you cannot add it later. If you currently use Calibre to manage your book library, you should choose this option. If you use it, Calibre will name and organize your book files for you.

If you are running Calibre, you must first start the Calibre Content Server (Preferences / Sharing over the net), and also set up a user and password. This will require a Calibre restart.

> Please note that Calibre Content Server and Calibre are NOT Calibre Web. Calibre Web is a separate tool unrelated to either of these programs, and is not required nor used by Readarr in any way.
{.is-warning}

#### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Readarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Readarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

### Install Readarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the `:nightly` tag with docker images, as there is no `master` nor `develop` branch.
{.is-warning}

- [hotio/readarr](https://hotio.dev/containers/readarr/)
- [linuxserver/readarr](https://docs.linuxserver.io/images/docker-readarr)
{.links-list}

## Reverse Proxy Configuration

Sample config examples for configuring Readarr to be accessible through a reverse proxy.

> These examples assumes the default port of `8787` and that you set a baseurl of `readarr`. It also assumes your web server i.e nginx and Readarr running on the same server accessible at `localhost`. If not, use the host IP address or a FDQN instead for the proxy pass.
{.is-info}

### NGINX

```none
location /readarr {
  proxy_pass        http://127.0.0.1:8787/readarr;
  proxy_set_header Host $host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Host $host;
  proxy_set_header X-Forwarded-Proto https;
  proxy_redirect off;

  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
}
  location /readarr/api { auth_request off;
  proxy_pass       http://127.0.0.1:8787/readarr/api;
}

  location /readarr/Content { auth_request off;
    proxy_pass http://127.0.0.1:8787/readarr/Content;
 }
```

### Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `readarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /readarr>
  ProxyPass http://127.0.0.1:8787/readarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:8787/readarr
</Location>
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/readarr/api/`
- `/readarr/Content/`
