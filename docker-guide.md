---
title: Docker Guide
description: Servarr Docker Guide - Overview of Docker Concepts, Hardlink Concepts, and Linux Ownership and Permissions
published: true
date: 2023-07-15T20:36:22.693Z
tags: 
editor: markdown
dateCreated: 2021-05-16T20:23:46.192Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [The Best Docker Setup](#the-best-docker-setup)
- [Portainer](#portainer)
- [Introduction](#introduction)
- [Multiple users and a shared group](#multiple-users-and-a-shared-group)
  - [Permissions](#permissions)
  - [UMASK](#umask)
  - [PUID and PGID](#puid-and-pgid)
  - [Example](#example)
- [Single user and optional shared group](#single-user-and-optional-shared-group)
- [Ownership and permissions of /config](#ownership-and-permissions-of-config)
- [Consistent and well planned paths](#consistent-and-well-planned-paths)
  - [Examples](#examples)
    - [Torrents](#torrents)
    - [Usenet](#usenet)
    - [Media Server](#media-server)
    - [Sonarr, Radarr and Lidarr](#sonarr-radarr-and-lidarr)
  - [Issues](#issues)
- [Running containers using](#running-containers-using)
  - [Docker Compose](#docker-compose)
    - [Update all images and containers](#update-all-images-and-containers)
    - [Update individual image and container](#update-individual-image-and-container)
  - [docker run](#docker-run)
  - [Systemd](#systemd)
- [Helpful commands](#helpful-commands)
  - [List running containers](#list-running-containers)
  - [Shell *inside* a container](#shell-inside-a-container)
  - [Prune Docker](#prune-docker)
  - [Get docker run command](#get-docker-run-command)
  - [Get docker-compose](#get-docker-compose)
  - [Troubleshoot networking](#troubleshoot-networking)
  - [Recursively chown user and group](#recursively-chown-user-and-group)
  - [Recursively chmod to 775/664](#recursively-chmod-to-775664)
  - [Find UID/GID for user](#find-uidgid-for-user)
  - [Examine files for hard links](#examine-files-for-hard-links)
- [Interesting Docker Images](#interesting-docker-images)
- [Custom Docker Network and DNS](#custom-docker-network-and-dns)
- [Common Problems](#common-problems)
  - [Correct *outside* paths, incorrect *inside* paths](#correct-outside-paths-incorrect-inside-paths)
  - [Running Docker containers as root or changing users around](#running-docker-containers-as-root-or-changing-users-around)
  - [Running Docker containers with umask 000](#running-docker-containers-with-umask-000)
- [Getting Help](#getting-help)
  - [Chat Support (Discord)](#chat-support-discord)
  - [Forum Support (Reddit)](#forum-support-reddit)

# The Best Docker Setup

**TL;DR**: An [eponymous](https://www.lexico.com/en/definition/eponymous) user per daemon and a shared group with a umask of `002`. Consistent path definitions between *all* containers that maintains the folder structure. Using one volume (so the download folder and library folder are on the same file system)  makes [hardlinks](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/#what-are-hardlinks) and [instant moves (atomic moves)](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/#what-are-instant-moves-atomic-moves) possible for Sonarr, Radarr, Lidarr and Readarr. And most of all, ignore *most* of the Docker image’s path documentation!

> Note: Many folks find [TRaSH's Hardlink Tutorial](https://trash-guides.info/hardlinks/) helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.
{.is-info}

# Portainer

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

# Introduction

This article will not show you specifics about the best Docker setup, but it describes an overview that you can use to make your own setup the best that it can be. The idea is that you run each Docker container as its own user, with a shared group and consistent volumes so every container sees the same path layout. This is easy to say, but not so easy to understand and explain.

> Reminder that many folks find [TRaSH's Hardlink Tutorial](https://trash-guides.info/hardlinks/) helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.
{.is-warning}

# Multiple users and a shared group

## Permissions

Ideally, each software runs as its own user and they are all part of a shared group with folder permissions set to `775` (`drwxrwxr-x`) and files set to `664` (`-rw-rw-r--`), which is a umask of `002`. A sane alternative to this is a single shared user, which would use `755` and `644` which is a umask of `022`. You can restrict permissions even more by denying read from “other”, which would be a umask of `007` for a user per daemon or `077` for a single shared user. For a deeper explanation, try the Arch Linux wiki articles about [file permissions and attributes](https://wiki.archlinux.org/index.php/File_permissions_and_attributes) and [UMASK](https://wiki.archlinux.org/index.php/Umask).

## UMASK

Many Docker images accept `-e UMASK=002` as an environment variable and some software can be configured with a user, group and umask (NZBGet) or folder/file permission (Sonarr/Radarr), inside the container. This will ensure that files and folders created by *one* can be read and written by the others. If you are using existing folders and files, you will need to fix their current ownership and permissions too, but going forward they will be correct because you set each software up right.

## PUID and PGID

Many Docker images also take a `-e PUID=123` and `-e PGID=321` that lets you change the UID/GID used inside to that of an account on the outside. If you ever peek in, you’ll find that username is something like `abc`, `nobody` or `hotio`, but because it uses the UID/GID you pass in, on the outside it looks like the expected user. If you’re using storage from another system via NFS or CIFS, it will make your life easier if *that* system also has matching users and group. Perhaps let one system pick the UID/GIDs, then re-use those on the other system, assuming they don’t conflict.

## Example

You run [Sonarr](https://github.com/Sonarr/Sonarr/releases) using [hotio/sonarr](https://github.com/hotio/docker-sonarr), you’ve created a `sonarr` user with uid `123` and a shared group `media` with gid `321` which the `sonarr` user is a member of. You configure the Docker image to run with `-e PUID=123 -e PGID=321 -e UMASK=002`. Sonarr also lets you configure the user, group as well as folder and file permissions. The previous settings should negate these, but you could configure them if you wanted. An UMASK of `002` results in `775` (`drwxrwxr-x`) for folders and `664` (`-rw-rw-r--`) for files. and the user/group are a little tricky because *inside* the container, they have a different name. Typically they are `abc` or `nobody`.

# Single user and optional shared group

Another popular and arguably easier option is a single, shared user. Perhaps even *your* user. It isn’t as secure and doesn’t follow best practices, but in the end it is easier to understand and implement. The UMASK for this is `022` which results in `755` (`drwxr-xr-x`) for folders and `644` (`-rw-r--r--`) for files. The group no longer really matters, so you’ll probably just use the group named after the user. This does make it harder to share with *other* users, so you may still end up wanting a UMASK of `002` even with this setup.

# Ownership and permissions of /config

Don’t forget that your `/config` volume will *also* need to have correct ownership and permissions, usually the daemon’s user and that user’s group like `sonarr:sonarr` and a umask of `022` or `077` so *only* that user has access. In a single user setup, this would of course be the one user you’ve chosen.

# Consistent and well planned paths

> Many folks find [TRaSH's Hardlink Tutorial](https://trash-guides.info/hardlinks) helpful and easier to understand than this guide. This guide is more conceptual in nature while TRaSH's tutorial walks you through the process.
{.is-info}

The easiest and most important detail is to create unified path definitions across all the containers.

If you’re wondering why hardlinks aren’t working or why a simple move is taking far longer than it should, this section explains it. The paths you use on the *inside* matter. Because of how Docker’s volumes work, passing in two volumes such as the commonly suggested `/tv`, `/movies`, and `/downloads` makes them look like two different file systems, even if they are a single file system outside the container. This means hardlinks won’t work *and* instead of an instant/atomic move, a slower and more IO intensive copy+delete is used. If you have multiple download clients because you’re using torrents and usenet, having a single `/downloads` path means they’ll be mixed up. Because the Radarr in one container will ask the NZBGet in its own container where files are, using the same path in both means it will all just work. If you don’t, you’d need to fix it with a remote path map.

So pick *one* path layout and use it for all of them. It's suggested to use `/data`, but there are other  common names like `/shared`, `/media` or `/dvr`. Keeping this the same on the outside *and* inside will make your setup simpler: one path to remember or if integrating Docker and native software. For example, Synology might use `/Volume1/data` and unRAID might use `/mnt/user/data` on the outside, but `/data` on the inside is fine.

It is also important to remember that you’ll need to setup or re-configure paths in the software running *inside* these Docker containers. If you change the paths for your download client, you’ll need to edit its settings to match and likely update existing torrents. If you change your library path, you’ll need to change those settings in Sonarr, Radarr, Lidarr, Plex, etc.

## Examples

What matters here is the general structure, not the names. You are free to pick folder names that make sense to you. And there are other ways of arranging things too. For example, you’re not likely to download and run into conflicts of identical releases between usenet and torrents, so you *could* put both in `/data/downloads/{movies|books|music|tv}` folders. Downloads don’t even have to be sorted into subfolders either, since movies, music and tv will rarely conflict.

This example `data` folder has subfolders for torrents and usenet and each of these have subfolders for tv, movie and music downloads to keep things neat. The `media` folder has nicely named `tv`, `movies`, `books`, and `music` subfolders. This `media` folder is your library and what you’d pass to Plex, Kodi, Emby, Jellyfin, etc.

For the below example `data` is equivalent to the host path `/host/data` and the docker path `/data`

```none
    data
    ├── torrents
    │  ├── movies
    │  ├── music
    |  ├── books
    │  └── tv
    ├── usenet
    │  ├── movies
    │  ├── music
    │  ├── books
    │  └── tv
    └── media
        ├── movies
        ├── music
        ├── books
        └── tv
```

The path for each Docker container can be as specific as needed while still maintaining the correct structure:

### Torrents

```none
    data
    └── torrents
        ├── movies
        ├── music
        ├── books
        └── tv
```

Torrents only needs access to torrent files, so pass it `-v /host/data/torrents:/data/torrents`. In the torrent software settings, you’ll need to reconfigure paths and you can sort into subfolders like`/data/torrents/{tv|books|movies|music}`.

### Usenet

```none
    data
    └── usenet
        ├── movies
        ├── music
        └── tv
```

Usenet only needs access to usenet files, so pass it `-v /host/data/usenet:/data/usenet`. In the usenet software settings, you’ll need to reconfigure paths and you can sort into subfolders like`/data/usenet/{tv|movies|music}`.

### Media Server

```none
    data
    └── media
        ├── movies
        ├── music
        └── tv
```

Plex/Emby only needs access to your media library, so pass `-v /host/data/media:/data/media`, which can have any number of subfolders like `movies`, `kids movies`, `tv`, `documentary tv` and/or `music` as sub folders.

### Sonarr, Radarr and Lidarr

```none
    data
    ├── torrents
    │  ├── movies
    │  ├── music
    │  └── tv
    ├── usenet
    │  ├── movies
    │  ├── music
    │  └── tv
    └── media
        ├── movies
        ├── music
        └── tv
```

Sonarr, Radarr and Lidarr get everything using `-v /host/data:/data` because the *download* folder(s) and *media* folder will look like and *be* one file system. Hard links will work and moves will be atomic, instead of copy + delete.

## Issues

There are a couple minor issues with not following the Docker image’s suggested paths.

The biggest is that volumes defined in the `dockerfile` will get created if they’re not specified, this means they’ll pile up as you delete and re-create the containers. If they end up with data in them, they can consume space unexpectedly and likely in an unsuitable place. You can find a [cleanup command](#prune-docker) in the helpful commands section below. This could also be mitigated by passing in an empty folder for all the volumes you don’t want to use, like `/data/empty:/movies` and `/data/empty:/downloads`. Maybe even put a file named `DO NOT USE THIS FOLDER` inside, to remind yourself.

Another problem is that some images are pre-configured to use the documented volumes, so you’ll need to change settings in the software inside the Docker container. Thankfully, since configuration persists outside the container this is a one time issue. You might also pick a path like `/data` or `/media` which some images already define for a specific use. It shouldn’t be a problem, but will be a little more confusing when combined with the previous issues. In the end, it is worth it for working hard links and fast moves. The consistency and simplicity are welcome side effects as well.

If you use the latest version of the abandoned [RadarrSync](https://github.com/Sperryfreak01/RadarrSync) to synchronize two Radarr instances, it *depends* on mapping the *same* path inside to a different path on the outside, for example `/movies` for one instance would point at `/data/media/movies` and the other at `/data/media/movies4k`. This breaks *everything* you’ve read above. There is no good solution, you either use the old version which isn’t as good, do your mapping in a way that is ugly and breaks hard links or just don’t use it at all.

# Running containers using

## Docker Compose

This is the best option for most users, it lets you control and configure many containers and their interdependence in one file. A good starting place is Docker’s own [Get started with Docker Compose](https://docs.docker.com/compose/gettingstarted/). You can use [composerize](https://composerize.com) or [ghcr.io/red5d/docker-autocompose](#get-docker-compose) to convert `docker run` commands into a single `docker-compose.yml` file.

> The below is *not* a complete working example! The containers only have PID, UID, UMASK and example paths defined to keep it simple.
{.is-warning}

```yml
    # sonarr
    Sonarr:
        image: cr.hotio.dev/hotio/sonarr
        volumes:
            - /path/to/config/sonarr:/config
            - /host/data:/data
        environment:
            - PUID=111
            - PGID=321
            - UMASK=002

    # deluge
    Deluge:
        image: binhex/arch-delugevpn
        volumes:
            - /path/to/config/deluge:/config
            - /host/data/torrents:/data/torrents
        environment:
            - PUID=222
            - PGID=321
            - UMASK=002

    # SABnzbd
    SABnzbd:
        image: cr.hotio.dev/hotio/sabnzbd
        volumes:
            - /path/to/config/sabnzbd:/config
            - /host/data/usenet:/data/usenet
        environment:
            - PUID=333
            - PGID=321
            - UMASK=002

    # plex
    Plex:
        image: cr.hotio.dev/hotio/plex
        volumes:
            - /path/to/config/plex:/config
            - /host/data/media:/data/media

        environment:
            - PUID=444
            - PGID=321
            - UMASK=002
```

### Update all images and containers

```shell
    docker-compose pull
    docker-compose up -d
```

### Update individual image and container

```shell
    docker-compose pull NAME
    docker-compose up -d NAME
```

## docker run

> Like the Docker Compose example above, the following `docker run` commands are stripped down to *only* the PUID, PGID, UMASK and volumes in order to act as an obvious example.
{.is-warning}

```shell
    # sonarr
    docker run -v /path/to/config/sonarr:/config \
               -v /host/data:/data \
               -e PUID=111 -e PGID=321 -e UMASK=002 \
               cr.hotio.dev/hotio/sonarr

    # deluge
    docker run -v /path/to/config/deluge:/config \
               -v /host/data/torrents:/data/torrents \
               -e PUID=222 -e PGID=321 -e UMASK=002 \
               binhex/arch-delugevpn

    # SABnzbd
    docker run -v /path/to/config/sabnzbd:/config \
               -v /host/data/usenet:/data/usenet \
               -e PUID=333 -e PGID=321 -e UMASK=002 \
               cr.hotio.dev/hotio/sabnzbd

    # plex
    docker run -v /path/to/config/plex:/config \
               -v /host/data/media:/data/media \
               -e PUID=444 -e PGID=321 -e UMASK=002 \
               cr.hotio.dev/hotio/plex
```

## Systemd

For maintaining a few Docker containers just using systemd is an option. It standardizes control and makes dependencies simpler for both native and Docker services. The generic example below can be adapted to any container by adjusting or adding the various values and options.

```shell
    # /etc/systemd/system/thing.service
    [Unit]
    Description=Thing
    Requires=docker.service
    After=network.target docker.service

    [Service]
    ExecStart=/usr/bin/docker run --rm \
                              --name=thing \
                              -v /path/to/config/thing:/config \
                              -v /host/data:/data
                              -e PUID=111 -e PGID=321 -e UMASK=002 \
                              nobody/thing

    ExecStop=/usr/bin/docker stop -t 30 thing

    [Install]
    WantedBy=default.target
```

# Helpful commands

## List running containers

```shell
    docker ps
```

## Shell *inside* a container

Exec into a container will typically log you in as root

```shell
    docker exec -it CONTAINER_NAME /bin/bash
```

Once inside, you can switch users with

```shell
    su - <username>
```

To exec in as a specific user, add `-u` as an argument and pass the username or id

```shell
    docker exec -u USER -it CONTAINER_NAME /bin/bash
```

### Examples as Specific Users

#### LSIO Radarr

```shell
    docker exec -u abc -it radarr bash
```

#### Hotio Sonarr

```shell
    docker exec -u hotio -it sonarr bash
```

For more information, see the [docker exec](https://docs.docker.com/engine/reference/commandline/exec/) documentation.

## Prune Docker

```shell
    docker system prune --all --volumes
```

> Remove unused containers, networks, volumes, images and build cache. As the WARNING this command gives says, this will remove all of the previously mentioned items for anything not in use by a running container. In a correctly configured environment, this is fine. But be aware and proceed cautiously the first time. See the [Docker system prune](https://docs.docker.com/engine/reference/commandline/system_prune/) documentation for more details.
{.is-warning}

## Get docker run command

Getting the `docker run` command from GUI managers can be hard, this Docker image makes it easy for a running container ([source](https://stackoverflow.com/questions/32758793/how-to-show-the-run-command-of-a-docker-container)).

```shell
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock assaflavie/runlike CONTAINER_NAME
```

## Get docker-compose

> Additionally, you may check out [TRaSH's Guide for docker-compose](https://trash-guides.info/compose/)
{.is-info}

Getting a `docker-compose.yml` from running instances is possible with [docker-autocompose](https://github.com/Red5d/docker-autocompose), in case you’ve already started your containers with `docker run` or `docker create` and want to change to `docker-compose` style. It is also great for sharing your settings with others, since it doesn’t matter what management software you’re using. The last argument(s) are your container names and you can pass in as many as needed at the same time. The first container name is required, more are optional. You can see container names in the **NAMES** column of `docker ps`, they're usually set by you or might be generated based on the image like `binhex-qbittorrent`. It is *not* the image name, like `binhex/arch-qbittorrentvpn`.

```shell
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/red5d/docker-autocompose $CONTAINER_NAME $ANOTHER_CONTAINER_NAME ... $ONE_MORE_CONTAINER_NAME
```

For some users this could be:

```shell
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/red5d/docker-autocompose lidarr prowlarr radarr readarr sonarr qbittorrent
```

## Troubleshoot networking

Most Docker images don’t have many useful tools in them for troubleshooting, but you can [attach a network troubleshooting type image](https://hub.docker.com/r/nicolaka/netshoot) to an existing container to help with that.

```shell
    docker run -it --rm --network container:CONTAINER_NAME nicolaka/netshoot
```

## Recursively chown user and group

```shell
    chown -R user:group /some/path/here
```

## Recursively chmod to 775/664

```shell
    chmod -R a=,a+rX,u+w,g+w /some/path/here
              ^  ^    ^   ^ adds write to group
              |  |    | adds write to user
              |  | adds read to all and execute to all folders (which controls access)
              | sets all to `000`
```

## Find UID/GID for user

```shell
    id <username>
```

## Examine files for hard links

```shell
    ls -alhi
    42207934 -rw-r--r--  2 user group    0 Sep 11 11:55 # hardlinked
    42207936 -rw-r--r--  1 user group    0 Sep 11 11:55 # no hardlinks
    42207934 -rw-r--r--  2 user group    0 Sep 11 11:55 # original

    stat original
      File: original
      Size: 0               Blocks: 0          IO Block: 4096   regular empty file
    Device: 803h/2051d      Inode: 42207934    Links: 2
    Access: (0644/-rw-r--r--)  Uid: ( 1000/ user)   Gid: ( 1001/ group)
    Access: 2020-09-11 11:55:43.803327144 -0500
    Modify: 2020-09-11 11:55:43.803327144 -0500
    Change: 2020-09-11 11:55:49.706660476 -0500
     Birth: 2020-09-11 11:55:43.803327144 -0500
```

# Interesting Docker Images

- [rasmunk/sshfs](https://github.com/rasmunk/docker-volume-sshfs)
{.links-list}
- [hotio’s](https://hotio.dev/) The documentation and Dockerfile don’t make any poor path suggestions. Images are automatically updated 2x in 1 hour if upstream changes are found. Hotio also builds our Pull Requests (except Sonarr) which may be useful for testing.
  - [sonarr](https://hotio.dev/containers/sonarr)
  - [radarr](https://hotio.dev/containers/radarr)
  - [lidarr](https://hotio.dev/containers/lidarr)
  - [readarr](https://hotio.dev/containers/readarr)
  - [prowlarr](https://hotio.dev/containers/prowlarr) for usenet and torrent tracker searching
  - [qbittorrent](https://hotio.dev/containers/qbittorrent/)
  - [NZBGet](https://hotio.dev/containers/nzbget/)
  - [SABnzbd](https://hotio.dev/containers/sabnzbd/)
  - [qflood](https://hotio.dev/containers/qflood/)
  - [ombi](https://hotio.dev/containers/ombi) for requesting media
  - [overseerr](https://hotio.dev/containers/overseerr/) for requesting media
  - [jackett](https://hotio.dev/containers/jackett) for torrent tracker searching
  - [nzbhydra2](https://hotio.dev/containers/nzbhydra2) for usenet indexer searching
  - [bazarr](https://hotio.dev/containers/bazarr) for subtitles
  - [pullio](https://hotio.dev/pullio/) for auto updating containers
  - [unpackerr](https://hotio.dev/containers/unpackerr) is useful for packed torrent extraction across a variety of torrent clients where unpacking is lacking or missing entirely.
{.links-list}
- [linuxserver.io](https://hub.docker.com/u/linuxserver) images have images for a *lot* of software and they’re well maintained. However, avoid their 'suggested (optional)' paths.
  - [SWAG Proxy](https://hub.docker.com/r/linuxserver/swag)
  - [qbittorrent](https://hub.docker.com/r/linuxserver/qbittorrent/)
  - [deluge](https://hub.docker.com/r/linuxserver/deluge/)
  - [rtorrent](https://hub.docker.com/r/linuxserver/rutorrent/)
  - [SABnzbd](https://hub.docker.com/r/linuxserver/sabnzbd/)
  - [NZBGet](https://hub.docker.com/r/linuxserver/nzbget/)
  - [sonarr](https://hub.docker.com/r/linuxserver/sonarr/)
  - [radarr](https://hub.docker.com/r/linuxserver/radarr/)
  - [lidarr](https://hub.docker.com/r/linuxserver/lidarr/)
- [binhex](https://hub.docker.com/u/binhex) another popular maintainer
  - [qbittorrent](https://hub.docker.com/r/binhex/arch-qbittorrentvpn/)
  - [deluge](https://hub.docker.com/r/binhex/arch-delugevpn/)
  - [rtorrent](https://hub.docker.com/r/binhex/arch-rtorrentvpn/)
  - [SABnzbd](https://hub.docker.com/r/binhex/arch-sabnzbd/)
  - [NZBGet](https://hub.docker.com/r/binhex/arch-nzbget/)
  - [sonarr](https://hub.docker.com/r/binhex/arch-sonarr/)
  - [radarr](https://hub.docker.com/r/binhex/arch-radarr/)
  - [lidarr](https://hub.docker.com/r/binhex/arch-lidarr/)
{.links-list}

> Note: [This is a GitHub repository](https://github.com/Luctia/ezarr) aimed at beginners who want to use Docker for their Servarr stack. It is basically a ready-to-go collection of files and only requires you to run two things to get the entire thing online. It removes the hassle around user management and permissions on the host device and features some other applications like PleX.
{.is-info}

# Custom Docker Network and DNS

One interesting feature of a [custom Docker network](https://docs.docker.com/network/network-tutorial-standalone/#use-user-defined-bridge-networks) is that it gets its own DNS server. If you create a bridge network for your containers, you can use their hostnames in your configuration. For example, if you `docker run --network=isolated --hostname=deluge binhex/arch-deluge` and `docker run --network=isolated --hostname=radarr binhex/arch-radarr`, you can then configure the Download Client in Radarr to point at just `deluge` and it’ll work *and* communicate on its own private network. Which means if you wanted to be even more secure, you could *stop* forwarding that port too. If you put your reverse proxy container on the same network, you can even stop forwarding the web interface ports and make them even more secure.

# Common Problems

## Correct *outside* paths, incorrect *inside* paths

Many people read this and think they understand, but they end up seeing the outside path correctly to something like `/data/usenet`, but then they miss the point and set the *inside* path to `/downloads` still.

- Good:
  - `/host/data/usenet:/data/usenet`
  - `/data/media:/data/media`
- Bad:
  - `/host/data:/downloads`
  - `/host/data:/media`
  - `/data/downloads:/data`

## Running Docker containers as root or changing users around

If you find yourself running your containers as `root:root`, you’re doing something wrong. If you’re not passing in a UID and GID, you’ll be using whatever the default is for the image and *that* will be unlikely to line up with a reasonable user on your system. And if you’re changing the user and group your Docker containers are running as, you’ll probably end up with permissions issues on folders like the `/config` folder which will likely have files and folders in them that got created the first time with the UID/GID you used the first time.

## Running Docker containers with umask 000

If you find yourself setting a UMASK of `000` (which is 777 for folders and 666 for files), you’re *also* doing something wrong. It leaves your files and folders read/write to *everyone*, which is poor Linux hygiene.

# Getting Help

## Chat Support (Discord)

- [Sonarr Discord](https://discord.sonarr.tv/)
- [Radarr Discord](https://radarr.video/discord)
{.links-list}

## Forum Support (Reddit)

- [/r/sonarr](http://reddit.com/r/sonarr)
- [/r/radarr](http://reddit.com/r/radarr)
{.links-list}
