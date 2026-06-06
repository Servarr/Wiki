---
title: Lidarr Docker Installation
description: Docker installation guide for Lidarr
published: true
date: 2026-06-06T14:51:35.308Z
tags: lidarr, docker, installation
editor: markdown
dateCreated: 2023-07-03T20:10:37.188Z
---

## Docker

The Lidarr team doesn't offer an official Docker image. Third parties have created and maintain their own.

These instructions provide generic guidance that applies to any Lidarr Docker image.

## Avoid Portainer

> Avoid Portainer for setting up Docker containers.
{.is-danger}

Portainer gives a pretty GUI for managing containers, but that's all it's useful for. Use it only for viewing Docker container logs and status.

Use Docker Compose instead. Portainer has many issues:

- Incorrect order of source and target of mounts
- Inconsistent case-sensitivity
- No automatically created custom networks for inter-container communication
- Inconsistent Compose implementations on different architectures
- Pulls every tag on update when you don't set a specific tag
- Capabilities hidden and some don't work at all on ARM platforms

See the [Docker Guide](/docker-guide) and [TRaSH's Docker Tutorial](https://trash-guides.info/hardlinks/) for how to set up Docker Compose.

## Avoid Common Pitfalls

### Volumes and Paths

Two common problems with Docker volumes: paths that differ between the Lidarr and download client container, and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Music.2018/`, but in the Lidarr container that might be at `/downloads/My.Music.2018/`. The second is a performance issue and causes problems for seeding torrents. Well-planned, consistent paths fix both.

Most Docker images suggest paths like `/music` and `/downloads`. This causes slow moves and doesn't allow hard links because they're considered two different file systems inside the container. Some also recommend paths for the download client container that differ from the Lidarr container, like `/torrents`.

The best solution is a single, common volume inside the containers, such as `/data`. Your music would be at `/data/Music`, torrents at `/data/downloads/torrents`, and Usenet downloads at `/data/downloads/usenet`.

If you don't follow this, you may have to configure a Remote Path Mapping in the Lidarr web UI (Settings → Download Clients).

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Lidarr users, both inside and outside Docker. Most images have environment variables that can override the default user, group, and umask. Decide on these before setting up all your containers. Use a common group for all related containers so each can use the shared group permissions to read and write files on the mounted volumes.

Lidarr needs read and write access to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide).
{.is-info}

## Install Lidarr

To install and use these Docker images, keep the above in mind while following their documentation. Installation and maintenance will depend on which route you choose.

- [hotio/lidarr](https://hotio.dev/containers/lidarr/)
- [lscr.io/linuxserver/lidarr](https://docs.linuxserver.io/images/docker-lidarr)
{.links-list}
