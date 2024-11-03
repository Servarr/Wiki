---
title: Sonarr Linux Installation
description: Linux installation guide for Sonarr
published: true
date: 2024-04-05T19:14:26.741Z
tags: sonarr
editor: markdown
dateCreated: 2023-07-03T20:13:25.657Z
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

*It is assumed you have a basic knowledge of linux or the ability to google / learn as necessary. Otherwise it is suggested to use an OS you know and understand*

You'll need to install the binaries using the below commands.

> The steps below will download the stable version (`main` release branch) Sonarr and install it into `/opt`
> Sonarr will run under the user `sonarr` and group `media`; `media` is the commonly suggested group to run the \*Arrs, download clients, and media server under.
> Sonarr's configuration files will be stored in `/var/lib/sonarr`
{.is-success}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `sonarr` is created
> \* The user `sonarr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* You created the directory `/var/lib/sonarr` and ensured the user `sonarr` has read/write permissions for it for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-success}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'https://services.sonarr.tv/v1/download/main/latest?version=4&os=linux&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Sonarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Sonarr /opt/
```

> Note: This assumes you will run as the user `sonarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Sonarr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell
sudo chown sonarr:sonarr -R /opt/Sonarr
```

- Configure systemd so Sonarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/sonarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Sonarr` simply remove the `-data` argument. Note: that `$USER` is the User Sonarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/sonarr.service > /dev/null
[Unit]
Description=Sonarr Daemon
After=syslog.target network.target
[Service]
User=sonarr
Group=media
Type=simple

ExecStart=/opt/Sonarr/Sonarr -nobrowser -data=/var/lib/sonarr/
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

- Enable the Sonarr service:

```shell
sudo systemctl enable --now -q sonarr
```

- (Optional) Remove the tarball:

```shell
rm Sonarr*.linux*.tar.gz
```

Typically to access the Sonarr web GUI browse to `http://{Your server IP Address}:8989`

If Sonarr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u sonarr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop sonarr
sudo rm -rf /opt/Sonarr
sudo rm -rf /var/lib/sonarr
sudo rm -rf /etc/systemd/system/sonarr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop sonarr
sudo rm -rf /opt/Sonarr
sudo rm -rf /etc/systemd/system/sonarr.service
sudo systemctl -q daemon-reload
```
