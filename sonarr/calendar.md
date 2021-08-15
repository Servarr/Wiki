---
title: Sonarr Calendar
description: 
published: true
date: 2021-08-15T11:43:03.320Z
tags: sonarr, needs-love
editor: markdown
dateCreated: 2021-06-11T23:31:36.392Z
---

## Calendar

The calendar shows you recently aired episodes, as well as upcoming episodes.

## iCal Feed

- Sonarr can procide your calendar as an iCal feed. This will contain the previous [7 days](https://github.com/Sonarr/Sonarr/blob/0a2b109a3fe101e260b623d0768240ef8b7a47ae/src/NzbDrone.Api/Calendar/CalendarFeedModule.cs#L35) and the next [28 days](https://github.com/Sonarr/Sonarr/blob/0a2b109a3fe101e260b623d0768240ef8b7a47ae/src/NzbDrone.Api/Calendar/CalendarFeedModule.cs#L36)