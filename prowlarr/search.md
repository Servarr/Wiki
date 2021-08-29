---
title: Prowlarr Search
description: 
published: true
date: 2021-08-29T04:21:09.575Z
tags: prowlarr
editor: markdown
dateCreated: 2021-06-08T23:31:53.221Z
---

This page will show you how to perform a search from within Prowlarr. In general, your searches would be via app, but it's possible to do them directly in Prowlarr as well.

## Performing a Search

To initiate a search, click on `Search` on the left menu. There will be a mostly blank page with some options at the bottom of the screen.

![search_1_searchscreen.png](/assets/prowlarr/search_1_searchscreen.png)

- Enter your search terms in the Query field.
- Choose your indexers in the Indexers drop-down.  You can check "Usenet" or "Torrents" to select all of the indexers in those categories automatically, or you can select specific indexers for your search from either group.
- Choose the categories you want to search on your indexers from the drop-down. You can select top-level categories (TV, Movies, etc.) to select all of the sub-categories automatically, or you can select specific categories from any of the groups.

Then click on `Search`. Your results may take a few seconds to appear. Once they do, you can add or remove columns using the `Options` button, and you can sort and filter your results by either clicking on the column headers or using the `Filter` button.

You can download the result by clicking on the download icon on the right of the result. This will send it to the proper download client you have configured.

> Anything downloaded will have the category assignment you've set in Prowlarr. This may require a manual import in your app program from a non-standard directory!

## API Endpoints

### RSS Compatible - Single Indexer Feed

- Standard Newznab/Torznab compatible endpoint/parameters.

#### API Key in Query
- http://{prowlarrhost}:{prowlarrport}/{baseurl}/{indexerid}/api?t=search&q=mike&apikey={yourkey}&cat={comma separated list}
  - e.g. `http://192.168.1.100:9696/11/api?t=search&q=mike&apikey={yourkey}&cat=5000,2000`

#### API Key in Header

> Pass `X-Api-Key` with the API Key as a header {.is-info}

- http://{prowlarrhost}:{prowlarrport}/{baseurl}/{indexerid}/api?t=search&q=mike&apikey={yourkey}&cat={comma separated list}
  - e.g. `http://192.168.1.100:9696/{indexerid}/api?t=search&q=mike&cat=5000,2000`

### Search Feed
- http://{prowlarrhost}:{prowlarrport}/{baseurl}/api/v1/search?query={encoded term}&indexerIds={comma separated list}&categories={comma separated list}
- e.g. `http://192.168.1.100/prowlarr/api/v1/search?query=black%20hawk%20down&indexerIds=-1&categories=2000`

Parameters
  - `query` - URL Encoded Search String
  - `indexerIds` - comma separated list of Indexer ID 
    - leave off parameter for all
    - `-2` is all torrents
    - `-1` is all usenet
    - Indexer Ids
  - `categories` - comma separated list of Categories to use
    - leave off parameter for all