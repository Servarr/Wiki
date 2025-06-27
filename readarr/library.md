---
title: Readarr Library (Retired)
description: 
published: true
date: 2021-11-30T01:41:54.243Z
tags: readarr, needs-love, library
editor: markdown
dateCreated: 2021-11-30T00:50:59.442Z
---

# Announcement: Retirement of Readarr

We would like to announce that the [Readarr project](https://github.com/Readarr/Readarr) has been retired. This difficult decision was made due to a combination of factors: the project's metadata has become unusable, we no longer have the time to remake or repair it, and the community effort to transition to using Open Library as the source has stalled without much progress.

Third-party metadata mirrors exist, but as we're not involved with them at all, we cannot provide support for them. Use of them is entirely at your own risk. The most popular mirror appears to be [rreading-glasses](https://github.com/blampe/rreading-glasses).

Without anyone to take over Readarr development, we expect it to wither away, so we still encourage you to seek alternatives to Readarr.

## Key Points

- Effective Immediately: The retirement takes effect immediately. Please stay tuned for any possible further communications.
- Support Window: We will provide support during a brief transition period to help with troubleshooting non metadata related issues.
- Alternative Solutions: Users are encouraged to explore and adopt any other possible solutions as alternatives to Readarr.
- Opportunities for Revival: We are open to someone taking over and revitalizing the project. If you are interested, please get in touch.
- Gratitude: We extend our deepest gratitude to all the contributors and community members who supported Readarr over the years.

Thank you for being part of the Readarr journey. For any inquiries or assistance during this transition, please contact our team.

Sincerely,
The Servarr Team

# Library

This section is for managing your library of [authors](#authors) and [books](#books)

# Authors

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

# Books

- Library View
  - Update All - Update metadata for all authors, refresh posters, rescan author folders, and rescan book files (if enabled)
  - Refresh & Scan - Refresh the currently viewed author's metadata and rescan its folder
  - RSS Sync - Refresh the RSS feed from your Indexers and see if anything new has been posted to be grabbed
  - Search All / Search Filtered / Search Selected - Search all books or selected books in the current view
  - Book Editor / Book Index - Toggle between Mass Editor mode and Book Index (Library) mode
  - Options - Change display options
  - View - Toggle View Type
    - Table - Tabular View (list view)
    - Posters - Display Posters (similar to Plex)
    - Overview - Display overview information and the poster (detailed view)
  - Sort - Sort the current view
  - Filter - Filter the current view
  
# Add New

![addnew.png](/assets/readarr/addnew.png)

- You can add new authors or individual books by entering the author's name or a book name here, and selecting it from the result list.
  - You'll find the how-to in our [Quick Start Guide](/readarr/quick-start-guide)
- You can also add authors by GoodReads ID, ISBN, or ASIN as needed, using the format shown.

![poe.png](/assets/readarr/poe.png)

- Click on the author or book name to add it to Readarr. A box will pop up with options for you.

![addauthor.png](/assets/readarr/addauthor.png)

- Root Folder - Select the root folder here. Do not change this if you use Calibre Content Server.
- Monitor - Select the monitoring state of all books for this author.
- Quality Profile - Select the Quality Profile to use when looking for books for this author.
- (Book Only) Metadata Profile - Select the Metadata Profile to use for this book
- Tags - If you would like a tag applied to this author's books, enter it here.
- Start Search for Missing Book(s) - Choose whether to start a historical search of your indexers for all books by this author immediately. If you do not do this, only NEWLY uploaded books will be grabbed from this point forward.
- Add {Author Name} or Add {Book Name} - Click the Add button to add this author to Readarr and start pulling metadata for all books by this author. This process can take some time, so it would be advisable not to add too many authors too quickly.

>If you add an individual book, and select `None`\* for the [metadata profile](/readarr/settings#metadata-profiles), only that book will show up under the author when it's added. If you want other books for that author added, choose an appropriate metadata profile.
> \* **Note that `None` does not apply any metadata filters and you may get unwanted foreign editions. To work around these [create a metadata profile as prescribed in the faq](/readarr/faq#metadata-profile-none-allowing-foreign-releases)**
{.is-warning}

# Unmapped Files

![unmappedfiles.png](/assets/readarr/unmappedfiles.png)

If there are books listed here, then they are unrecognized by Readarr and are not listed as "existing" in Readarr, but they are in one of the root folders you've defined.

You can get more info by clicking on the *i* icon on the right.

You can manually import the book by clicking on the *person* icon on the right.

You can delete the book file by clicking on the *trashcan* icon on the right.

You can also click on *Add Missing* at the top to try to add all books to Readarr. Note that this can be time-intensive if you have a lot of books listed here.
