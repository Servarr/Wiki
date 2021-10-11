---
title: Readarr Settings
description: 
published: true
date: 2021-08-22T04:06:31.296Z
tags: readarr, settings
editor: markdown
dateCreated: 2021-05-27T16:47:28.054Z
---

## Media Management

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

- Replace Illegal Characters - If this is toggled off (no check in the box) Readarr will replace illegal characters. Examples include `\ # / $ * < >` and more.

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
  
- (Advanced Option) Select the box to create empty author folders when a new author is added.
- (Advanced Option) Select the box to delete empty author folders if there are no books in it.
  
> One of those boxes can be checked, but they should not BOTH be checked.
  
![mm_importing.png](/assets/readarr/mm_importing.png)
  
- (Advanced Option) Enter the minimum free space for the drive to have before importing stops.
- (Advanced Option) Check this box to use Hardlinks instead of Copies (for Torrents).
  
> You should ideally use this wherever possible. In order for hardlinks to be used, you must have your source/destination on the same file system (drive, partition) and mount points.
  
- If you would like additional files to be imported, check this box.
- (Advanced Option, only shown when box is checked) Enter the extensions to move with files, separated by commas. Some good examples are `jpg,nfo,cue`.

> If you are using Readarr for audiobooks, you should add .cue to this list, as it holds your chapter information!
  
### File Management
  
  ![mm_filemgmt.png](/assets/readarr/mm_filemgmt.png)

- Check this box to unmonitor books you delete from Readarr's root folder.
- (Advanced Option) Choose how you would like to handle re-uploads with PROPER or REPACK or FIXED in them.
- (Advanced Option) Check this box to trigger a rescan when the root folder changes.
- (Advanced Option) Choose when to rescan an author folder after refreshing the author.
- (Advanced Option) Choose how to handle fingerprinting, which allows increased accuracy for book matching, at the expense of CPU/disk time.
- (Advanced Option) Choose whether to change the file date stamp.
- (Advanced Option) Enter a folder here if you want to use a Recycling Bin (things you delete will go here instead of being permanently deleted, so that you can restore them if you made a mistake).
- (Advanced Option) Enter the number of days to keep files in the Recycling Bin before they are permanently deleted.

> It is highly recommended that you use a Recycling Bin. It's easy to delete files, and recovering them is easy if you use the bin.

## Profiles

### Quality Profiles

Quality profiles are used to determine what formats of books are acceptable for a book in your library.
  
![qualityprofile.png](/assets/readarr/qualityprofile.png)

- On a new quality profile, enter a name for it.
- If you want Readarr to keep grabbing new versions until it hits your favorite format of ebook, check the box.
- If you checked the box, select your final "best" version of ebooks from the drop-down.

Under Qualities, you are going to check the boxes for the formats of ebooks you want. If they are not checked here, you will not get other formats; be careful what you choose to eliminate as it might mean that you do not get a particular book.
  
You can drag the format up and down using the icon on the right, to rank them. This only matters if you have upgrades allowed. Upgrades are from bottom to top on the quality ranking.
  
> You may create multiple quality profiles, and apply a separate one to each author as needed. But, you may only apply a single quality profile to any given author.
  
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

This page is where you will add or edit your Usenet or Torrent download clients, and if necessary to add Remote Path Mappings.

![downloadclients.png](/assets/readarr/downloadclients.png)

### Download Clients

This is a list of download clients you've added to Readarr. How to add more is detailed below.

### Completed Download Handling

- Enable: If this is not checked, Readarr won't handle completed downloads in any way. You will need to handle them manually.

- (Advanced Option) Check this box to remove imported downloads from the download client history. This should be checked if you're using only usenet, but should not be checked if you're using torrent downloads.

### Failed Download Handling

- This box should be checked if you want Readarr to automatically do a new search for an item that failed download.

- (Advanced Option) This box should be checked to remove failed downloads from the download client history. This should be checked for both usenet and torrent clients.

### Remote Path Mappings

If your download client is on another physical machine, you may need a remote path mapping. These are detailed extensively [here](https://trash-guides.info/Sonarr/Sonarr-remote-path-mapping/). Keep in mind that remote path mappings are "dumb" search/replaces. "If you see this, then replace it with this". If your error messages display the old/bad path, then the remote path mapping is not working properly. If they display the new path, then they are working as expected but may be incorrect.

## Adding a Download Client

To add a download client, click on the `+` icon, which will open a pop-up box.

![addclient1.png](/assets/readarr/addclient1.png)

- Enter a name for this client.
- Check this box to enable it for use by Readarr.
- Enter the hostname. This can be a domain, localhost, or IP address.
- Enter the port that your download client is running on.
- (Advanced Option) If you use a reverse proxy, enter a URL Base.
- If your client requires a username, enter it here.
- If your client requires a password, enter it here.
- We highly recommend entering a Category here, which also exists in your download client. This way, every *arr you run doesn't have to parse every download.

![addclient2.png](/assets/readarr/addclient2.png)

- For releases less than 14 days old, this is the priority assigned in the download client.
- For releases more than 14 days old, this is the priority assigned in the download client.
- Check this box to add downloads to your client in a "Paused" state.
- Check this box to use https instead of http.

> If you are using localhost or an IP, you almost certainly DO NOT WANT to check this box.

- (Advanced Option) Client priority from 1-50. This is used where you have multiple of a given type (usenet/torrent) of client, and want one to be prioritized over the other. If two clients have the same priority, items are round-robined among them.

Click `Test` to test the connection. If you get a green checkmark, you can click `Save` to save it. Repeat as necessary for each client you wish to add.

If you get an error, please check your logs for the specific issue and fix it until it tests green.

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

This page lists the external 3rd party connections Readarr uses for notifications.

![connect.png](/assets/readarr/connect.png)

### Connections

This section lists all current connections, and allows you to add new ones.

## Adding a Connection

To add a new connection, click the `+` icon.  There are many connection types you can select from:

![connectiontypes.png](/assets/readarr/connectiontypes.png)

Since there are so many, and each is different, we won't get into the individual details. But there are a few things to note:

- The Email connection allows you to attach the book itself to the email, which is a great way to deliver books to your reading device.
- Notifiarr allows you to customize most of these same connections in a single setup, if you have [Notifiarr](https://github.com/Notifiarr/notifiarr) installed.
- Custom Script allows you to invoke a custom script for many different event types - if you want to convert book formats, sync to your device, or other options.

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

If you have created any tags, they will be listed here and you can remove them if necessary.

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
