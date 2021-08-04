---
title: Supported Indexers
description: 
published: true
date: 2021-08-04T02:00:24.856Z
tags: 
editor: markdown
dateCreated: 2021-08-01T22:50:25.115Z
---

# Supported Indexers

-   Usenet
    -   Newznab
        -   Newznab is a standardized API used by many usenet indexing sites.
        -   Many presets are available, but all require an API key to be accessible.
    -   Omgwtfnzbs
        -   This indexer *also* supports newznab and is available as one of the above presets.
        -   Website: [https://omgwtfnzbs.me/](https://omgwtfnzbs.me/)
    -   Fanzub
        -   Website: [http://fanzub.com/](http://fanzub.com/)
        -   Indexer for Japanese media (Anime) exclusively.
-   Torrents
    -   BroadcastheNet
        -   Private Tracker
        -   Website: [https://broadcasthe.net/](https://broadcasthe.net/)
    -   Filelist
        -   Private Tracker
        -   Website: [https://filelist.io](https://filelist.io)
    -   HDBits
        -   Private tracker
        -   Website: [https://hdbits.org/](https://hdbits.org/)
    -   IPTorrents
        -   Private tracker, no search api.
        -   Website: [http://www.iptorrents.com/](http://www.iptorrents.com/)
    -   Nyaa
        -   Website: [http://www.nyaa.si/](http://www.nyaa.si/)
        -   Torrent Indexer for Japanese media (Anime) exclusively.
    -   Rarbg
        -   Website: [https://rarbg.to/](https://rarbg.to/)
    -   Torrent RSS Feed
        -   Generic torrent RSS feed parser.
        -   **NOTE:** The RSS feed must contain a pubdate. The release size is recommended as well.
        -   Private tracker
    -   Torrentleech
        -   Private Indexer
        -   Website: [http://torrentleech.org/](http://torrentleech.org/)
    -   Torznab
        -   Known indexers: Anime Tosho and Nyaa Pantsu as well as Jackett.
        -   Torznab is a wordplay on Torrent and Newznab. It uses the same structure and syntax as the Newznab API specification, but exposing torrent-specific attributes and .torrent files. Thus supports a recent rss feed AND backlog searching capabilities. The specification is not maintained nor supported by the Newznab organization. (The same api specification is shared with nZEDb)
        -   At this point it’s unlikely your favorite tracker supports this. We’ll update this post once we become aware of other trackers supporting it. Additionally you can use [Jackett](https://github.com/Jackett/Jackett). It acts as a Torznab proxy adding Torznab support for more than 100 torrent trackers, but uses website scraping instead of APIs.
        -   **Important/Disclaimer:** Many torrent trackers thrive on the community and may have rules in place that mandate site visits, karma, votes, comments and all. Please review your tracker rules and etiquette, keep your community alive.  
            
        -   We’re not responsible if your account is banned for disobeying rules or accruing HnRs/low-ratio.