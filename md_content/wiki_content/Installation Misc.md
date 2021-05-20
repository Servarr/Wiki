Installation
------------

### Radarr

#### OSX

<section begin=radarr_osx_installation />

Detailed instructions coming \"soon\" For now please see our website for
details: <https://radarr.video/#downloads-v3-macos>

<section end=radarr_osx_installation />
<section begin=radarr_linux_installation />

#### Debian/Ubuntu

##### .NET Core Install

You\'ll need curl, mediainfo, and sqlite.
`sudo apt install curl mediainfo sqlite3`

###### Manual Install

Note: this assumes you created a user named `radarr`

![Example of Radarr download
options](ARR_Download_Link_Example.png "fig:Example of Radarr download options")
In the example screenshot here, you can see multiple options. Choose the
option that matches your OS and processor best. For most users, this
would be `.linux-core-x64.tar.gz` selected via `arch=x64` in the url.

For:

-   ARM use `arch=arm`
-   ARM64 use `arch=arm64`

Download this file onto your system: (Note: The link below will target
the Linux .NET Core x64 file. Replace if needed with the file you chose
previously)

` wget --content-disposition '`[`http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64`](http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64)`'`

-   Alternatively: Go to the Radarr download page, and pick the
    appropriate file: <https://github.com/Radarr/Radarr/releases>

Uncompress:

`tar -xvzf Radarr*.linux*.tar.gz`

