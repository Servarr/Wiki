---
title: Radarr Installation
description: 
published: true
date: 2021-10-18T11:18:09.134Z
tags: 
editor: markdown
dateCreated: 2021-05-17T01:14:47.863Z
---

## Windows

Radarr is supported natively on Windows. Radarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Radarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You will likely have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Radarr\config.xml` is denied -- or you use mapped network drives. This gives Radarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Radarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:7878> to start using Radarr

- [Windows x64 Installer](https://radarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://radarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Radarr manually using the [x64 .zip download](https://radarr.servarr.com/v1/update/master/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

## MacOS (OSX)

{#OSX}

> Radarr not compatible with OSX versions < 10.13 (High Sierra) due to netcore incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://radarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Radarr icon to your Application folder.
1. Browse to <http://localhost:7878> to start using Radarr

## Linux

### Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

#### Easy Install

> **The following is a community written and maintained script.** {.is-info}

For the Debian / Ubuntu / Raspian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](/radarr/installation#debian-ubuntu-hands-on-install)  steps further below.**

> Original script author note: For the avoidance of doubt this script is just to help the next person along and improve the Radarr install experience until Radarr eventually when a deb package / Apt Repo is created.
>
> Its target is the beginner/novice with `I know enough to be dangerous` experience.
> If you see any errors or improvements then please update for the next person by amending the wiki and script.

> This will create the user `radarr` and install Radarr to /opt. It will run Radarr as the group `media` You will likely need to modify the group (GUID) in the script to match the common group of your download client and media server to ensure ownership and permissions are sane and all files are accessible.{.is-info}

> This will remove any existing Installations; please ensure you have a backup of your settings using Backup from within Radarr. The script won't delete your settings (application data), but be safe. {.is-danger}

- (Optional) Ensure you have [set a static IP Address](https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/), it'll will make your life easier.
- SSH into your 'Debian (Raspbian / Raspberry Pi OS) / Ubuntu box and become or login as root. SSH in using Putty, mRemoteNG, or any other SSH tool. Note that most tools support saving your connection.
- Once SSHed in type the below to create the installation script in your current director

```bash
nano RadarrInstall.sh
```

- Copy (top right corner of the script) and Paste into your SSH console
  - If you are in an GUI OS such as Windows or MacOS (OSX): pasting could be as simple as 'right clicking' in your ssh client.

```bash
#!/bin/bash
#### Description: Radarr 3.2+ (.NET) Debian install
#### Originally written by: DoctorArr - doctorarr@the-rowlands.co.uk on 2021-10-01 v1.0
#### Version v1.1 2021-10-02 - Bakerboy448 (Made more generic and conformant)
#### Version v1.1.1 2021-10-02 - DoctorArr (Spellcheck and boilerplate update)
#### Version v2.0.0 2021-10-09 - Bakerboy448 (Refactored and ensured script is generic. Added more variables.)
#### Updates by: The Radarr Community
#### Thanks to Bakerboy448 for the guidance and improved wiki entry & script
#### Original author note: For the avoidance of doubt, this script is just to help the next person along and improve the Radarr install experience.
#### Its target is the beginner/novice with 'I know enough to be dangerous' experience.
#### If you see any errors or improvements please update the script for future users.

## Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

## Const
#### Update these variables as required for your specific instance

app="radarr"                        # App Name
app_uid="radarr"                    # {Update me if needed} User App will run as and the owner of it's binaries
app_guid="media"                   # {Update me if needed} Group App will run as.
app_port="7878"                     # Default App Port; Modify config.xml after install if needed
app_prereq="curl mediainfo sqlite3" # Required packages
app_umask="0002"                    # UMask the Service will run as
app_bin=${app^}                     # Binary Name of the app
bindir="/opt/${app^}"               # Install Location
branch="master"                     # {Update me if needed} branch to instal
datadir="/var/lib/radarr/"          # {Update me if needed} AppData directory to use

## Create App user if it doesn't exist

