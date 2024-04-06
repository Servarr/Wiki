---
title: Lidarr File Naming Guide
description: Common file and folder naming schemes
published: true
date: 2024-04-06T13:02:35.717Z
tags: 
editor: markdown
dateCreated: 2024-03-30T13:23:53.095Z
---

# Lidarr File Naming Guide

Lidarr users often ask about file naming formats. This guide outlines popular options and their justifications.

Lidarr offers options for customizing folder and track naming conventions for standard albums and multi disc albums.

## Davo's Naming Convention

This format is from Davo's [community-guide](/lidarr/community-guide).

### Standard Track Format

```jinja
{Album Title} {(Album Disambiguation)}/{Artist Name}_{Album Title}_{track:00}_{Track Title}
```

### Multi Disc Track Format

```jinja
{Album Title} {(Album Disambiguation)}/{Artist Name}_{Album Title}_{medium:00}-{track:00}_{Track Title}
```

### Artist Folder Format

```jinja
{Artist Name}
```

## B's Naming Convention

This naming convention limits folder and file length to the specified number of characters. This is especially important for fans of [Fiona Apple](https://musicbrainz.org/release-group/b7493310-d408-44e2-a2d6-bbbd485d7abc), [Flume](https://musicbrainz.org/recording/93d0086c-27e7-4206-8722-e4c3c0b6d786) or [Bring Me the Horizon](https://musicbrainz.org/release-group/b7493310-d408-44e2-a2d6-bbbd485d7abc).

Windows users should not use this naming convention as some folders could [become inaccessible](https://wiki.servarr.com/lidarr/faq#why-cant-i-access-a-folder-in-windows-after-lidarr-rename).

### Standard Track Format

```jinja
{Album CleanTitle:100} {(Release Year)}/{Artist CleanName:100} - {Album CleanTitle:100} - {track:00} - {Track Title:100}
```

### Multi Disc Track Format

```jinja
{Album CleanTitle:100} ({Release Year})/{Medium Format} {medium:00}/{Artist CleanName:100} - {Album CleanTitle:100} - {track:00} - {Track Title:100}
artist: {Artist CleanName}
```

### Artist Folder Format

```jinja
{Artist Name}
```

## PearsonFlyer's Naming Convention

<!---
TODO: Add explainer
--->

### Standard Track Format

```jinja
{Album Title} ({Release Year})/{Artist Name} - {Album Title} - {track:00} - {Track Title} ({Quality Full} {MediaInfo AudioBitRate}) {-Release Group}
```

### Multi Disc Track Format

```jinja

```

### Artist Folder Format

Adding the artist disambiguation is needed when MusicBrainz has two similar artist entries such as Alice Cooper [the person](https://musicbrainz.org/artist/ee58c59f-8e7f-4430-b8ca-236c4d3745ae) and Alice Cooper [the band](/lidarr/quick-start-guide)<https://musicbrainz.org/artist/4d7928cd-7ed2-4282-8c29-c0c9f966f1bd>).

```jinja
{Artist NameThe} {(Artist Disambiguation)}
```

## JasonVelocity's Naming Convention

This naming convention works well with Plex and is useful as a workaround when an artist has multiple release groups with the same name. Jason runs Lidarr using Docker on WSL.

### Standard Track Format

```jinja
{Album Type}/{Album CleanTitle}{ (Album Disambiguation)}/{track:00} - {Track CleanTitle}
```

### Multi Disc Track Format

```jinja
{Album Type}/{Album CleanTitle}{ (Album Disambiguation)}/{medium:00}{track:00} - {Track CleanTitle}
```

### Artist Folder Format

Using `CleanNameThe` moves `The` to the end of the folder name for easier folder navigation.

```jinja
{Artist CleanNameThe}
```

## Fra's Naming Convention

Fra recommends this naming scheme as it aligns with [Plex's music folder naming recommendations](https://support.plex.tv/articles/200265296-adding-music-media-from-folders/#toc-0).

### Standard Track Format

```jinja
{Album Title}/{track:00} - {Track Title}
```

### Multi Disc Track Format

```jinja
{Album Title}/{medium:0}{track:00} - {Track Title}
```

### Artist Folder Format

```jinja
{Artist Name}
```
