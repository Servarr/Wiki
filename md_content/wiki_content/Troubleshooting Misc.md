***This page is used for the misc items needed for the specificity of each of the ARRs that do not cross between them***

## Testing a search

### Radarr

<section begin=radarr_indexers_and_trackers_testing_a_search />

Just like the indexer/tracker test above, when you trigger a search while at Debug or Trace level logging, you can get the URL used from the log files. While testing, it is best to use as narrow a search as possible. A manual search is good because it is specific *and* you can see the results in the UI while examining the logs.

In this test, you’ll be looking for obvious errors and running some simple tests. You can see the search used the url `"`<https://api.nzbgeek.info/api?t=movie&cat=2000&apikey=(removed)&q=O+Brother+Where+Art+Thou>, which you can try yourself in a browser after replacing `(removed)` with your apikey for that indexer. Does it work? Do you see the expected results? In that URL, you can see that it set specific categories with `2000`, so if you’re not seeing expected results, this is one likely reason. If the movie isn’t properly categorized on the indexer, it will need to be fixed. Look at Manual Search XML Output below to see an example of a working query’s output. {{\#spoiler:show=Manual Search XML Output|hide=Click here to Close|

    coming soon

<section end=radarr_indexers_and_trackers_testing_a_search />

### Sonarr

<section begin=sonarr_indexers_and_trackers_testing_a_search />

Just like the indexer/tracker test above, when you trigger a search while at Debug or Trace level logging, you can get the URL used from the log files. While testing, it is best to use as narrow a search as possible. A manual search is good because it is specific *and* you can see the results in the UI while examining the logs.

