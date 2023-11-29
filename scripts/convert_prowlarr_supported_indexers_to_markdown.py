"""
conver_prowlarr_supported_indexers_to_markdown.py

The purpose of this script is to export a markdown table for the wiki of the available indexers.
We get the most recent commits from two repositories and from the existing specified output page.
The current and existing commits are compared and if needed a new wiki page is generated.
Specifcally the indexer tables are compared.
"""

import json
import logging
import sys
import argparse
from datetime import datetime
import requests
import iso639
import re
import pycountry
import hashlib

# Constants
API_VERSION = "v1"
WIKI_1NEWLINE = "\n"
WIKI_2NEWLINE = "\n\n"
WIKI_ENCODING = "utf8"
WIKI_INFOLINK = "https://wiki.servarr.com/prowlarr/supported-indexers#"
GH_APP_URL = "https://api.github.com/repos/Prowlarr/Prowlarr/commits"
GH_APP_COMMIT_URL = "https://github.com/Prowlarr/Prowlarr/commit/"
GH_INDEXER_URL = "https://api.github.com/repos/Prowlarr/Indexers/commits"
GH_INDEXER_COMMIT_URL = "https://github.com/Prowlarr/Indexers/commit/"
LANG_DICT = {
    'af': 'Afrikaans',
    'af-ZA': 'Afrikaans (South Africa)',
    'ar': 'Arabic',
    'ar-AE': 'Arabic (U.A.E.)',
    'ar-BH': 'Arabic (Bahrain)',
    'ar-DZ': 'Arabic (Algeria)',
    'ar-EG': 'Arabic (Egypt)',
    'ar-IQ': 'Arabic (Iraq)',
    'ar-JO': 'Arabic (Jordan)',
    'ar-KW': 'Arabic (Kuwait)',
    'ar-LB': 'Arabic (Lebanon)',
    'ar-LY': 'Arabic (Libya)',
    'ar-MA': 'Arabic (Morocco)',
    'ar-OM': 'Arabic (Oman)',
    'ar-QA': 'Arabic (Qatar)',
    'ar-SA': 'Arabic (Saudi Arabia)',
    'ar-SY': 'Arabic (Syria)',
    'ar-TN': 'Arabic (Tunisia)',
    'ar-YE': 'Arabic (Yemen)',
    'az': 'Azeri (Latin)',
    'az-AZ': 'Azeri (Azerbaijan)',
    'be': 'Belarusian',
    'be-BY': 'Belarusian (Belarus)',
    'bg': 'Bulgarian',
    'bg-BG': 'Bulgarian (Bulgaria)',
    'bs-BA': 'Bosnian (Bosnia and Herzegovina)',
    'ca': 'Catalan',
    'ca-ES': 'Catalan (Spain)',
    'cs': 'Czech',
    'cs-CZ': 'Czech (Czech Republic)',
    'cy': 'Welsh',
    'cy-GB': 'Welsh (United Kingdom)',
    'da': 'Danish',
    'da-DK': 'Danish (Denmark)',
    'de': 'German',
    'de-AT': 'German (Austria)',
    'de-CH': 'German (Switzerland)',
    'de-DE': 'German (Germany)',
    'de-LI': 'German (Liechtenstein)',
    'de-LU': 'German (Luxembourg)',
    'dv': 'Divehi',
    'dv-MV': 'Divehi (Maldives)',
    'el': 'Greek',
    'el-GR': 'Greek (Greece)',
    'en': 'English',
    'en-AU': 'English (Australia)',
    'en-BZ': 'English (Belize)',
    'en-CA': 'English (Canada)',
    'en-CB': 'English (Caribbean)',
    'en-GB': 'English (United Kingdom)',
    'en-IE': 'English (Ireland)',
    'en-JM': 'English (Jamaica)',
    'en-NZ': 'English (New Zealand)',
    'en-PH': 'English (Republic of the Philippines)',
    'en-TT': 'English (Trinidad and Tobago)',
    'en-US': 'English (United States)',
    'en-ZA': 'English (South Africa)',
    'en-ZW': 'English (Zimbabwe)',
    'eo': 'Esperanto',
    'es': 'Spanish',
    'es-AR': 'Spanish (Argentina)',
    'es-BO': 'Spanish (Bolivia)',
    'es-CL': 'Spanish (Chile)',
    'es-CO': 'Spanish (Colombia)',
    'es-CR': 'Spanish (Costa Rica)',
    'es-DO': 'Spanish (Dominican Republic)',
    'es-EC': 'Spanish (Ecuador)',
    'es-ES': 'Spanish (Spain)',
    'es-GT': 'Spanish (Guatemala)',
    'es-HN': 'Spanish (Honduras)',
    'es-MX': 'Spanish (Mexico)',
    'es-NI': 'Spanish (Nicaragua)',
    'es-PA': 'Spanish (Panama)',
    'es-PE': 'Spanish (Peru)',
    'es-PR': 'Spanish (Puerto Rico)',
    'es-PY': 'Spanish (Paraguay)',
    'es-SV': 'Spanish (El Salvador)',
    'es-UY': 'Spanish (Uruguay)',
    'es-VE': 'Spanish (Venezuela)',
    'et': 'Estonian',
    'et-EE': 'Estonian (Estonia)',
    'eu': 'Basque',
    'eu-ES': 'Basque (Spain)',
    'fa': 'Farsi',
    'fa-IR': 'Farsi (Iran)',
    'fi': 'Finnish',
    'fi-FI': 'Finnish (Finland)',
    'fo': 'Faroese',
    'fo-FO': 'Faroese (Faroe Islands)',
    'fr': 'French',
    'fr-BE': 'French (Belgium)',
    'fr-CA': 'French (Canada)',
    'fr-CH': 'French (Switzerland)',
    'fr-FR': 'French (France)',
    'fr-LU': 'French (Luxembourg)',
    'fr-MC': 'French (Principality of Monaco)',
    'gl': 'Galician',
    'gl-ES': 'Galician (Spain)',
    'gu': 'Gujarati',
    'gu-IN': 'Gujarati (India)',
    'he': 'Hebrew',
    'he-IL': 'Hebrew (Israel)',
    'hi': 'Hindi',
    'hi-IN': 'Hindi (India)',
    'hr': 'Croatian',
    'hr-BA': 'Croatian (Bosnia and Herzegovina)',
    'hr-HR': 'Croatian (Croatia)',
    'hu': 'Hungarian',
    'hu-HU': 'Hungarian (Hungary)',
    'hy': 'Armenian',
    'hy-AM': 'Armenian (Armenia)',
    'id': 'Indonesian',
    'id-ID': 'Indonesian (Indonesia)',
    'is': 'Icelandic',
    'is-IS': 'Icelandic (Iceland)',
    'it': 'Italian',
    'it-CH': 'Italian (Switzerland)',
    'it-IT': 'Italian (Italy)',
    'ja': 'Japanese',
    'ja-JP': 'Japanese (Japan)',
    'ka': 'Georgian',
    'ka-GE': 'Georgian (Georgia)',
    'kk': 'Kazakh',
    'kk-KZ': 'Kazakh (Kazakhstan)',
    'kn': 'Kannada',
    'kn-IN': 'Kannada (India)',
    'ko': 'Korean',
    'ko-KR': 'Korean (Korea)',
    'kok': 'Konkani',
    'kok-IN': 'Konkani (India)',
    'ky': 'Kyrgyz',
    'ky-KG': 'Kyrgyz (Kyrgyzstan)',
    'lt': 'Lithuanian',
    'lt-LT': 'Lithuanian (Lithuania)',
    'lv': 'Latvian',
    'lv-LV': 'Latvian (Latvia)',
    'mi': 'Maori',
    'mi-NZ': 'Maori (New Zealand)',
    'mk': 'FYRO Macedonian',
    'mk-MK': 'FYRO Macedonian (Former Yugoslav Republic of Macedonia)',
    'mn': 'Mongolian',
    'mn-MN': 'Mongolian (Mongolia)',
    'mr': 'Marathi',
    'mr-IN': 'Marathi (India)',
    'ms': 'Malay',
    'ms-BN': 'Malay (Brunei Darussalam)',
    'ms-MY': 'Malay (Malaysia)',
    'mt': 'Maltese',
    'mt-MT': 'Maltese (Malta)',
    'nb': 'Norwegian (Bokmål)',
    'nb-NO': 'Norwegian (Bokmål) (Norway)',
    'nl': 'Dutch',
    'nl-BE': 'Dutch (Belgium)',
    'nl-NL': 'Dutch (Netherlands)',
    'nn-NO': 'Norwegian (Nynorsk) (Norway)',
    'ns': 'Northern Sotho',
    'ns-ZA': 'Northern Sotho (South Africa)',
    'pa': 'Punjabi',
    'pa-IN': 'Punjabi (India)',
    'pl': 'Polish',
    'pl-PL': 'Polish (Poland)',
    'ps': 'Pashto',
    'ps-AR': 'Pashto (Afghanistan)',
    'pt': 'Portuguese',
    'pt-BR': 'Portuguese (Brazil)',
    'pt-PT': 'Portuguese (Portugal)',
    'qu': 'Quechua',
    'qu-BO': 'Quechua (Bolivia)',
    'qu-EC': 'Quechua (Ecuador)',
    'qu-PE': 'Quechua (Peru)',
    'ro': 'Romanian',
    'ro-RO': 'Romanian (Romania)',
    'ru': 'Russian',
    'ru-RU': 'Russian (Russia)',
    'sa': 'Sanskrit',
    'sa-IN': 'Sanskrit (India)',
    'se': 'Sami',
    'se-FI': 'Sami (Finland)',
    'se-NO': 'Sami (Norway)',
    'se-SE': 'Sami (Sweden)',
    'sk': 'Slovak',
    'sk-SK': 'Slovak (Slovakia)',
    'sl': 'Slovenian',
    'sl-SI': 'Slovenian (Slovenia)',
    'sq': 'Albanian',
    'sq-AL': 'Albanian (Albania)',
    'sr-BA': 'Serbian (Bosnia and Herzegovina)',
    'sr-SP': 'Serbian (Serbia and Montenegro)',
    'sv': 'Swedish',
    'sv-FI': 'Swedish (Finland)',
    'sv-SE': 'Swedish (Sweden)',
    'sw': 'Swahili',
    'sw-KE': 'Swahili (Kenya)',
    'syr': 'Syriac',
    'syr-SY': 'Syriac (Syria)',
    'ta': 'Tamil',
    'ta-IN': 'Tamil (India)',
    'te': 'Telugu',
    'te-IN': 'Telugu (India)',
    'th': 'Thai',
    'th-TH': 'Thai (Thailand)',
    'tl': 'Tagalog',
    'tl-PH': 'Tagalog (Philippines)',
    'tn': 'Tswana',
    'tn-ZA': 'Tswana (South Africa)',
    'tr': 'Turkish',
    'tr-TR': 'Turkish (Turkey)',
    'tt': 'Tatar',
    'tt-RU': 'Tatar (Russia)',
    'ts': 'Tsonga',
    'uk': 'Ukrainian',
    'uk-UA': 'Ukrainian (Ukraine)',
    'ur': 'Urdu',
    'ur-PK': 'Urdu (Islamic Republic of Pakistan)',
    'uz': 'Uzbek (Latin)',
    'uz-UZ': 'Uzbek (Uzbekistan)',
    'vi': 'Vietnamese',
    'vi-VN': 'Vietnamese (Viet Nam)',
    'xh': 'Xhosa',
    'xh-ZA': 'Xhosa (South Africa)',
    'zh': 'Chinese',
    'zh-CN': 'Chinese (China)',
    'zh-HK': 'Chinese (Hong Kong)',
    'zh-MO': 'Chinese (Macau)',
    'zh-SG': 'Chinese (Singapore)',
    'zh-TW': 'Chinese (Taiwan)',
    'zu': 'Zulu',
    'zu-ZA': 'Zulu (South Africa)'
}


