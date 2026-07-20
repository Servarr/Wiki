---
title: Radarr Calendar
description: View upcoming movie releases and track cinema/digital release dates
published: true
date: 2021-11-24T19:23:55.178Z
tags: radarr, calendar, releases, schedule, movies, planning
editor: markdown
dateCreated: 2021-05-25T01:29:31.158Z
---

# Calendar

The calendar tab allows you to see any upcoming films (or recently released) that is presently monitored in your library.

## Views

The calendar can be displayed in several views, selectable from the calendar header:

- Day
- Week
- Month
- Forecast
- Agenda

## Legend

Events on the calendar are color coded to indicate their status:

- Downloaded and Monitored
- Downloaded but not Monitored
- Missing, Monitored, and Considered Available
- Missing, not Monitored
- Queued
- Unreleased

> The cutoff-unmet icon is only shown when the **Icon for Cutoff Unmet** calendar option is enabled.
{.is-info}

## Calendar Options

The calendar options (the gear/options modal) let you control what is displayed:

- **Show Movie Information** - Show movie information such as title and year
- **Show Cinema Release** - Show the cinema/theatrical release date
- **Show Digital Release** - Show the digital release date
- **Show Physical Release** - Show the physical release date
- **Icon for Cutoff Unmet** - Show an icon for files when the quality cutoff has not been met
- **Full Color Events** - Make the entire event background the status color rather than a colored edge

Global display options (shared with the rest of the UI) such as **First Day of Week**, **Week Column Header**, **Time Format**, and **Enable Color-Impaired Mode** are also available here.

# iCal Feed

Radarr can provide your calendar as an iCal feed at `/feed/v3/calendar/Radarr.ics`. By default the feed contains the previous [7 days](https://github.com/Radarr/Radarr/blob/develop/src/Radarr.Api.V3/Calendar/CalendarFeedController.cs) (`pastDays`) and the next [28 days](https://github.com/Radarr/Radarr/blob/develop/src/Radarr.Api.V3/Calendar/CalendarFeedController.cs) (`futureDays`).

The feed link can be generated in the calendar via the iCal feed button, where you can choose:

- **Include Unmonitored** - Include unmonitored movies in the feed (`unmonitored`)
- **Show as All-Day Events** - Display releases as all-day events
- **Release Types** - Which release dates to include: Cinema Release, Digital Release, and/or Physical Release (`releaseTypes`)
- **Tags** - Limit the feed to movies with the selected tag(s) (`tags`)

> Google Calendar has internal issues that result in it no longer updating. This is a Google issue and not a Radarr issue. It can often be resolved by removing and re-adding the calendar.
{.is-warning}