Move to your preferred install location (typically `/opt/Radarr/`

`sudo mv Radarr/ /opt`

Finally, make sure you grant the needed permission to your install
directory:

`sudo chown radarr:radarr /opt/Radarr`

You can start Radarr with the following command:

`/opt/Radarr/Radarr -nobrowser`

<section end=radarr_linux_installation />

### Sonarr

#### OSX

<section begin=sonarr_osx_installation />

1.  After downloading Sonarr V3 from
    [here](https://services.sonarr.tv/v1/download/phantom-develop/latest?version=3&os=macos&installer=true).
    The `zip` file will be located in your downloads directory.
2.  After the download has finished you\'ll need to unzip the file from
    there you\'ll have a **Sonarr.app** in your downloads folder simply
    move the **Sonarr.app** to your Applications directory.

![](Move-sonarr-to-applications.gif "Move-sonarr-to-applications.gif"){width="750"
height="750"}

<li>

From there if you go to your launch pad you\'ll notice that Sonarr is
now in there, double click on Sonarr

</li>
<li>

You\'ll probably get a pop up that says \"Sonarr.app\" cannot be opened
because the developer cannot be verified.

</li>

![](sonarr-developer-cannot-be-verified.png "sonarr-developer-cannot-be-verified.png"){width="250"}

<li>

Don\'t fret we can get this fixed.

</li>

1.  Click on System Preferences in your dock
2.  Click Security and Privacy
3.  Click **Open Anyways**
4.  You\'ll get a pop up that looks something like this:

![framless\|250px](sonarr-developer-cannot-be-verified2.png "framless|250px")

<li>

Click Open

</li>
</ol>
<li>

Now since Sonarr uses the Mono Framework Version 5.20 or later if you do
not already have that installed you\'ll receive a pop up like this

</li>

![](sonarr-cannot-launch-sonarr-mono.png "sonarr-cannot-launch-sonarr-mono.png"){width="250"}

-   Note: If Mono is already installed skip these steps

1.  Click Download
2.  Safari (or default browser) will now open up to [the Mono
    Project](https://www.mono-project.com/download/stable/#download-mac)
    for macOS. Click **Download mono (Stable channel)**
3.  Once the download is complete go to your downloads folder and click
    the new pkg file that was downloaded and install it
4.  After installation is complete go back and reopen Sonarr

<li>

Now browse to [`http://localhost:8989`](http://localhost:8989)

</li>
</ol>

Now you\'re all set Sonarr is now up and running on your system.

<section end=sonarr_osx_installation />
<section begin=sonarr_linux_installation />

#### Debian/Ubuntu

[Please see our website](https://sonarr.tv/#downloads-v3-linux-ubuntu)

Manual installs methods are unsupported and you\'ll need to determine
the process yourself.

<section end="sonarr_linux_installation" />

### Lidarr

#### OSX

<section begin=lidarr_osx_installation />

Detailed instructions coming \"soon\" For now please see our website for
details: <https://lidarr.audio/#downloads-v1-macos>

<section end=lidarr_osx_installation />
<section begin=lidarr_linux_installation />

#### Debian/Ubuntu

##### .NET Core Install

You\'ll need curl, mediainfo, chromaprint, and sqlite.
`sudo apt install curl mediainfo sqlite3 libchromaprint-tools`

###### Manual Install

Note: this assumes you created a user named `lidarr`

![Example of Lidarr download
options](ARR_Download_Link_Example.png "fig:Example of Lidarr download options")
In the example screenshot here, you can see multiple options. Choose the
option that matches your OS and processor best. For most users, this
would be `.linux-core-x64.tar.gz` selected via `arch=x64` in the url.

For:

-   ARM use `arch=arm`
-   ARM64 use `arch=arm64`

Download this file onto your system: (Note: The link below will target
the Linux .NET Core x64 file. Replace if needed with the file you chose
previously)

` wget --content-disposition '`[`http://lidarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64`](http://lidarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64)`'`

-   Alternatively: Go to the Lidarr download page, and pick the
    appropriate file: <https://github.com/Lidarr/Lidarr/releases>

Uncompress:

`tar -xvzf Lidarr*.linux*.tar.gz`

Move to your preferred install location (typically `/opt/Lidarr/`

`sudo mv Lidarr/ /opt`

Finally, make sure you grant the needed permission to your install
directory:

`sudo chown lidarr:lidarr /opt/Lidarr`

You can start Lidarr with the following command:

`/opt/Lidarr/Lidarr -nobrowser -data=path/to/app/data`

<section end=lidarr_linux_installation />

### Readarr

#### OSX

<section begin=readarr_osx_installation />

Readarr is in a pre-alpha state. Instructions will be built once Readarr
is stable (i.e. alpha).

<section end=readarr_osx_installation />

#### Linux

<section begin=readarr_linux_installation />

#### Debian/Ubuntu

##### .NET Core Install

You\'ll need curl and sqlite. `sudo apt install curl sqlite3`

###### Manual Install

Go to the Readarr discord and locate the binaries

Note: this assumes you created a user named `readarr`

Download this file onto your system:

` wget --content-disposition '{Readarr is pre-alpha; link hidden from the public}'`

Uncompress:

`tar -xvzf Readarr*.linux-core-x64.tar.gz`

Move to your preferred install location (typically `/opt/Readarr/`

`sudo mv Readarr/ /opt`

Finally, make sure you grant the needed permission to your install
directory:

`sudo chown readarr:readarr /opt/Readarr`

You can start Readarr with the following command:

`/opt/Readarr/Readarr -nobrowser`

<section end=readarr_linux_ubuntu_NetCore_manual_installation />

### Prowlarr

#### OSX

<section begin=prowlarr_osx_installation />

Detailed instructions coming \"soon\" For now please see our website for
details: <https://prowlarr.com/#downloads-v3-macos>

<section end=prowlarr_osx_installation />
<section begin=prowlarr_linux_installation />

#### Debian/Ubuntu

##### .NET Core Install

You\'ll need curl and sqlite. `sudo apt install curl sqlite3`

###### Manual Install

Note: this assumes you created a user named `prowlarr`

Download this file onto your system:

` wget --content-disposition '{Prowlarr is pre-alpha; link hidden from the public}'`

Uncompress:

`tar -xvzf Prowlarr*.linux*.tar.gz`

Move to your preferred install location (typically `/opt/Prowlarr/`

`sudo mv Prowlarr/ /opt`

Finally, make sure you grant the needed permission to your install
directory:

`sudo chown prowlarr:prowlarr /opt/Prowlarr`

You can start Prowlarr with the following command:

`/opt/Prowlarr/Prowlarr -nobrowser`

<section end=prowlarr_linux_installation />

Code Blocks
-----------

### Radarr

#### Preparing the Unit Service File

<section begin=radarr_installation_unit_service_file />

`[Unit]`\
`Description=Radarr Daemon`\
`After=syslog.target network.target`\
\
`[Service]`\
`# Change the user and group variables here.`\
`User=radarr`\
`Group=radarr`\
\
`Type=simple`\
`#Update the data path`\
`ExecStart=/opt/Radarr/Radarr -nobrowser -data=/path/to/appdata/for/Radarr/`\
\
`TimeoutStopSec=20`\
`KillMode=process`\
`Restart=always`\
\
`[Install]`\
`WantedBy=multi-user.target`

<section end=radarr_installation_unit_service_file />

### Sonarr

#### Preparing the Unit Service File

<section begin=sonarr_installation_unit_service_file />

Manual installs methods are unsupported and you\'ll need to determine
the process yourself.

<section end=sonarr_installation_unit_service_file />

### Lidarr

#### Preparing the Unit Service File

<section begin=lidarr_installation_unit_service_file />

`[Unit]`\
`Description=Lidarr Daemon`\
`After=syslog.target network.target`\
\
`[Service]`\
`# Change the user and group variables here.`\
`User=lidarr`\
`Group=lidarr`\
\
`Type=simple`\
\
`# NetCore install:`\
`# Update the data path`\
`ExecStart=/opt/Lidarr/Lidarr -nobrowser -data=/path/to/appdata/for/Lidarr/`\
\
`TimeoutStopSec=20`\
`KillMode=process`\
`Restart=always`\
\
`[Install]`\
`WantedBy=multi-user.target`

<section end=lidarr_installation_unit_service_file />

### Readarr

#### Preparing the Unit Service File

<section begin=readarr_installation_unit_service_file />

`[Unit]`\
`Description=Readarr Daemon`\
`After=syslog.target network.target`\
\
`[Service]`\
`# Change the user and group variables here.`\
`User=readarr`\
`Group=readarr`\
\
`Type=simple`\
\
`# NetCore install:`\
`# Update the data path`\
`ExecStart=/opt/Readarr/Readarr -nobrowser -data=/path/to/appdata/for/Readarr/`\
\
`TimeoutStopSec=20`\
`KillMode=process`\
`Restart=always`\
\
`[Install]`\
`WantedBy=multi-user.target`

<section end=readarr_installation_unit_service_file />

### Prowlarr

#### Preparing the Unit Service File

<section begin=prowlarr_installation_unit_service_file />

`[Unit]`\
`Description=Prowlarr Daemon`\
`After=syslog.target network.target`\
\
`[Service]`\
`# Change the user and group variables here.`\
`User=prowlarr`\
`Group=prowlarr`\
\
`Type=simple`\
`#Update the data path`\
`ExecStart=/opt/Prowlarr/Prowlarr -nobrowser -data=/path/to/appdata/for/Prowlarr/`\
\
`TimeoutStopSec=20`\
`KillMode=process`\
`Restart=always`\
\
`[Install]`\
`WantedBy=multi-user.target`

<section end=prowlarr_installation_unit_service_file />
