---
title: Sonarr v4 FAQ
description: Sonarr v4 FAQ
published: true
date: 2025-03-30T15:42:44.052Z
tags: 
editor: markdown
dateCreated: 2022-11-25T14:02:10.493Z
---

# Sonarr v4 FAQ

## What Changed?

Refer to the [v4 release announcement](https://forums.sonarr.tv/t/sonarr-v4-released/33089) for more information

Below are some of the highlights and more prominent changes:

- [Sonarr v4 FAQ](#sonarr-v4-faq)
  - [What Changed?](#what-changed)
  - [Forced Authentication](#forced-authentication)
    - [Authentication Method](#authentication-method)
    - [Authentication Required](#authentication-required)
  - [Preferred Words to Custom Formats Migration](#preferred-words-to-custom-formats-migration)
    - [Must (not) contain](#must-not-contain)
    - [File Naming Tokens](#file-naming-tokens)
  - [Where have language profiles gone?](#where-have-language-profiles-gone)
    - [Only English](#only-english)
    - [Only Original](#only-original)
  - [My Reverse Proxy doesn't work anymore?](#my-reverse-proxy-doesnt-work-anymore)
    - [Nginx](#nginx)
    - [Apache](#apache)
  - [What is this new "*Override and add to download queue*" button?](#what-is-this-new-override-and-add-to-download-queue-button)
  - [Where has the Mass Editor gone?](#where-has-the-mass-editor-gone)
  - [Episodes showing runtimes of 0](#episodes-showing-runtimes-of-0)

## Forced Authentication

If Sonarr is exposed so that the UI can be accessed from outside your local network then you should have some form of authentication method enabled in order to access the UI. This is also increasingly required by Trackers and Indexers.

As of Sonarr v4, Authentication is Mandatory.

- `AuthenticationRequired` and `AuthenticationMethod` are mandatory required attributes in the configuration file.

### Authentication Method

- `Basic` (Browser pop-up) - This option when accessing your Sonarr will show a small pop-up allowing you to input a Username and Password
- `Forms` (Login Page) - This option will have a familiar looking login screen much like other websites have to allow you to log onto your Sonarr
- `External` - Configurable via Config File Only
  - Disables authentication completely. Suggested only if you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](/sonarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost value will be used**

### Authentication Required

- If you do not expose the app externally and/or do not wish to have auth required for local (e.g. LAN) access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`
- `<AuthenticationType>Enabled</AuthenticationType>` is also a valid value

## Preferred Words to Custom Formats Migration

The Preferred Words system has been replaced with the Custom Formats system. This allows for much more granularity in the decisions sonarr can make. Whereas preferred words were applicable to all quality profiles, custom formats can be given different levels of importance for each quality profile.

Custom Formats can also be given a cutoff level so that upgrades stop happening once a desired level of preference is reached, whereas the old preferred words system upgraded always if a better release was found.

### Must (not) contain

Must Contain and Must Not Contain remain in the release profile settings as was in v3.

### File Naming Tokens

The `{Preferred Words}` naming token used the term matched on the regex entry for naming in files.
The `{Custom Formats}` naming token uses the Custom Format Name for naming in files.

> It's recommended to screenshot or remove your Preferred Words release profiles PRIOR to upgrading.  Every Preferred Word line will become it's own Custom Format post migration.
{.is-warning}

## Where have language profiles gone?

Languages are handled differently in Sonarr v4. They are no longer managed via the old Language Profiles system, but are now part of Custom Formats. You will need to create custom formats for languages that you desire to grab, and then add these custom formats to your quality profiles with a rating appropriate to enforce a grab of that language.

> See TRaSH Guide's [How to setup Language Custom Formats](https://trash-guides.info/Sonarr/Tips/How-to-setup-language-custom-formats/) for more information
{.is-info}

### Only English

**From [TRaSH => Language: English Only](https://trash-guides.info/Sonarr/Tips/How-to-setup-language-custom-formats/#language-english-only)**

If you only want to grab releases in English then you can use the following custom format. Import this custom format, and then assign it to each of your quality profiles with a score of -10000. Assuming your minimum custom format score is 0 then this will reject all releases that are not parsed as English.

```json
{
  "trash_id": "guide-only",
  "trash_score": "-10000",
  "trash_description": "Language: English Only",
  "name": "Language: Not English",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "Not English Language",
      "implementation": "LanguageSpecification",
      "negate": true,
      "required": false,
      "fields": {
        "value": 1
      }
    }
  ]
}
```

### Only Original

**From [TRaSH => Language: Original Only](https://trash-guides.info/Sonarr/Tips/How-to-setup-language-custom-formats/#language-original-only)**

If you only want to grab releases in The Series's TVDb Original Language then you can use the following custom format. Import this custom format, and then assign it to each of your quality profiles with a score of -10000. Assuming your minimum custom format score is 0 then this will reject all releases that are not parsed as The Series's TVDb Original Language.

```json
{
  "trash_id": "guide-only",
  "trash_score": "-10000",
  "trash_description": "Language: Original Only",
  "name": "Language: Not Original",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "Not Original Language",
      "implementation": "LanguageSpecification",
      "negate": true,
      "required": false,
      "fields": {
        "value": -2
      }
    }
  ]
}
```

## My Reverse Proxy doesn't work anymore?

Due to changes in the backend of Sonarr (migration from mono to donnet) your may not work any more.

### Nginx

  Your Nginx conf file will need changing. Replace this line:
  
  ```nginx
     proxy_set_header   Host $proxy_host;
  ```

  with this line:

  ```nginx
    proxy_set_header   Host $host;
  ```

### Apache

  Your apache virtualhost conf file will need changing. Add this line:

 ```apache2
      ProxyPreserveHost On
 ```

## What is this new "*Override and add to download queue*" button?

When doing an interactive search a second download button has been added titled "Override and add to download queue". This button enables you to do two things:

- Choose which download client the download is sent to. This is useful in the case that you have multiple download clients for the same protocol (e.g. multiple instances of a torrent client) instead of letting Sonarr decide which client to use.
- Override Sonarrs parsing of the release title in case Sonarr has parsed it incorrectly or Sonarr was unable to parse it, but you still want to grab the release. The following parsed fields can be overruled:
  - Series
  - Season Number
  - Episode(s)
  - Quality
  - Language
- *Note that this overruled information is not carried over to the import logic and manual imports may be required*

## Where has the Mass Editor gone?

The Mass Editor standalone page has been removed and the functionality has been merged into the series overview page. To mass edit shows first click the `Select Series` button at the top of the series overview and select the shows you want to edit.

The Season Pass page has also been retired. Part of the functionality remains in the Series Overview editor, choose the table view and  press `Select Series`. Once in select mode hover over the number in the seasons column to access the season pass popover for that show.

## Episodes showing runtimes of 0

v4 uses a per episode run time from TVDb. If the runtime for the episode is 0 it will try to fall back to the series’ runtime.
If the series runtime is also 0 then Sonarr will use a runtime of 45 for any episode that aired within 24 hours of the first episode.
