System
------

### Health

#### Overview

###### Radarr

<section begin=radarr_system_status_health_overview />

This page contains a list of health checks errors. These health checks
are periodically performed performed by Radarr and on certain events.
The resulting warnings and errors are listed here to give advice on how
to resolve them.

<section end=radarr_system_status_health_overview />

###### Sonarr

<section begin=sonarr_system_status_health_overview />

This page contains a list of health checks errors. These health checks
are periodically performed performed by Sonarr and on certain events.
The resulting warnings and errors are listed here to give advice on how
to resolve them.

<section end=sonarr_system_status_health_overview />

###### Lidarr

<section begin=lidarr_system_status_health_overview />

This page contains a list of health checks errors. These health checks
are periodically performed performed by Lidarr and on certain events.
The resulting warnings and errors are listed here to give advice on how
to resolve them.

<section end=lidarr_system_status_health_overview />

###### Readarr

<section begin=readarr_system_status_health_overview />

This page contains a list of health checks errors. These health checks
are periodically performed performed by Readarr and on certain events.
The resulting warnings and errors are listed here to give advice on how
to resolve them.

<section end=readarr_system_status_health_overview />

#### System Warnings

##### Radarr

<section begin=radarr_system_status_health_system_warnings />

-   <span id="branch_is_not_a_valid_release_branch">**[Branch is not a
    valid release
    branch](#branch_is_not_a_valid_release_branch "wikilink")**</span>
    -   The branch you have set is not a valid release branch. You will
        not receive updates. Please change to one of the current release
        branches.

<!-- -->

-   <span id="update_to_net_core_version">**[Update to .NET Core
    version](#update_to_net_core_version "wikilink")**</span>
    -   Newer versions of Radarr are targeted for .NET. We will no
        longer be providing legacy mono builds after 3.2 is released.
        You are running one of these legacy builds but your platform
        supports .NET.
    -   Fixing Docker installs
        -   Re-pull your container
    -   Fixing Standalone installs
        -   <span style="color:#ff0000">**[ Back-Up your existing
            configuration](Radarr_FAQ#how_do_i_backup_restore_my_Radarr "wikilink")**</span>
            before the next step.
        -   This should only happen on Linux hosts.
            <span style="color:#ff0000">**Do not install .net core
            runtime or SDK from microsoft.**</span> To remedy, download
            the correct build for your architecture. Please note that
            the links are for the `master` branch. If you are on
            `develop` or `nightly` you\'ll need to adjust `/master/` in
            the URL.
        -   **Delete your existing binaries (contents or folder of
            /opt/Radarr)** and replace with the contents of the
            `.tar.gz` you just downloaded.
        -   <span style="color:#ff0000">**DO NOT JUST EXTRACT THE
            DOWNLOAD OVER THE TOP OF YOUR EXISTING BINARIES.\
            YOU MUST DELETE THE OLD ONES FIRST**.</span>
            -   `wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'`
                Download the .net binaries. The example is for a x64
                (AMD64) installation.
                -   For most users, this would be
                    `.linux-core-x64.tar.gz` selected via `arch=x64` in
                    the url. For ARM use `arch=arm` and for ARM64 use
                    `arch=arm64`
            -   `sudo systemctl stop radarr` Stop Radarr
            -   `sudo mv /opt/Radarr /opt/Radarr.old` Backup the old
                Binaries
            -   `tar -xvzf Radarr*.linux-core-x64.tar.gz` Extract the
                Radarr Tarball
            -   `sudo mv Radarr/ /opt` Move the new Radarr Binaries
            -   `sudo chown -R radarr:radarr /opt/Radarr` Ensure Radarr
                has permissions to its directory, this assumes it runs
                as the user `radarr`
            -   `sudo rm -rf /opt/Radarr.old` Remove the old binaries
            -   `sudo rm -rf Radarr*.linux-core-x64.tar.gz` Remove the
                Tarball
            -   Update your startup script in your systemd
                (`sudo nano -e /etc/systemd/system/radarr.service`) to
                call `Radarr` instead of calling it with mono like
                `mono --debug Radarr.exe`. In other words you want, as
                an example, `/opt/Radarr/Radarr` and **not**
                `mono --debug /opt/Radarr/Radarr`.
                -   If Radarr doesn't start, ensure you have [the
                    dependencies listed
                    here](https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?tabs=netcore31&pivots=os-linux)
                    installed.
            -   `systemctl daemon-reload` Reload the Systemd Files
            -   `sudo systemctl start radarr.service` Restart Radarr

<!-- -->

-   <span id="currently_installed_mono_version_is_old_and_unsupported">**[Currently
    installed mono version is old and
    unsupported](#currently_installed_mono_version_is_old_and_unsupported "wikilink")**</span>
    -   Radarr is written in .Net and requires Mono to run on very old
        ARM processors.
    -   Mono 5.20 is the absolute minimum for Radarr.
    -   The upgrade procedure for Mono varies per platform.

<!-- -->

-   <span id="currently_installed_sqlite_version_is_not_supported">**[Currently
    installed SQLite version is not
    supported](#currently_installed_sqlite_version_is_not_supported "wikilink")**</span>
    -   Radarr stores its data in an SQLite database. The sqlite3
        library installed on your system is too old. Radarr requires at
        least version 3.9.0. Note that Radarr uses `libsqlite3.so` which
        may or may not be contained in a sqlite3 upgrade package.

<!-- -->

-   <span id="new_update_is_available">**[New update is
    available](#new_update_is_available "wikilink")**</span>
    -   Rejoice, the developers have released a new update. This
        generally means awesome new features and squashed piles of bugs
        (right?). Apparently you don't have Auto-Updating enabled, so
        you'll have to figure out how to update on your platform.
        Pressing the Install button on the System -\> Updates page is
        probably a good starting point.
    -   *(This warning will not appear if your current version is less
        than 14 days old)*

<!-- -->

-   <span id="cannot_install_update_because_startup_folder_is_not_writable_by_the_user">**[Cannot
    install update because startup folder is not writable by the
    user](#cannot_install_update_because_startup_folder_is_not_writable_by_the_user "wikilink")**</span>
    -   This means Radarr will be unable to update itself. You'll have
        to update Radarr manually or set the permissions on Radarr's
        Startup directory (the installation directory) to allow Radarr
        to update itself.

<!-- -->

-   <span id="updating_will_not_be_possible_to_prevent_deleting_appdata_on_update">**[Updating
    will not be possible to prevent deleting AppData on
    Update](#updating_will_not_be_possible_to_prevent_deleting_appdata_on_update "wikilink")**</span>
    -   Radarr detected that AppData folder for your Operating System is
        located inside the directory that contains the Radarr binaries.
        Normally it would be `C:\ProgramData` for Windows and,
        `~/.config` for linux.
    -   Please look at System -\> Info to see the current AppData &
        Startup directories.
    -   This means Radarr will be unable to update itself without
        risking data-loss.
    -   If you're on linux, you'll probably have to change the home
        directory for the user that is running Radarr and copy the
        current contents of the `~/.config/Radarr` directory to preserve
        your database.

<!-- -->

-   <span id="branch_is_for_a_previous_version">**[Branch is for a
    previous
    version](#branch_is_for_a_previous_version "wikilink")**</span>
    -   The update branch setup in Settings/General is for a previous
        version of Radarr, therefore the instance will not see correct
        update information in the System/Updates feed and may not
        receive new updates when released.

<!-- -->

-   <span id="Could_not_connect_to_signalr">**[Could not connect to
    signalR](#Could_not_connect_to_signalr "wikilink")**</span>
    -   signalR drives the dynamic UI updates, so if your browser cannot
        connect to signalR on your server you won't see any real time
        updates in the UI.
    -   The most common occurrence of this is use of a reverse proxy or
        cloudflare
    -   Cloudflare needs websockets enabled.
    -   Nginx requires the following addition to the location block for
        the app:

` proxy_http_version 1.1;`\
` proxy_set_header Upgrade $http_upgrade;`\
` proxy_set_header Connection $http_connection;`

-   -   Make sure you <span style="color:#ff0000">**do not**</span>
        include `proxy_set_header Connection "Upgrade";` as suggested by
        the nginx documentation. <span style="color:#ff0000">**THIS WILL
        NOT WORK**</span>
    -   See <https://github.com/aspnet/AspNetCore/issues/17081>

<!-- -->

-   -   For Apache2 reverse proxy, you need to enable the following
        modules: `proxy`, `proxy_http`, and `proxy_wstunnel`. Then, add
        this websocket tunnel directive to your vhost configuration:

`RewriteEngine On`\
`RewriteCond %{`[`HTTP:Upgrade`](HTTP:Upgrade)`} =websocket [NC]`\
`RewriteRule /(.*) `[`ws://127.0.0.1:7878/$1`](ws://127.0.0.1:7878/$1)` [P,L]`

-   -   For Caddy (V1) use this:
        -   Note: you\'ll also need to add the websocket directive to
            your radarr configuration

` proxy /radarr 127.0.0.1:7878 {`\
`     websocket`\
`     transparent`\
` }`

-   <span id="proxy_failed_resolve_ip">**[Failed to resolve the IP
    Address for the Configured Proxy
    Host](#proxy_failed_resolve_ip "wikilink")**</span>
    -   Review your proxy settings and ensure they are accurate
    -   Ensure your proxy is up, running, and accessible

<!-- -->

-   <span id="proxy_failed_test">**[Proxy Failed
    Test](#proxy_failed_test "wikilink")**</span>
    -   Your configured proxy failed to test successfully, review the
        HTTP error provided and/or check logs for more details.

<!-- -->

-   <span id="system_time_off">**[System Time is off by more than 1
    day](#system_time_off "wikilink")**</span>
    -   System time is off by more than 1 day. Scheduled tasks may not
        run correctly until the time is corrected
    -   Review your system time and ensure it is synced to an
        authoritative time server and accurate

<!-- -->

-   <span id="mediainfo_not_loaded">**[MediaInfo Library Could not be
    Loaded](#mediainfo_not_loaded "wikilink")**</span>
    -   MediaInfo Library could not be loaded.

<!-- -->

-   <span id="ptp_settings_old">**[PTP Indexer Settings Out of
    Date](#ptp_settings_old "wikilink")**</span>
    -   The following PassThePopcorn indexers have deprecated settings
        and should be updated.

<!-- -->

-   <span id="mono_tls_legacy">**[Mono Legacy TLS
    enabled](#mono_tls_legacy "wikilink")**</span>
    -   Mono 4.x tls workaround still enabled, consider removing
        MONO\_TLS\_PROVIDER=legacy environment option

<!-- -->

-   <span id="mono_support_end_of_life">**[Mono and x86 builds are
    ending](#mono_support_end_of_life "wikilink")**</span>
    -   Mono and x86 builds will no longer be supported in the next
        build of the application. If you are receiving this error then
        you are running the mono version of the application or the x86
        version. Unfortunately, due to increasing difficulting in
        development support for these legacy versions we will be
        discontinuing their support and thus releases for them going
        forward. Thus it is advised you upgrade to a supported Operating
        System that does not require neither x86 nor mono. You may also
        be able to explore using Docker for your needs.

<section end=radarr_system_status_health_system_warnings />

##### Sonarr

<section begin=sonarr_system_status_health_system_warnings />

-   <span id="branch_is_not_a_valid_release_branch">**[Branch is not a
    valid release
    branch](#branch_is_not_a_valid_release_branch "wikilink")**</span>
    -   The branch you have set is not a valid release branch. You will
        not receive updates. Please change to one of the current release
        branches.

<!-- -->

-   <span id="currently_installed_net_framework_is_old_and_unsupported">**[Currently
    installed .Net Framework is old and
    unsupported](#currently_installed_net_framework_is_old_and_unsupported "wikilink")</span>**
    -   Sonarr uses the .Net Framework. We need to build Sonarr against
        the lowest supported version still used by our users.
        Occasionally we increase the version we build against to be able
        to utilize new features. Apparently you haven\'t applied the
        appropriate Windows updates in a while and need to upgrade .Net
        to be able to use newer versions of Sonarr.
    -   Upgrading the .Net Framework is very straightforward on Windows,
        although it often requires a restart. [Please follow the
        instructions
        here](https://dotnet.microsoft.com/download/dotnet-framework).

<!-- -->

-   <span id="currently_installed_net_framework_is_supported_but_upgrading_is_recommended">**[Currently
    installed .Net Framework is supported but upgrading is
    recommended](#currently_installed_net_framework_is_supported_but_upgrading_is_recommended "wikilink")**</span>
    -   Sonarr uses the .Net Framework. We need to build Sonarr against
        the lowest supported version still used by our users. Upgrading
        to newer versions allows us to build against newer versions and
        use new Framework features.
    -   Upgrading the .Net Framework is very straightforward on Windows,
        although it often requires a restart. [Please follow the
        instructions
        here](https://dotnet.microsoft.com/download/dotnet-framework).

<!-- -->

-   <span id="currently_installed_mono_version_is_old_and_unsupported">**[Currently
    installed mono version is old and
    unsupported](#currently_installed_mono_version_is_old_and_unsupported "wikilink")**</span>
    -   Sonarr is written in .Net and requires Mono to run. Various
        versions of Sonarr have different minimum versions of Mono to
        operate correctly. The ideal version of Mono varies per
        platform.\
    -   Mono 5.8 is the absolute minimum for Sonarr, but Mono 5.20 is
        currently recommended.
    -   The upgrade procedure for Mono varies per platform.

<!-- -->

-   <span id="currently_installed_mono_version_is_supported_but_upgrading_is_recommended">**[Currently
    installed mono version is supported but upgrading is
    recommended](#currently_installed_mono_version_is_supported_but_upgrading_is_recommended "wikilink")**</span>
    -   Sonarr uses the .Net Framework which Mono implements for your
        system. We need to build Sonarr against the lowest supported
        version still used by our users. Upgrading to newer versions
        allows us to build against newer versions and use new Framework
        features.
    -   The upgrade procedure for Mono varies per platform.

<!-- -->

-   <span id="new_update_is_available">**[New update is
    available](#new_update_is_available "wikilink")**</span>
    -   Rejoice, the developers have released a new update. This
        generally means awesome new features and squashed piles of bugs
        (right?). Apparently you don\'t have Auto-Updating enabled, so
        you\'ll have to figure out how to update on your platform.
        Pressing the Install button on the System -\> Updates page is
        probably a good starting point. But while you\'re at it, read
        the change log to find out what the relevant changes were.
    -   *(This warning will not appear if your current version is less
        than 14 days old)*

<!-- -->

-   <span id="cannot_install_update_because_startup_folder_is_not_writable_by_the_user">**[Cannot
    install update because startup folder is not writable by the
    user](#cannot_install_update_because_startup_folder_is_not_writable_by_the_user "wikilink")**</span>
    -   This means Sonarr will be unable to update itself. You\'ll have
        to update Sonarr manually or set the permissions on Sonarr\'s
        Startup directory (the installation directory) to allow Sonarr
        to update itself.

<!-- -->

-   <span id="updating_will_not_be_possible_to_prevent_deleting_appdata_on_update">**[Updating
    will not be possible to prevent deleting AppData on
    Update](#updating_will_not_be_possible_to_prevent_deleting_appdata_on_update "wikilink")**</span>
    -   Sonarr detected that AppData folder for your Operating System is
        located inside the directory that contains the Sonarr binaries.
        Normally it would be `C:\ProgramData` for Windows and,
        `~/.config` for linux.\
    -   Please look at System -\> About to see the current AppData &
        Startup directories.
    -   This means Sonarr will be unable to update itself without
        risking data-loss.
    -   If you\'re on linux, you\'ll probably have to change the home
        directory for the user that is running Sonarr and copy the
        current contents of the `~/.config/Sonarr` directory to preserve
        your database.
-   <span id="package_maintainer_message">**[Package Maintainer
    Message](#package_maintainer_message "wikilink")**</span>
    -   Please refer to the specific message your package maintainer is
        indicating to you. This is not a Sonarr issue. For additional
        information, refer to your package maintainer. Your package
        maintainer can be found in System -\> Status -\> About. Note
        that this includes docker and your package maintainer is
        whomever maintains your docker image.

<!-- -->

-   <span id="proxy_failed_resolve_ip">**[Failed to resolve the IP
    Address for the Configured Proxy
    Host](#proxy_failed_resolve_ip "wikilink")**</span>
    -   Review your proxy settings and ensure they are accurate
    -   Ensure your proxy is up, running, and accessible

<!-- -->

-   <span id="proxy_failed_test">**[Proxy Failed
    Test](#proxy_failed_test "wikilink")**</span>
    -   Your configured proxy failed to test successfully, review the
        HTTP error provided and/or check logs for more details.

<!-- -->

-   <span id="system_time_off">**[System Time is off by more than 1
    day](#system_time_off "wikilink")**</span>
    -   System time is off by more than 1 day. Scheduled tasks may not
        run correctly until the time is corrected
    -   Review your system time and ensure it is synced to an
        authoritative time server and accurate

<!-- -->

-   <span id="mediainfo_not_loaded">**[MediaInfo Library Could not be
    Loaded](#mediainfo_not_loaded "wikilink")**</span>
    -   MediaInfo Library could not be loaded.

<!-- -->

-   <span id="mono_tls_legacy">**[Mono Legacy TLS
    enabled](#mono_tls_legacy "wikilink")**</span>
    -   Mono 4.x tls workaround still enabled, consider removing
        MONO\_TLS\_PROVIDER=legacy environment option

<section end=sonarr_system_status_health_system_warnings />

##### Lidarr

<section begin=lidarr_system_status_health_system_warnings />

-   <span id="branch_is_not_a_valid_release_branch">**[Branch is not a
    valid release
    branch](#branch_is_not_a_valid_release_branch "wikilink")**</span>
    -   The branch you have set is not a valid release branch. You will
        not receive updates. Please change to one of the current release
        branches.

<!-- -->

-   <span id="update_to_net_core_version">**[Update to .NET Core
    version](#update_to_net_core_version "wikilink")**</span>
    -   Newer versions of Lidarr are targeted for .NET. We will soon no
        longer provide legacy mono builds for those platforms that
        cannot use .NET. You are running one of these legacy builds but
        your platform supports .NET.
    -   Fixing Docker installs
        -   Re-pull your container
    -   Fixing Standalone installs
        -   <span style="color:#ff0000">**Back-Up your existing
            configuration**</span> before the next step.
        -   This should only happen on Linux hosts.
            <span style="color:#ff0000">**Do not install .net core
            runtime or SDK from microsoft.**</span> To remedy, download
            the correct build for your architecture. Please note that
            the links are for the `develop` branch. If you are on
            `nightly` you\'ll need to adjust `/develop/` in the URL.
        -   **Delete your existing binaries (contents or folder of
            /opt/Lidarr)** and replace with the contents of the
            `.tar.gz` you just downloaded.
        -   <span style="color:#ff0000">**DO NOT JUST EXTRACT THE
            DOWNLOAD OVER THE TOP OF YOUR EXISTING BINARIES.\
            YOU MUST DELETE THE OLD ONES FIRST**</span>
            -   `wget --content-disposition 'http://lidarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'`
                Download the .net binaries. The example is for a x64
                (AMD64) installation.
                -   For most users, this would be
                    `.linux-core-x64.tar.gz` selected via `arch=x64` in
                    the url. For ARM use `arch=arm` and for ARM64 use
                    `arch=arm64`
            -   `sudo systemctl stop lidarr.service` Stop Lidarr
            -   `sudo mv /opt/Lidarr /opt/Lidarr.old` Backup the old
                Binaries
            -   `tar -xvzf Lidarr*.linux-core-x64.tar.gz` Extract the
                Lidarr Tarball
            -   `sudo mv Lidarr/ /opt` Move the new Lidarr Binaries
            -   `sudo chown -R lidarr:lidarr /opt/Lidarr` Ensure Lidarr
                has permissions to its directory, this assumes it runs
                as the user `lidarr`
            -   `sudo rm -rf /opt/Lidarr.old` Remove the old binaries
            -   `sudo rm -rf Lidarr*.linux-core-x64.tar.gz` Remove the
                Tarball
            -   Update your startup script
                (`sudo nano -e /etc/systemd/system/lidarr.service`) to
                call `Lidarr` instead of calling it with mono like
                `mono --debug Lidarr.exe`. In other words you want, as
                an example, `/opt/Lidarr/Lidarr` and **not**
                `mono --debug /opt/Lidarr/Lidarr`.
                -   If Lidarr doesn't start, ensure you have [the
                    dependencies listed
                    here](https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?tabs=netcore31&pivots=os-linux)
                    installed
            -   `systemctl daemon-reload` Reload the Systemd Files
            -   `sudo systemctl start lidarr.service` Restart Lidarr

<!-- -->

-   <span id="mono_version_is_less_than_5_8_upgrade_for_improved_stability">**[Mono
    version is less than 5.8, upgrade for improved
    stability](#mono_version_is_less_than_5_8_upgrade_for_improved_stability "wikilink")**</span>
    -   Lidarr is written in .Net and requires Mono to run on very old
        ARM processors.
    -   Mono 5.20 is the absolute minimum for Lidarr.
    -   The upgrade procedure for Mono varies per platform..
    -   See \"Update to .NET Core version above\"

<!-- -->

-   <span id="new_update_is_available">**[New update is
    available](#new_update_is_available "wikilink")**</span>
    -   Rejoice, the developers have released a new update. This
        generally means awesome new features and squashed piles of bugs
        (right?). Apparently you don't have Auto-Updating enabled, so
        you'll have to figure out how to update on your platform.
        Pressing the Install button on the System -\> Updates page is
        probably a good starting point.
    -   *(This warning will not appear if your current version is less
        than 14 days old)*

<!-- -->

-   <span id="cannot_install_update_because_startup_folder_is_not_writable_by_the_user">**[Cannot
    install update because startup folder is not writable by the
    user](#cannot_install_update_because_startup_folder_is_not_writable_by_the_user "wikilink")**</span>
    -   This means Lidarr will be unable to update itself. You'll have
        to update Lidarr manually or set the permissions on Lidarr
        Startup directory (the installation directory) to allow Lidarr
        to update itself.

<!-- -->

-   <span id="branch_is_for_a_previous_version">**[Branch is for a
    previous
    version](#branch_is_for_a_previous_version "wikilink")**</span>
    -   The update branch setup in Settings/General is for a previous
        version of Lidarr, therefore the instance will not see correct
        update information in the System/Updates feed and may not
        receive new updates when released.

<!-- -->

-   <span id="Could_not_connect_to_signalr">**[Could not connect to
    signalR](#Could_not_connect_to_signalr "wikilink")**</span>
    -   signalR drives the dynamic UI updates, so if your browser cannot
        connect to signalR on your server you won't see any real time
        updates in the UI.
    -   The most common occurrence of this is use of a reverse proxy or
        cloudflare
    -   Cloudflare needs websockets enabled.
    -   Nginx requires the following addition to the location block for
        the app:

` proxy_http_version 1.1;`\
` proxy_set_header Upgrade $http_upgrade;`\
` proxy_set_header Connection $http_connection;`

-   -   Make sure you <span style="color:#ff0000">**do not**</span>
        include `proxy_set_header Connection "Upgrade";` as suggested by
        the nginx documentation. <span style="color:#ff0000">**THIS WILL
        NOT WORK**</span>
    -   See <https://github.com/aspnet/AspNetCore/issues/17081>
    -   For Apache2 reverse proxy, you need to enable the following
        modules: `proxy`, `proxy_http`, and `proxy_wstunnel`. Then, add
        this websocket tunnel directive to your vhost configuration:

`RewriteEngine On`\
`RewriteCond %{`[`HTTP:Upgrade`](HTTP:Upgrade)`} =websocket [NC]`\
`RewriteRule /(.*) `[`ws://127.0.0.1:8686/$1`](ws://127.0.0.1:8686/$1)` [P,L]`

-   <span id="fpcalc_upgrade">**[Fpcalc Needs
    Upgrading](#fpcalc_upgrade "wikilink")**</span>

Lidarr can use chromaprint audio fingerprinting to identify tracks. This
depends on an external binary, which is distributed with Lidarr for
Windows and macOS, but must be provided independently on Linux.

To fix this on a native Linux instance, install the appropriate package
using your package manager and make sure that fpcalc is on your PATH
(this can be checked using which fpcalc and verifying that the correct
location of fpcalc is returned):

  Distribution    Package
  --------------- ------------------------
  Debian/Ubuntu   `libchromaprint-tools`
  Fedora/CentOS   `chromaprint-tools`
  Arch            `chromaprint`
  OpenSUSE        `chromaprint-fpcalc`
  Synology        `chromaprint`

-   <span id="proxy_failed_resolve_ip">**[Failed to resolve the IP
    Address for the Configured Proxy
    Host](#proxy_failed_resolve_ip "wikilink")**</span>
    -   Review your proxy settings and ensure they are accurate
    -   Ensure your proxy is up, running, and accessible

<!-- -->

-   <span id="proxy_failed_test">**[Proxy Failed
    Test](#proxy_failed_test "wikilink")**</span>
    -   Your configured proxy failed to test successfully, review the
        HTTP error provided and/or check logs for more details.

<!-- -->

-   <span id="system_time_off">**[System Time is off by more than 1
    day](#system_time_off "wikilink")**</span>
    -   System time is off by more than 1 day. Scheduled tasks may not
        run correctly until the time is corrected
    -   Review your system time and ensure it is synced to an
        authoritative time server and accurate

<!-- -->

-   <span id="mediainfo_not_loaded">**[MediaInfo Library Could not be
    Loaded](#mediainfo_not_loaded "wikilink")**</span>
    -   MediaInfo Library could not be loaded.

<!-- -->

-   <span id="mono_tls_legacy">**[Mono Legacy TLS
    enabled](#mono_tls_legacy "wikilink")**</span>
    -   Mono 4.x tls workaround still enabled, consider removing
        MONO\_TLS\_PROVIDER=legacy environment option

<section end=lidarr_system_status_health_system_warnings />

##### Readarr

<section begin=readarr_system_status_health_system_warnings />

-   <span id="branch_is_not_a_valid_release_branch">**[Branch is not a
    valid release
    branch](#branch_is_not_a_valid_release_branch "wikilink")**</span>
    -   The branch you have set is not a valid release branch. You will
        not receive updates. Please change to one of the current release
        branches.

<!-- -->

-   <span id="update_to_net_core_version">**[Update to .NET Core
    version](#update_to_net_core_version "wikilink")**</span>
    -   Newer versions of Readarr are targeted for .NET. We will soon no
        longer provide legacy mono builds for those platforms that
        cannot use .NET. You are running one of these legacy builds but
        your platform supports .NET Core.
    -   Fixing Docker installs
        -   Re-pull your container
    -   Fixing Standalone installs
        -   <span style="color:#ff0000">**Back-Up your existing
            configuration**</span> before the next step.
        -   This should only happen on Linux hosts.
            <span style="color:#ff0000">**Do not install .net core
            runtime or SDK from microsoft.**</span> To remedy, download
            the correct build for your architecture. Please note that
            the links are for the `master` branch. If you are on
            `develop` or `nightly` you\'ll need to adjust `/master/` in
            the URL.
        -   **Delete your existing binaries (contents or folder of
            /opt/Readarr)** and replace with the contents of the
            `.tar.gz` you just downloaded.
        -   <span style="color:#ff0000">**DO NOT JUST EXTRACT THE
            DOWNLOAD OVER THE TOP OF YOUR EXISTING BINARIES.\
            YOU MUST DELETE THE OLD ONES FIRST**.</span>
            -   `wget --content-disposition 'http://readarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'`
                Download the .net binaries. The example is for a x64
                (AMD64) installation.
                -   For most users, this would be
                    `.linux-core-x64.tar.gz` selected via `arch=x64` in
                    the url. For ARM use `arch=arm` and for ARM64 use
                    `arch=arm64`
            -   `sudo systemctl stop readarr` Stop Readarr
            -   `sudo mv /opt/Readarr /opt/Readarr.old` Backup the old
                Binaries
            -   `tar -xvzf Readarr*.linux-core-x64.tar.gz` Extract the
                Readarr Tarball
            -   `sudo mv Readarr/ /opt` Move the new Readarr Binaries
            -   `sudo chown -R readarr:readarr /opt/Readarr` Ensure
                Readarr has permissions to its directory, this assumes
                it runs as the user `readarr`
            -   `sudo rm -rf /opt/Readarr.old` Remove the old binaries
            -   `sudo rm -rf Readarr*.linux-core-x64.tar.gz` Remove the
                Tarball
            -   Update your startup script
                (`sudo nano -e /etc/systemd/system/readarr.service`) to
                call `Readarr` instead of calling it with mono like
                `mono --debug Readarr.exe`. In other words you want, as
                an example, `/opt/Readarr/Readarr` and **not**
                `mono --debug /opt/Readarr/Readarr`.
                -   If Readarr doesn't start, ensure you have [the
                    dependencies listed
                    here](https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?tabs=netcore31&pivots=os-linux)
                    installed.
            -   `systemctl daemon-reload` Reload the Systemd Files
            -   `sudo systemctl start readarr.service` Restart Readarr

<!-- -->

-   <span id="mono_version_is_less_than_5_2_upgrade_for_improved_stability">**[Mono
    version is less than 5.2, upgrade for improved
    stability](#mono_version_is_less_than_5_2_upgrade_for_improved_stability "wikilink")**</span>
    -   Readarr is written in .Net and requires Mono to run on very old
        ARM processors.
    -   Mono 5.20 is the absolute minimum for Readarr.
    -   The upgrade procedure for Mono varies per platform.
    -   See \"Update to .NET Core version above\"

<!-- -->

-   <span id="new_update_is_available">**[New update is
    available](#new_update_is_available "wikilink")**</span>
    -   Rejoice, the developers have released a new update. This
        generally means awesome new features and squashed piles of bugs
        (right?). Apparently you don't have Auto-Updating enabled, so
        you'll have to figure out how to update on your platform.
        Pressing the Install button on the System -\> Updates page is
        probably a good starting point.
    -   *(This warning will not appear if your current version is less
        than 14 days old)*

<!-- -->

-   <span id="cannot_install_update_because_startup_folder_is_not_writable_by_the_user">**[Cannot
    install update because startup folder is not writable by the
    user](#cannot_install_update_because_startup_folder_is_not_writable_by_the_user "wikilink")**</span>
    -   This means Lidarr will be unable to update itself. You'll have
        to update Lidarr manually or set the permissions on Lidarr
        Startup directory (the installation directory) to allow Lidarr
        to update itself.

<!-- -->

-   <span id="branch_is_for_a_previous_version">**[Branch is for a
    previous
    version](#branch_is_for_a_previous_version "wikilink")**</span>
    -   The update branch setup in Settings/General is for a previous
        version of Lidarr, therefore the instance will not see correct
        update information in the System/Updates feed and may not
        receive new updates when released.

<!-- -->

-   <span id="Could_not_connect_to_signalr">**[Could not connect to
    signalR](#Could_not_connect_to_signalr "wikilink")**</span>
    -   signalR drives the dynamic UI updates, so if your browser cannot
        connect to signalR on your server you won't see any real time
        updates in the UI.
    -   The most common occurrence of this is use of a reverse proxy or
        cloudflare
    -   Cloudflare needs websockets enabled.
    -   Nginx requires the following addition to the location block for
        the app:

` proxy_http_version 1.1;`\
` proxy_set_header Upgrade $http_upgrade;`\
` proxy_set_header Connection $http_connection;`

-   -   Make sure you <span style="color:#ff0000">**do not**</span>
        include `proxy_set_header Connection "Upgrade";` as suggested by
        the nginx documentation. <span style="color:#ff0000">**THIS WILL
        NOT WORK**</span>
    -   See <https://github.com/aspnet/AspNetCore/issues/17081>
    -   For Apache2 reverse proxy, you need to enable the following
        modules: `proxy`, `proxy_http`, and `proxy_wstunnel`. Then, add
        this websocket tunnel directive to your vhost configuration:

`RewriteEngine On`\
`RewriteCond %{`[`HTTP:Upgrade`](HTTP:Upgrade)`} =websocket [NC]`\
`RewriteRule /(.*) `[`ws://127.0.0.1:8787/$1`](ws://127.0.0.1:8787/$1)` [P,L]`

-   <span id="proxy_failed_resolve_ip">**[Failed to resolve the IP
    Address for the Configured Proxy
    Host](#proxy_failed_resolve_ip "wikilink")**</span>
    -   Review your proxy settings and ensure they are accurate
    -   Ensure your proxy is up, running, and accessible

<!-- -->

-   <span id="proxy_failed_test">**[Proxy Failed
    Test](#proxy_failed_test "wikilink")**</span>
    -   Your configured proxy failed to test successfully, review the
        HTTP error provided and/or check logs for more details.

<!-- -->

-   <span id="proxy_">**[System Time is off by more than 1
    day](#system_time_off "wikilink")**</span>
    -   System time is off by more than 1 day. Scheduled tasks may not
        run correctly until the time is corrected
    -   Review your system time and ensure it is synced to an
        authoritative time server and accurate

<!-- -->

-   <span id="mediainfo_not_loaded">**[MediaInfo Library Could not be
    Loaded](#mediainfo_not_loaded "wikilink")**</span>
    -   MediaInfo Library could not be loaded.

<!-- -->

-   <span id="mono_tls_legacy">**[Mono Legacy TLS
    enabled](#mono_tls_legacy "wikilink")**</span>
    -   Mono 4.x tls workaround still enabled, consider removing
        MONO\_TLS\_PROVIDER=legacy environment option

<section end=readarr_system_status_health_system_warnings />

#### Download Clients

##### Radarr

<section begin=radarr_system_status_health_download_clients />

-   <span id="no_download_client_is_available">**[No download client is
    available](#no_download_client_is_available "wikilink")**</span>
    -   A properly configured and enabled download client is required
        for Radarr to be able to download media. Since Radarr supports
        different download clients, you should determine which best
        matches your requirements. If you already have a download client
        installed, you should configure Radarr to use it and create a
        category. See Settings -\> Download Client.

<!-- -->

-   <span id="unable_to_communicate_with_download_client">**[Unable to
    communicate with download
    client](#unable_to_communicate_with_download_client "wikilink")**</span>
    -   Radarr was unable to communicate with the configured download
        client. Please verify if the download client is operational and
        double check the url. This could also indicate an authentication
        error.
    -   This is typically due to improperly configured download client.
        Things you can typically check:
        -   Your download clients IP Address if its on the same bare
            metal machine this is typically `127.0.0.1`
        -   The Port number of that your download client is using these
            are filled out with the default port number but if you\'ve
            changed it you\'ll need to have the same one entered into
            Radarr.
        -   Ensure SSL encryption is not turned on if you\'re using both
            your Radarr instance and your download client on a local
            network. See [the SSL FAQ
            entry](Radarr_FAQ#Invalid_Certificate_and_other_HTTPS_or_SSL_issues "wikilink")
            for more information.

<!-- -->

-   <span id="download_clients_are_unavailable_due_to_failures">**[Download
    clients are unavailable due to
    failure](#download_clients_are_unavailable_due_to_failures "wikilink")**</span>
    -   One or more of your download clients is not responding to
        requests made by Radarr. Therefore Radarr has decided to
        temporarily stop querying the download client on it's normal 1
        minute cycle, which is normally used to track active downloads
        and import finished ones. However, Radarr will continue to
        attempt to send downloads to the client, but will in all
        likeliness fail.
    -   You should inspect System-\>Logs to see what the reason is for
        the failures.
    -   If you no longer use this download client, disable it in Radarr
        to prevent the errors.

<!-- -->

-   <span id="enable_complete_download_handling">**[Enable Completed
    Download
    Handling](#enable_complete_download_handling "wikilink")**</span>
    -   Radarr requires Completed Download Handling to be able to import
        files that were downloaded by the download client. It is
        recommended to enable Completed Download Handling.
    -   *(Completed Download Handling is enabled by default for new
        users.)*

<!-- -->

-   <span id="docker_bad_remote_path_mapping">**[Docker bad remote path
    mapping](#docker_bad_remote_path_mapping "wikilink")**</span>
    -   This error is typically associated with bad docker paths within
        either your download client or Radarr
        -   An example of this would be:
            -   Download client:
                `Download Path: /downloads:/mnt/user/downloads`
            -   Radarr: `Download Path: /data:/mnt/user/downloads`
            -   Within this example the download client places its
                downloads into `/downloads` and therefore tells Radarr
                when its complete that the finished movie is in
                `/downloads`. Radarr then comes along and says \"Okay,
                cool, let me check in `/downloads`\" Well, inside Radarr
                you did not allocate a `/downloads` path you allocated a
                `/data` path so it throws this error.
            -   The easiest fix for this is **CONSISTENCY** if you use
                one scheme in your download client, use it across the
                board.
            -   Team Radarr is a big fan of simply using `/data`.
                -   Download client: `/data:/mnt/user/data`
                -   Radarr: `/data:/mnt/user/data`
                -   Now within the download client you can specify where
                    in `/data` you\'d like to place your downloads, now
                    this varies depending on the client but you should
                    be able to tell it \"Yeah download client place my
                    files into.\" `/data/torrents (or usenet)/movies`
                    and since you used `/data` in Radarr when the
                    download client tells Radarr it\'s done Radarr will
                    come along and say \"Sweet, I have a `/data` and I
                    also can see `/torrents (or usenet)/movies` all is
                    right in the world.\"
        -   There are many great write ups by some very talented people
            one on our wiki [Docker Guide](Docker_Guide "wikilink") and
            the other by TRaSH with his [How To Set Up Hardlinks and
            Atomic-Moves](https://trash-guides.info/hardlinks) Now these
            guides place heavy emphasis on Hardlinks and Atomic moves,
            but the general concept of containers and how path mapping
            works is the core of these discussions.

[See TRaSH\'s Remote Path Guide for more
information.](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/)

-   <span id="downloads_in_root_folder">**[Downloading into Root
    Folder](#downloads_in_root_folder "wikilink")**</span>
    -   Within the application, a root folder is defined as the
        configured media library folder. You\'re downloading directly
        into your root (library) folder. This frequently causes issues
        and is not advised. To fix this change your download client so
        it is not placing downloads within your root folder. Please note
        that this check looks at all [defined/configured root
        folders](Radarr_Settings#Root_Folders "wikilink") added not only
        root folders currently in use.

<!-- -->

-   \<span id=\"bad\_download\_client\_settings\>**[Bad Download Client
    Settings](#bad_download_client_settings "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map.

<!-- -->

-   <span id="bad_remote_path_mapping">**[Bad Remote Path
    Mapping](#bad_remote_path_mapping "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map. [See TRaSH\'s Remote
        Path Guide for more
        information.](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/)

<!-- -->

-   <span id="permissions_error">**[Permissions
    Error](#permissions_error "wikilink")**</span>
    -   Radarr or the user radarr is running as cannot access the
        location your download client is downloading files to. This is
        typically a permission issue.

<!-- -->

-   <span id="remote_path_file_removed">**[Remote File was removed part
    way through
    processing](#remote_path_file_removed "wikilink")**</span>
    -   A file accessible via a remote path map appears to have been
        removed prior to processing completing.

<!-- -->

-   <span id="remote_path_import_failed">**[Remote Path is Used and
    Import Failed](#remote_path_import_failed "wikilink")**</span>
    -   Check your logs for more info; Refer to our Troubleshooting
        Guides

<section end=radarr_system_status_health_download_clients />

##### Sonarr

<section begin=sonarr_system_status_health_download_clients />

-   <span id="no_download_client_is_available">**[No download client is
    available](#no_download_client_is_available "wikilink")**</span>
    -   A properly configured and enabled download client is required
        for Sonarr to be able to download media. Since Sonarr supports
        different download clients, you should determine which best
        matches your requirements. If you already have a download client
        installed, you should configure Sonarr to use it and create a
        category. See Settings -\> Download Client.

<!-- -->

-   <span id="unable_to_communicate_with_download_client">**[Unable to
    communicate with download
    client](#unable_to_communicate_with_download_client "wikilink")**</span>
    -   Sonarr was unable to communicate with the configured download
        client. Please verify if the download client is operational and
        double check the url. This could also indicate an authentication
        error.
    -   This is typically due to improperly configured download client.
        Things you can typically check:
        -   Your download clients IP Address if its on the same bare
            metal machine this is typically `127.0.0.1`
        -   The Port number of that your download client is using these
            are filled out with the default port number but if you\'ve
            changed it you\'ll need to have the same one entered into
            Sonarr.
        -   Ensure SSL encryption is not turned on if you\'re using both
            your Sonarr instance and your download client on a local
            network. See [the SSL FAQ
            entry](Sonarr_FAQ#Invalid_Certificate_and_other_HTTPS_or_SSL_issues "wikilink")
            for more information.

<!-- -->

-   <span id="download_clients_are_unavailable_due_to_failures">**[Download
    clients are unavailable due to
    failure](#download_clients_are_unavailable_due_to_failures "wikilink")**</span>
    -   One or more of your download clients is not responding to
        requests made by Sonarr. Therefore Sonarr has decided to
        temporarily stop querying the download client on it\'s normal 1
        minute cycle, which is normally used to track active downloads
        and import finished ones. However, Sonarr will continue to
        attempt to send downloads to the client, but will in all
        likeliness fail.
    -   You should inspect System-\>Logs to see what the reason is for
        the failures.
    -   If you no longer use this download client, disable it in Sonarr
        to prevent the errors.

<!-- -->

-   <span id="downloads_in_root_folder">**[Downloading into Root
    Folder](#downloads_in_root_folder "wikilink")**</span>
    -   Within the application, a root folder is defined as the
        configured media library folder. You\'re downloading directly
        into your root (library) folder. This frequently causes issues
        and is not advised. To fix this change your download client so
        it is not placing downloads within your root folder. Please note
        that this check looks at all [defined/configured root
        folders](Sonarr_Settings#Root_Folders "wikilink") added not only
        root folders currently in use.

<!-- -->

-   \<span id=\"bad\_download\_client\_settings\>**[Bad Download Client
    Settings](#bad_download_client_settings "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map.

<!-- -->

-   <span id="bad_remote_path_mapping">**[Bad Remote Path
    Mapping](#bad_remote_path_mapping "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map. [See TRaSH\'s Remote
        Path Guide for more
        information.](https://trash-guides.info/Sonarr/V3/Sonarr-remote-path-mapping/)

<!-- -->

-   <span id="permissions_error">**[Permissions
    Error](#permissions_error "wikilink")**</span>
    -   Sonarr or the user sonarr is running as cannot access the
        location your download client is downloading files to. This is
        typically a permission issue.

<!-- -->

-   <span id="remote_path_file_removed">**[Remote File was removed part
    way through
    processing](#remote_path_file_removed "wikilink")**</span>
    -   A file accessible via a remote path map appears to have been
        removed prior to processing completing.

<!-- -->

-   <span id="remote_path_import_failed">**[Remote Path is Used and
    Import Failed](#remote_path_import_failed "wikilink")**</span>
    -   Check your logs for more info; Refer to our Troubleshooting
        Guides

<section end="sonarr_system_status_health_download_clients" />

##### Lidarr

<section begin=lidarr_system_status_health_download_clients />

-   <span id="no_download_client_is_available">**[No download client is
    available](#no_download_client_is_available "wikilink")**</span>
    -   A properly configured and enabled download client is required
        for Lidarr to be able to download media. Since Lidarr supports
        different download clients, you should determine which best
        matches your requirements. If you already have a download client
        installed, you should configure Lidarr to use it and create a
        category. See Settings -\> Download Client.

<!-- -->

-   <span id="unable_to_communicate_with_download_client">**[Unable to
    communicate with download
    client](#unable_to_communicate_with_download_client "wikilink")**</span>
    -   Lidarr was unable to communicate with the configured download
        client. Please verify if the download client is operational and
        double check the url. This could also indicate an authentication
        error.
    -   This is typically due to improperly configured download client.
        Things you can typically check:
        -   Your download clients IP Address if its on the same bare
            metal machine this is typically `127.0.0.1`
        -   The Port number of that your download client is using these
            are filled out with the default port number but if you\'ve
            changed it you\'ll need to have the same one entered into
            Lidarr.
        -   Ensure SSL encryption is not turned on if you\'re using both
            your Lidarr instance and your download client on a local
            network. See [the SSL FAQ
            entry](Lidarr_FAQ#Invalid_Certificate_and_other_HTTPS_or_SSL_issues "wikilink")
            for more information.

<!-- -->

-   <span id="download_clients_are_unavailable_due_to_failures">**[Download
    clients are unavailable due to
    failure](#download_clients_are_unavailable_due_to_failures "wikilink")**</span>
    -   One or more of your download clients is not responding to
        requests made by Lidarr. Therefore Lidarr has decided to
        temporarily stop querying the download client on it's normal 1
        minute cycle, which is normally used to track active downloads
        and import finished ones. However, Lidarr will continue to
        attempt to send downloads to the client, but will in all
        likeliness fail.
    -   You should inspect System-\>Logs to see what the reason is for
        the failures.
    -   If you no longer use this download client, disable it in Lidarr
        to prevent the errors.

<!-- -->

-   <span id="enable_complete_download_handling">**[Enable Completed
    Download
    Handling](#enable_complete_download_handling "wikilink")**</span>
    -   Lidarr requires Completed Download Handling to be able to import
        files that were downloaded by the download client. It is
        recommended to enable Completed Download Handling.
    -   *(Completed Download Handling is enabled by default for new
        users.)*

<!-- -->

-   <span id="docker_bad_remote_path_mapping">**[Docker bad remote path
    mapping](#docker_bad_remote_path_mapping "wikilink")**</span>
    -   This error is typically associated with bad docker paths within
        either your download client or Lidarr
        -   An example of this would be:
            -   Download client:
                `Download Path: /downloads:/mnt/user/downloads`
            -   Lidarr: `Download Path: /data:/mnt/user/downloads`
            -   Within this example the download client places its
                downloads into `/downloads` and therefore tells Lidarr
                when its complete that the finished song is in
                `/downloads`. Lidarr then comes along and says \"Okay,
                cool, let me check in `/downloads`\" Well, inside Lidarr
                you did not allocate a `/downloads` path you allocated a
                `/data` path so it throws this error.
            -   The easiest fix for this is **CONSISTENCY** if you use
                one scheme in your download client, use it across the
                board.
            -   Team Lidarr is a big fan of simply using `/data`.
                -   Download client: `/data:/mnt/user/data`
                -   Lidarr: `/data:/mnt/user/data`
                -   Now within the download client you can specify where
                    in `/data` you\'d like to place your downloads, now
                    this varies depending on the client but you should
                    be able to tell it \"Yeah download client place my
                    files into.\" `/data/torrents (or usenet)/audio` and
                    since you used `/data` in Lidarr when the download
                    client tells Lidarr it\'s done Lidarr will come
                    along and say \"Sweet, I have a `/data` and I also
                    can see `/torrents (or usenet)/audio` all is right
                    in the world.\"
        -   There are many great write ups by some very talented people
            one on our wiki [Docker Guide](Docker_Guide "wikilink") and
            the other by TRaSH with his [How To Set Up Hardlinks and
            Atomic-Moves](https://trash-guides.info/Misc/how-to-set-up-hardlinks-and-atomic-moves/)
            Now these guides place heavy emphasis on Hardlinks and
            Atomic moves, but the general concept of containers and how
            path mapping works is the core of these discussions.

<!-- -->

-   <span id="downloads_in_root_folder">**[Downloading into Root
    Folder](#downloads_in_root_folder "wikilink")**</span>
    -   Within the application, a root folder is defined as the
        configured media library folder. You\'re downloading directly
        into your root (library) folder. This frequently causes issues
        and is not advised. To fix this change your download client so
        it is not placing downloads within your root folder. Please note
        that this check looks at all [defined/configured root
        folders](Lidarr_Settings#Root_Folders "wikilink") added not only
        root folders currently in use.

<!-- -->

-   \<span id=\"bad\_download\_client\_settings\>**[Bad Download Client
    Settings](#bad_download_client_settings "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map.

<!-- -->

-   <span id="bad_remote_path_mapping">**[Bad Remote Path
    Mapping](#bad_remote_path_mapping "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map. [See TRaSH\'s Remote
        Path Guide for more information. The link is for Radarr, but the
        same concept
        applies.](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/)

<!-- -->

-   <span id="permissions_error">**[Permissions
    Error](#permissions_error "wikilink")**</span>
    -   Lidarr or the user lidarr is running as cannot access the
        location your download client is downloading files to. This is
        typically a permission issue.

<!-- -->

-   <span id="remote_path_file_removed">**[Remote File was removed part
    way through
    processing](#remote_path_file_removed "wikilink")**</span>
    -   A file accessible via a remote path map appears to have been
        removed prior to processing completing.

<!-- -->

-   <span id="remote_path_import_failed">**[Remote Path is Used and
    Import Failed](#remote_path_import_failed "wikilink")**</span>
    -   Check your logs for more info; Refer to our Troubleshooting
        Guides

<section end=lidarr_system_status_health_download_clients />

##### Readarr

<section begin=readarr_system_status_health_download_clients />

-   <span id="no_download_client_is_available">**[No download client is
    available](#no_download_client_is_available "wikilink")**</span>
    -   A properly configured and enabled download client is required
        for Readarr to be able to download media. Since Readarr supports
        different download clients, you should determine which best
        matches your requirements. If you already have a download client
        installed, you should configure Lidarr to use it and create a
        category. See Settings -\> Download Client.

<!-- -->

-   <span id="unable_to_communicate_with_download_client">**[Unable to
    communicate with download
    client](#unable_to_communicate_with_download_client "wikilink")**</span>
    -   Readarr was unable to communicate with the configured download
        client. Please verify if the download client is operational and
        double check the url. This could also indicate an authentication
        error.
    -   This is typically due to improperly configured download client.
        Things you can typically check:
        -   Your download clients IP Address if its on the same bare
            metal machine this is typically `127.0.0.1`
        -   The Port number of that your download client is using these
            are filled out with the default port number but if you\'ve
            changed it you\'ll need to have the same one entered into
            Readarr.
        -   Ensure SSL encryption is not turned on if you\'re using both
            your Readarr instance and your download client on a local
            network. See [the SSL FAQ
            entry](Readarr_FAQ#Invalid_Certificate_and_other_HTTPS_or_SSL_issues "wikilink")
            for more information.

<!-- -->

-   <span id="download_clients_are_unavailable_due_to_failures">**[Download
    clients are unavailable due to
    failure](#download_clients_are_unavailable_due_to_failures "wikilink")**</span>
    -   One or more of your download clients is not responding to
        requests made by Readarr. Therefore Readarr has decided to
        temporarily stop querying the download client on it's normal 1
        minute cycle, which is normally used to track active downloads
        and import finished ones. However, Readarr will continue to
        attempt to send downloads to the client, but will in all
        likeliness fail.
    -   You should inspect System-\>Logs to see what the reason is for
        the failures.
    -   If you no longer use this download client, disable it in Readarr
        to prevent the errors.

<!-- -->

-   <span id="enable_complete_download_handling">**[Enable Completed
    Download
    Handling](#enable_complete_download_handling "wikilink")**</span>
    -   Readarr requires Completed Download Handling to be able to
        import files that were downloaded by the download client. It is
        recommended to enable Completed Download Handling.
    -   *(Completed Download Handling is enabled by default for new
        users.)*

<!-- -->

-   <span id="docker_bad_remote_path_mapping">**[Docker bad remote path
    mapping](#docker_bad_remote_path_mapping "wikilink")**</span>
    -   This error is typically associated with bad docker paths within
        either your download client or Readarr
        -   An example of this would be:
            -   Download client:
                `Download Path: /downloads:/mnt/user/downloads`
            -   Readarr: `Download Path: /data:/mnt/user/downloads`
            -   Within this example the download client places its
                downloads into `/downloads` and therefore tells Radarr
                when its complete that the finished book is in
                `/downloads`. Readarr then comes along and says \"Okay,
                cool, let me check in `/downloads`\" Well, inside
                Readarr you did not allocate a `/downloads` path you
                allocated a `/data` path so it throws this error.
            -   The easiest fix for this is **CONSISTENCY** if you use
                one scheme in your download client, use it across the
                board.
            -   Team Readarr is a big fan of simply using `/data`.
                -   Download client: `/data:/mnt/user/data`
                -   Readarr: `/data:/mnt/user/data`
                -   Now within the download client you can specify where
                    in `/data` you\'d like to place your downloads, now
                    this varies depending on the client but you should
                    be able to tell it \"Yeah download client place my
                    files into.\" `/data/torrents (or usenet)/books` and
                    since you used `/data` in Readarr when the download
                    client tells Readarr it\'s done Readarr will come
                    along and say \"Sweet, I have a `/data` and I also
                    can see `/torrents (or usenet)/books` all is right
                    in the world.\"
        -   There are many great write ups by some very talented people
            one on our wiki [Docker Guide](Docker_Guide "wikilink") and
            the other by TRaSH with his [How To Set Up Hardlinks and
            Atomic-Moves](https://trash-guides.info/Misc/how-to-set-up-hardlinks-and-atomic-moves/)
            Now these guides place heavy emphasis on Hardlinks and
            Atomic moves, but the general concept of containers and how
            path mapping works is the core of these discussions.

<!-- -->

-   <span id="downloads_in_root_folder">**[Downloading into Root
    Folder](#downloads_in_root_folder "wikilink")**</span>
    -   Within the application, a root folder is defined as the
        configured media library folder. You\'re downloading directly
        into your root (library) folder. This frequently causes issues
        and is not advised. To fix this change your download client so
        it is not placing downloads within your root folder. Please note
        that this check looks at all [defined/configured root
        folders](Readarr_Settings#Root_Folders "wikilink") added not
        only root folders currently in use.

<!-- -->

-   \<span id=\"bad\_download\_client\_settings\>**[Bad Download Client
    Settings](#bad_download_client_settings "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map.

<!-- -->

-   <span id="bad_remote_path_mapping">**[Bad Remote Path
    Mapping](#bad_remote_path_mapping "wikilink")**</span>
    -   The location your download client is downloading files to is
        causing problems. Check the logs for further information. This
        may be permissions or attempting to go from windows to linux or
        linux to windows without a remote path map. [See TRaSH\'s Remote
        Path Guide for more information. The link is for Radarr, but the
        same concept
        applies.](https://trash-guides.info/Radarr/V3/Radarr-remote-path-mapping/)

<!-- -->

-   <span id="permissions_error">**[Permissions
    Error](#permissions_error "wikilink")**</span>
    -   Readarr or the user readarr is running as cannot access the
        location your download client is downloading files to. This is
        typically a permission issue.

<!-- -->

-   <span id="remote_path_file_removed">**[Remote File was removed part
    way through
    processing](#remote_path_file_removed "wikilink")**</span>
    -   A file accessible via a remote path map appears to have been
        removed prior to processing completing.

<!-- -->

-   <span id="remote_path_import_failed">**[Remote Path is Used and
    Import Failed](#remote_path_import_failed "wikilink")**</span>
    -   Check your logs for more info; Refer to our Troubleshooting
        Guides

<section end=readarr_system_status_health_download_clients />

#### Completed/Failed Download Handling

##### Radarr

<section begin=radarr_system_status_health_complete_failed_download_handling />

-   <span id="completed_download_handling_is_disabled">**[Completed
    Download Handling is
    disabled](#completed_download_handling_is_disabled "wikilink")**</span>
    -   *(This warning is only generated for existing users before when
        the Completed Download Handling feature was implemented. This
        feature is disabled by default to ensure the system continued to
        operate as expected for current configurations.)*
    -   It's recommended to use Completed Download Handling since it
        provides better compatibility for the unpacking and
        post-processing logic of various download clients. With it,
        Radarr will only import a download once the download client
        reports it as ready.
    -   If you wish to enable Completed Download Handling you should
        verify the following: \* **Warning**: Completed Download
        Handling only works properly if the download client and Radarr
        are on the same machine since it gets the path to be imported
        directly from the download client otherwise a remote map is
        needed.

<section end=radarr_system_status_health_complete_failed_download_handling />

##### Sonarr

<section begin=sonarr_system_status_health_complete_failed_download_handling />

-   <span id="completed_download_handling_is_disabled">**[Completed
    Download Handling is
    disabled](#completed_download_handling_is_disabled "wikilink")**</span>
    -   *(This warning is only generated for existing users before when
        the Completed Download Handling feature was implemented. This
        feature is disabled by default to ensure the system continued to
        operate as expected for current configurations.)*
    -   It's recommended to use Completed Download Handling since it
        provides better compatibility for the unpacking and
        post-processing logic of various download clients. With it,
        Sonarr will only import a download once the download client
        reports it as ready.
    -   If you wish to enable Completed Download Handling you should
        verify the following: \* **Warning**: Completed Download
        Handling only works properly if the download client and Sonarr
        are on the same machine since it gets the path to be imported
        directly from the

<section end=sonarr_system_status_health_complete_failed_download_handling />

##### Lidarr

<section begin=lidarr_system_status_health_complete_failed_download_handling />

-   <span id="completed_download_handling_is_disabled">**[Completed
    Download Handling is
    disabled](#completed_download_handling_is_disabled "wikilink")**</span>
    -   *(This warning is only generated for existing users before when
        the Completed Download Handling feature was implemented. This
        feature is disabled by default to ensure the system continued to
        operate as expected for current configurations.)*
    -   It's recommended to use Completed Download Handling since it
        provides better compatibility for the unpacking and
        post-processing logic of various download clients. With it,
        Lidarr will only import a download once the download client
        reports it as ready.
    -   If you wish to enable Completed Download Handling you should
        verify the following: \* **Warning**: Completed Download
        Handling only works properly if the download client and Lidrr
        are on the same machine since it gets the path to be imported
        directly from the download client otherwise a remote map is
        needed.

<section end=lidarr_system_status_health_complete_failed_download_handling />

##### Readarr

<section begin=readarr_system_status_health_complete_failed_download_handling />

-   <span id="completed_download_handling_is_disabled">**[Completed
    Download Handling is
    disabled](#completed_download_handling_is_disabled "wikilink")**</span>
    -   *(This warning is only generated for existing users before when
        the Completed Download Handling feature was implemented. This
        feature is disabled by default to ensure the system continued to
        operate as expected for current configurations.)*
    -   It's recommended to use Completed Download Handling since it
        provides better compatibility for the unpacking and
        post-processing logic of various download clients. With it,
        Readarr will only import a download once the download client
        reports it as ready.
    -   If you wish to enable Completed Download Handling you should
        verify the following: \* **Warning**: Completed Download
        Handling only works properly if the download client and Readarr
        are on the same machine since it gets the path to be imported
        directly from the download client otherwise a remote map is
        needed.

<section end=readarr_system_status_health_complete_failed_download_handling />

#### Indexers

##### Radarr

<section begin=radarr_system_status_health_indexers />

-   <span id="no_indexers_available_with_automatic_search_enabled_radarr_will_not_provide_any_automatic_search_results">**[No
    indexers available with automatic search enabled, Radarr will not
    provide any automatic search
    results](#no_indexers_available_with_automatic_search_enabled_radarr_will_not_provide_any_automatic_search_results "wikilink")**</span>
    -   Simply put you do not have any of your indexers set to allow
        automatic searches
        -   Go into Settings \> Indexers, select an indexer you\'d like
            to allow Automatic Searches and then click save.
-   <span id="no_indexers_available_with_rss_sync_enabled_radarr_will_not_grab_new_releases_automatically">**[No
    indexers available with RSS sync enabled, Radarr will not grab new
    releases
    automatically](#no_indexers_available_with_rss_sync_enabled_radarr_will_not_grab_new_releases_automatically "wikilink")**</span>
    -   So Radarr uses the RSS feed to pick up new releases as they come
        along. More info on that
        [here](Radarr_FAQ#How_does_Radarr_work? "wikilink")
    -   To correct this issue go to Settings \> Indexers, select an
        indexer you have and enable RSS Sync
-   <span id="no_indexers_are_enabled">**[No indexers are
    enabled](#no_indexers_are_enabled "wikilink")**</span>
    -   Radarr requires indexers to be able to discover new releases.
        [Please read the wiki on instructions how to add
        indexers](Radarr_Settings#Indexers "wikilink").
-   <span id="enabled_indexers_do_not_support_searching">**[Enabled
    indexers do not support
    searching](#enabled_indexers_do_not_support_searching "wikilink")**
    </span>
    -   None of the indexers you have enabled support searching. This
        means Radarr will only be able to find new releases via the RSS
        feeds. But searching for movies (either Automatic Search or
        Manual Search) will never return any results. Obviously, the
        only way to remedy it is to add another indexer.
-   <span id="no_indexers_available_with_interactive_search_enabled">**[No
    indexers avaiable with Interactive Search
    Enabled\"](#no_indexers_available_with_interactive_search_enabled "wikilink")**
    </span>
    -   None of the indexers you have enabled support interactive
        searching. This means the application will only be able to find
        new releases via the RSS feeds or an automatic search.
-   <span id="indexers_are_unavailable_due_to_failures">**[Indexers are
    unavailable due to
    failures](#indexers_are_unavailable_due_to_failures "wikilink")**</span>
    -   Errors occurs while Radarr tried to use one of your indexers. To
        limit retries, Radarr will not use the indexer for an increasing
        amount of time (up to 24h).
    -   This mechanism is triggered if Radarr was unable to get a
        response from the indexer (could be dns, connection,
        authentication or indexer issue), or unable to fetch the
        nzb/torrent file from the indexer. Please inspect the logs to
        determine what kind of error causes the problem.
    -   You can prevent the warning by disabling the affected indexer.
    -   Run the Test on the indexer to force Radarr to recheck the
        indexer, please note that the Health Check warning will not
        always disappear immediately.

<section end=radarr_system_status_health_indexers />

##### Sonarr

<section begin=sonarr_system_status_health_indexers />

-   <span id="no_indexers_available_with_automatic_search_enabled_sonarr_will_not_provide_any_automatic_search_results">**[No
    indexers available with automatic search enabled, Sonarr will not
    provide any automatic search
    results](#no_indexers_available_with_automatic_search_enabled_sonarr_will_not_provide_any_automatic_search_results "wikilink")**</span>
    -   Simply put you do not have any of your indexers set to allow
        automatic searches
        -   Go into Settings \> Indexers, select an indexer you\'d like
            to allow Automatic Searches and then click save.
-   <span id="no_indexers_available_with_rss_sync_enabled_sonarr_will_not_grab_new_releases_automatically">**[No
    indexers available with RSS sync enabled, Sonarr will not grab new
    releases
    automatically](#no_indexers_available_with_rss_sync_enabled_sonarr_will_not_grab_new_releases_automatically "wikilink")**</span>
    -   So Sonarr uses the RSS feed to pick up new releases as they come
        along. More info on that
        [here](Sonarr_FAQ#How_does_Sonarr_work? "wikilink")
    -   To correct this issue go to Settings \> Indexers, select an
        indexer you have and enable RSS Sync
-   <span id="no_indexers_are_enabled">**[No indexers are
    enabled](#no_indexers_are_enabled "wikilink")**</span>
    -   Sonarr requires indexers to be able to discover new releases.
        [Please read the wiki on instructions how to add
        indexers](Sonarr_Settings#Indexers "wikilink").
-   <span id="enabled_indexers_do_not_support_searching">**[Enabled
    indexers do not support
    searching](#enabled_indexers_do_not_support_searching "wikilink")**</span>
    -   None of the indexers you have enabled support searching. This
        means Sonarr will only be able to find new releases via the RSS
        feeds. But searching for episodes (either Automatic Search or
        Manual Search) will never return any results. Obviously, the
        only way to remedy it is to add another indexer.
-   <span id="no_indexers_available_with_interactive_search_enabled">**[No
    indexers avaiable with Interactive Search
    Enabled\"](#no_indexers_available_with_interactive_search_enabled "wikilink")**
    </span>
    -   None of the indexers you have enabled support interactive
        searching. This means the application will only be able to find
        new releases via the RSS feeds or an automatic search.
-   <span id="indexers_are_unavailable_due_to_failures">**[Indexers are
    unavailable due to
    failures](#indexers_are_unavailable_due_to_failures "wikilink")**</span>
    -   Errors occurs while Sonarr tried to use one of your indexers. To
        limit retries, Sonarr will not use the indexer for an increasing
        amount of time (up to 24h).
    -   This mechanism is triggered if Sonarr was unable to get a
        response from the indexer (could be dns, connection,
        authentication or indexer issue), or unable to fetch the
        nzb/torrent file from the indexer. Please inspect the logs to
        determine what kind of error causes the problem.
    -   You can prevent the warning by disabling the affected indexer.
    -   Run the Test on the indexer to force Sonarr to recheck the
        indexer, please note that the Health Check warning will not
        always disappear immediately.

<section end=sonarr_system_status_health_indexers />

##### Lidarr

<section begin=lidarr_system_status_health_indexers />

-   <span id="no_indexers_available_with_automatic_search_enabled_lidarr_will_not_provide_any_automatic_search_results">**[No
    indexers available with automatic search enabled, Lidarr will not
    provide any automatic search
    results](#no_indexers_available_with_automatic_search_enabled_lidarr_will_not_provide_any_automatic_search_results "wikilink")**</span>
    -   Simply put you do not have any of your indexers set to allow
        automatic searches
        -   Go into Settings \> Indexers, select an indexer you\'d like
            to allow Automatic Searches and then click save.
-   <span id="no_indexers_available_with_rss_sync_enabled_lidarr_will_not_grab_new_releases_automatically">**[No
    indexers available with RSS sync enabled, Lidarr will not grab new
    releases
    automatically](#no_indexers_available_with_rss_sync_enabled_lidarr_will_not_grab_new_releases_automatically "wikilink")**</span>
    -   So Lidarr uses the RSS feed to pick up new releases as they come
        along. More info on that
        [here](Lidarr_FAQ#How_does_Lidarr_work? "wikilink")
    -   To correct this issue go to Settings \> Indexers, select an
        indexer you have and enable RSS Sync
-   <span id="no_indexers_are_enabled">**[No indexers are
    enabled](#no_indexers_are_enabled "wikilink")**</span>
    -   Lidarr requires indexers to be able to discover new releases.
        [Please read the wiki on instructions how to add
        indexers](Lidarr_Settings#Indexers "wikilink").
-   <span id="enabled_indexers_do_not_support_searching">**[Enabled
    indexers do not support
    searching](#enabled_indexers_do_not_support_searching "wikilink")**
    </span>
    -   None of the indexers you have enabled support searching. This
        means Lidarr will only be able to find new releases via the RSS
        feeds. But searching for music (either Automatic Search or
        Manual Search) will never return any results. Obviously, the
        only way to remedy it is to add another indexer.
-   <span id="no_indexers_available_with_interactive_search_enabled">**[No
    indexers avaiable with Interactive Search
    Enabled\"](#no_indexers_available_with_interactive_search_enabled "wikilink")**
    </span>
    -   None of the indexers you have enabled support interactive
        searching. This means the application will only be able to find
        new releases via the RSS feeds or an automatic search.
-   <span id="indexers_are_unavailable_due_to_failures">**[Indexers are
    unavailable due to
    failures](#indexers_are_unavailable_due_to_failures "wikilink")**</span>
    -   Errors occurs while Lidarr tried to use one of your indexers. To
        limit retries, Lidarr will not use the indexer for an increasing
        amount of time (up to 24h).
    -   This mechanism is triggered if Lidarr was unable to get a
        response from the indexer (could be dns, connection,
        authentication or indexer issue), or unable to fetch the
        nzb/torrent file from the indexer. Please inspect the logs to
        determine what kind of error causes the problem.
    -   You can prevent the warning by disabling the affected indexer.
    -   Run the Test on the indexer to force Lidarr to recheck the
        indexer, please note that the Health Check warning will not
        always disappear immediately.

<section end=lidarr_system_status_health_indexers />

##### Readarr

<section begin=readarr_system_status_health_indexers />

-   <span id="no_indexers_available_with_automatic_search_enabled_readarr_will_not_provide_any_automatic_search_results">**[No
    indexers available with automatic search enabled, Readarr will not
    provide any automatic search
    results](#no_indexers_available_with_automatic_search_enabled_readarr_will_not_provide_any_automatic_search_results "wikilink")**</span>
    -   Simply put you do not have any of your indexers set to allow
        automatic searches
        -   Go into Settings \> Indexers, select an indexer you\'d like
            to allow Automatic Searches and then click save.
-   <span id="no_indexers_available_with_rss_sync_enabled_readarr_will_not_grab_new_releases_automatically">**[No
    indexers available with RSS sync enabled, Readarr will not grab new
    releases
    automatically](#no_indexers_available_with_rss_sync_enabled_readarr_will_not_grab_new_releases_automatically "wikilink")**</span>
    -   So Readarr uses the RSS feed to pick up new releases as they
        come along. More info on that
        [here](Readarr_FAQ#How_does_Readarr_work? "wikilink")
    -   To correct this issue go to Settings \> Indexers, select an
        indexer you have and enable RSS Sync
-   <span id="no_indexers_are_enabled">**[No indexers are
    enabled](#no_indexers_are_enabled "wikilink")**</span>
    -   Readarr requires indexers to be able to discover new releases.
        [Please read the wiki on instructions how to add
        indexers.](Readarr_Settings#Indexers "wikilink")
-   <span id="enabled_indexers_do_not_support_searching">**[Enabled
    indexers do not support
    searching](#enabled_indexers_do_not_support_searching "wikilink")**
    </span>
    -   None of the indexers you have enabled support searching. This
        means Readarr will only be able to find new releases via the RSS
        feeds. But searching for books (either Automatic Search or
        Manual Search) will never return any results. Obviously, the
        only way to remedy it is to add another indexer.
-   <span id="no_indexers_available_with_interactive_search_enabled">**[No
    indexers avaiable with Interactive Search
    Enabled\"](#no_indexers_available_with_interactive_search_enabled "wikilink")**
    </span>
    -   None of the indexers you have enabled support interactive
        searching. This means the application will only be able to find
        new releases via the RSS feeds or an automatic search.
-   <span id="indexers_are_unavailable_due_to_failures">**[Indexers are
    unavailable due to
    failures](#indexers_are_unavailable_due_to_failures "wikilink")**</span>
    -   Errors occurs while Readarr tried to use one of your indexers.
        To limit retries, Readarr will not use the indexer for an
        increasing amount of time (up to 24h).
    -   This mechanism is triggered if Readarr was unable to get a
        response from the indexer (could be dns, connection,
        authentication or indexer issue), or unable to fetch the
        nzb/torrent file from the indexer. Please inspect the logs to
        determine what kind of error causes the problem.
    -   You can prevent the warning by disabling the affected indexer.
    -   Run the Test on the indexer to force Readarr to recheck the
        indexer, please note that the Health Check warning will not
        always disappear immediately.

<section end=readarr_system_status_health_indexers />

#### Folders

##### Radarr

<section begin=radarr_system_status_health_folders />

-   <span id="missing_root_folder">**[Missing root
    folder](#missing_root_folder "wikilink")**</span>
    -   This error is typically identified if a Movie is looking for a
        root folder but that root folder is no longer available.
        -   If you would like to remove this warning simply find the
            movie that is still using the old root folder and edit it to
            the correct root Folder
            1.  Easiest way to find this is to go to the Movies
                (Library) Tab
            2.  Create a custom filter with the old root folder path
            3.  Select mass edit on the top bar and from the **Root
                Paths** drop down select the new root path that you want
                these movies to be moved to.
            4.  Next you\'ll receive a pop-up that states **Would you
                like to move the movie folders to \'<root path>\' ?**
                This will also state **This will also rename the movie
                folder per the movie folder format in settings.** Simply
                select No if the you do not want Radarr to move your
                files

<section end=radarr_system_status_health_folders />

##### Sonarr

<section begin=sonarr_system_status_health_folders />

-   <span id="missing_root_folder">**[Missing root
    folder](#missing_root_folder "wikilink")**</span>
    -   This error is typically identified if a series is looking for a
        root folder but that root folder is no longer available.
        -   If you would like to remove this warning simply find the
            series that is still using the old root folder and edit it
            to the correct root folder
            1.  Go to the Series \> Mass Editor Tab
            2.  Create a custom filter with the old root folder path
            3.  Once the series have been found find the **Root Paths**
                drop down and select the new root path that you want
                these series to be moved to.
            4.  Next you\'ll receive a pop-up that states **Would you
                like to move the series folders to \'<root path>\'?**
                Simply select No if the you do not want Sonarr to move
                your files
-   <span id="import_list_missing_root_folder">**[Import List missing
    root folder](#import_list_missing_root_folder "wikilink")**</span>
    -   This error is typically identified if a list is looking for a
        root folder but that root folder is no longer available.
        1.  Go to Settings \> Import Lists
        2.  Edit the import lists that were mentioned in the health
            check
        3.  Save

<section end=sonarr_system_status_health_folders />

##### Lidarr

<section begin=lidarr_system_status_health_folders />

-   <span id="missing_root_folder">**[Missing root
    folder](#missing_root_folder "wikilink")**</span>
    -   This error is typically identified if an artist is looking for a
        root folder but that root folder is no longer available.
        -   If you would like to remove this warning simply find the
            artist that is still using the old root folder and edit it
            to the correct root folder
            1.  Go to the Library \> Mass Editor Tab
            2.  Create a custom filter with the old root folder path
            3.  Once the series have been found find the **Root Paths**
                drop down and select the new root path that you want
                these artists to be moved to.
            4.  Next you\'ll receive a pop-up that states **Would you
                like to move the artist folders to \'<root path>\'?**
                Simply select No if the you do not want Lidarr to move
                your files

<section end=lidarr_system_status_health_folders />

##### Readarr

<section begin=readarr_system_status_health_folders />

-   <span id="missing_root_folder">**[Missing root
    folder](#missing_root_folder "wikilink")**</span>
    -   This error is typically identified if an author is looking for a
        root folder but that root folder is no longer available.
        -   If you would like to remove this warning simply find the
            author that is still using the old root folder and edit it
            to the correct root folder
            1.  Go to the Library \> Mass Editor Tab
            2.  Create a custom filter with the old root folder path
            3.  Once the series have been found find the **Root Paths**
                drop down and select the new root path that you want
                these authors to be moved to.
            4.  Next you\'ll receive a pop-up that states **Would you
                like to move the author folders to \'<root path>\'?**
                Simply select No if the you do not want Readarr to move
                your files

<section end=readarr_system_status_health_folders />

#### Media

##### Radarr

<section begin=radarr_system_status_health_media />

-   <span id="movie_was_removed_from_tmdb">**[Movie was removed from
    TMDb](#movie_was_removed_from_tmdb "wikilink")**</span>
    -   The movie is linked to a TMDb Id that was deleted from TMDb,
        usually because it was a duplicate, wasn\'t a movie or changed
        ID for some other reason. Deleted movies will not receive any
        updates and should be corrected by the user to ensure continued
        functionality. Remove the movie from Radarr without deleting the
        files, then try to re-add it. If it doesn\'t show up in a
        search, check Radarr because it might be a TV miniseries like
        Stephen King\'s It.\
    -   You can find and edit deleted movies by creating a custom filter
        using the following steps: 1. Click Movies from the left menu 2.
        Click the dropdown on Filter and select "Custom Filter" 3. Enter
        a label, for example "Deleted Movies" 4. Make the filter as
        follows: Status is Deleted 5. Click save and select the newly
        created filter from the filter dropdown menu

<!-- -->

-   <span id="lists_are_unavailable_due_to_failures">**[Lists are
    unavailable due to
    failures](#lists_are_unavailable_due_to_failures "wikilink")**</span>
    -   Typically this simply means that Radarr is no longer able to
        communicate via API or via logging in to your chosen list
        provider. Your best bet if the problem persists is to contact
        them in order to rule them out, as their systems maybe
        overloaded from time to time.

<section end=radarr_system_status_health_media />

##### Sonarr

<section begin=sonarr_system_status_health_media />

-   <span id="series_removed_from_thetvdb">**[Series Removed from
    TheTVDB](#series_removed_from_thetvdb "wikilink")**</span>
    -   The affected series were removed from TheTVDB, this usually
        happens because it is a duplicate or considered part of a
        different series. To correct you will need to remove the
        affected series and add the correct series.

<section end=sonarr_system_status_health_media />

##### Lidarr

<section begin=lidarr_system_status_health_media />

Text

<section end=lidarr_system_status_health_media />

##### Readarr

<section begin=readarr_system_status_health_media />

Text

<section end=readarr_system_status_health_media />

### Disk Space

#### Radarr

<section begin=radarr_system_status_disk_space />

-   This section will show you available disk space
    -   In docker this can be tricky as it will typically show you the
        available space within your Docker image

<section end=radarr_system_status_disk_space />

#### Sonarr

<section begin=sonarr_system_status_disk_space />

-   This section will show you available disk space
    -   In docker this can be tricky as it will typically show you the
        available space within your Docker image

<section end=sonarr_system_status_disk_space />

#### Lidarr

<section begin=lidarr_system_status_disk_space />

-   This section will show you available disk space
    -   In docker this can be tricky as it will typically show you the
        available space within your Docker image

<section end=lidarr_system_status_disk_space />

#### Readarr

<section begin=readarr_system_status_disk_space />

-   This section will show you available disk space
    -   In docker this can be tricky as it will typically show you the
        available space within your Docker image

<section end=readarr_system_status_disk_space />

### About

#### Radarr

<section begin=radarr_system_status_about />

This will tell you about your current install of Radarr

<section end=radarr_system_status_about />

#### Sonarr

<section begin=sonarr_system_status_about />

This will tell you about your current install of Radarr

<section end=sonarr_system_status_about />

#### Lidarr

<section begin=lidarr_system_status_about />

This will tell you about your current install of Lidarr

<section end=lidarr_system_status_about />

#### Readarr

<section begin=readarr_system_status_about />

This will tell you about your current install of Readarr

<section end=readarr_system_status_about />

### More Info

#### Radarr

<section begin=radarr_system_status_more_info />

-   Home Page: [Radarr\'s home page](https://radarr.video)
-   Wiki: [You\'re here already](https://wiki.servarr.com/Radarr)
-   Reddit: [r/radarr](https://reddit.com/r/radarr)
-   Discord: [Join our discord](https://radarr.video/discord)
-   Donations: If you\'re feeling generous and would like to donate
    [click here](https://opencollective.com/radarr)
-   Donations to Sonarr: If you\'re feeling generous and would like to
    donate to the project that started it all [click
    here](https://sonarr.tv/donate)
-   Source: [Github](https://github.com/Radarr/Radarr)
-   Feature Requests: Got a great idea drop it
    [here](https://github.com/Radarr/Radarr/issues)

<section end=radarr_system_status_more_info />

#### Sonarr

<section begin=sonarr_system_status_more_info />

-   Home page: [Sonarr\'s home page](https://sonarr.tv)
-   Forums: [Sonarr Forums](https://forums.sonarr.tv)
-   Discord: [Join our discord](https://discord.gg/M6BvZn5)
-   Reddit: [r/sonarr](https://reddit.com/r/sonarr)
-   Twitter: [\@sonarrtv](https://twitter.com/sonarrtv)
-   IRC: [\#sonarr on
    Freenode](https://webchat.freenode.net/?channels=#sonarr)
-   Wiki: [You\'re here already](https://wiki.servarr.com/sonarr)
-   Donations: If you\'re feeling generous and would like to donate
    [click here](https://sonarr.tv/donate)
-   Source: <https://github.com/Sonarr/Sonarr> Github\]
-   Feature Requests: Got a great idea drop it on Github
    [here](https://github.com/Sonarr/Sonarr/issues)

<section end=sonarr_system_status_more_info />

#### Lidarr

<section begin=lidarr_system_status_more_info />

-   Home page: [Lidarr\'s home page](https://lidarr.audio)
-   Wiki: [You\'re here already](https://wiki.servarr.com/Lidarr)
-   Reddit: [r/lidarr](https://reddit.com/r/lidarr)
-   Discord: [Join our discord](https://lidarr.audio/discord)
-   Donations: If you\'re feeling generous and would like to donate
    [click here](https://opencollective.com/lidarr)
-   Donations to Sonarr: If you\'re feeling generous and would like to
    donate to the project that started it all [click
    here](https://sonarr.tv/donate)
-   Source: [Github](https://github.com/lidarr/Lidarr/)
-   Feature Requests: Got a great idea drop it on GitHub
    [here](https://github.com/Lidarr/Lidarr/issues)

<section end=lidarr_system_status_more_info />

#### Readarr

<section begin=readarr_system_status_more_info />

-   Home page: [Readarr\'s home page](https://readarr.com)
-   Wiki: [You\'re here already](https://wiki.servarr.com/Readarr)
-   Reddit: [r/readarr](https://reddit.com/r/readarr)
-   Discord: [Join our discord](https://readarr.com/discord)
-   Donations: If you\'re feeling generous and would like to donate
    click [here](https://opencollective.com/readarr)
-   Donations to Sonarr: If you\'re feeling generous and would like to
    donate to the project that started it all [click
    here](https://sonarr.tv/donate)
-   Source: [Github](https://github.com/Readarr/Readarr)
-   Feature Requests: Got a great idea drop it [click
    here](https://github.com/Readarr/Readarr/issues)

<section end=readarr_system_status_more_info />

### Templates
