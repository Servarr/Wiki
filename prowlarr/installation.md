---
title: Prowlarr Installation
description: 
published: true
date: 2021-08-30T15:48:19.010Z
tags: prowlarr
editor: markdown
dateCreated: 2021-05-24T05:07:51.882Z
---

## Windows

Prowlarr is supported natively on Windows. Prowlarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Prowlarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You will likely have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Prowlarr\config.xml` is denied -- or you use mapped network drives. This gives Prowlarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Prowlarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:9696> to start using Prowlarr

- [Windows x64 Installer](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Prowlarr manually using the [x64 .zip download](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

> If you use [Cerify The Web](https://docs.certifytheweb.com/docs/backgroundservice/) for LetsEncrypt certificate management for IIS and are installing Prowlarr on the same machine, port `9696` is used by the background service. You will need to either change the listening port of Prowlarr in your `config.xml` to something else or change the port of the Certify The Web background service.
{.is-info}

## MacOS (OSX)

{#OSX}
  
> Prowlarr not compatible with OSX versions < 10.13 (High Sierra) due to netcore incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Prowlarr icon to your Application folder.
1. Browse to <http://localhost:9696> to start using Prowlarr

## Linux

### Debian / Ubuntu

> Prowlarr is curretly in beta testing and is generally still in a work in progress. Features may be broken, incomplete, or cause spontaneous combustion.
{.is-danger}
> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

#### Easy Install

> **The following is a community written and maintained script.** {.is-info}
For the Debian / Ubuntu / Raspian beginners there isn't an Apt Repository or Deb package.
If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.
**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](/prowlarr/installation#debian-ubuntu-hands-on-install)  steps further below.**
> Original script author note: For the avoidance of doubt this script is just to help the next person along and improve the Prowlarr install experience until Prowlarr eventually when a deb package / Apt Repo is created.
>
> Its target is the beginner/novice with `I know enough to be dangerous` experience.
> If you see any errors or improvements then please update for the next person by amending the wiki and script.
> This will create the user `prowlarr` and install Prowlarr to /opt. It will run Prowlarr as the group `prowlarr`.
> This will remove any existing Installations; please ensure you have a backup of your settings using Backup from within Prowlarr. The script won't delete your settings (application data), but be safe. {.is-danger}

- (Optional) Ensure you have [set a static IP Address](https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/), it'll will make your life easier.
- SSH into your 'Debian (Raspbian / Raspberry Pi OS) / Ubuntu box and become or login as root. SSH in using Putty, mRemoteNG, or any other SSH tool. Note that most tools support saving your connection.
- Once SSHed in type the below to create the installation script in your current director

```bash
nano ProwlarrInstall.sh
```

- Copy (top right corner of the script) and Paste into your SSH console
  - If you are in an GUI OS such as Windows or MacOS (OSX): pasting could be as simple as 'right clicking' in your ssh client.

```bash
#!/bin/bash
#### Description: Prowlarr Debian install
#### Originally from the Radarr Community
## Am I root?, need root!
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi
## Const
#### Update these variables as required for your specific instance
app="prowlarr"                       # App Name
app_uid="prowlarr"                   # {Update me if needed} User App will run as and the owner of it's binaries
app_guid="prowlarr"                  # {Update me if needed} Group App will run as.
app_port="9696"                      # Default App Port; Modify config.xml after install if needed
app_prereq="curl sqlite3"            # Required packages
app_umask="0002"                     # UMask the Service will run as
app_bin=${app^}                      # Binary Name of the app
bindir="/opt/${app^}"                # Install Location
branch="develop"                     # {Update me if needed} branch to install
datadir="/var/lib/prowlarr/"         # {Update me if needed} AppData directory to use

