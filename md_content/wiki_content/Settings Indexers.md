## Settings Indexers

### Overview

#### Radarr

<section begin=radarr_settings_indexers />

Once you're here you'll be adding the indexer/tracker that you'll be
using to actually download any of your files. If you're curious on how
Radarr works with your indexer/tracker click
[here](Radarr_FAQ "wikilink")

<section end=radarr_settings_indexers />

#### Sonarr

<section begin=sonarr_settings_indexers />

Once you're here you'll be adding the indexer/tracker that you'll be
using to actually download any of your files. If you're curious on how
Sonarr works with your indexer/tracker click
[here](Sonarr_FAQ "wikilink")

<section end=sonarr_settings_indexers />

#### Lidarr

<section begin=lidarr_settings_indexers />

Once you're here you'll be adding the indexer/tracker that you'll be
using to actually download any of your files. If you're curious on how
Lidarr works with your indexer/tracker click
[here](Lidarr_FAQ "wikilink")

<section end=lidarr_settings_indexers />

#### Readarr

<section begin=readarr_settings_indexers />

Once you're here you'll be adding the indexer/tracker that you'll be
using to actually download any of your files. If you're curious on how
Readarr works with your indexer/tracker click
[here](Readarr_FAQ "wikilink")

<section end=readarr_settings_indexers />

### Indexer Settings

#### Radarr

<section begin=radarr_settings_indexers_settings/>

Once you've clicked the `+` button to add a new indexer you'll be
presented with a new window with many different options. For the
purposes of this wiki Readarr considers both Usenet Indexers and Torrent
Trackers as "Indexers".

There are two sections here: Usenet and Torrents. Based upon what
download client you'll be using you'll want to select the type of
indexer you'll be going with.

