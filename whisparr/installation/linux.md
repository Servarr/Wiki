---
title: Whisparr Linux Installation
description: Linux installation guide for Lidarr
published: true
date: 2023-07-03T20:26:42.229Z
tags: installation, linux, ubuntu, debian, setup, guide, whisparr
editor: markdown
dateCreated: 2022-04-03T03:49:24.491Z
---

# Linux

## Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

### Easy Install

For the Debian / Ubuntu / Raspbian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](#debian-ubuntu-hands-on-install) steps further below.**

[Please see the \*Arr Community Installation Script](/install-script)

### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Whisparr and install it into `/opt`
> Whisparr will run under the user `whisparr` and group `media`; `media` is the commonly suggested group to run the \*Arrs, download clients, and media server under.
> Whisparr's configuration files will be stored in `/var/lib/whisparr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `whisparr` is created
> \* The user `whisparr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* You created the directory `/var/lib/whisparr` and ensured the user `whisparr` has read/write permissions for it for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://whisparr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Whisparr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Whisparr /opt/
```

> Note: This assumes you will run as the user `whisparr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Whisparr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell
sudo chown whisparr:whisparr -R /opt/Whisparr
```

- Configure systemd so Whisparr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/whisparr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Whisparr` simply remove the `-data` argument. Note: that `$USER` is the User Whisparr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/whisparr.service > /dev/null
[Unit]
Description=Whisparr Daemon
After=syslog.target network.target
[Service]
User=whisparr
Group=media
Type=simple

ExecStart=/opt/Whisparr/Whisparr -nobrowser -data=/var/lib/whisparr/
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

- Enable the Whisparr service:

```shell
sudo systemctl enable --now -q whisparr
```

- (Optional) Remove the tarball:

```shell
rm Whisparr*.linux*.tar.gz
```

Typically to access the Whisparr web GUI browse to `http://{Your server IP Address}:6969`

If Whisparr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u whisparr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop whisparr
sudo rm -rf /opt/Whisparr
sudo rm -rf /var/lib/whisparr
sudo rm -rf /etc/systemd/system/whisparr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop whisparr
sudo rm -rf /opt/Whisparr
sudo rm -rf /etc/systemd/system/whisparr.service
sudo systemctl -q daemon-reload
```
