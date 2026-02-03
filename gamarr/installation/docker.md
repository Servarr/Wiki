---
title: Gamarr Docker Installation
description: Docker installation guide for Gamarr
published: true
date: 2025-02-02T00:00:00.000Z
tags: docker, installation, gamarr
editor: markdown
dateCreated: 2025-02-02T00:00:00.000Z
---

# Docker

These instructions provide generic guidance that should apply to any Gamarr Docker image.

Synology Users can see [TRaSH's Synology Docker Guide](https://trash-guides.info/Hardlinks/How-to-setup-for/Synology/)

## Portainer

> **Portainer should be avoided for setting up docker containers** {.is-danger}

- Portainer gives a pretty GUI for managing containers, but that is all it is useful for.
- Portainer should only for viewing docker container logs / container status.
- It's strongly suggested to use Docker compose and to not use Portainer.
- Portainer has many issues, such as:
  - Incorrect order of source and target of mounts
  - Inconsistent case-sensitivity
  - No automatically created custom networks for inter-container communication
  - Inconsistent compose implementations on different architectures
  - Pulls every tag on update when you don't set a specific tag
  - Capabilities are hidden and some don't work at all on ARM platforms

See this [Docker Guide](/docker-guide) and [TRaSH's Docker Tutorial](https://trash-guides.info/hardlinks/) instead for how to setup Docker Compose.

## Avoid Common Pitfalls

### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Gamarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Game/`, but in the Gamarr container that might be at `/downloads/My.Game/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/games` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Gamarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Games would be in `/data/Games`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Gamarr web UI (Settings › Download Clients).

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Gamarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Gamarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Gamarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [ghcr.io/gamarr-app/gamarr](https://github.com/gamarr-app/Gamarr/pkgs/container/gamarr)
{.links-list}
