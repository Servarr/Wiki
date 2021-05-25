## Tasks

### Scheduled

#### Radarr

<section begin=radarr_system_tasks_scheduled />

This page lists all scheduled tasks that Radarr runs

  - Application Check Update - This will run every on the displayed schedule in the UI, checking to see if Radarr is on the most current version then triggering the update script to update Radarr. [Settings-\> Update](Radarr_Settings#Updates "wikilink")
      - Note: If on Docker this will not update your container as a new image will need to be downloaded.
  - Backup - This will run a backup of your Radarr's database on a set schedule more details on this can be found [here](Radarr_Settings#Backups "wikilink"). More information about backups can be found [System -\> Backups](Radarr_System#Backup "wikilink").
  - Check Health - Check Health will run on the displayed schedule in the UI checking the overall health of your Radarr. To see a list of possible health related issues see [the Wiki Entry on Health Checks](Radarr_System#Health "wikilink").
  - Clean Up Recycle Bin - The recycling bin will be cleared out on the displayed schedule in the UI. This will only be used if the recycling bin is set in [File Management](Radarr_Settings#File_Management "wikilink")
  - Housekeeping - On the displayed schedule in the UI this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
  - Import List Sync - On the displayed schedule in the UI this will run your Lists and import any possible new movies. More info about lists can be found [Settings -\> Lists](Radarr_Settings#Lists "wikilink").
  - Messaging Cleanup - On the displayed schedule in the UI this cleans up those messages that appear in the bottom left corner of Radarr
  - Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under [Activity](Radarr_Activity#Queue "wikilink"). Essentially pinging your [download client](Radarr_Settings#Download_Client "wikilink") to check for finished downloads.
  - Refresh Movie - This goes through and refreshes all the metadata for all monitored and unmonitored movies
  - Rss Sync - This will run the RSS Sync. This can be changed in [settings -\> options](Radarr_Settings#Options "wikilink"). More information on the RSS function can be found [on our FAQ](Radarr_FAQ#How_does_Radarr_work? "wikilink")
  - **Note**: All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.

<section end=radarr_system_tasks_scheduled />

#### Sonarr

<section begin=sonarr_system_tasks_scheduled />

This page lists all scheduled tasks that Sonarr runs

  - Application Check Update - This will on the displayed schedule in the UI, checking to see if Sonarr is on the most current version then triggering the update script to update Sonarr. [More Info](Sonarr_Settings#Updates "wikilink")
      - Note: If on Docker this will not update your container as a new image will need to be downloaded.
  - Backup - This will run a backup of your Sonarr's database on a set schedule more details on this can be found [Settings -\> Backups](Sonarr_Settings#Backups "wikilink"). More information about backups can be found [System -\> Backup](Sonarr_System#Backup "wikilink").
  - Check Health - Check Health will run on the displayed schedule in the UI, checking the overall health of your Sonarr. To see a list of possible health related issues see [the Wiki Entry on Health Checks](Sonarr_System#Health "wikilink").
  - Clean Up Recycle Bin - The recycling bin will run on on the displayed schedule in the UI. This will only be used if the recycling bin is set in [File Management](Sonarr_Settings#File_Management "wikilink")
  - Housekeeping - On the displayed schedule in the UI, this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
  - Import List Sync - On the displayed schedule in the UI, this will run your Lists and import any possible new shows. More info about lists can be found [here](Sonarr_Settings#Lists "wikilink").
  - Messaging Cleanup -On the displayed schedule in the UI, this cleans up those messages that appear in the bottom left corner of Sonarr
  - Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under [Activity](Sonarr_Activity#Queue "wikilink"). Essentially pinging your [download client](Sonarr_Settings#Download_Client "wikilink") to check for finished downloads.
  - Refresh Series- This goes through and refreshes all the metadata for all monitored and unmonitored series
  - Rss Sync - This will run the RSS Sync. This can be changed [here](Sonarr_Settings#Options "wikilink"). More information on the RSS function can be found [here](Sonarr_FAQ#How_does_Sonarr_work? "wikilink")
  - **Note**: All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.

<section end=sonarr_system_tasks_scheduled />

#### Lidarr

<section begin=lidarr_system_tasks_scheduled />

This page lists all scheduled tasks that Lidarr runs

  - Application Check Update - On the displayed schedule in the UI, this will run checking to see if Lidarr is on the most current version then triggering the update script to update Lidarr. [More Info](Lidarr_Settings#Updates "wikilink")
      - Note: If on Docker this will not update your container as a new image will need to be downloaded.
  - Backup - This will run a backup of your Lidarr's database on a set schedule more details on this can be found [here](Lidarr_Settings#Backups "wikilink"). More information about backups can be found [here](Lidarr_System#Backup "wikilink").
  - Check Health - Check Health will run on the displayed schedule in the UI, checking the overall health of your Lidarr. To see a list of possible health related issues click [here](Lidarr_System#Health "wikilink").
  - Clean Up Recycle Bin - The recycling bin will be cleared out on the displayed schedule in the UI. This will only be used if the recycling bin is set in [File Management](Lidarr_Settings#File_Management "wikilink")
  - Housekeeping - On the displayed schedule in the UI, this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
  - Import List Sync - On the displayed schedule in the UI, this will run your Lists and import any possible new artists. More info about lists can be found [here](Lidarr_Settings#Lists "wikilink").
  - Messaging Cleanup - On the displayed schedule in the UI, this cleans up those messages that appear in the bottom left corner of Lidarr
  - Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under [Activity](Lidarr_Activity#Queue "wikilink"). Essentially pinging your [download client](Lidarr_Settings#Download_Client "wikilink") to check for finished downloads.
  - Refresh Artists- This goes through and refreshes all the metadata for all monitored and unmonitored artists
  - Rss Sync - This will run the RSS Sync. This can be changed [here](Lidarr_Settings#Options "wikilink"). More information on the RSS function can be found [here](Lidarr_FAQ#How_does_Lidarr_work? "wikilink")
  - **Note**: All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.

<section end=lidarr_system_tasks_scheduled />

#### Readarr

<section begin=readarr_system_tasks_scheduled />

This page lists all scheduled tasks that Readarr runs

  - Application Check Update - This will run on the displayed schedule in the UI, checking to see if Readarr is on the most current version then triggering the update script to update Readarr. [More Info](Readarr_Settings#Updates "wikilink")
      - Note: If on Docker this will not update your container as a new image will need to be downloaded.
  - Backup - This will run a backup of your Readarr's database on a set schedule more details on this can be found [here](Readarr_Settings#Backups "wikilink"). More information about backups can be found [here](Readarr_System#Backup "wikilink").
  - Check Health - Check Health will run on the displayed schedule in the UI, checking the overall health of your Readarr. To see a list of possible health related issues click [here](Readarr_System#Health "wikilink").
  - Clean Up Recycle Bin - The recycling bin will be cleared out every day. This will only be used if the recycling bin is set in [File Management](Readarr_Settings#File_Management "wikilink")
  - Housekeeping - On the displayed schedule in the UI, this will dust out all the cobwebs, sweeps and vacuums the floors, mops, shines, and even makes nice neat little folded notes just for you. But does not take out the trash. That it just was not paid enough for.
  - Import List Sync - On the displayed schedule in the UI, this will run your Lists and import any possible new authors. More info about lists can be found [here](Readarr_Settings#Lists "wikilink").
  - Messaging Cleanup - On the displayed schedule in the UI, this cleans up those messages that appear in the bottom left corner of Readarr
  - Refresh Monitored Downloads - This goes through and refreshes the downloads queue located under [Activity](Readarr_Activity#Queue "wikilink"). Essentially pinging your [download client](Readarr_Settings#Download_Client "wikilink") to check for finished downloads.
  - Refresh Author- This goes through and refreshes all the metadata for all monitored and unmonitored authors
  - Rss Sync - This will run the RSS Sync. This can be changed [here](Readarr_Settings#Options "wikilink"). More information on the RSS function can be found [here](Readarr_FAQ#How_does_Readarr_work? "wikilink")
  - **Note**: All these tasks can be ran manually outside their scheduled times by hitting the icon to the far right of each of the tasks.

<section end=readarr_system_tasks_scheduled />

### Queue

#### Radarr

<section begin=radarr_system_tasks_queue />

The queue will show you upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

<section end=radarr_system_tasks_queue />

#### Sonarr

<section begin=sonarr_system_tasks_queue />

The queue will show you upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

<section end=sonarr_system_tasks_queue />

#### Lidarr

<section begin=lidarr_system_tasks_queue />

The queue will show you upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

<section end=lidarr_system_tasks_queue />

#### Readarr

<section begin=readarr_system_tasks_queue />

The queue will show you upcoming tasks as well as a history of recently ran tasks as well as how long those tasks took.

<section end=readarr_system_tasks_queue />

### Templates
