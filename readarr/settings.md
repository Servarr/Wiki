---
title: Settings
description: 
published: true
date: 2021-05-30T14:05:00.671Z
tags: 
editor: markdown
dateCreated: 2021-05-27T16:47:28.054Z
---

# Settings

## Media Management

### Book File Naming

![bookfilenaming.png](/assets/readarr/bookfilenaming.png)

If you are using Calibre integration, you do not get to name book files. Calibre takes care of this for you. You should only change these settings if you are not using Calibre.

Commonly used naming schema are:

Standard Book Format
<code>{Book Title}\{Author Name} - {Book Title}</code> which would then output a folder named <code>Cujo</code>, and a subdirectory containing a file with the name <code>Stephen King - Cujo.m4b</code>

Author Folder Format
- <code>{Author Name}</code> which would then output: <code>Stephen King</code>

- Rename Books - If this is toggled off (no check in the box) Readarr will use the existing file name if renaming is disabled.

> If you leave Rename Books unchecked, then none of the naming stuff below applies - you have told Readarr you do not want any renaming done at all.
{.is-info}

- Replace Illegal Characters - If this is toggled off (no check in the box) Readarr will replace illegal characters. Examples include <code>\ # / $ * < ></code> and more.

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
- {Author Name}	Author Name
- {Author CleanName}	Author Name
- {Author NameThe}	Author Name, The
- {Author Disambiguation}	Author Name (disambiguation used from GoodReads for multiple authors with the same name)

Book
- {Book Title}	Book Name!
- {Book CleanTitle}	Book Name
- {Book TitleThe}	Book Name, The
- {Book Type}	Book Type
- {Book Disambiguation}	Book Name! (disambiguation title used from GoodReads)

Release Date
- {Release Year}	2001

Medium
- {medium:0}	1
- {medium:00}	01

Medium Format
- {Medium Format}	CD

Quality
- {Quality Full}	FLAC Proper
- {Quality Title}	FLAC

Media Info
- {MediaInfo AudioCodec}	FLAC
- {MediaInfo AudioChannels}	2.0
- {MediaInfo AudioBitRate}	320kbps
- {MediaInfo AudioBitsPerSample}	24bit
- {MediaInfo AudioSampleRate}	44.1kHz

Other
- {Release Group}	Rls Group
- {Preferred Words}	iNTERNAL

Original
- {Original Title}	Author.Name.Book.Name.2018.FLAC-EVOLVE
- {Original Filename}	01-book name

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
## Profiles
### Quality Profiles

![qualityprofile.png](/assets/readarr/qualityprofile.png)

- On a new quality profile, enter a name for it.
- If you want Readarr to keep grabbing new versions until it hits your favorite format of ebook, check the box.
- If you checked the box, select your final "best" version of ebooks from the drop-down.
- 
