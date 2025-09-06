---
title: Lidarr Activity
description: Monitor download progress, search history, and queue management in Lidarr
published: true
date: 2022-02-06T09:06:39.366Z
tags: lidarr, activity, queue, downloads, history, monitoring
editor: markdown
dateCreated: 2021-06-14T21:35:25.390Z
---

# Activity

The activity tab is where you can see past and present activities that \*Arr  has done. Including imports, deletes, upgrades, grabs, renames, and failures.

# Queue

When something is actively downloading and not yet imported into \*Arr, it will show in the Queue page.

The queue shows all items the application can recognize that is in the specified download client's category (Settings => Download Client => Category). To view all releases Options => Show Unknown. The queue is not stored anywhere within the application, but is updated via your Download Client's API responses.

> For Usenet Clients, \*Arr will only look 60 items deep in the queue for potential imports! It is important not to exceed this, or you will need to clean up with manual imports when your system gets overloaded and starts missing items!.
> Remove Completed Downloads should be enabled for your Download Client as well. {.is-warning}

## Queue Action Icons

- X - Remove Item from Queue
  - Remove Release From Download Client - Remove Release from Download Client. Mandatory for unmatched release items
  - Blocklist Release - Add Release to Blocklist
- Human Icon - Manual Import Release
- Grab Icon - Send Release to Download Client

## Queue Statuses

> Note the below is incomplete {.is-warning}

| Icon       | Status                   | Description                                                                                     | Resolution Steps                                         |
| ---------- | ------------------------ | ----------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| grey clock | Release Pending          | Download is awaiting Download Client to be available or for release to meet Delay Profile Rules | N/A                                                      |
| yellow     | Warning Unable to Import | \*Arr was unable to import the release. Review the tool tip for more details                    | [See the Troubleshooting Guide](/lidarr/troubleshooting) |
| purple     | Download Importing       | Download is Importing                                                                           | N/A                                                      |
|            |                          |                                                                                                 |                                                          |
|            |                          |                                                                                                 |                                                          |

# History

The history tab shows all things that have left the queue by way of the task being finished/ended. This includes imports, failures, grabs, deletes, and upgrades.

The left icon is the action that was taken (the list of possible actions is shown below). You can filter these by clicking on the Filter icon on the right side. You can also show more columns by clicking on Options.

![history2.png](/assets/lidarr/history2.png)

On `Grabbed` statuses, you can click on the `i` icon on the right to see more details about the download (what indexer it came from, the URL of the grab, the age of the upload, etc.). You can also mark this item as failed, to initiate a removal, blocklist, and re-search of the item.

![history4.png](/assets/lidarr/history4.png)

# Blocklist

> Blocklist is formerly known as 'Blacklist' {.is-info}

The blocklist page shows you items that are blocklisted so they won't be downloaded again. These are failures from the automatic process or manually marked failed items. Items remain in the blocklist forever unless you manually remove them.

![blocklist1.png](/assets/lidarr/blocklist1.png)

Clicking on the `i` icon on the far right shows you more details about the blocklisted entry, and whether it was manually marked as failed or automatically failed during download.

![blocklist2.png](/assets/lidarr/blocklist2.png)

Clicking on the `x` on the far right removes the item from the blocklist, so that you can potentially grab it again, if it was added in error.

## Common Blocklist Reasons

- User Marked Download as Failed Manually
- User Selected "Add to Blocklist" when removing from queue
- Usenet Download Client reported release download failure