def escape_markdown(text):
    """
    Escape brackets in the given text for Markdown formatting.
    """
    return text.replace("[", "\\[").replace("]", "\\]")


def get_logger(name=__name__):
    """ Gets the logger for the given name"""
    logging.basicConfig(format='%(asctime)s %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')
    logger = logging.getLogger(name)
    logger.setLevel(logging.INFO)
    return logger


def get_language_name(language_code, indexer=None):
    """Gets the language name from the language code
    :param language_code: The language code
    :return: The language name
    """
    _logger = get_logger('lang_parser')
    country = None
    if indexer is not None:
        _logger.debug("Parsing Indexer %s", indexer)
    _logger.debug("Trying to get Name of Language: %s", language_code)
    try:
        return LANG_DICT[language_code]
    except KeyError:
        None
    try:
        language = iso639.Language.match(language_code)
        _logger.debug("Found Language: %s", language)
    except iso639.LanguageNotFoundError:
        _logger.debug("Language not found in iso639: %s", language_code)
        split_lang = language_code.split("-")
        try:
            _logger.debug("Trying to get Language: %s", split_lang[0])
            language = iso639.Language.match(split_lang[0])
            language = language.name
            _logger.debug("Found Parsed Split Language Code: %s", language)
            try:
                _logger.debug("Trying to get Country: %s", split_lang[1])
                country = pycountry.countries.get(alpha_2=split_lang[1])
            except LookupError:
                None
            finally:
                if country is not None:
                    country = country.name
                    _logger.debug("Found Parsed Split Country: %s", country)
                else:
                    country = 'Unknown'
                    _logger.warning(
                        "Unknown split country code [%s]: %s for %s", language_code, split_lang[1], indexer)
        except iso639.LanguageNotFoundError:
            language = 'Unknown'
            _logger.warning(
                "Unknown split language code [%s]: %s for %s", language_code, split_lang[0], indexer)
    return f'{language}{" (" + country + ")" if country is not None else ""}'


