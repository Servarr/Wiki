---
title: Prowlarr Custom Scripts
description: 
published: true
date: 2021-12-20T16:40:47.702Z
tags: prowlarr, needs-love, custom scripts
editor: markdown
dateCreated: 2021-06-23T06:40:30.916Z
---

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Prowlarr via the [Connect Settings](/prowlarr/settings#connections).

# Overview

Prowlarr can execute a custom script when an episode is newly imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## Prowlarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Info`
- The trigger of the script will be logged in `Trace`

# Environment Variables

## On Health Issue

| Environment Variable            | Details                                                      |
| ------------------------------- | ------------------------------------------------------------ |
| `prowlarr_eventtype`            | `HealthIssue`                                                |
| `prowlarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `prowlarr_health_issue_message` | Message from the health issue                                |
| `prowlarr_health_issue_type`    | Source of the health issue                                   |
| `prowlarr_health_issue_wiki`    | Wiki URL for the health issue (Empty if it does not exist)   |

## On Health Restored

| Environment Variable               | Details                                                      |
| ---------------------------------- | ------------------------------------------------------------ |
| `prowlarr_eventtype`               | `HealthRestored`                                             |
| `prowlarr_health_restored_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `prowlarr_health_restored_message` | Message from the health issue                                |
| `prowlarr_health_restored_type`    | Source of the health issue                                   |
| `prowlarr_health_restored_wiki`    | Wiki URL for the health issue (Empty if it does not exist)   |

## On Application Update

| Environment Variable              | Details                                                      |
| --------------------------------- | ------------------------------------------------------------ |
| `prowlarr_eventtype`              | `ApplicationUpdate`                                          |
| `prowlarr_update_message`         | Message from the update                                      |
| `prowlarr_update_newversion`      | Version Prowlarr updated from (string)                       |
| `prowlarr_update_previousversion` | Version Prowlarr updated to (string)                         |

## On Test

When adding the script to Prowlarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `prowlarr_eventtype` | `Test`  |
