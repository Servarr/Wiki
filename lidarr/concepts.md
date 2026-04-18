---
title: Lidarr Concepts
description: How Lidarr models music, why MusicBrainz metadata matters, and when Lidarr is (and isn't) the right tool for your library
published: true
date: 2026-04-18T16:59:43.512Z
tags: lidarr, releases, metadata, concepts, musicbrainz, artist
editor: markdown
dateCreated: 2026-04-18T16:48:08.649Z
---

# Lidarr Concepts

This page explains the model Lidarr uses to manage music, why that model depends on MusicBrainz, and when Lidarr is — and isn't — the right tool for your library. If you just want to install and start using Lidarr, read the [Quick Start](/lidarr/quick-start-guide) first and come back here when you want to understand *why* something behaves the way it does.

## How Lidarr manages music

Lidarr is a music library management system, data aggregator, and automation platform for finding and downloading media. At a high level it follows the same principles as the other Arr applications (Sonarr, Radarr, and so on), but music introduces complications that film and TV do not.

Unlike movies and TV shows, music has no consistent set of standards for tagging, naming, or storage. Distribution has shifted from physical media to electronic over several decades, which has widened the variation rather than narrowed it. Opinions on how to handle music-library management are wide and varied, and Lidarr has to pick one.

The choice Lidarr makes is to lean on third-party metadata to impose order. Every album and artist in Lidarr corresponds to a record in an external data source, and Lidarr uses that record to categorize, tag, and manage files. Everything else in this page follows from that decision.

> If the data does not exist in the third-party services, it cannot be managed by Lidarr.
{.is-warning}

## The Release model

Lidarr organizes music around the `Release` standard from MusicBrainz. Every item Lidarr manages must correspond to a `Release` in its metadata source.

Examples of `Releases`:

- Album
- EP
- Single
- Broadcast

If something you want to manage does not exist as a `Release` in the metadata source, Lidarr cannot handle it — there is no "add it locally only" escape hatch.

> `Releases` must exist in the third-party services to be managed in Lidarr.
{.is-info}

## The Artist model

An `Artist` in Lidarr is the `Release Artist` — the artist the metadata source attributes a `Release` to. This is a surprisingly slippery thing to pin down: naming, stylization, collaborations, and user preferences all contribute to ambiguity about what counts as "the" artist.

Consider how many ways the same person can appear:

- Bob Dylan
- BOB DYLAN
- The Bob Dylan
- Bob Dylan, The
- Bob Dylan & the Band
- Bob Dylan feat. The Band
- The Band featuring Bob Dylan

Every `Release` is associated with exactly one `Artist`. To add a `Release` in Lidarr you have to find and use the canonical `Artist` as the metadata source defines it — not the one written on the album cover, the one written in MusicBrainz. This is the source of most "why can't I add this artist?" problems; see the [FAQ](/lidarr/faq) for specific cases.

> `Release Artists` must exist in the third-party services to be managed in Lidarr.
{.is-info}

## Dependence on MusicBrainz

The metadata source Lidarr relies on is [MusicBrainz](https://musicbrainz.org/) — a free, community-driven service that exists and survives on user contributions. Lidarr does not have its own metadata; it reads MusicBrainz's.

Two practical consequences follow.

**Missing or incorrect data is a MusicBrainz problem, not a Lidarr problem.** If an album isn't showing up in Lidarr, the first question to ask is whether it exists on MusicBrainz and whether the data there is correct. Lidarr cannot invent records its source does not provide, and editing data inside Lidarr will not propagate anywhere useful — the upstream source is the one that has to change.

**Propagation takes time.** When someone adds or corrects a record on MusicBrainz, Lidarr does not see it immediately. Updates flow from MusicBrainz through a periodic sync into a metadata service that Lidarr queries, and from there into your instance on refresh. You can refresh individual artists and albums inside Lidarr once the upstream propagation has happened, but you cannot accelerate the propagation itself. Expect a delay measured in hours to days, not minutes.

If you find that a `Release` or `Release Artist` is missing from MusicBrainz, you can help fix it: see [How To Contribute](https://musicbrainz.org/doc/How_to_Contribute). Creating and editing MusicBrainz records is beyond the scope of this wiki.

## Is Lidarr right for your library?

Lidarr is built around the `Release` model. If your library does not fit that model, Lidarr will be a frustrating tool no matter how much you tune it. Lidarr is **not** a good fit for the following situations.

- **A loose collection of files** — files from multiple artists (not compilations) or multiple `Releases` sharing a single folder. Low-to-no-curation libraries will not work with Lidarr; don't try.
- **Classical music libraries** — classical releases typically have extensive tagging requirements, and `Release` metadata on MusicBrainz is often missing or incorrect. You can use Lidarr, but expect substantial manual work.
- **Singles-heavy libraries** — many singles are not actual `Releases` in MusicBrainz. Third-party data sources return no metadata for them, so they cannot be automated.
- **Mixes, beats, and samples** — libraries made of DJ mixes, beat packs, or producer samples (Beatport-style content). These are not `Releases` in the metadata sources and Lidarr cannot manage them. This does *not* apply to albums in the Electronic genre, which are fine.

If most of your library falls into one of the above categories, Lidarr may not be the right tool. If only part of your library does, you can still use Lidarr for the rest — just expect to manage the problematic portion by hand.

## Alternatives and companion tools

The tools below can be used instead of — or alongside — Lidarr.

- [Beets](https://beets.io/) — music library organizer and tagger, strong at bulk cleanup
- [MusicBrainz Picard](https://picard.musicbrainz.org/) — the canonical MusicBrainz tagger
- [MusicBee](https://getmusicbee.com/) — music player with strong library-management features

Using these in tandem with Lidarr is beyond the scope of this page, but they are common companions for preparing a library before import, or for managing the parts of a collection Lidarr can't.

## See also

- [Quick Start](/lidarr/quick-start-guide) — install and reach your first download
- [Importing an Existing Library](/lidarr/importing-existing-library) — migrating files you already have
- [FAQ](/lidarr/faq) — common questions and troubleshooting
- [Settings](/lidarr/settings) — detailed reference for every configuration option