def get_request(url, request_headers=None, request_timeout=5, max_retries=3):
    """Gets the request from the given url"""
    retries = 0
    while retries < max_retries:
        try:
            if request_headers is not None:
                response = requests.get(
                    url=url, timeout=request_timeout, headers=request_headers)
            else:
                response = requests.get(url=url, timeout=request_timeout)
            response.raise_for_status()
            return response
        except requests.exceptions.Timeout as ex:
            print("Request timed out:", ex)
            sys.exit(408)  # Request Timeout
        except requests.exceptions.ConnectionError as ex:
            print("Connection Error:", ex)
            retries += 1
        except requests.exceptions.HTTPError as ex:
            print("HTTP Error:", ex)
            sys.exit(500)  # Server Error
        except requests.exceptions.RequestException as ex:
            print("Request Exception:", ex)
            sys.exit(502)  # Bad Gateway
    print("Maximum retries exceeded.")
    sys.exit(504)  # Gateway Timeout


def get_version(api_url, headers):
    """
    Retrieves the Prowlarr application version.
    """
    version_url = f"{api_url}/system/status"
    response = get_request(version_url, headers)
    version_obj = json.loads(response.content)
    return version_obj["version"]


def get_indexers(api_url, headers):
    """
    Retrieves the list of indexers from Prowlarr.
    """
    indexer_url = f"{api_url}/indexer/schema"
    response = get_request(indexer_url, headers)
    indexer_obj = json.loads(response.content)
    return indexer_obj


