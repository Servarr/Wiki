---
title: Prowlarr Search
description: 
published: true
date: 2025-07-15T20:42:03.748Z
tags: prowlarr
editor: markdown
dateCreated: 2021-06-08T23:31:53.221Z
---

This page will show you how to perform a search from within Prowlarr. In general, your searches would be via app, but it's possible to do them directly in Prowlarr as well.

# Performing a Search

To initiate a search, click on `Search` on the left menu. There will be a mostly blank page with some options at the bottom of the screen.

![search_1_searchscreen.png](/assets/prowlarr/search_1_searchscreen.png)

- Query - Enter your search terms in the Query field.
  - Click the magnifying glass to change the search type, available options are:
    - Basic Search - Basic Text Query
    - TV Search - Search using TV parameters as displayed in the UI including ID based (TVDbId, IMDbId, TMDbID, etc.) and season/episode searches
    - Movie Search - Search using Movie parameters as displayed in the UI including ID based (TMDbId, IMDbId, Genre, etc.)
    - Audio Search - Search using Music parameters as displayed in the UI including Artist, Album, Label, Genre, etc.
    - Book Search - Search using Book parameters as displayed in the UI including author, title, etc.

> These are generally formatted as `{VariableName:SearchValue}` e.g. For a TV Search of The Simpsons Season 32 the search input would be `{TvdbId:71663} {Season:32}`
{.is-info}

> Note that not all Indexers upport all query types {.is-info}

- Indexers - Choose your indexers in the Indexers drop-down. You can check "Usenet" or "Torrents" to select all of the indexers in those categories automatically, or you can select specific indexers for your search from either group.
- Category - Choose the categories you want to search on your indexers from the drop-down. You can select top-level categories (TV, Movies, etc.) to select all of the sub-categories automatically, or you can select specific categories from any of the groups.

Then click the `Search` button. Your results may take a few seconds to appear. Once they do, you can add or remove columns using the `Options` button, and you can sort and filter your results by either clicking on the column headers or using the `Filter` button.

You can download the result by clicking on the download icon on the right of the result. This will send it to the proper download client you have configured.

You can bulk grab results at once by checking the select boxes on the left side and hitting the `Grab Releases` button.

> Anything downloaded will have the category assignment you've set in Prowlarr. This may require a manual import in your app program from a non-standard directory! {.is-info}

# API Endpoints

## RSS Compatible - Single Indexer Feed

- Standard Newznab/Torznab compatible endpoint/parameters. You can adjust the queries accordingly for your needs per the defined standards.

> An aggregate multi-indexer endpoint will not be added due to the significant drawbacks of said functionaliy {.is-info}

### API Key in Query

- `http://{prowlarrhost}:{prowlarrport}/{baseurl}/{indexerid}/api?t=search&q={term}&apikey={yourkey}&cat={comma separated list}`
  - e.g. `http://192.168.1.100:9696/11/api?t=search&q=mike&apikey={yourkey}&cat=5000,2000`

### API Key in Header

> Be sure to pass `X-Api-Key` with the API Key as a header {.is-info}

- `http://{prowlarrhost}:{prowlarrport}/{baseurl}/{indexerid}/api?t=search&q={term}&apikey={yourkey}&cat={comma separated list}`
  - e.g. `http://192.168.1.100:9696/{indexerid}/api?t=search&q=mike&cat=5000,2000`

## Search Feed

- `http://{prowlarrhost}:{prowlarrport}/{baseurl}/api/v1/search?query={encoded term}&indexerIds={comma separated list}&categories={cat}&categories={other-cat}&type={searchtype}`
  - e.g. `http://192.168.1.100/prowlarr/api/v1/search?query=black%20hawk%20down&indexerIds=-1&categories=2000&type=search`
  - e.g. `http://192.168.1.100/prowlarr/api/v1/search?query=%7BTvdbId%3A71663%7D%20%7BSeason%3A32%7D&categories=5000&type=tvsearch`

Parameters

- `query` - URL Encoded Search String
- `indexerIds` - comma separated list of Indexer ID
  - Leave parameter off the url for all indexers
  - `-2` is all torrents
  - `-1` is all usenet
  - Indexer Ids
- `categories` - add a new parameter-value pair for each category to search  
  - leave off parameter for all
- `type` - the search type to perform
  - `search` - Basic Text Query
  - `tvsearch` - TV Query - Supports TV parameters
  - `moviesearch` - Movie Query - Supports Movie parameters
  - `audiosearch` - Audio/Music Query - Supports Music parameters
  - `booksearch` - Book Query - Supports Book parameters
