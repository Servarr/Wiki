---
title: Lidarr File Naming Guide
description: Common file and folder naming schemes
published: true
date: 2024-03-30T13:23:53.095Z
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

## B's Naming Convention

<!---
TODO: Add explainer
--->


### Standard Track Format

```jinja
{Album Title} {(Album Disambiguation)}/{Artist Name}_{Album Title}_{track:00}_{Track Title}
```

### Multi Disc Track Format

```jinja
{Album Title} {(Album Disambiguation)}/{Artist Name}_{Album Title}_{medium:00}-{track:00}_{Track Title}
```

