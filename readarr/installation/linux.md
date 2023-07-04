---
title: Readarr Linux Installation
description: Linux installation guide for Readarr
published: true
date: 2023-07-03T20:30:47.519Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:11:02.991Z
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

> The steps below will download Readarr and install it into `/opt`
> Readarr will run under the user `readarr` and group `media`; `media` is the commonly suggested group to run the \*Arrs, download clients, and media server under.
> Readarr's configuration files will be stored in `/var/lib/readarr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `readarr` is created
> \* The user `readarr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* If Calibre will be used, Calibre runs as the group `media` and the Calibre library has read/write permissions for `media`
> \* You created the directory `/var/lib/readarr` and ensured the user `readarr` has read/write permissions for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://readarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Readarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Readarr /opt/
```

> Note: This assumes you have created the user and will run as the user `readarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Readarr. Please note that if use wish to use Calibre - Readarr will need permissions for that directory.
{.is-danger}

- Ensure ownership of the binary directory.

```shell  
sudo chown readarr:readarr -R /opt/Readarr
```

- Configure systemd so Readarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/readarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Readarr` simply remove the `-data` argument. Note: that `$USER` is the User Readarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/readarr.service > /dev/null
[Unit]
Description=Readarr Daemon
After=syslog.target network.target
[Service]
User=readarr
Group=media
Type=simple

ExecStart=/opt/Readarr/Readarr -nobrowser -data=/var/lib/readarr/
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

- Enable the Readarr service:

```shell
sudo systemctl enable --now -q readarr
```

- (Optional) Remove the tarball:

```shell
rm Readarr*.linux*.tar.gz
```

Typically to access the Readarr web GUI browse to `http://{Your server IP Address}:8787`

If Readarr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u readarr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop readarr
sudo rm -rf /opt/Readarr
sudo rm -rf /var/lib/readarr
sudo rm -rf /etc/systemd/system/readarr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop readarr
sudo rm -rf /opt/Readarr
sudo rm -rf /etc/systemd/system/readarr.service
sudo systemctl -q daemon-reload
```