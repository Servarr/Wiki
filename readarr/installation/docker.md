---
title: Readarr Docker Installation
description: Docker installation guide for Readarr
published: true
date: 2023-08-12T16:02:33.082Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:12:28.883Z
---

# Docker

The Readarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Readarr Docker image.

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

There are two common problems with Docker volumes: Paths that differ between the Readarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Movie.2018/`, but in the Readarr container that might be at `/downloads/My.Movie.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/books` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Readarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Readarr web UI (Settings › Download Clients).

### Calibre Integration

When creating a root folder, you can choose to use Calibre integration or not. This choice can only be made during folder creation, and if you choose not to utilize Calibre you cannot add it later. If you currently use Calibre to manage your book library, you should choose this option. If you use it, Calibre will name and organize your book files for you.

If you are running Calibre, you must first start the Calibre Content Server (Preferences / Sharing over the net), and also set up a user and password. This will require a Calibre restart.

> Please note that Calibre Content Server and Calibre are NOT Calibre Web. Calibre Web is a separate tool unrelated to either of these programs, and is not required nor used by Readarr in any way.
{.is-warning}

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Readarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Readarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Readarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the :nightly or :develop tags with docker images, as there is no master branch. [See this FAQ entey for the meaning of the branches](/readarr/faq#how-do-i-update-readarr)
{.is-warning}

- [hotio/readarr](https://hotio.dev/containers/readarr/)
- [lscr.io/linuxserver/readarr](https://docs.linuxserver.io/images/docker-readarr)
{.links-list}