def build_markdown_table(indexers, privacy, protocol):
    """
    Builds a markdown table for the given indexers, privacy, and protocol.
    """
    logger = get_logger('build_markdown_table')
    table = "|Indexer|Description|Language|"
    table += WIKI_1NEWLINE
    table += "|:--|:--|:--|"
    table += WIKI_1NEWLINE
    logger.info("Building Markdown Table for %s, %s", privacy, protocol)
    for indexer in indexers:
        if indexer["privacy"] in privacy and indexer["protocol"] == protocol:
            name = escape_markdown(
                indexer["name"]).strip().replace(".", r'\.')
            logger.debug("Name: %s", name)
            info_link = indexer["infoLink"].replace(WIKI_INFOLINK, "")
            logger.debug("Info Link: %s", info_link)
            description = escape_markdown(
                indexer["description"]).strip('.').strip().replace(".", r'\.')
            logger.debug("Description: %s", description)
            lang = get_language_name(indexer["language"], name)
            logger.debug("Language: %s", lang)
            if indexer["indexerUrls"][0] is not None and indexer["indexerUrls"][0] != "":
                url = indexer["indexerUrls"][0]
                row = f"[{name}]({url}){{#{info_link}}}"
            else:
                row = f"{name}{{#{info_link}}}"
            table += f"|{row}|{description}|{lang}|\n"
    return table


