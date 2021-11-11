---
title: Readarr Installation
description: 
published: true
date: 2021-11-11T23:09:03.231Z
tags: readarr
editor: markdown
dateCreated: 2021-05-25T00:22:15.328Z
---

## Windows

Readarr is supported natively on Windows. Readarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Readarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You will likely have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Readarr\config.xml` is denied -- or you use mapped network drives. This gives Readarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

> Warning: If you run Plex as a service via [PmsService](https://github.com/cjmurph/PmsService) you will either need to change PMsService's port from `8787` or you will need to modify the port Readarr runs on in the `config.xml` file.
{.is-info}

> Readarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}

1. Download the latest version of Readarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:8787> to start using Readarr

- [Windows x64 Installer](https://readarr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://readarr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Readarr manually using the [x64 .zip download](https://readarr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

## MacOS (OSX)

{#OSX}

> Readarr not compatible with OSX versions < 10.13 (High Sierra) due to netcore incompatibilities.
{.is-warning}

> Readarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}

1. Download the [MacOS App](https://readarr.servarr.com/v1/update/nightly/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Readarr icon to your Application folder.
1. Browse to <http://localhost:8787> to start using Readarr

## Linux

### Debian / Ubuntu

> Readarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

#### Easy Install

> **The following is a community written and maintained script.** {.is-info}
For the Debian / Ubuntu / Raspian beginners there isn't an Apt Repository or Deb package.
If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.
**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](/readarr/installation#debian-ubuntu-hands-on-install)  steps further below.**
> Original script author note: For the avoidance of doubt this script is just to help the next person along and improve the Readarr install experience until Readarr eventually when a deb package / Apt Repo is created.
>
> Its target is the beginner/novice with `I know enough to be dangerous` experience.
> If you see any errors or improvements then please update for the next person by amending the wiki and script.
> This will create the user `readarr` and install Readarr to /opt. It will run Readarr as the group `media` You will likely need to modify the group (GUID) in the script to match the common group of your download client and media server to ensure ownership and permissions are sane and all files are accessible.{.is-info}
> This will remove any existing Installations; please ensure you have a backup of your settings using Backup from within Readarr. The script won't delete your settings (application data), but be safe. {.is-danger}

- (Optional) Ensure you have [set a static IP Address](https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/), it'll will make your life easier.
- SSH into your 'Debian (Raspbian / Raspberry Pi OS) / Ubuntu box and become or login as root. SSH in using Putty, mRemoteNG, or any other SSH tool. Note that most tools support saving your connection.
- Once SSHed in type the below to create the installation script in your current director

```bash
nano ReadarrInstall.sh
```

- Copy (top right corner of the script) and Paste into your SSH console
  - If you are in an GUI OS such as Windows or MacOS (OSX): pasting could be as simple as 'right clicking' in your ssh client.

```bash
#!/bin/bash
#### Description: Readarr Debian install
#### Originally from the Radarr Community
## Am I root?, need root!
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi
## Const
#### Update these variables as required for your specific instance
app="readarr"                        # App Name
app_uid="readarr"                    # {Update me if needed} User App will run as and the owner of it's binaries
app_guid="media"                     # {Update me if needed} Group App will run as.
app_port="8787"                      # Default App Port; Modify config.xml after install if needed
app_prereq="curl sqlite3"            # Required packages
app_umask="0002"                     # UMask the Service will run as
app_bin=${app^}                      # Binary Name of the app
bindir="/opt/${app^}"                # Install Location
branch="nightly"                     # {Update me if needed} branch to install
datadir="/var/lib/readarr/"          # {Update me if needed} AppData directory to use

## Create App user if it doesn't exist
PASSCHK=$(grep -c "$app_uid:" /etc/passwd)
if [ "$PASSCHK" -ge 1 ]; then
    groupadd -f $app_guid
    usermod -a -G $app_guid $app_uid
    echo "User: [$app_uid] seems to exist. Skipping creation, but adding to the group if needed. Ensure the User [$app_uid] and Group [$app_guid] are setup properly.  Specifically the application will need access to your download client and media files."
else
    echo "User: [$app_uid] created with disabled password."
    adduser --disabled-password --gecos "" $app_uid
    groupadd -f $app_guid
    usermod -a -G $app_guid $app_uid
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
bash Reada <tab>
```

- This should autocomplete to ReadarrInstall.sh
If you need to re-install run again:

```bash
bash ReadarrInstall.sh
```

---

#### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Readarr and install it into `/opt`
> Readarr will run under the user `readarr` and group `media`
> Readarr's configuration files will be stored in `/var/lib/readarr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `readarr` is created
> \* The user `readarr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* If Calibre will be used, Calibre runs as the group `media` and the Calibre library has read/write permissions for `media`
> \* You created the directory `/var/lib/readarr` and ensured the user `readarr` has read/write permissions
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://readarr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Readarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Readarr/ /opt
```

