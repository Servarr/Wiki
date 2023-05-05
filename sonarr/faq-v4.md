---
title: Sonarr v4 Beta FAQ
description: Sonarr v4 Beta FAQ
published: true
date: 2023-04-17T18:42:30.831Z
tags: 
editor: markdown
dateCreated: 2022-11-25T14:02:10.493Z
---

# Sonarr v4 Beta FAQ

> Sonarr v4 is currently in beta, and as such errors and issues are to be expected. Please use our support channels to ask questions, report issues or provide feedback with the v4 beta. If necessary you may be asked to open an issue on Github, if you're asked to open an issue on [Github](https://github.com/Sonarr/Sonarr). Please provide a link to the original discussion along with all other requested information. {.is-warning}

## What Changed?

- See some of the entries below for common upgrade questions and notes.
- Refer to the [v4 beta announcement](https://www.reddit.com/r/sonarr/comments/z3nb82/sonarr_v4_beta/) for more information
  - Forced Authentication
  - Mono => Dotnet (more speed; no more mono)
    - Reverse Proxy [conf updates](#my-nginx-doesnt-work-anymore) are likely required
    - Reverse Proxy [conf updates](#my-apache-doesnt-work-anymore) are likely required
  - Preferred Words are gone and replaced with Custom Formats (see details below)
  - Language Profiles are gone and replaced with Custom Formats (dee details below)
  - Dark/Light Theme
  - SysLog and Instance Name Support
  - Much much more

## Can I disable forced authentication?

- If Sonarr is exposed externally then you are required - including increasingly required by most Trackers and Indexers - to have authentication in front of Sonarr.
  - If you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](/sonarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost will be used**
- If you do not expose Sonarr externally or do not wish to have auth required for local access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`

## Preferred Words to Custom Formats Migration

- Preferred words used the term matched on the regex entry for naming in files.
- Custom Formats use the Custom Format Name for naming in files.

> It's recommended to screenshot or remove your Preferred Words release profiles PRIOR to upgrading.  Every Preferred Word line will become it's own Custom Format post migration.
{.is-danger}

## Where have language profiles gone?

- Languages are handled differently in Sonarr v4. They are no longer managed via the old Language Profiles system, but are now part of Custom Formats. You will need to create custom formats for languages that you desire to grab, and then add these custom formats to your quality profiles with a rating appropriate to enforce a grab of that language.

> See TRaSH Guide's [How to setup Language Custom Formats](https://trash-guides.info/Sonarr/Tips/How-to-setup-language-custom-formats/) for more information
{.is-info}

### Only English

**From [TRaSH => Language: English Only](https://trash-guides.info/Sonarr/Tips/How-to-setup-language-custom-formats/#language-english-only)**

- If you only want to grab releases in English then you can use the following custom format. Import this custom format, and then assign it to each of your quality profiles with a score of -10000. Assuming your minimum custom format score is 0 then this will reject all releases that are not parsed as English.

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

- If you only want to grab releases in The Series's TVDb Original Language then you can use the following custom format. Import this custom format, and then assign it to each of your quality profiles with a score of -10000. Assuming your minimum custom format score is 0 then this will reject all releases that are not parsed as The Series's TVDb Original Language.

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

## My Nginx doesn't work anymore?

- Due to changes in the backend of Sonarr (migration from mono to donnet) your Nginx conf file will need changing. Replace this line:

  ```nginx
     proxy_set_header   Host $proxy_host;
   ```

  with this line:

  ```nginx
    proxy_set_header   Host $host;
  ```
  
  ## My Apache doesn't work anymore?
  - Due to changes in the backend of Sonarr (migration from mono to donnet) your apache virtualhost conf file will need changing. Add this line:
   ```apache2
      ProxyPreserveHost On
    ``` 

## What is this new "*Override and add to download queue*" button?

- When doing an interactive search a second download button has been added titled "Override and add to download queue". This button enables you to do two things:
  - Choose which download client the download is sent to. This is useful in the case that you have multiple download clients for the same protocol (e.g. multiple instances of a torrent client) instead of letting Sonarr decide which client to use.
  - Override Sonarrs parsing of the release title in case Sonarr has parsed it incorrectly or Sonarr was unable to parse it, but you still want to grab the release. The following parsed fields can be overruled:
      - Series
      - Season Number
      - Episode(s)
      - Quality
      - Language
