---
title: Readarr Quick Start Guide
description: 
published: true
date: 2021-06-05T17:21:52.383Z
tags: readarr
editor: markdown
dateCreated: 2021-05-25T00:08:13.267Z
---

In this guide we will try to explain the basic setup you need to do to get started as quickly as possible with Readarr.

There are a lot more settings you may need or want. They can be found at the [settings]( /readarr/settings) page.

> Please note that within the screenshots and GUI settings in `orange` are advanced options, so you'll need to enable those to make them visible.

After installation and starting up, you open a browser and go to `http://ip_where_installed:8787`

## Media Management

First we’re going to take a look at the `Media Management` settings where we can setup our preferred naming and file management settings.

`Settings` => `Media Management`

![mediamanagement.png](/assets/readarr/mediamanagement.png)

## Book Naming

![booknaming.png](/assets/readarr/booknaming.png)

- Enable/Disable Renaming of your books (as opposed to leaving the names that are currently there or as they were when you downloaded them).
- If you want illegal characters replaced or removed (`\ / : * ? " < > | ~ - % & + { }`).
- Here you will select the naming convention for the actual book files. Note that the Book folder name is defined here as well.
- `(Advanced Option) This is where you will set the naming convention for the Author folder.`

## Folders

![folders.png](/assets/readarr/folders.png)

- `(Advanced Option) Enable to create empty author folders when a new author is added to Readarr.`
- `(Advanced Option) Enable to delete empty author folders when there are no remaining books for that author.`

## Importing

![importing.png](/assets/readarr/importing.png)

- `(Advanced Option) Designate the required minimum free space that must be available on your drive in order for books to be imported.`
- `(Advanced Option) Enable`Use Hardlinks instead of Copy`more info how and why with examples [TRaSH's Hardlinks Guide](https://trash-guides.info/hardlinks).`
- `(Advanced Option) Import matching extra files (nfo, etc) after importing a file.`

## File Management

![filemanagement.png](/assets/readarr/filemanagement.png)

- Books deleted from disk are automatically unmonitored in Readarr.

- You may want to delete a book, and do not want Readarr to re-download the book later. You would use this option.

- How you want Readarr to handle PROPER and REPACK for replacement of your books.
- Check to watch root folders for file changes and update Readarr appropriately.
- Change behavior on how Readarr rescans author folders when a change is detected.
- Change behavior on how Readarr matches books using fingerprinting. This can impact CPU usage.
- Change the file date on imports to the book's release date.
- `(Advanced Option) Designate a location for deleted files to go to (just in case you want to retrieve them before the bin is taken out).`
- `(Advanced Option) This is how old a given file can be before it is deleted permanently.`

## Root Folders and Calibre Integration

![rootfolders1.png](/assets/readarr/rootfolders1.png)

Here we will add the root folder that Readarr will be using to import your existing organized media library and where Readarr will be importing (copy/hardlink/move) your media after your download client has downloaded it.

You may also elect to use Calibre to manage your library on this screen. Doing so will require you to run the Calibre Content Server. This is NOT Calibre-Web.

>Your download client downloads to a download folder, and Readarr imports it to your media folder (final destination) that your media server uses. Your download folder and media folder can’t be the same location!

Don’t forget to save your changes.

### Calibre Content Server (Optional)

If you are going to use Calibre to manage your books, you need to set up the Calibre Content Server. Again, this is not Calibre-Web, but a piece of Calibre itself. You must be running Calibre, and you must set up the Content Server.

To do this, open Calibre, and click `Preferences / Sharing over the net`

![calibreprefs.png](/assets/readarr/calibreprefs.png)

First, add a user account. The account does not need "make changes" access.

![calibreacct.png](/assets/readarr/calibreacct.png)

Then you will need to restart Calibre. Once back in, configure and start up the content server. It should show you that it's running. Set it to run automatically on startup. After saving, you will again need to restart Calibre. Make sure the sever is started when it comes back up, then you can move to the next section.

> You must select "Require username and password to access the content server" in order for Readarr to properly work. If you do not, you will get an error that says "Anonymous users are not allowed to make changes" when Readarr import a book!

![calibreserver.png](/assets/readarr/calibreserver.png)

### Calibre Integration

![calibre1.png](/assets/readarr/calibre1.png)

If you have chosen Calibre integration, you will enter more values here.

- The Calibre Host is where Calibre Content Server is running.
- The Calinre Port is the port Calibre Content Server uses (default 9900).
- If you are running with a URL base, enter that here.
- The username you created for the Content Server goes here.
- The password you entered for the Content Server goes here.
- You can choose a specific Calibre library to use, or leave it blank for the default.

![calibre2.png](/assets/readarr/calibre2.png)

- When a book is sent to Calibre, the option is available to run an auto-convert process in Calibre to your desired format(s).
- You can change the output profile for Calibre here if you need to.
- If Calibre Content Server is running on an https address, check this box.
- When you connect Calibre, it will import all of your authors. This determines the monitor flag for those authors' books.
- Select the quality profile to use for authors' books in Calibre.
- Select the metadata profile to use for authors' books in Calibre.
- If you want to apply a tag in Readarr for these authors, enter that here.
