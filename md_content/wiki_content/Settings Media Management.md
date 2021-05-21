## Naming

### Radarr

<section begin=radarr_movie_naming />

Commonly used naming schema are:

  - Standard Movie Format

`{Movie Title} {(Release Year)} {Edition Tags} {[Quality Full]}
{[MediaInfo 3D]} {[MediaInfo VideoDynamicRange]} [{MediaInfo
VideoBitDepth}bit] {[MediaInfo VideoCodec]} {[MediaInfo
AudioCodec}-{MediaInfo AudioChannels]}{MediaInfo
AudioLanguages}{-Release Group} `

which would then output: `The Movie Title! (2010) Ultimate Extended
Edition [Bluray-1080p Proper] [3D] [HDR] [10bit] [x264]
[DTS-5.1][DE]-EVOLVE`. This allows critical data such as the group and
Quality (source) to be maintained within the file name in case of
database loss or corruption

  - Movie Folder Format

`{Movie Title} ({Release Year}) {tmdb-{tmdbid}} {imdb-{imdbid}}` which
would then output: `The Movie Title! (2010) {tmdb-345691}
{imdb-tt0066921}`

  - Rename Movies - If this is toggled off (no check in the box) Radarr
    will use the existing file name if renaming is disabled
  - Replace Illegal Characters - If this is toggled off (no check in the
    box) Radarr will replace illegal characters.

<!-- end list -->

  -   
    Example: `\` `#` `/` `$` `*` `<` `>` just to name a few

<!-- end list -->

  - Colon (`:`) Replacement - This setting will dictate how Radarr
    handles colons within the movie file.  
    ''This is only available when Replace Illegal Characters is toggled
    on (check in the box)
      - Delete - Self explanatory
          - Example: Movie,The.mkv -\> MovieThe.mkv
      - Replace with Dash - Removes the colon and adds a dash in its
        place
          - Example: Movie,The.mkv -\> Movie-The.mkv
      - Replace with Space - Removes the colon and adds a space in its
        place
          - Example: Movie,The.mkv -\> Movie The.mkv
      - Replace with Space Dash Space - self explanatory
          - Example: Movie,The.mkv -\> Movie - The.mkv

##### Standard Movie Format

Here you will select the naming convention for the actual movie files

  - Dropdown Box (upper right corner)
      - Left Box - Space Handling
          - Space ( ) - Use spaces in naming (Default)
          - Period (`.`) - Use periods in lieu of spaces in naming
          - Underscore (`_`) - Use underscores in lieu of spaces in
            naming
          - Dash (`-`) - Use dashes in lieu of spaces in naming
      - Right Box - Case Handling
          - Default Case - Make title uppercase and lowercase
            (\~camelcase) (Default)
          - Uppercase - Make title all Uppercase
          - Lowercase - Make title all Lowercase

###### Movie Naming

| Input                       | Result               |
| --------------------------- | -------------------- |
| {Movie Title}               | Movie Name\!         |
| {Movie Title:DE}            | FileTitle            |
| {Movie CleanTitle}          | Movie Name           |
| {Movie TitleThe}            | Movie Name, The      |
| {Movie OriginalTitle}       | Τίτλος ταινίας       |
| {Movie TitleFirstCharacter} | M                    |
| {Movie Collection}          | The Movie Collection |
| {Movie Certification}       | PG-13                |
| {Release Year}              | 2020                 |

###### Movie IDs

| Input    | Result  |
| -------- | ------- |
| {ImdbId} | tt12345 |
| {Tmdbid} | 123456  |

###### Quality (Naming)

| Input           | Result           |
| --------------- | ---------------- |
| {Quality Full}  | HDTV 720p Proper |
| {Quality Title} | HDTV 720p        |

###### Media Info

| Input                         | Result             |
| ----------------------------- | ------------------ |
| {MediaInfo Simple}            | x264 DTS           |
| {MediaInfo Full}              | x264 DTS \[EN+DE\] |
| {MediaInfo VideoCodec}        | x264               |
| {MediaInfo AudioCodec}        | DTS                |
| {MediaInfo AudioChannels}     | 5.1                |
| {MediaInfo AudioLanguages}    | \[EN+DE\]          |
| {MediaInfo SubtitleLanguages} | \[EN\]             |
| {MediaInfo VideoCodec}        | x264               |
| {MediaInfo VideoBitDepth}     | 8                  |
| {MediaInfo VideoDynamicRange} | HDR                |

