How does Sonarr find episodes?
------------------------------

<span id="how_does_Sonarr_find_episodes"><small>[anchor](#how_does_Sonarr_find_episodes "wikilink")</small></span>\

-   Sonarr does *not* regularly search for episode files that are
    missing or have not met their quality goals. Instead, it fairly
    frequently queries your indexers and trackers for *all* the newly
    posted episodes/newly uploaded releases, then compares that with its
    list of episodes that are missing or need to be upgraded. Any
    matches are downloaded. This lets Sonarr cover a library of *any
    size* with just 24-100 queries per day (RSS interval of 15-60
    minutes). If you understand this, you\'ll realize that it only
    covers the *future* though.
-   So how do you deal with the present and past? When you\'re adding a
    show, you\'ll need to set the correct path, profile and monitoring
    status then use the Start search for missing checkbox. If the show
    has had no episodes and hasn\'t been released yet, you don\'t need
    to initiate a search.
-   Put another way, Sonarr will only find releases that are newly
    uploaded to your indexers. It will not actively try to find releases
    uploaded in the past.
-   If you\'ve already added the show, but now you want to search for
    it, you have a few choices. You can go to the show\'s page and use
    the search button, which will do a search and then automatically
    pick episode(s). You can search individual episodes or seasons
    automatically or manually. Or you can use the filters of `Missing`
    and `Cut-off Unmet`.
-   If Sonarr has been offline for an extended period of time, Sonarr
    will attempt to page back to find the last release it processed in
    an attempt to avoid missing a release. As long as your indexer
    supports paging and it hasn\'t been too long Sonarr will be able to
    process the releases it would have missed and avoid you needing to
    perform a search for the missed episodes.

Why didn't Sonarr grab an episode I was expecting?
--------------------------------------------------

<span id="Why_didnt_Sonarr_grab_an_episode_i_was_expecting"><small>[anchor](#Why_didnt_Sonarr_grab_an_episode_i_was_expecting "wikilink")</small></span>\
First, make sure you read and understand the section above called *"How
does Sonarr find episodes?"* Second, make sure at least one of your
indexers has the episode you were expecting to be grabbed.

1.  Click the 'Manual Search' icon next to the episode listing in
    Sonarr. Are there any results? If no, then either Sonarr is having
    trouble communicating with your indexers, or your indexers do not
    have the episode, or the episode is improperly named/categorized on
    the indexer.
2.  **If there are results from step 1**, check next to them for red
    exclamation point icon. Hover over the icon to see why that release
    is not a candidate for automatic downloads. If every result has the
    icon, then no automatic download will occur.
3.  **If there is at least one valid manual search result from step 2**,
    then an automatic download should have happened. If it didn't, the
    most likely reason is a temporary communication problem preventing
    an RSS Sync from your indexer. It is recommended to have several
    indexers set up for best results.
4.  **If there is no manual result from a show, but you can find it when
    you browse your indexer's website** - This is a common problem that
    is most frequently caused by having an insufficient number of
    indexers. Different indexers index different content, and not all
    shows on your indexer may be tagged properly, which would cause
    Sonarr's search to fail. Having several indexers active is the best
    solution to this problem.

How are possible downloads compared?
------------------------------------

<span id="how_are_possible_downloads_compared"><small>[anchor](#how_are_possible_downloads_compared "wikilink")</small></span>\
**Generally Quality Trumps All**

The current logic [can be found
here](https://github.com/Sonarr/Sonarr/blob/develop/src/NzbDrone.Core/DecisionEngine/DownloadDecisionComparer.cs#L31-L40s).
***As of 3/26/2021 the logic is as follows***

1.  Quality
2.  Language
3.  Preferred Word Score
4.  Protocol
5.  Episode Count
6.  Episode Number
7.  Indexer Priority
8.  Peers (If Torrent)
9.  Age (If Usenet)
10. Size

Preferred Words FAQs
--------------------

<span id="Preferred_Words_FAQs"><small>[anchor](#Preferred_Words_FAQs "wikilink")</small></span>\
For the score of the on disk file: The existing name of the file and the
\"scene name\" of the release are evaluated for preferred words. The
higher score of the two is taken.

How are preferred words included in renaming?

For Sonarr you can make use of the \`{Preferred Words}\` token in your
renaming scheme. and also check mark \`Include Preferred when Renaming\`
in the release profile. take a look
[HERE](https://trash-guides.info/Sonarr/V3/Sonarr-recommended-naming-scheme/)
for a recommended naming scheme examples for Sonarr.

Using the tokens in your renaming scheme could help with download loop
issues.

Preferred Words always upgrade a release even if the quality and/or
language cutoff has been met.

How does Sonarr handle scene numbering issues (American Dad!, etc)?
-------------------------------------------------------------------

<span id="how_does_sonarr_handle_scene_numbering_issues"><small>[anchor](#how_does_sonarr_handle_scene_numbering_issues "wikilink")</small></span>\

-   **How Sonarr handles scene numbering issues**
    -   Sonarr relies on [TheXEM](http://thexem.de/), a community driven
        site that lets users create mappings of shows that the scene
        (the people that post the files) and TheTVDB (which typically
        follows the network's numbering). There are a number of shows on
        there already, but it is easy to add another and typically the
        changes are accepted within a couple days (if they're correct).
        TheXEM is used to correct differences in episode numbering
        (disagreement whether an episode is a special or not) as well as
        season number differences, such as episodes being released as
        S10E01, but TheTVDB listing that same episode as S2017E01.
-   **Problematic Shows**
    -   This by no means is an all inclusive list of shows that have
        known issues with scene mapping however, these are the big ones
        that come to mind while writing this.
    -   Typical Issue: Scene numbering does not match TVDb numbering so
        Sonarr doesn\'t work. Well enter XEM which creates a map for
        Sonarr to look at.
        -   Scene releases double episodes in a single file since that
            is how they air but TVDb marks each episode individually.
        -   Scene uses a year for the season S2010 and TVDb uses S01.
    -   [XEM](http://thexem.de) works in most cases and keeps it running
        smooth without you ever knowing. However as with most things,
        there will always be a *black sheep* and in this case there is a
        list of them.
    -   This is an incomplete list of the known shows and how/why
        they\'re problematic:
        -   American Dad
        -   Arrested Development
        -   Mythbusters
        -   Paw Patrol
            -   Double episode files vs single episode TVDb but also not
                all episodes are doubles so the map can get added wrong
                pointing to which ones are singles vs doubles
        -   Pawn Stars
        -   Pokémon
            -   On TheXem, [pokemon](http://thexem.de/xem/show/4638) is
                tracking \* dubbed\* episodes. So if you want subbed
                episodes, you may be out of luck. If certain release
                groups are following TVDB and not XEM mapping, please
                contact us on our discord and bring the release name and
                group name as exceptions can be added for groups who
                follow TVDB.
-   **Possible resolutions:**

1.  TVDb adds alternate ordering to the API (Current status: They say v4
    but don\'t count on it to work or be stable based on the history of
    v3)
2.  XEM adds a map to allow for alternate orders that sonarr can use
    (Current status: Unlikely)
3.  Sonarr allows for disabling of XEM maps when doing manual searches
    (Current status: Unlikely)

-   **Sonarr side effects:**
    -   On top of the issues with the shows already, Sonarr also has
        some odd behavior so you may just need to overlook this as well.
        Example:
    -   American Dad is currently on S17 based on TVDb or S16 based on
        Scene at the time of this writing. So searching in sonarr for
        season 17 will **only** return S16 results because of the XEM
        map. If you have a tracker with S17 episodes (because they use
        P2P and not Scene), please contact us on our discord and bring
        the release name and group name as exceptions can be added for
        groups who follow TVDB.

Why can't Sonarr import episode files for series X? / Why can't Sonarr find releases for series X?
--------------------------------------------------------------------------------------------------

<span id="why_cant_sonarr_import_episode_files_for_series_x_why_cant_sonarr_find_releases_for_series_x"><small>[anchor](#why_cant_sonarr_import_episode_files_for_series_x_why_cant_sonarr_find_releases_for_series_x "wikilink")</small></span>\
Sonarr relies on being able to match titles, often the scene posts
episodes using different titles, eg *CSI: Crime Scene Investigation* as
just *CSI* so Sonarr can't match the names without some help. Sonarr
maintains a list of problematic series which lets us solve this issue.
**For anime, it will need to be added to
[thexem.de](https://thexem.de)**, for other series to request a new
mapping see the steps below.

1.  Make sure it hasn't already been requested. [Requested
    Mappings](https://docs.google.com/spreadsheet/ccc?key=0Atcf2VZ47O8tdGdQN1ZTbjFRanhFSTBlU0xhbzhuMGc#gid=0)
2.  Make a new request here: [Scene Mapping Request
    Form](https://docs.google.com/forms/d/15S6FKZf5dDXOThH4Gkp3QCNtS9Q-AmxIiOpEBJJxi-o/viewform)

*Typically these are added within 1-2 days.*

*Again, do not request a mapping for Anime; use XEM for that.* Further
information can be found with some of the XEM folks that hangout in our
[\#XEM discord channel](https://discord.gg/an9rnEdWs5).

The series \"Helt Perfekt\" with TVDB ids of `343189` and `252077` is
difficult to automate due to TVDB having the same name for both shows,
violating TVDB\'s own rules. The first entry for the series gets the
name. Any future entries for the series must have the year as part of
the series name. However, a scene exception as been added to map
releases (case sensitive mapping) Helt Perfekt releases containing
`NORWEGIAN` -\> `252077` and containing `SWEDISH` -\> `343189`

TVDB is updated why isn\'t Sonarr?
----------------------------------

<span id="tvdb_is_updated_why_is_not_sonarr"><small>[anchor](#tvdb_is_updated_why_is_not_sonarr "wikilink")</small></span>\
TVDB has a 24 hour cache on their API. Skyhook has a much smaller few
hour cache on top of that. Sonarr only runs the Refresh Series task
every 12 hours. Thus it typically takes 24 to 48 hours for a TVDB update
to make it into Sonarr.

If you know a TVDB update was made more than 48 hours ago, then please
come discuss on our [Discord](https://discord.gg/M6BvZn5).

I see that feature/bug X was fixed, why can't I see it?
-------------------------------------------------------

<span id="i_see_that_feature_bug_x_was_fixed_why_cant_i_see_it"><small>[anchor](#i_see_that_feature_bug_x_was_fixed_why_cant_i_see_it "wikilink")</small></span>\
Sonarr consists of two main branches of code, `main` and `develop`,
`main`is released periodically, when the `develop` branch is stable and
`develop` is for pre-release testing and people willing to live on the
edge, if you want to help out testing or want more information on the
two branches, please see: [Release
Branches](Sonarr_Settings#Updates "wikilink"). When a feature is marked
as in `develop` it will only be available to users running the `develop`
branch, once it has been move to live (in `main`) it is officially
released.

Episode Progress - How is it calculated?
----------------------------------------

<span id="episode_progress_-_how_is_it_calculated"><small>[anchor](#episode_progress_-_how_is_it_calculated "wikilink")</small></span>\
There are two parts to the episode count, one being the number of
episodes (Episode Count) and the other being the number of episodes with
files (Episode File Count), each one uses slightly different logic to
give you the overall progress for a series or season.

-   Episode Count
    -   Episode has already aired AND is monitored OR
    -   Episode has a file
-   Episode File Count
    -   Episode has a file

If a series has 10 episodes that have all aired and you don't have any
files for them you would have 0/10 episodes, if you unmonitored all the
episodes in that series you would have 0/0 and if you got all the
episodes for that series, regardless of if the episodes are monitored or
not, you would have 10/10 episodes.

How do I access Sonarr from another computer?
---------------------------------------------

<span id="how_do_I_access_sonarr_from_another_computer"><small>[anchor](#how_do_I_access_sonarr_from_another_computer "wikilink")</small></span>\
By default Sonarr doesn't listen to requests from all systems (when not
run as administrator), it will only listen on localhost, this is due to
how the Web Server Sonarr uses integrates with Windows (this also
applies for current alternatives). If Sonarr is run as an administrator
it will correctly register itself with Windows as well as open the
Firewall port so it can be accessed from other systems on your network.
Running as admin only needs to happen once (if you change the port it
will need to be re-run).

Why doesn't Sonarr automatically search for missing episodes?
-------------------------------------------------------------

<span id="why_doesnt_sonarr_automatically_search_for_missing_episodes"><small>[anchor](#why_doesnt_sonarr_automatically_search_for_missing_episodes "wikilink")</small></span>\
There are two times when we would want to have missing episodes searched
for, when a new series with existing aired episodes is added and when
Sonarr has been offline and unable to find episodes as it normally
would. Endlessly searching for episodes that have aired that are missing
is a waste of resources, both in terms of local processing power and on
the indexers and in our experience catches users off guard, wasting
bandwidth.

In v1 of Sonarr we had an opt in backlog search option, often people
would turn it on and then get a bunch of old episodes and ask us why, we
also had indexers ask why they saw an increase in API calls, which was
due to the backlog searching.

In v2 we sat back and thought about it and realized the benefit is not
really there, we could try to throttle the searching, but that just
draws it out and still does the same thing; hammer the indexer with
useless requests. If the episode wasn't there the last time the search
was performed, why would it be there now? It would be if it was
reposted, but if it was reposted, the automatic process that gets new
episodes would see it was posted and act on it.

Why does Sonarr refresh series information so frequently?
---------------------------------------------------------

<span id="why_does_sonarr_refresh_series_information_so_frequently"><small>[anchor](#why_does_sonarr_refresh_series_information_so_frequently "wikilink")</small></span>\

-   Sonarr refreshes series and episode information in addition to
    rescanning the disk for files every 12 hours. This might seem
    aggressive, but is a very important process. The data refresh from
    our TVDB proxy is important, because new episode information is
    synced down, air dates, number of episodes, status
    (continuing/ended). Even shows that aren't airing are being updated
    with new information.
-   The disk scan is less important, but is used to check for new files
    that weren't sorted by Sonarr and detect deleted files.
-   The most time consuming portion is the information refresh (assuming
    reasonable disk access speed), larger shows take longer due to the
    number of episodes to process.

Why is there a number next to Activity?
---------------------------------------

<span id="why_is_there_a_number_next_to_activity"><small>[anchor](#why_is_there_a_number_next_to_activity "wikilink")</small></span>\

-   This number shows the count of episodes in your download client's
    queue and the last 30 items in its history that have not yet been
    imported. If the number is blue it is operating normally and should
    import episodes when they complete. Yellow means there is a warning
    on one of the episodes. Red means there has been an error. In the
    case of yellow (warning) and red (error), you will need to look at
    the queue under Activity to see what the issue is (hover over the
    icon to get more details).
-   You need to remove the item from your download client's queue or
    history to remove them from Sonarr's queue.

I see log messages for shows I don't have/don't want
----------------------------------------------------

<span id="i_see_log_messages_for_shows_i_don_t_have_dont_want"><small>[anchor](#i_see_log_messages_for_shows_i_don_t_have_dont_want "wikilink")</small></span>\

-   These messages are completely normal and come from the RSS feeds
    that Sonarr checks to see if there are episodes you do want, usually
    these only appear in debug/trace logging, but in the event of an
    problem processing an item you may see a warning or error. It is
    safe to ignore the warnings/errors as well since they are for shows
    you don't want, in the event it is for a show you want, open up a
    support thread on the forums.

Seeding torrents aren't deleted automatically
---------------------------------------------

<span id="seeding_torrents_arent_deleted_automatically"><small>[anchor](#seeding_torrents_arent_deleted_automatically "wikilink")</small></span>\

-   When a torrent that is still seeding is imported, it is copied or
    hard linked (if enabled and *possible*) so that the torrent client
    can continue seeding. In an ideal setup, the torrent download folder
    and the library folder will be on the same file system and *look
    like it* (Docker and network shares make this easy to get wrong),
    which makes hard links possible and minimizes wasted space.
-   In addition, you can configure your seed time/ratio goals in Sonarr
    or your download client, setup your download client to *pause* or
    *stop* when they're met and enable Remove under Completed and Failed
    Download Handler. That way, torrents that finish seeding will be
    removed from the download client by Sonarr.

Why can't I add a new series?
-----------------------------

<span id="why_cant_i_add_a_new_series"><small>[anchor](#why_cant_i_add_a_new_series "wikilink")</small></span>\

-   In the event that TheTVDB is unavailable Sonarr is unable to get
    search results and you will be unable to add any new series by
    searching. You may be able to add a new series by the TVDBID if you
    know what it is, the UI explains how to add it by an ID.
-   Sonarr cannot add any series that does not have an English language
    title. If you try to add a series via TVDB ID that does not have an
    English title. If no English title exist for that series on TheTVDB
    it will need to be added (if available).
-   The show must be a TV Series, and not a movie. It must also exist on
    TVDB. If it is on IMDB, TMDB, or anywhere else, but not on TVDB you
    cannot add the show.
-   The series must exist on TVDB

Why can't I add a new series when I know the TVDB ID?
-----------------------------------------------------

<span id="why_cant_i_add_a_new_series_when_i_know_the_tvdb_id"><small>[anchor](#why_cant_i_add_a_new_series_when_i_know_the_tvdb_id "wikilink")</small></span>\

-   Sonarr cannot add any series that does not have an English language
    title. If you try to add a series via TVDB ID that does not have an
    English title. If no English title exist for that series on TheTVDB
    it will need to be added (if available).

Sonarr won\'t work on Big Sur
-----------------------------

<span id="sonarr_wont_work_on_big_sur"><small>[anchor](#sonarr_wont_work_on_big_sur "wikilink")</small></span>\
Run `chmod +x /Applications/Sonarr.app/Contents/MacOS/Sonarr`

My Custom Script stopped working after upgrading from v2
--------------------------------------------------------

<span id="my_custom_script_stopped_working_after_upgrading_from_v2"><small>[anchor](#my_custom_script_stopped_working_after_upgrading_from_v2 "wikilink")</small></span>\
You were likely passing arguments in your connection\...that is not
supported.

1.  Change your argument to be your path
2.  Make sure the shebang in your script maps to your pwsh path (if you
    don\'t have a shebang definition in there, add it)
3.  Make sure the pwsh script is executable

What\'s the different Series Types?
-----------------------------------

<span id="whats_the_different_series_types"><small>[anchor](#whats_the_different_series_types "wikilink")</small></span>\
Most shows should be `Standard`. For daily shows which are typically
released with a date, `Daily` should be used. Finally, there is anime
where using `Anime` is *usually* right, but sometimes `Standard` can
work better, so try the *other* one if you're having issues.

Please note that if the series type is set to anime and none of your
enabled indexers have any anime categories configured then it
effectively skips the indexer and may appear that it is not searching.

### Show Type Examples

Below are some example release names for each show type. The specific
differentiating piece is noted in bold.

**Daily**

-   Some.Daily.Show.**2021.03.04**.1080p.HDTV.x264-DARKSPORT
-   A.Daily.Show.with.Some.Guy.**2021.03.03**.1080p.CC.WEB-DL.AAC2.0.x264-null
-   DailyShow.**2021.03.08**.720p.HDTV.x264-NTb

**Standard**

-   The.Show.**S20E03**.Episode.Title.Part.3.1080p.HULU.WEB-DL.DDP5.1.H.264-NTb
-   Another.Show.**S03E08**.1080p.WEB.H264-GGEZ
-   GreatShow.**S17E02**.1080p.HDTV.x264-DARKFLiX

**Anime**

-   Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
-   \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC)
    \[63B8AC67\]
-   \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English
    Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]

How can I rename my series folders?
-----------------------------------

<span id="how_can_i_rename_my_series_folders"><small>[anchor](#how_can_i_rename_my_series_folders "wikilink")</small></span>\
\# Series

1.  Mass Editor
2.  Select what series need their folder renamed
3.  Change Root Folder to the same Root Folder that the series currently
    exist in
4.  Select \"Yes move files\"
