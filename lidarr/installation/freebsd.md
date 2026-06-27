---
title: Lidarr FreeBSD Installation
description: FreeBSD installation guide for Lidarr
published: true
date: 2026-06-06T14:50:58.941Z
tags: lidarr, installation, freebsd
editor: markdown
dateCreated: 2023-07-03T20:10:42.484Z
---

# FreeBSD

The Lidarr team only provides builds for FreeBSD. The FreeBSD community maintains Plugins and Ports.

The FreeBSD community also maintains installation instructions, and anyone with a GitHub account may update the wiki as needed.

[Freshports Lidarr Link](https://www.freshports.org/net-p2p/lidarr/)

## Jail Setup Using TrueNAS GUI

1. From the main screen select Jails
1. Click ADD
1. Click Advanced Jail Creation
1. Name (any name will work): Lidarr
1. Jail Type: Default (Clone Jail)
1. Release: 12.2-Release (or newer)
1. Configure Basic Properties to your liking
1. Configure Jail Properties to your liking but add:
   - [x] allow_mlock
   - [x] allow_raw_sockets

   > `allow_raw_sockets` is helpful for troubleshooting (for example, ping, traceroute) but isn't needed.
   {.is-info}

1. Configure Network Properties to your liking
1. Configure Custom Properties to your liking
1. Click Save
1. After the jail starts, set one more property so Lidarr can see the storage space of your mounted media locations. Open a root shell on the server and run:

```shell
iocage stop <jailname>
iocage set enforce_statfs=1 <jailname>
iocage start <jailname>
```

## Lidarr Installation

Back on the jails list, find your newly created jail for `lidarr` and click **Shell**.

To install Lidarr:

> - Ensure your pkg repo pulls packages from `/latest` and not `/quarterly`
> - Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
> - If that file doesn't exist, copy `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

```shell
pkg install lidarr
```

Don't close the shell yet — a few more steps remain.

## Configuring Lidarr

### Service Setup

The built-in updater is off by default. The `pkg-message` gives instructions on how to turn it on, but be aware: enabling it can break `pkg check -s` and `pkg remove` for Lidarr when the updater replaces files.

To enable the service:

```shell
sysrc lidarr_enable=TRUE
```

If you don't want to run under user/group `lidarr`, tell the service file which user/group to use:

```shell
sysrc lidarr_user="USER_YOU_WANT"
```

```shell
sysrc lidarr_group="GROUP_YOU_WANT"
```

`lidarr` stores its data, config, logs, and PID files in `/usr/local/lidarr` by default. The service file creates this directory and takes ownership of it only if it doesn't exist. To store these files elsewhere (for example, a dataset mounted into the jail for easier snapshots), change the path using `sysrc`:

```shell
sysrc lidarr_data_dir="DIR_YOU_WANT"
```

If you use an existing location, manually change ownership to the UID/GID `lidarr` uses, or add `lidarr` to a GID that has write access.

Start the service:

```shell
service lidarr start
```

If everything went according to plan, Lidarr should be running on the IP of the jail (port 8686).

You can now close the shell.

## Troubleshooting

- The service appears to be running but the UI isn't loading or the page is timing out
  - Double check that `allow_mlock` is on in the jail

- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail, ip6=inherit, or ip6=new

> The service script works around the lack of VNET and/or IP6, so VNET or ip6=inherit isn't required.
{.is-info}
