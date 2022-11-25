---
title: Sonarr v4 Beta FAQ
description: Unlinked Sonarr v4 Beta FAQ
published: true
date: 2022-11-25T14:02:10.493Z
tags: 
editor: markdown
dateCreated: 2022-11-25T14:02:10.493Z
---

# Sonarr v4 Beta FAQ

## Can I disable forced authentication?

- If Sonarr is exposed externally then you are required - including increasingly required by most Trackers and Indexers - to have authentication in front of Sonarr.
  - If you use an **external authentication** such as Authelia, Authetik, NGINX Basic auth, etc. you can prevent needing to double authenticate by adding `<AuthenticationMethod>External</AuthenticationMethod>` to the config file
- If you do not expose Sonarr externally or do not wish to have auth required for local access then change in Settings => General Security => Authentication Required to `Disabled For Local Addresses`
  - The config file equivalent of this is `<AuthenticationType>DisabledForLocalAddresses</AuthenticationType>
