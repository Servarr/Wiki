General
-------

Host
----

### Radarr

<section begin=radarr_settings_general_host />

-   Binding Address - Valid IP4 address or \'\*\' for all interfaces
    -   0.0.0.0 or \* - any address can connect
    -   127.0.0.1 or localhost - only localhost applications can connect
    -   Any other IP (e.g. 1.2.3.4) - only that IP (1.2.3.4) can connect
-   Port Number - The port number that you are wanting to use to access
    the webUI for Radarr
    -   Note: If using Docker do not touch
-   URL Base - For reverse proxy support, default is empty
    -   Note: If using a reverse proxy (example: mydomain.com/radarr)
        you would enter \'/radarr\' for URL Base.
-   Enable SSL - If you have SSL credentials and would like to secure
    communication to and from your Radarr enable this option.
    -   Note: do not mess with unless you know what you\'re doing

<section end=radarr_settings_general_host />

### Sonarr

<section begin=sonarr_settings_general_host />

-   Binding Address - Valid IP4 address or \'\*\' for all interfaces
    -   0.0.0.0 or \* - any address can connect
    -   127.0.0.1 or localhost - only localhost applications can connect
    -   Any other IP (e.g. 1.2.3.4) - only that IP (1.2.3.4) can connect
-   Port Number - The port number that you are wanting to use to access
    the webUI for Sonarr
    -   Note: If using Docker do not touch
-   URL Base - For reverse proxy support, default is empty
    -   Note: If using a reverse proxy (example: mydomain.com/sonarr)
        you would enter \'/sonarr\' for URL Base.
-   Enable SSL - If you have SSL credentials and would like to secure
    communication to and from your Sonarr enable this option.
    -   Note: do not mess with unless you know what you\'re doing

<section end=sonarr_settings_general_host />

### Lidarr

<section begin=lidarr_settings_general_host />

-   Binding Address - Valid IP4 address or \'\*\' for all interfaces
    -   0.0.0.0 or \* - any address can connect
    -   127.0.0.1 or localhost - only localhost applications can connect
    -   Any other IP (e.g. 1.2.3.4) - only that IP (1.2.3.4) can connect
-   Port Number - The port number that you are wanting to use to access
    the webUI for Lidarr
    -   Note: If using Docker do not touch
-   URL Base - For reverse proxy support, default is empty
    -   Note: If using a reverse proxy (example: mydomain.com/lidarr)
        you would enter \'/lidarr\' for URL Base.
-   Enable SSL - If you have SSL credentials and would like to secure
    communication to and from your Lidarr enable this option.
    -   Note: do not mess with unless you know what you\'re doing

<section end=lidarr_settings_general_host />

### Readarr

<section begin=readarr_settings_general_host />

-   Binding Address - Valid IP4 address or \'\*\' for all interfaces
    -   0.0.0.0 or \* - any address can connect
    -   127.0.0.1 or localhost - only localhost applications can connect
    -   Any other IP (e.g. 1.2.3.4) - only that IP (1.2.3.4) can connect
-   Port Number - The port number that you are wanting to use to access
    the webUI for Readarr
    -   Note: If using Docker do not touch
-   URL Base - For reverse proxy support, default is empty
    -   Note: If using a reverse proxy (example: mydomain.com/readarr)
        you would enter \'/readarr\' for URL Base.
-   Enable SSL - If you have SSL credentials and would like to secure
    communication to and from your Readarr enable this option.
    -   Note: do not mess with unless you know what you\'re doing

<section end=lidarr_settings_general_host />
<section end=readarr_settings_general_host />

Security
--------

### Radarr

<section begin=radarr_settings_general_security />

-   Authentication - How would you like to authenticate to access your
    Radarr instance
    -   None - You have no authentication to access your Radarr
        -   Typically if you\'re the only user of your network, do not
            have anybody on your network that would care to access your
            Radarr or your Radarr is not exposed to the web
    -   Basic (Browser pop-up) - This option when accessing your Radarr
        will show a small pop-up allowing you to input a Username and
        Password
    -   Forms (Login Page) - This option will have a familiar looking
        login screen much like other websites have to allow you to log
        onto your Radarr
