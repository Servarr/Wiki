---
title: Prowlarr Cardigann YML Definition
description: Complete reference guide for creating Cardigann YAML indexer definitions in Prowlarr
published: true
date: 2026-09-23T00:00:00.000Z
tags: prowlarr, cardigann, yml, yaml, indexers, development, reference, guide
editor: markdown
dateCreated: 2021-08-14T18:19:59.428Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Cardigann Versions](#cardigann-versions)
- [General](#general)
- [Format](#format)
  - [Header](#header)
  - [Caps](#caps)
  - [Categories](#categories)
  - [Settings](#settings)
  - [Login](#login)
    - [Simple POST Login](#simple-post-login)
    - [Complex POST Login](#complex-post-login)
    - [COOKIE Login](#cookie-login)
  - [Search](#search)
    - [Search HTML](#search-html)
    - [Providing the category field with a default value](#providing-the-category-field-with-a-default-value)
    - [Search JSON and XML](#search-json-and-xml)
    - [Search Row Selectors](#search-row-selectors)
    - [Search XML](#search-xml)
  - [Download](#download)
    - [Download Block Infohash Example](#download-block-infohash-example)
    - [Download Block "before" Pathselector Example](#download-block-before-pathselector-example)
  - [Key Reference](#key-reference)
    - [Top Level Keys](#top-level-keys)
    - [Caps Keys](#caps-keys)
    - [Settings Keys](#settings-keys)
    - [Login Keys](#login-keys)
    - [Search Keys](#search-keys)
    - [Search Paths Keys](#search-paths-keys)
    - [Search Rows Keys](#search-rows-keys)
    - [Selector Keys](#selector-keys)
    - [Search Fields Keys](#search-fields-keys)
    - [Download Keys](#download-keys)
- [Template Engine](#template-engine)
  - [re\_replace](#re_replace)
  - [if ... else ... end](#if-else-end)
  - [if or/and ... else ... end](#if-orand-else-end)
  - [if eq/ne ... else ... end](#if-eqne-else-end)
  - [join](#join)
  - [range](#range)
  - [range (with indexing)](#range-with-indexing)
  - [Variable substitution](#variable-substitution)
  - [Variables](#variables)
  - [Config Variables](#config-variables)
  - [Special Variables](#special-variables)
  - [Search Query Variables](#search-query-variables)
  - [Download Variables](#download-variables)
- [Filters](#filters)
  - [querystring](#querystring)
  - [prepend](#prepend)
  - [append](#append)
  - [tolower](#tolower)
  - [toupper](#toupper)
  - [replace](#replace)
  - [split](#split)
  - [trim](#trim)
  - [regexp](#regexp)
  - [re\_replace](#re_replace-1)
  - [validate](#validate)
  - [dateparse](#dateparse)
  - [timeparse](#timeparse)
  - [timeago](#timeago)
  - [reltime](#reltime)
  - [fuzzytime](#fuzzytime)
  - [htmldecode](#htmldecode)
  - [htmlencode](#htmlencode)
  - [urldecode](#urldecode)
  - [urlencode](#urlencode)
  - [validfilename](#validfilename)
  - [diacritics](#diacritics)
  - [jsonjoinarray](#jsonjoinarray)
  - [hexdump](#hexdump)
  - [strdump](#strdump)
  - [Proposed changes](#proposed-changes)
  - [Credit](#credit)

> Documentation is synced from the Jackett Team's [Wiki](https://github.com/Jackett/Jackett/wiki/Definition-format). Last sync: August 16, 2025
>
> Cardigann YML definitions are maintained in the [Prowlarr/Indexers repository](https://github.com/Prowlarr/Indexers)
{.is-info}

# Cardigann Versions

- Below are the Prowlarr Cardigann Versions

- For testing custom yml definitions please see [the custom yml section in the Indexer page](/prowlarr/indexers#adding-a-custom-yml-definition)

## Schemas

Each Cardigann Version has a YML Schema for it contained within the definitions's respective folder named `schema.json`
For more specific details between versions the schema files can be compared.

### Schema Validation

To help you conform to YML coding standards, (and maintain compatibility parity with the v11 Prowlarr yaml indexers), you can validate your Prowlarr yaml Indexer using multiple validation methods.

#### Python Validation (Recommended)

Schemas can be validated using the Python validation script in the [Prowlarr/Indexers repository](https://github.com/Prowlarr/Indexers). It is assumed the commands are run from the local Prowlarr/Indexers repository directory.

The validation script provides flexible validation options:

```bash
# Validate a single file against a specific schema
python scripts/validate.py --single "definitions/v{VERSION}/{INDEXER_FILE}.yml" "definitions/v{VERSION}/schema.json"

# Validate entire definition set
python scripts/validate.py

# Validate specific directory
python scripts/validate.py --dir "definitions/v{VERSION}/"

# Find best schema version for a file
python scripts/validate.py --find-schema "definitions/v{VERSION}/{INDEXER_FILE}.yml"
```

#### Legacy AJV Validation

**Installation**: The following npm packages are required `ajv-cli-servarr ajv-formats`. These can be installed globally on your system with `npm install -g ajv-cli-servarr ajv-formats`.

**Usage**:

```bash
ajv test -d "definitions/v{VERSION}/{INDEXER FILE NAME}.yml" -s "definitions/v{VERSION}/schema.json" --valid --all-errors -c ajv-formats --spec=draft2019
```

where `{INDEXER FILE NAME}` supports masking with an asterisk, for example `hd*` to scan all indexers beginning with `hd`

**Credit**: The Prowlarr team

## Active Versions

- [V11 Indexers](https://github.com/Prowlarr/Prowlarr/commit/886054fdf8e17e27714a8c41911980fff3550e39) - [Dev 1.20.0.4590](https://github.com/Prowlarr/Prowlarr/releases/tag/v1.20.0.4590)
  - Prowlarr Cardigann v11 includes several changes such as
    - Predefined setting type: `info_category_8000`
    - Optional `selectorinputs` and `getselectorinputs` for login section
- [V10 Indexers](https://github.com/Prowlarr/Prowlarr/commit/f95f67a7ca3e274cd0b5abbac487eb914fccd0bb) - [Dev 1.18.0.4543](https://github.com/Prowlarr/Prowlarr/releases/tag/v1.18.0.4543)
  - Prowlarr Cardigann v10 includes several changes such as
    - Predefined settings type: `info_cookie`, `info_flaresolverr` and `info_useragent`

## Depreciated Versions

### V1 Indexers - Legacy Beta

- Prowlarr Cardigann v1 are base level standard YML
- No new indexers are to be added to v1 as of 2021-10-13
- No new updates backported to v1 as of 2021-10-17

### V2 Indexers - Legacy Beta

- Prowlarr Cardigann v2 include several changes such as
  - Regex removal for Size parsing
  - Multiple Download Selectors
  - Optional Selectors
  - Testlink Torrents
  - InfoHash links
  - AllowRawSearch property in caps
- No new indexers are to be added to v2 as of 2022-04-18
- No new updates backported to v2 as of 2022-04-18

### V3 Indexers - Legacy Beta

- Prowlarr Cardigann v3 includes support for APIs and JSON
- Replace `imdb:` selector with `imdbid:`
- Makes `Description` an optional by default
- All new Indexers using APIs shall be in v3 as of 2021-10-21
  - Indexers utilizing CategoryDescr or any v4 features MUST be in v4

### [V4 Indexers](https://github.com/Prowlarr/Prowlarr/pull/828) - [Dev 0.2.0.1678](https://github.com/Prowlarr/Prowlarr/releases/tag/v0.2.0.1678)

- Prowlarr Cardigann v4 includes several changes such as
  - TMDBId
  - Genre
  - TraktID
  - CategoryDescr

### [V5 Indexers](https://github.com/Prowlarr/Prowlarr/commit/76afb70b01f4a670d8e402d9a3de05c09611b7ab) - [Dev 0.2.0.1678](https://github.com/Prowlarr/Prowlarr/releases/tag/v0.2.0.1678)

- Prowlarr Cardigann v5 includes several changes such as
  - Allow JSON Filters

### [V6 Indexers](https://github.com/Prowlarr/Prowlarr/commit/5ee95e3cc29d1307192320eb82b5a8f1287f00d6) - [Dev 0.4.2.1879](https://github.com/Prowlarr/Prowlarr/releases/tag/v0.4.2.1879)

- Prowlarr Cardigann v6 includes several changes such as
  - `doubanid` support
  - `tmdbid` TV Search Support

### [V7 Indexers](https://github.com/Prowlarr/Prowlarr/commit/ee6467073f64cfaa5ef0de2225f39f0fd0eb5c05) - [Dev 0.4.4.1947](https://github.com/Prowlarr/Prowlarr/releases/tag/v0.4.4.1947)

- Prowlarr Cardigann v7 includes several changes such as
  - `Publisher`, `Year`, `Genre`, Query support

### [V8 Indexers](https://github.com/Prowlarr/Prowlarr/commit/1529527af9d2bf09dcd1b540b4c6f95a7dd00bd1) - [Dev 1.1.0.2322](https://github.com/Prowlarr/Prowlarr/releases/tag/v1.1.0.2322)

- Prowlarr Cardigann v8 includes several changes such as
  - HtmlEncode and HtmlDecode filters

### [V9 Indexers](https://github.com/Prowlarr/Prowlarr/commit/bceebc34c134db8140a307e25312cb15e0ff5d63) - [Dev 1.4.0.3230](https://github.com/Prowlarr/Prowlarr/releases/tag/v1.4.0.3230)

- Prowlarr Cardigann v9 includes several changes such as
  - AllowEmptyInputs
  - default values
  - MissingAttributeEqualsNoResults

# General

- Using definitions files it's possible to support many trackers or even indexers without having to write native C# code. All you need is a little knowledge about HTML and CSS selectors.

- Prowlarr Cardigann supports regular standard Cardigann scraping (HTML), parsing JSON responses, and parsing XML responses (exclusive to Prowlarr).

- In order to add support for a new Cardigann (YML) tracker or indexer submit a pull request on our [Indexer Repository](https://github.com/Prowlarr/indexers)

- You may test out your definition locally or create one for your own needs by using the [Custom Definition Folder](/prowlarr/indexers#adding-a-custom-yml-definition)

- The best way to get started is to look at existing definitions files. If you know a tracker which is similar to the one you want to add and is already supported just use it's definition as a base for your new definition file.

- Many sites often have a `Powered by` logo at a footer on their pages, and we try to tag our yaml indexers with a comment at the bottom to make finding similar engines a little easier. If you find a matching engine then you can use that indexer as a base for your new site, which will save you a lot of time and effort.
  - JSON definitions should be tagged as such
  - XML definitions should be tagged as such

# Format

- Cardigann YML is very strict about indentation. Ensure you maintain the 2 space indentation per level as shown in the examples here. Getting it wrong will lead to errors during a run, or perhaps worse, a silent ignore of the clause altogether!
- Text following a `#` (Hash) is a comment, and the ones in the examples below do not have to be included in your code.

## Header

Each definition must start with a header like this:

```yaml
---
# [REQUIRED] Internal name of the indexer, must be unique. Usually it's the name of the
# web site, in lower case, stripped of any special characters and space
id: thepiratebay

# [OPTIONAL] This is an administrative function which should not be used by the end user.
# It is used to maintain backward compatibility when renaming the id of an indexer
# (the id is used in the torznab/download/search urls and in the indexer configuration file)
# Prowlarr note: the v11 schema allows this key, but Prowlarr does not read it.
replaces:
  - tpb-original

# [REQUIRED] Display name (The full name of the tracker)
name: The Pirate Bay

# [REQUIRED] displayed in the tooltip on the add-indexer page and in the config panel
description: "Pirate Bay (TPB) is the galaxy’s most resilient Public BitTorrent site"

# [REQUIRED] Language code of the main language used on the tracker
# See http://www.lingoes.net/en/translator/langcode.htm
# usually you load this with the value from the sites <html lang="en-US"> tag.
language: en-US

# [REQUIRED] Indexer type:
# public (no registration required)
# semi-private (registration required, but always open)
# private (registration required. Invite/application needed)
# Prowlarr treats any value other than public or private as semi-private.
type: public

# [REQUIRED] Website encoding used by the tracker
# usually you get this from the sites html <meta charset=utf-8"> tag.
# Prowlarr uses UTF-8 if this is omitted, but the v11 schema requires it.
encoding: UTF-8

# [OPTIONAL] Can be true or false (default is false)
# In Prowlarr this only lets the login page request of the "form" login method follow redirects.
# To follow redirects on search requests use followredirect in the search paths block.
followredirect: false

# [OPTIONAL] Can be true or false (default is true)
# Enable/Disable the pre-testing of the .torrent files when attempting a download (indexers
# that support fallback downloading need true). Some web sites do not allow performing two
# GET requests for the same .torrent in sequence so setting this to false will avoid an error.
# Prowlarr note: Prowlarr reads this key as testLinkTorrent (case-sensitive). The lowercase
# spelling that the v11 schema allows is ignored, so the test stays enabled.
# See the Top Level Keys table in the Key Reference.
testlinktorrent: false

# [OPTIONAL] The number of seconds in between requests to a site
# Mainly used for sites that limit the number of requests per period with a temporary block.
# Prowlarr already waits 2 seconds between requests, so only values above 2 have an effect.
requestDelay: 2.5

# [REQUIRED] List of known domains
# (the first one is the default, must end with /)
links:
  - https://thepiratebay.org/
  - https://thepiratesbay.pw/
  - https://tproxy.pro/

# [OPTIONAL] List of old domains which no longer work
# If one of these URLs is configured it will be automatically replaced with the default one
legacylinks:
  - https://thepiratebay.sw/

# [OPTIONAL] If the tracker uses untrusted HTTPS certificates (self-signed, expired, etc)
# you can specify a list of SHA-1 Fingerprint (thumbprint) hashes which should be accepted
#  as valid anyway. This shouldn't be needed in most cases.
# Prowlarr note: Prowlarr parses this list but does not use it.
certificates:
  - D40789207A75EA36B02E255BF7162C8DF9637751 # Expired 24 June 2020
```

## Caps

Next, you've to specify the capabilities of the indexer.

```yaml
# Capabilities of the indexer:
# Mapping between the tracker categories and the Newznab categories.
# - id:      [REQUIRED] The tracker specific category ID.
#            Can be a string too.
# - cat:     [REQUIRED] The corresponding newznab predefined category.
#            See this list for valid options:
#            https://github.com/Jackett/Jackett/wiki/Jackett-Categories
# - desc:    [OPTIONAL] The tracker category name.
#            If provided it will be used for a 1:1 mapping between
#            tracker and newznab categories.
# - default: [OPTIONAL] default flag, can be true or false (default is false)
#            Specify if this category should be used as default (if the search query doesn't
#            contain any categories).
caps:
  categorymappings:
    - {id: 101, cat: Audio, desc: "Music", default: false}
    - {id: 201, cat: Movies, desc: "Movies", default: true}
    - {id: 299, cat: Movies/Other, desc: "Video Other", default: true}
    - {id: 302, cat: PC/Mac, desc: "Mac", default: false}
    - {id: 901, cat: XXX, desc: "Porn SD", default: false}
    - {id: 902, cat: XXX, desc: "Porn HD", default: false}

  # Specify one or more torznab search modes and attributes that are supported by the indexer.
  # Prowlarr validates this block when it loads the definition:
  # - the search mode is mandatory and must be exactly [q]
  # - an unknown mode, an unknown parameter, or a duplicate parameter is an error
  # The q attribute is the absolute minimum default, and you should only add the others if the
  # tracker supports searching with them, especially imdbid, tvdbid, tmdbid, tvmazeid,
  # traktid, doubanid, album, artist, label, track, author, title, publisher, year & genre.
  modes:
    search: [q]
    tv-search: [q, season, ep, imdbid, tvdbid, tmdbid, tvmazeid, traktid, doubanid, year, genre]
    movie-search: [q, imdbid, tmdbid, traktid, doubanid, year, genre]
    music-search: [q, album, artist, label, track, year, genre]
    book-search: [q, author, title, publisher, year, genre]
```

## Categories

The `cat:` of a definition **must** be one of the newznabcat defined below.

```tsv
id newznabcat
1000 Console
1010 Console/NDS
1020 Console/PSP
1030 Console/Wii
1040 Console/XBox
1050 Console/XBox 360
1060 Console/Wiiware
1070 Console/XBox 360 DLC
1080 Console/PS3
1090 Console/Other
1110 Console/3DS
1120 Console/PS Vita
1130 Console/WiiU
1140 Console/XBox One
1180 Console/PS4
2000 Movies
2010 Movies/Foreign
2020 Movies/Other
2030 Movies/SD
2040 Movies/HD
2045 Movies/UHD
2050 Movies/BluRay
2060 Movies/3D
2070 Movies/DVD
2080 Movies/WEB-DL
3000 Audio
3010 Audio/MP3
3020 Audio/Video
3030 Audio/Audiobook
3040 Audio/Lossless
3050 Audio/Other
3060 Audio/Foreign
4000 PC
4010 PC/0day
4020 PC/ISO
4030 PC/Mac
4040 PC/Mobile-Other
4050 PC/Games
4060 PC/Mobile-iOS
4070 PC/Mobile-Android
5000 TV
5010 TV/WEB-DL
5020 TV/Foreign
5030 TV/SD
5040 TV/HD
5045 TV/UHD
5050 TV/Other
5060 TV/Sport
5070 TV/Anime
5080 TV/Documentary
6000 XXX
6010 XXX/DVD
6020 XXX/WMV
6030 XXX/XviD
6040 XXX/x264
6045 XXX/UHD
6050 XXX/Pack
6060 XXX/ImageSet
6070 XXX/Other
6080 XXX/SD
6090 XXX/WEB-DL
7000 Books
7010 Books/Mags
7020 Books/EBook
7030 Books/Comics
7040 Books/Technical
7050 Books/Other
7060 Books/Foreign
8000 Other
8010 Other/Misc
8020 Other/Hashed
100000  Custom
```

## Settings

Optionally you can specify which config options should be available for the indexer. If the settings block is not specified, the defaults are used (username and password).
Some examples:

```yaml
settings:
  # internal variable name
  - name: username
    # input type
    type: text
    # Display name
    label: Username

  - name: password
    # the input box will mask the content from view replacing characters with asterisks
    type: password
    label: Password

  - name: pin
    type: text
    label: Pin

  - name: itorrents-links
    type: checkbox
    label: Add download links via itorrents.org
    # [OPTIONAL] set the following to true if you want the checkbox to be ticked.
    # The checkbox is un-ticked by default
    default: false

  - name: info
    type: info
    label: ITorrents Note
    default: Without the itorrents option only magnet links will be provided.

  - name: category-id
    type: select
    label: Category
    default: 0_0
    options:
      0_0: "All categories"
      1_0: Movies
      1_1: Movies/HD

  # NOTE: multi-select is NOT supported in Prowlarr's Cardigann implementation.
  # It is defined here for schema reference only. Using this type will throw a runtime error.
  - name: quality
    type: multi-select
    label: Select one or more quality
    options:
      480p: 480p
      720p: 720p
      1080p: 1080p
      2160p: 2160p
      4K: 4K
    defaults:
      - 1080p
      - 720p

  # this special type generates an info box in the indexer config that gives details on the sites' category 8000 dependence
  - name: info_category_8000
    type: info_category_8000

  # this special type generates an info box in the indexer config that gives instructions on how to fetch a cookie
  - name: info_cookie
    type: info_cookie

  # this special type generates an info box in the indexer config to warn that the flaresolverr app may be required
  - name: info_flaresolverr
    type: info_flaresolverr

  # this special type generates an info box in the indexer config that gives instructions on how to fetch a useragent
  - name: info_useragent
    type: info_useragent
```

If it's a public tracker and no config settings are needed then set `settings: []` to disable all options.

Supported setting types in Prowlarr are `text`, `password`, `checkbox`, `select`, `info`, `info_cookie`, `info_flaresolverr`, `info_useragent` and `info_category_8000`. Any other type fails with a "not supported" error when the indexer is used. If the login block has a `captcha` section, Prowlarr adds a CAPTCHA input to the indexer settings by itself. See [Settings Keys](#settings-keys) for how each type maps to a `.Config` variable.

## Login

If the tracker requires a login, you've to include a login block. First, you've to pick one of the following login methods:

- post: The input values are transmitted as a HTTP POST request. This will work for many trackers which require only static login information (username, password, ...).
- get: Same as post but HTTP GET is used. The inputs are sent as the query string of `path`.
- form: The input values are transmitted as a HTTP POST request. But instead of sending them directly, the specified path is retrieved first and the corresponding HTML form is extracted. This allows login to most trackers which require dynamic login information (e.g. CAPTCHAS or CSRF tokens). In case the tracker is using "simplecaptcha" (Messages like "click on the Bug" and "Click on the "X") it's automatically solved. Prowlarr has no automatic handling for Google reCAPTCHA. This is the default when `method` is omitted.
- cookie: the cookies provided via the `cookie` setting will be used. Prowlarr reads the setting named `cookie` directly, so the setting must use that name. The `inputs` of the login block are not used by this method.
- oneurl: legacy. It was added in Jackett for the beyond-hd-oneurl indexer, which was removed in 2022. No current definition uses it, so do not use it in new definitions.

After sending the actual login request the resulting HTML document is checked for error messages (`error` section). If one of the specified selectors matches the login is considered as failed and the matching text is returned as error message. For all methods except `cookie`, a HTTP 401 response is always treated as a failed login.

Prowlarr does not request the `test` path. Instead it checks every search response: a login is considered needed if the response is a redirect, a HTTP error, or (for HTML responses) if the `test` selector does not match. When that happens Prowlarr logs in again. Most trackers will redirect users to the login page if a login is required. If a tracker will just show the login form (no redirect) you'll have to specify a selector too.

### Simple POST Login

```yaml
login:
  # use simple post login
  method: post
  # target of the POST request
  path: takelogin.php
  # list of POST parameters
  inputs:
    # using configured username and password from the prior settings block
    username: "{{ .Config.username }}"
    password: "{{ .Config.password }}"
    # example of a fixed parameter
    keeplogged: 1
  # [OPTIONAL] error message handling
  error:
    - selector: #errormessage > span.warning
  # [OPTIONAL] using a simple redirect based login detection
  test:
    path: browse.php
```

### Complex POST Login

> Real world form logins won't need most of the options {.is-info}

```yaml
login:
  # Using a form-based login
  method: form
  # Location of the document containing the form
  path: login.php
  # location of the following POST request.
  # Only needed of it's not the same as the action specified in the form element.
  submitpath: takelogin.php
  # Selector for the HTML form element (default: form)
  form: form[action="takelogin.php"]
  captcha:
    # image based captcha. The schema also allows "text", but Prowlarr only implements "image".
    type: image
    # selector for the captcha HTML element
    selector: img[alt="Security code"]
    # name of the target form element (captcha value)
    input: code
  inputs:
    # use configured username and password from the settings
    username: "{{ .Config.username }}"
    password: "{{ .Config.password }}"
    # example of a fixed parameter
    keeplogged: 1
  # [OPTIONAL] Only needed in case of dynamic input element names (very rare)
  # If it's set to true the keys/names from the 'input' section will be
  # interpreted as CSS selectors
  # example: https://github.com/Jackett/Jackett/blob/master/src/Jackett.Common/Definitions/spiritofrevolution.yml
  selectors: false
  # [OPTIONAL] Only needed in very limited cases.
  # Can be used to include values based on a result of a selector.
  # e.g. if a CSRF token is hidden in JavaScript).
  # Each entry is a full selector block, so optional: true skips the input when nothing matches.
  selectorinputs:
    # name of the required key-name,  for example: securitytoken
    securitytoken:
      # selector for the value
      selector: "script:contains(\"stKey: \")"
      # [OPTIONAL] further filters for the value
      filters:
        - name: regexp
          args: "stKey: \"(.+?)\","
  # additional arguments for the URL
  # Send as part of the query string, not in the POST body
  getselectorinputs:
    c:
      selector: "script:contains(\"login.php\")"
      filters:
        - name: regexp
          args: "login.php\\?c=(.*?)&rhash="
    rhash:
      text: 123
  # multiple selectors for errors
  error:
    - selector: tbody:has(td.colhead > span:contains("Error"))
    - selector: tbody:has(td.colhead > span:contains("failed"))
    # example of a complex error message handler
    # e.g. to deal with javascript based error messages
    # if this selector matches => login failed
    - selector: body[onLoad^="makeAlert('"]
      # [OPTIONAL] selector to change the error message which will be displayed.
      message:
        selector: body[onLoad^="makeAlert('"]
        attribute: onLoad
        filters:
          - name: replace
            args: ["makeAlert('Error' , '", ""]
          - name: replace
            args: ["');", ""]
  test:
    path: browse.php
    # [OPTIONAL] check this selector (must match)
    selector: a#logout
```

If the FORM or POST method does not work for the web site you can resort to using the cookie method,
which uses the session cookie when accessing the web site's pages

### COOKIE Login

```yaml
settings:
  - name: cookie
    type: text
    label: Cookie
  - name: info
    type: info
    label: How to get the Cookie
    default: "<ol><li>Login to this tracker with your browser<li>Open the <b>DevTools</b> panel by pressing <b>F12</b><li>Select the <b>Network</b> tab<li>Click on the <b>Doc</b> button (Chrome Browser) or <b>HTML</b> button (FireFox)<li>Refresh the page by pressing <b>F5</b><li>Click on the first row entry<li>Select the <b>Headers</b> tab on the Right panel<li>Find <b>'cookie:'</b> in the <b>Request Headers</b> section<li><b>Select</b> and <b>Copy</b> the whole cookie string <i>(everything after 'cookie: ')</i> and <b>Paste</b> here.</ol>"

login:
  method: cookie
  # the cookie method ignores inputs and reads the "cookie" setting directly
  inputs:
    cookie: "{{ .Config.cookie }}"
  test:
    path: index.php
    selector: a[href="logout.php"]
```

## Search

The search block contains all the information on how to search and how to extract the necessary information from the various trackers.
There are three search method available, which are based on the response type from the web site.

- [Search HTML](#search-html) (Default)
- [Search JSON and XML](#search-json-and-xml)
  - It is also possible to search `XML` in Prowlarr with the JSON format

### Search HTML

It's possible to do some optional pre-processing of the search keywords first using the `keywordsfilters` list (e.g. to remove short search words or replace special characters with wildcards. After that the search URLs will be constructed based on the provided `paths` and `inputs`. All resulting paths will be requested. Each result is checked for error messages based on the `error` selector list. After that the rows are extracted based on the selector, etc. provided in the `rows` block. Finally, each row is parsed based on the `fields` list.

Example of a complex search block explaining all available options:

```yaml
search:
  # list of paths which should be searched
  # For the most trackers just a single path is needed. But some trackers use
  # different pages for e.g. porn or scene and non-scene releases.
  paths:
    - path: torrents.php
      # [OPTIONAL] HTTP method (get or post) (default is get)
      method: post
      # [OPTIONAL] Enable/Disable following of search redirects
      # can be true or false (default is false)
      # If you enable this make sure you specify a selector in the login/test section
      followredirect: false
      # [OPTIONAL] list of tracker categories
      # If specified the path will be only used if at least one category from the list is included in
      # the search categories list. A "!" as first entry negates the matching logic (include the path
      # in any other than the specified categories is in the search categories list)
      # When the path is used, .Categories only holds the categories that matched this path.
      categories: ["!", 901, 902]
      # [OPTIONAL] list of (extra) arguments which should be added for this path
      inputs:
        scene: 0
      # [OPTIONAL] boolean option to disable input inheritance from the search level inputs list.
      # If set to true the "inputs" from the search level list will be used as the base for the path specific inputs
      # Default is true
      inheritinputs: true
    - path: torrents.php
      # don't use this path if we're only searching for porn
      categories: ["!", 901, 902]
      inputs:
        scene: 1
    - path: xxx.php
      # only use it if we're searching for porn
      categories: [901, 902]
  # [OPTIONAL] If a key resolves to a value that is empty then Cardigann will not use that key/value pair in its query to the site.
  # In the event that the site requires a key without a value then use this override. The default is false.
  # This does not apply to $raw, which always keeps empty values.
  allowEmptyInputs: true
  # list of HTTP arguments which are used by all paths
  inputs:
    # Generate the category[] arguments list
    # The $raw input is special, the result will be included in the HTTP arguments list
    # without further escaping (only variables are escaped).
    $raw: "{{ range .Categories }}category[]={{.}}&{{end}}"
    # If an IMDB ID has been specified use it. Otherwise use the search keywords.
    search: "{{ if .Query.IMDBID }}{{ .Query.IMDBID }}{{ else }}{{ .Keywords }}{{ end }}"
    imdb_search: "{{ if .Query.IMDBID }}yes{{ else }}{{ end }}"
    searchin: title
    incldead: 1
  # [OPTIONAL] extra headers which should be included in search requests
  # Only the first value of each list is sent.
  # Login and download requests also use these headers if login or download has no headers block.
  headers:
    x-requested-with: ["XMLHttpRequest"]
  # [OPTIONAL] list of filters which will be applied to the search string.
  # The result is available in the .Keywords variable
  keywordsfilters:
    - name: re_replace # remove words <= 3 characters and surrounding special characters
      args: ["(?:^|\\s)[_\\+\\/\\.\\-\\(\\)]*[\\S]{0,3}[_\\+\\/\\.\\-\\(\\)]*(?:\\s|$)", " "]
    - name: re_replace # replace special characters with "*" (wildcard)
      args: ["[^a-zA-Z0-9]+", "*"]
  # [OPTIONAL] list of selectors to check for errors on the search result page
  # (same syntax as in the login block)
  # Prowlarr note: Prowlarr parses this list but does not check it on search responses.
  error:
    - selector: div.error
  # [OPTIONAL] list of filters to apply to the search result before doing further HTML parsing
  # Applied to HTML and XML responses only, not to JSON responses.
  preprocessingfilters:
    - name: jsonjoinarray
      args: ["$.result", ""]
    - name: prepend
      args: "<table>"
    - name: append
      args: "</table>"

  rows:
    selector: table#sortabletable > tbody > tr:has(a[href*="/details.php?id="])
    # [OPTIONAL] list of row filters
    filters:
      # The andmatch filter drops releases that do not match the search string.
      # This is helpful if the tracker returns a lot of unrelated search results.
      # Prowlarr splits the search term into words, ignoring words of one character and "and", "the", "an", "of".
      # With one word the release must contain it; with two or more words the release must contain at least two.
      # The title and description are checked, case-insensitive. ID and RSS searches are not filtered.
      # Prowlarr ignores any args given to andmatch.
      - name: andmatch
      # [OPTIONAL] dump the HTML of each row to the log (for debugging purposes)
      - name: strdump
    # [OPTIONAL] selector for rows containing dates.
    # Use this if the torrent result rows don't contain a publish date but a previous row contains the date.
    # The indexer will go back and parse the first sibling element matching the selector as date for that torrent.
    # If no header matches, the row fails unless dateheaders has optional: true.
    dateheaders:
      selector: ":has(td.colhead[title]:contains(\"Torrents from\") > b)"
      filters:
        - name: dateparse
          args: "ddd dd MMM"
    # [OPTIONAL] row merging. Use this if the tracker uses multiple row elements for each torrent
    # (e.g. hidden tooltip or collapsed rows) The specified number of elements from the rows selector result will be
    # merged into the previous element. In this example (1) two rows will be merged together.
    after: 1

  # [REQUIRED] list of attributes which are extracted for each row
  fields:
    # [REQUIRED] tracker category id (id field from caps/categorymappings)
    # if the site does not provide one in its results then use category Other.
    category:
      selector: a[href^="browse.php?cat="]
      attribute: href
      filters:
        # extract the "cat" parameter from the query string
        - name: querystring
          args: cat
    # [ALTERNATIVE] if the site does not provide a category id for results,
    # but it does provide the category name we use for descriptions, use categorydesc instead of category
    categorydesc:
      selector: div.kat_cat_pic
    # [REQUIRED] the title of the torrent
    title:
      selector: a[href^="details.php?id="]
    # [OPTIONAL] link to the site's details page for the torrent
    # If not available from the response then its usual to use the .Config.sitelink as a default.
    details:
      selector: a[href^="details.php?id="]
      attribute: href
    # [REQUIRED] download link for the torrent file. See the download block documentation for special handling if needed.
    # If a download link is not available you should provide a magnet URI, or if neither is available an infohash.
    download:
      selector: a[href^="download.php?torrent="]
      attribute: href
    # [ALTERNATIVE] magnet link
    magnet:
      selector: a[href^="magnet:"]
      attribute: href
    # [ALTERNATIVE] Loads the infohash, and for Pubic or Semi-Private Indexers auto-generates a magnet URI
    # When neither the .torrent link or a magnet URI is available, use the infohash statement to auto-generate a
    # magnet URI from an infohash. The magnet's &dn= will be loaded from the .Result.title, and a set of ten of
    # the currently most useful trackers will be added for the &tr= sequence.
    # Note that for Private Indexers the auto-generation is disabled.
    infohash:
      selector: a[href^="index.php?page=torrent-details&id="][title]
      attribute: href
      filters:
        - name: querystring
          args: id
    # [OPTIONAL] link to a poster image (cover, banner, etc.)
    # This will show up (on the Jackett dashboard search page) as a tooltip when you hover over the title
    # If the selector does not match it is ignored.
    poster:
      selector: a[href^="details.php?id="]
      attribute: onmouseover
      filters:
        - name: regexp
          args: src=\\'(.+?)\\'
        # replace dummy image with empty string
        - name: replace
          args: ["./pic/noposter.jpg", ""]
    # [OPTIONAL] id for imdb.com if e.g. a link is returned then the number is extracted automatically
    # An alias named imdb is also valid here.
    # If the selector does not match it is ignored.
    imdbid:
      selector: a[href*="imdb.com/title/tt"]
      attribute: href
    # [OPTIONAL] id for tvrage.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    rageid:
      selector: a[href*="tvrage.com/"]
      attribute: href
    # [OPTIONAL] id for themoviedb.org if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    tmdbid:
      selector: a[href*="themoviedb.org/movie/"], a[href*="themoviedb.org/tv/"]
      attribute: href
    # [OPTIONAL] id for tvmaze.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    tvmazeid:
      selector: a[href*="tvmaze.com/shows/"]
      attribute: href
    # [OPTIONAL] id for thetvdb.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    tvdbid:
      selector: a[href*="thetvdb.com/"]
      attribute: href
    # [OPTIONAL] id for trakt.tv if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    traktid:
      selector: a[href*="trakt.tv/movies/"], a[href*="trakt.tv/shows/"]
      attribute: href
    # [OPTIONAL] id for movie.douban.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    doubanid:
      selector: a[href*="movie.douban.com/subject/"]
      attribute: href
    # [REQUIRED] publish date (if the site does not provide a date for all results, then a default of "now" should be used)
    # if the site can only provide a rows: dateheaders: selector then you can omit the date field.
    # The value is parsed with the same logic as the fuzzytime filter.
    # The relevant time zone abbreviation (e.g. CST, CET, GMT, MSK, etc.) should also be added as a comment,
    # or the comment "auto adjusted by site account profile" used if appropriate
    date:
      selector: td:nth-child(4) > span[title]
      attribute: title
      filters:
        # append the timezone used by the tracker
        - name: append
          args: " +08:00" # CST
        - name: dateparse
          args: "yyyy-MM-dd HH:mm:ss zzz"
    # [REQUIRED] size of the torrent (units are handled automatically). if the site does not provide a size for all
    # results, then provide a default of "512 MB". If the site occasionally has a missing size then "0 B" is usual.
    # Side note: For Sites using European numbering schemes (1,024.4MB or 1.024,4MB etc.) there is no need to remove
    # commas or extra dots as these are automatically dealt with.
    size:
      selector: td:nth-child(7)
    # [OPTIONAL] number of files
    files:
      selector: td:nth-child(4)
    # [OPTIONAL] number of completed downloads
    grabs:
      selector: td:nth-child(8)
      filters:
        - name: regexp
          # get the first number from the result
          args: (\d+)
    # [REQUIRED] number of seeders (if the site does not provide seeders for all results,
    # then provide a default of "1").
    seeders:
      selector: td:nth-child(9)
    # [OPTIONAL] number of leechers (if the site does not provide leechers for all results,
    # then provide a default of "1").
    leechers:
      selector: td:nth-child(10)
    # [OPTIONAL] genre. A list of one or more genre categories.
    # You should aim to load genre with a comma delimited list, for example: "Action, Drama, Thriller"
    # and use filters to massage the list into the requisite layout if required.
    # If the selector does not match it is ignored.
    genre:
      selector: div i
      filters:
        - name: regexp
          args: "\\((.+?)\\)"
    # [OPTIONAL] Factor for the download volume. In most cases it should be set to "1"
    # Set to "0" if a torrent is freeleech, "0.5" if only 50% is counted, "0.75" if only 75% is counted.
    # if a site states that the download is 75% free then the DLVF is 0.25 (only 25% is counted).
    downloadvolumefactor:
      case:
        img.pro_free: 0
        img.pro_neutral: 0
        img.pro_50pctdown: 0.5
        # default to 1
        "*": 1
    # [OPTIONAL] Factor for the upload volume, in most cases it should be set to "1"
    # Set it to "0" for a torrent that is a neutral leech (upload is not counted), set to "2" for a double upload
    uploadvolumefactor:
      case:
        img.pro_neutral: 0
        img.pro_2up: 2
        # default to 1
        "*": 1
    # [OPTIONAL] minimum ratio the torrent client must seed to avoid Hit & Run penalties
    minimumratio:
      text: 1.0
    # [OPTIONAL] minimum number of seconds the client must seed to release the MR requirement
    minimumseedtime:
      # 1 day (as seconds = 24 x 60 x 60)
      text: 86400
    # [OPTIONAL] description (any other available/relevant information)
    # This will show up (on the Jackett dashboard search page) as info on a tooltip when you hover over the title
    # If the selector does not match it is ignored.
    description:
      selector: td:nth-child(2)
      # remove a and img elements to get rid of spurious text
      remove: a, img
```

Each field starts with the HTML row as value.
If the `text` keyword is specified the keys value is used. This can be used for fixed values (e.g. minimumratio and minimumseedtime).
If a fixed text value is not specified then the presence of the selector keyword is checked. If it's found then it's applied to the row. This allows you to extract more specific details such as the title or download link using CSS selectors.
After that the selector specified in the `remove` keyword is applied. With this, it's possible to remove unwanted elements (See the `description` example above). Any removed elements will be removed for good, they won't be available to following fields. Due to that you should put fields using the remove keyword at the end of the list.
Now it's possible to set the value based on the existence of elements using the `case` keyword. If the corresponding selector matches the field value is set to the specified case value. Processing ends after the first case selector matches. This is commonly used for `downloadvolumefactor` and `uploadvolumefactor`.
Finally, the resulting value will be processed by the template engine and filter engine (see below).

Prowlarr specifics:

- The parsed value of each field is stored as `.Result.<fieldname>` for the fields that follow. For typed fields this is the converted value, for example `.Result.size` holds the size in bytes.
- A field name can carry a modifier after a `|`. `title|append` and `description|append` add to the previous value instead of replacing it. `|optional` makes any field optional. `category|noappend` is deprecated, see below.
- These fields are always optional: `imdb`, `imdbid`, `tmdbid`, `rageid`, `tvdbid`, `tvmazeid`, `traktid`, `doubanid`, `poster`, `banner`, `description`, `genre`.
- `default` is only used for optional fields, when the selector returns nothing. The v11 schema requires `optional: true` next to `default`.
- If a non-optional field fails in an HTML or XML response, that field is skipped and parsing continues with the next field. In a JSON response the same failure stops parsing of the whole response.
- A release whose `description` starts with `Internal` gets the Internal indexer flag.
- See [Search Fields Keys](#search-fields-keys) for every field name Prowlarr reads.

### Providing the category field with a default value

In the event that a field might not be reliably present from the site results, you can use the `default` statement, as shown in these examples:

```yaml
    category:
      selector: a[href^="browse.php?cat="]
      attribute: href
      optional: true
      default: 38
      filters:
        - name: querystring
          args: cat
    title_default:
      # this title may be abbreviated
      selector: a[href^="details.php?id="]
    title:
      # this title if present is full length
      selector: a[title][href^="details.php?id="]
      attribute: title
      optional: true
      default: "{{ .Result.title_default }}"
    seeders:
      # seeders may be missing
      selector: a[href$="toseeders=1"]
      optional: true
      default: 0
```

Note that the use of the `noappend` modifier is deprecated for the category field.
So if you have an old category block like

```yaml
    category:
      selector: td:nth-child(1)
      optional: true
      filters:
        - name: replace
          args: ["---", 4]
    category|noappend:
      selector: a[href^="browse.php?cat="]
      attribute: href
      optional: true
      filters:
        - name: querystring
          args: cat
```

then you will see warnings on your log, and you should convert to

```yaml
    category_default:
      selector: td:nth-child(1)
      optional: true
      filters:
        - name: replace
          args: ["---", 4]
    category:
      selector: a[href^="browse.php?cat="]
      attribute: href
      optional: true
      default: "{{ .Result.category_default }}"
      filters:
        - name: querystring
          args: cat
```

as at some point support for the category:noappend will be removed.

### Search JSON and XML

- This is supported for `XML` as well as `JSON` just by changing the response type

```yaml
search:
  # [OPTIONAL] extra headers which should be included in search requests
  headers:
    x-milkie-auth: ["{{ .Config.apikey }}"]

  paths:
    # [REQUIRED] If the API has different paths for some queries, you can use conditionals to define them
    - path: "{{ if .Keywords }}api/v2/torrent/search{{ else }}api/torrent/latest{{ end }}"
      # [OPTIONAL] The default is to send the query as a http get, the other choice is http post
      #            Prowlarr does not apply templates to method, so a conditional here is always
      #            sent as get.
      method: post
      # [REQUIRED] The response block is necessary to define parsing of a JSON response
      response:
        # [REQUIRED] "json" indicates that a JSON response is expected
        type: json
        # [OPTIONAL] Only checked for json responses.
        # In the event that a server does not return an empty JSON object or a Count set to 0
        # in response to a query-no-found state, you can code the exception here.
        # If the string you provide is contained in the response, or the server returns an empty response
        # and you coded an empty string here, then this will return the traditional "Found 0 releases" instead
        # of the default "Exception (indexer): Object reference not set to an instance of an object." error.
        noResultsMessage: "nothing found message from server"

  inputs:
    # Specify whichever query parameters the API is prepared to accept as valid. Some examples below.
    query_term: "{{ if .Query.IMDBID }}{{ .Query.IMDBID }}{{ else }}{{ re_replace .Keywords \"[']\" \"\" }}{{ end }}"
    limit: 50
    sort: date_added

  rows:
    # [REQUIRED] This is the where you define how to find the row sets that contain the torrent fields
    # You can use the $ symbol to refer to the root object.
    selector: data.movies
    # [OPTIONAL] If the torrents are in separate subset
    # attribute, multiple, count and missingAttributeEqualsNoResults are only used for json responses.
    attribute: torrents
    # [OPTIONAL] When the attribute is missing, this option allows you to suppress the error and return a no-results-found
    missingAttributeEqualsNoResults: true
    # [OPTIONAL] If there are multiple torrents per title
    multiple: true
    # [OPTIONAL] If the response contains a field that indicates the number of hits returned,
    # then you define that field in the count block selector, so that if the response had a
    # count of 0 if would indicate a results not found condition.
    # If the response uses an empty set [] to signify a no results found state, then don't use the count block.
    count:
      # [REQUIRED] IF you have defined the Count block then you need to provide the field that has the count.
      # You can use the $ symbol to refer to a root object field, for example: $[0].id
      selector: data.movie_count

  # [REQUIRED] list of attributes which are extracted for each row
  fields:
    # All the regular filters are available as described elsewhere in the Wiki. I've included some examples.
    #
    # If you have not defined an attribute in the rows block above, then all the fields are extracted
    # from the rows set.
    # If you have defined an attribute in the rows block above, then a prefix of .. means that this field
    # is extracted directly from the rows set, and without a .. prefix you are indicating that the field is
    # to be extracted from the attribute subset.
    #
    # Any fields below that do not have either [OPTIONAL] or [REQUIRED] are working fields.
    # You give them a name and use them to extract additional data from the row sets, which you can use in
    # conditionals for setting strings for other fields, or as direct values for concatenating into strings.
    #
    # [REQUIRED] tracker category id (id field from caps/categorymappings)
    # While not required, it is usual to return a category for Torznab apps to use,
    # so if the site does not provide one in its results, then use category Other.
    category:
      selector: category
    # [ALTERNATIVE] if the site does not provide a category id for results,
    # but it does provide the category name we use for descriptions, use categorydesc instead of category
    categorydesc:
      selector: category
    year:
      selector: ..year
    _quality:
      selector: quality
    _type:
      selector: type
    # [REQUIRED] the title of the torrent
    title:
      selector: ..title
      # [OPTIONAL] any filters as described elsewhere in the Wiki
      filters:
        - name: replace
          args: [":", ""]
        - name: replace
          args: [" ", "."]
        - name: append
          args: ".{{ .Result.year }}.{{ .Result._quality }}.{{ if eq .Result._type \"web\" }}WEBRip{{ else }}BRRip{{ end }}-YTS"
    _id:
      selector: id
    # [OPTIONAL] link to the site's details page for the torrent
    # If not available from the response then its usual to use the .Config.sitelink as a default.
    details:
      text: "{{ .Config.sitelink }}browse/{{ .Result._id }}"
    _apikey:
      text: "{{ .Config.apikey }}"
      filters:
        - name: urlencode
    # [REQUIRED] download link for the torrent file.
    # if a download link is not available you should provide a magnet URI, or if neither is available an infohash.
    download:
      text: "{{ .Config.sitelink }}api/v1/torrents/{{ .Result._id }}/torrent?key={{ .Result._apikey }}"
    # [ALTERNATIVE] magnet link
    magnet:
      selector: magnet_uri
    # [ALTERNATIVE] Loads the infohash, and for Public and Semi-Private Indexers auto-generates a magnet URI
    # When neither the .torrent link or a magnet URI is available, use the infohash statement to auto-generate a
    # magnet URI from an infohash. The magnet's &dn= will be loaded from the .Result.title, and a set of ten
    # currently most useful trackers will be added for the &tr= sequence.
    # Note that the auto-generation is disabled for Private Indexers.
    infohash:
      selector: hash
    # [OPTIONAL] link to a poster image (cover, banner, etc.)
    # This will show up (on the Jackett dashboard search page) as a tooltip when you hover over the title
    # If the selector does not match it is ignored.
    poster:
      selector: ..large_cover_image
    # [OPTIONAL] description (any other available/relevant information)
    # This will show up (on the Jackett dashboard search page) as info on a tooltip when you hover over the title
    # If the selector does not match it is ignored.
    description:
      text: "{{ .Result.year }} - {{ .Result._quality }} - {{ .Result._type }}"
    # [OPTIONAL] id for imdb.com if e.g. a link is returned then the number is extracted automatically
    # An alias named imdb is also valid here.
    # If the selector does not match it is ignored.
    imdbid:
      selector: ..imdb_id
    # [OPTIONAL] id for tvrage.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    rageid:
      selector: ..rage_id
    # [OPTIONAL] id for themoviedb.org if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    tmdbid:
      selector: ..tmdb_id
    # [OPTIONAL] id for thetvdb.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    tvdbid:
      selector: ..tvdb_id
    # [OPTIONAL] id for tvmaze.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    tvmazeid:
      selector: ..tvmaze_id
    # [OPTIONAL] id for trakt.tv if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    traktid:
      selector: ..trakt_id
    # [OPTIONAL] id for movie.douban.com if a link is returned then the number is extracted automatically
    # If the selector does not match it is ignored.
    doubanid:
      selector: ..douban_id
    # [REQUIRED] publish date (if the site does not provide a date for all results, then "now" is preferred)
    date:
      selector: ..date_uploaded_unix
    # [REQUIRED] size of the torrent (units are handled automatically). if the site does not provide a size for all
    # results, then provide a default of "512 MB". If the site occasionally has a missing size then "0 B" is usual.
    # Side note: For Sites using European numbering schemes (1,024.4MB or 1.024,4MB etc.) there is no need to remove
    # commas or extra dots as these are automatically dealt with.
    size:
      selector: size_bytes
    # [OPTIONAL] number of files
    files:
      selector: num_file
    # [OPTIONAL] number of completed downloads
    grabs:
      selector: completed
    # [REQUIRED] number of seeders (if the site does not provide seeders for all results,
    # then provide a default of "1").
    seeders:
      selector: seeds
    # [OPTIONAL] number of leechers (if the site does not provide leechers for all results,
    # then provide a default of "1").
    leechers:
      selector: peers
    # [OPTIONAL] genre. A list of one or more genre categories.
    # You should aim to load genre with a comma delimited list, for example: "Action, Drama, Thriller"
    # and use filters to massage the list into the requisite layout if required.
    # If the selector does not match it is ignored.
    genre:
      selector: genres
    # [OPTIONAL] Factor for the download volume. In most cases it should be set to "1"
    # Set to "0" if a torrent is freeleech, "0.5" if only 50% is counted, "0.75" if only 75% is counted.
    # if a site states that the download is 75% free then the DLVF is 0.25 (only 25% is counted).
    downloadvolumefactor:
      selector: freeleech
      # in this example the freeleech provided by the API is 0=false, 1=true
      # so we use a case block to provide the expected DLVF values
      case:
        0: 1 # not free
        1: 0 # freeleech
    # [OPTIONAL] Factor for the upload volume, in most cases it should be set to "1"
    # Set it to "0" for a torrent that is a neutral leech (upload is not counted), set to "2" for a double upload
    uploadvolumefactor:
      selector: double_upload
      # in this example the double_upload provided by the API is 0=false, 1=true
      # so we use a case block to provide the expected ULVF values
      case:
        0: 1 # normal
        1: 2 # double
    # [OPTIONAL] minimum ratio the torrent client must seed to avoid Hit & Run penalties
    minimumratio:
      text: 0.4
    # [OPTIONAL] minimum number of seconds the client must seed to release the MR requirement
    minimumseedtime:
      # 7 day (as seconds = 7 x 24 x 60 x 60)
      text: 604800
```

### Search Row Selectors

The use of `:has()`, `:not()` and `:contains()` are supported by the rows selector and fields selectors.

```yaml
 rows:
    selector: data:has(attributes.size):has(attributes.name:contains(1080)):has(attributes.poster:contains(.jpg)):not(attributes.fake_att):not(attributes.uploader:contains(DarkSwan2001))
  fields:
    title_dts:
      selector: name:contains(DTS)
      optional: true
      filters:
        - name: re_replace
          args: ["DTS", "DTSSS"]
    title_notdts:
      selector: name:not(:contains(DTS))
      optional: true
    title:
      text: "{{ if .Result.title_dts }}{{ .Result.title_dts }}{{ else }}{{ .Result.title_notdts }}{{ end }}"
      filters:
        - name: re_replace
          args: ["\\[", " "]
```

### Search XML

This is similar to the JSON method except you code type xml:

```plaintext
      response:
        # [REQUIRED] indicates that an XML response is expected
        type: xml
```

Prowlarr parses an XML response with an XML parser and then applies the rows and fields selectors as CSS selectors, the same way as for HTML. So `preprocessingfilters`, `after` and `dateheaders` work, and the JSON-only keys (`attribute`, `multiple`, `count`, `missingAttributeEqualsNoResults`, `noResultsMessage`) are not used.

## Download

The download block is needed in the following cases:

- The torrent download link can't be extracted from the search results (e.g. if it's only available from the details page of the torrent)
- The download request must be done via HTTP POST instead of GET
- You've to access another page first before downloading the file (e.g. you've to click on the "Thank you" button first).

Note: Some trackers just omit the download link from the search results, but it still can be easily generated from the available information (e.g. use the details link and replace "details.php" with "download.php"). In this case the download block isn't needed.

Example of the download block explaining all options:

```yaml
download:
  # [OPTIONAL] use HTTP POST instead of GET to download the torrent file (default is get)
  method: post
  # [OPTIONAL] headers for the download requests. If omitted, the search headers are used.
  # Only the first value of each list is sent.
  headers:
    referer: ["{{ .Config.sitelink }}"]
  # [OPTIONAL] HTTP request which needs to be done before downloading the file
  before:
    # request target
    path: thanks.php
    # send via HTTP POST
    method: post
    # [OPTIONAL] if the before link requires a query separator other than the default "&" then use this
    # Only used for GET requests. The schema also allows queryseparator in search paths, but Prowlarr
    # ignores it there.
    queryseparator: ";"
    # list of HTTP arguments which will be included
    inputs:
      # extract the "id" parameter from the search result download URL query string
      infohash: "{{ .DownloadUri.Query.id }}"
      thanks: 1
  selectors:
    # [OPTIONAL] If a list of selectors is defined, the search result download URL will be retrieved and parsed as HTML.
    # The first selector is then applied to get the actual download URL.
    # If it does not match, or the link fails the torrent test (see testLinkTorrent), the next selector is tried.
    # If no selector works the download fails.
    - selector: a[href^="download.php?id="]
      attribute: href
      # [OPTIONAL] Can be true of false (default is false)
      # Set to true if you want the selector to come from the page generated by the previous BEFORE block.
      # The default causes the selector to come from the page of the link in the search download block.
      usebeforeresponse: false
      # [OPTIONAL] a list of filters which should be applied to the result of this selector
      filters:
        - name: querystring
          args: url
        - name: urldecode
    # [OPTIONAL] As many other selectors as you need, to be used as a fallback for when the prior selector fails to download.
    - selector: a[href^="magnet:?xt="]
      attribute: href
      # [OPTIONAL] a list of filters which should be applied to the result of this selector
      filters:
        - name: toupper
```

### Download Block Infohash Example

```yaml
download:
  # [OPTIONAL] HTTP request which needs to be done before downloading the file
  before:
    path: get_srv_details.php
    inputs:
      action: 2
      id: "{{ .DownloadUri.Query.id }}"
  # [OPTIONAL] If you only have a magnet hash then this method will allow you to automatically generate a magnet URI
  # For use with Public or Semi-Private Indexers.
  # If infohash is set, Prowlarr uses it and ignores the selectors list.
  # Note that this option is not suitable for Private sites which may require ONLY the use of their own tracker and
  # have DHT DISABLED and no other PUBLIC trackers on the magnet.
  infohash:
    # [OPTIONAL] Can be true or false (default is false)
    # Set to true if you want the infohash and title to come from the page generated by the previous BEFORE block.
    # The default causes the infohash and title to come from the page of the link in the search download block.
    usebeforeresponse: true
    # [REQUIRED] Use this selector to provide the file hash for the &xt parameter of the magnet URI
    hash:
      # [REQUIRED] the selector to use to find the file hash
      selector: a[href^="magnet:?xt="]
      attribute: href
      # [OPTIONAL] a list of filters which should be applied to the result of this selector
      filters:
        - name: regexp
          args: ([A-F|a-f|0-9]{40})
    # [REQUIRED] Use this selector to provide the title for the &dn parameter of the magnet URI
    title:
      # [REQUIRED] The selector used to find the title
      selector: meta[property="og:title"]
      attribute: content
      # [OPTIONAL] a list of filters which should be applied to the result of this selector
      filters:
        - name: trim
        - name: validfilename
```

### Download Block "before" Pathselector Example

```yaml
download:
  # Use this method if you need to do a http GET using a href in the details page in order to make a download link available
  before:
    # thankyou link: ./viewtopic.php?f=52&p=65417&thanks=65417&to_id=54&from_id=3950
    pathselector:
      selector: ul.post-buttons li:nth-last-child(1) a
      attribute: href
  selectors:
    - selector: a[href^="magnet:?xt="]
      attribute: href
```

## Key Reference

These tables list every key that Prowlarr reads from a definition, with its type, default, and effect. They reflect the Prowlarr source (`src/NzbDrone.Core/Indexers/Definitions/Cardigann/`) and the v11 `schema.json` in the [Prowlarr/Indexers repository](https://github.com/Prowlarr/Indexers). Keys are case-sensitive. Prowlarr ignores keys it does not know, but the schema rejects them, so a definition must pass both.

### Top Level Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `id` | string | none | Unique internal name of the indexer. Required by the schema. |
| `replaces` | list of strings | none | Old ids of this indexer. Allowed by the schema, not read by Prowlarr. |
| `name` | string | none | Display name. Required by the schema. |
| `description` | string | none | Description shown in the indexer list. Required by the schema. |
| `language` | string | none | Language code of the site, shown as the indexer language. Required by the schema, which limits it to a fixed list of codes. |
| `type` | string | none | `public`, `semi-private` or `private`. Any other value is treated as semi-private. For `private`, no magnet link is generated from an `infohash`. Required by the schema. |
| `encoding` | string | `UTF-8` | Encoding used for requests and by the `urlencode` and `urldecode` filters. Required by the schema. |
| `requestDelay` | number | none | Minimum seconds between requests. Only used if it is more than the 2 second default of Prowlarr. |
| `links` | list of URLs | none | Known site URLs. The first one is the default base URL. Required by the schema. |
| `legacylinks` | list of URLs | empty | Old URLs. If the configured base URL is in this list, Prowlarr uses the first entry of `links` instead. |
| `followredirect` | boolean | `false` | Lets the login page request of the `form` login method follow redirects. No other request uses it. |
| `testLinkTorrent` | boolean | `true` | Before a download selector result is used, request it and check that the response starts with `d` (a bencoded torrent). If not, try the next selector. Magnet links are not tested. See the note below. |
| `certificates` | list of strings | none | Parsed, not used by Prowlarr. |
| `caps` | block | none | Categories and search modes. Required by the schema. |
| `settings` | list | `username` (text) and `password` (password) | Settings shown in the indexer configuration. `settings: []` gives no settings. |
| `login` | block | none | How to log in. If omitted, no login is done. |
| `search` | block | none | How to search and parse results. Required by the schema. |
| `download` | block | none | Special handling for downloads. |

Note on `testLinkTorrent`: Prowlarr reads YAML keys in camelCase and matches them case-sensitively, so the property `TestLinkTorrent` is read from `testLinkTorrent`. The v11 schema only allows the lowercase `testlinktorrent`, which Prowlarr ignores. As a result, `testlinktorrent: false` in a v11 definition has no effect and the link test stays on.

### Caps Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `categorymappings` | list | none | Maps site categories to Newznab categories. Each entry has `id` (site category, required), `cat` (Newznab category name, required), `desc` (site category name, used by the `categorydesc` field) and `default` (boolean, default `false`). Categories with `default: true` are searched when the search has no category that maps to this site. An unknown `cat` is logged as an error and skipped. |
| `categories` | map | none | Short form: site category id to Newznab category name, without `desc` or `default`. |
| `modes` | map | none | Supported search modes: `search`, `tv-search`, `movie-search`, `music-search`, `book-search`. `search` is required and must be exactly `[q]`. Required by the schema. |
| `allowrawsearch` | boolean | `false` | Adds `searchEngine="raw"` to the search modes in the Torznab caps of the indexer. |
| `allowtvsearchimdb` | boolean | none | Allowed by the schema, not read by Prowlarr. |

Search mode parameters that Prowlarr accepts:

| Mode | Parameters |
| --- | --- |
| `tv-search` | `q`, `season`, `ep`, `imdbid`, `tvdbid`, `rid`, `tvmazeid`, `traktid`, `tmdbid`, `doubanid`, `genre`, `year` |
| `movie-search` | `q`, `imdbid`, `tmdbid`, `imdbtitle`, `imdbyear`, `traktid`, `genre`, `doubanid`, `year` |
| `music-search` | `q`, `album`, `artist`, `label`, `year`, `genre`, `track` |
| `book-search` | `q`, `title`, `author`, `publisher`, `genre`, `year` |

The v11 schema does not allow `rid` for `tv-search` or `imdbtitle` and `imdbyear` for `movie-search`.

### Settings Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `name` | string | none | Variable name. The value is available as `.Config.<name>`. Required by the schema. |
| `type` | string | none | Input type, see the next table. Required by the schema. |
| `label` | string | none | Label shown in the UI. |
| `default` | string, number or boolean | none | Default value. For `select` it must be one of the option keys. For `info` it is the text shown. |
| `options` | map | none | For `select`: option key to display text. The options are shown sorted by key. |
| `defaults` | list of strings | none | Only for `multi-select`, which Prowlarr does not support. |

| Setting type | `.Config.<name>` value |
| --- | --- |
| `text`, `password` | The entered text. |
| `checkbox` | Non-empty when checked, null when not checked. Use it with `if`. |
| `select` | The key of the selected option. |
| `info` | No variable. Shows `label` and the `default` text. |
| `info_cookie`, `info_flaresolverr`, `info_useragent`, `info_category_8000` | No variable. Prowlarr supplies the label and text, so `label` and `default` are not used. |

`.Config.sitelink` is always set to the configured base URL.

### Login Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `method` | string | `form` | `form`, `post`, `get` or `cookie` (`oneurl` is legacy). See [Login](#login). |
| `path` | string | none | Login page (`form`) or login target (`post`, `get`). Templates are applied. |
| `submitpath` | string | form `action` | `form` only. Target of the POST, if different from the form action. |
| `form` | string | `form` | `form` only. CSS selector of the login form. |
| `inputs` | map | none | Values to send. Templates are applied. For `form`, they override the values found in the form. Not used by `cookie`. |
| `selectors` | boolean | `false` | `form` only. If true, the keys of `inputs` and the captcha `input` are CSS selectors, and the `name` attribute of the matched element is used as the input name. |
| `selectorinputs` | map of selector blocks | none | `form` only. Values read from the login page and sent in the POST body. |
| `getselectorinputs` | map of selector blocks | none | `form` only. Values read from the login page and added to the query string of the submit URL. |
| `cookies` | list of strings | none | Cookies sent with the `post` login request and with the `form` login page request. |
| `headers` | map of lists | `search.headers` | Headers for login requests. Only the first value of each list is sent. |
| `captcha` | block | none | `form` only. `type` (only `image` is implemented), `selector` (the captcha `img`), `input` (name of the form input for the answer). Setting this adds a CAPTCHA field to the indexer settings. A captcha found during an automatic re-login stops the login. |
| `error` | list | none | Error checks on the login response. Each entry has `selector` (required) and optional `message` (a selector block for the error text). `path` is allowed but not used. |
| `test` | block | none | `selector` is checked on HTML search responses to detect an expired login. `path` is required by the schema but not used by Prowlarr. |

### Search Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `path` | string | none | Single search path. Prowlarr adds it to `paths` with `inheritinputs: true`. |
| `paths` | list | none | Search paths, see the next table. Each path is a separate request. GET requests with the same URL are only sent once. |
| `inputs` | map | none | Inputs for all paths. Templates are applied. `$raw` is added as a pre-built query string. |
| `allowEmptyInputs` | boolean | `false` | Send inputs whose value is empty. |
| `headers` | map of lists | none | Headers for search requests. Only the first value of each list is sent. |
| `keywordsfilters` | list of filters | none | Applied to `.Query.Keywords`. The result is `.Keywords`. |
| `preprocessingfilters` | list of filters | none | Applied to the whole HTML or XML response before parsing. |
| `error` | list | none | Parsed, not checked by Prowlarr. |
| `rows` | block | none | How to find result rows. See below. Required by the schema. |
| `fields` | map | none | How to read each release field. Required by the schema. |

### Search Paths Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `path` | string | none | Request path. Templates are applied, and variable values inserted by the template are URL-encoded. Required by the schema. |
| `method` | string | `get` | `get` or `post` (case-insensitive). With `post`, inputs are sent as form data. Templates are not applied to this key. |
| `inputs` | map | none | Extra inputs for this path. |
| `inheritinputs` | boolean | `true` | Include the search level `inputs`. |
| `categories` | list | none | Site categories that select this path. A leading `"!"` inverts the match. |
| `followredirect` | boolean | `false` | Follow redirects for this search request. |
| `response` | block | HTML | `type`: `json` or `xml` (required if `response` is set). `noResultsMessage`: for `json`, return no results if the response contains this text, or if it is empty and the response is empty. |
| `queryseparator` | string | `&` | Allowed by the schema, not used for search paths. |

### Search Rows Keys

| Key | Type | Default | Applies to | Description |
| --- | --- | --- | --- | --- |
| `selector` | string | none | all | CSS selector (HTML, XML) or JSONPath with optional `:has()`, `:not()`, `:contains()` (JSON). Templates are applied. |
| `after` | integer | `0` | HTML, XML | Merge this many following rows into each row. |
| `dateheaders` | selector block | none | HTML, XML | Date from a previous row when the row has no date. |
| `filters` | list | none | all | Row filters: `andmatch` and `strdump` only. |
| `attribute` | string | none | JSON | Path inside each row that holds the release object or list. |
| `multiple` | boolean | `false` | JSON | The `attribute` holds a list of releases. |
| `count` | selector block | none | JSON | If this value is below 1, return no results. |
| `missingAttributeEqualsNoResults` | boolean | `false` | JSON | If the rows selector matches nothing, return no results instead of an error. Rows without the `attribute` are skipped. |

The schema also allows `optional`, `case`, `remove` and `text` in `rows`, but Prowlarr does not use them there.

### Selector Keys

A selector block is used for each field, and for `dateheaders`, `count`, `selectorinputs`, `getselectorinputs` and the login error `message`.

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `selector` | string | the row | CSS selector (HTML, XML) or JSON path (JSON). Templates are applied. In HTML, a selector that starts with `:root` searches from the document root. In JSON, a leading `..` reads from the row instead of the `attribute` object. |
| `attribute` | string | text content | HTML attribute to read. |
| `text` | string or number | none | Fixed value. Templates are applied. If set, `selector` is ignored. |
| `remove` | string | none | HTML only. CSS selector of child elements to remove before reading the text. |
| `case` | map | none | HTML: the key is a CSS selector, the first match gives the value. JSON: the key is compared with the value, `"*"` matches anything. |
| `filters` | list of filters | none | Filters applied to the value. |
| `optional` | boolean | `false` | Do not fail if nothing matches. |
| `default` | string or number | none | Value used when an optional selector returns nothing. Templates are applied. |

### Search Fields Keys

| Field | Effect in Prowlarr |
| --- | --- |
| `title` | Release title. Required by the schema. |
| `download` | Download URL. A value that starts with `magnet:` is used as the magnet link. Also used as the release GUID. |
| `magnet` | Magnet link. |
| `infohash` | Info hash. For non-private indexers a magnet link is built from it if there is no magnet. |
| `details` | Details page URL. |
| `comments` | Comments page URL. |
| `category` | Site category id, mapped through `caps`. Values from more than one `category` field are combined. |
| `categorydesc` | Site category name, mapped through the `desc` of `categorymappings`. |
| `size` | Size, units are parsed. Required by the schema. |
| `seeders`, `leechers` | Peer counts. Values of 5000000 or more are set to 0. `seeders` is required by the schema. |
| `date` | Publish date, parsed like `fuzzytime`. |
| `files`, `grabs` | Integers. |
| `downloadvolumefactor`, `uploadvolumefactor` | Numbers. |
| `minimumratio` | Number. |
| `minimumseedtime` | Seconds. |
| `imdb`, `imdbid`, `tmdbid`, `rageid`, `tvdbid`, `tvmazeid`, `traktid`, `doubanid` | The first number in the value. |
| `poster` | Poster URL. |
| `genre` | Split into genres on spaces and on these characters: `,` `/` `(` `)` `.` `;` `[` `]` `"` `\|` `:`. An `_` in a genre becomes a space. |
| `year` | Integer. |
| `author`, `booktitle`, `publisher`, `artist`, `album`, `label`, `track` | Text. |
| `description` | Release description. |

Any other field name only sets `.Result.<name>`. The schema requires exactly one of `category` and `categorydesc`, and at least one of `download`, `magnet` and `infohash`.

### Download Keys

| Key | Type | Default | Description |
| --- | --- | --- | --- |
| `method` | string | `get` | `post` (lowercase) sends the final download request as POST. |
| `headers` | map of lists | `search.headers` | Headers for download requests. Only the first value of each list is sent. |
| `before` | block | none | A request sent before the download. Keys: `path`, `method`, `inputs`, `queryseparator` (default `&`), `pathselector` (a download selector that reads `path` from the download page). The `.DownloadUri` variables are available. |
| `selectors` | list | none | Download selectors, tried in order. Keys: `selector`, `attribute`, `filters`, `usebeforeresponse` (default `false`, read from the `before` response instead of the download page). |
| `infohash` | block | none | Build a magnet link from the page. Keys: `hash` and `title` (download selectors), `usebeforeresponse` (default `false`). |

# Template Engine

The template engine is very basic, and supports the following statements.

Prowlarr evaluates them in this order: `re_replace`, `join`, the logic functions (`and`, `or`, `eq`, `ne`), `if ... else ... end`, `range`, and then plain variables. Referencing a variable that does not exist is an error, it does not give an empty value.

## re_replace

A simple regex replace operation.

Syntax: `{{ re_replace .Variable "regex-term" "replace-term"}}`

Example:

```yaml
# Replace any non alphanumeric character in the keywords with the wildcard character
"{{ re_replace .Keywords \"[^a-zA-Z0-9]+\" \"*\" }}"
```

## if ... else ... end

A basic if/else condition. Only boolean true (non-empty)/false (empty) operations on variables are supported.

Syntax: `{{ if .Variable }}on true result{{ else }}on false result{{ end }}`

The `{{ else }}` part is required, use `{{ else }}{{ end }}` for an empty result. The condition must be a single variable (or the result of a logic function). A string is true if it is not empty or white space, and a list is true if it has at least one item.

Example:

```yaml
search:
  paths:
    # when .Keywords contains a value
    # then search.php is used as for the path
    # otherwise latest.php is used
    - path: "{{ if .Keywords }}search.php{{ else }}latest.php{{ end }}"
```

## if or/and ... else ... end

The implementation is based on: [go hdr functions](https://golang.org/pkg/text/template/#hdr-Functions)
These are not true logical OR and AND operators in that they operate on variables that contain a value or are empty.
Note that the use of round brackets is entirely optional.

- `or` returns the first variable that is not empty, or else the last variable.
- `and` returns the first variable that is empty, or else the last variable.
- Both take two or more variables. Quoted string literals are ignored by `and` and `or`.

Example of: if or ... else ... end

```yaml
search:
  paths:
    # when any of the 3 vars in brackets has a value
    # then set the path to search
    # otherwise set it to music
    - path: "{{ if or (.Query.Album) (.Query.Artist) (.Keywords) }}search{{ else }}music{{ end }}"
  inputs:
    # when either/both of the two query vars in the brackets have a value
    # then load whichever vars have a value to the string
    # and when neither var has a value then load the value from .Keywords to the string
    q: "{{ if or (.Query.Album) (.Query.Artist) }}{{ or (.Query.Album) (.Query.Artist) }}{{ else }}{{ .Keywords }}{{ end }}"
```

Example of: if and ... else ... end

```yaml
    title:
      # when both the vars in brackets have a value
      # then load the value from title_polish to the string
      # when only one of the vars has a value, or both vars have no value
      # then load the value from title_phase1 to the string
      text: "{{ if and (.Config.lang) (.Result.is_polish) }}{{ .Result.title_polish }}{{ else }}{{ .Result.title_phase1 }}{{ end }}"
```

## if eq/ne ... else ... end

The implementation is based on: [go hdr functions](https://golang.org/pkg/text/template/#hdr-Functions)
This is a string comparison only.
Supports the use of both variables and strings. Strings must be in double quotes. Only the first two values are compared. The result is `.True` or `.False`.

Example of: if eq ... else ... end

```yaml
    size:
      # when the variable .Result._cat contains the string "series"
      # then the text string will be set to "512 MB"
      # otherwise it will be set to "2 GB"
      text: "{{ if eq .Result._cat \"series\" }}512 MB{{ else }}2 GB{{ end }}"
```

Nesting is supported.

```yaml
    size:
      # when the variable .Result.cat contains any of the strings "movie", "movie_etc", "movie_eng"
      # then the text string will be set to "2 GB"
      # otherwise it will be set to "512 MB"
      text: "{{ if or (eq .Result.cat \"movie\") (or (eq .Result.cat \"movie_etc\") (eq .Result.cat \"movie_eng\")) }}2 GB{{ else }}512 MB{{ end }}"
```

Special variables .True and .False are available
.True contains "True" (which represents a non-empty variable) and
.False contains null (which represents an empty variable).

## join

A simple loop over a list variable building a concatenated string with items joined by a delimiter.

Syntax: `{{ join .Variable "<delimiter>"}}`

Example:

```yaml
# build a query string by concatenating all the categories with a comma
# input: [101,201,301]
"{{join .Categories \",\"}}"
# output: "101,201,301"
```

## range

A simple loop over a list variable building a concatenated string.

Syntax: `{{ range .Variable }}<prefix>{{.}}<suffix>{{end}}`

Example:

```yaml
# build a query string argument list for the selected categories
# input: [101,201,301]
"{{ range .Categories }}&cat{{.}}=1{{end}}"
# output: "&cat101=1&cat201=1&cat301=1"
```

## range (with indexing)

If a parameter requires indexing then use the following to generate an incremental index starting with zero.

Syntax: `{{ range $i, $e := .Variable }}<prefix[{{$i}}]>{{.}}<suffix>{{end}}`

Example:

```none
# build a query string argument list for the selected categories with indexing
# input: [101,201,301]
"{{ range $i, $e := .Categories }}&categories[{{$i}}]={{.}}{{end}}"
# output: "&categories[0]=101&categories[1]=201&categories[2]=301"
```

## Variable substitution

The basic variable substitution operation.

Syntax: `{{ .Variable }}`

## Variables

Variables start with a `.` and are replaced with their value. The sections below list the variables Prowlarr sets. Some are set only in some contexts: `.Query` and `.Keywords` only during a search, `.Result` only while fields are parsed, and `.DownloadUri` only during a download.

## Config Variables

Note that these are always available.
Generated based on the settings section

```yaml
.Config.$Name # for example .Config.username , .Config.password , .Config.sitelink
```

## Special Variables

Note that these are always available.

```yaml
.True contains "True" (which represents a non-empty variable)
.False contains null (which represents an empty variable)
.Today.Year contains "2024" (or whatever the current year is)
.Config.sitelink contains the base URL configured for the indexer
```

## Search Query Variables

Note that these are only available during search queries.

```yaml
.Query.Type        # search, movie, tvsearch, book, music
.Query.Q
.Query.Series      # not supported (Cardigann compatibility)
.Query.Ep          # from t=tvsearch
.Query.Season      # from t=tvsearch
.Query.Movie       # not supported (Cardigann compatibility)
.Query.Year        # from t=tvsearch or t=movie or t=music or t=book
.Query.Limit
.Query.Offset
.Query.Extended    # always null in Prowlarr
.Query.Categories  # the requested Torznab category ids
.Query.APIKey      # always null in Prowlarr
.Query.TVDBID      # from t=tvsearch
.Query.TVRageID    # from t=tvsearch
.Query.IMDBID      # e.g. tt12345678 from t=tvsearch or t=movie
.Query.IMDBIDShort # e.g. 12345678
.Query.TMDBID      # from t=tvsearch or t=movie
.Query.TVMazeID    # from t=tvsearch
.Query.TraktID     # from t=tvsearch or t=movie
.Query.DoubanID    # from t=tvsearch or t=movie
.Query.Genre       # from t=tvsearch or t=movie or t=music or t=book
.Query.Album       # from t=music
.Query.Artist      # from t=music
.Query.Label       # from t=music
.Query.Track       # from t=music
.Query.Episode     # EpisodeSearchString, such as S00E00 or S00 or yyyy.MM.dd from t=tvsearch
.Query.Author      # from t=book
.Query.Title       # from t=book
.Query.Publisher   # from t=book
.Categories        # MappedCategories
.Query.Keywords    # original keywords
.Keywords          # keywords after applying the keywordsfilters
```

`.Query.Keywords` is built from `.Query.Q`, `.Query.Series`, `.Query.Movie`, `.Query.Year` and `.Query.Episode`, joined with spaces, skipping empty values. So a TV search for season 1 episode 2 adds `S01E02` to the keywords.

`.Categories` holds the site category ids that the requested Torznab categories map to. If none map, it holds the categories marked `default: true` in `categorymappings`. Inside a search path with `categories`, it only holds the categories that matched that path.

The following boolean-like variables are documented in the upstream Jackett Cardigann specification. **These variables are NOT implemented as template variables in Prowlarr's Cardigann engine**. They exist as internal C# properties on the search criteria objects but are never added to the template variables. Referencing them in a YAML definition is an error, because the variable does not exist.

```yaml
.Query.IsBookSearch   # t=book (Jackett only, not available in Prowlarr templates)
.Query.IsDoubanQuery  # from t=tvsearch or t=movie (Jackett only)
.Query.IsGenreQuery   # from t=tvsearch or t=movie or t=music or t=book (Jackett only)
.Query.IsIdSearch     # (Jackett only)
.Query.IsImdbQuery    # from t=tvsearch or t=movie (Jackett only)
.Query.IsMovieSearch  # t=movie (Jackett only)
.Query.IsMusicSearch  # t=music (Jackett only)
.Query.IsRssSearch    # SearchTerm.IsNullOrWhiteSpace() && !IsIdSearch (Jackett only)
.Query.IsSearch       # t=search (Jackett only)
.Query.IsTVRageQuery  # from t=tvsearch (Jackett only)
.Query.IsTVSearch     # t=tvsearch (Jackett only)
.Query.IsTmdbQuery    # from t=tvsearch or t=movie (Jackett only)
.Query.IsTraktQuery   # from t=tvsearch or t=movie (Jackett only)
.Query.IsTvdbQuery    # from t=tvsearch (Jackett only)
.Query.IsTvmazeQuery  # from t=tvsearch (Jackett only)
```

Note: There are several variables that are not supported and are provided by Cardigann for compatibility with the Torznab specifications (`.Query.Series`, `.Query.Movie`, `.Query.Extended`, `.Query.APIKey`). These variables will always return null.

All field results are available to the following fields via the `.Result.$FieldName` variables too.
For example:

```yaml
  fields:
    title:
      selector: h3 a
    _subcat:
      selector: div.box ul li:first-child
    year:
      selector: div.box ul li:contains("Year:")
    _quality:
      selector: div.box ul li:contains("Quality:")
    description:
      text: "{{ .Result._subcat }} {{ .Result.year }} {{ .Result._quality }}"
```

Temporary variables used to help build release results should contain an underscore in their variable names, such as `title_phase1` or `_quality`. The v11 schema enforces this: a field name must either start with `_`, or be a known field name optionally followed by `_` and a suffix.

## Download Variables

Based on the download search field result the following variables are available:

```yaml
.DownloadUri.AbsoluteUri        example: https://domain.to/torrent/1234567/A-Torrent-Name-1080p/
.DownloadUri.AbsolutePath       example: /torrent/1234567/A-Torrent-Name-1080p/
.DownloadUri.Scheme             example: https
.DownloadUri.Host               example: domain.to
.DownloadUri.Port               example: 443
.DownloadUri.PathAndQuery       example: /torrent/1234567/A-Torrent-Name-1080p/
.DownloadUri.Query              example: ?id=1234567 (the raw query string)
```

For each query string argument of the URI a corresponding `.DownloadUri.Query.$Key` variable is generated.
for example, a URI like `https://amigos-share.club/torrents-details.php?id=37346&hit=yes`
would generate the following two variables:
`.DownloadUri.Query.id` with the value `37346` and
`.DownloadUri.Query.hit` with the value `yes`.

# Filters

Filters are applied in the order listed. Prowlarr supports the filters below. An unknown filter name is logged as an error and skipped. The only row filters (`rows: filters:`) are `andmatch` and `strdump`.

## querystring

Extract values from URL arguments.

Example:

```yaml
# extract the category ID from a category link
selector: a[href^="browse.php?cat="]
attribute: href
filters:
  # input: browse.php?cat=123
  - name: querystring
    args: cat
  # result: 123
```

## prepend

Inserts a *string* by appending additional characters to the beginning of its current value.
The single parameter in the argument is the *string* to be prefixed. Templates in the argument are applied.

Example:

```yaml
# prefix InfoHash with a magnet URI header
selector: span > a
attribute: href
filters:
  # input: B21F2A6DB07A8F4F76E2C5E15D28235D356B8D41
  - name: prepend
    args: "magnet:?xt=urn:btih:"
  # result: magnet:?xt=urn:btih:B21F2A6DB07A8F4F76E2C5E15D28235D356B8D41
```

## append

Extends a *string* by appending additional characters to the end.
The single parameter in the argument is the *string* to be appended. Templates in the argument are applied.

Example:

```yaml
# add a tracker to complete the magnet URI
selector: span > a
attribute: href
filters:
  # input: magnet:?xt=urn:btih:B21F2A6DB07A8F4F76E2C5E15D28235D356B8D41&dn=I.Am.A.Magnet
  - name: append
    args: "&tr=udp://tracker.coppersurfer.tk:6969"
  # result: magnet:?xt=urn:btih:B21F2A6DB07A8F4F76E2C5E15D28235D356B8D41&dn=I.Am.A.Magnet&tr=udp://tracker.coppersurfer.tk:6969
```

## tolower

Converts a *string* to lowercase letters.
Does not require any parameters.

Example:

```yaml
# make the title lowercase
selector: dt a
filters:
  # input: MY MOVIE TITLE 1080P
  - name: tolower
  # result: my movie title 1080p
```

## toupper

Converts a *string* to uppercase letters.
Does not require any parameters.

Example:

```yaml
# make the title uppercase
selector: dt a
filters:
  # input: my movie title 1080p
  - name: toupper
  # result: MY MOVIE TITLE 1080P
```

## replace

If the *pattern string* is matched, then the *pattern* is replaced by a *replacement string*.
The first parameter in the argument is the *pattern string*, and the second is the *replacement string*. Every match is replaced. Templates in the replacement string are applied.

Example:

```yaml
# fix the date field when it contains Y-day
selector: td:nth-child(2)
filters:
  # input: Y-day 12:27
  - name: replace
    args: ["Y-day", "yesterday"]
  # result: yesterday 12:27
```

## split

Divides a *string* into an array of *substrings*, and return the selected *substring*.
The first parameter in the argument is the single character *pattern* used to split the *string*, and the second parameter is the array element *number* of the wanted *substring*, counting from zero for the first element. A negative number counts from the end, so `-1` is the last element. Only the first character of the pattern is used.

Example:

```yaml
# extract the category id
selector:  td[class^="coll-1"] a[href^="sub/"]
attribute: href
filters:
  # input: sub/45/0
  - name: split
    args: ["/", 1]
  # result: 45
```

## trim

Removes all leading and trailing occurrences of a specified *character*.
Used without an argument removes all leading and trailing *white-space characters*.
If an argument is supplied, Prowlarr only uses its first character, and removes all leading and trailing occurrences of that character.

Example:

```yaml
# fetch the title
selector: td:nth-child(2) a
attribute: title
filters:
  # input: &nbsp;This Is My Title&nbsp;
  - name: trim
  # result: This Is My Title
```

```yaml
# extract the title
selector: td:nth-child(2) a
attribute: title
filters:
  # input: xxxThis Is My Titlexxx
  - name: trim
    args: "x"
  # result: This Is My Title
```

## regexp

Perform pattern-matching and "search-and-replace" functions on a *string* using a [Regular Expression](https://docs.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference).

The result is the first capture group of the first match. If there is no match, or the pattern has no capture group, the result is an empty string.

Example:

```yaml
# extract the uploaded date and time
selector: td:nth-child(2) font.detDesc
filters:
  # input: Uploaded 09-14 02:31, Size 282.88 MiB, ULed by
  - name: regexp
    args: "Uploaded (.+?),"
  # result: 09-14 02:31
```

## re_replace

Similar to [replace](#replace), but the parameters in the argument are [Regular Expressions](https://docs.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference). Templates in the replacement are applied, and `$1`, `$2` and so on insert capture groups.

Example:

```yaml
# normalize to SXXEYY format
selector: td:nth-child(2) a.tab
attribute: href
filters:
  # input: 12x45
  - name: re_replace
    args: ["(\\d{2})x(\\d{2})", "S$1E$2"]
  # result: S12E45
```

## validate

Given a list of words, delimited by any one of `, /.)(;[]"|:` this filter will return a comma delimited list of only the words that
are in the args. Useful for removing non-genre types from an open tag list.

Note: to preserve a double word (for example `Science Fiction` or `Sci-Fi & Fantasy`) replace the spaces with underscores. These will be auto-restored in results.

Example:

```yaml
# remove any tags that are not standard genre types
selector: div.tags
filters:
  - name: re_replace
    args: ["(?i)(Science Fiction)", "Science_Fiction"]
  # input: crime, x264, 1080p, (music), pack, comedy, Science_Fiction, dd5.1, Hip/Hop
  - name: validate
    args: "Action, Adventure, Crime, Comedy, Science_Fiction, War"
  # result: crime, comedy, science fiction
```

## dateparse

Converts a date/time *string* into a DateTime object ("ddd, dd MMM yyyy HH:mm:ss z").
Takes one argument, the *format* to use for the conversion. The *string* to convert is the current value.
For a full breakdown of the format specifiers see <https://learn.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings>

Prowlarr specifics:

- The format is tried as a .NET format if it contains `y`, `h` or `d` (any case). Otherwise, or if that fails, it is read as a Go reference layout (for example `2006-01-02 15:04:05`). The v11 schema rejects `dateparse` arguments that contain digits, so use .NET formats in definitions.
- If the date cannot be parsed, the value is left unchanged and a debug message is logged.

Here are the more common format specifiers used by Jackett

| format specifier | description                                                          | example                             |
| ---------------- | -------------------------------------------------------------------- | ----------------------------------- |
| yyyy             | The year as a four-digit number.                                     | 2009-06-15T13:45:30.6175 -> 2009    |
| yy               | The year, from 00 to 99.                                             | 2009-06-15T13:45:30.6175 -> 09      |
| MMMM             | The full name of the month.                                          | 2009-06-15T13:45:30.6175 -> June    |
| MMM              | The abbreviated name of the month.                                   | 2009-06-15T13:45:30.6175 -> Jun     |
| MM               | The month, from 01 through 12.                                       | 2009-06-15T13:45:30.6175 -> 06      |
| M                | The month, from 1 through 12.                                        | 2009-06-15T13:45:30.6175 -> 6       |
| dddd             | The full name of the day of the week.                                | 2009-06-15T13:45:30.6175 -> Monday  |
| ddd              | The abbreviated name of the day of the week.                         | 2009-06-15T13:45:30.6175 -> Mon     |
| dd               | The day of the month, from 01 through 31.                            | 2009-06-15T13:45:30.6175 -> 15      |
| d                | The day of the month, from 1 through 31.                             | 2009-06-15T13:45:30.6175 -> 15      |
| HH               | The hour, using a 24-hour clock from 00 to 23.                       | 2009-06-15T13:45:30.6175 -> 13      |
| H                | The hour, using a 24-hour clock from 0 to 23.                        | 2009-06-15T13:45:30.6175 -> 13      |
| hh               | The hour, using a 12-hour clock from 01 to 12.                       | 2009-06-15T13:45:30.6175 -> 01      |
| h                | The hour, using a 12-hour clock from 1 to 12.                        | 2009-06-15T13:45:30.6175 -> 1       |
| mm               | The minute, from 00 through 59.                                      | 2009-06-15T13:45:30.6175 -> 45      |
| m                | The minute, from 0 through 59.                                       | 2009-06-15T13:45:30.6175 -> 45      |
| ss               | The second, from 00 through 59.                                      | 2009-06-15T13:45:30.6175 -> 30      |
| s                | The second, from 0 through 59.                                       | 2009-06-15T13:45:30.6175 -> 30      |
| ffff             | The ten thousandths of a second in a date and time value.            | 2009-06-15T13:45:30.6175 -> 6175    |
| fff              | The milliseconds in a date and time value.                           | 2009-06-15T13:45:30.6175 -> 617     |
| ff               | The hundredths of a second in a date and time value.                 | 2009-06-15T13:45:30.6175 -> 61      |
| f                | The tenths of a second in a date and time value.                     | 2009-06-15T13:45:30.6175 -> 6       |
| tt               | The AM/PM designator.                                                | 2009-06-15T13:45:30.6175 -> PM      |
| zzz              | Hours and minutes offset from UTC.                                   | 2009-06-15T13:45:30-07:00 -> -07:00 |
| zz               | Hours offset from UTC, with a leading zero for a single-digit value. | 2009-06-15T13:45:30-07:00 -> -07    |

Example:

```yaml
# get the DateTime
selector: td.torrent_table_dateAdded
filters:
  # input: 2017-09-18 19:17:24 +00:00
  - name: dateparse
    args: "yyyy-MM-dd HH:mm:ss zzz"
  # result: Mon, 18 Sep 2017 19:17:24 GMT
```

## timeparse

Alias for [dateparse](#dateparse)

## timeago

Converts a time-ago *string* into a DateTime object ("ddd, dd MMM yyyy HH:mm:ss z").
Does not require an argument.
Timeago can handle a time-ago *string* such as:

```none
now
2 hours and 1 day
4 years ago
1 week
5 months
9hr,12m,39s
8 days 3 hours 12 minutes 10 seconds
```

Example:

```yaml
# get the DateTime (assuming the current time is Mon, 18 Sep 2017 19:17:24 GMT)
selector: td.torrent_table_dateAdded
filters:
  # input: 2 hours and 1 day
  - name: timeago
  # result: Sun, 17 Sep 2017 17:17:24 GMT
```

## reltime

Alias for [timeago](#timeago)

## fuzzytime

Converts a fuzzy-time *string* into a DateTime object ("ddd, dd MMM yyyy HH:mm:ss z").
By default fuzzytime renders a USA_Date. Note: the "UK" argument for UK date format is not implemented in Prowlarr's Cardigann engine. Filter args are ignored and USA date format is always used.
Fuzzytime can handle a fuzzy-time *string* such as:

```yaml
now
4 years ago (or any other timeago values)
Today
Yesterday
Tomorrow
1505788002 (a UNIX time-stamp Tue Sep 19 02:26:42 2017 UTC)
01-31 (dates without a year value)
1 Jan
Wednesday at 15:30
```

Example:

```yaml
# get the DateTime (assuming the current time is Mon, 18 Sep 2017 19:17:24 GMT)
selector: td.torrent_table_dateAdded
filters:
  # input: Yesterday
  - name: fuzzytime
  # result: Sun, 17 Sep 2017 19:17:24 GMT
```

## htmldecode

Converts a *string* that has been HTML-encoded for HTTP transmission into a decoded *string*.

Example:

```yaml
# decode the HTML
selector: td:nth-child(2) a
attribute: href
filters:
  - name: querystring
    args: f
  # input: Anne+Rice%26%23039%3Bs+Mayfair+Witches+S01E01+1080p+WEB-DL+DD%2B+5.1+H.264-GGEZ
  - name: htmldecode
  # result: Anne Rice's Mayfair Witches S01E01 1080p WEB-DL DD+ 5.1 H.264-GGEZ
```

## htmlencode

Converts a *string* into an HTML-encoded *string* for HTTP transmission.

Example:

```yaml
# encode the string for HTML transmission
selector: td:nth-child(2) a
attribute: title
filters:
  # input: Anne Rice's Mayfair Witches
  - name: htmlencode
  # result: Anne Rice&#39;s Mayfair Witches
```

## urldecode

Converts a *string* that has been encoded for transmission in a URL into a decoded *string*.

Example:

```yaml
# decode the url
selector: td:nth-child(2) a.tab
attribute: href
filters:
  # input: https://zooqle.com/search?q=preacher+s01e10
  - name: urldecode
  # result: https://zooqle.com/search?q=preacher s01e10
```

## urlencode

Encodes a URL *string*.

Example:

```yaml
# encode the url
magfile:
  text: "{{ .Result.title }}"
  filters:
    # input: https://zooqle.com/search?q=preacher s01e10
    - name: urlencode
    # result: https://zooqle.com/search?q=preacher+s01e10
```

## validfilename

Ensures that a *string* comprises only characters that are valid for use in filenames.
Prowlarr replaces each invalid character with `_`. The set of invalid characters comes from .NET and depends on the operating system. On Linux it is only `/` and the null character.

Example:

```yaml
# get the filename
text: "{{ .Result.title }}"
filters:
  # input: a file/Name
  - name: validfilename
  # result: a file_Name
```

## diacritics

Replace diacritics characters with their base character.
The only supported argument is `replace`. Any other argument is an error.

Example:

```yaml
# replace any diacritics
keywordsfilters:
  # input: Å ÄÄÅ½Å¡ÄÄÄÅ¾
  - name: diacritics
    args: replace
  # result: SÄCZsÄccz
```

## jsonjoinarray

Parse the input string as JSON, apply a JSONPath expression and join the resulting array using the specified separator.

args: [JSONPathExpression, separator]

Example:

```yaml
  # extract HTML code from a JSON response
  preprocessingfilters:
    - name: jsonjoinarray
      args: ["$.result", ""]
```

## hexdump

Dump the current value to the log with the HEX code of each character (for debugging purposes).
You will need to have *Enhanced Logging* enabled to view the results. The log line is labelled `strdump`.

Example:

```yaml
date:
selector: div[class="resultdivbotton"] div[class="resulttime"] div[class="resultdivbottontime"]
filters:
  # input: Tue, 19 Sep 2017 21:21:52 +12
  - name: hexdump
  # result in the log: MM-dd hh:mm:ss Debug CardigannIndexer (trackername): strdump: T(54)u(75)e(65),(2C) (20)1(31)9(39) (20)S(53)e(65)p(70) (20)2(32)0(30)1(31)7(37) (20)2(32)1(31):(3A)2(32)1(31):(3A)5(35)2(32) (20)+(2B)1(31)2(32)
```

## strdump

Dump the HTML of each row or field to the log (for debugging purposes).
You will need to have *Enhanced Logging* enabled to view the results.
If you are using strdump to debug multiple field selectors, you can use the Optional args so that you can uniquely tag the results in the enhanced log.

Example:

```yaml
selector: div[class="resultdivbotton"] div[id^="hideinfohash"]
filters:
  # input: dbbde2fc0c299c1d1aa43280b57dafc3fbf0bd39
  - name: strdump
  # result in the log: MM-dd hh:mm:ss Debug CardigannIndexer (trackername): strdump: dbbde2fc0c299c1d1aa43280b57dafc3fbf0bd39
```

```yaml
fields:
  title:
    selector: a[href*="?p=torrents&pid=10&action=details"]
    filters:
      # input: Star Trek 1080p
      - name: strdump
        args: title
      # result in the log: # MM-dd hh:mm:ss Debug CardigannIndexer (trackername): strdump(title): Star Trek 1080p
  download:
    selector: a[href^="details.php/?id="]
    attribute: href
    filters:
      # input: http://tracker.btnext.com/details.php/?id=123456
      - name: strdump
        args: dl_href_in
      # result in the log: MM-dd hh:mm:ss Debug CardigannIndexer (trackername): strdump(dl_href_in): http://tracker.btnext.com/details.php/?id=123456
      - name: replace
        args: ["/details.php/", "/download.php/"]
      - name: strdump
        args: dl_href_out
      # result in the log: MM-dd hh:mm:ss Debug CardigannIndexer (trackername): strdump(dl_href_out): http://tracker.btnext.com/download.php/?id=123456
```

## Proposed changes

- Add support for a more powerful and cross platform template engine (JavaScript?)
- Add support for multi row parsing as described in <https://github.com/cardigann/cardigann/pull/336#issuecomment-277645749>

## Credit

Documentation and examples are maintained by the Jackett Team within their [Wiki](https://github.com/Jackett/Jackett/wiki/Definition-format) and synced to Prowlarr's documentation.

- [Jackett Wiki Contributors](https://github.com/Jackett/Jackett/wiki/Definition-format)
- [Prowlarr Wiki Contributors](https://wiki.servarr.com/prowlarr/cardigann-yml-definition)
