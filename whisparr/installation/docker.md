---
title: Whisparr Docker Installation
description: Docker installation guide for Whisparr
published: true
date: 2023-08-12T16:04:03.075Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:14:02.618Z
---

# Docker

The Whisparr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Whisparr Docker image.

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

There are two common problems with Docker volumes: Paths that differ between the Whisparr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Movie.2018/`, but in the Whisparr container that might be at `/downloads/My.Movie.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/movies` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Whisparr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Whisparr web UI (Settings › Download Clients).

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Whisparr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Whisparr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Whisparr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the :nightly ~~or :develop~~ tags with docker images, as there is no master nor develop branch. [See this FAQ entry for the meaning of the branches](/whisparr/faq#how-do-i-update-whisparr)
{.is-whisparr}

- [hotio/whisparr](https://hotio.dev/containers/whisparr/)
{.links-list}
