---
title: Prowlarr Windows Installation
description: Windows installation guide for Prowlarr
published: true
date: 2023-08-28T19:43:08.146Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:11:39.779Z
---

# Windows

Prowlarr is supported natively on Windows. Prowlarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in.
Otherwise, a system tray application can be used if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing if you get an access error such as Access to the path `C:\ProgramData\Prowlarr\config.xml` is denied. This gives Prowlarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Prowlarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:9696> to start using Prowlarr

- [Windows x64 Installer](https://prowlarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://prowlarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Prowlarr manually using the [x64 .zip download](https://prowlarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

> If you use [Certify The Web](https://docs.certifytheweb.com/docs/backgroundservice/) for LetsEncrypt certificate management for IIS and are installing Prowlarr on the same machine, port `9696` is used by the background service. You will need to either change the listening port of Prowlarr in your `config.xml` to something else or change the port of the Certify The Web background service.
{.is-info}