-   API Key - This is how other programs would communicate or have
    Radarr communicate to other programs. This key if given to the wrong
    person with access could do all kinds of things to your library.
    This is why in the logs the API key is redacted
-   Certificate Validation - Change how strict HTTPS certification
    validation is

<section end=radarr_settings_general_security />

### Sonarr

<section begin=sonarr_settings_general_security />

-   Authentication - How would you like to authenticate to access your
    Sonarr instance
    -   None - You have no authentication to access your Sonarr
        -   Typically if you\'re the only user of your network, do not
            have anybody on your network that would care to access your
            Sonarr or your Sonarr is not exposed to the web
    -   Basic (Browser pop-up) - This option when accessing your Sonarr
        will show a small pop-up allowing you to input a Username and
        Password
    -   Forms (Login Page) - This option will have a familiar looking
        login screen much like other websites have to allow you to log
        onto your Sonarr
-   API Key - This is how other programs would communicate or have
    Sonarr communicate to other programs. This key if given to the wrong
    person with access could do all kinds of things to your library.
    This is why in the logs the API key is redacted
-   Certificate Validation - Change how strict HTTPS certification
    validation is

<section end=sonarr_settings_general_security />

### Lidarr

<section begin=lidarr_settings_general_security />

-   Authentication - How would you like to authenticate to access your
    Lidarr instance
    -   None - You have no authentication to access your Lidarr
        -   Typically if you\'re the only user of your network, do not
            have anybody on your network that would care to access
            Lidarr or your Lidarr is not exposed to the web
    -   Basic (Browser pop-up) - This option when accessing your Lidarr
        will show a small pop-up allowing you to input a Username and
        Password
    -   Forms (Login Page) - This option will have a familiar looking
        login screen much like other websites have to allow you to log
        onto your Lidarr
-   API Key - This is how other programs would communicate or have
    Lidarr communicate to other programs. This key if given to the wrong
    person with access could do all kinds of things to your library.
    This is why in the logs the API key is redacted
-   Certificate Validation - Change how strict HTTPS certification
    validation is

<section end=lidarr_settings_general_security />

### Readarr

<section begin=readarr_settings_general_security />

-   Authentication - How would you like to authenticate to access your
    Readarrinstance
    -   None - You have no authentication to access your Readarr
        -   Typically if you\'re the only user of your network, do not
            have anybody on your network that would care to access
            Readarr or your Readarr is not exposed to the web
    -   Basic (Browser pop-up) - This option when accessing your Readarr
        will show a small pop-up allowing you to input a Username and
        Password
    -   Forms (Login Page) - This option will have a familiar looking
        login screen much like other websites have to allow you to log
        onto your Readarr
-   API Key - This is how other programs would communicate or have
    Readarr communicate to other programs. This key if given to the
    wrong person with access could do all kinds of things to your
    library. This is why in the logs the API key is redacted
-   Certificate Validation - Change how strict HTTPS certification
    validation is

<section end=readarr_settings_general_security />

Proxy
-----

### Radarr

<section begin=radarr_settings_general_proxy />

-   Proxy - This option allows you to run the information your Radarr
    pulls and searches for through a proxy. This can be useful if
    you\'re in a country that does not allow the downloading of
    `Torrent` files

<section end=radarr_settings_general_proxy />

### Sonarr

<section begin=sonarr_settings_general_proxy />

-   Proxy - This option allows you to run the information your Sonarr
    pulls and searches for through a proxy. This can be useful if
    you\'re in a country that does not allow the downloading of
    `Torrent` files

<section end=sonarr_settings_general_proxy />

### Lidarr

<section begin=lidarr_settings_general_proxy />

-   Proxy - This option allows you to run the information your Lidarr
    pulls and searches for through a proxy. This can be useful if
    you\'re in a country that does not allow the downloading of
    `Torrent` files

