---
title: Readarr Settings
description: 
published: true
date: 2021-11-14T17:35:39.767Z
tags: readarr, settings
editor: markdown
dateCreated: 2021-05-27T16:47:28.054Z
---

## Media Management

### Root Folders

- A list of your configured Root Folders (Library Folders) is displayed.
- Click the <kb>+</kb> button to add a new Root Folder or click an existing's card to edit it.

#### Root Folder Settings

- Name - The name of the Root Folder for UI Purposes
- Path - The folder containing your book library i.e. the final destination as Readarr sees it. Note that this must be different than the location your download client places files.
- Calibre Specific Settings (Only if Use Calibre is enabled)
  - Use Calibre - Enable / Disable the use of Calibre Content Server to manage your Root Folder.
    - Note that this **cannot be enabled on an existing root folder**.
    - Note that this **cannot be disabled on an existing Calibre enabled root folder**.
    - Note that this requires **Calibre Content Server** and will not work with Calibre Web nor Calibre.
    - Note that this requires that Calibre to have `Require username and password to access the content server` to ne enabled.
      - Failure to do so will result in an error of `Anonymous users are not allowed to make changes`
  - Calibre Host - The IP/domain of the host of the Calibre Content Server
  - Calibre Port - The Port that Calibre Content Server is listening on
  - (Advanced) Calibre URL Base - Add a prefux to the Calibre URL e.g. http://[host]:[port]/[urlBase]
  - Calibre Username - Username to use to access Calibre Content Server 
  - Calibre Password - Password to use to access Calibre Content Server
  - Calibre Library - Calibre Content Server library name. Leave blank for default
  - Convert to Format - (Optional) Ask Calibre Content Server to convert to other formats with a comma separated list. 
    - Review the (i) icon within the app for a current list of options. 
    - Options are: MOBI, EPUB, AZW3, DOCX, FB2, HTMLZ, LIT, LRF, PDB, PDF, PMLZ, RB, RTF, SNB, TCR, TXT, TXTZ, ZIP
  - Calibre Output Profile - Select the Calibre Content Server Output Profile to use
    - The output profile tells the Calibre Content Server conversion system how to optimize the created document for the specified device (such as by resizing images for the device screen size). In some cases, an output profile can be used to optimize the output for a particular device, but this is rarely necessary.
  - Use SSL - Enable or Disable the use of SSL (HTTPS) for Calibre Content Server
- Monitor - Configure your monitoring options for books detected in this folder
  - All Books - Monitor all books
  - Future Books - Monitor books that have not released yet
  - Missing Books - Monitor books that do not have files or have not released yet
  - Existing Books - Monitor books that have files or have not released yet
  - First Book - Monitor the first book. All other books will be ignored
  - Latest Book - Monitor the latest book and future books
  - None - No books will be monitored unless explictly added
- Quality Profile - Default Quality Profile for books and authors detected within this folder
- Metadata Profile - Select the Metadata Profile to use for authors detected in this folder.  To only load books that were explictly added or detected select None.
- Default Readarr Tags - Default tags for authors detected within this folder
  

### Remote Path Mappings

- Remote Path Mapping acts as a dumb find Remote Path and replace with Local Path This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client or Calibre are not on the same server.

![bookfilenaming.png](/assets/readarr/bookfilenaming.png)

If you are using Calibre integration, you do not get to name book files. Calibre takes care of this for you. You should only change these settings if you are not using Calibre.

> Please note that while Readarr is in beta; if you use Calibre it is recommended to disable Renaming in Readarr just in case an unintended bug slips through. `{.is-info}

Commonly used naming schema are:

- Standard Book Format
  - `{Book Title}\{Author Name}` - `{Book Title}` which would then output a folder named `Cujo`, and a subdirectory containing a file with the name `Stephen King - Cujo.m4b`

- Author Folder Format
  - `{Author Name}` which would then output: `Stephen King`

### Book Naming

- Rename Books - If this is toggled off (no check in the box) Readarr will use the existing file name if renaming is disabled.

> If you leave Rename Books unchecked, then none of the naming stuff below applies - you have told Readarr you do not want any renaming done at all. The book will be imported directly into the author folder.
{.is-info}

- Replace Illegal Characters - If disabled Readarr will remove illegal characters. If enabled Readarr will replace illegal characters. Examples include `\ # / $ * < >` and more.

