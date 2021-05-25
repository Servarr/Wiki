## Download Clients

### Overview

<section begin=settings_download_client_overview />

Downloading and importing is where most people experience issues. From a high level perspective, the software needs to be able to communicate with your download client and have access to the files it downloads. There is a large variety of supported download clients and an even bigger variety of setups. This means that while there are some common setups there isn't one right setup and everyone's setup can be a little different. But there are many wrong setups.

<section end=settings_download_client_overview />

### Download Clients

**TEMPLATE**

### Complete Download Handling

#### Radarr

<section begin=radarr_settings_download_clients_complete_download_handling />

Completed Download Handling is how Radarr imports media from your download client to your series folders. **Many common issues are related to [bad Docker paths and/or other Docker permissions issues](Docker_Guide "wikilink").**

  - Enable - Automatically import completed downloads from the download client
  - Remove - Remove completed downloads when finished (usenet) or stopped/complete (torrents)
  - Check For Finished Downloads Interval - How often to query the download client

Remove Completed Downloads

1.  Radarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
2.  Radarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
3.  When the download is completed, Radarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
4.  Radarr will scan that completed file location for video files. It will parse the video file name to match it to a movie. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
5.  Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

  - Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Radarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
  - If the "Completed Download Handling - Remove" option is enabled in settings, Radarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

<section end=radarr_settings_download_clients_complete_download_handling />

#### Sonarr

<section begin=sonarr_settings_download_clients_complete_download_handling />

Completed Download Handling is how Sonarr imports media from your download client to your series folders. **Many common issues are related to [bad Docker paths and/or other Docker permissions issues](Docker_Guide "wikilink").**

  - Enable - Automatically import completed downloads from the download client
  - Remove - Remove completed downloads when finished (usenet) or stopped/complete (torrents)

Remove Completed Downloads

1.  Sonarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
2.  Sonarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
3.  When the download is completed, Sonarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
4.  Sonarr will scan that completed file location for video files. It will parse the video file name to match it to an episode. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
5.  Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

  - Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Sonarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
  - If the "Completed Download Handling - Remove" option is enabled in settings, Sonarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

<section end=sonarr_settings_download_clients_complete_download_handling />

#### Lidarr

<section begin=lidarr_settings_download_clients_complete_download_handling />

Completed Download Handling is how Lidarr imports media from your download client to your series folders. **Many common issues are related to [bad Docker paths and/or other Docker permissions issues](Docker_Guide "wikilink").**

  - Enable - Automatically import completed downloads from the download client
  - Remove - Remove completed downloads when finished (usenet) or stopped/complete (torrents)

Remove Completed Downloads

1.  Lidarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
2.  Lidarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
3.  When the download is completed, Lidarr will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
4.  Lidarr will scan that completed file location for audio files. It will parse the file name to match it to a track. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
5.  Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

  - Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Lidarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
  - If the "Completed Download Handling - Remove" option is enabled in settings, Lidarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

<section end=lidarr_settings_download_clients_complete_download_handling />

#### Readarr

<section begin=readarr_settings_download_clients_complete_download_handling />

Completed Download Handling is how Readarr imports media from your download client to your series folders. **Many common issues are related to [bad Docker paths and/or other Docker permissions issues](Docker_Guide "wikilink").**

  - Enable - Automatically import completed downloads from the download client
  - Remove - Remove completed downloads when finished (usenet) or stopped/complete (torrents)

Remove Completed Downloads

1.  Readarr will send a download request to your client, and associate it with a label or category name that you have configured in the download client settings.
2.  Readarr will monitor your download clients active downloads that use that category name. It monitors this via your download client's API.
3.  When the download is completed, Readar will know the final file location as reported by your download client. This file location can be almost anywhere, as long as it is somewhere separate from your media folder.
4.  Readarr will scan that completed file location for book files. It will parse the file name to match it to a book. If it can do that, it will rename the file according to your specifications, and move it to the assigned library folder.
5.  Leftover files from the download will be sent to your trash or recycling.