###### Release Group

| Input           | Result    |
| --------------- | --------- |
| {Release Group} | Rls Group |

###### Edition

| Input          | Result |
| -------------- | ------ |
| {Edition Tags} | IMAX   |

###### Custom Formats

| Input            | Result              |
| ---------------- | ------------------- |
| {Custom Formats} | Surround Sound x264 |

###### Original

| Input               | Result                       |
| ------------------- | ---------------------------- |
| {Original Title}    | Movie.Title.HDTV.x264.EVOLVE |
| {Original Filename} | Movie.title.hdtv.x264.EVOLVE |

  - Original Filename is not recommended. It is the literal original
    filename and may be obfuscated `t1i0p3s7i8yuti`.
  - Original Title is the release name is is what is suggested to be
    used.

##### *Standard Movie Folder Format*

This is where you will set the naming convention for the folder that
contains the video file.

###### Movie Naming

| Input                       | Result               |
| --------------------------- | -------------------- |
| {Movie Title}               | Movie Name\!         |
| {Movie Title:DE}            | Filetitle            |
| {Movie CleanTitle}          | Movie Name           |
| {Movie TitleThe}            | Movie Name, The      |
| {Movie OriginalTitle}       | Τίτλος ταινίας       |
| {Movie TitleFirstCharacter} | M                    |
| {Movie Collection}          | The Movie Collection |
| {Movie Certification}       | PG-13                |
| {Release Year}              | 2020                 |

###### Movie IDs

| Input    | Result  |
| -------- | ------- |
| {ImdbId} | tt12345 |
| {Tmdbid} | 123456  |

<section end="radarr_movie_naming" />

### Sonarr

<section begin="sonarr_episode_naming" />

  - Rename Episodes - If this is toggled off (no check in the box)
    Sonarr will use the existing file name if renaming is disabled
  - Replace Illegal Characters - If this is toggled off (no check in the
    box) Sonarr will replace illegal characters.

<!-- end list -->

  -   
    Example: `\` `#` `/` `$` `*` `<` `>` just to name a few

##### Standard Episode Format

Here you will select the naming convention for your episodes

  - Dropdown Box (upper right corner)
      - Left Box - Space Handling
          - Space ( ) - Use spaces in naming (Default)
          - Period (`.`) - Use periods in lieu of spaces in naming
          - Underscore (`_`) - Use underscores in lieu of spaces in
            naming
          - Dash (`-`) - Use dashes in lieu of spaces in naming
      - Right Box - Case Handling
          - Default Case - Make title uppercase and lowercase
            (\~camelcase) (Default)
          - Uppercase - Make title all uppercase
          - Lowercase - Make title all lowercase

###### Series Naming

| Input                        | Result              |
| ---------------------------- | ------------------- |
| {Series Title}               | Series Name\!       |
| {Series CleanTitleYear}      | Series Title 2010   |
| {Series TitleFirstCharacter} | S                   |
| {Series CleanTitle}          | Series Title        |
| {Series TitleThe}            | Series Title, The   |
| {Series TitleYear}           | Series Title (2010) |
| {Series Year}                | (2010)              |

###### Series IDs

| Input      | Result  |
| ---------- | ------- |
| {ImdbId}   | tt12345 |
| {Tmdbid}   | 123456  |
| {TvMazeId} | 54321   |

###### Seasons

| Input       | Result |
| ----------- | ------ |
| {season:0}  | 1      |
| {season:00} | 01     |

###### Episode

| Input        | Result |
| ------------ | ------ |
| {episode:0}  | 1      |
| {episode:00} | 01     |

###### Air Date

| Input      | Result     |
| ---------- | ---------- |
| {Air-Date} | 2020-09-03 |
| {Air Date} | 2020 09 03 |

###### Episode Title

| Input                | Result        |
| -------------------- | ------------- |
| {Episode Title}      | Episode Title |
| {Episode CleanTitle} | Episode Title |

###### Quality

