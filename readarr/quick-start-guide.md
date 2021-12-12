---
title: Readarr Quick Start Guide
description: 
published: true
date: 2021-12-12T20:22:17.641Z
tags: readarr
editor: markdown
dateCreated: 2021-12-11T19:42:31.825Z
---

In this guide we will try to explain the basic setup you need to do to get started as quickly as possible with Readarr.

There are a lot more settings you may need or want. They can be found at the [settings]( /readarr/settings) page.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you will need to enable those to make them visible.

After installation and starting up, you open a browser and go to `http://ip_where_installed:8787`

# Media Management

First we’re going to take a look at the `Media Management` settings where we can setup our preferred naming and file management settings.

`Settings` => `Media Management`

![mediamanagement.png](/assets/readarr/mediamanagement.png)

# Book Naming

![booknaming.png](/assets/readarr/booknaming.png)

- Enable/Disable Renaming of your books (as opposed to leaving the names that are currently there or as they were when you downloaded them).
- If you want illegal characters replaced or removed (`\ / : * ? " < > | ~ - % & + { }`).
- Here you will select the naming convention for the actual book files. Note that the Book folder name is defined here as well.
- `(Advanced Option) This is where you will set the naming convention for the Author folder.`

> This does not apply if Calibre is used as Calibre handles file/folder naming using its own internal schema.
{.is-info}

# Folders

![folders.png](/assets/readarr/folders.png)

- (Advanced Option) Create Empty Author Folders - Enable to create empty author folders when a new author is added to Readarr.
- (Advanced Option) Delete Empty Folders - Enable to delete empty author folders when there are no remaining books for that author.

> One of those boxes can be checked, but they should not BOTH be checked. {.is-warning}

> This does not apply if Calibre is used as Calibre handles file/folder naming using its own internal schema.
{.is-info}

# Importing

![importing.png](/assets/readarr/importing.png)

- (Advanced Option) Skip Free Space Check - If enabled skip checking free space prior to importing
- (Advanced Option) Minimum Free Space - Enter the minimum free space for the drive to have before importing stops.
- (Advanced Option) Use Hardlinks instead of Copy - Check this box to use Hardlinks instead of Copies (for Torrents). Note that this is enabled by default.
  
