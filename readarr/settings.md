---
title: Readarr Settings
description: 
published: true
date: 2021-06-11T18:58:48.474Z
tags: readarr, settings
editor: markdown
dateCreated: 2021-05-27T16:47:28.054Z
---

## Media Management

### Book File Naming

![bookfilenaming.png](/assets/readarr/bookfilenaming.png)

If you are using Calibre integration, you do not get to name book files. Calibre takes care of this for you. You should only change these settings if you are not using Calibre.

Commonly used naming schema are:

Standard Book Format
`{Book Title}\{Author Name} - {Book Title}` which would then output a folder named `Cujo`, and a subdirectory containing a file with the name `Stephen King - Cujo.m4b`

Author Folder Format

- `{Author Name}` which would then output: `Stephen King`

- Rename Books - If this is toggled off (no check in the box) Readarr will use the existing file name if renaming is disabled.

> If you leave Rename Books unchecked, then none of the naming stuff below applies - you have told Readarr you do not want any renaming done at all.
{.is-info}

- Replace Illegal Characters - If this is toggled off (no check in the box) Readarr will replace illegal characters. Examples include `\ # / $ * < >` and more.

Dropdown Box (upper right corner)

Left Box - Space Handling

- Space ( ) - Use spaces in naming (Default)
- Period (.) - Use periods in lieu of spaces in naming
- Underscore (_) - Use underscores in lieu of spaces in naming
- Dash (-) - Use dashes in lieu of spaces in naming

Right Box - Case Handling

- Default Case - Make title uppercase and lowercase (~camelcase) (Default)
- Uppercase - Make title all Uppercase
- Lowercase - Make title all Lowercase

Author

- {Author Name} Author Name
- {Author NameThe} Author Name, The
- {Author CleanName} Author Name
- {Author SortName} Name, Author
- {Author Disambiguation} Author Name (disambiguation used from GoodReads for multiple authors with the same name)

Book

- {Book Title} Book Title!: Subtitle!
- {Book TitleThe} Book Title!, The: Subtitle!
- {Book CleanTitle} Book Title: Subtitle
- {Book TitleNoSub} Book Title!
- {Book TitleTheNoSub} Book Title!, The
- {Book CleanTitleNoSub} Book Title: Subtitle
- {Book Subtitle} Subtitle!
- {Book SubtitleThe} Subtitle!, The
- {Book CleanSubtitle} Subtitle
- {Book Disambiguation} Book Name! (disambiguation title used from GoodReads)
- {PartNumber} 2
- {PartCount} 10

Release Date

- {Release Year} 2016
- {Release YearFirst} 2015
- {Edition Year} 2016

Quality

- {Quality Full} AZW3 Proper
- {Quality Title} AZW3

Media Info

- {MediaInfo AudioCodec} MP3
- {MediaInfo AudioChannels} 2.0
- {MediaInfo AudioBitRate} 320kbps
- {MediaInfo AudioBitsPerSample} 24bit
- {MediaInfo AudioSampleRate} 44.1kHz

Other

- {Release Group} Rls Grp
- {Preferred Words} iNTERNAL

Original

- {Original Title} Author.Name.Book.Name.2018.AZW3-EVOLVE
- {Original Filename} 01-book name

> Original Filename is not recommended. It is the literal original filename and may be obfuscated t1i0p3s7i8yuti. Original Title is the release name and should be used instead.
{.is-info}
  
Author Folder Format

- (Advanced Option) This is where you will set the naming convention for the author folder name.

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
  
- Check this box to include your preferred words in the {Preferred Words} file naming assignment token.
  
> You should include {Preferred Words} in your file naming, and check this box if you're using them, because otherwise you can end up in a download loop.

- In this drop-down, you can limit this release profile to a single indexer.
- Enter a tag here, to be able to apply this tag to authors with the same tag. If you do not apply a tag here, then this profile applies to ALL authors.

## Quality

![qualitydefinitions.png](/assets/readarr/qualitydefinitions.png)

Here you can adjust your size limits for the various types of books you want. The defaults are probably good, you should not really need to adjust them.

## Indexers

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
