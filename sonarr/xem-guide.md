---
title: TheXEM Moderation Guide
description: Guide for how to map various scenarios in XEM for optimal use with Sonarr and other PVR software.
published: true
date: 2021-10-05T15:41:48.487Z
tags: sonarr, xem
editor: markdown
dateCreated: 2021-10-03T16:48:28.241Z
---

## TheXEM Moderation Guide

[TheXEM](https://thexem.info) is a service that allows making connections between other services/entities that use different numbering and naming schemes for TV series releases. Sonarr uses TVDB as a data source for its episode information and sometimes scene and other release groups will use a different naming or numbering scheme. With the proper mapping it is possible to make sure that episode 1 of season 1 by TVDB's reckoning matches episode 5 of season 1 by the scene's reckoning, so that Sonarr is able to download the correct episode despite the numbering being different.

This guide is for people with an account on TheXEM and will walk you through some of the more common patterns that you may want to use. But first, we'll walk you through some of the basics.

## Naming

As a convention, we use the same name that The TVDB uses for the show itself. This is particularly interesting for international shows like anime and basically boils down to us using the officially licensed English name of the show.

Additionally it is possible to enter different aliases for the series name, which is mainly used for anime but occasionally useful for "regular" TV as well.

## The different Entity types

TheXEM has four different data sources or entity types that it currently supports and can connect with one another as and when needed. These four types are:

- Scene
- [TVDB](https://thetvdb.com)
- [AniDB](https://anidb.net)
- Master

A proper XEM mapping for a particular show should *at the very least* have an entry in the scene column and an entry in the TVDB column with the applicable mapping type (see the paragraph called *Mapping types* below) between them.

> Shows that do not have at least a scene column and a TVDB column are useless and will potentially be removed. The same goes for shows in which there is no direct or indirect connection between the scene column and the TVDB column.
{.is-warning}

## Mapping types

TheXEM has three different automatic options for connecting different entities with one another: SxxExx mapping, absolute mapping and the combination of both, full mapping. Additionally you can also directly map episodes onto one another using direct mapping. Each of these has its own use and is useful in particular situations.

### ![SxxExx mapping](/assets/sonarr/xem-guide/mapping-sxxexx.svg) SxxExx mapping

This type of mapping determines that between the two entities it connects, the season and episode numbers are equal, meaning that S01E01 is the same episode in both entity types. The absolute numbering however is not necessarily the same.

### ![Absolute mapping](/assets/sonarr/xem-guide/mapping-abs.svg) Absolute mapping

Apart from a few very specific use cases absolute mapping is almost exclusively useful for anime series. The anime naming scheme employed by most release groups just uses an incrementing episode number rather than SxxExx numbering, which we call absolute numbering. Marking the mapping between two entities as "absolute" tells services using this data that the SxxExx numbering may or may not differ but the absolute numbering at the very least is the same.

### ![Full mapping](/assets/sonarr/xem-guide/mapping-full.svg) Full mapping

Full mapping tells any service using TheXEM that between the two entities it connects both the absolute numbering and the SxxExx mapping are the same, meaning that the numbering is the same between both entities.

> This means that if all you want to add to your mapping is a scene column and a TVDB column with full mapping between them, your series entry is obsolete as this works by default without an entry on TheXEM.
{.is-info}

### ![Direct mapping](/assets/sonarr/xem-guide/mapping-diretc.svg) Direct mapping

Direct mapping is only possible between the Master entity type and the entities to either side of it. You'll want to use it as sparingly as possible because once you start using direct connections you'll need to keep using them for at least the remainder of the season and in some cases for the remainder of the entire show.

You can enable direct mapping by clicking the icon above the automatic mapping type. You'll see the user interface of the page shift around a little to make room for the connections you're about to draw. To connect an episode to another episode, you simply click an episode on the left side of the connection, followed by clicking the corresponding episode on the right side. If you did it well, the site will ask you to confirm the connection.

> It is possible to link a single episode on one side to multiple episodes on the other, for instance if The TVDB considers two episodes as separate episodes while the scene combines them into one number. This is particularly interesting for Western cartoons.
{.is-info}

## Examples

The above is a lot to take in but all in all there are just a handful of use cases that cover the vast majority of all shows that you will ever need to add to TheXEM. The following are some very common types of mapping.

### Basic Anime mapping

When mapping an anime show we always use the AniDB column. Whenever allowed at all by the mapping you're trying to achieve you should *always* aim to use full mapping between the Scene column and the AniDB column.

Most anime shows can directly map between the scene column through AniDB and finally to The TVDB. A simple example would be the show [Ronia the Robber's Daughter](https://thexem.info/xem/show/1603). It needs mapping in the first place because the Japanese name used by release groups does not match the English name used by TVDB, but otherwise the mapping is simple: numbering is identical between the scene and AniDB so we use full mapping between those, while the only thing we know for certain between AniDB and TVDB is that the SxxExx numbering is identical.

> AniDB resets the absolute numbering between each season because it considers each season its own show. When adding a new AniDB season, make sure that you enter its ID number and that you set the "Ab. Start" field for that new season to 1.
{.is-info}

For an example of an anime show with multiple seasons, take a look at [Assassination Classroom](https://thexem.info/xem/show/2817). Make note of the separate aliases for the second season, which help Sonarr figure out that `[Release group] Ansatsu Kyoushitsu - 01 (1080p)` maps to S01E01 in TVDB while `[Release group] Ansatsu Kyoushitsu S2 - 01 (1080p)` maps to S02E01.

### Complex anime mapping

Sometimes the concept The TVDB has of a season does not match with what AniDB calls a season. In particular this happens when an anime is released as a so-called *split-cour*. This presents itself as a bunch of episodes, followed by a short break after which the next set of episodes air as well. Split-cour anime typically has one or at most two anime seasons between it and TVDB mostly considers an anime split-cour when the second batch of episodes is announced during the first part's air time.

An example of what this might look like would be [That Time I Got Reincarnated as a Slime](https://thexem.info/xem/show/5241). Note how what TVDB calls season 2 is actually split up into seasons 2 and 3 as far as AniDB is concerned. We're using a link to the Master entity here to make the mapping less complex. Basically the Master entry combines the absolute numbering as used on TVDB with the SxxExx numbering that AniDB uses. We then link the Master column to TVDB using absolute mapping and to the AniDB column using SxxExx mapping. The Scene column can be linked using full mapping as usual.

### Short-format Western cartoon shows

Children's cartoons often offer up a challenge when mapping the episodes because if a 30-minute episode is split into two separate stories, TVDB considers those to be two different episodes while the Scene generally considers them a single episode. This means that we will need very detailed direct mapping between individual episodes.

An example of this is the show [Paw Patrol](https://thexem.info/xem/show/4814). When you hover over episodes in the Master column you'll see that a single episode on the Scene side is linked to one or two episodes on the TVDB side. This particular type of mapping needs constant input as new episodes for the series air.

> Bear in mind that mapping one episode on one side to multiple episodes on the other can make sense in cases like this, but mapping multiple episodes on one side to multiple episodes on the other does not. The software will allow you to do it, but please don't as Sonarr will not be able to do anything with that.
{.is-warning}

### Complex individual mapping

In some (luckily very rare!) cases mapping episodes onto one another can get very complex. The TVDB considers air dates of the show's main network to be leading when it comes to determining episode ordering. That can make things really complex in cases like Firefly or [Transporter](https://thexem.info/xem/show/1653), which were aired by their original networks in an order that breaks the chronological order. The Scene will often compensate for that by using the chronological episode order, which results in needing complex individual mapping for each episode.

Note how with Transporter there is no automatic mapping between the Master column and the Scene column; all mapping is achieved by direct links between episodes.

## Limitations

TheXEM currently has a few limitations that we'll try to cover here.

### Only one scene numbering scheme per series is supported

If multiple release groups use different numbering schemes, this complicates matters. As such there are a few guidelines in the case of disagreeing sources.

1. Scene releases' numbering always takes priority over that of P2P releases.
2. If no scene releases exist for a certain show, pick the one that seems the most popular. This will usually boil down to whichever group tends to release episodes the fastest in decent quality.
3. In the case of anime we follow the numbering of SubsPlease/Erai-Raws if available. If not, the previous guideline applies here as well.

### Only one master entity is supported

You'll use the Master entity type in some relatively rare cases to make direct connections *or* to avoid having to make direct connections. You can however only use one of those master entities to connect two other entities. Because the end goal is to make sure that mapping works for the main use case of connecting TVDB to the scene, you'll need to make sure that at least *that* mapping works and if that requires a master entity, that's where you'll prioritize using it.

### Deleting the master column or individual seasons in it

When you delete the Master column for any reason, make sure that there are no direct mappings on individual episodes inside it. If you delete the season while the mappings are still there, **the mapping will be invisible in the interface but will still exist!** If you do this accidentally, just re-add the season you removed, undo the individual links and then delete the season again.

### Some things just simply cannot be mapped

One of the things to always keep in mind is that sometimes a series is so messed up or otherwise complex that it can not be mapped in TheXEM. Sometimes you'll be able to map one of the use cases, sometimes not even that. In those cases often nothing can really be done about it.

## Need help?

Finally, if you need help with anything or if you simply do not have an account on TheXEM, please join us on Sonarr's Discord server in the [#xem channel](https://discord.gg/QzDaBmN2J3). We'll be happy to help. Do keep in mind though that response times might be slow and very much dependent on timezone difference.