<section end=lidarr_settings_general_proxy />

### Readarr

<section begin=readarr_settings_general_proxy />

-   Proxy - This option allows you to run the information your Readarr
    pulls and searches for through a proxy. This can be useful if
    you\'re in a country that does not allow the downloading of
    `Torrent` files

<section end=readarr_settings_general_proxy />

Logging
-------

### Radarr

<section begin=radarr_settings_general_logging />

-   Log level - Probably one of the most useful
    [troubleshooting](Radarr_Troubleshooting "wikilink") tools
    -   Info - This is the most basic way that Radarr gathers
        information this will include very minimal amount of information
        in the logs.
        -   This log file contains fatal, error, warn and info entries.
    -   Debug - Debug will include all the information that Info
        includes plus more information that can be useful.
        -   This log files contains fatal, error, warn, info and debug
            entries
    -   Trace - The most advance and detailed logging on Radarr, Trace
        will include all the information gathered by Info and Debug and
        more. This is the most common type of log that is going to be
        asked for when troubleshooting on Discord or Reddit. If you\'re
        needing help please select your log to Trace and redo the task
        that was giving you problems to capture the log.
        -   This log files contains fatal, error, warn, info, debug and
            trace entries.

<section end=radarr_settings_general_logging />

### Sonarr

<section begin=sonarr_settings_general_logging />

-   Log level - Probably one of the most useful
    [troubleshooting](Sonarr_Troubleshooting "wikilink") tools
    -   Info - This is the most basic way that Sonarr gathers
        information this will include very minimal amount of information
        in the logs.
        -   This log file contains fatal, error, warn and info entries.
    -   Debug - Debug will include all the information that Info
        includes plus more information that can be useful.
        -   This log files contains fatal, error, warn, info and debug
            entries
    -   Trace - The most advance and detailed logging on Sonarr, Trace
        will include all the information gathered by Info and Debug and
        more. This is the most common type of log that is going to be
        asked for when troubleshooting on Discord or Reddit. If you\'re
        needing help please select your log to Trace and redo the task
        that was giving you problems to capture the log.
        -   This log files contains fatal, error, warn, info, debug and
            trace entries.

<section end=sonarr_settings_general_logging />

### Lidarr

<section begin=lidarr_settings_general_logging />

-   Log level - Probably one of the most useful
    [troubleshooting](Lidarr_Troubleshooting "wikilink") tools
    -   Info - This is the most basic way that Lidarr gathers
        information this will include very minimal amount of information
        in the logs.
        -   This log file contains fatal, error, warn and info entries.
    -   Debug - Debug will include all the information that Info
        includes plus more information that can be useful.
        -   This log files contains fatal, error, warn, info and debug
            entries
    -   Trace - The most advance and detailed logging on Lidarr, Trace
        will include all the information gathered by Info and Debug and
        more. This is the most common type of log that is going to be
        asked for when troubleshooting on Discord or Reddit. If you\'re
        needing help please select your log to Trace and redo the task
        that was giving you problems to capture the log.
        -   This log files contains fatal, error, warn, info, debug and
            trace entries.

<section end=lidarr_settings_general_logging />

### Readarr

<section begin=readarr_settings_general_logging />

-   Log level - Probably one of the most useful
    [troubleshooting](Readarr_Troubleshooting "wikilink") tools
    -   Info - This is the most basic way that Readarr gathers
        information this will include very minimal amount of information
        in the logs.
        -   This log file contains fatal, error, warn and info entries.
    -   Debug - Debug will include all the information that Info
        includes plus more information that can be useful.
        -   This log files contains fatal, error, warn, info and debug
            entries
    -   Trace - The most advance and detailed logging on Readarr, Trace
        will include all the information gathered by Info and Debug and
        more. This is the most common type of log that is going to be
        asked for when troubleshooting on Discord or Reddit. If you\'re
        needing help please select your log to Trace and redo the task
        that was giving you problems to capture the log.
        -   This log files contains fatal, error, warn, info, debug and
            trace entries.

