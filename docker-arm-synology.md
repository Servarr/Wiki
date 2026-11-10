---
title: Installing Docker on a Synology ARM NAS
description: Step-by-step guide for installing Docker on ARM-based Synology NAS devices and running Servarr applications
published: true
date: 2022-05-18T15:47:17.201Z
tags: docker, synology, arm, installation, nas, deprecated
editor: markdown
dateCreated: 2021-07-12T20:22:05.719Z
---

> **This guide is outdated and deprecated.** It dates from 2021 and relies on an unmaintained third-party bootstrap that installs Docker 20.10.0 and Docker Compose v1 (`docker-compose`). The steps below replace Compose v1. It has not been validated against current DSM releases and may no longer work. Prefer Synology's official Container Manager on supported hardware; use this only if you understand the risks. {.is-warning}

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

Hopefully you have a functioning `docker` command, which should work when logged in as your normal user.

## Replace Docker Compose v1 with the Compose v2 plugin

The script installs `docker-compose` as a wrapper that runs Compose v1.29.2 inside a container. That version is no longer maintained and has known problems on these devices. For example, `docker-compose -f /path/to/docker-compose.yml` can fail to find a file that exists, and secrets files referenced in a compose file can fail to load.

Replace it with the official Compose v2 plugin. As `root`, run:

```bash
rm -f /usr/local/bin/docker-compose
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL --fail https://github.com/docker/compose/releases/latest/download/docker-compose-linux-aarch64 -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
```

Then confirm it works as your normal user:

```bash
docker compose version
```

Compose v2 is a `docker` subcommand, so use `docker compose` (with a space) wherever older guides show `docker-compose`. To update Compose later, run the `curl` command again.

For more detail, see Docker's [manual plugin installation instructions](https://docs.docker.com/compose/install/linux/#install-the-plugin-manually).

# Caveats

1. It seems most ARM Synology don't support seccomp, so the Docker
    container has unfettered access to your system (even more so than
    with a regular docker).
1. Again, due to Synology constraints, all containers need to use
    `--network=host` (or `network_mode: host` in compose) and everything will
    be directly accessible from the host. There are no port maps.
1. Obviously you can only run aarch64 images, but most hotio and
    linuxserver images offer an aarch64 version.

# Monitoring containers

Manage your containers with `docker compose`. Avoid Portainer for creating or changing containers. The [Docker Guide](/docker-guide#portainer) explains why.

If you want a lightweight view of running containers, [ctop](https://github.com/bcicen/ctop) is a terminal tool that shows container status, resource usage, and logs. As `root`, run:

```bash
curl -SL --fail https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-arm64 -o /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop
```

Then run `ctop` as your normal user.

# Setting up Sonarr/Radarr/Lidarr/Readarr

For guidance setting up Sonarr/Radarr/Lidarr/Readarr, see the [Docker Guide](/docker-guide), and **remember caveat 2 above.**
