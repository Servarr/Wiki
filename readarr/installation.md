---
title: Readarr Installation
description: 
published: true
date: 2021-06-07T17:27:13.477Z
tags: readarr
editor: markdown
dateCreated: 2021-05-25T00:22:15.328Z
---

## Windows

Readarr is supported natively on Windows. Readarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account does not have permissions to access your user's home directory unless permissions have been assigned manually. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Readarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> Readarr is in a pre-alpha state and has no binaries currently available for Windows. If you wait a bit, there should be an official release soon. Until that time, building from source is your only available option. This is a difficult process that requires advanced technical knowledge, and is not supported by the Readarr team.
{.is-warning}

1. Download the latest version of Readarr from <https://readarr.com/#downloads-v1-windows> for your architecture
1. Run the installer
1. Browse to <http://localhost:8787> to start using Readarr

## OSX

> Readarr is in a pre-alpha state and has no binaries currently available for OSX. If you wait a bit, there should be an official release soon. Until that time, building from source is your only available option. This is a difficult process that requires advanced technical knowledge, and is not supported by the Readarr team.
{.is-warning}

1. Download the latest version of Readarr from <https://readarr.com/#downloads-v1-macos>
1. Open the archive and drag the Readarr icon to your Application folder.
1. Browse to <http://localhost:8787> to start using Readarr

### Linux

> Readarr is in a pre-alpha state and has no binaries currently available for Linux. If you wait a bit, there should be an official release soon. Until that time, building from source is your only available option. This is a difficult process that requires advanced technical knowledge, and is not supported by the Readarr team.
{.is-warning}
You'll need to install the binaries using the below commands.
> Note: This assumes you will run as the user `readarr` and group `media`.
> This will download the `x64` copy of readarr and install it into `/opt`
{.is-info}

- Ensure you have the required prequisite packages: `sudo apt install curl SQLite3`
- Download the correct binaries for your architecture.
 `wget --content-disposition '{link hidden}'`
  - AMD64 use `arch=x64`
  - ARM use `arch=arm`
  - ARM64 use `arch=arm64`
- Uncompress the files: `tar -xvzf Readarr*.linux*.tar.gz`
- Move the files to `/opt/` `sudo mv Readarr/ /opt`
- Ensure ownership of the binary directory.
  `sudo chown readarr:readarr /opt/Readarr`
- Configure systemd so Readarr can autostart at boot.

> The below systemd creation script will use a data directory of `/data/.config/Readarr`.  For the default data directory of `/home/$USER/.config/Readarr` simply remove the `-data` argument
{.is-warning}

```bash
    cat > /etc/systemd/system/readarr.service << EOF
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
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```

- Reload systemd: `systemctl -q daemon-reload`
- Enable the Readarr service: `systemctl enable --now -q readarr`

## Docker

> Readarr is in a pre-alpha state. If you wait a bit, there should be an official release soon.
{.is-warning}
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

Please note that Calibre Content Server, and Calibre, are NOT Calibre Web. Calibre Web is a separate tool unrelated to either of these things, and is not required or used by Readarr in any way.

#### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Readarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Readarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

### Install Readarr

To install and use these Docker images, you'll need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/readarr](https://hotio.dev/containers/readarr/)
- [linuxserver/readarr](https://docs.linuxserver.io/images/docker-readarr)
{.links-list}
