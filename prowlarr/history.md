---
title: Prowlarr History
description: 
published: true
date: 2021-07-10T16:04:58.037Z
tags: prowlarr
editor: markdown
dateCreated: 2021-06-08T23:32:35.055Z
---

This page will show you how to review and search your history, and the various settings available.

# Opening History

To get into the History screen, click on `History` on the left menu.

![hist_1_history.png](/assets/prowlarr/hist_1_history.png)

# Menu Items

At the top of the screen there are various menu items:

- Refresh allows you to dynamically refresh the history and see any new entries.
- Clear allows you to complete clear your history.

> Care should be taken before clearing history. It will be completely purged and unrecoverable!

- Options allows you to change the columns shown, set the number of history entries per page, and set the number of days before the history is purged during the scheduled tasks.

- Filter allows you to filter the history for various types of actions such as searches, grabs, etc.

# RSS Searches

Automated search queries from your Apps look like this:

![hist_2_search.png](/assets/prowlarr/hist_2_search.png)

If you have the columns selected, you can see the indexer searched, the category used, what App made the request, and how long that query took to complete. You can also click on the `i` icon on the right to get more specific information. For RSS feeds, there is no actual query, so that will be empty.

![hist_3_rssquery.png](/assets/prowlarr/hist_3_rssquery.png)

# Query Searches

Specific query searches will show exactly what was searched, based on the capabilities of each indexer. As you can see below, the same series/episode was searched on 3 different indexers, and each has different capabilities:

![hist_4_search.png](/assets/prowlarr/hist_4_search.png)

If you click on the `i` on any of these searches, you can see the number of results that were returned.

![hist_5_results.png](/assets/prowlarr/hist_5_results.png)
