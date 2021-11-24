---
title: Readarr Library
description: 
published: true
date: 2021-11-24T18:57:22.376Z
tags: readarr
editor: markdown
dateCreated: 2021-05-25T15:29:27.457Z
---

## Library

This section is for managing your library of authors and books.

## Authors

- Library View
  - Update All - Update metadata for all authors, refresh posters, rescan author folders, and rescan book files (if enabled)
  - Refresh & Scan - Refresh the currently viewed author's metadata and rescan its folder
  - RSS Sync - Refresh the RSS feed from your Indexers and see if anything new has been posted to be grabbed
  - Author Editor / Author Index - Toggle between Mass Editor mode and Author Index (Library) mode
  - Options - Change display options
  - View - Toggle View Type
    - Table - Tabular View (list view)
    - Posters - Display Posters (similar to Plex)
    - Overview - Display overview information and the poster (detailed view)
  - Sort - Sort the current view
  - Filter - Filter the current view

## Books

- Library View
  - Update All - Update metadata for all authors, refresh posters, rescan author folders, and rescan book files (if enabled)
  - Refresh & Scan - Refresh the currently viewed author's metadata and rescan its folder
  - RSS Sync - Refresh the RSS feed from your Indexers and see if anything new has been posted to be grabbed
  - Search All / Search Filtered / Search Selected - Search all books / search all filtered books / search all selected books on your indexers
  - Book Editor / Book Index - Toggle between Mass Editor mode and Book Index (Library) mode
  - Options - Change display options
  - View - Toggle View Type
    - Table - Tabular View (list view)
    - Posters - Display Posters (similar to Plex)
    - Overview - Display overview information and the poster (detailed view)
  - Sort - Sort the current view
  - Filter - Filter the current view
  
## Add New

![addnew.png](/assets/readarr/addnew.png)

- You can add new authors or individual books by entering the author's name or a book name here, and selecting it from the result list.
  - You'll find the how-to in our [Quick Start Guide](/readarr/quick-start-guide)
- You can also add authors by GoodReads ID, ISBN, or ASIN as needed, using the format shown.

![poe.png](/assets/readarr/poe.png)

- Click on the author name to add it to Readarr. A box will pop up with options for you.

![addauthor.png](/assets/readarr/addauthor.png)

- Select the root folder here. Do not change this if you use Calibre Content Server.
- Select the monitoring state of all books for this author.
- Select the Quality Profile to use when looking for books for this author.
- If you would like a tag applied to this author's books, enter it here.
- Choose whether to start a historical search of your indexers for all books by this author immediately. If you do not do this, only NEWLY uploaded books will be grabbed from this point forward.
- Click the Add button to add this author to Readarr and start pulling metadata for all books by this author. This process can take some time, so it would be advisable not to add too many authors too quickly.

>If you add an individual book, and select "None" for the metadata profile, only that book will show up under the author when it's added. If you want other books for that author added, choose an appropriate metadata profile.
{.is-warning}


## Unmapped Files

![unmappedfiles.png](/assets/readarr/unmappedfiles.png)

If there are books listed here, then they are unrecognized by Readarr and are not listed as "existing" in Readarr, but they are in one of the root folders you've defined.

You can get more info by clicking on the *i* icon on the right.

You can manually import the book by clicking on the *person* icon on the right.

You can delete the book file by clicking on the *trashcan* icon on the right.

You can also click on *Add Missing* at the top to try to add all books to Readarr. Note that this can be time-intensive if you have a lot of books listed here.
