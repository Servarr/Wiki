---
title: Readarr Custom Scripts (Retired)
description:
published: true
date: 2022-05-02T03:36:38.595Z
tags: readarr, needs-love, custom scripts
editor: markdown
dateCreated: 2021-06-23T06:41:11.792Z
---

# Announcement: Retirement of Readarr

We would like to announce that the [Readarr project](https://github.com/Readarr/Readarr) has been retired. This difficult decision was made due to a combination of factors: the project's metadata has become unusable, we no longer have the time to remake or repair it, and the community effort to transition to using Open Library as the source has stalled without much progress.

Third-party metadata mirrors exist, but as we're not involved with them at all, we cannot provide support for them. Use of them is entirely at your own risk. The most popular mirror appears to be [rreading-glasses](https://github.com/blampe/rreading-glasses).

Without anyone to take over Readarr development, we expect it to wither away, so we still encourage you to seek alternatives to Readarr.

## Key Points

- Effective Immediately: The retirement takes effect immediately. Please stay tuned for any possible further communications.
- Support Window: We will provide support during a brief transition period to help with troubleshooting non metadata related issues.
- Alternative Solutions: Users are encouraged to explore and adopt any other possible solutions as alternatives to Readarr.
- Opportunities for Revival: We are open to someone taking over and revitalizing the project. If you are interested, please get in touch.
- Gratitude: We extend our deepest gratitude to all the contributors and community members who supported Readarr over the years.

Thank you for being part of the Readarr journey. For any inquiries or assistance during this transition, please contact our team.

Sincerely,
The Servarr Team

If you're looking to trigger a custom script, you can find more details here. Scripts are added to Readarr via the [Connect Settings](/readarr/settings#connections).

# Overview

Readarr can execute a custom script when a book is newly imported or renamed. Depending on the action, different parameters are supplied. Parameters are passed to the script through environment variables.

## Readarr Logs

Note that the following will only be logged for custom scripts:

- Script `stdout` output will be logged as `Debug`
- Script `stderr` output will be logged as `Info`
- The trigger of the script will be logged in `Trace`

# Environment Variables

## On Grab

| Environment Variable               | Details                                     |
| ---------------------------------- | ------------------------------------------- |
| `readarr_eventtype`                | `Grab`                                      |
| `readarr_author_id`                | Internal ID of the author                   |
| `readarr_author_name`              | Name of the author                          |
| `readarr_author_grid`              | Author goodreads id                         |
| `readarr_release_bookcount`        | Number of books in the release              |
| `readarr_release_bookreleasedates` | Release date of the book                    |
| `readarr_release_booktitles`       | Book titles of the release                  |
| `readarr_release_bookids`          | Book id                                     |
| `readarr_release_grids`            | Goodreads ids of the release                |
| `readarr_release_title`            | Title of the book                           |
| `readarr_release_indexer`          | Indexer from which the release was grabbed  |
| `readarr_release_size`             | Release size                                |
| `readarr_release_quality`          | Release quality                             |
| `readarr_release_qualityVersion`   | Release quality version                     |
| `readarr_release_releasegroup`     | Release group (empty if unknown)            |
| `readarr_download_client`          | Download client use to download the release |
| `readarr_download_id`              | Download id                                 |

## On Import/On Upgrade

| Environment Variable       | Details                                     |
| -------------------------- | ------------------------------------------- |
| `readarr_eventtype`        | `Download`                                  |
| `readarr_author_id`        | Internal ID of the author                   |
| `readarr_author_name`      | Name of the author                          |
| `readarr_author_path`      | Path of the Author                          |
| `readarr_author_grid`      | Author goodreads id                         |
| `readarr_book_id`          | Book's id                                   |
| `readarr_book_title`       | Book's title                                |
| `readarr_book_grid`        | Book's Goodreads id                         |
| `readarr_book_releasedate` | Release date of the book                    |
| `readarr_download_client`  | Download client use to download the release |
| `readarr_download_id`      | Download id                                 |

## On Rename

| Environment Variable  | Details                   |
| --------------------- | ------------------------- |
| `readarr_eventtype`   | `Rename`                  |
| `readarr_author_id`   | Internal ID of the author |
| `readarr_author_name` | Name of the author        |
| `readarr_author_path` | Path of the Author        |
| `readarr_author_grid` | Author goodreads id       |

## On Book Retag

| Environment Variable              | Details                   |
| --------------------------------- | ------------------------- |
| `readarr_eventtype`               | `TrackRetag`              |
| `readarr_author_id`               | Internal ID of the author |
| `readarr_author_name`             | Name of the author        |
| `readarr_author_path`             | Path of the Author        |
| `readarr_author_grid`             | Author goodreads id       |
| `readarr_book_id`                 | Book's id                 |
| `readarr_book_title`              | Book's title              |
| `readarr_book_grid`               | Book's Goodreads id       |
| `readarr_book_releasedate`        | Release date of the book  |
| `readarr_bookfile_id`             | Book file id              |
| `readarr_bookfile_path`           | Path to the book          |
| `readarr_bookfile_quality`        | Book file quality         |
| `readarr_bookfile_qualityversion` | Book file quality version |
| `readarr_bookfile_releasegroup`   | Release group of the book |
| `readarr_bookfile_scenename`      | Scene name of the book    |
| `readarr_tags_diff`               | Tags differences          |
| `readarr_tags_scrubbed`           | Tags scrubbed             |

## On Health Issue

| Environment Variable           | Details                                                      |
| ------------------------------ | ------------------------------------------------------------ |
| `readarr_eventtype`            | `HealthIssue`                                                |
| `readarr_health_issue_level`   | Type of health issue (`Ok`, `Notice`, `Warning`, or `Error`) |
| `readarr_health_issue_message` | Message from the health issue                                |
| `readarr_health_issue_type`    | Area that failed and triggered the health issue              |
| `readarr_health_issue_wiki`    | Wiki URL (empty if does not exist)                           |

## On Test

When adding the script to Readarr and clicking 'Test,' the script will be invoked with the following parameters. The script should be able to gracefully ignore any unsupported event type.

| Environment Variable | Details |
| -------------------- | ------- |
| `readarr_eventtype`  | `Test`  |