| Input           | Result           |
| --------------- | ---------------- |
| {Quality Full}  | HDTV 720p Proper |
| {Quality Title} | HDTV 720p        |

###### Media Info

| Input                         | Result                |
| ----------------------------- | --------------------- |
| {MediaInfo Simple}            | x264 DTS              |
| {MediaInfo VideoCodec}        | x264                  |
| {MediaInfo AudioChannels}     | 5.1                   |
| {MediaInfo SubtitleLanguages} | \[EN\]                |
| {MediaInfo VideoBitDepth}     | 8                     |
| {MediaInfo Full}              | x264 DTS \[EN+DE\] \* |
| {MediaInfo AudioCodec}        | DTS                   |
| {MediaInfo AudioLanguages}    | \[EN+DE\]             |
| {MediaInfo VideoCodec}        | x264                  |
| {MediaInfo VideoDynamicRange} | HDR                   |

  - MediaInfo Full/AudioLanguages/SubtitleLanguages support a :EN+DE
    suffix allowing you to filter the languages included in the
    filename. Use -DE to exclude specific languages. Appending + (eg
    :EN+) will output \[EN\]/\[EN+--\]/\[--\] depending on excluded
    languages. For example {MediaInfo Full:EN+DE}.

###### Other

| Input             | Result   |
| ----------------- | -------- |
| {Release Group}   | Rls Grp  |
| {Preferred Words} | iNTERNAL |

  - Preferred words will be the word or words that were the literal
    matches of any preferred words you have. The above example would be
    a preferred word of `iNTERNAL` or similarly a preferred word of
    `/\b(amzn|amazon)\b(?=[ ._-]web[ ._-]?(dl|rip)\b)/i` would return
    `AMZN` or `Amazon`

###### Original

| Input               | Result                               |
| ------------------- | ------------------------------------ |
| {Original Title}    | Series.Title.S01E01.HDTV.x264.EVOLVE |
| {Original Filename} | Series.title.s01e01hdtv.x264.EVOLVE  |

  - Original Filename is not recommended. It is the literal original
    filename and may be obfuscated `t1i0p3s7i8yuti`.
  - Original Title is the release name is is what is suggested to be
    used.

##### Daily Episode Format

Here you will select the naming convention for episodes that air daily