#### Standard Book Format

- Here you will select the naming convention for your books

- Dropdown Box (upper right corner)
  - Left Box - Space Handling
    - `Space ( )` - Use spaces in naming (Default)
    - `Period (.)` - Use periods in lieu of spaces in naming
    - `Underscore (_)` - Use underscores in lieu of spaces in naming
    - `Dash (-)` - Use dashes in lieu of spaces in naming
  - Right Box - Case Handling
    - `Default Case` - Make title uppercase and lowercase (~camelcase) (Default)
    - `Uppercase` - Make title all uppercase
    - `Lowercase` - Make title all lowercase

#### Author

- `{Author Name}` = Author's Name
- `{Author NameThe}` = Author's Name, The
- `{Author CleanName}` = Authors Name
- `{Author SortName}` = Name, Author
- `{Author Disambiguation}` = Author Name (disambiguation used from GoodReads for multiple authors with the same name)

#### Book

- `{Book Title}` = The Book's Title!: Subtitle!
- `{Book TitleThe}` = Book's Title!, The: Subtitle!
- `{Book CleanTitle}` = The Books Title: Subtitle
- `{Book TitleNoSub}` = The Book's Title!
- `{Book TitleTheNoSub}` = Book's Title!, The
- `{Book CleanTitleNoSub}` = The Books Title
- `{Book Subtitle}` = Subtitle!
- `{Book SubtitleThe}` Subtitle!, The
- `{Book CleanSubtitle}` = Subtitle
- `{Book Disambiguation}` = Book Name! (disambiguation title used from GoodReads)
- `{PartNumber:0}` or `{PartNumber:0}` = 2
- `{PartNumber:00}` = 02
- `{PartCount}` or `{PartCount:0} = 9
- `{PartCount:00}` = 09

#### Release Date

- `{Release Year}` = 2016
- `{Release YearFirst}` = 2015
- `{Edition Year}` = 2016

#### Quality

- `{Quality Full}` = AZW3 Proper
- `{Quality Title}` = AZW3

#### Media Info

- `{MediaInfo AudioCodec}` = MP3
- `{MediaInfo AudioChannels}` = 2.0
- `{MediaInfo AudioBitRate}` = 320kbps
- `{MediaInfo AudioBitsPerSample}` = 24bit
- `{MediaInfo AudioSampleRate}` = 44.1kHz

#### Other

- `{Release Group}` = Rls Grp
- `{Preferred Words}` = iNTERNAL

#### Original

- `{Original Title}` = Author.Name.Book.Name.2018.AZW3-EVOLVE
- `{Original Filename}` = 01-book name

> Original Filename is not recommended. It is the literal original filename and may be obfuscated t1i0p3s7i8yuti. Original Title is the release name and should be used instead.
{.is-info}
  
### Author Folder Format

- (Advanced Option) This is where you will set the naming convention for the author folder name.

#### Author

- `{Author Name}` = Author's Name
- `{Author NameThe}` = Author's Name, The
- `{Author CleanName}` = Authors Name
- `{Author SortName}` = Name, Author
- `{Author Disambiguation}` = Author Name (disambiguation used from GoodReads for multiple authors with the same name)

### Folders
  
![mm_folders.png](/assets/readarr/mm_folders.png)
  
- (Advanced Option) Create empty author folders - Select the box to create empty author folders when a new author is added.
- (Advanced Option) Delete empty author folders -  Select the box to delete empty author folders if there are no books in it.
  
> One of those boxes can be checked, but they should not BOTH be checked.
  
![mm_importing.png](/assets/readarr/mm_importing.png)
  
- (Advanced Option) Skip Free Space Check - If enabled skip checking free space prior to importing
- (Advanced Option) Minimum Free Space - Enter the minimum free space for the drive to have before importing stops.
- (Advanced Option) Use Hardlinks instead of Copy - Check this box to use Hardlinks instead of Copies (for Torrents). Note that this is enabled by default.
  
> You should ideally use this wherever possible. In order for hardlinks to be used, you must have your source/destination on the same file system (drive, partition) and mount points.
  
- Import Extra Files - If enabled import specified extra files located within the folder of the book when its imported
- (Advanced Option) Import Extra Files - If Import Extra Files is enabled enter a comma separated list of extensions to import.

> If you are using Readarr for audiobooks, you should add .cue to this list, as it holds your chapter information!
  
### File Management
  
  ![mm_filemgmt.png](/assets/readarr/mm_filemgmt.png)

- Ignore Deleted Books - Check this box to unmonitor books detected as deleted or inacessible from Readarr's root folder.
- Download Proper & Repacks - Whether or not to automatically upgrade to Propers/Repacks. Use `Do not Prefer` to sort by preferred word score over propers/repacks
  - Prefer and Upgrade - Rank repacks and propers higher than non-repacks and non-propers. Treat new repacks and propers as upgrade to current releases.
  - Do Not Upgrade Automatically - Rank repacks and propers higher than non-repacks and non-propers. Do not treat new repacks and propers as upgrade to current releases.
  - Do Not Prefer - Effectively this ignores repacks and propers. You'll need to manage any preference for those with [Preferred Words](#release-profiles).
- > `PROPER` - means there was a problem with the previous release. Downloads tagged as PROPER shows that the problems have been fixed in that release. This is done by a Group that did not release the original. {.is-info}
- > `REPACK` - means there was a problem with the previous release and is corrected by the original Group. Downloads tagged as REPACK shows that the problems have been fixed in that release. This is done by a Group that did release the original.{.is-info}

- (Advanced Option) Watch Root Folders for file changes - Check this box to trigger a rescan when it is detected that the root folder had changes.
- (Advanced Option) Rescan Author Folder after Refresh -  Choose when to rescan an author folder after refreshing the author.
  - Always - This will rescan author folders based upon Tasks Schedule
  - After Manual Refresh - You will have to manually rescan the disk
  - Never - Just as it says, never rescan the author folders.
- (Advanced Option) Allow Fingerprinting - Choose how to handle fingerprinting, which allows increased accuracy for book matching, at the expense of CPU/disk time.
  - Always - Always use fingerprinting if possible
  - For new imports only - Only fingerprint newly imported releases
  - Never - Just as it says, never use fingerprinting
- (Advanced Option) Change File Date - Change file date on import/rescan
  - None - Readarr will not change the date that shows in your given file browser
  - Book Release Date - The date the book was released.
- (Advanced Option) Recycling Bin - Book files will go here when deleted instead of being permanently deleted
- (Advanced Option) Recycling Bin Cleanup - This is how old a given file can be before it is deleted permanently

> It is highly recommended that you use a Recycling Bin. It's easy to delete files, and recovering them is easy if you use the bin.

## Permissions

- Set Permissions - Should `chmod` be run when files are imported/renamed?
  - chmod Folder - Octal, applied during import/rename to media folders and files (without execute bits)

> The drop down box has a preset list of very commonly used permissions that can be used. However, you can manually enter a folder octal if you wish.
{.is-info}

> This only works if the user running `Readarr` is the owner of the file. It's better to ensure the download client sets the permissions properly.{.is-warning}

- chown Group - Group name or GID. Use GID for remote file systems

> This only works if the user running `Readarr` is the owner of the file. It's better to ensure the download client sets the permissions properly.{.is-warning}

## Profiles

### Quality Profiles

Quality profiles are used to determine what formats of books are acceptable for a book in your library.
  
![qualityprofile.png](/assets/readarr/qualityprofile.png)

- Set profiles for the quality of books you're looking to download.

> When selecting an existing profile or adding an additional profile a new window will appear{.is-info}

> Note: The quality which has a blue box is the quality at which any media with this profile will continue to be upgraded to.
{.is-info}

- Plus icon (<kb>+</kb>) - Create a new quality profile

- Name - Select a **UNIQUE** name for the quality profile you are creating
- Upgrades Allowed - When this option is checked and you tell Readarr to download a `EPUB` as it is the first release of a specific book then later somebody is able to upload a `AZW3` Readarr will automatically upgrade to the better quality ***if*** `Upgrade Until` has that quality selected
  - Upgrade Until - Once this quality is reached Readarr will no longer download movies

> Note: This is only applicable if you have `AZW3` higher than `EPUB` within the `Qualities` section
{.is-warning}

- Qualities - Qualities higher in the list are more preferred. Qualities within the same group are equal. Only checked qualities are wanted.
  - Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases. Prime example of this is `WebDL` and `WebRip` as these are very similar and typically have similar bitrates. When editing the groups you can change the preference within each of the groups.

  - [See Qualities](#qualities-defined)

> By default the qualities are set from lowest (bottom) to highest (top)
{.is-info}

### Metadata Profiles

Metadata profiles are used to determine which books from GoodReads to add under an author when a new author is added.

![metaprofiles.png](/assets/readarr/metaprofiles.png)
  
- Enter a name for this profile.
- Enter the minimum popularity for a book to be added for an author.

> Setting this too high will result in books not being added to Readarr, but setting it too low will result in obscure publications showing up.

- Enter the minimum number of pages a book must have to be added for an author.
- Check this box to skip books with a missing release date.
- Check this box to skip books that do not contain either an ISBN or ASIN number.
- Check this box to skip part books and sets.
- Check this box to skip secondary series books.
- Enter a comma-separated list of allowed languages for your books.
- Enter words or phrases that a book title must not contain in order to be added.
  
> You may create multiple metadata profiles, and apply a separate one to each author as needed. But, you may only apply a single metadata profile to any given author.
  
### Release Profiles

Release profiles are used to determine if indexer release names qualify for downloading.

![releaseprofiles.png](/assets/readarr/releaseprofiles.png)  
  
- Check the box to enable this profile.
- Add a list of words or phrases that MUST be in the release name in order to be considered valid.
- Add a list of words or phrases that MUST NOT be in the release name in order to be considered valid.
- Here you can add terms or regexes with scores (positive and negative) to be considered more or less preferable. For example, you may prefer "unabridged" with a positive score.
  
> Preferred words with a higher score than were originally grabbed are ALWAYS an upgrade!
  
- Check this box to include your preferred words in the `{Preferred Words}` file naming assignment token.
  
> You should include `{Preferred Words}` in your file naming, and check this box if you're using them, because otherwise you can end up in a download loop.

- In this drop-down, you can limit this release profile to a single indexer.
- Enter a tag here, to be able to apply this tag to authors with the same tag. If you do not apply a tag here, then this profile applies to ALL authors.

## Quality

![qualitydefinitions.png](/assets/readarr/qualitydefinitions.png)

Here you can adjust your size limits for the various types of books you want. The defaults are probably good, you should not really need to adjust them.

## Indexers

> Information on supported indexers can be found [here](/readarr/supported#indexers)
{.is-info}

Indexers are how Readarr searches for books. You must have at least one for the program to function. Before we get into how to add them, there are some options at the bottom of the page:
![indexeroptions.png](/assets/readarr/indexeroptions.png)

- Set the minimum age in minutes for usenet indexers to wait before downloading a book. This allows all articles to propagate to avoid failures for brand new files.
- Set the HARD LIMIT maximum size for anything Readarr grabs.

> It is very much recommended that you do NOT set this value. It overrides all size limits you set in Quality!

- Retention is the maximum number of days old something can be on your indexers. If you set it to 300, and something is 301 days old, it will not be grabbed.
- (Advanced Option) RSS Sync Interval is the number of minutes between RSS grabs from each of your indexers. Set it higher to reduce API hits, set it lower to grab things quicker. Setting it too low can result in bans from your indexers!

### Adding an indexer

To add an indexer, click the `+` symbol.

There are some preconfigured indexers available, but mostly you will be using Custom Newznab (for usenet) or Custom Torznab (for torrents) setups.

![addindexer.png](/assets/readarr/addindexer.png)

- Enter a name for this indexer.

- Check this box if you want this indexer to be used for the periodic RSS feed pulls. If you do not check this box, it will only be used for searches if those boxes are checked!
- Check this box to enable automatic searches (the magnifying glass).
- Check this box to enable interactive searches (the person icon).
- Enter the URL of your indexer (including the `https://`)
- (Advanced Option) A few indexers have a non-standard API path. Change this if necessary.
- Enter the API Key from your indexer's profile page here. Do not share this API key with anyone, and blur it out of any screenshots.
- The Categories here are pulled automatically from a "caps" (capabilities) call to your indexer when you Test, but they can be modified here.
- (Advanced Option) If you enter a number here, this is the number of days before a book's release that Readarr will grab a book.
- (Advanced Option) You can add additional Newznab parameters here as needed for this indexer.
- (Advanced Option) You can set the indexer's priority here from 1-50 (1 being highest). This will be a deciding factor in where downloads are grabbed from if they are identical releases.