If you download using a BitTorrent client, the process is slightly different:

  - Completed files are left in their original location to allow you to seed. When files are imported to your assigned library folder Readarr will attempt to hardlink the file or fall back to copy (use double space) if hard links are not supported.
  - If the "Completed Download Handling - Remove" option is enabled in settings, Readarr will delete the original file and torrent from your client, but only if the client reports that seeding is complete and torrent is stopped.

<section end=readarr_settings_download_clients_complete_download_handling />

### Failed Download Handling

#### Radarr

**"Redownload"** - Radarr will handle failed downloads if **Redownload** is enabled. Automatically search for and attempt to download a different release within your **Quality Profiles** if the download fails for any reason.

"**Remove**" - Radarr will send a request to your Download Client to remove the download history of your failed download if **Remove** is enabled.

(**Note**: "**Remove**" is only presented if you have toggled "**Show Advanced**" settings).

#### Sonarr

**"Redownload"** - Sonarr will handle failed downloads if **Redownload** is enabled. Automatically search for and attempt to download a different release within your **Quality Profiles** if the download fails for any reason.

"**Remove**" - Sonarr will send a request to your Download Client to remove the download history of your failed download if **Remove** is enabled.

(**Note**: "**Remove**" is only presented if you have toggled "**Show Advanced**" settings).

#### Lidarr

**"Redownload"** - Lidarr will handle failed downloads if **Redownload** is enabled. Automatically search for and attempt to download a different release within your **Quality Profiles** if the download fails for any reason.

"**Remove**" - Lidarr will send a request to your Download Client to remove the download history of your failed download if **Remove** is enabled.

(**Note**: "**Remove**" is only presented if you have toggled "**Show Advanced**" settings).

#### Readarr

**"Redownload"** - Readarr will handle failed downloads if **Redownload** is enabled. Automatically search for and attempt to download a different release within your **Quality Profiles** if the download fails for any reason.

"**Remove**" - Readarr will send a request to your Download Client to remove the download history of your failed download if **Remove** is enabled.

(**Note**: "**Remove**" is only presented if you have toggled "**Show Advanced**" settings).

### Remote Path Mapping

#### Radarr

<section begin=radarr_settings_download_clients_remote_path_mapping />

Remote Path Mapping acts as a dumb find `Remote Path` and replace with `Local Path` This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

One of our amazing community members have created an excellent guide to help you out if you think remotte path mapping is what will work for you [here](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/)

<section end=radarr_settings_download_clients_remote_path_mapping />

#### Sonarr

<section begin=sonarr_settings_download_clients_remote_path_mapping />

Remote Path Mapping acts as a dumb find `Remote Path` and replace with `Local Path` This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

One of our amazing community members have created an excellent guide to help you out if you think remotte path mapping is what will work for you [here](https://trash-guides.info/Sonarr/V3/Sonarr-remote-path-mapping/)

<section end=sonarr_settings_download_clients_remote_path_mapping />

#### Lidarr

<section begin=lidarr_settings_download_clients_remote_path_mapping />

Remote Path Mapping acts as a dumb find `Remote Path` and replace with `Local Path` This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

One of our amazing community members have created an excellent guide to help you out if you think remotte path mapping is what will work for you [here](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/) The guide is for Radarr but all concepts are exactly the same for Lidarr

<section end=lidarr_settings_download_clients_remote_path_mapping />

#### Readarr

<section begin=readarr_settings_download_clients_remote_path_mapping />

Remote Path Mapping acts as a dumb find `Remote Path` and replace with `Local Path` This is primarily used for either merged local/remote setups using mergerfs or similar or is used for when the application and download client are not on the same server.

One of our amazing community members have created an excellent guide to help you out if you think remotte path mapping is what will work for you [here](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/) The guide is for Radarr but all concepts are exactly the same for Readarr

<section end=readarr_settings_download_clients_remote_path_mapping />

### Templates

  - [Template:settings\_download\_clients\_download\_clients](Template:settings_download_clients_download_clients "wikilink")
  - [Template:settings\_download\_clients\_failed\_download\_handling](Template:settings_download_clients_failed_download_handling "wikilink")