PASSCHK=$(grep -c "$app_uid:" /etc/passwd)
if [ "$PASSCHK" -ge 1 ]; then
    groupadd -f $app_guid
    usermod -a -G $app_uid $app_guid
    echo "User: [$app_uid] seems to exist. Skipping creation, but adding to the group if needed. Ensure the User [$app_uid] and Group [$app_guid] are setup properly.  Specifically the application will need access to your download client and media files."
else
    echo "User: [$app_uid] created with disabled password."
    adduser --disabled-password --gecos "" $app_uid
    groupadd -f $app_guid
    usermod -a -G $app_uid $app_guid
fi
## Stop the App if running

if service --status-all | grep -Fq "$app"; then
    systemctl stop $app
    sytemctl disable $app.service
fi

## Create Appdata Directory

## AppData
mkdir -p $datadir
chown -R $app_uid:$app_uid $datadir
chmod 775 $datadir

## Download and install the App

## prerequisite packages
apt install $app_prereq

ARCH=$(dpkg --print-architecture)
## get arch
dlbase="https://$app.servarr.com/v1/update/$branch/updatefile?os=linux&runtime=netcore"
case "$ARCH" in
"amd64") DLURL="${dlbase}&arch=x64" ;;
"armhf") DLURL="${dlbase}&arch=arm" ;;
"arm64") DLURL="${dlbase}&arch=arm64" ;;
*)
    echo_error "Arch not supported"
    exit 1
    ;;
esac
echo "Downloading..."
wget --content-disposition "$DLURL"
tar -xvzf ${app^}.*.tar.gz
echo "Installation files downloaded and extracted"

## remove existing installs
echo "Removing existing installation"
rm -rf $bindir
echo "Installing..."
mv "${app^}" /opt/
chown $app_uid:$app_uid -R $bindir
rm -rf "${app^}.*.tar.gz"
echo "App Installed"
##Configure Autostart

#Remove any previous app .service
echo "Removing old service file"
rm -rf /etc/systemd/system/$app.service

##Create app .service with correct user startup
echo "Creating service file"
cat << EOF | tee /etc/systemd/system/$app.service >/dev/null
[Unit]
Description=${app^} Daemon
After=syslog.target network.target
[Service]
User=$app_uid
Group=$app_guid
UMask=$app_umask
Type=simple
ExecStart=$bindir/$app_bin -nobrowser -data=$datadir
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

##Start the App
echo "Service file created. Attempting to start the app"
systemctl -q daemon-reload
systemctl enable --now -q "$app"

## Finish update
host=$(hostname -I)
ip_local=$(grep -oP '^\S*' <<<"$host")
echo ""
echo "Install complete"
echo "Browse to http://$ip_local:$app_port for the ${app^} GUI"
```

- Press <kbd>Ctrl</kbd>+<kbd>O</kbd> (save) then <kbd>Enter</kbd>
- Press <kbd>Ctrl</kbd>+<kbd>X</kbd> (exit) then <kbd>Enter</kbd>
- Then in your console type:

```shell
bash Rada <tab>
```

- This should autocomplete to RadarrInstall.sh

If you need to re-install run again:

```bash
bash RadarrInstall.sh
```

---

#### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Radarr and install it into `/opt` because it's not an official package yet.
> Radarr will run under the user `radarr` and group `media`; `media` is the commonly suggested group to run the \*Arrs, download clients, and media server under.
> Radarr's configuration files will be stored in `/var/lib/radarr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl mediainfo sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `radarr` is created
> \* The user `radarr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* You created the directory `/var/lib/radarr` and ensured the user `radarr` has read/write permissions for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://radarr.servarr.com/v1/update/master/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Radarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Radarr /opt/
```

> Note: This assumes you will run as the user `radarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Radarr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell  
sudo chown radarr:radarr -R /opt/Radarr
```

- Configure systemd so radarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/radarr`. Ensure it exists or modify it as needed.  For the default data directory of `/home/$USER/.config/Radarr` simply remove the `-data` argument. Note: that `$USER` is the User Radarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/radarr.service > /dev/null
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=radarr
Group=media
Type=simple

ExecStart=/opt/Radarr/Radarr -nobrowser -data=/var/lib/radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```

