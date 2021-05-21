## TRaSH's Custom Formats

[TRaSH's Guides](https://trash-guides.info/Radarr/)

## Rename Movie Folders

  - If you've recently changed your movie folder name template
    ([Settings -\> Movie Folder
    Format](Radarr_Settings#Standard_Movie_Folder_Format "wikilink"))
    and want to rename your existing movie folders, you need to use a
    trick.

![original-movie-folder-nameing.png](original-movie-folder-nameing.png
"original-movie-folder-nameing.png")

  - You'll first need to go to the main library page (Movies) and select
    Mass Edit:

![select-mass-editor.png](select-mass-editor.png
"select-mass-editor.png")

  - Select the Movies you'll want to edit (1) or click Select all (2)

![select-individual-or-all-movies.png](select-individual-or-all-movies.png
"select-individual-or-all-movies.png")

  - Next you'll want to select which root folder this(these) movies need
    to be placed in (your root folders might look different than shown
    here)

![select-root-folder.png](select-root-folder.png
"select-root-folder.png")

  - When the move files propt is displayed select select: **Yes, Move
    the files** (even if the though the files aren't being moved this
    will in a sense move the files from the old folder to the new folder
    renamed)

![move-files-pop-up-window-select-yes.png](move-files-pop-up-window-select-yes.png
"move-files-pop-up-window-select-yes.png")

  - Depending on how large your library is it may take a while for all
    folders to be renamed once completed check your movies to see if
    everything worked properly.

![framless|none|750px|alt=New name](new-movie-folder-name.png
"framless|none|750px|alt=New name")

## Importing IMDb lists into TMDb

This is a guide for importing a list from IMDb into The Movie Database.
This can be useful for large lists, due to IMDb’s RSS feeds not
supporting the entire list.

1.  [Log into your IMDb
    account](https://www.imdb.com/registration/signin).
2.  Open the list you would like to import into TMDb.
3.  Scroll to the bottom, just before the comments, and click the
    “Export this list” button, as shown below: ![Click the “Export
    this list” button](Importing-IMDb-lists-into-TMDb1.png
    "Click the “Export this list” button")
4.  [Log into your TMDb account](https://www.themoviedb.org/login).
5.  [Go to your account page on TMDb (by clicking your
    username)](https://www.themoviedb.org/account/).
6.  Click the “Import List” button on the left side-bar as shown below:

![Click the “Import List” button](Importing-IMDb-lists-into-TMDb2.png
"Click the “Import List” button")

7.  Click “Select Files…” and navigate to the downloaded CSV file from
    IMDb:

![Click “Select Files…”](Importing-IMDb-lists-into-TMDb3.png
"Click “Select Files…”")

8.  Choose the destination list as shown in the image above.
9.  Click import, and wait to be notified of the import completion.

## Create a Folder for Each Movie

### Windows & Linux

#### Filebot

[Filebot](http://www.filebot.net/) is a fantastic utility for getting
your movies organized in a way that Radarr can successfully parse.
Version 4.7.9’s [64
bit](https://sourceforge.mirrorservice.org/f/project/fi/filebot/filebot/FileBot_4.7.9/FileBot_4.7.9_x64.msi)
and [32
bit](https://sourceforge.mirrorservice.org/f/project/fi/filebot/filebot/FileBot_4.7.9/FileBot_4.7.9_x86.msi)
can still be downloaded free from a SourceForge
[mirror](https://sourceforge.mirrorservice.org/f/project/fi/filebot/filebot/FileBot_4.7.9/),
but there are also paid versions in the
[Windows](https://www.microsoft.com/en-us/store/p/filebot/9nblggh52t9x?cid=filebot2)
and
[Apple](https://itunes.apple.com/us/app/filebot/id905384638?mt=12&uo=6&at=1l3vupy&ct=filebot2)
stores. On Linux, your distribution of choice may have a package for it,
like in [Arch’s AUR
package](https://aur.archlinux.org/packages/filebot/) or `.deb` files
for Debian/Ubuntu from their [download
page](http://www.filebot.net/#download). It has both a GUI and a CLI, so
should satisfy almost everyone.

There is great help available, including their [format
expressions](http://www.filebot.net/naming.html) page. My personal
suggestion is to use something like `{ny}\{fn}` *if* your files include
useful details like quality, edition and/or group *or* `{ny}/{ny}
[{dim[0] >= 1280 ? 'Bluray' : 'DVD'}-{vf}]` if they don’t, which would
yield `Movie (Year)/Movie (Year) [Bluray-1080p]` or `Movie (Year)/Movie
(Year) [DVD-480p]` for example. Instead of `Bluray`, you could also use
`WEBDL` if you’d rather your collection be considered that.

To keep this pattern for future movies, you should set:

Settings -\> Media Management (Advanced Settings Shown) -\> Movie Naming
\* File: `{Movie CleanTitle} {(Release Year)} {Edition Tags} {[Quality
Title]}` \* Folder: `{Movie CleanTitle} {(Release Year)}`

Note: You can replace the spaces above with `.` or `_` if you prefer
that naming format.

### Windows

#### Files 2 Folder

I used a program called [Files 2
Folder](http://www.dcmembers.com/skwire/download/files-2-folder/) to
make my movie library visible for import into Radarr, extract the zip to
your computer and run the .exe as administrator, then click yes to add
it to your right click menu.

1.  Browse to your movie folder
2.  Select all files and right click to bring up the menu
3.  Press the files 2 folder option in the menu

![File 2 Folder](Create-a-Folder-for-Each-Movie1.jpg "File 2 Folder")

1.  Wait for the box to appear, ONLY CLICK THE SECOND OPTION

![Second Option](Create-a-Folder-for-Each-Movie2.png "Second Option")

1.  Each movie will be in its’ own folder.

![Own Folder](Create-a-Folder-for-Each-Movie3.jpg "Own Folder")

### Linux

    cd /path/to/your/movies/files/
    find . -maxdepth 1 -type f -iname "*.mkv" -exec sh -c 'mkdir "${1%.*}" ; mv "${1%}" "${1%.*}" ' _ {} \;

#### Windows & Linux

This script will place movies and TV episodes on folders  
Files are not modifed or renamed only moved to folders.

Usage:: ./movie\&TV2folder.py /path/movies/ (Movie 1 (year) , Movie)  
Usage:: ./movie\&TV2folder.py /path/tv/ ( tv folders: Tile 1, Title 2
)  
Type of files:

Movies: (scans 1 folder deep - i.e. not recursive)  
All files bellow would be moved to folder: ./Movie Title (2017)  
Movie Title (2017) 1080p.mkv  
Movie Title (2017) anything else.\*  
Movie Title (2017).\*  
Movie Title.mkv –\> **would not be moved, since missing (year)**

Series: (scans 2 folders deep)  
All files bellow would be moved to folder: ./Season 04/  
Farscape - S04E01.mkv  
Farscape - S04E01-E02.mkv  
Farscape - S04E01  
S04E01 - Farscape - group.mkv  
Daily Show S2014E20 - would be moved to ./Season 2014/

Additional rules:  
On OS error: retry operation 3 times with 1 second delay between
attempts.  
If move fails it continue with other files.

<https://github.com/ajkis/scripts/blob/master/other/movie-tv2folder.py>

## Custom Post Processing Scripts

If you’re looking to trigger a custom script in your download client to
tell Radarr when to update, you can find more details below. Scripts are
added to Radarr via the [Connect
Settings](Radarr_Settings#Connections "wikilink") page.

### Overview

Radarr can execute a custom script when new movies are imported or a
movie is renamed and depending on which action occurred, the parameters
will be different. They are passed to the script through environment
variables which allows for more flexibility in what is sent to the
script and in no particular order.

### Environment Variables

##### On Grab

| Environment Variable                   | Details                                                                                                                       |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| radarr\_eventtype                      | Grab                                                                                                                          |
| radarr\_download\_client               | NZB/Torrent downloader client, empty if missing                                                                               |
| radarr\_download\_id                   | The hash of the torrent/NZB file downloaded (used to uniquely identify the download in the download client), empty if missing |
| radarr\_movie\_id                      | Internal ID of the movie                                                                                                      |
| radarr\_movie\_imdbid                  | IMDb ID for the movie, empty if missing                                                                                       |
| radarr\_movie\_in\_cinemas\_date       | Cinema release date, empty if missing                                                                                         |
| radarr\_movie\_physical\_release\_date | Physical release date, empty if missing                                                                                       |
| radarr\_movie\_title                   | Title of the movie                                                                                                            |
| radarr\_movie\_tmdbid                  | TMDb ID for the movie                                                                                                         |
| radarr\_movie\_year                    | Release year of the movie                                                                                                     |
| radarr\_release\_indexer               | Indexer where the release was grabbed, empty if missing                                                                       |
| radarr\_release\_quality               | Quality name from Radarr                                                                                                      |
| radarr\_release\_qualityversion        | 1 is the default, 2 for proper, 3+ could be used for anime versions                                                           |
| radarr\_release\_releasegroup          | Release Group, empty if missing                                                                                               |
| radarr\_release\_size                  | Size of the release reported by the indexer                                                                                   |
| radarr\_release\_title                 | NZB/Torrent title                                                                                                             |

##### On Download/On Upgrade

| Environment Variable                   | Details                                                                                                                       |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| radarr\_eventtype                      | Download                                                                                                                      |
| radarr\_download\_id                   | The hash of the torrent/NZB file downloaded (used to uniquely identify the download in the download client), empty if missing |
| radarr\_download\_client               | NZB/Torrent downloader client, empty if missing                                                                               |
| radarr\_isupgrade                      | `True` when an existing file is upgraded, otherwise `False`                                                                   |
| radarr\_movie\_id                      | Internal ID of the movie                                                                                                      |
| radarr\_movie\_imdbid                  | IMDb ID for the movie                                                                                                         |
| radarr\_movie\_in\_cinemas\_date       | Cinema release date, empty if missing                                                                                         |
| radarr\_movie\_physical\_release\_date | Physical release date, empty if missing                                                                                       |
| radarr\_movie\_path                    | Full path to the movie                                                                                                        |
| radarr\_movie\_title                   | Title of the movie                                                                                                            |
| radarr\_movie\_tmdbid                  | TMDb ID for the movie                                                                                                         |
| radarr\_movie\_year                    | Release year of the movie                                                                                                     |
| radarr\_moviefile\_id                  | Internal ID of the movie file                                                                                                 |
| radarr\_moviefile\_relativepath        | Path to the movie file relative to the movie’ path                                                                            |
| radarr\_moviefile\_path                | Full path to the movie file                                                                                                   |
| radarr\_moviefile\_quality             | Quality name from Radarr                                                                                                      |
| radarr\_moviefile\_qualityversion      | 1 is the default, 2 for proper, 3+ could be used for anime versions                                                           |
| radarr\_moviefile\_releasegroup        | Release group, empty if missing                                                                                               |
| radarr\_moviefile\_scenename           | Original release name, empty if missing                                                                                       |
| radarr\_moviefile\_sourcepath          | Full path to the movie file that was imported                                                                                 |
| radarr\_moviefile\_sourcefolder        | Full path to the folder the movie file was imported from                                                                      |
| radarr\_deletedrelativepaths           | | separated list of files that were deleted to import this file                                                               |
| radarr\_deletedpaths                   | | separated list of full paths for files that were deleted to import this file                                                |

##### On Rename

| Environment Variable                   | Details                                 |
| -------------------------------------- | --------------------------------------- |
| radarr\_eventtype                      | Rename                                  |
| radarr\_movie\_id                      | Internal ID of the movie                |
| radarr\_movie\_imdbid                  | IMDb ID for the movie, empty if missing |
| radarr\_movie\_in\_cinemas\_date       | Cinema release date, empty if missing   |
| radarr\_movie\_path                    | Full path to the movie                  |
| radarr\_movie\_physical\_release\_date | Physical release date, empty if missing |
| radarr\_movie\_title                   | Title of the movie                      |
| radarr\_movie\_tmdbid                  | TMDb ID for the movie                   |
| radarr\_movie\_year                    | Release year of the movie               |

#### On Health Check

| Environment Variable           | Details                                              |
| ------------------------------ | ---------------------------------------------------- |
| radarr\_eventype               | HealthIssue                                          |
| radarr\_health\_issue\_level   | the type of health issue: Ok, Notice, Warning, Error |
| radarr\_health\_issue\_message | the message from the health issue                    |
| radarr\_health\_issue\_type    | the area that failed and triggered the health issue  |
| radarr\_health\_issue\_wiki    | the wiki url, empty if does not exist                |

#### On Test

When adding the script to Radarr and run ‘Test’ the script will be
invoked with the following parameters. The script should be able to
gracefully ignore any other eventtype

| Environment Variable | Details |
| -------------------- | ------- |
| radarr\_eventtype    | Test    |

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

The information from Radarr will not be added to
\(_ENV as one might expect but should be included in the [\)\_SERVER
variable\](https://secure.php.net/manual/en/reserved.variables.server.php).
A sample script to use this information to convert a file can be found
[here](https://gist.github.com/karbowiak/7fb38d346e368edc9d1a). \#\#\#\#
PowerShell \#\#\#\# Sample script using the Radarr environment variables
to create EDL files for all episodes is
[here](https://gist.github.com/RedsGT/e1b5f28e7b5b81e1e45378151e73ba5c).

Sample script to have Plex scan destination folder only and “analyze
deeply” the file. PSQLite needed to query the plex DB. Adjust folder
locations to match your setup.

This script will add the movie to plex and scan the destination folder
(it will not scan the entire library) {{\#spoiler:show=Powershell
Script|hide=Click to close|

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
root movie folder as set in Radarr, and will create a symlink in the
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

## Installing multiple Radarrs on Windows

This guide will show you how to run multiple instances of Radarr on
Windows using only one base installation. This guide was put together
using Windows 10; if you are using a previous version of Windows (7, 8,
etc.) you may need to adjust some things. This guide also assumes that
you have installed Radarr to the default directory, and your second
instance of Radarr will be called Radarr-4K. Feel free to change things
to fit your own installations, though.

### Prerequisites

  - You must have Radarr already installed. It is *highly* recommended
    that you use [the latest installer.exe
    file](https://github.com/Radarr/Radarr/releases).
  - You must have [NSSM (Non-Sucking Service Manager)](http://nssm.cc)
    installed. To install, download the latest release (2.24 at the time
    of writing) and copy either the 32-bit or 64-bit nssm.exe file to
    C:/windows/system32. (If you aren’t sure if you have a 32-bit or
    64-bit system, check Settings \> System \> About \> System type.)

### Configuring Radarr

1.  Open a Command Prompt administrator window. (To run as an admin,
    right click on the Command Prompt icon and choose “Run as
    administrator.”)
2.  If Radarr is running, stop the service by running `nssm stop Radarr`
    in Command Prompt.
3.  Now we have to edit the existing Radarr instance to explicitly point
    to its data directory. The default command is as follows:
    `sc config Radarr binpath= "C:\ProgramData\Radarr\bin\Radarr.exe
    -data=C:\ProgramData\Radarr"`

This command tells the original instance of Radarr to explicitly use
C:\\ProgramData\\Radarr for its data directory. If you didn't use the
default Radarr install, or if your data folder is somewhere else, you
may have to change your paths here.

### Creating Radarr-4K

4.  Create a new folder where you’d like Radarr-4K to live. I prefer all
    my instances in the same place, so my new folder is
    C:\\ProgramData\\Radarr-4K .
5.  Back in Command Prompt, create the new Radarr-4K service using `nssm
    install Radarr-4K`. A popup window will open where you can type your
    parameters for the new instance. For this example, we will use the
    following:
      - **Path:** C:\\ProgramData\\Radarr\\bin\\Radarr.exe
      - **Startup directory:** C:\\ProgramData\\Radarr\\bin
      - **Arguments:** -data=C:\\ProgramData\\Radarr-4K

Note that **Arguments** points to the *new* folder created in step 4.
This is crucial, as it keeps all the data files from both instances in
separate locations.

6.  Click *Install service*. The window should close and the service
    will now be available to run.

### Alternate Installation for running as user instead of service (enables UNC path mapping)

1.  Shut down and disable the current service if it is running
    1.  Start Menu, type services.msc
    2.  Right click on Radarr-4K and Disable
    3.  Right click on Radarr-4K and click Properties and choose
        Disabled
2.  Navigate to the Startup Folder for the current user (usually
    Users/username/AppData/Roaming/Microsoft/Start Menu/Startup)
3.  Right click and Create New Shortcut
4.  **Path:** C:\\ProgramData\\Radarr\\bin\\Radarr.exe
    -data=C:\\ProgramData\\Radarr-4K
5.  Give the shortcut a unique name such as Radarr-4K and finish the
    wizard.
6.  Double click the new shortcut to run and test.

### Configuring Radarr-4K

7.  Next we’ll need to configure the new service to use its own port,
    the entry for which is in a config.xml file. This file is created
    when you first run the service, so start up Radarr-4K with `nssm
    start Radarr-4K` in Command Prompt.
8.  Navigate to your new data directory (C:\\ProgramData\\Radarr-4K in
    this case) to see if the config.xml file is there. If it is, go
    ahead and stop Radarr-4K with `nssm stop Radarr-4K`. (Don’t worry,
    we’ll be starting it back up in a second.)
9.  Open the config.xml file using your preferred text editor. There
    should only be a handful of lines, but the important one is
    `<Port>7878</Port>`.

Since the first Radarr instance will occupy port 7878, the second
instance must use another available port, like 7879 or 17878. I prefer
the latter, so I changed the line to `<Port>17878</Port>`. Don’t change
anything else.

9.  After you’ve set a new port, save the file and close your text
    editor.
10. With both services fully installed and properly configured, you can
    now start them:
      - `nssm start Radarr` (accessible via <http://ip_address:7878>)
      - `nssm start Radarr-4K` (accessible via
        <http://ip_address:17878>)

#### Notes

  - Though this tutorial was tested using Command Prompt, it should work
    with Windows Terminal/Powershell as well. But, if you’re feeling
    cautious, just go with Command Prompt.
  - A previous version of this installation guide encouraged users to
    copy Radarr’s config.xml file to Radarr-4K’s data directory.
    However, you’ll run into trouble with this method, especially if you
    have authentication enabled. I’d recommend starting with a clean
    config.xml file, created when you start the service for the first
    time (Step 7).
  - If one Radarr instance is updated, both instances will shutdown and
    only the updated one will start again. To fix this, you will have to
    manually start the other instance, or you may want to look into
    using the below powershell script to address the problem until an
    official solution is found.
  - If you’re correcting a problematic installation, you may need to
    restore from one of Radarr’s many backups.

### Port Checker and Restarter PowerShell Script

When you use two Radarr instances and one of it is updating, it will
kill both instances ( by killing all running radarr.console.exe ). Only
the one which is updating will come back online.

To keep both online i made a powershell script which i run as a
scheduled task.

It checks the ports and if one is not online, it will (re-)start the
scheduled task to launch radarr.

Create a new File and name it `RadarrInstancesChecker.ps1` with the
below code.

{{\#spoiler:show=RadarrInstancesChecker.ps1|hide=Click two close|

``` powershell
################################################################################################
### RadarrInstancesChecker.ps1                                                               ###
################################################################################################
### Keeps multiple Radarr Instances up by checking the port                                  ###
### Please use Radarr´s Discord or Reddit for support!                                       ###
### https://github.com/Radarr/Radarr/wiki/Installing-Multiple-Instances-of-Radarr-on-Windows ###
################################################################################################
### Version: 1.1                                                                             ###
### Updated: 2020-10-22                                                                      ###
### Author:  reloxx13                                                                        ###
################################################################################################



### SET YOUR CONFIGURATION HERE ###
# Set your host ip and port correctly and use your service or scheduledtask names!

# (string) The type how Radarr is starting
# "Service" (default) Service process is used
# "ScheduledTask" Task Scheduler is used
$startType = "Service"

# (bool) Writes the log to C:\Users\YOURUSERNAME\log.txt when enabled
# $false (default)
# $true
$logToFile = $false


$instances = @(
    [pscustomobject]@{   # Instance 1
        Name='Radarr-V3';    # (string) Service or Task name (default: Radarr-V3)
        IP='192.168.178.12'; # (string) Server IP where Radarr runs (default: 192.168.178.12)
        Port='7873';         # (string) Server Port where Radarr runs (default: 7873)
    }
    [pscustomobject]@{   # Instance 2
        Name='Radarr-4K';    # (string) Service or Task name (default: Radarr-V3)
        IP='192.168.178.12'; # (string) Server IP where Radarr runs (default: 192.168.178.12)
        Port='7874';         # (string) Server Port where Radarr runs (default: 7874)
    }
    # If needed you can add more instances here...
    # [pscustomobject]@{   # Instance 3
        # Name='Radarr-3D';    # (string) Service or Task name (default: Radarr-3D)
        # IP='192.168.178.12'; # (string) Server IP where Radarr runs (default: 192.168.178.12)
        # Port='7875';         # (string) Server Port where Radarr runs (default: 7875)
    # }
)


### DONT CHANGE ANYTHING BELOW THIS LINE ###


###
# This function will write to a log file or in console output
###
function Write-Log {
    #Will write to C:\Users\YOURUSERNAME\log.txt
    
    Param(
        $Message,
        $Path = "$env:USERPROFILE\log.txt" 
    )

    function TS {Get-Date -Format 'hh:mm:ss'}
    
    #Console output
    Write-Output "[$(TS)]$Message"
    
    #File Output
    if($logToFile){
        "[$(TS)]$Message" | Tee-Object -FilePath $Path -Append | Write-Verbose
    }
}


Write-Log "START ====================="


$instances | ForEach-Object {
    Write-Log "Check $($_.Name) $($_.IP):$($_.Port)"
    
    $PortOpen = ( Test-NetConnection $_.IP -Port $_.Port -WarningAction SilentlyContinue ).TcpTestSucceeded 
    
    if (!$PortOpen) {
        Write-Log "Port $($_.Port) is closed, restart $($startType) $($_.Name)!"

        if($startType -eq "Service"){
            Get-Service -Name $_.Name | Stop-Service
            Get-Service -Name $_.Name | Start-Service
        }
        elseif($startType -eq "ScheduledTask"){
            Get-ScheduledTask -TaskName $_.Name | Stop-ScheduledTask
            Get-ScheduledTask -TaskName $_.Name | Start-ScheduledTask
        }
        else{
            Write-Log "[ERROR] STARTTYPE UNKNOWN! USE Service or ScheduledTask !"
        }
    }else{
        Write-Log "Port $($_.Port) is open!"
    }
}

Write-Log "END ====================="
```

}}Edit the script with your actual service names, IP, and ports. Create
a scheduled task to run the script on a repeating schedule.

  - Security Options: check Run with highest privileges (otherwise the
    script will be unable to manipulate services)
  - Trigger: On launch
  - Repeat task every: 5 or 10 minutes
  - Action: Start a Program
      - Program/script: `powershell`
      - Argument (with path to your script's location): `-File
        D:\RadarrInstancesChecker.ps1`

## Installing Multiple Versions on Linux

<h6>

Swizzin Users

</h6>

Go here: <https://github.com/ComputerByte/radarr4k>

<h6>

Other \*UNIX users

</h6>

Here's an example of a systemd for a 4K Instance (or second instance) of
Radarr. To do this, you'd need to create a second data folder; perhaps:
`mkdir ~/.config/radarr4k && chown youruser:youruser
~/.config/radarr4k`. Additionally, you'll need to stop any other
versions of  that may be running, as it can cause port issues. After
starting the 4K instance, wait for about 20 seconds, then stop the
service. Modify the port numbers and baseurl (if needed) in the
configuration.

`[Unit]`  
`Description=Radarr 4K`  
`After=syslog.target network.target`  
`[Service]`  
`# Change the user and group variables here.`  
`User=$userRadarrRunsas`  
`Group=$groupRadarrRunsas`  
`Type=simple`  
`# Change the path to Radarr here if it is in a different location for you.`  
`ExecStart=/opt/Radarr/Radarr -nobrowser --data=/path/to/second/config/dir`  
`TimeoutStopSec=20`  
`KillMode=process`  
`Restart=on-failure`  
`# These lines optionally isolate (sandbox) Radarr from the rest of the system.`  
`# Make sure to add any paths it might use to the list below (space-separated).`  
`#ReadWritePaths=/opt/Radarr /path/to/movies/folder`  
`#ProtectSystem=strict`  
`#PrivateDevices=true`  
`#ProtectHome=true`  
`[Install]`  
`WantedBy=multi-user.target`
