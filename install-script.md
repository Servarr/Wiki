---
title: Servarr Installation Script
description: Common Installation Script for the Servarr Suite of Applications
published: true
date: 2024-01-10T15:35:19.132Z
tags: 
editor: markdown
dateCreated: 2022-02-03T15:12:29.483Z
---

# Servarr Installation Script

This is a community created and community supported **unofficial** script to handle installation of Servarr Apps (Lidarr/Prowlarr/Radarr/Readarr/Whisparr) on a Linux operating system - commonly targeted towards Debian & Ubuntu or similar distributions.

> This will install the selected application to /opt. It will run application as the user and group you configure.
> For Lidarr/Radarr/Readarr/Whisparr - you should use a common group that is the same that your download client runs as and media server runs as to ensure ownership and permissions are sane and all files are accessible.
{.is-info}

Please be aware of the following common mistake around permissions.

> Two things to keep in mind are that Lidarr/Radarr/Readarr/Whisparr require read and write access to your download client's download directory and whatever folder you'll configure as your root (library or media) folder.
> Ideally each app is running as its own user and common group of `media` with permissions of `775` and `664` which is a UMask of `002`
> \* Your download clients and media server run as and are a part of the group you input
> \* Your paths used by your download clients and media server are accessible (read/write) to the group you input
{.is-warning}

Be aware of the following:

> This will remove any existing Installations installed to /opt. it will not uninstall existing installations from any other location; please ensure you have a backup of your settings using Backup from within the app (System => Backup). The script won't delete your settings (application data), but be safe.
{.is-danger}

- (Optional) Ensure you have [set a static IP Address](https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/), it'll will make your life easier.
- SSH into your Debian (Raspbian / Raspberry Pi OS) / Ubuntu box and become or login as root.

> SSH in using Putty, mRemoteNG, or any other SSH tool. Note that most tools support saving your connection.{.is-info}

- Once SSHed in type the command below to download the installation script in your current directory

```bash
curl -o servarr-install-script.sh https://raw.githubusercontent.com/Servarr/Wiki/master/servarr/servarr-install-script.sh
```

- To run the install script

```shell
sudo bash servarr-install-script.sh
```
