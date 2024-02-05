---
title: Prowlarr Docker Installation
description: Docker installation guide for Prowlarr
published: true
date: 2023-08-12T16:03:43.190Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:11:13.937Z
---

# Docker

The Prowlarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

> For a more detailed explanation of docker and suggested practices, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

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

## Install Prowlarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/prowlarr](https://hotio.dev/containers/prowlarr/)
- [lscr.io/linuxserver/prowlarr](https://docs.linuxserver.io/images/docker-prowlarr)
{.links-list}
