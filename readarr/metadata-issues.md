---
title: Readarr Metadata Issues
description: Summary of Readarr metadata issues
published: true
date: 2024-08-23T18:20:51.850Z
tags: 
editor: markdown
dateCreated: 2024-08-23T18:20:51.850Z
---

# Readarr Metadata Server Updates

Below are the summarized issues of the Readarr Metadata Server.
For the latest updates please refer to the pinned messages in the [Readarr Discord](https://readarr.com/discord)

## Future Plans

Due to continuous GoodReads issues - work has slowly begun by a community member and is also being poked at by one of the Servarr Development Team members to migrate to [OpenLibrary](https://openlibrary.org/).  Note that Readarr effectively has no active developers at this time and given the berth of the project it will be slow moveing.  If you wish to assist with this - please visit us on Discord.  Please do not ask for updates as that is not productive and updates will be shared as progress progresses.

## Rate Limiting

- As Of: 2024-05-22
- Updated: 2024-08-09
- Impact: Log Entries of `BookInfo returned 429, backing off for `
  - Readarr's metadata server is getting a lot of rate limiting because of the downtime and everyone's systems hitting it to get list imports, etc. This is expected to slow things down for a week or two until everything is running like normal again. If you're trying to import, or search, etc. and those things are slow or failing, your logs will indicate a 429 error. This will get better. Please have some patience and it will resolve in time.
  - The metadata server is struggling. Something occurred on 2024-07-31 that caused it, and it hasn't been able to be corrected yet. It works. You will see 429's a LOT. Sometimes it's better than other times. Hopefully it will be corrected soon. When that happens, I will update here. There is nothing you can do to help but wait and be patient. It is not an issue on your end.
  - The 429 messages are due to a metadata server issue. This impacts all searches for books or authors, imports, list additions, etc. Anything that hits the metadata server.
  - **The metadata server cannot be self-hosted or changed. The only thing you can do is be patient and wait. It will work, but slowly. There is nothing you can do to help in the meantime.**
  - It's not you, it's us.
  - Please be patient, it will eventually get better, but we have no timeline on when that might happen. The pins, as always, have the most current information and will be updated if/when something changes.

## Data Delays

- As Of: 2024-04-17
- Impact: It's functioning, approximately 3 months behind. If you have a book that was added to Goodreads less than 3 months ago, it probably is not going to show up yet.

## Large Authors

- As Of: 2023
- Impact:
  - Large authors are still not working, and will not be for a while. A partial, but not exhaustive, list of those authors: Stephen King, Isaac Asimov, Leo Tolstoy, Fyodor Dostoevsky, Arthur Conan Doyle, Stephen Fry, Agatha Christie, Arthur C. Clarke, Oscar Wilde, Jack London, Neil Gaiman, Charles Dickens, Jane Smiley, Vladimir Nabokov, Bernard Cornwall, D.H. Lawrence. 
  -  For large authors, you cannot do anything to add either the author OR their individual books. There is no workaround. 