> This assumes you have created the user and will run as the user `readarr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Readarr.  Please note that if use wish to use Calibre - Readarr will need permissions for that directory.
{.is-danger}

- Ensure ownership of the binary directory.

```shell  
sudo chown readarr:readarr -R /opt/Readarr
```

- Configure systemd so Readarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/readarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Readarr` simply remove the `-data` argument.  Note: that `$USER` is the User Readarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/readarr.service > /dev/null
[Unit]
Description=Readarr Daemon
After=syslog.target network.target
[Service]
User=readarr
Group=media
Type=simple

ExecStart=/opt/Readarr/Readarr -nobrowser -data=/var/lib/readarr/
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

- Enable the Readarr service:

```shell
sudo systemctl enable --now -q readarr
```

- (Optional) Remove the tarball:

```shell
rm Readarr*.linux*.tar.gz
```

Typically to access the Readarr web GUI browse to `http://{Your server IP Address}:8787`

---

#### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop readarr
sudo rm -rf /opt/Readarr
sudo rm -rf /var/lib/readarr
sudo rm -rf /etc/systemd/system/readarr.service
systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop readarr
sudo rm -rf /opt/Readarr
sudo rm -rf /etc/systemd/system/readarr.service
systemctl -q daemon-reload
```

## Docker

The Readarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Readarr Docker image.

### Avoid Common Pitfalls

#### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Readarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Book.2018.epub/`, but in the Readarr container that might be at `/downloads/My.Book.2018.epub/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/books` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Readarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your books would be in `/data/Books`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Readarr web UI (Settings › Download Clients).

#### Calibre Integration

When installing Readarr, you can choose to use Calibre integration or not. This choice can only be made during installation, and if you choose not to utilize Calibre you cannot add it later. If you currently use Calibre to manage your book library, you should choose this option. If you use it, Calibre will name and organize your book files for you.

If you are running Calibre, you must first start the Calibre Content Server (Preferences / Sharing over the net), and also set up a user and password. This will require a Calibre restart.

> Please note that Calibre Content Server and Calibre are NOT Calibre Web. Calibre Web is a separate tool unrelated to either of these programs, and is not required nor used by Readarr in any way.
{.is-warning}

#### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Readarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Readarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

### Install Readarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the `:nightly` tag with docker images, as there is no `master` nor `develop` branch.
{.is-warning}

- [hotio/readarr](https://hotio.dev/containers/readarr/)
- [lscr.io/linuxserver/readarr](https://github.com/lscr.io/linuxserver/docker-prowlarr/tree/nightly)
{.links-list}

## Reverse Proxy Configuration

Sample config examples for configuring Readarr to be accessible through a reverse proxy.

> These examples assumes the default port of `8787` and that you set a baseurl of `readarr`. It also assumes your web server i.e nginx and Readarr running on the same server accessible at `localhost`. If not, use the host IP address or a FDQN instead for the proxy pass.
{.is-info}

### NGINX

```none
location /readarr {
  proxy_pass        http://127.0.0.1:8787/readarr;
  proxy_set_header Host $host;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Host $host;
  proxy_set_header X-Forwarded-Proto https;
  proxy_redirect off;

  proxy_http_version 1.1;
  proxy_set_header Upgrade $http_upgrade;
  proxy_set_header Connection $http_connection;
}
  location /readarr/api { auth_request off;
  proxy_pass       http://127.0.0.1:8787/readarr/api;
}

  location /readarr/Content { auth_request off;
    proxy_pass http://127.0.0.1:8787/readarr/Content;
 }
```

### Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `readarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /readarr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:8787/readarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:8787/readarr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

Or for making an entire VirtualHost for Readarr:

```none
ProxyPass / http://127.0.0.1:8787/readarr/
ProxyPassReverse / http://127.0.0.1:8787/readarr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/readarr/api/`
- `/readarr/Content/`

## Multiple Instances

- It is possible to run multiple instances of Readarr. This is typically done when one wants a text and audiobook of the same book.
- Note that you can configure Readarr to use a second Readarr as a list.  This is helpful if you wish to keep both in sync.

The following requirements should be noted:

- If non-docker, the same binaries (program files) should be used
- If non-docker, all instances *must* have a `-data=` or `/data=` argument passed
- If non-docker, different ports must be used
  - If docker, different external ports must be used
- Different download client categories must be used
- Different root folders must be used.
- If non-docker, disable automatic updates on all but 1 instance.

### Windows

> Contributions welcome and encouraged.{.is-info}

### Linux

- Ensure your first instance has the `-data=` argument passed.
- Temporarily stop your first instance, so you can change the second instance's port `systemctl stop readarr`

> Below is an example script to create a ReadarrAudio instance. The below systemd creation script will use a data directory of `/var/lib/readarraudio/`. Ensure it exists or modify it as needed.{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/readarraudio.service > /dev/null
[Unit]
Description=ReadarrAudio Daemon
After=syslog.target network.target
[Service]
User=readarr
Group=media
Type=simple

ExecStart=/opt/Readarr/Readarr -nobrowser -data=/var/lib/readarraudio/
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

- Enable the ReadarrAudio service:

```shell
sudo systemctl enable --now -q readarraudio
```

### Docker

- Simply spin up a second Docker container with a different name, ensuring the above requirments are met.
