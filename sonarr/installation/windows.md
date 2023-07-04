---
title: Sonarr Windows Installation
description: Windows installation guide for Sonarr
published: true
date: 2023-07-04T15:22:44.146Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:13:54.851Z
---

# Windows

Sonarr is supported natively on Windows. Sonarr can be installed on Windows as Windows Service or system tray application.

> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services [cannot access network drives](https://learn.microsoft.com/en-us/windows/win32/services/services-and-redirected-drives) (X:\ mapped drives or \\\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Sonarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing if you get an access error -- such as Access to the path `C:\ProgramData\Sonarr\config.xml` is denied -- or you use mapped network drives. This gives Sonarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Sonarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:8989> to start using Sonarr

- [Windows x32 Installer](https://services.sonarr.tv/v1/download/main/latest?version=3&os=windows&installer=true)
{.links-list}

> It is possible to install Sonarr manually using the [x32 .zip download](https://services.sonarr.tv/v1/download/main/latest?version=3&os=windows). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}