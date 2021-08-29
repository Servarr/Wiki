---
title: Readarr Library
description: 
published: true
date: 2021-08-21T20:57:33.248Z
tags: readarr
editor: markdown
dateCreated: 2021-05-25T15:29:27.457Z
---

## Library

This section is for managing your library of authors and books.

## Authors

- Library View
  - Update All - Update metadata for all authors, refresh posters, rescan author folders, and rescan author files (if enabled)
  - RSS Sync - Refresh the RSS feed from your Indexers and see if anything new has been posted to be grabbed
  - Options - Change display options
  - View Toggle View Type
  - Table - Tabular View
  - Posters - Display Posters (Similar to Plex)
  - Overview - Display overview information and the poster; the most detailed view
  - Sort - Sort the current view
  - Filter - Filter the current view
    - Wanted - Author is missing, monitored, and available
    - Missing - Author is missing and monitored

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

## Mass Editor

![masseditor.png](/assets/readarr/masseditor.png)

The Sort and Filter options are the same here as the main Library screen and are documented above.

After selecting the authors you want to make mass changes to (you can select, and shift-click further down to select an entire range), you can make changes to monitoring status, quality profile, root folder (do not change this if you use Calibre), rename files (do not change this if you use Calibre), write metadata tags, set Readarr tags, or delete authors by clicking on the correct option at the bottom of the screen.

## Bookshelf

![bookshelf.png](/assets/readarr/bookshelf.png)

The Filter options are the same here as the main Library screen and are documented above.

Here you can do mass updating of the monitored state of individual books as well as authors. A solid flag indicates monitored, and an outline indicates unmonitored.

## Unmapped Files

![unmappedfiles.png](/assets/readarr/unmappedfiles.png)

If there are books listed here, then they are unrecognized by Readarr and are not listed as "existing" in Readarr, but they are in one of the root folders you've defined.

You can get more info by clicking on the *i* icon on the right.

You can manually import the book by clicking on the *person* icon on the right.

You can delete the book file by clicking on the *trashcan* icon on the right.

You can also click on *Add Missing* at the top to try to add all books to Readarr. Note that this can be time-intensive if you have a lot of books listed here.