See [Standard Episode Format](#Standard_Episode_Format "wikilink")

##### Anime Episode Format

Here you will select the naming convention for Anime series  
Note:'' Typically anime is aired in an absolute order also known as
production order. Usually this is shown as e001, e002...e104, e105 ect.
When a series is set to use Anime this setting will pull the absolute
order from TheTVDB which is usually one continuous season. An example of
this can be seen
[here](https://thetvdb.com/series/dragon-ball-z/seasons/absolute/1)''

All other settings are as above in the [Standard Episode
Format](#Standard_Episode_Format "wikilink") section

###### Absolute Episode Number

| Input          | Result |
| -------------- | ------ |
| {absolute:0}   | 1      |
| {absolute:00}  | 01     |
| {absolute:000} | 001    |

#### *Series Folder Format*

This is where you will set the naming convention for the folder that
contains the season folders or episode files.

##### Series Naming

| Input                        | Result              |
| ---------------------------- | ------------------- |
| {Series Title}               | Series Name\!       |
| {Series CleanTitleYear}      | Series Title 2010   |
| {Series TitleFirstCharacter} | S                   |
| {Series CleanTitle}          | Series Title        |
| {Series TitleThe}            | Series Title, The   |
| {Series TitleYear}           | Series Title (2010) |
| {Series Year}                | (2010)              |

##### Series IDs

| Input      | Result  |
| ---------- | ------- |
| {ImdbId}   | tt12345 |
| {Tmdbid}   | 123456  |
| {TvMazeId} | 54321   |

#### Season Folder Format

##### Seasons

| Input       | Result |
| ----------- | ------ |
| {season:0}  | 1      |
| {season:00} | 01     |

<section end="sonarr_episode_naming" />

### Lidarr

<section begin="lidarr_track_naming" />

  - Rename Tracks - If this is toggled off (no check in the box) Lidarr
    will use the existing file name if renaming is disabled
  - Replace Illegal Characters - If this is toggled off (no check in the
    box) Lidarr will replace illegal characters.

<!-- end list -->

  -   
    Example: `\` `#` `/` `$` `*` `<` `>` just to name a few

##### Standard Track Format

Here you will select the naming convention for the actual audio files

  - Dropdown Box (upper right corner)
      - Left Box - Space Handling
          - Space ( ) - Use spaces in naming (Default)
          - Period (`.`) - Use periods in lieu of spaces in naming
          - Underscore (`_`) - Use underscores in lieu of spaces in
            naming
          - Dash (`-`) - Use dashes in lieu of spaces in naming
      - Right Box - Case Handling
          - Default Case - Make title uppercase and lowercase
            (\~camelcase) (Default)
          - Uppercase - Make title all uppercase
          - Lowercase - Make title all lowercase

###### Artist Naming

| Input                   | Result           |
| ----------------------- | ---------------- |
| {Artist Name}           | Artist Name      |
| {Artist CleanName}      | Artist Name      |
| {Artist NameThe}        | Artist Name, The |
| {Artist Disambiguation} | Disambiguation   |

###### Album

| Input                  | Result           |
| ---------------------- | ---------------- |
| {Album Title}          | Album Title      |
| {Album CleanTitle}     | Album Title      |
| {Album Disambiguation} | Disambiguation   |
| {Album TitleThe}       | Album Title, The |
| {Album Type}           | Album Type       |

###### Release Date

| Input          | Result |
| -------------- | ------ |
| {Release Year} | 2020   |

###### Medium

| Input       | Result |
| ----------- | ------ |
| {medium:0}  | 1      |
| {medium:00} | 01     |

###### Medium Format

| Input           | Result |
| --------------- | ------ |
| {Medium Format} | CD     |

###### Track

| Input      | Result |
| ---------- | ------ |
| {track:0}  | 1      |
| {track:00} | 01     |

###### Track Title

| Input              | Result      |
| ------------------ | ----------- |
| {Track Title}      | Track Title |
| {Track CleanTitle} | Track Title |

###### Quality

| Input           | Result      |
| --------------- | ----------- |
| {Quality Full}  | FLAC Proper |
| {Quality Title} | FLAC        |

###### Media Info

| Input                          | Result  |
| ------------------------------ | ------- |
| {MediaInfo AudioCodec}         | FLAC    |
| {MediaInfo AudioBitRate}       | 320kbps |
| {MediaInfo AudioSampleRate}    | 44.1kHz |
| {MediaInfo AudioChannels}      | 2.0     |
| {MediaInfo AudioBitsPerSample} | 24bit   |

###### Other

| Input             | Result   |
| ----------------- | -------- |
| {Release Group}   | Rls Grp  |
| {Preferred Words} | iNTERNAL |

  - Preferred words will be the word or words that were the literal
    matches of any preferred words you have. The above example would be
    a preferred word of `iNTERNAL` or similarly a preferred word of
    `/\b(amzn|amazon)\b(?=[ ._-]web[ ._-]?(dl|rip)\b)/i` would return
    `AMZN` or `Amazon`

###### Original

| Input               | Result                                  |
| ------------------- | --------------------------------------- |
| {Original Title}    | Artist.Name.Album.Name.2020.FLAC.EVOLVE |
| {Original Filename} | 01-track name                           |

  - Original Filename is not recommended. It is the literal original
    filename and may be obfuscated `t1i0p3s7i8yuti`.
  - Original Title is the release name is is what is suggested to be
    used.

##### Multi Disc Track Format

See [Standard Track Format](#Standard_Track_Format "wikilink")

##### Artist Folder Format

| Input                   | Result           |
| ----------------------- | ---------------- |
| {Artist Name}           | Artist Name      |
| {Artist CleanName}      | Artist Name      |
| {Artist NameThe}        | Artist Name, The |
| {Artist Disambiguation} | Disambiguation   |

##### Album Folder Format

###### Artist

| Input                   | Result           |
| ----------------------- | ---------------- |
| {Artist Name}           | Artist Name      |
| {Artist CleanName}      | Artist Name      |
| {Artist NameThe}        | Artist Name, The |
| {Artist Disambiguation} | Disambiguation   |

###### Album

| Input                   | Result           |
| ----------------------- | ---------------- |
| {Album Title}           | Album Title      |
| {Album CleanTitle}      | Album Title      |
| {Artist Disambiguation} | Disambiguation   |
| {Album TitleThe}        | Album Title, The |
| {Album Type}            | Album Type       |

###### Release Date

| Input          | Result |
| -------------- | ------ |
| {Release Year} | 2020   |

<section end="lidarr_track_naming" />

### Readarr

<section begin="readarr_book_naming" />

  - Rename Books - If this is toggled off (no check in the box) Readarr
    will use the existing file name if renaming is disabled
  - Replace Illegal Characters - If this is toggled off (no check in the
    box) Readarr will replace illegal characters.

<!-- end list -->

  -   
    Example: `\` `#` `/` `$` `*` `<` `>` just to name a few

##### Standard Book Format

Here you will select the naming convention for the actual audio files

  - Dropdown Box (upper right corner)
      - Left Box - Space Handling
          - Space ( ) - Use spaces in naming (Default)
          - Period (`.`) - Use periods in lieu of spaces in naming
          - Underscore (`_`) - Use underscores in lieu of spaces in
            naming
          - Dash (`-`) - Use dashes in lieu of spaces in naming
      - Right Box - Case Handling
          - Default Case - Make title uppercase and lowercase
            (\~camelcase) (Default)
          - Uppercase - Make title all uppercase
          - Lowercase - Make title all lowercase

###### Author

| Input                   | Result           |
| ----------------------- | ---------------- |
| {Author Name}           | Author Name      |
| {Author CleanName}      | Author Name      |
| {Author NameThe}        | Author Name, The |
| {Author Disambiguation} | Disambiguation   |

###### Book

| Input                 | Result          |
| --------------------- | --------------- |
| {Book Title}          | Book Title      |
| {Book CleanTitle}     | Book Title      |
| {Book Disambiguation} | Disambiguation  |
| {Book TitleThe}       | Book Title, The |
| {Book Type}           | Book Type       |

###### Release Date

| Input          | Result |
| -------------- | ------ |
| {Release Year} | 2020   |

###### Medium

| Input       | Result |
| ----------- | ------ |
| {medium:0}  | 1      |
| {medium:00} | 01     |

###### Medium Format

| Input           | Result |
| --------------- | ------ |
| {Medium Format} | CD     |

###### Quality

| Input           | Result      |
| --------------- | ----------- |
| {Quality Full}  | FLAC Proper |
| {Quality Title} | FLAC        |

###### Media Info

| Input                          | Result  |
| ------------------------------ | ------- |
| {MediaInfo AudioCodec}         | FLAC    |
| {MediaInfo AudioBitRate}       | 320kbps |
| {MediaInfo AudioSampleRate}    | 44.1kHz |
| {MediaInfo AudioChannels}      | 2.0     |
| {MediaInfo AudioBitsPerSample} | 24bit   |

###### Other

| Input             | Result   |
| ----------------- | -------- |
| {Release Group}   | Rls Grp  |
| {Preferred Words} | iNTERNAL |

  - Preferred words will be the word or words that were the literal
    matches of any preferred words you have. The above example would be
    a preferred word of `iNTERNAL` or similarly a preferred word of
    `/\b(amzn|amazon)\b(?=[ ._-]web[ ._-]?(dl|rip)\b)/i` would return
    `AMZN` or `Amazon`

###### Original

| Input               | Result                                 |
| ------------------- | -------------------------------------- |
| {Original Title}    | Author.Name.Book.Name.2020.FLAC.EVOLVE |
| {Original Filename} | 01-book name                           |

  - Original Filename is not recommended. It is the literal original
    filename and may be obfuscated `t1i0p3s7i8yuti`.
  - Original Title is the release name is is what is suggested to be
    used.

##### Author Folder Format

Here you will select the naming convention for the Author Folder

  - Dropdown Box (upper right corner)
      - Left hand one - Replaces all spaces with selected variable
      - Right hand one - Sets to default upper and Lowercase, all
        lowercase or all uppercase

| Input                   | Result           |
| ----------------------- | ---------------- |
| {Author Name}           | Author Name      |
| {Author CleanName}      | Author Name      |
| {Author NameThe}        | Author Name, The |
| {Author Disambiguation} | Disambiguation   |

<section end="readarr_book_naming" />

## Folders \<-- Uses template

**Uses template with no variables**  [Template:Settings Media Management
Folders](Template:Settings_Media_Management_Folders "wikilink")

## Importing

### Radarr

<section begin="radarr_importing" />

  - *Skip Free Space Check* - Use when Radarr is unable to detect free
    space from your movies root folder
  - *Minimum Free Space* - Toggling this will prevent import if it would
    leave less than this amount of disk space available
  - *Use Hard links instead of Copy* - Use Hard links when trying to
    copy files from torrents that are still being seeded (for more
    information on this click [here](Docker_Guide "wikilink"))
  - Import Extra Files - Import matching extra files (subtitles, nfo,
    etc) after importing a file

<section end="radarr_importing" />

### Sonarr

<section begin="sonarr_importing" />

  - *Episode Title Required* - Prevent importing for up to 24 hours if
    the episode title is in the naming format and the episode title is
    TBA. After 24 hours the release will be imported even if still TBA.
      - Always - Always wait up to 24 hours for a title prior to
        importing if the episode is TBA
      - Only for Bulk Season Releases - Only if a season pack or bulk
        release is found wait up to 24 hours for a title prior to
        importing if the episode is TBA.
      - Never - Do not delay importing if the episode is TBA.
  - *Skip Free Space Check* - Use when Sonarr is unable to detect free
    space from your series root folder
  - *Minimum Free Space* - Toggling this will prevent import if it would
    leave less than this amount of disk space available
  - Use Hard links instead of Copy - Use Hard links when trying to copy
    files from torrents that are still being seeded (for more
    information on this click [here](Docker_Guide "wikilink"))
  - Import Extra Files - Import matching extra files (subtitles, nfo,
    etc) after importing a file

<section end="sonarr_importing" />

### Lidarr

<section begin="lidarr_importing" />

  - Skip Free Space Check - Use when Lidarr is unable to detect free
    space from your aritist root folder
  - *Use Hard links instead of Copy* - Use Hard links when trying to
    copy files from torrents that are still being seeded (for more
    information on this click [here](Docker_Guide "wikilink"))
  - Import Extra Files - Import matching extra files (subtitles, nfo,
    etc) after importing a file

<section end="lidarr_importing" />

### Readarr

<section begin="readarr_importing" />

  - *Skip Free Space Check* - Use when Readarr is unable to detect free
    space from your author root folder
  - *Minimum Free Space* - Toggling this will prevent import if it would
    leave less than this amount of disk space available
  - *Use Hard links instead of Copy* - Use Hard links when trying to
    copy files from torrents that are still being seeded (for more
    information on this click [here](Docker_Guide "wikilink"))
  - Import Extra Files - Import matching extra files (subtitles, nfo,
    etc) after importing a file

<section end="readarr_importing" />

## File Management

### Radarr

<section begin="radarr_file_management" />

  - Ignore Deleted Movies - Movies deleted from disk, detected by a
    scheduled or manual rescan, are automatically unmonitored in Radarr
  - *Download Proper & Repacks* - Should Radarr automatically upgrade
    and preferr propers when available? (see link for explanation on
    [Proper and Repack](Definitions "wikilink"))
      - Prefer and Upgrade - Rank repacks and propers higher than
        non-repacks and non-propers. Treat new repacks and propers as
        upgrade to current releases.
      - Do Not Upgrade Automatically - Rank repacks and propers higher
        than non-repacks and non-propers. Do not treat new repacks and
        propers as upgrade to current releases.
      - Do Not Prefer - Effectively this ignores repacks and propers.
        You'll need to manage any preference for those with custom
        formats.
  - *Analyse video files* - Extract file information such as resolution,
    runtime and codec information from files. This requires Radarr to
    read parts of the file which may cause high disk or network activity
    during scans.

<!-- end list -->

  - *Rescan Movie Folder after Refresh*
      - Always - This will rescan the movies folder based upon
        [Tasks](Radarr_System#Tasks "wikilink") Schedule
      - After Manual Refresh - You will have to manually rescan the disk
      - Never - Just as it says, never rescan the movie folder.

<!-- end list -->

  - *Change File Date*
      - None - Radarr will not change the date that shows in your given
        file browser
      - In Cinemas - The date the video was in cinemas
      - Physical release date - The date the video was released on
        disc/streaming

<!-- end list -->

  - *Recycling Bin* - Designate a location for deleted files to go to
    (just in case you want to retrieve them before the bin is taken out)
  - *Recycling Bin Cleanup* - This is how old a given file can be before
    it is deleted permanently

<section end="radarr_file_management" />

### Sonarr

<section begin="sonarr_file_management" />

  - Ignore Deleted Episodes - Episodes deleted from disk, detected by a
    scheduled or manual rescan, are automatically unmonitored in Sonarr
  - *Download Proper & Repacks* - Should Sonarr automatically upgrade to
    propers when available? (see link for explanation on [Proper and
    Repack](Definitions "wikilink"))
      - Prefer and Upgrade - Rank repacks and propers higher than
        non-repacks and non-propers. Treat new repacks and propers as
        upgrade to current releases.
      - Do Not Upgrade Automatically - Rank repacks and propers higher
        than non-repacks and non-propers. Do not treat new repacks and
        propers as upgrade to current releases.
      - Do Not Prefer - Effectively this ignores repacks and propers.
        You'll need to manage any preference for those with Release
        Profiles (Preferred Words).
  - *Analyse video files* - Extract file information such as resolution,
    runtime and codec information from files. This requires Sonarr to
    read parts of the file which may cause high disk or network activity
    during scans.

<!-- end list -->

  - *Rescan Series Folder after Refresh*
      - Always - This will rescan series folder based upon
        [Tasks](Sonarr_System#Tasks "wikilink") Schedule
      - After Manual Refresh - You will have to manually rescan the disk
      - Never - Just as it says, never rescan the series folder.

<!-- end list -->

  - *Change File Date*
      - None - Sonarr will not change the date that shows in your given
        file browser
      - Sonarr - Local Release - The date the video was aired locally
      - Sonarr - UTC Release date - The date the video was released
        based upon the
        [UTC](wikipedia:Coordinated_Universal_Time "wikilink")

<!-- end list -->

  - *Recycling Bin* - Designate a location for deleted files to go to
    (just in case you want to retrieve them before the bin is taken out)
  - *Recycling Bin Cleanup* - This is how old a given file can be before
    it is deleted permanently

<section end="sonarr_file_management" />

### Lidarr

<section begin="lidarr_file_management" />

  - Ignore Deleted Tracks - Tracks deleted from disk, detected by a
    scheduled or manual rescan, are automatically unmonitored in Lidarr
  - Download Proper & Repacks - Should Lidarr automatically upgrade to
    propers when available? (see link for explanation on [Proper and
    Repack](Definitions "wikilink"))
      - Prefer and Upgrade - will prefer proper/repack if one is
        available (gives it a higher rating)
      - Do not upgrade automatically - This will not allow it to upgrade
        automatically but will still be rated accordingly.
  - *Rescan Artist Folder after Refresh*
      - Always - This will rescan artist folder based upon
        [Tasks](Lidarr_System#Tasks "wikilink") Schedule
      - After Manual Refresh - You will have to manually rescan the disk
      - Never - Just as it says, never rescan the artist folder.
  - *Allow Fingerprinting* - Use fingerprinting to improve accuracy of
    track matching
      - Always - This will analyze the file when matching
      - For New Imports Only - This will analyze only new imports
      - Never - just as it says, never fingerprint the track

<!-- end list -->

  - Change File Date
      - None - Lidarr will not change the date that shows in your given
        file browser
      - Album Release Date - The date the album was released

<!-- end list -->

  - Recycling Bin - Designate a location for deleted files to go to
    (just in case you want to retrieve them before the bin is taken out)

<!-- end list -->

  - Recycling Bin Cleanup - This is how old a given file can be before
    it is deleted permanently

<section end="lidarr_file_management" />

### Readarr

<section begin="readarr_file_management" />

  - Ignore Deleted Books - Books deleted from disk are automatically
    unmonitored in Readarr
  - *Propers and Repacks* - Should Readarr automatically upgrade to
    propers when available? (see link for explanation on [Proper and
    Repack](Definitions "wikilink"))
      - Prefer and Upgrade - will prefer proper/repack if one is
        available (gives it a higher rating)
      - Do not upgrade automatically - This will not allow it to upgrade
        automatically but will still be rated accordingly.
      - Do not prefer - Use 'Do not Prefer' to sort by preferred word
        score over propers/repacks, essentially putting the
        proper/repack lower on the list
  - *Watch Root Folders for file changes* - Rescan automatically when
    files change in a root folder

<!-- end list -->

  - *Rescan Author Folder after Refresh*
      - Always - This will rescan author folder based upon
        [Tasks](Readarr_System#Tasks "wikilink") Schedule
      - After Manual Refresh - You will have to manually rescan the disk
      - Never - Just as it says, never rescan the author folder.

<!-- end list -->

  - *Allow Fingerprinting* - Use fingerprinting to improve accuracy of
    book matching
      - Always - This will analyze the file when matching
      - For New Imports Only - This will analyze only new imports
      - Never - just as it says, never fingerprint the book

<!-- end list -->

  - *Change File Date*
      - None - Readarr will not change the date that shows in your given
        file browser
      - Book Release Date - The date the book was released

<!-- end list -->

  - *Recycling Bin* - Designate a location for deleted files to go to
    (just in case you want to retrieve them before the bin is taken out)

<!-- end list -->

  - *Recycling Bin Cleanup* - This is how old a given file can be before
    it is deleted permanently

<section end="readarr_file_management" />

## Permissions

### Radarr

**TEMPLATE**

### Sonarr

**TEMPLATE**

### Lidarr

**TEMPLATE**

### Readarr

**TEMPLATE**

## Root Folders

### Radarr

**TEMPLATE**

### Sonarr

**TEMPLATE**

### Lidarr

**TEMPLATE**

### Readarr

<section begin="readarr_root_folders" />

Readarr is unique in that it can integrate with an outside application
known as Calibre to further manage, tag and even serv up your media to
various readers

  - Name - This is a unique name for the given path
  - Path - This is where your media is going to be stored **(do not have
    your downloads going here)**
  - Calibre Library - Toggle if you're going to use Calibre to further
    manage your library
  - Calibre Host - The IP address for your Calibre instance
  - Calibre Port - The port number associated to your Calibre instance
  - Calibre Url Base - Adds a prefix to the calibre url, e.g.
    [http://\[host\]](http://%5Bhost%5D):\[port\]/\[urlBase\]
  - Calibre User Name - The username in order to access your Calibre
    server
  - Calibre Password - The password in order to access your Calibre
    server
  - Convert to format - Calibre has the ability to convert any incoming
    format to a specific format (eg. epub or mobi just to name a few)
  - Calibre Output Profile - ????
  - Use SSL - Toggle if you'd like Readarr to connect to Calibre using
    SSL encryption
  - Monitor
      - All books - Readarr will monitor all books in your library
      - Future Books - Readarr will only monitor future books, Readarr
        will not monitor any current or older books
      - Missing - Readarr will only monitor any books that are missing
      - Existing - Readarr will monitor only existing books in order to
        meet your given cutoff
      - First - Readarr will only monitor the given author's first book
      - Last - Readarr will only monitor the given author's last book
      - None - Readarr will not monitor any authors books
  - Quality Profile - These can be changed within the
    [Profiles](#Profiles "wikilink") section and will dictate what
    quality is acceptable
  - Metadata Profile - This can be changed within the
    [Metadata](#Metadata "wikilink") section and will dictate what
    metadata source
      - Standard is set by default
      - Select 'None' to only include items manually added via search or
        that match files on disk
  - Default Readarr Tags - Select what tag you'd like to set for this
    content (more information on Tags can be found
    [here](#Tags "wikilink"))

<section end="readarr_root_folders" />

## Templates

  - [Template:Settings Media Management Root
    Folders](Template:Settings_Media_Management_Root_Folders "wikilink")
  - [Template:Settings Media Management
    Folders](Template:Settings_Media_Management_Folders "wikilink")
  - [Template:Settings Media Management
    Permissions](Template:Settings_Media_Management_Permissions "wikilink")