def extract_and_compare_commits_from_file(filename, app_commit, indexer_commit):
    """
    Extracts Commits from existing output file and compares them to the current commits.
    """
    _logger = get_logger('extract_commits_from_file')
    try:
        with open(filename, 'r') as content_file:
            content = content_file.read()

            # Use regex to find the commit hash pattern
            app_commit_pattern = r'\[Commit: (\w{40})\]'
            indexer_commit_pattern = r'\[Prowlarr Indexers Commit: (\w{40})\]'

            prev_app_commit_match = re.search(app_commit_pattern, content)
            prev_indexer_commit_match = re.search(
                indexer_commit_pattern, content)

            prev_app_commit = prev_app_commit_match.group(
                1) if prev_app_commit_match else None
            prev_indexer_commit = prev_indexer_commit_match.group(
                1) if prev_indexer_commit_match else None

            if prev_app_commit:
                _logger.info("Existing App Commit is {%s}", prev_app_commit)

            if prev_indexer_commit:
                _logger.info(
                    "Existing Indexer Commit is {%s}", prev_indexer_commit)
    except:
        prev_app_commit = None
        prev_indexer_commit = None
        _logger.warning(
            "Couldn't read previous commits from file. Assuming no previous data.")

    if app_commit == prev_app_commit and indexer_commit == prev_indexer_commit:
        _logger.debug("Commits are the same. TRUE")
        return True
    else:
        _logger.debug("Commits are different. FALSE")
        return False


def hash_and_compare_tables(hash_file_name, tbl_fmt_use, tbl_fmt_tor):
    """
    Gets hashed file and compares to existing tables to determine if data changed.
    """
    _logger = get_logger('compare_table_hashes')
    # Generate SHA256 hash of the concatenated string of tbl_fmt_use and tbl_fmt_tor
    hash_data = tbl_fmt_use + tbl_fmt_tor
    generated_hash = hashlib.sha256(hash_data.encode('utf-8')).hexdigest()
    _logger.info("Calculated Table Hash is {%s}", generated_hash)
    try:
        # Read the hash from the file and compare it with the newly generated hash
        with open(hash_file_name, 'r') as file:
            stored_hash = file.read().strip()
        _logger.info("Stored Table Hash is {%s}", stored_hash)
    except:
        stored_hash = None
        _logger.warning(
            "Couldn't read previous hash from file. Assuming no previous data.")
    if stored_hash == generated_hash:
        _logger.debug("Tables are the same. TRUE")
        return True
    else:
        _logger.debug("Tables are different. FALSE")
        # Write the generated hash to the file
        with open(hash_file_name, 'w') as file:
            file.write(generated_hash)
        _logger.info(
            "Wrote New Table Hash {%s} to {%s}", generated_hash, hash_file_name)
        return False


