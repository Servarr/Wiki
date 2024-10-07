---
title: Readarr Metadata Issues
description: Summary of Readarr metadata issues
published: true
date: 2024-10-07T21:10:59.838Z
tags: 
editor: markdown
dateCreated: 2024-08-23T18:20:51.850Z
---

# Readarr Metadata Server Updates

Below are the summarized issues of the Readarr Metadata Server.
For the latest updates please refer to the pinned messages in the [Readarr Discord](https://readarr.com/discord)

## Metadata Server Information

### The Future and Open Library

> **It is only anticipated that Open Library will resolve the 'Large Author Issue' and similar GoodRead's Specific Issues**
{.is-warning}

Due to continuous GoodReads issues - work has begun by a [community member](https://github.com/Saghen/open-library-proxy) and is also being poked at by one of the Servarr Development Team members to migrate to [OpenLibrary](https://openlibrary.org/).  Note that Readarr effectively has no active developers at this time and given the berth of the project it will be slow moveing.  If you wish to assist with this - please visit us on Discord, acquire the Tester role and meet us in the appropiate channel.  Please do not ask for updates as that is not productive and updates will be shared as progress progresses.

Per the community user:

> The replacement metadata server is close to completion which should resolve the issue for everyone in the meantime. If you're referring to switching to book-based instead of author-based, I don't think that's blocking.
{.is-info}

Per the Servarr Team:

> Our priority is definitely trying to do this in a way that we do not lose any of the existing libraries - there is a mapping exercise we need to do in the back end to map between goodreads ID and the openlibrary IDs which I believe ISBN is the only solution to at the moment. However this will take a lot of work not just at the metadata server end, but also on the client app end as a migration will be required there for all users to make use of it. This is not a small piece of work due to this.

#### Why can we not just use OpenLibrary Directly?

As per docs you are not allowed to do that, that’s why they provide data dumps.

### Why can we not just use the Metadata Provider Directly?

If you throw all that directly at the source, it's either against their policy, or going to be very expensive

### BookInfo

BookInfo is the Servarr Readarr GoodReads Metadata Proxy. Similar to Skyhook for Sonarr.

### Metadata Server

- Why is the meta server not OSS?
  - It is due to the fact that we use goodreads, and they have killed off access to their API, so even if it was OS no one could run it as goodreads will not provide new access to their API

## Metadata Server Issues

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