<section end=readarr_settings_general_logging />

Analytics
---------

### Radarr

<section begin=radarr_settings_general_analytics />

-   Analytics - Send anonymous usage and error information to Radarr\'s
    servers (Servarr). This includes information on your browser, which
    Radarr WebUI pages you use, error reporting as well as OS and
    runtime version. We will use this information to prioritize features
    and bug fixes.

<section end=radarr_settings_general_analytics />

### Sonarr

<section begin=sonarr_settings_general_analytics />

-   Analytics - Send anonymous usage and error information to Sonarr\'s
    servers (SkyHook). This includes information on your browser, which
    Sonarr WebUI pages you use, error reporting as well as OS and
    runtime version. We will use this information to prioritize features
    and bug fixes.

<section end=sonarr_settings_general_analytics />

### Lidarr

<section begin=lidarr_settings_general_analytics />

-   Analytics - Send anonymous usage and error information to Lidarr\'s
    servers (Servarr). This includes information on your browser, which
    Lidarr WebUI pages you use, error reporting as well as OS and
    runtime version. We will use this information to prioritize features
    and bug fixes.

<section end=lidarr_settings_general_analytics />

### Readarr

<section begin=readarr_settings_general_analytics />

-   Analytics - Send anonymous usage and error information to Readarr\'s
    servers (Servarr). This includes information on your browser, which
    Readarr WebUI pages you use, error reporting as well as OS and
    runtime version. We will use this information to prioritize features
    and bug fixes.

<section end=readarr_settings_general_analytics />

Updates
-------

### Radarr

<section begin=radarr_settings_general_updates />