More information on Indexers and Trackers can be found
[here](Definitions#Indexers/Trackers "wikilink")

##### Usenet Indexer Configuration

  - Newznab - Here you'll find presets of popular usenet indexers (that
    are pre-filled out, all you'll need is your API key which is
    provided by the usenet indexer of your choice) along with the
    ability to create a custom Indexer
  - An excellent software that works with usenet and integrates quite
    well with Radarr is
    [NZBHydra2](https://github.com/theotherp/nzbhydra2)
      - Regardless of if you select a pre filled out indexer or a custom
        indexer setup you'll be presented with a new window to input all
        your settings
      - Choose from the presets or add a custom indexer (such as
        NZBHydra2)
      - Name - The name of the indexer in Radarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <https://api.nzbgeek.info>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - *Multiple Languages* - Define what `MULTI` means for this
        indexer.
      - API Key - The indexer provided key to access the API.
      - *Categories* - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Radarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Additional Parameters* - Additional Newznab parameters to add
        to the query link
      - *Remove year from search string* - Should Radarr remove the year
        after the title when searching this indexer.
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

##### Torrent Tracker Configuration

  - As with Usenet there are an assortment of prefilled out Torrent
    tracker information. If you are not a member of any of these these
    specific trackers they will not do you any good.
  - One of the best and simplest ways to utilize Torrent trackers with
    Sonarr is to utilize a second program called
    [Jackett](https://github.com/Jackett/Jackett). This software pairs
    well with Sonarr as a search indexer that houses all your
    information and sends it to Sonarr.
  - Torznab - This option will set you up with a Jackett preset, if you
    utilize multiple trackers you'll need to have each entry have a
    unique name
  - Torznab Indexer
      - Choose from the presets or add a custom indexer (such as
        Jackett)
      - Name - The name of the indexer in Radarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <https://api.nzbgeek.info>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - *Multiple Languages* - Define what `MULTI` means for this
        indexer.
      - API Key - The indexer provided key to access the API.
      - *Categories* - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Radarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Additional Parameters* - Additional Newznab parameters to add
        to the query link
      - *Remove year from search string* - Should Radarr remove the year
        after the title when searching this indexer.
      - *Minimum Seeders* - The minimum number of seeders required for a
        release from this tracker to be grabbed.
      - *Seed Ratio* - If empty, use the download client default.
        Otherwise, the minimum seed ratio required for your download
        client to meet for releases from this indexer prior to it being
        paused by your client and removed by Sonarr (Requires Completed
        Download Handling - Remove enabled)
      - *Seed Time* - If empty, use the download client default.
        Otherwise, the minimum seed time in minutes required for your
        download client to meet for releases from this indexer prior to
        it being paused by your client and removed by Sonarr (Requires
        Completed Download Handling - Remove enabled)
      - *Required Flags* - What [ indexer
        flags](Definitions#Indexer_Flags "wikilink") are required for
        this indexer?
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

<section end=radarr_settings_indexers_settings/>

#### Sonarr

<section begin=sonarr_settings_indexers_settings/>

Once you've clicked the `+` button to add a new indexer you'll be
presented with a new window with many different options. For the
purposes of this wiki Readarr considers both Usenet Indexers and Torrent
Trackers as "Indexers".

There are two sections here: Usenet and Torrents. Based upon what
download client you'll be using you'll want to select the type of
indexer you'll be going with.

More information on Indexers and Trackers can be found
[here](Definitions#Indexers/Trackers "wikilink")

##### Usenet Indexer Configuration

  - Newznab - Here you'll find presets of popular usenet indexers (that
    are pre-filled out, all you'll need is your API key which is
    provided by the usenet indexer of your choice) along with the
    ability to create a custom Indexer
  - An excellent software that works with usenet and integrates quite
    well with Sonarr is
    [NZBHydra2](https://github.com/theotherp/nzbhydra2)
      - Regardless of if you select a pre filled out indexer or a custom
        indexer setup you'll be presented with a new window to input all
        your settings
      - Choose from the presets or add a custom indexer (such as
        NZBHydra2)
      - Name - The name of the indexer in Sonarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <https://api.nzbgeek.info>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - API Key - The indexer provided key to access the API.
      - Categories - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Sonarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - Anime Categories - The categories that Sonarr will use for Anime
        searches No categories will be used unless edited. Upon editing
        this setting, Sonarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Additional Parameters* - Additional Newznab parameters to add
        to the query link
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

##### Torrent Tracker Configuration

  - As with Usenet there are an assortment of prefilled out Torrent
    tracker information. If you are not a member of any of these these
    specific trackers they will not do you any good.
  - One of the best and simplest ways to utilize Torrent trackers with
    Sonarr is to utilize a second program called
    [Jackett](https://github.com/Jackett/Jackett). This software pairs
    well with Sonarr as a search indexer that houses all your
    information and sends it to Sonarr.
  - Torznab - This option will set you up with a Jackett preset, if you
    utilize multiple trackers you'll need to have each entry have a
    unique name
  - Torznab Indexer
      - Choose from the presets or add a custom indexer (such as
        Jackett)
      - Name - The name of the indexer in Sonarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <http://localhost:9117/jackett/api/v2.0/indexers/torrentdb/results/torznab/>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - API Key - The indexer provided key to access the API.
      - Categories - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Sonarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - Anime Categories - The categories that Sonarr will use for Anime
        searches No categories will be used unless edited. Upon editing
        this setting, Sonarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Additional Parameters* - Additional Torznab parameters to add
        to the query link
      - *Minimum Seeders* - The minimum number of seeders required for a
        release from this tracker to be grabbed.
      - *Seed Ratio* - If empty, use the download client default.
        Otherwise, the minimum seed ratio required for your download
        client to meet for releases from this indexer prior to it being
        paused by your client and removed by Sonarr (Requires Completed
        Download Handling - Remove enabled)
      - *Seed Time* - If empty, use the download client default.
        Otherwise, the minimum seed time in minutes required for your
        download client to meet for releases from this indexer prior to
        it being paused by your client and removed by Sonarr (Requires
        Completed Download Handling - Remove enabled)
      - *Seed Time* - If empty, use the download client default.
        Otherwise, the minimum seed time in minutes required for your
        download client to meet for season pack releases from this
        indexer prior to it being paused by your client and removed by
        Sonarr (Requires Completed Download Handling - Remove enabled)
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

<section end=sonarr_settings_indexers_settings/>

#### Lidarr

<section begin=lidarr_settings_indexers_settings/>

Once you've clicked the `+` button to add a new indexer you'll be
presented with a new window with many different options. For the
purposes of this wiki Readarr considers both Usenet Indexers and Torrent
Trackers as "Indexers".

There are two sections here: Usenet and Torrents. Based upon what
download client you'll be using you'll want to select the type of
indexer you'll be going with.

More information on Indexers and Trackers can be found
[here](Definitions#Indexers/Trackers "wikilink")

##### Usenet Indexer Configuration

  - Newznab - Here you'll find presets of popular usenet indexers (that
    are pre-filled out, all you'll need is your API key which is
    provided by the usenet indexer of your choice) along with the
    ability to create a custom Indexer
  - An excellent software that works with usenet and integrates quite
    well with Lidarr is
    [NZBHydra2](https://github.com/theotherp/nzbhydra2)
      - Regardless of if you select a pre filled out indexer or a custom
        indexer setup you'll be presented with a new window to input all
        your settings
      - Choose from the presets or add a custom indexer (such as
        NZBHydra2)
      - Name - The name of the indexer in Lidarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <https://api.nzbgeek.info>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - *Multiple Languages* - Define what `MULTI` means for this
        indexer.
      - API Key - The indexer provided key to access the API.
      - *Categories* - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Lidarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Additional Parameters* - Additional Newznab parameters to add
        to the query link
      - *Remove year from search string* - Should Lidarr remove the year
        after the title when searching this indexer.
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

##### Torrent Tracker Configuration

  - As with Usenet there are an assortment of prefilled out Torrent
    tracker information. If you are not a member of any of these these
    specific trackers they will not do you any good.
  - One of the best and simplest ways to utilize Torrent trackers with
    Sonarr is to utilize a second program called
    [Jackett](https://github.com/Jackett/Jackett). This software pairs
    well with Sonarr as a search indexer that houses all your
    information and sends it to Sonarr.
  - Torznab - This option will set you up with a Jackett preset, if you
    utilize multiple trackers you'll need to have each entry have a
    unique name
  - Torznab Indexer
      - Choose from the presets or add a custom indexer (such as
        Jackett)
      - Name - The name of the indexer in Lidarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <https://api.nzbgeek.info>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - *Multiple Languages* - Define what `MULTI` means for this
        indexer.
      - API Key - The indexer provided key to access the API.
      - *Categories* - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Lidarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Additional Parameters* - Additional Newznab parameters to add
        to the query link
      - *Remove year from search string* - Should Lidarr remove the year
        after the title when searching this indexer.
      - *Minimum Seeders* - The minimum number of seeders required for a
        release from this tracker to be grabbed.
      - *Seed Ratio* - If empty, use the download client default.
        Otherwise, the minimum seed ratio required for your download
        client to meet for releases from this indexer prior to it being
        paused by your client and removed by Sonarr (Requires Completed
        Download Handling - Remove enabled)
      - *Seed Time* - If empty, use the download client default.
        Otherwise, the minimum seed time in minutes required for your
        download client to meet for releases from this indexer prior to
        it being paused by your client and removed by Sonarr (Requires
        Completed Download Handling - Remove enabled)
      - *Required Flags* - What [ indexer
        flags](Definitions#Indexer_Flags "wikilink") are required for
        this indexer?
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

<section end=lidarr_settings_indexers_settings/>

#### Readarr

<section begin=readarr_settings_indexers_settings/>

Once you've clicked the `+` button to add a new indexer you'll be
presented with a new window with many different options. For the
purposes of this wiki Readarr considers both Usenet Indexers and Torrent
Trackers as "Indexers".

There are two sections here: Usenet and Torrents. Based upon what
download client you'll be using you'll want to select the type of
indexer you'll be going with.

More information on Indexers and Trackers can be found
[here](Definitions#Indexers/Trackers "wikilink")

##### Usenet Indexer Configuration

  - Newznab - Here you'll find presets of popular usenet indexers (that
    are pre-filled out, all you'll need is your API key which is
    provided by the usenet indexer of your choice) along with the
    ability to create a custom Indexer
  - An excellent software that works with usenet and integrates quite
    well with Readarr is
    [NZBHydra2](https://github.com/theotherp/nzbhydra2)
      - Regardless of if you select a pre filled out indexer or a custom
        indexer setup you'll be presented with a new window to input all
        your settings
      - Choose from the presets or add a custom indexer (such as
        NZBHydra2)
      - Name - The name of the indexer in Readarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <https://api.nzbgeek.info>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - API Key - The indexer provided key to access the API.
      - *Categories* - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Readarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Early Download Limit* - Number of days before the release date
        that Readarr will download from this indexer. If empty then no
        limit.
      - *Additional Parameters* - Additional Newznab parameters to add
        to the query link
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

##### Torrent Tracker Configuration

  - As with Usenet there are an assortment of prefilled out Torrent
    tracker information. If you are not a member of any of these these
    specific trackers they will not do you any good.
  - One of the best and simplest ways to utilize Torrent trackers with
    Readarr is to utilize a second program called
    [Jackett](https://github.com/Jackett/Jackett). This software pairs
    well with Readarr as a search indexer that houses all your
    information and sends it to Readarr.
  - Torznab - This option will set you up with a Jackett preset, if you
    utilize multiple trackers you'll need to have each entry have a
    unique name
  - Torznab Indexer
      - Choose from the presets or add a custom indexer (such as
        Jackett)
      - Name - The name of the indexer in Readarr
      - Enable RSS - If enabled, use this indexer to watch for files
        that are wanted and missing or have not yet reached their
        cutoff.
      - Enable Automatic Search - If enabled, use this indexer for
        automatic searches including Search on Add
      - Enable Interactive Search - If enabled, use this indexer for
        manual interactive searches.
      - URL - The indexer provided URL of the indexer such as
        <http://localhost:9117/jackett/api/v2.0/indexers/torrentdb/results/torznab/>.
      - *API Path* - The indexer provided path to the api. This is
        typically `/api`
      - API Key - The indexer provided key to access the API.
      - *Categories* - Default categories will be used unless edited. It
        is likely these default categories are suboptimal. Upon editing
        this setting, Readarr queries the indexer for its available
        categories and displays them in a selectable a list. The stale
        defaults will clear as soon as a category is toggled.
      - *Early Download Limit* - Number of days before the release date
        that Readarr will download from this indexer. If empty then no
        limit.
      - *Additional Parameters* - Additional Torznab parameters to add
        to the query link
      - *Minimum Seeders* - The minimum number of seeders required for a
        release from this tracker to be grabbed.
      - *Seed Ratio* - If empty, use the download client default.
        Otherwise, the minimum seed ratio required for your download
        client to meet for releases from this indexer prior to it being
        paused by your client and removed by Readarr (Requires Completed
        Download Handling - Remove enabled)
      - *Seed Time* - If empty, use the download client default.
        Otherwise, the minimum seed time in minutes required for your
        download client to meet for releases from this indexer prior to
        it being paused by your client and removed by Readarr (Requires
        Completed Download Handling - Remove enabled)
      - *Indexer Priority* - Priority of this indexer to prefer one
        indexer over another in release tiebreaker scenarios. 1 is
        highest priority and 50 is lowest priority.

<section end=readarr_settings_indexers_settings/>

### Options

#### Radarr

<section begin=radarr_settings_indexers_options />

  - Minimum Age - Usenet only: Minimum age in minutes of NZBs before
    they are grabbed. Use this to give new releases time to propagate to
    your usenet provider.
  - Retention - Usenet only: Set to zero to set for unlimited retention
  - Maximum Size - Maximum size for a release to be grabbed in MB. Set
    to zero to set to unlimited
  - Prefer Indexer Flag - If enabled, prioritize releases with special
    flags
      - See [Indexer Flags](Definitions#Indexer_Flags "wikilink") for
        more details
  - Availability Delay - Amount of time before (-\#) or after (\#) the
    available date to search for Movie
      - This is helpful to delay searching for a release to give the
        community time to perform the best encodes
  - *RSS Sync Interval* - Interval in minutes. Set to zero to disable
    (this will stop all automatic release grabbing) Minimum: 10 minutes
    Maximum: 120 minutes
      - Please see [How does Radarr
        work?](Radarr_FAQ#How_does_Radarr_work? "wikilink") for a better
        understanding of how RSS Sync will help you
      - Note: If Radarr has been offline for an extended period of time,
        Radarr will attempt to page back to find the last release it
        processed in an attempt to avoid missing a release. As long as
        your indexer supports paging and it hasn’t been too long will be
        able to process the releases it would have missed and avoid you
        needing to perform a search for the missed releases.
  - *Whitelisted Subtitle Tags* - Subtitle tags set here will not be
    considered hardcoded
  - *Allow Hardcoded Subs* - If enabled, detected hardcoded subs will be
    automatically downloaded

<section end=radarr_settings_indexers_options />

#### Sonarr

<section begin=sonarr_settings_indexers_options />

  - Minimum Age - Usenet only: Minimum age in minutes of NZBs before
    they are grabbed. Use this to give new releases time to propagate to
    your usenet provider.
  - Retention - Usenet only: Set to zero to set for unlimited retention
  - Maximum Size - Maximum size for a release to be grabbed in MB. Set
    to zero to set to unlimited
  - RSS Sync interval - Interval in minutes. Set to zero to disable
    (this will stop all automatic release grabbing) Minimum: 10 minutes
    Maximum: 120 minutes
      - Please see [How does Sonarr find
        episodes?](Sonarr_FAQ#How_does_Sonarr_find_episodes? "wikilink")
        for a better understanding of how RSS Sync will help you
      - Note: If Sonarr has been offline for an extended period of time,
        Sonarr will attempt to page back to find the last release it
        processed in an attempt to avoid missing a release. As long as
        your indexer supports paging and it hasn’t been too long will be
        able to process the releases it would have missed and avoid you
        needing to perform a search for the missed releases.

<section end=sonarr_settings_indexers_options />

#### Lidarr

<section begin=lidarr_settings_indexers_options />

  - Minimum Age - Usenet only: Minimum age in minutes of NZBs before
    they are grabbed. Use this to give new releases time to propagate to
    your usenet provider.
  - Maximum Size - Maximum size for a release to be grabbed in MB. Set
    to zero to set to unlimited
  - Retention - Usenet only: Set to zero to set for unlimited retention
  - RSS Sync interval - Interval in minutes. Set to zero to disable
    (this will stop all automatic release grabbing) Minimum: 10 minutes
    Maximum: 120 minutes
      - Please see [How does Lidarr
        work?](Lidarr_FAQ#How_does_Lidarr_work? "wikilink") for a better
        understanding of how RSS Sync will help you
      - Note: If Lidarr has been offline for an extended period of time,
        Lidarr will attempt to page back to find the last release it
        processed in an attempt to avoid missing a release. As long as
        your indexer supports paging and it hasn’t been too long will be
        able to process the releases it would have missed and avoid you
        needing to perform a search for the missed releases.

<section end=lidarr_settings_indexers_options />

#### Readarr

<section begin=readarr_settings_indexers_options />

  - Minimum Age - Usenet only: Minimum age in minutes of NZBs before
    they are grabbed. Use this to give new releases time to propagate to
    your usenet provider.
  - Maximum Size - Maximum size for a release to be grabbed in MB. Set
    to zero to set to unlimited
  - Retention - Usenet only: Set to zero to set for unlimited retention
  - RSS Sync interval - Interval in minutes. Set to zero to disable
    (this will stop all automatic release grabbing) Minimum: 10 minutes
    Maximum: 120 minutes
      - Please see [How does Readarr
        work?](Readarr_FAQ#How_does_Readarr_work? "wikilink") for a
        better understanding of how RSS Sync will help you
      - Note: If Readarr has been offline for an extended period of
        time, Readarr will attempt to page back to find the last release
        it processed in an attempt to avoid missing a release. As long
        as your indexer supports paging and it hasn’t been too long will
        be able to process the releases it would have missed and avoid
        you needing to perform a search for the missed releases.

<section end=readarr_settings_indexers_options />

### Restrictions

#### Radarr

<section begin=radarr_settings_indexers_restrictions />

  - Here you'll be able to set global restrictions based upon a couple
    of parameters
  - Click the `+` and a new window will open
      - Must Contain - Within this field you can tell Radarr that if a
        release does not contain a certain string then Radarr will not
        grab that release. This is case insensitive by default and regex
        can be used.
      - Must Not Contain - Within this field you can tell Radarr that if
        a release does contain a certain string then Radarr will not
        grab that release. This is case insensitive by default and regex
        can be used.
      - Tags - Here you can apply these settings to movies with at least
        one of the given tag
          - Please see [Tags](#Tags "wikilink")

<section end=radarr_settings_indexers_restrictions />

#### Sonarr

<section begin=sonarr_settings_indexers_restrictions />

Not in Sonarr

<section end=sonarr_settings_indexers_restrictions />

#### Lidarr

<section begin=lidarr_settings_indexers_restrictions />

Not in Lidarr

<section end=lidarr_settings_indexers_restrictions />

#### Readarr

<section begin=readarr_settings_indexers_restrictions />

Not in Readarr

<section end=readarr_settings_indexers_restrictions />

### Supported Indexers

#### Radarr

<section begin=radarr_settings_indexers_supported_indexers />

  - Usenet
      - Newznab
          - Newznab is a standardized API used by many usenet indexing
            sites.
          - Many presets are available, but all require an API key to be
            accessible.
      - Omgwtfnzbs
          - This indexer *also* supports newznab and is available as one
            of the above presets.
          - Website: <https://omgwtfnzbs.me/>

Torrents

  -   - filelist.io
          - Private Tracker
          - Website: <https://filelist.io/>
      - HDBits
          - Private Tracker
          - Website: <https://hdbits.org>
      - IP Torrents
          - Private Tracker
          - Website: <https://iptorrents.com>
      - Nyaa
          - Website: <http://www.nyaa.si/>
          - Torrent Indexer for Japanese media (Anime) exclusively.
      - Pass the Popcorn
          - Private Tracker
          - Website: <https://passthepopcorn.me>
      - Rarbg
          - Website: <https://rarbg.to/>
      - Torrent RSS Feed
          - Generic torrent RSS feed parser.
          - **NOTE:** The RSS feed must contain a pubdate. The release
            size is recommended as well.
      - TorrentPotato
          - Website:
            [TorrentPotato](https://github.com/CouchPotato/CouchPotatoServer/wiki/Couchpotato-torrent-provider)
      - Torznab
          - Known indexers: Anime Tosho and Nyaa Pantsu as well as
            Jackett.
          - Torznab is a wordplay on Torrent and Newznab. It uses the
            same structure and syntax as the Newznab API specification,
            but exposing torrent-specific attributes and .torrent files.
            Thus supports a recent rss feed AND backlog searching
            capabilities. The specification is not maintained nor
            supported by the Newznab organization. (The same api
            specification is shared with nZEDb)
          - At this point it’s unlikely your favorite tracker supports
            this. Thus you can use
            [Jackett](https://github.com/Jackett/Jackett). It acts as a
            Torznab proxy adding Torznab support for more than 100
            torrent trackers, but uses website scraping instead of APIs.
          - **Important/Disclaimer:** Many torrent trackers thrive on
            the community and may have rules in place that mandate site
            visits, karma, votes, comments and all. Please review your
            tracker rules and etiquette, keep your community alive.  
      - We’re not responsible if your account is banned for disobeying
        rules or accruing HnRs/low-ratio.

<section end=radarr_settings_indexers_supported_indexers />

#### Sonarr

<section begin=sonarr_settings_indexers_supported_indexers />

  - Usenet
      - Newznab
          - Newznab is a standardized API used by many usenet indexing
            sites.
          - Many presets are available, but all require an API key to be
            accessible.
      - Omgwtfnzbs
          - This indexer *also* supports newznab and is available as one
            of the above presets.
          - Website: <https://omgwtfnzbs.me/>
      - Fanzub
          - Website: <http://fanzub.com/>
          - Indexer for Japanese media (Anime) exclusively.
  - Torrents
      - BroadcastheNet
          - Private Tracker
          - Website: <https://broadcasthe.net/>
      - Filelist
          - Private Tracker
          - Website: <https://filelist.io>
      - HDBits
          - Private tracker
          - Website: <https://hdbits.org/>
      - IPTorrents
          - Private tracker, no search api.
          - Website: <http://www.iptorrents.com/>
      - Nyaa
          - Website: <http://www.nyaa.si/>
          - Torrent Indexer for Japanese media (Anime) exclusively.
      - Rarbg
          - Website: <https://rarbg.to/>
      - Torrent RSS Feed
          - Generic torrent RSS feed parser.
          - **NOTE:** The RSS feed must contain a pubdate. The release
            size is recommended as well.
          - Private tracker
      - Torrentleech
          - Private Indexer
          - Website: <http://torrentleech.org/>
      - Torznab
          - Known indexers: Anime Tosho and Nyaa Pantsu as well as
            Jackett.
          - Torznab is a wordplay on Torrent and Newznab. It uses the
            same structure and syntax as the Newznab API specification,
            but exposing torrent-specific attributes and .torrent files.
            Thus supports a recent rss feed AND backlog searching
            capabilities. The specification is not maintained nor
            supported by the Newznab organization. (The same api
            specification is shared with nZEDb)
          - At this point it’s unlikely your favorite tracker supports
            this. We’ll update this post once we become aware of other
            trackers supporting it. Additionally you can use
            [Jackett](https://github.com/Jackett/Jackett). It acts as a
            Torznab proxy adding Torznab support for more than 100
            torrent trackers, but uses website scraping instead of APIs.
          - **Important/Disclaimer:** Many torrent trackers thrive on
            the community and may have rules in place that mandate site
            visits, karma, votes, comments and all. Please review your
            tracker rules and etiquette, keep your community alive.  
          - We’re not responsible if your account is banned for
            disobeying rules or accruing HnRs/low-ratio.
      - We’re not responsible if your account is banned for disobeying
        rules or accruing HnRs/low-ratio.

<section end=sonarr_settings_indexers_supported_indexers />

#### Lidarr

<section begin=lidarr_settings_indexers_supported_indexers />

  - Usenet
      - Headphones VIP
          - Website: <https://headphones.codeshy.com/vip/>
      - Newznab
          - Newznab is a standardized API used by many usenet indexing
            sites.
          - Many presets are available, but most require an API key to
            be accessible.
      - Omgwtfnzbs
          - This indexer *also* supports newznab and is available as one
            of the above presets.
          - Website: <https://omgwtfnzbs.me/>
  - Torrents
      - filelist.io
          - Private Tracker
          - Website: <https://filelist.io/>
      - Gazelle API
          - Private Tracker
          - Website: <https://gazellegames.net/login.php>
      - IP Torrents
          - Private Tracker
          - Website: <https://iptorrents.com>
      - Rarbg
          - Website: <https://rarbg.to/>
      - Redacted
          - Private Tracker - Considered one of the best Music Trackers
            on the net.
          - Website: <https://redacted.ch/index.php>
          - Interview: <https://interviewfor.red/en/index.html>
      - Torrent RSS Feed
          - Generic torrent RSS feed parser.
          - **NOTE:** The RSS feed must contain a pubdate. The release
            size is recommended as well.
      - Torrentleech
          - Private Indexer
          - Website: <http://torrentleech.org/>
      - Torznab
          - Known indexers: Anime Tosho and Nyaa Pantsu as well as
            Jackett.
          - Torznab is a wordplay on Torrent and Newznab. It uses the
            same structure and syntax as the Newznab API specification,
            but exposing torrent-specific attributes and .torrent files.
            Thus supports a recent rss feed AND backlog searching
            capabilities. The specification is not maintained nor
            supported by the Newznab organization. (The same api
            specification is shared with nZEDb)
          - At this point it’s unlikely your favorite tracker supports
            this. We’ll update this post once we become aware of other
            trackers supporting it. Additionally you can use
            [Jackett](https://github.com/Jackett/Jackett). It acts as a
            Torznab proxy adding Torznab support for more than 100
            torrent trackers, but uses website scraping instead of APIs.
          - **Important/Disclaimer:** Many torrent trackers thrive on
            the community and may have rules in place that mandate site
            visits, karma, votes, comments and all. Please review your
            tracker rules and etiquette, keep your community alive.  
      - We’re not responsible if your account is banned for disobeying
        rules or accruing HnRs/low-ratio.

<section end=lidarr_settings_indexers_supported_indexers />

#### Readarr

<section begin=readarr_settings_indexers_supported_indexers />

  - Usenet
      - Newznab
          - Newznab is a standardized API used by many usenet indexing
            sites.
          - Many presets are available, but most require an API key to
            be accessible.
      - Omgwtfnzbs
          - This indexer *also* supports newznab and is available as one
            of the above presets.
          - Website: <https://omgwtfnzbs.me/>
  - Torrents
      - filelist.io
          - Private Tracker
          - Website: <https://filelist.io/>
      - Gazelle API
          - Private Tracker
          - Website: <https://gazellegames.net/login.php>
      - IP Torrents
          - Private Tracker
          - Website: <https://iptorrents.com>
      - Rarbg
          - Website: <https://rarbg.to/>
      - Torrent RSS Feed
          - Generic torrent RSS feed parser.
          - **NOTE:** The RSS feed must contain a pubdate. The release
            size is recommended as well.
      - Torrentleech
          - Private Indexer
          - Website: <http://torrentleech.org/>
      - Torznab
          - Known indexers: Jackett.
          - Torznab is a wordplay on Torrent and Newznab. It uses the
            same structure and syntax as the Newznab API specification,
            but exposing torrent-specific attributes and .torrent files.
            Thus supports a recent rss feed AND backlog searching
            capabilities. The specification is not maintained nor
            supported by the Newznab organization. (The same api
            specification is shared with nZEDb)
          - At this point it’s unlikely your favorite tracker supports
            this. Additionally you can use
            [Jackett](https://github.com/Jackett/Jackett). It acts as a
            Torznab proxy adding Torznab support for more than 100
            torrent trackers, but uses website scraping instead of APIs.
          - **Important/Disclaimer:** Many torrent trackers thrive on
            the community and may have rules in place that mandate site
            visits, karma, votes, comments and all. Please review your
            tracker rules and etiquette, keep your community alive.  
      - We’re not responsible if your account is banned for disobeying
        rules or accruing HnRs/low-ratio.

<section end=readarr_settings_indexers_supported_indexers />

### Templates

None.
