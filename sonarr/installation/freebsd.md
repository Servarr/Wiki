---
title: Sonarr FreeBSD Installation
description: FreeBSD installation guide for Sonarr
published: true
date: 2023-07-03T20:23:52.657Z
tags: sonarr
editor: markdown
dateCreated: 2021-07-10T16:07:37.425Z
---

# FreeBSD

The Sonarr team only provides builds for FreeBSD. Plugins and Ports are maintained and created by the FreeBSD community.

Instructions for FreeBSD installations are also maintained by the FreeBSD community and anyone with a GitHub account may update the wiki as needed.

[Freshports Sonarr Link](https://www.freshports.org/net-p2p/sonarr/)

## Jail Setup Using TrueNAS GUI

1. From the main screen select Jails

1. Click ADD

1. Click Advanced Jail Creation

1. Name (any name will work): Sonarr

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

1. After the jail is created it will start automatically. One more property is required to be set in order for Sonarr to see the storage space of your mounted media locations. Open a root shell on the server and enter these commands:

```shell
iocage stop <jailname>
iocage set enforce_statfs=1 <jailname>
iocage start <jailname>
```

## Jail Setup Using CLI

Assumes iocage is installed and configured (<https://iocage.readthedocs.io/en/latest/install.html>)
Assumes iocage network bridge (vnet) is configured (<https://iocage.readthedocs.io/en/latest/networking.html>)

Replace "10.0.0.100" with an open IPV4 address on your network
Replace "13.1-RELEASE" with preferred FreeBSD version
Replace "sonarr" with your preferred jail name
Replace "accept_rtadv" or remove ip6_addr if you do not want auto configure IPV6

```shell
iocage create -n "sonarr" -r 13.1-RELEASE ip4_addr="vnet0|10.0.0.100/24" vnet="on" allow_raw_sockets="1" boot="on" allow_mlock="1" ip6_addr="vnet0|accept_rtadv" enforce_statfs="1"
iocage console sonarr
```

## Sonarr Mono Installation

Back on the jails list find your newly created jail for `sonarr` and click "Shell"

To install Sonarr

> \* Ensure your pkg repo is configured to get packages from `/latest` and not `/quarterly`
> \* Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
> \* If that does not exist, copy over `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

```shell
pkg install sonarr
```

Don't close the shell out yet we still have a few more things!

## Sonarr .NET Installation

Back on the jails list find your newly created jail for `sonarr` and click "Shell"

To install Sonarr

> \* Ensure your pkg repo is configured to get packages from `/latest` and not `/quarterly`
> \* Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
> \* If that does not exist, copy over `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

Install the following libraries to support sonarr

```shell
pkg install icu libunwind krb5 libnotify libinotify sqlite3
```

Create Sonarr User and Group (If you do not want to use user/group 'sonarr' it can be changed based on preference)

```shell
pw user add sonarr -c sonarr -u 351 -d /nonexistent -s /usr/bin/nologin
```

Download the latest version from <https://services.sonarr.tv/v1/download/develop/latest?version=4&os=freebsd&arch=x64> and set its permissions

```shell
curl -J -L "https://services.sonarr.tv/v1/download/develop/latest?version=4&os=freebsd&arch=x64" -o Sonarr.develop.freebsd-x64.tar.gz
tar -xvf Sonarr.develop.freebsd-x64.tar.gz -C /usr/local/share
chown -R sonarr:sonarr /usr/local/share/Sonarr
```

Create a rc.subr script to run Sonarr as a daemon in an editor of your choice (you may be able to skip line 1 if the folder already exists) and use the contents of sonarr rc.subr below

```shell
mkdir -p /usr/local/etc/rc.d
vi /usr/local/etc/rc.d/sonarr
chmod +x /usr/local/etc/rc.d/sonarr
```

```shell
#!/bin/sh

# PROVIDE: sonarr
# REQUIRE: LOGIN
# KEYWORD: shutdown
#
# Add the following lines to /etc/rc.conf.local or /etc/rc.conf
# to enable this service:
#
# sonarr_enable:   Set to yes to enable the sonarr service.
#                       Default: no
# sonarr_user:     The user account used to run the sonarr daemon.
#                       This is optional, however do not specifically set this to an
#                       empty string as this will cause the daemon to run as root.
#                       Default: sonarr
# sonarr_group:    The group account used to run the sonarr daemon.
#                       This is optional, however do not specifically set this to an
#                       empty string as this will cause the daemon to run with group wheel.
#                       Default: sonarr
# sonarr_data_dir: Directory where sonarr configuration data is stored.
#                       Default: /var/db/sonarr
# sonarr_pid:      Name of the pid file.
#                       Default: sonarr.pid
# sonarr_pid_dir:  Path of the pid file.
#                       Default: /var/run/sonarr

. /etc/rc.subr
name=sonarr
rcvar=${name}_enable
load_rc_config ${name}

: ${sonarr_enable:="no"}
: ${sonarr_user:="sonarr"}
: ${sonarr_group:="sonarr"}
: ${sonarr_data_dir:="/var/db/sonarr"}
: ${sonarr_pid:="sonarr.pid"}
: ${sonarr_pid_dir:="/var/run/sonarr"}

pidfile="${sonarr_pid_dir}/${sonarr_pid}"
command="/usr/sbin/daemon"
command_args="-r -f -P ${pidfile} /usr/local/share/Sonarr/Sonarr --debug --data=${sonarr_data_dir} --nobrowser"

start_precmd=sonarr_start_precmd
sonarr_start_precmd()
{
 [ -d ${sonarr_pid_dir} ] || install -d -g ${sonarr_group} -o ${sonarr_user} ${sonarr_pid_dir}
 [ -d ${sonarr_data_dir} ] || install -d -g ${sonarr_group} -o ${sonarr_user} ${sonarr_data_dir}

 # .NET 6+ uses dual mode sockets to avoid the separate AF handling.
 # disable .NET use of V6 if no ipv6 is configured.
 # See https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=259194#c17
 ifconfig | grep -q inet6
 if [ $? == 1 ]; then
  export DOTNET_SYSTEM_NET_DISABLEIPV6=1
 fi
}

run_rc_command "$1"
```

Don't close the shell out yet we still have a few more things!

## Configuring Sonarr

Now that we have it installed a few more steps are required.

### Service Setup

Time to enable the service but before we do, a note:

The updater is disabled by default. The `pkg-message` gives instructions on how to enable the updater but keep in mind: this can break things like `pkg check -s` and `pkg remove` for Sonarr when the built-in updater replaces files.

To enable the service:

```shell
sysrc sonarr_enable=TRUE
```

If you do not want to use user/group `sonarr` you will need to tell the service file what user/group it should be running under

```shell
sysrc sonarr_user="USER_YOU_WANT"
```

```shell
sysrc sonarr_group="GROUP_YOU_WANT"
```

`sonarr` stores its data, config, logs, and PID files in `/usr/local/sonarr` by default. The service file will create this and take ownership of it IF AND ONLY IF IT DOES NOT EXIST. If you want to store these files in a different place (e.g., a dataset mounted into the jail for easier snapshots) then you will need to change it using `sysrc`

```shell
sysrc sonarr_data_dir="DIR_YOU_WANT"
```

Reminder: If you are using an existing location then you will manually need to either: change the ownership to the UID/GID `sonarr` uses AND/OR add `sonarr` to a GID that has write access.

Almost done, let's start the service:

```shell
service sonarr start
```

If everything went according to plan then sonarr should be up and running on the IP of the jail (port 8989)!

You can now safely close the shell

## Troubleshooting

- The service appears to be running but the UI is not loading or the page is timing out
  - Double check that `allow_mlock` is enabled in the jail

- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail, ip6=inherit, or ip6=new

> The service script should now work around the lack of VNET and/or IP6 thus removing the requirement for VNET or ip6=inherit
{.is-info}

### BSD Mono SSL Issues

- SSL or other Certificate issues (i.e. `unable to verify SSL certificate`)
  - See [this TrueNAS forum post as you'll need to update and sync mono's certs](https://www.truenas.com/community/threads/sonarr-radarr-probably-other-arr-jails-unable-to-verify-ssl-certificates-after-latest-update.96008/)
