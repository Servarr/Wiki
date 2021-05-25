## Log Files

### Log Files

#### Radarr

<section begin=radarr_system_log_files />

This page will allow you to download and see what current log files are available for Radarr

  - On the top row there are several options to allow you to control your log files.
      - The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
          - Log Files - The bread and butter of any support issue more on log files can be found [here](Radarr_Settings#Logging "wikilink").
          - Updater Log Files - This will show the log files associated with Radarr's updater script
              - Note: If you're on docker this will be empty as you should be updating by downloading a new docker image
      - Refresh - This will refresh the current page and display any newly created logs
      - Delete - This will clear all logs allowing you to start from fresh
      - File Name - This will display the file name associated with the log
      - Last Written - This is the local time that this particular log file was written to.
          - Radarr uses rolling log files limited to 1MB each. The current log file is always radarr.txt, for the the other files radarr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains fatal, error, warn, and info entries.
          - When Debug log level is enabled, additional radarr.debug.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, and debug entries. It usually covers a \~40h period.
          - When Trace log level is enabled, additional radarr.trace.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, debug, and trace entries. Due to trace verbosity it only covers a couple of hours at most.

<section end=radarr_system_log_files />

#### Sonarr

<section begin=sonarr_system_log_files />

This page will allow you to download and see what current log files are available for Sonarr

  - On the top row there are several options to allow you to control your log files.
      - The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
          - Log Files - The bread and butter of any support issue more on log files can be found [here](Sonarr_Settings#Logging "wikilink").
          - Updater Log Files - This will show the log files associated with Sonarr's updater script
              - Note: If you're on docker this will be empty as you should be updating by downloading a new docker image
      - Refresh - This will refresh the current page and display any newly created logs
      - Delete - This will clear all logs allowing you to start from fresh
      - File Name - This will display the file name associated with the log
      - Last Written - This is the local time that this particular log file was written to.
          - Sonarr uses rolling log files limited to 1MB each. The current log file is always sonarr.txt, for the the other files sonarr.0.txt is the next newest (the higher the number the older it is) up to 6 log files total. This log file contains fatal, error, warn, and info entries.
          - When Debug log level is enabled, additional sonarr.debug.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, and debug entries. It usually covers a \~40h period.
          - When Trace log level is enabled, additional sonarr.trace.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, debug, and trace entries. Due to trace verbosity it only covers a couple of hours at most.

<section end=sonarr_system_log_files />

#### Lidarr

<section begin=lidarr_system_log_files />

This page will allow you to download and see what current log files are available for Lidarr

  - On the top row there are several options to allow you to control your log files.
      - The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
          - Log Files - The bread and butter of any support issue more on log files can be found [here](Lidarr_Settings#Logging "wikilink").
          - Updater Log Files - This will show the log files associated with Lidarr's updater script
              - Note: If you're on docker this will be empty as you should be updating by downloading a new docker image
      - Refresh - This will refresh the current page and display any newly created logs
      - Delete - This will clear all logs allowing you to start from fresh
      - File Name - This will display the file name associated with the log
      - Last Written - This is the local time that this particular log file was written to.
          - Lidarr uses rolling log files limited to 1MB each. The current log file is always lidarr.txt, for the the other files lidarr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains fatal, error, warn, and info entries.
          - When Debug log level is enabled, additional lidarr.debug.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, and debug entries. It usually covers a \~40h period.
          - When Trace log level is enabled, additional lidarr.trace.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, debug, and trace entries. Due to trace verbosity it only covers a couple of hours at most.

<section end=lidarr_system_log_files />

#### Readarr

<section begin=readarr_system_log_files />

This page will allow you to download and see what current log files are available for Readarr

  - On the top row there are several options to allow you to control your log files.
      - The top row on the far left there is a dropdown that will allow you to switch from Log files and Updater Log Files
          - Log Files - The bread and butter of any support issue more on log files can be found [here](Readarr_Settings#Logging "wikilink").
          - Updater Log Files - This will show the log files associated with Readarr's updater script
              - Note: If you're on docker this will be empty as you should be updating by downloading a new docker image
      - Refresh - This will refresh the current page and display any newly created logs
      - Delete - This will clear all logs allowing you to start from fresh
      - File Name - This will display the file name associated with the log
      - Last Written - This is the local time that this particular log file was written to.
          - Readarr uses rolling log files limited to 1MB each. The current log file is always readarr.txt, for the the other files readarr.0.txt is the next newest (the higher the number the older it is) up to 51 log files total. This log file contains fatal, error, warn, and info entries.
          - When Debug log level is enabled, additional readarr.debug.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, and debug entries. It usually covers a 40h period.
          - When Trace log level is enabled, additional readarr.trace.txt rolling log files will be present, up to 51 files. This log files contains fatal, error, warn, info, debug, and trace entries. Due to trace verbosity it only covers a couple of hours at most.

<section end=readarr_system_log_files />

### Templates
