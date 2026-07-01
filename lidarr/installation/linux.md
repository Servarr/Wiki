---
title: Lidarr Linux Installation
description: Linux installation guide for Lidarr
published: true
date: 2026-06-07T00:00:00.000Z
tags: lidarr, installation, linux
editor: markdown
dateCreated: 2023-07-03T20:10:49.328Z
---

# Linux

## Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

### Easy Install

For the Debian / Ubuntu / Raspbian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](#debian--ubuntu-hands-on-install) steps further below.**

[Please see the \*Arr Community Installation Script](/install-script)

### Debian / Ubuntu Hands on Install

*It is assumed you have a basic knowledge of linux or the ability to google / learn as necessary. Otherwise it is suggested to use an OS you know and understand*

You'll need to install the binaries using the below commands.

> The steps below will download Lidarr and install it into `/opt`
> Lidarr will run under the user `lidarr` and group `media`
> Lidarr's configuration files will be stored in `/var/lib/lidarr`
{.is-success}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl mediainfo sqlite3 libchromaprint-tools wget
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `lidarr` is created
> \* The user `lidarr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* You created the directory `/var/lib/lidarr` and ensured the user `lidarr` has read/write permissions for it
{.is-success}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
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

> This assumes you have created the user and will run as the user `lidarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Lidarr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell
sudo chown -R lidarr:media /opt/Lidarr
```

- Configure systemd so Lidarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/lidarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Lidarr` simply remove the `-data` argument. Note: that `$USER` is the User Lidarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/lidarr.service > /dev/null
[Unit]
Description=Lidarr Daemon
After=syslog.target network.target
[Service]
User=lidarr
Group=media
UMask=0002
Type=simple

ExecStart=/opt/Lidarr/Lidarr -nobrowser -data=/var/lib/lidarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
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

- (Optional) Remove the tarball:

```shell
rm Lidarr*.linux*.tar.gz
```

Typically to access the Lidarr web GUI browse to `http://{Your server IP Address}:8686`

If Lidarr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u lidarr
```

> If Lidarr v3+ fails to start on older end-of-life systems (Debian 10, Debian 11, Synology DSM, Ubuntu 18, Ubuntu 20) due to SQLite/GLIBC compatibility issues, see the [SQLite version workaround](#sqlite-version-workaround) below.
{.is-info}

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop lidarr
sudo rm -rf /opt/Lidarr
sudo rm -rf /var/lib/lidarr
sudo rm -rf /etc/systemd/system/lidarr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop lidarr
sudo rm -rf /opt/Lidarr
sudo rm -rf /etc/systemd/system/lidarr.service
sudo systemctl -q daemon-reload
```

# Troubleshooting

## SQLite version workaround on older systems

{#sqlite-version-workaround}

> This workaround is only for older end-of-standard-support systems with outdated GLIBC / SQLite. It is **not** a fix for SQLite corruption errors — those have a completely different recovery path; see [FAQ → Database disk image is malformed](/lidarr/faq#i-am-getting-an-error-database-disk-image-is-malformed).
{.is-warning}

Lidarr v3 and later uses a bundled SQLite build that requires newer GLIBC than ships with end-of-standard-support distributions. Affected systems include Debian 10, Debian 11, Ubuntu 18.04, Ubuntu 20.04, and some Synology DSM versions. If Lidarr fails to start with SQLite initialisation errors (as opposed to corruption errors), you can force it to link against the distribution's own SQLite library instead.

### Solution

Symlink the system SQLite library into Lidarr's install directory under the name Lidarr expects:

```bash
# First, ensure libsqlite3-0 is installed (not just sqlite3):
sudo apt update
sudo apt install libsqlite3-0

# Navigate to Lidarr installation directory
cd /opt/Lidarr/

# Backup the bundled library
mv libe_sqlite3.so libe_sqlite3.so.backup 2>/dev/null || true

# Create the symlink. The library path depends on your architecture:
# - amd64/x64: /usr/lib/x86_64-linux-gnu/libsqlite3.so.0
# - arm64:     /usr/lib/aarch64-linux-gnu/libsqlite3.so.0
# - armhf:     /usr/lib/arm-linux-gnueabihf/libsqlite3.so.0

# For amd64:
ln -s /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 libe_sqlite3.so

# Verify the symlink
ls -la libe_sqlite3.so
```

Restart Lidarr after creating the symlink.

> Every Lidarr update replaces the files in `/opt/Lidarr/`, so the symlink has to be recreated after each update. If you're using this workaround, script the symlink into your update procedure.
{.is-info}

### When to use this workaround

- You are running an older end-of-life distribution (Debian 10, Debian 11, Ubuntu 18.04, Ubuntu 20.04, older Synology DSM).
- Lidarr fails to start with SQLite initialisation errors at startup.
- The error is not related to an existing database file being corrupt.
- Your system SQLite is at least version 3.9.0.

### When NOT to use this workaround

- You have database corruption — see [FAQ → Database disk image is malformed](/lidarr/faq#i-am-getting-an-error-database-disk-image-is-malformed).
- You are on a modern, supported distribution. Upgrade the distribution instead; older distributions accumulate other issues beyond SQLite and this workaround does not address them.
- Lidarr starts normally. The workaround replaces a working library with another working library; there is no benefit.