In this test, you’ll be looking for obvious errors and running some simple tests. You can see the search used the url <https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1>, which you can try yourself in a browser after replacing `(removed)` with your apikey for that indexer. Does it work? Do you see the expected results? [Does this FAQ entry apply?](Sonarr_FAQ#why_cant_sonarr_import_episode_files_for_series_x_why_cant_sonarr_find_releases_for_series_x "wikilink") In that URL, you can see that it set specific categories with `cat=5030,5040,5045,5080`, so if you’re not seeing expected results, this is one likely reason. You can also see that it searched by tvdbid with `tvdbid=354629`, so if the episode isn’t properly categorized on the indexer, it will need to be fixed. You can also see that it searches by *specific* season and episode with `season=1` and `ep=1`, so if *that* isn’t correct on the indexer, you won’t see those results. Look at Manual Search XML Output below to see an example of a working query’s output. {{\#spoiler:show=Manual Episode XML Output|hide=Click here to Close|

    <rss xmlns:atom="http://www.w3.org/2005/Atom" xmlns:newznab="http://www.newznab.com/DTD/2010/feeds/attributes/" version="2.0">
    <channel>
    <atom:link href="https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1" rel="self" type="application/rss+xml"/>
    <title>api.nzbgeek.info</title>
    <description>NZBgeek API</description>
    <link>http://api.nzbgeek.info/</link>
    <language>en-gb</language>
    <webMaster>info@nzbgeek.info (NZBgeek)</webMaster>
    <category/>
    <image>
    <url>https://api.nzbgeek.info/covers/nzbgeek.png</url>
    <title>api.nzbgeek.info</title>
    <link>http://api.nzbgeek.info/</link>
    <description>NZBgeek</description>
    </image>
    <newznab:response offset="0" total="2"/>
    <item>
    <title>The.Fix.S01E01.1080p.AMZN.WEB-DL</title>
    <guid isPermaLink="true">
    https://api.nzbgeek.info/details/358e0f946f953771c7688864b0334ba1
    </guid>
    <link>
    https://api.nzbgeek.info/api?t=get&id=358e0f946f953771c7688864b0334ba1&apikey=(removed)
    </link>
    <comments>
    https://nzbgeek.info/geekseek.php?guid=358e0f946f953771c7688864b0334ba1
    </comments>
    <pubDate>Wed, 20 Mar 2019 05:03:32 +0000</pubDate>
    <category>TV > HD</category>
    <description>The.Fix.S01E01.1080p.AMZN.WEB-DL</description>
    <enclosure url="https://api.nzbgeek.info/api?t=get&id=358e0f946f953771c7688864b0334ba1&apikey=(removed)" length="3810861000" type="application/x-nzb"/>
    <newznab:attr name="category" value="5000"/>
    <newznab:attr name="category" value="5040"/>
    <newznab:attr name="size" value="3810861000"/>
    <newznab:attr name="guid" value="358e0f946f953771c7688864b0334ba1"/>
    <newznab:attr name="tvdbid" value="354629"/>
    <newznab:attr name="season" value="S01"/>
    <newznab:attr name="episode" value="E01"/>
    <newznab:attr name="tvairdate" value="2019-03-18T00:00:00Z"/>
    <newznab:attr name="grabs" value="55"/>
    <newznab:attr name="usenetdate" value="Wed, 20 Mar 2019 04:54:15 +0000"/>
    </item>
    <item>
    <title>The.Fix.S01E01.720p.AMZN.WEB-DL</title>
    <guid isPermaLink="true">
    https://api.nzbgeek.info/details/f7e4ac2875b6a1ce45bae91ab19e9699
    </guid>
    <link>
    https://api.nzbgeek.info/api?t=get&id=f7e4ac2875b6a1ce45bae91ab19e9699&apikey=(removed)
    </link>
    <comments>
    https://nzbgeek.info/geekseek.php?guid=f7e4ac2875b6a1ce45bae91ab19e9699
    </comments>
    <pubDate>Wed, 20 Mar 2019 05:03:33 +0000</pubDate>
    <category>TV > HD</category>
    <description>The.Fix.S01E01.720p.AMZN.WEB-DL</description>
    <enclosure url="https://api.nzbgeek.info/api?t=get&id=f7e4ac2875b6a1ce45bae91ab19e9699&apikey=(removed)" length="1195794000" type="application/x-nzb"/>
    <newznab:attr name="category" value="5000"/>
    <newznab:attr name="category" value="5040"/>
    <newznab:attr name="size" value="1195794000"/>
    <newznab:attr name="guid" value="f7e4ac2875b6a1ce45bae91ab19e9699"/>
    <newznab:attr name="tvdbid" value="354629"/>
    <newznab:attr name="season" value="S01"/>
    <newznab:attr name="episode" value="E01"/>
    <newznab:attr name="tvairdate" value="2019-03-18T00:00:00Z"/>
    <newznab:attr name="grabs" value="14"/>
    <newznab:attr name="usenetdate" value="Wed, 20 Mar 2019 04:51:45 +0000"/>
    </item>
    </channel>
    </rss>

}}

<section end=sonarr_indexers_and_trackers_testing_a_search />

### Lidarr

<section begin=lidarr_indexers_and_trackers_testing_a_search />

Coming Soon(tm)

<section end=lidarr_indexers_and_trackers_testing_a_search />

### Readarr

<section begin=readarr_indexers_and_trackers_testing_a_search />

Coming Soon(tm)

<section ned=readarr_indexers_and_trackers_testing_a_search />

## Type

### Radarr

<section begin=radarr_indexers_and_trackers_type />

<section end=radarr_indexers_and_trackers_type />

### Sonarr

<section begin=sonarr_indexers_and_trackers_type />

#### Wrong Show Type or Unknown Series

##### Unknown Series

