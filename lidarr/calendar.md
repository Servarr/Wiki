---
title: Lidarr Calendar
description: View upcoming album releases and track music release schedules
published: true
date: 2026-05-29T13:10:48.016Z
tags: lidarr, calendar, releases, schedule, albums, music, planning
editor: markdown
dateCreated: 2021-06-14T21:35:03.094Z
---

# Calendar

The Calendar page shows album releases from artists in your library, laid out week by week. It's useful for seeing what's coming up and checking whether Lidarr already has files for a recent release.

## Color coding

Each release tile is color-coded to show its current status:

| Color | Meaning |
| --- | --- |
| Green | Files on disk; Lidarr has this release. |
| Blue | Monitored and upcoming; the release date is in the future. |
| Yellow/Orange | Monitored, released, and missing; past release date but no files yet. |
| Grey | Unmonitored; Lidarr isn't looking for this release. |

## Navigation

Use the **<** and **>** arrows to move backward or forward one week at a time. The **Today** button returns to the current week.

Clicking a release tile takes you to the album's detail page, where you can trigger a manual search or adjust monitoring.

## iCal Feed

Lidarr can expose your calendar as an iCal feed that any calendar client supporting the webcal or iCal format can subscribe to. Outlook, Google Calendar, and Apple Calendar all support this.

Click the **iCal Feed** button on the Calendar page to open the feed configuration dialog. The options available are:

| Field | Default | Description |
| --- | --- | --- |
| Include Unmonitored | Off | When enabled, unmonitored album releases are included in the feed as well as monitored ones. |
| Past Days | 7 | How many days into the past the feed includes. |
| Future Days | 28 | How many days into the future the feed includes. |
| Tags | (none) | When set, the feed only includes artists that have at least one matching tag. Leave blank to include all artists. |

The dialog generates a personalised **iCal Feed URL** containing your API key. Copy the URL into your calendar client to subscribe, or click the calendar icon to open it directly if your browser supports the `webcal://` protocol.

> The feed URL contains your Lidarr API key. Treat it as a secret and don't share it publicly.
{.is-warning}

## Options

The **Options** button opens the Calendar Options dialog, split into two sections.

**Local** (apply to this browser only):

| Option | Default | Description |
| --- | --- | --- |
| Collapse Multiple Albums | On | When more than one album from the same artist releases on the same day, collapse them into a single tile instead of showing each one. |
| Icon for Cutoff Unmet | On | Show a visual indicator on release tiles where files exist but the quality cutoff hasn't been met. |

**Global** (apply across all browsers and users):

| Option | Description |
| --- | --- |
| First Day of Week | Sets whether weeks start on Sunday or Monday. |
| Week Column Header | Controls the date format shown above each day column (for example, `Tue 3/25`). |
| Time Format | Sets the time format used across the calendar (12-hour or 24-hour). |
| Enable Color-Impaired Mode | Adjusts the color scheme to help users who have difficulty distinguishing the default color-coded release statuses. |
