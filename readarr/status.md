---
title: Readarr Status
description: Readarr is in Beta and Goodreads data is finicky. As such this page documents the status and known issues.
published: true
date: 2024-05-16T13:29:24.655Z
tags: 
editor: markdown
dateCreated: 2024-05-16T13:27:03.794Z
---

# Readarr Status

## 2024-05-14 Search is down

Searching is currently down. I will advise when it's back up. This will impact adding new authors, books, and manual imports where searches are required to function.
[Discord Message](https://discord.com/channels/264387956343570434/1028840624864120872/1239911456728809512)

## 2024-04-17 Metadata is alive (with issues)

The current state of the Readarr metadata server: 
1. It's functioning, approximately 3 months behind. If you have a book that was added to Goodreads less than 3 months ago, it probably is it is not going to to show up yet.
1. Large authors are still not working, and will not be for a while. A partial, but **not exhaustive**, list of those authors:     
    - Stephen King
    - Isaac Asimov
    - Leo Tolstoy
    - Fyodor Dostoevsky
    - Arthur Conan Doyle
    - Stephen Fry
    - Agatha Christie
    - Arthur C. Clarke
    - Oscar Wilde
    - Jack London
    - Neil Gaiman
    - Charles Dickens
1. For large authors, you cannot do anything to add either the author OR their individual books. There is no workaround.
[Discord Message](https://discord.com/channels/264387956343570434/1028840624864120872/1230155166334849025)

## 2023-12-18 Calibre 7.2.0

There was a change in Calibre 7.2.0 which starts listening on ipv6, and it can cause a problem with readarr connections. To fix it, change the setting "The interface to listen for connections" to 0.0.0.0 in Preferences->Sharing over the net->Advanced, in calibre, and restart calibre. This should resolve the issue.

[Discord Message](https://discord.com/channels/264387956343570434/1028840624864120872/1186297973307613184)
