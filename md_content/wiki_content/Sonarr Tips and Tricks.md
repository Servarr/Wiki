TRaSH\'s Custom Formats
-----------------------

[TRaSH\'s Guides](https://trash-guides.info/Radarr/)

Converting DB paths from Windows to Linux with SQL commands
-----------------------------------------------------------

***This document is to provide a guide for users who want to move their
Sonarr from Windows to Linux, while maintaining all data from the
Windows setup.***

### DISCLAIMER

I am by no means an expert when it comes to SQL or databases. This guide
is a use at your own risk, and I recommend making a copy of sonarr.db
with a backup or two.

This process can likely be scripted via Python, or some other language,
however I do not posses that skill.

This is the process that I went through during my configuration change,
your mileage may vary.

### Conversion guide

Make sure Sonarr is not running on the Linux Machine prior to copying
the Database over.

The first thing that you will need to download is a copy of SQLite here
is the [link](https://github.com/pawelsalawa/sqlitestudio/releases) to
the one that I used(SQLiteStudio-3.2.1.zip (portable))

Generally the Sonarr DB file is located at: `C:\ProgramData\Sonarr` (Or
you can find the path in Sonarr by going to System \> Status \> About

Once you have SQLite open you will be met with a screen similar to the
one below. You will click to \"Add a Database\", and add the
\*\*COPY\*\* of your `sonarr.db` file. The database should then show up
in the list as it does in the image below, from there you will need to
click on \"Connect to the Database\"

![](Sqliteopen.PNG "Sqliteopen.PNG"){width="750"}

Now that you have the database added and connected you should see the
same as the image below. I have highlighted the main areas that I had to
go through to remove \"Windows paths\" to make it \"Linux compatible\"
(Series, EpisodeFiles, ExtraFiles, SubtitleFiles, and RootFolders)

![](DatabaseEdit.PNG "DatabaseEdit.PNG"){width="750"}

If you double click on any of the following Series, EpisodeFiles,
ExtraFiles, SubtitleFiles, and RootFolders, you can see what is in the
database for that section (This will be important for later). In the
example below \"Path\" is the identifier in the table \"Series\" this is
where you will see the path where all of your Sonarr shows are listed,
and is what we will be modifying.

![](SeriesExample.PNG "SeriesExample.PNG"){width="750"}

If you go to \"Tools\" at the top \> \"Open SQL editor\" (ALT+E
shortcut) you will see the following screen. The SQL editor is where we
will be making most of the changes. I\'d advise on scrolling through
\"Series\" \> \"Path\" to compare changes and see if anything was missed
after running the command.

The command you will edit and run to change the path of where all shows
are listed are as follows between START and END (Do not include the
words START and END).

Replace the following sections as follows (the path typed out is case
sensitve, and you may have to run this command with minor changes to get
everything updated correctly:

`\\169.254.0.1\Media\Download Complete\TV Shows\` - Both sections as
listed below will need to be changed to the main location of all of your
shows. You will edit the section in between the single quotes. Make sure
you leave the \\ at the end of your path.

`%\\169.254.0.1\Media\Download Complete\TV Shows\%` - You will replace
all data in between the single quotes and % with your main location of
all of your shows as you did in the step prior to this (both \'\' and %%
are needed in this section.) Make sure you leave the \\ at the end of
your path.

`/home/username/mnt/share/media/DownloadComplete/tv/shows/` - This
section will be the new path where all of your shows will be listed
after the migration. You will replace everything inside of the single
quotes, but make sure you leave the / at the end.

\-\--START\-\--

`update Series set Path = replace(Path, '\\169.254.0.1\Media\Download Complete\TV Shows\', '/home/username/mnt/share/media/DownloadComplete/tv/shows/')`
`where Path like '%\\169.254.0.1\Media\Download Complete\TV Shows\%'`

\-\--END\-\--

So in this example, my shows were listed on a NAS device but this will
be wherever your show paths are listed ie.
`C:\Users\USERNAME\Documents\...` if storage is on the same device as
Sonarr.

So in this example my path for shows was
`\\169.254.0.1\Media\Download Complete\TV Shows\Name Of Show`

So what this command will do will replace
`\\169.254.0.1\Media\Download Complete\TV Shows\` to
`/home/username/mnt/share/media/DownloadComplete/tv/shows/`

This will only replace up to Name of Show so the end result would be
`home/username/mnt/share/media/DownloadComplete/tv/shows/Name Of Show`

![](SqlEdit.PNG "SqlEdit.PNG"){width="750"}

The hard should be mostly over. Now we just have to clean up any Windows
file path \\\'s to Linux file path /\'s

You will clear out the code where you made the changes in the last step,
and enter these one by one.

(NOTE) I did not include screenshots of this process as it is just a
matter of running the commands one by one, then opening the EpisodeFiles
Table, selecting Data, and seeing if there are any \\\'s listed in the
data or if they have been changed to /\'s (END NOTE)

\-\--START\-\--

`update EpisodeFiles set RelativePath = replace(RelativePath, '\', '/')`\
\
`update ExtraFiles set RelativePath = replace(RelativePath, '\', '/')`\
\
`update SubtitleFiles set RelativePath = replace(RelativePath, '\', '/')`

\-\--END\-\--

In my case Episodefiles, ExtraFiles, and SubtitleFiles the only changes
I had to make was to replace \\\'s with /\'s.

All that is left now is RootFolders which I just edited manually as I
did not have many RootFolders.

To change the Path of RootFolders, you will right click and select
\"Edit value in editor\" This you will just enter your new path. (be
sure to include the / at the end of your path, as this will be needed
for future shows added to Sonarr.))

Once you have made all of the changes you will click \"Commit Changes\"
(the green checkbox)

![](RootFolders.png "RootFolders.png"){width="750"}

\
Finally the end\....

After you have finished your last changes and committed the changes, you
are done, just click \"Disconnect from this Database\" (Unplug symbol
next to where we connected to the Database)

Make sure Sonarr is not running on the Linux Machine prior to copying
the Database over.

Then you just copy Sonarr.db to it\'s new home, and start Sonarr.

====\'\'\'

### Accreditation

Walkthough Guide created and provided by Justin(BitHawkGaming)
Update/change as needed

Custom Post Processing Scripts
------------------------------

If you're looking to trigger a custom script in your download client to
tell Sonarr when to update, you can find more details here. Scripts are
added to Sonarr via the *Connect* Settings page.

### Overview

Sonarr can execute a custom script when an episode is newly imported or
renamed and depending on the action, different parameters are supplied.
They are passed to the script through environment variables which allows
for more flexibility in what is sent to the script and in no particular
order.

### Environment Variables

##### On Grab

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| sonarr\_eventtype                 | Grab                              |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_id                | Internal ID of the series         |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_title             | Title of the series               |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_tvdbid            | TVDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_tvmazeid          | TVMaze ID for the series          |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_imdbid            | IMDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_type              | Type of the series, Anime, Daily  |
|                                   | or Standard                       |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_episodecount     | Number of episodes in the release |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_seasonnumber     | Season number from release        |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_episodenumbers   | , separated list of episode       |
|                                   | numbers                           |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_absoluteepisoden | , separated list of absolute      |
| umbers                            | episode numbers                   |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_episodeairdates  | , separated list of Air date from |
|                                   | original network                  |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_episodeairdatesu | , separated list of Air Date with |
| tc                                | Time in UTC                       |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_episodetitles    | \| separated list of episode      |
|                                   | titles                            |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_title            | NZB/Torrent title                 |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_indexer          | Indexer where the release was     |
|                                   | grabbed                           |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_size             | Size of the release reported by   |
|                                   | the indexer                       |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_quality          | Quality name of the release as    |
|                                   | detected by Sonarr                |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_qualityversion   | 1 is the default, 2 for proper,   |
|                                   | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| sonarr\_release\_releasegroup     | Release Group, will be empty if   |
|                                   | it is unknown                     |
+-----------------------------------+-----------------------------------+
| sonarr\_download\_client          | download client, will be empty if |
|                                   | it is unknown                     |
+-----------------------------------+-----------------------------------+
| sonarr\_download\_id              | The hash of the torrent/NZB file  |
|                                   | downloaded (used to uniquely      |
|                                   | identify the download in the      |
|                                   | download client)                  |
+-----------------------------------+-----------------------------------+

#### On Download/On Upgrade

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| sonarr\_eventtype                 | Download                          |
+-----------------------------------+-----------------------------------+
| sonarr\_isupgrade                 | `True` when an an existing file   |
|                                   | is upgraded, otherwise `False`    |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_id                | Internal ID of the series         |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_title             | Title of the series               |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_path              | Full path to the series           |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_tvdbid            | TVDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_tvmazeid          | TVMaze ID for the series          |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_imdbid            | IMDB ID for the series, empty if  |
|                                   | not available                     |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_type              | Type of the series, Anime, Daily  |
|                                   | or Standard                       |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_id           | Internal ID of the episode file   |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodecount | Number of episodes in the file    |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_relativepath | Path to the episode file relative |
|                                   | to the series' path               |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_path         | Full path to the episode file     |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodeIDs   | Internal ID(s) of the episode     |
|                                   | file                              |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_seasonnumber | Season number of episode file     |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodenumbe | , separated list of episode       |
| rs                                | numbers                           |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodeairda | , seperated list of Air dates     |
| tes                               | from original network             |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodeairda | , seperated list of Air Date with |
| tesutc                            | Time in UTC                       |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodetitle | \| separated list of episode      |
| s                                 | titles                            |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_quality      | Quality name of the Episode from  |
|                                   | Sonarr                            |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_qualityversi | 1 is the default, 2 for proper,   |
| on                                | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_releasegroup | Release group, will be empty if   |
|                                   | unknown                           |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_scenename    | Original release name, will be    |
|                                   | empty if unknown                  |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_sourcepath   | Full path to the episode file     |
|                                   | that was imported from            |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_sourcefolder | Full path to the folder the       |
|                                   | episode file was imported from    |
+-----------------------------------+-----------------------------------+
| sonarr\_download\_client          | download client, will be empty if |
|                                   | it is unknown                     |
+-----------------------------------+-----------------------------------+
| sonarr\_download\_id              | The hash of the torrent/NZB file  |
|                                   | downloaded (used to uniquely      |
|                                   | identify the download in the      |
|                                   | download client)                  |
+-----------------------------------+-----------------------------------+
| sonarr\_deletedrelativepaths      | \| separated list of files that   |
|                                   | were deleted to import this file  |
+-----------------------------------+-----------------------------------+
| sonarr\_deletedpaths              | \| separated list of full paths   |
|                                   | for files that were deleted to    |
|                                   | import this file                  |
+-----------------------------------+-----------------------------------+

#### On Rename

  Environment Variable       Details
  -------------------------- ------------------------------------------------
  sonarr\_eventtype          Rename
  sonarr\_series\_id         Internal ID of the series
  sonarr\_series\_title      Title of the series
  sonarr\_series\_path       Full path to the series
  sonarr\_series\_tvdbid     TVDB ID for the series
  sonarr\_series\_tvmazeid   TVMaze ID for the series
  sonarr\_series\_imdbid     IMDB ID for the series, empty if not available
  sonarr\_series\_type       Type of the series, Anime, Daily or Standard

#### On Episode File Delete

+-----------------------------------+-----------------------------------+
| Environment Variable              | Details                           |
+===================================+===================================+
| sonarr\_eventtype                 | EpisodeDeleted                    |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_id                | Internal ID of the series         |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_title             | Title of the series               |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_path              | Full path to the series           |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_tvdbid            | TVDB ID for the series            |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_tvmazeid          | TVMaze ID for the series          |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_imdbid            | IMDB ID for the series, empty if  |
|                                   | not available                     |
+-----------------------------------+-----------------------------------+
| sonarr\_series\_type              | Type of the series, Anime, Daily  |
|                                   | or Standard                       |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_id           | Internal ID of the episode file   |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodecount | Number of episodes in the file    |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_relativepath | Path to the episode file relative |
|                                   | to the series' path               |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_path         | Full path to the episode file     |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodeIDs   | Internal ID(s) of the episode     |
|                                   | file                              |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_seasonnumber | Season number of episode file     |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodenumbe | , separated list of episode       |
| rs                                | numbers                           |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodeairda | , seperated list of Air dates     |
| tes                               | from original network             |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodeairda | , seperated list of Air Date with |
| tesutc                            | Time in UTC                       |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_episodetitle | \| separated list of episode      |
| s                                 | titles                            |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_quality      | Quality name of the Episode from  |
|                                   | Sonarr                            |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_qualityversi | 1 is the default, 2 for proper,   |
| on                                | 3+ could be used for anime        |
|                                   | versions                          |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_releasegroup | Release group, will be empty if   |
|                                   | unknown                           |
+-----------------------------------+-----------------------------------+
| sonarr\_episodefile\_scenename    | Original release name, will be    |
|                                   | empty if unknown                  |
+-----------------------------------+-----------------------------------+

#### On Series Delete

  Environment Variable           Details
  ------------------------------ --------------------------------------------------------------------------
  sonarr\_eventtype              SeriesDeleted
  sonarr\_series\_id             Internal ID of the series
  sonarr\_series\_title          Title of the series
  sonarr\_series\_path           Full path to the series
  sonarr\_series\_tvdbid         TVDB ID for the series
  sonarr\_series\_imdbid         IMDB ID for the series
  sonarr\_series\_type           Type of the series, Anime, Daily or Standard
  sonarr\_series\_deletedfiles   `True` when the delete files option has been selected, otherwise `False`

#### On Health Issue

  Environment Variable             Details
  -------------------------------- ------------------------------------------------------
  sonarr\_eventype                 HealthIssue
  sonarr\_health\_issue\_level     the type of health issue: Ok, Notice, Warning, Error
  sonarr\_health\_issue\_message   the message from the health issue
  sonarr\_health\_issue\_type      the area that failed and triggered the health issue
  sonarr\_health\_issue\_wiki      the wiki url, empty if does not exist

#### On Test

When adding the script to Sonarr and run 'Test' the script will be
invoked with the following parameters. The script should be able to
gracefully ignore any other eventtype

  Environment Variable   Details
  ---------------------- ---------
  sonarr\_eventtype      Test

### Arguments

Arguments is no longer supported in Sonarr v3, point to the script
directly.

### Specific usage tips

#### PHP

The information from Sonarr will not be added to
$_ENV as one might expect but should be included in the [https://secure.php.net/manual/en/reserved.variables.server.php$\_SERVER
variable\]. A sample script to use this information to convert a file
can be found
[here](https://gist.github.com/karbowiak/7fb38d346e368edc9d1a).
**PowerShell** Sample script using the Sonarr environment variables to
create EDL files for all episodes is
[here](https://gist.github.com/RedsGT/e1b5f28e7b5b81e1e45378151e73ba5c).\
**Reverse Symlinking** For those moving from Medusa this [seems to work
well](https://github.com/Sonarr/Sonarr/wiki/Reverse-symlink-script-for-Connect)