See Also: [FAQ: How do I update
Radarr?](Radarr_FAQ#How_do_I_update_Radarr.3F "wikilink")

-   Branch - This is the branch of Radarr that you are running on.
    Please see [the
    FAQ](Radarr_FAQ#How_do_I_update_Radarr.3F "wikilink") for available
    branches and version information
-   Automatic - Automatically download and install updates. You will
    still be able to install from System: Updates. Note: Windows Users
    are always automatically updated.
-   Mechanism - Use Radarr\'s built-in updater or a script
    -   Built-In - Use Radarr\'s own updater
    -   Docker - Do not update Radarr from inside the Docker, instead
        pull a brand new image with the new update
    -   Script - Have Radarr run the update script

<section end=radarr_settings_general_updates />

### Sonarr

<section begin=sonarr_settings_general_updates />

-   Branch - This is the branch of Sonarr that you are running on.
    Please see [Github](https://github.com/Sonarr/Sonarr) for available
    branches and version information. These branches only apply to V3.
    -   main (Stable): This has been tested by users on nightly branch
        and it\'s not known to have any major issues. This branch should
        be used by the majority of users.
    -   develop (Nightly) : This is the bleeding edge. It is released as
        soon as code is committed and passes all automated tests. This
        build may have not been used by us or other users yet. There is
        no guarantee that it will even run in some cases. This branch is
        only recommended for advanced users. Issues and self
        investigation are expected in this branch.
    -   phantom-develop (v3-preview): This is EOL and the built-in
        updater will automatically update to main.
    -   Automatic - Automatically download and install updates. You will
        still be able to install from System: Updates. Note: Windows
        Users are always automatically updated.
-   Mechanism - Use Sonarr built-in updater or a script
    -   Built-in - Use Sonarr\'s own updater
    -   Script - Have Sonarr run the update script
    -   Docker - Do not update Sonarr from inside the Docker, instead
        pull a brand new image with the new update
    -   Apt - Set by the Debian/Ubuntu package when updating is managed
        exclusively via Apt

<!-- -->

-   Script - Visible only when Mechanism is set to Script - Path to
    update script

<!-- -->

-   Update Process - Sonarr will download the update file, verify its
    integrity and extract it to a temporary location and call the chosen
    method. The update process will be be run under the same user that
    Sonarr is run under, it will need permissions to update the Sonarr
    files as well as stop/start Sonarr.
    -   Built-in - The built-in method will backup Sonarr files and
        settings, stop Sonarr, update the installation and Start Sonarr,
        if your system will not handle the stopping of Sonarr and will
        attempt to restart it automatically it may be best to use a
        script instead. In the event of failure the previous version of
        Sonarr will be restarted.
    -   Script - The script should handle the the same as the built-in
        updater, if you need to handle stopping and starting services
        (upstart/launchd/etc) you will need to do that here.

<section end=sonarr_settings_general_updates />

### Lidarr

<section begin=lidarr_settings_general_updates />

-   Branch - This is the branch of Lidarr that you are running on.
-   Automatic - Automatically download and install updates. You will
    still be able to install from System: Updates. Note: Windows Users
    are always automatically updated.

<!-- -->

-   Mechanism - Use Lidarr\'s built-in updater or a script
    -   Built-In - Use Lidarr\'s own updater
    -   Docker - Do not update Lidarr from inside the Docker, instead
        pull a brand new image with the new update
    -   Script - Have Lidarr run the update script

<section end=lidarr_settings_general_updates />

### Readarr

<section begin=readarr_settings_general_updates />

-   Branch - This is the branch of Readarr that you are running on.
-   Automatic - Automatically download and install updates. You will
    still be able to install from System: Updates. Note: Windows Users
    are always automatically updated.

<!-- -->

-   Mechanism - Use Readarr\'s built-in updater or a script
    -   Built-In - Use Readarr\'s own updater
    -   Docker - Do not update Readarr from inside the Docker, instead
        pull a brand new image with the new update
    -   Script - Have Readarr run the update script

<section end=readarr_settings_general_updates />

Backups
-------

### Radarr

<section begin=radarr_settings_general_backups />

The backup section allows you to tell Radarr how you would like for it
to handle backups

-   Folder - This allows you to select the backup location
    -   In docker you will be limited to what you allow the container to
        see
    -   Paths are relative to the appdata folder; if necessary, you can
        set an absolute path to backup outside of the appdata folder
-   Interval - How often would you like Radarr to make a backup
-   Retention - How long would you like Radarr to hold on to each
    backup. After a new backup is made the oldest backup will be removed

<section end=radarr_settings_general_backups />

### Sonarr

<section begin=sonarr_settings_general_backups />

The backup section allows you to tell Sonarr how you would like for it
to handle backups

-   Folder - This allows you to select the backup location
    -   In docker you will be limited to what you allow the container to
        see
    -   Paths are relative to the appdata folder; if necessary, you can
        set an absolute path to backup outside of the appdata folder
-   Interval - How often would you like Sonarr to make a backup
-   Retention - How long would you like Sonarr to hold on to each
    backup. After a new backup is made the oldest backup will be removed

<section end=sonarr_settings_general_backups />

### Lidarr

<section begin=lidarr_settings_general_backups />

The backup section allows you to tell Lidarr how you would like for it
to handle backups

-   Folder - This allows you to select the backup location
    -   In docker you will be limited to what you allow the container to
        see
    -   Paths are relative to the appdata folder; if necessary, you can
        set an absolute path to backup outside of the appdata folder
-   Interval - How often would you like Lidarr to make a backup
-   Retention - How long would you like Lidarr to hold on to each
    backup. After a new backup is made the oldest backup will be removed

<section end=lidarr_settings_general_backups />

### Readarr

<section begin=readarr_settings_general_backups />

The backup section allows you to tell Readarr how you would like for it
to handle backups

-   Folder - This allows you to select the backup location
    -   In docker you will be limited to what you allow the container to
        see
    -   Paths are relative to the appdata folder; if necessary, you can
        set an absolute path to backup outside of the appdata folder
-   Interval - How often would you like Readarr to make a backup
-   Retention - How long would you like Readarr to hold on to each
    backup. After a new backup is made the oldest backup will be removed

<section end=readarr_settings_general_backups />

Templates
---------