> You should ideally use this wherever possible. In order for hardlinks to be used, you must have your source/destination on the same file system (drive, partition) and mount points. [See TRaSH's Hardlink Guide for more information](https://trash-guides.info/hardlinks/)
  
- Import Extra Files - If enabled import specified extra files located within the folder of the book when its imported
- (Advanced Option) Import Extra Files - If Import Extra Files is enabled enter a comma separated list of extensions to import.

> If you are using Readarr for audiobooks, you should add .cue to this list, as it holds your chapter information!

# File Management

![filemanagement.png](/assets/readarr/filemanagement.png)

- Books deleted from disk are automatically unmonitored in Readarr.


- Ignore Deleted Books - Check this box to unmonitor books detected as deleted or inaccessible from Readarr's root folder.
- Download Proper & Repacks - Whether or not to automatically upgrade to Propers/Repacks. Use `Do not Prefer` to sort by preferred word score over propers/repacks
  - Prefer and Upgrade - Rank repacks and propers higher than non-repacks and non-propers. Treat new repacks and propers as upgrade to current releases.
  - Do Not Upgrade Automatically - Rank repacks and propers higher than non-repacks and non-propers. Do not treat new repacks and propers as upgrade to current releases.
  - Do Not Prefer - Effectively this ignores repacks and propers. You'll need to manage any preference for those with [Preferred Words](#release-profiles).
- > `PROPER` - means there was a problem with the previous release. Downloads tagged as PROPER shows that the problems have been fixed in that release. This is done by a Group that did not release the original. {.is-info}
- > `REPACK` - means there was a problem with the previous release and is corrected by the original Group. Downloads tagged as REPACK shows that the problems have been fixed in that release. This is done by a Group that did release the original.{.is-info}

- (Advanced Option) Watch Root Folders for file changes - Check this box to trigger a rescan when it is detected that the root folder had changes.
- (Advanced Option) Rescan Author Folder after Refresh -  Choose when to rescan an author folder after refreshing the author.
  - Always - This will rescan author folders based upon Tasks Schedule
  - After Manual Refresh - You will have to manually rescan the disk
  - Never - Just as it says, never rescan the author folders.
- (Advanced Option) Allow Fingerprinting - Choose how to handle fingerprinting, which allows increased accuracy for book matching, at the expense of CPU/disk time.
  - Always - Always use fingerprinting if possible
  - For new imports only - Only fingerprint newly imported releases
  - Never - Just as it says, never use fingerprinting
- (Advanced Option) Change File Date - Change file date on import/rescan
  - None - Readarr will not change the date that shows in your given file browser
  - Book Release Date - The date the book was released.
- (Advanced Option) Recycling Bin - Book files will go here when deleted instead of being permanently deleted
- (Advanced Option) Recycling Bin Cleanup - This is how old a given file can be before it is deleted permanently

> It is highly recommended that you use a Recycling Bin. It's easy to delete files, and recovering them is easy if you use the bin.

# Root Folders and Calibre Integration

![rootfolders1.png](/assets/readarr/rootfolders1.png)

Here we will add the root folder that Readarr will be using to import your existing organized media library and where Readarr will be importing (copy/hardlink/move) your media after your download client has downloaded it.

> **The user and group you configured Readarr to run as must have read & write access to this location.** {.is-info}

You may also elect to use Calibre to manage your library on this screen. Doing so will require you to run the Calibre Content Server. This is NOT Calibre-Web.

> If you are going to use Calibre, the books you want to have Readarr recognize on initial library import **must already be in Calibre**.  Books within the folder and not in Calibre will be ignored.
> **Note that you cannot add Calibre integration to a root folder after it's created.**
{.is-danger}

> Your download client downloads to a download folder, and Readarr imports it to your media folder (final destination) that your media server uses. Your download folder and media folder can’t be the same location! {.is-warning}

Don’t forget to save your changes.

## Calibre Content Server (Optional)

If you are going to use Calibre to manage your books, you need to set up the Calibre Content Server. Again, this is not Calibre-Web, but a piece of Calibre itself. You must be running Calibre, and you must set up the Content Server.

> Please note that while Readarr is in beta; if you use Calibre it is recommended to disable Renaming in Readarr just in case an unintended bug slips through. {.is-info}

To do this, open Calibre, and click `Preferences / Sharing over the net`

![calibreprefs.png](/assets/readarr/calibreprefs.png)

First, add a user account. The account DOES need "make changes" access.

![calibreacct.png](/assets/readarr/calibreacct.png)

Then you will need to restart Calibre. Once back in, configure and start up the content server. It should show you that it's running. Set it to run automatically on startup. After saving, you will again need to restart Calibre. Make sure the sever is started when it comes back up, then you can move to the next section.

> You must select "Require username and password to access the content server" in order for Readarr to properly work. If you do not, you will get an error that says "Anonymous users are not allowed to make changes" when Readarr import a book!

![calibreserver.png](/assets/readarr/calibreserver.png)

## Calibre Integration

![calibre1.png](/assets/readarr/calibre1.png)

If you have chosen Calibre integration, you will enter the necessary values here.

- Calibre Host - Host (e.g. ip or container name) where Calibre Content Server is running.
- Calibre Port - the port Calibre Content Server uses (default 9900).
- (Advanced Option) Calibre URL Base - the url base for Calibre Content Server, typically only needed with Reverse Proxies
- Username - username you created for the Content Server goes here.
- Password - password you entered for the Content Server goes here.
- Calibre Library - enter a specific Calibre library to use, or leave it blank for the default library

![calibre2.png](/assets/readarr/calibre2.png)

- When a book is sent to Calibre, the option is available to run an auto-convert process in Calibre to your desired format(s).
- You can change the output profile for Calibre here if you need to.
- If Calibre Content Server is running on an https address, check this box.
- When you connect Calibre, it will import all of your authors. This determines the monitor flag for those authors' books.
- Select the quality profile to use for authors' books in Calibre.
- Select the metadata profile to use for authors' books in Calibre.
- If you want to apply a tag in Readarr for these authors, enter that here.

>If you add an individual book, and select `None`\* for the [metadata profile](/readarr/settings#metadata-profiles), only that book will show up under the author when it's added. If you want other books for that author added, choose an appropriate metadata profile.
> \* **Note that `None` does not apply any metadata filters and you may get unwanted foreign editions. To work around these [create a metadata profile as prescribed in the faq](/readarr/faq#metadata-profile-none-allowing-foreign-releases)**
{.is-warning}

# Download Clients

`Settings` => `Download Clients`

![Readarr-settings-download-clients.png](/assets/readarr/Readarr-settings-download-clients.png)

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn’t one right setup and everyone’s setup can be a little different. But there are many wrong setups.

[See the Settings Page for details](/readarr/settings#download-clients)

## {.tabset}

### Usenet

{#usenet}

- Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Readarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
- When the download is completed, Readarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder and accessible by Readarr
- Readarr will scan that completed file location for files that Readarr can use. It will parse the file name to match it against the requested media. If it can do that, it will rename the file according to your specifications, and move it to the specified media location.
- Atomic Moves (instant moves) are enabled by default. The file system and mounts must be the same for your completed download directory and your media library. If the the atomic move fails or your setup does not support hardlinks and atomic moves then Readarr will fall back and copy the file then delete from the source which is IO intensive.
- If the "Completed Download Handling - Remove" option is enabled in Readarr's settings leftover files from the download will be sent to your trash or recycling via a request to your client to delete/remove the release.

### BitTorrent

{#bittorrent}

- Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
  - Examples: movies, tv, series, music, etc.
- Readarr will monitor your download clients active downloads that use that category name. This monitoring occurs via your download client's API.
- Completed files are left in their original location to allow you to seed the file (ratio or time can be adjusted in the download client or from within Readarr under the specific download client). When files are imported to your media folder Readarr will hardlink the file if supported by your setup or copy if not hardlinks are not supported.
- Hardlinks are enabled by default. A hardlink will allow not use any additional disk space. The file system and mounts must be the same for your completed download directory and your media library. If the hardlink creation fails or your setup does not support hardlinks then Readarr will fall back and copy the file.
- If the "Completed Download Handling - Remove" option is enabled in Readarr's settings, Readarr will delete the torrent from your client and qsk the client to remove the torrent data, but only if the client reports that seeding is complete and torrent is stopped (paused on completion).
