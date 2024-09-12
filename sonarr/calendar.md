---
title: Sonarr Calendar
description: 
published: true
date: 2022-04-26T01:49:26.770Z
tags: sonarr, needs-love
editor: markdown
dateCreated: 2021-06-11T23:31:36.392Z
---

# Calendar

The calendar shows you recently aired episodes, as well as upcoming episodes.

# iCal Feed

- Sonarr can provide your calendar as an iCal feed. This will contain the previous [7 days](https://github.com/Sonarr/Sonarr/blob/22f044844c33187450dcc2d6b329ad3e1d241e74/src/NzbDrone.Api/Calendar/CalendarFeedModule.cs#L35) and the next [28 days](https://github.com/Sonarr/Sonarr/blob/22f044844c33187450dcc2d6b329ad3e1d241e74/src/NzbDrone.Api/Calendar/CalendarFeedModule.cs#L36)

> Google Calendar has internal issues that results in it no longer updating. This is a Google issue and not a Sonarr issue. It can often be resolved by removing and re-adding the calendar.
{.is-warning}
