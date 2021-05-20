How does Lidarr work?
---------------------

<span id="how_does_lidarr_work"><small>[anchor](#how_does_lidarr_work "wikilink")</small></span>\
\* Lidarr relies on RSS feeds to automate grabbing of releases as they
are posted, for both new releases as well as previously released
releases being released or re-released. The RSS feed is the latest
releases from a site, typically between 50 and 100 releases, though some
sites provide more and some less. The RSS feed is comprised of all
releases recently available, including releases for requested media you
do not follow, if you look at debug logs you will see these releases
being processed, which is completely normal.

-   Lidarr enforces a minimum of 10 minutes on the RSS Sync interval and
    a maximum of 2 hours. 15 minutes is the minimum recommended by most
    indexers, though some do allow lower intervals and 2 hours ensures
    Lidarr is checking frequently enough to not miss a release (even
    though it can page through the RSS feed on many indexers to help
    with that). Some indexers allow clients to perform an RSS sync more
    frequently than 10 minutes, in those scenarios we recommend using
    Lidarr\'s Release-Push API endpoint along with an IRC announce
    channel to push releases to Lidarr for processing which can happen
    in near real time and with less overhead on the indexer and Lidarr
    as Lidarr doesn't need to request the RSS feed too frequently and
    process the same releases over and over.

Why does Lidarr only show studio albums, How do I find singles or EPs?
----------------------------------------------------------------------

<span id="why_does_lidarr_only_show_studio_albums_how_do_i_find_singles_or_eps"><small>[anchor](#why_does_lidarr_only_show_studio_albums_how_do_i_find_singles_or_eps "wikilink")</small></span>\
Lidarr defaults to only bringing in studio albums for each artist.
However, you can expand the album types per an artist, or for your
entire library by utilizing [Metadata
Profiles](Lidarr_Settings#Metadata_Profiles "wikilink").

Why can\'t I add a various artists album?
-----------------------------------------

<span id="why_cant_i_add_a_various_artists_album"><small>[anchor](#why_cant_i_add_a_various_artists_album "wikilink")</small></span>\
Various Artists and other meta artists on Musicbrainz are due to the
number of entries they provide.

Can I add just an album?
------------------------

<span id="can_i_add_just_an_album"><small>[anchor](#an_i_add_just_an_album "wikilink")</small></span>\
Not at the moment.

Can I download single tracks?
-----------------------------

<span id="can_i_download_single_tracks"><small>[anchor](#can_i_download_single_tracks "wikilink")</small></span>\
Lidarr works by searching for and downloading full releases, therefore
individual tracks cannot be downloaded unless they were released as a
single by the artist.

Why doesn\'t artist X show up in search?
----------------------------------------

<span id="why_doesnt_artist_x_show_up_in_search"><small>[anchor](#why_doesnt_artist_x_show_up_in_search "wikilink")</small></span>\
Search is still a work in progress. Artists that don\'t show up in
search may be added by searching for \`lidarr:mbid\` where \`mbid\` is
the Musicbrainz ID of the artist.

Lidarr matched an album with too many tracks. How can I change the Album to the correct Release?
------------------------------------------------------------------------------------------------

<span id="lidarr_matched_an_album_with_too_many_tracks_how_can_i_change_thealbum_to_the_correct_release"><small>[anchor](#lidarr_matched_an_album_with_too_many_tracks_how_can_i_change_thealbum_to_the_correct_release "wikilink")</small></span>\
Open the Album details page and select the Edit Icon in the top nav.
There you can find a dropdown of all releases tied to that Album.

I\'m having trouble importing my artists, what could it be?
-----------------------------------------------------------

<span id="im_having_trouble_importing_my_artists_what_could_it_be"><small>[anchor](#im_having_trouble_importing_my_artists_what_could_it_be "wikilink")</small></span>\
The artist import process just imports the Artist names and path
locations, which are then stored in the database so that a) metadata can
be retrieved and b) downloaded content can be put in the same location
in future. To this end, the user account that Lidarr runs under needs
both read and write to your data directory.

I can\'t find a release in Lidarr but it is on MusicBrainz
----------------------------------------------------------

<span id="cant_find_release_lidarr_on_mb"><small>[anchor](#cant_find_release_lidarr_on_mb "wikilink")</small></span>\
This is likely due to the release having an `unknown` release status.
Update MusicBrainz.

How often do Lidarr\'s and MusicBrainz databases sync?
------------------------------------------------------

<span id="lidarr_mb_db_sync"><small>[anchor](#lidarr_mb_db_sync "wikilink")</small></span>\
Every hour at 5 after the hour

How can I add missing artist images?
------------------------------------

<span id="missing_artist_images"><small>[anchor](#missing_artist_images "wikilink")</small></span>\
Add art to fanart.tv and wait \~7+ days for it to clear through the
cache. Then refresh the metadata.

How can I get missing album images? (Cover Art)
-----------------------------------------------

<span id="missing_album_images"><small>[anchor](#missing_album_images "wikilink")</small></span>\
Add coverart to musicbrainz and wait \~1hr+ for it to clear through the
cache. Then refresh the metadata.

I\'m having trouble importing my artists, what could it be?
-----------------------------------------------------------

<span id="im_having_trouble_importing_my_artists_what_could_it_be"><small>[anchor](#im_having_trouble_importing_my_artists_what_could_it_be "wikilink")</small></span>\
The artist import process just imports the Artist names and path
locations, which are then stored in the database so that a) metadata can
be retrieved and b) downloaded content can be put in the same location
in future. To this end, the user account that Lidarr runs under needs
both read and write to your data directory.
