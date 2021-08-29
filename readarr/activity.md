---
title: Readarr Activity
description: 
published: true
date: 2021-08-19T21:43:00.662Z
tags: 
editor: markdown
dateCreated: 2021-05-25T16:14:58.862Z
---

## Activity

This set of screens show current and past activity performed by Readarr.

## Queue

When something is actively downloading and not yet imported into Readarr, it will show in the Queue page.

![queue1.png](/assets/readarr/queue1.png)

In the image above, the ebook is downloading, and not yet complete. The arrow is black, which means it has no current issues, and the progress bar is still filling in. You can cancel the download by clicking on the `X` on the right.

> For Usenet indexers, Readarr will only look 60 items deep in the queue for potential imports! It is important not to exceed this, or you will need to clean up with manual imports when your system gets overloaded and starts missing items!

![queue2.png](/assets/readarr/queue2.png)

If an item needs a human to review it and make a decision, it will be orange on the left icon. Hovering over it will show you the specific error. If you think you can manually import it anyway, click the "person" icon on the right.  In the example above, the book is correct, but the matching percentage is too low to be sure, so Readarr needs your help to decide if it's really the book it thinks it is.  Since it is, I will click on the person icon.

![queue3.png](/assets/readarr/queue3.png)

Make sure the author and book match, and click `Import`.

## History

The History page shows you everything that Readarr has done with your media. The default sorting is from newest to oldest.

![history1.png](/assets/readarr/history1.png)

The left icon is the action that was taken (the list of possible actions is shown below). You can filter these by clicking on the Filter icon on the right side. You can also show more columns by clicking on Options.

![history2.png](/assets/readarr/history2.png)

On `Grabbed` statuses, you can click on the `i` icon on the right to see more details about the download (what indexer it came from, the URL of the grab, the age of the upload, etc.). You can also mark this item as failed, to initiate a removal, blocklist, and re-search of the item.

![history4.png](/assets/readarr/history4.png)

## Blocklist

> Blocklist is formerly known as 'Blacklist' {.is-info}

The blocklist page shows you items that are blocklisted so they won't be downloaded again. These are failures from the automatic process or manually marked failed items. Items remain in the blocklist forever unless you manually remove them.

![blocklist1.png](/assets/readarr/blocklist1.png)

Clicking on the `i` icon on the far right shows you more details about the blocklisted entry, and whether it was manually marked as failed or automatically failed during download.

![blocklist2.png](/assets/readarr/blocklist2.png)

Clicking on the `x` on the far right removes the item from the blocklist, so that you can potentially grab it again, if it was added in error.
