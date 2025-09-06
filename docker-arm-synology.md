---
title: Installing Docker on a Synology ARM NAS
description: Step-by-step guide for installing Docker on ARM-based Synology NAS devices and running Servarr applications
published: true
date: 2022-05-18T15:47:17.201Z
tags: docker, synology, arm, installation, nas
editor: markdown
dateCreated: 2021-07-12T20:22:05.719Z
---

# Introduction

Synology only offer a Docker package on their `x64` based NAS. Using this method to install Docker on an `aarch64` NAS is totally unsupported/untested and totally at your own risk. It is entirely possible it will destroy your NAS.

> Again, this method to install Docker on an `aarch64` NAS is **totally
unsupported/untested** and totally at your own risk. It is entirely
possible it will destroy your NAS. {.is-danger}

# Summary

The instructions below will:

1. Place the Docker binaries in `/usr/local/bin/`
1. Create a Docker config file `/usr/local/etc/docker/docker.json`
1. Configure Docker to save its data to `/volume1/docker/var`
1. Create a script to start Docker on boot at `/usr/local/etc/rc.d/docker.sh`
1. Create a `docker` group
1. Place a docker-compose script in `/usr/local/bin/`

# Installation

1. [Login to your Synology via SSH and elevate to `root`](https://kb.synology.com/en-global/DSM/tutorial/How_to_login_to_DSM_with_root_permission_via_SSH_Telnet)

1. Execute the following command:

```bash
curl https://gist.githubusercontent.com/ta264/2b7fb6e6466b109b9bf9b0a1d91ebedc/raw/b76a28d25d0abd0d27a0c9afaefa0d499eb87d3d/get-docker.sh | sh
```

If all goes well you should see the message:

```none
Done. Please add your user to the Docker group in the Synology GUI and reboot your NAS.
```

Do as it says:

1. Add your user to the new `docker` group using the Synology GUI
1. **Reboot.**

Hopefully you have functioning `docker` and `docker-compose` commands, which should work when logged in as your normal user.

# Caveats

1. It seems most ARM Synology don't support seccomp, so the Docker
    container has unfettered access to your system (even more so than
    with a regular docker).
1. Again, due to Synology constraints, all containers need to use
    `--network=host` (or `network_mode: host` in compose) and everything will
    be directly accessible from the host. There are no port maps.
1. Obviously you can only run aarch64 images, but most hotio and
    linuxserver images offer an aarch64 version.

# Setting up a Docker GUI

If you want a GUI you can run Portainer using the following example
compose:

```yml
    version: '2'

    services:
      portainer:
        image: portainer/portainer
        restart: unless-stopped
        network_mode: host
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
          - portainer_data:/data

    volumes:
      portainer_data:
```

Place this in a file called `docker-compose.yml` in an otherwise empty directory. Run:

```shell
docker-compose up -d
```

Visit [`http://ip:9000`](http://ip:9000) to complete setup (where `ip` is the IP address of your synology).

# Setting up Sonarr/Radarr/Lidarr/Readarr

For guidance setting up Sonarr/Radarr/Lidarr/Readarr, see the [Docker Guide](/docker-guide), and **remember caveat 2 above.**
