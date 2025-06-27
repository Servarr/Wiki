---
title: Readarr Metadata Issues (Retired)
description: Summary of Readarr metadata issues
published: true
date: 2025-06-17T11:58:13.112Z
tags: 
editor: markdown
dateCreated: 2024-08-23T18:20:51.850Z
---

# Announcement: Retirement of Readarr 2025-06-27

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

# Readarr Metadata Server Updates

> The Servarr dev team would like another dev/team to take over the readarr project. Otherwise it's probably just going to atrophy until it's unusable.
{.is-danger}

> Help is wanted in pulling the ~1200 Sonarr cherry-picks from upstream and other development work. The priority would be 1) What you want to fix, 2) [Oldest sonarr-pulls first](https://github.com/Readarr/Readarr/issues?q=is%3Aopen+is%3Aissue+label%3Asonarr-pull), 3) Other fixes related to what's been pulled, 4) Everything else
{.is-warning}

Below are the summarized issues of the Readarr Metadata Server.
For the latest updates please refer to the pinned messages in the [Readarr Discord](https://readarr.com/discord)

## Migration from Goodreads to OpenLibrary

### The Future and Open Library

> **It is only anticipated that Open Library will resolve the 'Large Author Issue' and similar GoodRead's Specific Issues** It is likely it will resolve the 522 / similar metadata issues as well.
{.is-warning}

Due to continuous GoodReads issues - work has begun by a [community member](https://github.com/Saghen/open-library-proxy) and is also being poked at by one of the Servarr Development Team members to migrate to [OpenLibrary](https://openlibrary.org/).  Note that Readarr effectively has no active developers at this time and given the berth of the project it will be slow moveing.  If you wish to assist with this - please visit us on Discord, acquire the Tester role and meet us in the appropiate channel.  Please do not ask for updates as that is not productive and updates will be shared as progress progresses.

> Our priority is definitely trying to do this in a way that we do not lose any of the existing libraries - there is a mapping exercise we need to do in the back end to map between goodreads ID and the openlibrary IDs which I believe ISBN is the only solution to at the moment. However this will take a lot of work not just at the metadata server end, but also on the client app end as a migration will be required there for all users to make use of it. This is not a small piece of work due to this.
{.is-info}

> We are expecting the new meta to be able to take GR IDs and translate, so the readarr code changes should be minimal at first (I would rather confirm it's working before looking at the client migration), but yes pretty much spot on. The expectation is that it doesn't break anyones existing Readarr in the process and it will fully function.
{.is-info}

#### Community Container

> These are unofficial repositories and not official nor endorsed by the Servarr Team use at your own risk
{.is-danger}

1. https://github.com/santarrsgrotto/readarr-docker - a Docker compose setup for running Readarr with the custom metadata server, which if you just want to help test on the client side then feel free to {Instructions Removed - Please visit discord for details}

1. https://github.com/santarrsgrotto/readarr-server - A full metadata server designed for use with a PostgreSQL database containing Open Library data, based on Saghen's work. To use this you will need to install the prerequisites first. This is very much still alpha quality, it should broadly speaking work and has a level of ratings and series support and a full text search, but it needs lots of testing.

1. https://github.com/santarrsgrotto/mapping - A mapping of Goodreads IDs to Open Library IDs in CSV format as well as some scripts to load said CSVs into the same database as the Open Library data. This repository is ~750 MB so please don't clone it unless you're fully committed to helping on the server side of this since GitHub has bandwidth restrictions. This mapping is also not complete yet, and I will be making updates.

#### Current Status

A proof-of-concept container has been created and initial integration is ongoing.  It's been identified the main next outstanding steps are

  1. continuing OL to GR mapping
  1. updating, enhancing, and cleaning up OpenLibrary Metadata
  1. Implementing the metadata using the recent changes endpoint and applying them from OL

### Why can we not just use OpenLibrary Directly?

- Due to the large amount of data readarr uses, the dump is providing the base of the data in the BookInfo metadata service to cache it.

### Why can we not just use the Metadata Provider Directly or use a user selectable provider?

- If you throw all that directly at the source, it's either against their policy, or going to be very expensive.
- We do not support directly hitting any metadata service that isn't our own in order to reduce likelihood of a website blocking our user-agent etc.

### BookInfo

BookInfo is the Servarr Readarr GoodReads Metadata Proxy. Similar to Skyhook for Sonarr.

### Legacy Goodreads Metadata Server

- Why is the meta server not OSS?
  - It is due to the fact that we use goodreads, and they have killed off access to their API, so even if it was OS no one could run it as goodreads will not provide new access to their API.


# Metadata Server Issues

## 2025-06 522 Issues

- As Of: 2025-06-17
- Updated: 2025-06-17

- This looks to impact all use of the metadata server. The issue is characterised by a 522 error from the Metadata server.
- We don't currently know what causes this - possibly Digital Ocean or Cloudflare DNS problems, but devs have been notified and will sort it out as soon as possible. We apologise for the inconvenience.

## 2024-12 522 Issues

> Resolved: As of 2024-12-28
{.is-success}

- As Of: 2024-12-13
- Updated: 2024-12-28

- The metadata server is having issues and effectively dead in the water. The devs are aware. There is nothing feasible that can be done at this time by the community for a specific metadata server issue (unrelated to Goodreads as the source). Please assist the community with the OpenLibrary conversion or the `sonarr-pull` Readarr github issues that need to be cherry-picked into Readarr.

## Other Updates

> The metadata issue was fixed on 9/17. We are still seeing a couple of 429 rate limits and a couple of failed searches, presumably while things get re-cached again and they will continue to improve as time goes on. I have not seen any issues with imports, only with searches to add authors or books. This does not fix the large author issue below, or the 3 month metadata delay. Both of those issues are being worked on with a change to OpenLibrary as the source of data, but that work is long and ongoing (you can self-apply a `!tester` role to yourself and follow along in the [#readarr-ol](https://discord.com/channels/264387956343570434/1278408662188036156) channel to see how that project is coming along, if you're curious). These are 2 separate, concurrent issues that are being solved that do not interconnect. As always, the metadata server is not open source, and there is nothing you can do to help with that part of the issue except to be patient. Dev help is not being solicited/accepted on the metadata server side of things. There are 900+ open issues on the readarr github if you're anxious to help us out. Please start there. This pin will be updated with current information. If you're reading this pin, this is the most current, accurate information about the metadata server, and there is no need to ask in the channel if things have changed.
{.is-info}

## BookInfo Server Error HTTP 500

> Resolved: As of 2024-09-17
{.is-success}

- As Of: 2024-09-14
- Updated: 2024-09-14

Text searches seem to be having a bit of a flaky issue, because it does that search directly on Goodreads to get the ID and then searches the metadata server for that ID. To shortcut the problem, use ID based searches directly.

## Rate Limiting

> Resolved: As of 2024-09-17
{.is-success}

- As Of: ~~2024-05-22~~ 2024-09-14
- Updated: 2024-09-17
- Impact: Log Entries of `BookInfo returned 429, backing off for `
  - The metadata server appears to be having some further issues with 429's. There's not much you can do, although doing ID based searches are better than doing text string searches where possible. The devs have been made aware of the issue (which began on the evening of 9/14), and this pin will updated when there is a change in status. If this pin is up, it's still an issue, no need to ask.
  - ~~Readarr's metadata server is getting a lot of rate limiting because of the downtime and everyone's systems hitting it to get list imports, etc. This is expected to slow things down for a week or two until everything is running like normal again. If you're trying to import, or search, etc. and those things are slow or failing, your logs will indicate a 429 error. This will get better. Please have some patience and it will resolve in time.~~
  - ~~The metadata server is struggling. Something occurred on 2024-07-31 that caused it, and it hasn't been able to be corrected yet. It works. You will see 429's a LOT. Sometimes it's better than other times. Hopefully it will be corrected soon. When that happens, I will update here. There is nothing you can do to help but wait and be patient. It is not an issue on your end.~~
  - ~~The 429 messages are due to a metadata server issue. This impacts all searches for books or authors, imports, list additions, etc. Anything that hits the metadata server.~~
  - **The metadata server cannot be self-hosted or changed. The only thing you can do is be patient and wait. It will work, but slowly. There is nothing you can do to help in the meantime.**
  - It's not you, it's us.
  - Please be patient, it will eventually get better, but we have no timeline on when that might happen. The pins, as always, have the most current information and will be updated if/when something changes.

## Data Delays

> Readarr's metadata server appears to be functioning normally with no 429 or cache issues. As always, I will update this pin if things change. All pins are the current state of readarr and if anything changes, the pins will be updated accordingly.
{.is-success}

- As Of: 2024-04-17
- Updated: 2024-09-09
- Impact: It's functioning, approximately 3 months behind. If you have a book that was added to Goodreads less than 3 months ago, it probably is not going to show up yet.

## Large Authors

- As Of: 2023
- Updated: 2024-09-09
- Impact:
  - Large authors are still not working, and will not be for a while. A partial, but not exhaustive, list of those authors: Stephen King, Isaac Asimov, Leo Tolstoy, Fyodor Dostoevsky, Arthur Conan Doyle, Stephen Fry, Agatha Christie, Arthur C. Clarke, Oscar Wilde, Jack London, Neil Gaiman, Charles Dickens, Jane Smiley, Vladimir Nabokov, Bernard Cornwall, D.H. Lawrence. 
  -  For large authors, you cannot do anything to add either the author OR their individual books. There is no workaround.
  - The eventual move from Goodreads to OpenLibrary will resolve this.

## Github Issues

- [Readarr #2783: Metadata Server Issues (429) & Authors with missing books / Authors not found](https://github.com/Readarr/Readarr/issues/2783)
- [Readarr #3486: Migrate to OpenLibrary as Metadata Backend](https://github.com/Readarr/Readarr/issues/3486)
{.links-list}