This occurs due to one of two issues: either the series you are searching and Sonarr has found results for does not exist within Sonarr or more likely a scene (or xem) mapping is required. [Please see this FAQ entry for details.](Sonarr_FAQ#why_cant_sonarr_import_episode_files_for_series_x_why_cant_sonarr_find_releases_for_series_x "wikilink")

##### Wrong Show Type

The show type is another cause of poor search results. Most shows should be `Standard`. For daily shows which are typically released with a date, `Daily` should be used. Finally, there is anime where using `Anime` is *usually* right, but sometimes `Standard` can work better, so try the *other* one if you’re having issues.

Please note that if the series type is set to anime and none of your enabled indexers have any anime categories configured then it effectively skips the indexer and may appear that it is not searching.

##### Show Type Examples

Below are some example release names for each show type. The specific differentiating piece is noted in bold.

**Daily**

  - Some.Daily.Show.**2021.03.04**.1080p.HDTV.x264-DARKSPORT
  - A.Daily.Show.with.Some.Guy.**2021.03.03**.1080p.CC.WEB-DL.AAC2.0.x264-null
  - DailyShow.**2021.03.08**.720p.HDTV.x264-NTb

**Standard**

  - The.Show.**S20E03**.Episode.Title.Part.3.1080p.HULU.WEB-DL.DDP5.1.H.264-NTb
  - Another.Show.**S03E08**.1080p.WEB.H264-GGEZ
  - GreatShow.**S17E02**.1080p.HDTV.x264-DARKFLiX

**Anime**

  - Anime.Origins.**E04**.File.4\_.Monkey.WEB-DL.H.264.1080p.AAC2.0.AC3.5.1.Srt.EngCC-Pikanet128.1272903A
  - \[Coalgirls\] Human X Monkey **148** (1920x1080 Blu-ray FLAC) \[63B8AC67\]
  - \[KaiDubs\] Series x Title (2011) - **142** \[1080p\] \[English Dub\] \[CC\] \[AS-DL\] \[A24AB2E5\]

<section end=sonarr_indexers_and_trackers_type />

### Lidarr

<section begin=lidarr_indexers_and_trackers_type />

<section end=lidarr_indexers_and_trackers_type />

### Readarr

<section begin=lidarr_indexers_and_trackers_type />

<section end=lidarr_indexers_and_trackers_type />

## Code Blocks

### Radarr

#### Code Block 1

<section begin=radarr_indexers_and_trackers_code_block />

Need to add logs of feed downloaded and parsed (rss)

<section end=radarr_indexers_and_trackers_code_block />

#### Code Block 2

<section begin=radarr_indexers_and_trackers_code_block2 />

Need to add logs of feed downloaded and parsed (search)

<section end=radarr_indexers_and_trackers_code_block2 />

### Sonarr

#### Code Block 1

<section begin=sonarr_indexers_and_trackers_code_block />

    19-11-12 13:27:28.8|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&amp;cat=5030,5040,5045,5080,5070&amp;extended=1&amp;apikey=(removed)&amp;offset=0&amp;limit=100
    19-11-12 13:27:28.8|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&amp;cat=5030,5040,5045,5080,5070&amp;extended=1&amp;apikey=(removed)&amp;offset=0&amp;limit=100
    19-11-12 13:27:28.8|Trace|ConfigService|Using default config value for 'proxyenabled' defaultValue:'False'
    19-11-12 13:27:29.9|Trace|HttpClient|Res: [GET] https://api.nzbgeek.info/api?t=tvsearch&amp;cat=5030,5040,5045,5080,5070&amp;extended=1&amp;apikey=(removed)&amp;offset=0&amp;limit=100: 200.OK (1093 ms)
    19-11-12 13:27:30.0|Trace|NewznabRssParser|Parsed: Shetland.S04E06.1080p.AMZN.WEB-DL.DDP2.0.H.264.1-Cinefeel-Obfuscated
    ...
    19-11-12 13:27:30.0|Trace|NewznabRssParser|Parsed: James.Corden.2019.11.11.Kate.Beckinsale.1080p.WEB.x264.1-TBS-Obfuscated
    19-11-12 13:27:30.0|Trace|NewznabRssParser|Parsed: [BakedFish] Black Clover (2017) - 109 [720p][AAC]
    19-11-12 13:27:30.0|Trace|Http|Res: 108939 [POST] /api/v3/indexer/test: 200.OK (1404 ms)
    19-11-12 13:27:30.0|Debug|Api|[POST] /api/v3/indexer/test: 200.OK (1404 ms)

<section end=sonarr_indexers_and_trackers_code_block />

#### Code Block 2

<section begin=sonarr_indexers_and_trackers_code_block2 />

    19-11-20 13:15:23.6|Info|NzbSearchService|Searching 1 indexers for [The Fix : S01E01]
    19-11-20 13:15:23.6|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&amp;cat=5030,5040,5045,5080&amp;extended=1&amp;apikey=(removed)&amp;offset=0&amp;limit=100&amp;tvdbid=354629&amp;season=1&amp;ep=1
    19-11-20 13:15:23.6|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&amp;cat=5030,5040,5045,5080&amp;extended=1&amp;apikey=(removed)&amp;offset=0&amp;limit=100&amp;tvdbid=354629&amp;season=1&amp;ep=1

<section end=sonarr_indexers_and_trackers_code_block2 />

### Lidarr

#### Code Block 1

<section begin=lidarr_indexers_and_trackers_code_block />

Need to add logs of feed downloaded and parsed (rss)

<section end=lidarr_indexers_and_trackers_code_block />

#### Code Block 2

<section begin=lidarr_indexers_and_trackers_code_block2 />

Need to add logs of feed downloaded and parsed (search)

<section end=lidarr_indexers_and_trackers_code_block2 />

### Readarr

#### Code Block 1

<section begin=readarr_indexers_and_trackers_code_block />

Need to add logs of feed downloaded and parsed (rss)

<section end=readarr_indexers_and_trackers_code_block />

#### Code Block 2

<section begin=readarr_indexers_and_trackers_code_block2 />

Need to add logs of feed downloaded and parsed (search)

<section end=readarr_indexers_and_trackers_code_block2 />

### Trace Logs Example

#### Radarr

<section begin=radarr_trace_logs_example />

{{\#spoiler:show=Manual Search Trace Log|hide=Click here to Close|

    Needs Trace Log Example

}}

<section end=radarr_trace_logs_example />

#### Sonarr

<section begin=sonarr_trace_logs_example />

{{\#spoiler:show=Manual Search Trace Log|hide=Click here to Close|

    19-11-20 13:15:23.6|Trace|Http|Req: 66 [GET] /api/v3/release?episodeId=1                                                                                                                                                                                                                         [5/3289]
    19-11-20 13:15:23.6|Info|NzbSearchService|Searching 1 indexers for [The Fix : S01E01]
    19-11-20 13:15:23.6|Debug|Newznab|Downloading Feed https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
    19-11-20 13:15:23.6|Trace|HttpClient|Req: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1
    19-11-20 13:15:23.6|Trace|ConfigService|Using default config value for 'proxyenabled' defaultValue:'False'
    19-11-20 13:15:24.3|Trace|HttpClient|Res: [GET] https://api.nzbgeek.info/api?t=tvsearch&cat=5030,5040,5045,5080&extended=1&apikey=(removed)&offset=0&limit=100&tvdbid=354629&season=1&ep=1: 200.OK (680 ms)
    19-11-20 13:15:24.3|Trace|NewznabRssParser|Parsed: The.Fix.S01E01.1080p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Trace|NewznabRssParser|Parsed: The.Fix.S01E01.720p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|NzbSearchService|Total of 2 reports were found for [The Fix : S01E01] from 1 indexers
    19-11-20 13:15:24.3|Debug|NzbSearchService|Setting last search time to: 11/20/2019 13:15:24
    19-11-20 13:15:24.3|Info|DownloadDecisionMaker|Processing 2 releases
    19-11-20 13:15:24.3|Trace|DownloadDecisionMaker|Processing release 1/2
    19-11-20 13:15:24.3|Debug|DownloadDecisionMaker|Processing release 'The.Fix.S01E01.1080p.AMZN.WEB-DL' from 'NZBgeek'
    19-11-20 13:15:24.3|Debug|Parser|Parsing string 'The.Fix.S01E01.1080p.AMZN.WEB-DL'
    19-11-20 13:15:24.3|Trace|Parser|^(?<title>.+?)(?:(?:[-_\W](?<![()\[!]))+S?(?<season>(?<!\d+)(?:\d{1,2})(?!\d+))(?:[ex]|\W[ex]){1,2}(?<episode>\d{2,3}(?!\d+))(?:(?:\-|[ex]|\W[ex]|_){1,2}(?<episode>\d{2,3}(?!\d+)))*)\W?(?!\\)
    19-11-20 13:15:24.3|Debug|Parser|Episode Parsed. The Fix - S01E01
    19-11-20 13:15:24.3|Debug|Parser|Language parsed: English
    19-11-20 13:15:24.3|Debug|QualityParser|Trying to parse quality for The.Fix.S01E01.1080p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|Parser|Quality parsed: WEBDL-1080p v1
    19-11-20 13:15:24.3|Debug|Parser|Release Group parsed:
    19-11-20 13:15:24.3|Trace|PreferredWordService|Calculating preferred word score for 'The.Fix.S01E01.1080p.AMZN.WEB-DL'
    19-11-20 13:15:24.3|Trace|PreferredWordService|Calculated preferred word score for 'The.Fix.S01E01.1080p.AMZN.WEB-DL': 0
    19-11-20 13:15:24.3|Debug|AcceptableSizeSpecification|Beginning size check for: The.Fix.S01E01.1080p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|AcceptableSizeSpecification|Possible double episode, doubling allowed size.
    19-11-20 13:15:24.3|Debug|AcceptableSizeSpecification|Item: The.Fix.S01E01.1080p.AMZN.WEB-DL, meets size constraints.
    19-11-20 13:15:24.3|Debug|AlreadyImportedSpecification|Performing already imported check on report
    19-11-20 13:15:24.3|Debug|AlreadyImportedSpecification|Skipping already imported check for episode without file
    19-11-20 13:15:24.3|Debug|LanguageSpecification|Checking if report meets language requirements. English
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'maximumsize' defaultValue:'0'
    19-11-20 13:15:24.3|Debug|MaximumSizeSpecification|Maximum size is not set.
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'minimumage' defaultValue:'0'
    19-11-20 13:15:24.3|Debug|MinimumAgeSpecification|Minimum age is not set.
    19-11-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Checking if report meets quality requirements. WEBDL-1080p v1
    19-11-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Quality WEBDL-1080p v1 rejected by Series' quality profile
    19-11-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|Checking if release meets restrictions: The.Fix.S01E01.1080p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|[The.Fix.S01E01.1080p.AMZN.WEB-DL] No restrictions apply, allowing
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'retention' defaultValue:'0'
    19-11-20 13:15:24.3|Debug|RetentionSpecification|Checking if report meets retention requirements. 245
    19-11-20 13:15:24.3|Debug|SeriesSpecification|Checking if series matches searched series
    19-11-20 13:15:24.3|Debug|DelaySpecification|Ignoring delay for user invoked search
    19-11-20 13:15:24.3|Debug|HistorySpecification|Skipping history check during search
    19-11-20 13:15:24.3|Debug|MonitoredEpisodeSpecification|Skipping monitored check during search
    19-11-20 13:15:24.3|Debug|DownloadDecisionMaker|Release rejected for the following reasons: [Permanent] WEBDL-1080p is not wanted in profile
    19-11-20 13:15:24.3|Trace|DownloadDecisionMaker|Processing release 2/2
    19-11-20 13:15:24.3|Debug|DownloadDecisionMaker|Processing release 'The.Fix.S01E01.720p.AMZN.WEB-DL' from 'NZBgeek'
    19-11-20 13:15:24.3|Debug|Parser|Parsing string 'The.Fix.S01E01.720p.AMZN.WEB-DL'
    19-11-20 13:15:24.3|Trace|Parser|^(?<title>.+?)(?:(?:[-_\W](?<![()\[!]))+S?(?<season>(?<!\d+)(?:\d{1,2})(?!\d+))(?:[ex]|\W[ex]){1,2}(?<episode>\d{2,3}(?!\d+))(?:(?:\-|[ex]|\W[ex]|_){1,2}(?<episode>\d{2,3}(?!\d+)))*)\W?(?!\\)
    19-11-20 13:15:24.3|Debug|Parser|Episode Parsed. The Fix - S01E01
    19-11-20 13:15:24.3|Debug|Parser|Language parsed: English
    19-11-20 13:15:24.3|Debug|QualityParser|Trying to parse quality for The.Fix.S01E01.720p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|Parser|Quality parsed: WEBDL-720p v1
    19-11-20 13:15:24.3|Debug|Parser|Release Group parsed:
    19-11-20 13:15:24.3|Trace|PreferredWordService|Calculating preferred word score for 'The.Fix.S01E01.720p.AMZN.WEB-DL'
    19-11-20 13:15:24.3|Trace|PreferredWordService|Calculated preferred word score for 'The.Fix.S01E01.720p.AMZN.WEB-DL': 0
    19-11-20 13:15:24.3|Debug|AcceptableSizeSpecification|Beginning size check for: The.Fix.S01E01.720p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|AcceptableSizeSpecification|Possible double episode, doubling allowed size.
    19-11-20 13:15:24.3|Debug|AcceptableSizeSpecification|Item: The.Fix.S01E01.720p.AMZN.WEB-DL, meets size constraints.
    19-11-20 13:15:24.3|Debug|AlreadyImportedSpecification|Performing already imported check on report
    19-11-20 13:15:24.3|Debug|AlreadyImportedSpecification|Skipping already imported check for episode without file
    19-11-20 13:15:24.3|Debug|LanguageSpecification|Checking if report meets language requirements. English
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'maximumsize' defaultValue:'0'
    19-11-20 13:15:24.3|Debug|MaximumSizeSpecification|Maximum size is not set.
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'minimumage' defaultValue:'0'
    19-11-20 13:15:24.3|Debug|MinimumAgeSpecification|Minimum age is not set.
    19-11-20 13:15:24.3|Debug|QualityAllowedByProfileSpecification|Checking if report meets quality requirements. WEBDL-720p v1
    19-11-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|Checking if release meets restrictions: The.Fix.S01E01.720p.AMZN.WEB-DL
    19-11-20 13:15:24.3|Debug|ReleaseRestrictionsSpecification|[The.Fix.S01E01.720p.AMZN.WEB-DL] No restrictions apply, allowing
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'retention' defaultValue:'0'
    19-11-20 13:15:24.3|Debug|RetentionSpecification|Checking if report meets retention requirements. 245
    19-11-20 13:15:24.3|Debug|SeriesSpecification|Checking if series matches searched series
    19-11-20 13:15:24.3|Debug|DelaySpecification|Ignoring delay for user invoked search
    19-11-20 13:15:24.3|Debug|HistorySpecification|Skipping history check during search
    19-11-20 13:15:24.3|Debug|MonitoredEpisodeSpecification|Skipping monitored check during search
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'autounmonitorpreviouslydownloadedepisodes' defaultValue:'False'
    19-11-20 13:15:24.3|Debug|DownloadDecisionMaker|Release accepted
    19-11-20 13:15:24.3|Trace|ConfigService|Using default config value for 'downloadpropersandrepacks' defaultValue:'PreferAndUpgrade'
    19-11-20 13:15:24.3|Trace|Http|Res: 66 [GET] /api/v3/release?episodeId=1: 200.OK (775 ms)
    19-11-20 13:15:24.3|Debug|Api|[GET] /api/v3/release?episodeId=1: 200.OK (775 ms)

}}

<section end=sonarr_trace_logs_example />

#### Lidarr

<section begin=lidarr_trace_logs_example />

{{\#spoiler:show=Manual Search Trace Log|hide=Click here to Close|

    Needs Trace Log Example

}}

<section end=lidarr_trace_logs_example />

#### Readarr

<section begin=readarr_trace_logs_example />

{{\#spoiler:show=Manual Search Trace Log|hide=Click here to Close|

    Needs Trace Log Example

}}

<section end=readarr_trace_logs_example />
