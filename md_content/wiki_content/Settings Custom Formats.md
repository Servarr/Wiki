**<sub>Yes, I'm aware Sonarr does not have CFs but a man can dream can't he?</sub>**

### Custom Formats

#### Radarr

<section begin=radarr_settings_custom_formats />

Ensure you get the right release every time\! Custom formats allows fine control over release prioritization and selection. As simple as a single preferred word or as complex as you want with multiple criteria and regex.

Custom formats have been reworked significantly in Radarr V3. They are now calculated on-the-fly instead of being stored in the database, so they update as soon as you change the definitions.

Custom formats are used within your Quality Profiles to determine the scoring of each custom format. Within each quality profile, you can set a minimum custom format score for a release to be grabbed and an upgrade until score as well.

  - `Name` - The Name of the Custom Format
  - `Include Custom Format when Renaming` - Include the Name of the Custom Format in Renaming; [See also the naming schema.](Radarr_Settings#Custom_Formats "wikilink")

<section end=radarr_settings_custom_formats />

#### Sonarr

<section begin=sonarr_settings_custom_formats />

Custom format text

<section end=sonarr_settings_custom_formats />

#### Lidarr

<section begin=lidarr_settings_custom_formats />

Custom format text

<section end=lidarr_settings_custom_formats />

#### Readarr

<section begin=readarr_settings_custom_formats />

Custom format text

<section end=readarr_settings_custom_formats />

### Conditions

#### Radarr

<section begin=radarr_settings_custom_formats_conditions />

All conditions have two possible modifiers:

  - `Negate` - the match is inverted, so the condition is satisfied if and only if the non-negated condition is not satisfied
  - `Required` - only applies to formats with more than one condition of the same type and changes the matching rules for type groups. Enabling this option means that this specific condition must be satisfied for the whole custom format to apply regardless of if another condition of the same type would otherwise satisfy the type group. *Note: You only use this if you use a condition more than once.*

The conditions are:

  - `Release Title` - This is a regular expression matched against the release title and, after download, the filename on disk. *(Note: Radarr only considers text after the movie title and year which means anything preceding the title is ignored.)*
  - `Edition` - This tag is matched against any Editions Radarr may parse. You can put any value Radarr will try to match that against what it parsed (case-insensitive).
  - `Language` - This language is matched against any language(s) Radarr parses. All languages previously selectable in profiles work here.
  - `Indexer Flag` - This tag is matched against any Indexer Flags that Radarr may parse.
  - `Source` - The source where a release was ripped from (e.g. BLURAY).
  - `Resolution` - The resolution parsed from either the release name or mediainfo (if available).
  - `Quality Modifier` - Quality Modifier sets things like Telescene, Telesync, Remux, Regional. It disambiguates a given source and resolution pair when there are multiple quality (source) types that can apply.
  - `Size` - This is matched against the release size. The release size is converted to gigabytes and compared against the min and max values.

<section end=radarr_settings_custom_formats_conditions />

#### Sonarr

We know... they don't exist. Use preferred words.

#### Lidarr

#### Readarr

### Profiling Settings and Ranking

#### Radarr

<section begin=radarr_settings_custom_formats_profiling_settings_and_ranking />

Custom formats are implemented within and have their impact controlled by Quality Profiles. The Upgrade Until score prevents upgrading once a release with this desired score has been downloaded. A score of 0 results in the custom format being informational only. The Minimum score requires releases to reach this threshold otherwise they will be rejected. Custom formats that match with undesirable attributes should be given a negative score to lower their appeal. Outright rejections should be given a negative score low enough that even if all of the other formats with positive scores were added, the score would still fall below the minimum.

<section end=radarr_settings_custom_formats_profiling_settings_and_ranking />

#### Sonarr

We know... they don't exist. Use preferred words.

#### Lidarr

#### Readarr

### Import/Export

<section begin=radarr_settings_custom_formats_import_export />

Please see [TRaSH's Guides](https://trash-guides.info/Radarr/V3/How-to-importexport-Custom-Formats-and-truly-make-use-of-it/) for a guide. However, one is able to import and export custom formats.

<section end=radarr_settings_custom_formats_import_export />

### Community Custom Formats

#### Radarr

<section begin=radarr_community_custom_formats />

  - Please see our [Radarr Tips and Tricks](Radarr_Tips_and_Tricks "wikilink") section

<section end=radarr_community_custom_formats />

#### Sonarr

Nope still don't exist.

#### Lidarr

#### Readarr
