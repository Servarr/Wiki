<noinclude> <templatedata> {

`   "params": {`  
`       "ARRNAME": {`  
`           "description": "ARR Name",`  
`           "type": "string",`  
`           "required": true,`  
`           "example": "Radarr, Sonarr, Lidarr, Readarr"`  
`       },`  
`       "MEDIA": {`  
`           "example": "Movie, Episode, Track, Book",`  
`           "type": "string",`  
`           "required": true,`  
`           "description": "List of possible MEDIA variables"`  
`       },`  
`       "QUALITY1": {`  
`           "example": "HDTV 720p, MP3-320, PDF",`  
`           "type": "string",`  
`           "required": true,`  
`           "description": "List of possible qualities that should be used for this template (`` and above are allowed `` is the quality cutoff * `` is the highest ranked quality)"`  
`       },`  
`       "QUALITY2": {`  
`           "example": "WebDL 720p , OGG Vorbis Q7, MOBI",`  
`           "type": "string",`  
`           "required": true,`  
`           "description": "List of possible qualities that should be used for this template (`` and above are allowed `` is the quality cutoff * `` is the highest ranked quality)"`  
`       },`  
`       "QUALITY3": {`  
`           "example": "WebDL 1080p, FLAC, EPUB",`  
`           "type": "string",`  
`           "required": true,`  
`           "description": " List of possible qualities that should be used for this template (`` and above are allowed `` is the quality cutoff * `` is the highest ranked quality)"`  
`       }`  
`   },`  
`   "description": "Template for Delay Profiles"`

} </templatedata> </noinclude>

  - Delay profiles allow you to reduce the number of releases that will
    be downloaded for an , by adding a delay while  will continue to
    watch for releases that better match your preferences.
      - Protocol - This will either be Usenet or Torrent depending on
        which download protocol you're using
      - Usenet Delay - Set by the number of minutes you'll want to wait
        before the download to start
      - Torrent Delay - Set by the number of minutes you'll want to wait
        before the download to start
      - Bypass if Highest Quality - Bypass the delay profile if the
        highest quality for that  is found and grab once the first
        instance of the highest ranked quality is found. Otherwise wait
        for the best quality release until the end of the delay period.
      - Tags - This is where you'll select any relevant
        [tags](#Tags "wikilink") that you'll be using for this scheme
  - Wrench icon - This will allow you to edit the delay profile
  - Plus icon - Create a new profile

**Example:** Some media will receive half a dozen different releases of
varying quality in the hours after a release, and without delay profiles
 might try to download all of them. With delay profiles,  can be
configured to ignore the first few hours of releases.

Delay profiles are also helpful if you want to emphasize one protocol
(Usenet or BitTorrent) over the other. (See Example 3)

How Delay Profiles Work

The timer begins as soon as  detects an  has a release available. This
release will show up in your Queue with a clock icon to indicate that it
is under a delay. Please note that the clock starts from the releases
uploaded time and not from the time  sees it.

During the delay period, any new releases that become available will be
noted by . When the delay timer expires,  will download the single
release which best matches your quality preferences.

The timer period can be different for Usenet and Torrents. Each profile
can be associated with one or more tags to allow you to customize which
shows have which profiles. A delay profile with no tag is considered the
default and applies to all shows that do not have a specific tag.

**NOTE:** Delay profiles start from the timestamp that the indexer
reports the release was uploaded. This means that any content older than
the number of minutes you have set are not impacted in any way by your
delay profile, and will be downloaded immediately. In addition, any
manual searches for content (non-RSS feed searches) will ignore delay
profile settings.

**Examples**

For each example, assume the user has the follow quality profile active:
 and above are allowed  is the quality cutoff \*  is the highest ranked
quality

**Example 1:**

In this simple example, the profile is set with a 120 minute (two hour)
delay for both Usenet and Torrent.

At `11:00pm` the first release for an  is detected by  and it was
uploaded at 10:50pm and the 120 minute clock begins. At `12:50am`,  will
evaluate any releases it has found in the past two hours, and download
the best one, which is .

At `3:00am` another release is found, which is  that was added to your
indexer at 2:46am. Another 120 minute clock begins. At `4:46am` the
best-available release is downloaded. Since the quality cutoff is now
reached, the  no longer is upgradable and  will stop looking for new
releases.

At any point, if a  release is found, it will be downloaded immediately
because it is the highest-ranking quality. If there is a delay timer
currently active it will be cancelled.

**Example 2:**

This example has different timers for Usenet and Torrents. Assume a 120
minute timer for Usenet and a 180 minute timer for BitTorrent.

At `11:00pm` the first release for an  is detected by  and both timers
begin. The release was added to the indexer at 10:15pm At `12:15am`, 
will evaluate any releases, and if there are any acceptable Usenet
releases, the best one will be downloaded and both timers will end. If
not,  will wait until `12:15am` and download the best release,
regardless of which source it came from.

**Example 3:**

A common use for delay profiles is to emphasize one protocol over
another. For example, you might only want to download a BitTorrent
release if nothing has been uploaded to Usenet after a certain amount of
time.

You could set a 60 minute timer for BitTorrent, and a 0 minute timer for
Usenet.

If the first release that is detected is from Usenet,  will download it
immediately.

If the first release is from BitTorrent,  will set a 60 minute timer. If
any qualifying Usenet release is detected during that timer, the
BitTorrent release will be ignored and the Usenet release will be
grabbed.
