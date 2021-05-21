## Custom Post Processing Scripts

<table>
<thead>
<tr class="header">
<th><p>WARNING</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Readarr this page is not yet complete.<br />
</p>
<p><strong>You have been WARNED!</strong></p></td>
</tr>
</tbody>
</table>

If you’re looking to trigger a custom script in your download client to
tell Readarr when to update, you can find more details here. Scripts are
added to Readarr via the [Connect
Settings](Radarr_Settings#Connections "wikilink") page.

### Overview

Readarr can execute a custom script when new movies are imported or a
movie is renamed and depending on which action occurred, the parameters
will be different. They are passed to the script through environment
variables which allows for more flexibility in what is sent to the
script and in no particular order.

### Environment Variables

##### On Grab

| Environment Variable                    | Details                                                                                                     |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| readarr\_eventtype                      | Grab                                                                                                        |
| readarr\_download\_client               | NZB/Torrent downloader client                                                                               |
| readarr\_download\_id                   | The hash of the torrent/NZB file downloaded (used to uniquely identify the download in the download client) |
| readarr\_movie\_id                      | Internal ID of the movie                                                                                    |
| readarr\_movie\_imdbid                  | IMDb ID for the movie                                                                                       |
| readarr\_movie\_in\_cinemas\_date       | Cinema release date                                                                                         |
| readarr\_movie\_physical\_release\_date | Physical release date                                                                                       |
| readarr\_movie\_title                   | Title of the movie                                                                                          |
| readarr\_movie\_tmdbid                  | TMDb ID for the movie                                                                                       |
| readarr\_movie\_year                    | Release year of the movie                                                                                   |
| readarr\_release\_indexer               | Indexer where the release was grabbed                                                                       |
| readarr\_release\_quality               | Quality name from Readarr                                                                                   |
| readarr\_release\_qualityversion        | 1 is the default, 2 for proper, 3+ could be used for anime versions                                         |
| readarr\_release\_releasegroup          | Release Group, will not be set if it is unknown                                                             |
| readarr\_release\_size                  | Size of the release reported by the indexer                                                                 |
| readarr\_release\_title                 | NZB/Torrent title                                                                                           |

##### On Download/On Upgrade

| Environment Variable                    | Details                                                                                                     |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| readarr\_eventtype                      | Download                                                                                                    |
| readarr\_download\_id                   | The hash of the torrent/NZB file downloaded (used to uniquely identify the download in the download client) |
| readarr\_isupgrade                      | `True` when an existing file is upgraded, otherwise `False`                                                 |
| readarr\_movie\_id                      | Internal ID of the movie                                                                                    |
| readarr\_movie\_imdbid                  | IMDb ID for the movie                                                                                       |
| readarr\_movie\_in\_cinemas\_date       | Cinema release date                                                                                         |
| readarr\_movie\_physical\_release\_date | Physical release date                                                                                       |
| readarr\_movie\_path                    | Full path to the movie ( /Movie (Year)/ )                                                                   |
| readarr\_movie\_title                   | Title of the movie                                                                                          |
| readarr\_movie\_tmdbid                  | TMDb ID for the movie                                                                                       |
| readarr\_movie\_year                    | Release year of the movie                                                                                   |
| readarr\_moviefile\_id                  | Internal ID of the movie file                                                                               |
| readarr\_moviefile\_relativepath        | Path to the movie file relative to the movie’ path                                                          |
| readarr\_moviefile\_path                | Full path to the movie file ( /Movie (Year)/Movie (Year).mkv )                                              |
| readarr\_moviefile\_quality             | Quality name from Readarr                                                                                   |
| readarr\_moviefile\_qualityversion      | 1 is the default, 2 for proper, 3+ could be used for anime versions                                         |
| readarr\_moviefile\_releasegroup        | Release group, will not be set if it is unknown                                                             |
| readarr\_moviefile\_scenename           | Original release name                                                                                       |
| readarr\_moviefile\_sourcepath          | Full path to the movie file that was imported                                                               |
| readarr\_moviefile\_sourcefolder        | Full path to the folder the movie file was imported from                                                    |

##### On Rename

| Environment Variable                    | Details                   |
| --------------------------------------- | ------------------------- |
| readarr\_eventtype                      | Rename                    |
| readarr\_movie\_id                      | Internal ID of the movie  |
| readarr\_movie\_imdbid                  | IMDb ID for the movie     |
| readarr\_movie\_in\_cinemas\_date       | Cinema release date       |
| readarr\_movie\_path                    | Full path to the movie    |
| readarr\_movie\_physical\_release\_date | Physical release date     |
| readarr\_movie\_title                   | Title of the movie        |
| readarr\_movie\_tmdbid                  | TMDb ID for the movie     |
| readarr\_movie\_year                    | Release year of the movie |

### Specific usage tips

#### LINUX / UNIX Scripts

Remember to always add a
[shebang](https://en.wikipedia.org/wiki/Shebang_\(Unix\)) and make your
scripts executable with [chmod](https://en.wikipedia.org/wiki/Chmod).

{{\#spoiler:show=Sample bash script to echo environmental
variables|hide=Click to close|spoiler\_text

``` bash
#!/bin/bash
RADARRENVLOG=&quot;/pathtoalog.log&quot;

if [[ $radarr_eventtype == &quot;Grab&quot; ]] ; then
  echo &quot;
    radarr_download_client = $radarr_download_client // NZB/Torrent downloader client
    radarr_download_id = $radarr_download_id // The hash of the torrent/NZB file downloaded (used to uniquely identify the download in the download client)
    radarr_movie_id = $radarr_movie_id // Internal ID of the movie
    radarr_movie_imdbid = $radarr_movie_imdbid // IMDb ID for the movie
    radarr_movie_in_cinemas_date = $radarr_movie_in_cinemas_date // Cinema release date
    radarr_movie_physical_release_date = $radarr_movie_physical_release_date // Physical release date
    radarr_movie_title = $radarr_movie_title // Title of the movie
    radarr_movie_tmdbid = $radarr_movie_tmdbid // TMDb ID for the movie
    radarr_movie_year = $radarr_movie_year // Release year of the movie
    radarr_release_indexer = $radarr_release_indexer // Indexer where the release was grabbed
    radarr_release_quality = $radarr_release_quality // Quality name from Radarr
    radarr_release_qualityversion = $radarr_release_qualityversion // 1 is the default, 2 for proper, 3+ could be used for anime versions
    radarr_release_releasegroup = $radarr_release_releasegroup // Release Group, will not be set if it is unknown
    radarr_release_size = $radarr_release_size // Size of the release reported by the indexer
    radarr_release_title = $radarr_release_title // NZB/Torrent title&quot; &gt;&gt; $RADARRENVLOG
fi
if [[ $radarr_eventtype == &quot;Download&quot; ]] ; then
  echo &quot;
    radarr_download_id = $radarr_download_id // The hash of the torrent/NZB file downloaded (used to uniquely identify the download in the download client)
    radarr_isupgrade = $radarr_isupgrade // `True` when an existing file is upgraded, otherwise `False`
    radarr_movie_id = $radarr_movie_id // Internal ID of the movie
    radarr_movie_imdbid = $radarr_movie_imdbid // IMDb ID for the movie
    radarr_movie_in_cinemas_date = $radarr_movie_in_cinemas_date // Cinema release date
    radarr_movie_physical_release_date = $radarr_movie_physical_release_date // Physical release date
    radarr_movie_path = $radarr_movie_path // Full path to the movie ( /Movie (Year)/ )
    radarr_movie_title = $radarr_movie_title // Title of the movie
    radarr_movie_tmdbid = $radarr_movie_tmdbid // TMDb ID for the movie
    radarr_movie_year = $radarr_movie_year // Release year of the movie
    radarr_moviefile_id = $radarr_moviefile_id // Internal ID of the movie file
    radarr_moviefile_relativepath = $radarr_moviefile_relativepath // Path to the movie file relative to the movie' path
    radarr_moviefile_path = $radarr_moviefile_path // Full path to the movie file ( /Movie (Year)/Movie (Year).mkv )
    radarr_moviefile_quality = $radarr_moviefile_quality // Quality name from Radarr
    radarr_moviefile_qualityversion = $radarr_moviefile_qualityversion // 1 is the default, 2 for proper, 3+ could be used for anime versions
    radarr_moviefile_releasegroup = $radarr_moviefile_releasegroup // Release group, will not be set if it is unknown
    radarr_moviefile_scenename = $radarr_moviefile_scenename // Original release name
    radarr_moviefile_sourcepath = $radarr_moviefile_sourcepath // Full path to the movie file that was imported
    radarr_moviefile_sourcefolder = $radarr_moviefile_sourcefolder // Full path to the folder the movie file was imported from&quot; &gt;&gt; $RADARRENVLOG
fi
if [[ $radarr_eventtype == &quot;Rename&quot; ]] ; then
  echo &quot;
    radarr_movie_id = $radarr_movie_id // Internal ID of the movie
    radarr_movie_imdbid = $radarr_movie_imdbid // IMDb ID for the movie
    radarr_movie_in_cinemas_date = $radarr_movie_in_cinemas_date // Cinema release date
    radarr_movie_path = $radarr_movie_path // Full path to the movie
    radarr_movie_physical_release_date = $radarr_movie_physical_release_date // Physical release date
    radarr_movie_title = $radarr_movie_title // Title of the movie
    radarr_movie_tmdbid = $radarr_movie_tmdbid // TMDb ID for the movie
    radarr_movie_year = $radarr_movie_year // Release year of the movie&quot; &gt;&gt; $RADARRENVLOG
fi
```

}}

#### PHP

The information from Readarr will not be added to
\(_ENV as one might expect but should be included in the [\)\_SERVER
variable\](https://secure.php.net/manual/en/reserved.variables.server.php).
A sample script to use this information to convert a file can be found
[here](https://gist.github.com/karbowiak/7fb38d346e368edc9d1a). \#\#\#\#
PowerShell \#\#\#\# Sample script using the Readarr environment
variables to create EDL files for all episodes is
[here](https://gist.github.com/RedsGT/e1b5f28e7b5b81e1e45378151e73ba5c).

Sample script to have Plex scan destination folder only and “analyze
deeply” the file. PSQLite needed to query the plex DB. Adjust folder
locations to match your setup.

This script will add the movie to plex and scan the destination folder
(it will not scan the entire library) {{\#spoiler:show=Powershell
Scriptt|hide=Click to close|

``` powershell
# 
# C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe\PowerShell.exe -ExecutionPolicy Bypass "C:\Users\Server\Desktop\radarrcustom.ps1"

$movie_path = $env:radarr_movie_path
#PSQlite location
Import-Module C:\Users\Server\Desktop\scripts\PSSQLite
#set file locations
$logfile = "C:\Users\Server\Desktop\radarrimport.txt"
$database = "C:\Users\Server\AppData\Local\Plex Media Server\Plug-in Support\Databases\com.plexapp.plugins.library.db"
$plexscanner = "C:\Program Files (x86)\Plex\Plex Media Server\Plex Media Scanner.exe"
#set your plex library ID
$libraryid = 0
#If you have multiple root folders and library IDs you can set them like so
#If ($movie_path -like '*Movies Release\*' ) { $libraryid = 19 } 

#Scan the movie folder
& "$plexscanner" --scan --refresh --section $libraryid --directory $movie_path
write-output """$plexscanner"" --scan --refresh --section $libraryid --directory $movie_path" | add-content $logfile

sleep 20

#Query the plex db for the item ID
$likemoviepath = $movie_path + "%"
$query = "SELECT mi.metadata_item_id FROM media_parts mp LEFT JOIN media_items mi on mp.media_item_id=mi.id WHERE mp.file LIKE '$likemoviepath'"
$itemid = Invoke-SqliteQuery -Query $query -DataSource $database
$itemid = $itemid.metadata_item_id

#Analyze the ItemID
& "$plexscanner" --analyze --item $itemid
write-output """$plexscanner"" --analyze --item $itemid" | add-content $logfile

sleep 20

#Analyze deeply the item ID
& "$plexscanner" --analyze-deeply --item $itemid
write-output """$plexscanner"" --analyze-deeply --item $itemid" | add-content $logfile
```

}}

#### Reverse Symlinking

When using private trackers, it is imperative to continue seeding. By
using this script `on Download` and `on Upgrade` moves the media to your
root movie folder as set in Readarr, and will create a symlink in the
original download location so you can continue to seed.

Symlinking is preferable over hardlinking in some cases as the root
movie folder can be on a seperate drive or nfs mount, where hardlinks
are impossible. {{\#spoiler:show=Bash Script|hide=Click to close|

``` bash
#!/bin/bash

PERMPATH="$radarr_moviefile_path"
LINKPATH="$radarr_moviefile_sourcepath"

if [[ -f "$LINKPATH" ]]; then
    sleep 1
else
    exit 1
fi

ORIGFILESIZE=$(stat -c%s "$LINKPATH")
PERMFILESIZE=$(stat -c%s "$PERMPATH")

sleep 30

while [[ $PERMFILESIZE != $ORIGFILESIZE ]]; do
    sleep 60
    PERMFILESIZE=$(stat -c%s "$PERMPATH")
done

if [[ $PERMFILESIZE == $ORIGFILESIZE ]]; then
    # Save current time stamps to prevent radarr from identifying our simlink as new, and double-processing it
    LINKDIR=$(dirname "$LINKPATH")
    FOLDER_DATE=$(date -r "$LINKDIR" +@%s.%N)
    FILE_DATE=$(date -r "$LINKPATH" +@%s.%N)

    rm "$LINKPATH"
    ln -s "$PERMPATH" "$LINKPATH"

    touch --no-create --no-dereference  --date "$FILE_DATE" "$LINKPATH"
    touch --no-create --no-dereference  --date "$FILE_DATE" "$PERMPATH"
    touch --no-create --no-dereference  --date "$FOLDER_DATE" "$LINKDIR"
fi
```

}} A quick way to test scripts is to create a testing environment using
the movie “Test (2013)”.

    mkdir -p ~/test &amp;&amp; cd ~/test &amp;&amp; touch &quot;Test (2013).nfo&quot; &quot;Test (2013).por.srt&quot; &quot;Test (2013).por.forced.srt&quot; &quot;Test (2013).eng.srt&quot; &quot;Test (2013).mkv&quot; &amp;&amp; cp -R ~/test /path/to/folder/to/import

or in bash:

    mkdir -p ~/test &amp;&amp; cd ~/test &amp;&amp; touch &quot;Test (2013).&quot;{nfo,por.srt,por.forced.srt,eng.srt,mkv} &amp;&amp; cp -R ~/test /path/to/folder/to/import

This way you can manually import this movie and trigger the script. You
can just run it again to repopulate the files.
