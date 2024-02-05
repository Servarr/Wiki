---
title: Whisparr FreeBSD Installation
description: FreeBSD installation guide for Lidarr
published: true
date: 2023-07-03T20:26:42.229Z
tags: 
editor: markdown
dateCreated: 2022-04-03T03:49:24.491Z
---

# FreeBSD

The Whisparr team only provides builds for FreeBSD. Plugins and Ports are maintained and created by the FreeBSD community.

Instructions for FreeBSD installations are also maintained by the FreeBSD community and anyone with a GitHub account may update the wiki as needed.

> Currently the BSD Community does not have any package or port available
{.is-danger}

[Freshports Whisparr Link](https://www.freshports.org/net-p2p/whisparr/)

## Jail Setup Using TrueNAS GUI

1. From the main screen select Jails

1. Click ADD

1. Click Advanced Jail Creation

1. Name (any name will work): Whisparr

1. Jail Type: Default (Clone Jail)

1. Release: 12.2-Release (or newer)

1. Configure Basic Properties to your liking

1. Configure Jail Properties to your liking but add

- [x] allow_mlock

- [x] allow_raw_sockets

> `allow_raw_sockets` is helpful for troubleshooting (e.g. ping, traceroute) but is not a requirement. {.is-info}

1. Configure Network Properties to your liking

1. Configure Custom Properties to your liking

1. Click Save

1. After the jail is created it will start automatically. One more property is required to be set in order for Whisparr to see the storage space of your mounted media locations. Open a root shell on the server and enter these commands:

```shell
iocage stop <jailname>
iocage set enforce_statfs=1 <jailname>
iocage start <jailname>
```

## Whisparr Installation

Back on the jails list find your newly created jail for `whisparr` and click `Shell`

To install Whisparr

> \* Ensure your pkg repo is configured to get packages from `/latest` and not `/quarterly`
> \* Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
> \* If that does not exist, copy over `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

> Currently the BSD Community does not have any package or port available
{.is-danger}

```shell
pkg install whisparr
```

Don't close the shell out yet we still have a few more things!

## Configuring Whisparr

Now that we have it installed a few more steps are required.

### Service Setup

Time to enable the service but before we do, a note:

The updater is disabled by default. The `pkg-message` gives instructions on how to enable the updater but keep in mind: this can break things like `pkg check -s` and `pkg remove` for Whisparr when the built-in updater replaces files.

To enable the service:

```shell
sysrc whisparr_enable=TRUE
```

If you do not want to use user/group `whisparr` you will need to tell the service file what user/group it should be running under

```shell
sysrc whisparr_user="USER_YOU_WANT"
```

```shell
sysrc whisparr_group="GROUP_YOU_WANT"
```

`whisparr` stores its data, config, logs, and PID files in `/usr/local/whisparr` by default. The service file will create this and take ownership of it IF AND ONLY IF IT DOES NOT EXIST. If you want to store these files in a different place (e.g., a dataset mounted into the jail for easier snapshots) then you will need to change it using `sysrc`

```shell
sysrc whisparr_data_dir="DIR_YOU_WANT"
```

Reminder: If you are using an existing location then you will manually need to either: change the ownership to the UID/GID `whisparr` uses AND/OR add `whisparr` to a GID that has write access.

Almost done, let's start the service:

```shell
service whisparr start
```

If everything went according to plan then whisparr should be up and running on the IP of the jail (port 6969)!

You can now safely close the shell

## Troubleshooting

- The service appears to be running but the UI is not loading or the page is timing out
  - Double check that `allow_mlock` is enabled in the jail

- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail, ip6=inherit, or ip6=new

> The service script should now work around the lack of VNET and/or IP6 thus removing the requirement for VNET or ip6=inherit
{.is-info}
