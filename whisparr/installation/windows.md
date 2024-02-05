---
title: Whisparr Windows Installation
description: Windows installation guide for Lidarr
published: true
date: 2023-07-03T20:26:42.229Z
tags: 
editor: markdown
dateCreated: 2022-04-03T03:49:24.491Z
---

# Windows

Whisparr is supported natively on Windows. Whisparr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Whisparr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing if you get an access error -- such as Access to the path `C:\ProgramData\Whisparr\config.xml` is denied -- or you use mapped network drives. This gives Whisparr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Whisparr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:6969> to start using Whisparr

- [Windows x64 Installer](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Whisparr manually using the [x64 .zip download](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}
