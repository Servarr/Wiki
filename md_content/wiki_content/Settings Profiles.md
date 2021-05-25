## Profiles

### Quality Profiles

#### Radarr

<section begin=radarr_quality_profiles />

  - Here you'll be allowed to set profiles for which you can have for the quality of movie you're looking to download
  - When selecting an existing profile or adding an additional profile a new window will appear  
    Note: The quality with the blue box will be the quality that is set for Upgrade Until (basically the cutoff)
      - Name - Here you'll select a *UNIQUE* name for the profile to which you are creating
      - Upgrades allowed - If you tell Radarr to download a Web 1080p as it is the first release of a specific movie then later somebody is able to upload a Bluray-1080p then with this selected Radarr will automatically upgrade to the better quality  
        Note: This is only if you have Bluray-1080p higher than Web 1080p within the Qualities section and both are selected
      - Upgrade until Quality - Here you'll set the cut-off to which Radarr says to its self, "This is as high of quality that you want. I won't be looking anymore for better quality releases."
      - Minimum Custom Format Score - The minimum sum of custom format(s) for a release to be downloaded. Note this does not outrank qualities, but is ranked after qualities.
      - Upgrade Until Custom Format Score - Similar to *Upgrade until Quality*; the minimum score to be reached within a quality to upgrade to. Once this is reached, there will be no upgrades within that quality due to custom formats.
      - Language - Select your preferred language
      - Custom Format - Radarr scores each release using the sum of scores for matching custom formats. If a new release would improve the score, at the same or better quality, then Radarr will grab it.
          - For more details on Custom Formats click [HERE](#Custom_Formats_2 "wikilink")
      - Qualities - For definitions for qualities please click [HERE](Definitions "wikilink")
      - Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases, Prime example of this is WebDL and WebRip as these are very similar and typically have similar [bitrates](Definitions "wikilink"). When editing the groups you can change the preference within each of the groups.
          - Qualities higher in the list are more preferred. Qualities within the same group are equal. Only checked qualities are wanted  
            Note: By default the qualities are set from lowest (bottom) to highest (top)

<section end=radarr_quality_profiles />

#### Sonarr

<section begin=sonarr_quality_profiles />

  - Here you'll be allowed to set profiles for which you can have for the quality of series you're looking to download.
  - When selecting an existing profile or adding an additional profile a new window will appear  
    Note: The quality with the blue box will be the quality that is set for Upgrade Until (basically the cutoff)
      - Name - Here you'll select a *UNIQUE* name for the profile to which you are creating
      - Upgrades allowed - If you tell Sonarr to download a Web 1080p as it is the first release of a specific episode then later somebody is able to upload a Bluray-1080p then with this selected Sonarr will automatically upgrade to the better quality  
        Note: This is only if you have Bluray-1080p higher than Web 1080p within the Qualities section
      - Qualities - For definitions for qualities please [click here](#Qualities_Defined "wikilink")
      - Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases, Prime example of this is WebDL and WebRip as these are very similar and typically have similar [bitrates](Definitions#bitrates "wikilink"). When editing the groups you can change the preference within each of the groups.
          - Qualities higher in the list are more preferred. Qualities within the same group are equal. Only checked qualities are wanted  
            Note: By default the qualities are set from lowest (bottom) to highest (top)

<section end=sonarr_quality_profiles />

#### Lidarr

<section begin=lidarr_quality_profiles />

  - Here you'll be allowed to set profiles for which you can have for the quality of series you're looking to download.
  - When selecting an existing profile or adding an additional profile a new window will appear  
    Note: The quality with the green box will be the quality that is set for Upgrade Until (basically the cutoff)
      - Name - Here you'll select a *UNIQUE* name for the profile to which you are creating
      - Upgrades allowed - If you tell Lidarr to download a MP3-160 (Poor Quality Lossy) file as it is the first release of a specific episode then later somebody is able to upload a FLAC (Lossless) then with this selected Lidarr will automatically upgrade to the better quality  
        Note: This is only if you have FLAC (Lossless) higher than MP3-160 (Poor Quality Lossy) within the Qualities section
      - Qualities - For definitions for qualities please click [HERE](Definitions "wikilink")
      - Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases, Prime example of this is MP3-160 and MP-96 as these are very similar and typically have similar [bitrates](Definitions "wikilink"). When editing the groups you can change the preference within each of the groups.
          - Qualities higher in the list are more preferred. Qualities within the same group are equal. Only checked qualities are wanted  
            Note: By default the qualities are set from lowest (bottom) to highest (top)

<section end=lidarr_quality_profiles />

#### Readarr

<section begin=readarr_quality_profiles />

  - Here you'll be allowed to set profiles for which you can have for the quality of series you're looking to download.
  - When selecting an existing profile or adding an additional profile a new window will appear
      - Name - Here you'll select a *UNIQUE* name for the profile to which you are creating
      - Upgrades allowed -
          - Audio Books - If you tell Readarr to download a MP3-320 file as it is the first release of a specific episode then later somebody is able to upload a FLAC then with this selected Readarr will automatically upgrade to the better quality  
            Note: This is only if you have FLAC higher than MP3-320 within the Qualities section
          - E-Books - Quality settings are based upon preferences, if you want an ePub over Mobi file format
      - Qualities - For definitions for qualities please click [HERE](Definitions "wikilink")
      - Edit Groups - Some qualities are grouped together to reduce the size of the list as well grouping like releases.
          - Qualities higher in the list are more preferred. Qualities within the same group are equal. Only checked qualities are wanted
          - Audio Book Qualities are set higher than ebook qualities however this does not mean an audio book will be downloaded before an ebook

<section end=readarr_quality_profiles />

### Delay Profiles

#### Radarr

**TEMPLATE**

#### Sonarr

**TEMPLATE**

#### Lidarr

**TEMPLATE**

#### Readarr

**TEMPLATE**

### Language Profiles

#### Radarr

#### Sonarr

<section begin=sonarr_language_profiles />

  - Here you'll be allowed to set profiles for which you can have for the language of series you're looking to download.
  - Please note that the priority / order does matter even if the language is not wanted (selected).

<!-- end list -->

  -   - Name - Select a unique name for this given profile
      - Upgrades allowed - If you tell Sonarr download a Chinese version as it is the first release of a specific series then later somebody is able to upload an English version then with this selected Sonarr will automatically upgrade to the better quality  
        Note: This is only valid if English is higher in the language list than Chinese and both are selected
      - Languages - Languages higher in the list are more preferred. Only checked languages are wanted

<section end=sonarr_language_profiles />

#### Lidarr

#### Readarr

### Release Profiles

#### Radarr

#### Sonarr

<section begin=sonarr_release_profiles />

  - Not all releases are created equal, each release group has their own way of packaging and encoding their material. Here you'll be able to select the preferred releases you're looking for
  - Enable Profile - Toggling this given profile on or off
  - Must Contain - The release must contain at least one of these terms (case insensitive)
  - Must Not Contain - The release will be rejected if it contains one or more of terms (case insensitive)
  - Preferred:
      - Here you can select a given term and give it a score.
      - Example: Let's say you're looking for releases with a specific grouping of words. Let's say you want to tell Sonarr that you want [Repacks or Propers](Definitions "wikilink") over regular releases. Here you'll put the word Repack in one of the fields and give it a value (say 100) but, you're also looking for DTS-HD audio so you'll put that in there and also give it a score (say 100 again). When Sonarr goes through and looks at all the releases from the RSS feed and it comes across a release that has both Repack and DTS-HD that will give it a score of 200. Which is much higher than all the others that don't have either of those words. This tells Sonarr that this has a higher score and it will be the first file picked for download.
  - Include Preferred when Renaming - When utilizing the [{Preferred Words}](#Other "wikilink") tag in the naming scheme
  - Indexer - Specify what indexer the profile applies to.  
    This is useful if you only want specific releases from a given indexer/tracker
  - Tags - With giving this release profile a tag you'll be able to tag a given series to have it play by the rules set here. If you leave this field blank these rules will apply to all series

<section end=sonarr_release_profiles />

#### Lidarr

<section begin=lidarr_release_profiles />

  - Not all releases are created equal, each release group has their own way of packaging and encoding their material. Here you'll be able to select the preferred releases you're looking for
  - Enable Profile - Toggling this given profile on or off
  - Must Contain - The release must contain at least one of these terms (case insensitive)
  - Must Not Contain - The release will be rejected if it contains one or more of terms (case insensitive)
  - Preferred - Here you can select a given term and give it a score.
  - Include Preferred when Renaming - When utilizing the [{Preferred Words}](#Other "wikilink") tag in the naming scheme
  - Tags - With giving this release profile a tag you'll be able to tag a given series to have it play by the rules set here. If you leave this field blank these rules will apply to all series

<section end=lidarr_release_profiles />

#### Readarr

<section being=readarr_release_profiles />

  - Not all releases are created equal, each release group has their own way of packaging and encoding their material. Here you'll be able to select the preferred releases you're looking for
  - Enable Profile - Toggling this given profile on or off
  - Must Contain - The release must contain at least one of these terms (case insensitive)
  - Must Not Contain - The release will be rejected if it contains one or more of terms (case insensitive)
  - Preferred - Here you can select a given term and give it a score.
  - Include Preferred when Renaming - When utilizing the [{Preferred Words}](#Other "wikilink") tag in the naming scheme
  - Tags - With giving this release profile a tag you'll be able to tag a given series to have it play by the rules set here. If you leave this field blank these rules will apply to all series

<section end=readarr_release_profiles />

### Metadata Profiles

#### Radarr

#### Sonarr

#### Lidarr

<section begin=lidarr_metadata_profiles />

  - Here you'll be allowed to set profiles for which you can have for the releases of a given artist
  - When selecting an existing profile or adding an additional profile a new window will appear
      - Name - Here you'll select a *UNIQUE* name for the profile to which you are creating
      - Primary Types - These are typically the most common types of releases from an artist
      - Secondary Types - Less common types of releases however some artists will have them
      - Release Statuses - How did the artist release their material?

Note: If you're not seeing a release from a given artist then you might then you might want to create more profiles. A prime example of this is [Metallica](https://en.wikipedia.org/wiki/Metallica). They have 10 primary Album releases that show up under the "Standard" profile, however, if you're looking for [S\&M](https://en.wikipedia.org/wiki/S%26M_\(album\)). Then you'll need to ensure that EP is selected in order to see it. Note: Be careful with with selecting everything long running artists or artists with a lot of different types of releases can make loading up a specific artist for the first time quite slow as Lidarr is pulling all the information down an example of this is if you select everything for Metallica over 600 album releases are pulled as possible downloads

<section end=lidarr_metadata_profiles />

#### Readarr

<section begin=readarr_metadata_profiles />

  - Here you'll be allowed to set profiles for which you can have for the releases of a given author
  - When selecting an existing profile or adding an additional profile a new window will appear
      - Name - Here you'll select a *UNIQUE* name for the profile to which you are creating
      - Minimum Popularity - Popularity is average rating \* number of votes
      - Skip books with missing release date - Readarr will skip any books that do not have a release date to them
      - Skip books with no [ISBN](https://en.wikipedia.org/wiki/International_Standard_Book_Number) or [ASIN](https://en.wikipedia.org/wiki/Amazon_Standard_Identification_Number)
      - Skip part books and sets - Readarr will skip books that are broken into parts or sets
      - Skip secondary series books - ???
      - Allowed Languages - Set which languages Readarr will look for

<section end=readarr_metadata_profiles />

## Templates

[Template:Settings Profiles Delay Profiles](Template:Settings_Profiles_Delay_Profiles "wikilink")