- Reload systemd:

```shell
sudo systemctl -q daemon-reload
```

- Enable the Radarr service:

```shell
sudo systemctl enable --now -q radarr
```

- (Optional) Remove the tarball:

```shell
rm Radarr*.linux*.tar.gz
```

Typically to access the Radarr web GUI browse to `http://{Your server IP Address}:7878`

---

#### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop radarr
sudo rm -rf /opt/Radarr
sudo rm -rf /var/lib/radarr
sudo rm -rf /etc/systemd/system/radarr.service
systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop radarr
sudo rm -rf /opt/Radarr
sudo rm -rf /etc/systemd/system/radarr.service
systemctl -q daemon-reload
```

## Docker

The Radarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Radarr Docker image.

### Avoid Common Pitfalls

#### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Radarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Movie.2018/`, but in the Radarr container that might be at `/downloads/My.Movie.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/movies` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Radarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Radarr web UI (Settings › Download Clients).

#### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Radarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Radarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

### Install Radarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/radarr](https://hotio.dev/containers/radarr/)
- [lscr.io/linuxserver/radarr](https://docs.linuxserver.io/images/docker-radarr)
{.links-list}

## Reverse Proxy Configuration

Sample config examples for configuring Radarr to be accessible through a reverse proxy.

> These examples assumes the default port of `7878` and that you set a baseurl of `radarr`. It also assumes your web server i.e nginx and Radarr running on the same server accessible at `localhost`. If not, use the host IP address or a FDQN instead for the proxy pass.
{.is-info}

### NGINX

```none
location /radarr {
  proxy_pass        http://127.0.0.1:7878/radarr;
  proxy_set_header Host $host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Host $host;
  proxy_set_header X-Forwarded-Proto https;
  proxy_redirect off;

  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
}
  location /radarr/api { auth_request off;
  proxy_pass       http://127.0.0.1:7878/radarr/api;
}

  location /radarr/Content { auth_request off;
    proxy_pass http://127.0.0.1:7878/radarr/Content;
 }
```

### Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `radarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /radarr>
  ProxyPass http://127.0.0.1:7878/radarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:7878/radarr
</Location>
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/radarr/api/`
- `/radarr/Content/`

## Multiple Instances

- It is possible to run multiple instances of Radarr. This is typically done when one wants a 4K and 1080p copy of a movie.
- Note that you can configure Radarr to use a second Radarr as a list.  This is helpful if you wish to keep both in sync.

The following requirements should be noted:

- If non-docker, the same binaries (program files) should be used
- If non-docker, all instances *must* have a `-data=` or `/data=` argument passed
- If non-docker, different ports must be used
  - If docker, different external ports must be used
- Different download client categories must be used
- Different root folders must be used.
- If non-docker, disable automatic updates on all but 1 instance.

### Windows

> [Please see the legacy wiki entry.](https://wikiold.servarr.com/Radarr_Tips_and_Tricks#Installing_multiple_Radarrs_on_Windows) Contributions to convert the entry to this wiki are welcome and encouraged.{.is-info}

### Linux

- [Swizzin Users](https://github.com/ComputerByte/radarr4k)
- Non-Swizzin Users
  - Ensure your first instance has the `-data=` argument passed.
  - Temporarily stop your first instance, so you can change the second instance's port `systemctl stop radarr`

> Below is an example script to create a Radarr4K instance. The below systemd creation script will use a data directory of `/var/lib/radarr4k/`. Ensure it exists or modify it as needed.{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/radarr4k.service > /dev/null
[Unit]
Description=Radarr4k Daemon
After=syslog.target network.target
[Service]
User=radarr
Group=media
Type=simple

ExecStart=/opt/Radarr/Radarr -nobrowser -data=/var/lib/radarr4k/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF
```

- Reload systemd:

```shell
sudo systemctl -q daemon-reload
```

- Enable the Radarr4k service:

```shell
sudo systemctl enable --now -q radarr4k
```

### Docker

- Simply spin up a second Docker container with a different name, ensuring the above requirements are met.
