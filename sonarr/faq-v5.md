---
title: Sonarr v5 FAQ
description: Sonarr v5 FAQ
published: true
date: 2026-11-22T00:00:00.000Z
tags:
editor: markdown
dateCreated: 2026-11-22T00:00:00.000Z
---

# Sonarr v5 FAQ

> Sonarr v5 is a pre-release. See [Sonarr releases](https://github.com/Sonarr/Sonarr/releases) for the current build.
{.is-info}

- [Sonarr v5 FAQ](#sonarr-v5-faq)
  - [Anime Search Improvements](#anime-search-improvements)
    - [Season Search](#season-search)
    - [Season Aliases](#season-aliases)

## Anime Search Improvements

Sonarr v5 improves how anime is searched.

### Season Search

- Previously, an anime season search also ran one search for each episode.
- Sonarr v5 only searches for individual episodes when the season has not fully aired (or will not within 24 hours).
- This cuts the number of indexer requests for a season that has already aired.
- Source: [Sonarr PR #8833](https://github.com/Sonarr/Sonarr/pull/8833)

### Season Aliases

Many anime seasons are released under their own title, for example `Anime S2` or `Anime 2nd Season`.

- Sonarr v5 searches for these season-specific aliases without adding a season number, which gives better results.
- Sonarr v5 also parses these aliases, so a season pack named only by its season title is matched to the right season.
- Sources: [Sonarr PR #8837](https://github.com/Sonarr/Sonarr/pull/8837) (search) and [Sonarr PR #8836](https://github.com/Sonarr/Sonarr/pull/8836) (parsing)
