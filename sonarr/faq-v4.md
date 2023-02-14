---
title: Sonarr v4 Beta FAQ
description: Sonarr v4 Beta FAQ
published: true
date: 2022-12-29T12:48:11.121Z
tags: 
editor: markdown
dateCreated: 2022-11-25T14:02:10.493Z
---

# Sonarr v4 Beta FAQ

> Sonarr v4 is currently in beta, and as such errors and issues are to be expected. Please use our support channels to ask questions, report issues or provide feedback with the v4 beta. If necessary you may be asked to open an issue on Github, if you're asked to open an issue on [Github](https://github.com/Sonarr/Sonarr). Please provide a link to the original discussion along with all other requested information. {.is-warning}

## Can I disable forced authentication?

- If Sonarr is exposed externally then you are required - including increasingly required by most Trackers and Indexers - to have authentication in front of Sonarr.
  - If you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by shutting down the app, setting `<AuthenticationMethod>External</AuthenticationMethod>` in the [config file](/sonarr/appdata-directory), and restarting the app. **Note that multiple `AuthenticationMethod` entries in the file are not supported and only the topmost will be used**
- If you do not expose Sonarr externally or do not wish to have auth required for local access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>`
  
## Where have language profiles gone?

- Languages are handled differently in Sonarr v4. They are no longer managed via the old Language Profiles system, but are now part of custom formats. You will need to create custom formats for languages that you desire to grab, and then add these custom formats to your quality profiles with a rating appropriate to enforce a grab of that language.

### Only English

- If you only want to grab releases in English then you can use the following custom format. Import this custom format, and then assign it to each of your quality profiles with a score of -10000. Assuming your minimum custom format score is 0 then this will reject all releases that are not parsed as English.

```json
{
  "name": "Reject Non English",
  "includeCustomFormatWhenRenaming": false,
  "specifications": [
    {
      "name": "Non English",
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

## My Nginx doesn't work anymore?

- Due to changes in the backend of Sonarr (migration from mono to donnet) your Nginx conf file will need changing. Replace this line:

  ```nginx
     proxy_set_header   Host $proxy_host;
   ```

  with this line:

  ```nginx
    proxy_set_header   Host $host;
  ```
