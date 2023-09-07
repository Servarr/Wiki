---
title: Radarr Linux Installation
description: Linux installation guide for Radarr
published: true
date: 2023-09-07T20:43:01.533Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:11:59.391Z
---

# Linux

## Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

### Easy Install

For the Debian / Ubuntu / Raspbian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](#debian-ubuntu-hands-on-install) steps further below.**

[Please see the \*Arr Community Installation Script](/install-script)

> Radarr uses a bundled version of ffprobe for media file analysis and does not require ffprobe or ffmpeg to be installed on the system.  If Radarr says Ffprobe is not found this can typically be fixed with a reinstall.
{.is-info}

### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download the stable version (`master` release branch) Radarr and install it into `/opt`
> Radarr will run under the user `radarr` and group `media`; `media` is the commonly suggested group to run the \*Arrs, download clients, and media server under.
> Radarr's configuration files will be stored in `/var/lib/radarr`
{.is-success}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `radarr` is created
> \* The user `radarr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* You created the directory `/var/lib/radarr` and ensured the user `radarr` has read/write permissions for it for it
> \* Previous/existing installations were using the `master` release branch noted on the [FAQ](/radarr/faq) or you update `master` in the download URL
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-success}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Radarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Radarr /opt/
```

> Note: This assumes you will run as the user `radarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Radarr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell  
sudo chown radarr:radarr -R /opt/Radarr
```

- Configure systemd so Radarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/radarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Radarr` simply remove the `-data` argument. Note: that `$USER` is the User Radarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/radarr.service > /dev/null
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=radarr
Group=media
Type=simple

ExecStart=/opt/Radarr/Radarr -nobrowser -data=/var/lib/radarr/
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

- Enable the Radarr service:

```shell
sudo systemctl enable --now -q radarr
```

- (Optional) Remove the tarball:

```shell
rm Radarr*.linux*.tar.gz
```

Typically to access the Radarr web GUI browse to `http://{Your server IP Address}:7878`

> Radarr uses a bundled version of ffprobe for media file analysis and does not require ffprobe or ffmpeg to be installed on the system.  If Radarr says Ffprobe is not found this can typically be fixed with a reinstall.
{.is-info}

If Radarr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u radarr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop radarr
sudo rm -rf /opt/Radarr
sudo rm -rf /var/lib/radarr
sudo rm -rf /etc/systemd/system/radarr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop radarr
sudo rm -rf /opt/Radarr
sudo rm -rf /etc/systemd/system/radarr.service
sudo systemctl -q daemon-reload
```