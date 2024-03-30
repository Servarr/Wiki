---
title: Lidarr File Naming Guide
description: Common file and folder naming schemes
published: true
date: 2024-03-30T13:52:57.300Z
tags: lidarr, naming, folders
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

```jinja
{Artist Name}
```

## JasonVelocity's Naming Convention

This naming convention works well with Plex and is useful as a workaround when an artist has multiple release groups with the same name.

### Standard Track Format

```jinja
{Album Type}/{Album CleanTitle}{ (Album Disambiguation)}/{track:00} - {Track CleanTitle}
```

### Multi Disc Track Format

```jinja
{Album Type}/{Album CleanTitle}{ (Album Disambiguation)}/{medium:00}{track:00} - {Track CleanTitle}
```
### Artist Folder Format

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



