---
title: Prowlarr Linux Installation
description: Linux installation guide for Prowlarr
published: true
date: 2024-02-06T01:19:36.117Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:11:24.804Z
---

# Linux

## Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

### Easy Install

For the Debian / Ubuntu / Raspbian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](#debian-ubuntu-hands-on-install) steps further below.**

-[Please see the \*Arr Community Installation Script](/install-script)
{.links-list}

### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Prowlarr and install it into `/opt`
> Prowlarr will run under the user `prowlarr` and group `prowlarr`
> Prowlarr's configuration files will be stored in `/var/lib/prowlarr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `prowlarr` is created
> \* You created the directory `/var/lib/prowlarr` and ensured the user `prowlarr` has read/write permissions for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://prowlarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Prowlarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Prowlarr/ /opt
```

> This assumes you have created the user and will run as the user `prowlarr` and group `prowlarr`. You may change this to fit your usecase.
{.is-danger}

- Ensure ownership of the binary directory.

```shell  
sudo chown prowlarr:prowlarr -R /opt/Prowlarr
```

- Configure systemd so Prowlarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/prowlarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Prowlarr` simply remove the `-data` argument. Note: that `$USER` is the User Prowlarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/prowlarr.service > /dev/null
[Unit]
Description=Prowlarr Daemon
After=syslog.target network.target
[Service]
User=prowlarr
Group=prowlarr
Type=simple

ExecStart=/opt/Prowlarr/Prowlarr -nobrowser -data=/var/lib/prowlarr/
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

- Enable the Prowlarr service:

```shell
sudo systemctl enable --now -q prowlarr
```

- (Optional) Remove the tarball:

```shell
rm Prowlarr*.linux*.tar.gz
```

Typically to access the Prowlarr web GUI browse to `http://{Your server IP Address}:9696`

If Prowlarr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u prowlarr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop prowlarr
sudo rm -rf /opt/Prowlarr
sudo rm -rf /var/lib/prowlarr
sudo rm -rf /etc/systemd/system/prowlarr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop prowlarr
sudo rm -rf /opt/Prowlarr
sudo rm -rf /etc/systemd/system/prowlarr.service
sudo systemctl -q daemon-reload
```