Then click `Test`, and if you get a green checkmark, you can `Save` the indexer and you're ready to go. Repeat as necessary for the indexers you want to add.

> If it doesn't test successfully, you will need to review your logs to see what's wrong and fix it. You cannot add an indexer if that indexer is currently down.

## Download Clients

> Information on supported download clients can be found [here](/readarr/supported#download-clients)
{.is-info}

### Overview

- Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn't one right setup and everyone's setup can be a little different. But there are many wrong setups.

### Download Client Processes

#### Usenet Process

- Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: books, tv, series, music, ect.
- Readarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Readarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Readarr
- Readarr will scan that completed file location for files that Readarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Readarr will fall back and copy the file then delete from the source which is IO intensive.

#### Torrent Process

- Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings. Examples: books, tv, series, music, ect.
- Readarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Readarr under the specific download client). When files are imported to your media folder Readarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Readarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Readarr's settings, Readarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

### Download Clients

Click on `Settings =>`Download Clients`, and then click the <kb>+</kb> to add a new download client. Your download client should already be configured and running.

#### Supported Download Clients

- A list of supported download clients is located [here](/readarr/supported#downloadclient)

Select the download client you wish to add, and there will be a pop-up box to enter connection details.  These details are similar for most clients. Some will ask for a username or password, some will ask for whether to add new downloads in a paused/start state, etc.

#### Usenet Client Settings

- Name - The name of the download client within Readarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- API Key - the API key to authenticate to your client
- Username - the username to authenticate to your client (typically not needed)
- Password- the password to authenticate to your client (typically not needed)
- Category - the category within your download client that Readarr will use
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Client Priority - Priority of the download Client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

#### Torrent Client Settings

- Name - The name of the download client within Readarr
- Enable - Enable this Download Client
- Host - The URL of your download client
- Port - The port of your download client
- Use SSL - Use a secure connection with your download client. Please be aware of this common mistake.
- URL Base - Add a prefix to the url; this is commonly needed for reverse proxies.
- Username - the username to authenticate to your client
- Password- the password to authenticate to your client
- Category - the category within your download client that Readarr will use
- Post-Import Category - the category to set after the release is downloaded and imported. Please note that this breaks completed download handling removal.
- Recent Priority - download client priority for recently released media
- Older Priority - download client priority for media released not recently
- Initial State - Initial state for torrents
- Client Priority - Priority of the download Client. Round-Robin is used for clients of the same type (torrent/usenet) that have the same priority.

#### Torrent Client Remove Download Compatibility

- Readarr is only able to set the seed ratio/time on clients that support setting this value via their API when the torrent is added. See the table below for client compatibility.

|      Client       | Ratio |      Time      |
| :---------------: | :---: | :------------: |
|      Deluge       |  Yes  |       No       |
|     Hadouken      |  No   |       No       |
|    qBittorrent    |  Yes  |      Yes       |
|     rTorrent      |  No   |       No       |
| Torrent Blackhole |  No   |       No       |
| Download Station  |  No   |       No       |
|   Transmission    |  Yes  | *Idle Limit*\* |
|     uTorrent      |  Yes  |      Yes       |
|       Vuze        |  Yes  |      Yes       |

> *Idle Limit* - Transmission internally has an Idle Time check, but Readarr compares it with the seeding time if the idle limit is set on a per-torrent basis. This is done as workaround to Transmission’s api limitations.{.is-info}

### Completed Download Handling

- Completed Download Handling is how Readarr imports media from your download client to your series folders. Many common issues are related to bad Docker paths and/or other Docker permissions issues.

- Enable (Advanced Global Setting) - Automatically import completed downloads from the download client
- Remove (Per Client Setting) - Remove completed downloads when finished (usenet) or stopped/complete (torrents)

#### Remove Completed Downloads

- Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
- Readarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Readarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
- Readarr will scan that completed file location for video files. It will parse the video file name to match it to an book. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
- Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

- Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Readarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
- If the "Completed Download Handling - Remove" option is enabled in settings, Readarr will ask the torrent client to delete the original file and torrent, but this will only occur if the client reports that seeding is complete, the seed goal reached is supported by Readarr, and torrent is paused (stopped).

#### Failed Download Handling

- Failed Download Handling is only compatible with SABnzbd and NZBGet.
- Failed Downloading Handling does not apply to Torrents nor is their plans to add such functionality.

- There are several components that make up the failed download handling process:

- Check Downloader:
  - Queue - Check your downloader's queue for password-protected (encrypted) releases marked as a failure
  - History - Check your downloader's history for failure (e.g. not enough to repair, or extraction failed)
- When Readarr finds a failed download it starts processing them and does a few things:
  - Adds a failed event to Readarr's history
  - Removes the failed download from Download Client to free space and clear downloaded files (optional)
  - Starts searching for a replacement file (optional)
  - Blocklisting (fka 'Blacklisting') allows automatic skipping of nzbs when they fail, this means that nzb will not be automatically downloaded by Readarr ever again (You can still force the download via a manual search).
  - There are 2 advanced options (on 'Download Client' settings page) that control the behavior of failed downloading in Readarr, at this time, they are all on by default.

- Redownload - Controls whether or not Readarr will search for the same file after a failure
- Remove - Whether or not the download should automatically be removed from Download Client when the failure is detected

### Remote Path Mappings

- Remote Path Mapping acts as a dumb find Remote Path and replace with Local Path This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

- One of our amazing community members have created [an excellent guide (for Radarr - same concepts for readarr)](https://trash-guides.info/Radarr/Radarr-remote-path-mapping/) to help you out if you think remote path mapping is what will work for you here

## Import Lists

> Information on supported list types can be found [here](/readarr/supported#lists)
{.is-info}

Import lists allow you to add items to Readarr automatically from your GoodReads shelves or from other users. This has the potential to add a lot of unexpected items to your Readarr database, so please use it with care.

![importlists.png](/assets/readarr/importlists.png)

### Import Lists

This shows you the lists you currently have, and allows you to add new lists. Adding lists is covered below in more detail.

### Import List Exclusions

Anything on here has been excluded from being added by lists, and will never be added from any list.  You can remove items from this by clicking on it.

## Adding an Import List

After clicking the `+`, choose what kind of list you'd like to add:

![addlist.png](/assets/readarr/addlist.png)

In this instance, we're going to add a Goodreads Bookshelf list.

![bookshelflist.png](/assets/readarr/bookshelflist.png)

- Enter a name for this list.
- Check this box to have anything on the list automatically add to Readarr.

> This is going to add all authors, and ALL BOOKS from that author, to Readarr!

- Select your monitoring level for things added. Valid options are `None`, `Selected book`, and `All Author Books`. All books are added to Readarr, but will be monitored or unmonitored based on this selection.
- Check this box to have Readarr initiate a search for missing monitored items when they are added from a list. If you're adding a lot of authors/monitored books, this may overload your system!
- Choose the root folder for these authors/books.
- Choose your quality profile.
- Choose your metadata profile.
- Choose what tags apply to items from this list.

> It is highly recommended that you add a descriptive tag here. Otherwise, you will not know what list added these items to Readarr, and once they're added you can never get this information again! This info is not logged!

- (Advanced Option) Enter a userid here if it is not your userid you're added.
- Click the button to authenticate with Goodreads.

When done, click `Test` to test the connection. If you get a green checkmark, you can click `Save` to save the list.

If you get an error, you should check your logs to see what the specific error is, and then fix that issue before saving.

Lists sync by default every 24 hours, but can be triggered manually from the `Settings` => `Tasks` page. You cannot automate this process any quicker than that.

## Connect

> Information on supported connection types can be found [here](/readarr/supported#notifications)
{.is-info}

### Connections

Connections are how you want Readarr to communicate with the outside world.

- By pressing the <kb>+</kb> button you will be presented with a new window which will allow you to configure many different endpoints

- A list of supported notifications & connections is located [here](/readarr/supported#notifications)

### Connection Triggers

- On Grab - Be notified when books are available for download and has been sent to a download client
- On Release Import - Be notified when books are successfully imported
- On Upgrade - Be notified when books are upgraded to a better quality
- On Download Failure - Be notified when a book download fails (usenet only)
- On Import Failure - Be notified when a book download fails to import
- On Rename - Be notified when books are renamed
- On Book Retag - Be notified when books are retagged
- On Health Issue - Be notified on health check failures
  - Include Health Warnings - Be notified on health warnings in addition to errors.

## Metadata

> Information on supported metadata consumers can be found [here](/readarr/supported#metadata)
{.is-info}

This page allows you to create/update metadata tags/covers.

![metadata.png](/assets/readarr/metadata.png)

### Calibre Metadata

If you are using Calibre to manage your ebook collection, you will use these options to control it.

- Send Metadata to Calibre options.
- Check the box to send book covers to Calibre.
- Check the box to embed metadata into the book files.

### Write Metadata to Audio Files

If you are using audiobooks, you will use these options to control it.

- Select your options for tagging audiobooks with metadata.
- Check the box to remove any embedded tags and leave only those added by Readarr.

## Tags

- The tag section in Readarr is used to link different aspects of Readarr.
- Tags are particularly useful for:

  - Release Profiles
  - Indexers
  - Import Lists

- Tags can be used to link Release Profiles, Indexers, Import Lists and Authors/Books together.
- For Example:
  - You want a specific Author/Book to only use a specific indexer. You would create a tag and assign the Author/Book and indexer that tag.
  - You want a specific Import List to only use a specific Release Profile. You would create a tag and assign the Import List and Release Profile that tag.

> It is highly recommended that you add a descriptive tag to an Import List aside from what is mentioned above.

> Note: Tags do not influence any "Quality Profiles", "Metadata Profiles" or any other aspect not mentioned above.
{.is-info}

## General

This page is for general Readarr settings that are not covered in other sections.

### Host

![genhost.png](/assets/readarr/genhost.png)

- (Advanced Option) Bind address should be * unless you have a specific setup that requires something different.
- Port number that Readarr is running on. This can also be changed in the `config.xml` file if Readarr is not running.
- URL Base for Readarr if you're using a reverse proxy.
- (Advanced Option) Check this box to enable SSL.

> If you are running on an IP or localhost, do not check this box!

- Check this box to open a (default) browser window on start.

### Security

![gensecurity.png](/assets/readarr/gensecurity.png)

- Choose your authentication here. You can set a username/password for accessing Readarr.

> If you forget your password, you will need to stop Readarr, edit the `config.xml` file and change Authentication to `none` and restart, and then set these values again.

- This is your API key for use by other programs where necessary. Do not share this API with anyone, and blur it from any public postings.
- Change how string HTTPS certificate validation is. This only applies to Readarr access itself!

### Proxy

![genproxy.png](/assets/readarr/genproxy.png)

- If you use a proxy, check this box.
- Select your proxy type (HTTPS, Socks4, or Socks5).
- Enter your proxy hostname.
- Enter your proxy port.
- Enter your proxy username.
- Enter your proxy password.
- Enter a comma-separated list of addresses that bypass the proxy.
- Check the box to bypass the proxy for local addresses.

### Logging

![genlogging.png](/assets/readarr/genlogging.png)

Select your logging level here.

> When asking for help, `Trace` level logging is generally needed. Regardless of the warning in the image above, trace logging rolls over and will not fill up your drive. It's fine to leave on all the time, so you have the required logs when necessaery.

### Analytics

![genanalytics.png](/assets/readarr/genanalytics.png)

Check this box so that the Readarr development team can make decisions about what issues and bug reports to prioritize.

### Updates

![genupdates.png](/assets/readarr/genupdates.png)

### Updates

- (Advanced Option) Branch - This is the branch of Readarr that you are running on.
  - [Please see this FAQ entry for more information](/readarr/faq#how-do-i-update-readarr)
- Automatic - Automatically download and install updates. You will still be able to install from System: Updates. Note: Windows Users are always automatically updated.
- Mechanism - Use Readarr built-in updater or a script
  - Built-in - Use Readarr's own updater
  - Script - Have Readarr run the update script
  - Docker - Do not update Readarr from inside the Docker, instead pull a brand new image with the new update
- Script - Visible only when Mechanism is set to Script - Path to update script
- Update Process - Readarr will download the update file, verify its integrity and extract it to a temporary location and call the chosen method. The update process will be be run under the same user that Readarr is run under, it will need permissions to update the Readarr files as well as stop/start Readarr.
- Built-in - The built-in method will backup Readarr files and settings, stop Readarr, update the installation and Start Readarr, if your system will not handle the stopping of Readarr and will attempt to restart it automatically it may be best to use a script instead. In the event of failure the previous version of Readarr will be restarted.
- Script - The script should handle the the same as the built-in updater, if you need to handle stopping and starting services (upstart/launchd/etc) you will need to do that here.

### Backups

![genbackups.png](/assets/readarr/genbackups.png)

- (Advanced Option) The folder where backups are located.
- (Advanced Option) How many days apart backups are made.
- (Advanced Option) How many days old backups are deleted.

By default, backups are performed every 7 days, and the last 4 are kept.

## UI (User Interface)

This page allows you to customize the user interface display options.

### Calendar

![uicalendar.png](/assets/readarr/uicalendar.png)

- Choose the day of the first day of the week on the calendar.
- Choose the week's column header for the calendar.

### Dates

![caldates.png](/assets/readarr/caldates.png)

- Choose the short date format.
- Choose the long date format.
- Choose the time format.
- Check the box to show "Today", etc. instead of dates that are close.

### Style

![calstyle.png](/assets/readarr/calstyle.png)

- Check the box to change colors to be separated on the spectrum better for color-impaired viewers.

### Language

![callanguage.png](/assets/readarr/callanguage.png)

- Choose the UI language from the drop-down of available translations.