## Create App user if it doesn't exist
PASSCHK=$(grep -c "$app_uid:" /etc/passwd)
if [ "$PASSCHK" -ge 1 ]; then
    groupadd -f $app_guid
    usermod -a -G $app_uid $app_guid
    echo "User: [$app_uid] seems to exist. Skipping creation, but adding to the group if needed. Ensure the User [$app_uid] and Group [$app_guid] are setup properly.  Specifically the application will need access to your download client and prowlarr files."
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
bash Prowl <tab>
```

- This should autocomplete to ProwlarrInstall.sh
If you need to re-install run again:

```bash
bash ProwlarrInstall.sh
```

---

#### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Prowlarr and install it into `/opt`
> Prowlarr will run under the user `prowlarr` and group `prowlarr`
> Prowlarr's configuration files will be stored in `/var/lib/prowlarr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `prowlarr` is created
> \* You created the directory `/var/lib/prowlarr` and ensured the user `prowlarr` has read/write permissions
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://prowlarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Prowlarr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Prowlarr/ /opt
```

> This assumes you have created the user and will run as the user `prowlarr` and group `prowlarr`. You may change this to fit your usecase.
{.is-danger}

- Ensure ownership of the binary directory.

```shell  
sudo chown prowlarr:prowlarr -R /opt/Prowlarr
```

- Configure systemd so Prowlarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/prowlarr`.  Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Prowlarr` simply remove the `-data` argument.  Note: that `$USER` is the User Prowlarr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/prowlarr.service > /dev/null
[Unit]
Description=Prowlarr Daemon
After=syslog.target network.target
[Service]
User=prowlarr
Group=prowlarr
Type=simple

ExecStart=/opt/Prowlarr/Prowlarr -nobrowser -data=/var/lib/prowlarr/
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

- Enable the Prowlarr service:

```shell
sudo systemctl enable --now -q prowlarr
```

- (Optional) Remove the tarball:

```shell
rm Prowlarr*.linux*.tar.gz
```

Typically to access the Radarr web GUI browse to `http://{Your server IP Address}:9696`

---

#### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop prowlarr
sudo rm -rf /opt/Prowlarr
sudo rm -rf /var/lib/prowlarr
sudo rm -rf /etc/systemd/system/prowlarr.service
systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop prowlarr
sudo rm -rf /opt/Prowlarr
sudo rm -rf /etc/systemd/system/prowlarr.service
systemctl -q daemon-reload
```

## Docker

### Install Prowlarr

The Prowlarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

> For a more detailed explanation of docker and suggested practices, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the `:nightly` or `:develop` tags with docker images, as there is no `master` branch.
{.is-warning}

- [hotio/prowlarr](https://hotio.dev/containers/prowlarr/)
- [lscr.io/linuxserver/prowlarr](https://github.com/lscr.io/linuxserver/docker-prowlarr/tree/develop)
{.links-list}

## Reverse Proxy Configuration

Sample config examples for configuring Prowlarr to be accessible through a reverse proxy.

> These examples assumes the default port of `9696` and that you set a baseurl of `prowlarr`. It also assumes your web server i.e nginx and Prowlarr running on the same server accessible at `localhost`. If not, use the host IP address or a FQDN instead.
{.is-info}

### NGINX

```nginx
location /prowlarr {
  proxy_pass    http://127.0.0.1:9696/prowlarr;
  proxy_set_header Host              $host;
  proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Host  $host;
  proxy_set_header X-Forwarded-Proto https;
  proxy_redirect  off;

  proxy_http_version 1.1;
  proxy_set_header  Upgrade     $http_upgrade;
  proxy_set_header  Connection  $http_connection;
}

location /prowlarr/api {
  auth_request off;
  proxy_pass  http://127.0.0.1:9696/prowlarr/api;
}

location ~ /prowlarr/[0-9]+/api {
 auth_request off;
  proxy_pass  http://127.0.0.1:9696;
}

location /prowlarr/Content {
 auth_request off;
 proxy_pass  http://127.0.0.1:9696/prowlarr/Content;
}
```

### Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `prowlarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /prowlarr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:9696/prowlarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:9696/prowlarr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

Or for making an entire VirtualHost for Prowlarr:

```none
ProxyPass / http://127.0.0.1:9696/prowlarr/
ProxyPassReverse / http://127.0.0.1:9696/prowlarr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/prowlarr/api/`
- `/prowlarr/Content/`
