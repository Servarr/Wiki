---
title: Lidarr Activity
description: Monitor download progress, search history, and queue management in Lidarr
published: true
date: 2026-06-06T13:48:53.842Z
tags: lidarr, activity, queue, downloads, history, monitoring
editor: markdown
dateCreated: 2021-06-14T21:35:25.390Z
---

## Activity

The Activity section is where you can see everything Lidarr has done or is currently doing: imports, deletes, upgrades, grabs, renames, and failures.

## Queue

The Queue shows all items that are actively downloading or waiting for import. Lidarr populates the queue by polling your download client's API, so the queue isn't stored internally. It reflects your download client's current state.

Lidarr only shows items that are in the download client category configured under **Settings → Download Clients → Category**. Items in other categories are invisible to Lidarr.

> For Usenet clients, Lidarr only looks 60 items deep in the queue for potential imports. If your queue exceeds this depth, Lidarr won't pick them up and they'll require manual imports.
{.is-warning}

> Enable **Remove Completed Downloads** in your download client so it clears finished items from the queue automatically.
{.is-info}

### Queue columns

The queue table shows the following columns by default: Status, Artist, Album Title, Quality, Formats, Protocol, Download Client, Output Path, Time Left, Added, and Progress. Use **Options** to show or hide columns or change their order.

### Queue statuses

| Icon | Status | Description | Resolution |
|---|---|---|---|
| Grey cloud | Queued | The item is waiting in the download client and hasn't started downloading yet. | Wait for the download client to start it. |
| Grey clock | Release Pending | The download is waiting for a Delay Profile timer to expire before Lidarr sends it to the download client. | Wait for the delay to pass, or adjust your Delay Profile in Settings. |
| Yellow arrow | Downloading | The item is actively downloading in the download client. | N/A. |
| Purple arrow | Importing | The download has finished and Lidarr is importing it. | N/A. |
| Yellow warning | Unable to Import | Lidarr couldn't import the release. Hover over the icon for details. | See [Import Troubleshooting](/lidarr/import-troubleshooting). |

### Queue action icons

Each row has action icons on the right:

- **Manual Import** (person icon): opens the manual import dialog for this item, letting you match and import it yourself.
- **Grab** (download icon): re-sends the release to the download client. Useful if the client removed an item that's still in the Lidarr queue.
- **Remove** (✕): removes the item from the Lidarr queue. When removing, you can also choose to:
  - **Remove from Download Client:** deletes the item from the download client as well. Use this for unmatched items Lidarr shouldn't download.
  - **Add to Blocklist:** prevents Lidarr from grabbing this release again.

### Queue options

Click **Options** in the queue toolbar to open Table Options:

| Option | Default | Description |
|---|---|---|
| Page Size | 250 | Number of queue items shown per page. |
| Show Unknown Artist Items | On | Shows items in Lidarr's download client category that Lidarr can't match to any artist in your library (for example, removed artists or items added to the category manually). |
| Columns | (see below) | Choose which columns are visible and their display order. |

Available columns: Status, Artist, Album Title, Album Release Date, Quality, Formats, Custom Format Score, Protocol, Indexer, Download Client, Release Title, Size, and Output Path.

## History

The History tab shows everything that has left the queue: completed imports, failures, grabs, deletes, renames, and upgrades.

The icon on the left of each row shows what action Lidarr took. Use the **Filter** button to narrow the view by event type, and **Options** to show or hide columns.

On `Grabbed` entries, click the `i` icon on the right to see details about the download: which indexer it came from, the grab URL, the upload age, and more. You can also mark a grabbed item as failed from here, which removes it, adds it to the blocklist, and triggers a re-search.

## Blocklist

> The Blocklist was formerly called the Blacklist.
{.is-info}

The Blocklist shows releases that Lidarr won't download again. Lidarr adds entries automatically when a download fails, or you can add them manually by selecting **Add to Blocklist** while removing an item from the queue. Items stay on the blocklist permanently until you remove them.

Click the `i` icon on the right of any entry to see whether Lidarr marked it failed manually or automatically, and what the failure reason was.

Click the `✕` on the right to remove an entry from the blocklist, allowing Lidarr to grab that release again if it comes up in a future search.

### Common blocklist reasons

- User manually marked a download as failed
- User selected **Add to Blocklist** when removing an item from the queue
- Usenet download client reported a download failure