def main(app_commit, indexer_commit, build, app_apikey, output_file, hashfile, app_base_url, prev_app_commit, prev_indexer_commit):

    _logger = get_logger('main')

    # API URLs
    api_url = f"{app_base_url}/api/{API_VERSION}"

    # Headers
    headers = {"X-Api-Key": app_apikey}

    # Determine App Commit
    if not app_commit:
        response = get_request(GH_APP_URL)
        github_req = json.loads(response.content)
        app_commit = github_req[0]["sha"]
    _logger.info("App Commit is {%s}", app_commit)

    # Determine Version (Build)
    if not build:
        version_obj = get_version(api_url, headers)
        build = version_obj.replace("\n", "").replace("\r", "")

    # Determine Indexers Commit
    if not indexer_commit:
        response = get_request(GH_INDEXER_URL)
        github_req = json.loads(response.content)
        indexer_commit = github_req[0]["sha"]
    _logger.info("Indexer Commit is {%s}", indexer_commit)

    # Compare Commits to Existing
    compared = extract_and_compare_commits_from_file(
        output_file, app_commit, indexer_commit)
    if compared:
        _logger.info("No change in commits. Exiting script.")
        sys.exit()
    else:
        _logger.info("Commits have changed. Continuing script.")

    # Get Indexer Data
    indexer_obj = get_indexers(api_url, headers)

    # Build Table Fields
    _logger.info("Building Indexer Tables")
    # Public Usenet
    _logger.info("Building: Usenet - Public")
    tbl_usenet_public = build_markdown_table(indexer_obj, ["public"], "usenet")
    # Semi-Private Usenet
    _logger.info("Building: Usenet - Semi-Private")
    tbl_usenet_semiprivate = build_markdown_table(
        indexer_obj, ["semiPrivate"], "usenet")
    # Private Usenet
    _logger.info("Building: Usenet - Private")
    tbl_usenet_private = build_markdown_table(
        indexer_obj, ["private"], "usenet")
    # Public Torrents
    _logger.info("Building: Torrents - Public")
    tbl_torrent_public = build_markdown_table(
        indexer_obj, ["public"], "torrent")
    # Semi-Private Torrents
    _logger.info("Building: Torrents - Semi-Private")
    tbl_torrent_semiprivate = build_markdown_table(
        indexer_obj, ["semiPrivate"], "torrent")
    # Private Torrents
    _logger.info("Building: Torrents - Private")
    tbl_torrent_private = build_markdown_table(
        indexer_obj, ["private"], "torrent")

    # Page Header Info
    wiki_page_start = (
        WIKI_1NEWLINE
        + "- Supported Trackers and Indexers as of"
        + WIKI_1NEWLINE
        + f"  - Prowlarr Build `{build}` / [Commit: {app_commit}]({GH_APP_COMMIT_URL.rstrip('/')}/{app_commit})"
        + WIKI_1NEWLINE
        + f"  - [Prowlarr Indexers Commit: {indexer_commit}]({GH_INDEXER_COMMIT_URL.rstrip('/')}/{indexer_commit})"
        + WIKI_1NEWLINE
    )

    # Build Page Pieces
    tbl_fmt_tor = (
        WIKI_2NEWLINE +
        "## Torrents" +
        WIKI_2NEWLINE +
        "### Public Trackers" +
        WIKI_2NEWLINE +
        tbl_torrent_public +
        WIKI_1NEWLINE +
        "### Semi-Private Trackers" +
        WIKI_2NEWLINE +
        tbl_torrent_semiprivate +
        WIKI_1NEWLINE +
        "### Private Trackers" +
        WIKI_2NEWLINE +
        tbl_torrent_private
    )

    tbl_fmt_use = (
        WIKI_2NEWLINE +
        "## Usenet" +
        WIKI_2NEWLINE +
        "### Public Indexers" +
        WIKI_2NEWLINE +
        tbl_usenet_public +
        WIKI_1NEWLINE +
        "### Semi-Private Indexers" +
        WIKI_2NEWLINE +
        tbl_usenet_semiprivate +
        WIKI_1NEWLINE +
        "### Private Indexers" +
        WIKI_2NEWLINE +
        tbl_usenet_private
    )

    # Compare Tables to Existing
    compared_tables = hash_and_compare_tables(
        hashfile, tbl_fmt_use, tbl_fmt_tor)
    if compared_tables:
        _logger.info("No change in tables. Exiting script.")
        sys.exit()
    else:
        _logger.info("Tables have changed. Continuing script.")

    # Build and Output Page
    date = datetime.utcnow().isoformat()
    header_wiki = (
        f"---\n"
        f"title: Prowlarr Supported Indexers\n"
        f"description: Indexers currently named as supported in the current nightly build of Prowlarr. "
        f"Other indexers may be available via either Generic Newznab or Generic Torznab.\n"
        f"published: true\n"
        f"date: {date}\n"
        f"tags: prowlarr, indexers\n"
        f"editor: markdown\n"
        f"dateCreated: {date}\n"
        f"---"
    )
    wiki_page_version = (
        "---\n\n"
        "- Current `Master` Version | ![Current Master/Stable]"
        "(https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Master"
        "&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/master/changes)\n"
        "- Current `Develop` Version | ![Current Develop/Beta]"
        "(https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Develop"
        "&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/develop/changes)\n"
        "- Current `Nightly` Version | ![Current Nightly/Unstable]"
        "(https://img.shields.io/badge/dynamic/json?color=f5f5f5&style=flat-square&label=Nightly"
        "&query=%24%5B0%5D.version&url=https://prowlarr.servarr.com/v1/update/nightly/changes)\n"
        "---"
    )

    # Build and Output Page
    wiki_page_file = (
        f"{header_wiki}"
        f"{WIKI_1NEWLINE}"
        f"{wiki_page_start}"
        f"{WIKI_1NEWLINE}"
        f"{wiki_page_version}"
        f"{tbl_fmt_tor}"
        f"{tbl_fmt_use}"
    )
    with open(output_file, "w", encoding=WIKI_ENCODING) as file:
        file.write(wiki_page_file)
    _logger.info("Wiki Page Output")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Convert Prowlarr Supported Indexers to Markdown Table for Wiki Page if and only if commits and table contents changed"
    )
    parser.add_argument("-c", "--commit", help="App Commit hash")
    parser.add_argument("-i", "--indexercommit", help="Indexer Commit hash")
    parser.add_argument("-b", "--build", help="Build version")
    parser.add_argument("-k", "--appapikey", help="App API Key")
    parser.add_argument(
        "-o", "--outputfile", help="Output file path", default="supported-indexers.md"
    )
    parser.add_argument("-s", "--hashfile", help="Hash file of previous wiki page tables",
                        default="supported-indexers.md.hash")
    parser.add_argument(
        "-u",
        "--appbaseurl",
        help="App Base URL",
        default="http://localhost:9696",
    )
    parser.add_argument("-pc", "--prev_app_commit",
                        help="Previous App Commit hash")
    parser.add_argument("-pic", "--prev_indexer_commit",
                        help="Previous Indexer Commit hash")
    args = parser.parse_args()

    main(
        args.commit,
        args.indexercommit,
        args.build,
        args.appapikey,
        args.outputfile,
        args.hashfile,
        args.appbaseurl,
        args.prev_app_commit,
        args.prev_indexer_commit
    )
