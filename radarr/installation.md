---
title: Radarr Installation
description: 
published: true
date: 2022-01-30T04:45:26.426Z
tags: 
editor: markdown
dateCreated: 2021-05-17T01:14:47.863Z
---

# Windows

Radarr is supported natively on Windows. Radarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\\server\share UNC paths) without special configuration steps.

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

# MacOS (OSX)

{#OSX}

> Radarr not compatible with OSX versions < 10.13 (High Sierra) due to netcore incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://radarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Radarr icon to your Application folder.
1. Browse to <http://localhost:7878> to start using Radarr

# Linux

## Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

### Easy Install

> **The following is a community written and community maintained unofficial script.** {.is-info}

For the Debian / Ubuntu / Raspbian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](/radarr/installation#debian-ubuntu-hands-on-install)  steps further below.**

> Original script author note: For the avoidance of doubt this script is just to help the next person along and improve the Radarr install experience until Radarr eventually when a deb package / Apt Repo is created.
>
> Its target is the beginner/novice with `I know enough to be dangerous` experience.
> If you see any errors or improvements then please update for the next person by amending the wiki and script.

> This will create the user `radarr` and install Radarr to /opt. It will run Radarr as the group `media` You will likely need to modify the group (GUID) in the script to match the common group of your download client and media server to ensure ownership and permissions are sane and all files are accessible.
Two things to keep in mind are that Radarr requires read and write access to your download client's download directory and whatever folder you'll configure as your root (library) folder. Ideally each app is running as its own user and common group of `media` with permissions of `775` and `664` which is a UMask of `002`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
{.is-info}

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
### Description: Radarr 3.2+ (.net) Debian install
### Originally written by: DoctorArr - doctorarr@the-rowlands.co.uk on 2021-10-01 v1.0
### Version v1.1 2021-10-02 - Bakerboy448 (Made more generic and conformant)
### Version v1.1.1 2021-10-02 - DoctorArr (Spellcheck and boilerplate update)
### Version v2.0.0 2021-10-09 - Bakerboy448 (Refactored and ensured script is generic. Added more variables.)
### Version v2.0.1 2021-11-23 - brightghost (Fixed datadir step to use correct variables.)
### Additional Updates by: The Radarr Community

set -euo pipefail

# Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

# Const
### Update these variables as required for your specific instance

app="radarr"                        # App Name
app_uid="radarr"                    # {Update me if needed} User App will run as and the owner of it's binaries
app_guid="media"                    # {Update me if needed} Group App will run as.
app_port="7878"                     # Default App Port; Modify config.xml after install if needed
app_prereq="curl mediainfo sqlite3" # Required packages
app_umask="0002"                    # UMask the Service will run as
app_bin=${app^}                     # Binary Name of the app
installdir="/opt"                   # {Update me if needed} Install Location
bindir="${installdir}/${app^}"      # Full Path to Install Location
branch="master"                     # {Update me if needed} branch to install
datadir="/var/lib/radarr/"          # {Update me if needed} AppData directory to use

# Create User / Group as needed
if ! getent group "$app_guid" >/dev/null; then
    groupadd "$app_guid"
    echo "Group [$app_guid] created"
fi
if ! getent passwd "$app_uid" >/dev/null; then
    useradd --system --groups "$app_guid" "$app_uid"
    echo "User [$app_uid] created and added to Group [$app_guid]"
else
    echo "User [$app_uid] already exists"
fi

if ! getent group "$app_guid" | grep -qw "${app_uid}"; then
    echo "User [$app_uid] did not exist in Group [$app_guid]"
    usermod -a -G "$app_guid" "$app_uid"
    echo "Added User [$app_uid] to Group [$app_guid]"
else
    echo "User [$app_uid] already exists in Group [$app_guid]"
fi

# Stop the App if running

if service --status-all | grep -Fq "$app"; then
    systemctl stop $app
    systemctl disable $app.service
fi

# Create Appdata Directory

# AppData
mkdir -p $datadir
chown -R $app_uid:$app_guid $datadir
chmod 775 $datadir

# Download and install the App

# prerequisite packages
# Get MediaInfo from MI direct rather than the OS
wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-19_all.deb && dpkg -i repo-mediaarea_1.0-19_all.deb && apt-get update
apt install $app_prereq

ARCH=$(dpkg --print-architecture)
# get arch
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

# remove existing installs
echo "Removing existing installation"
# If you happen to run this script in the installdir the line below will delete the extracted files and cause the mv some lines below to fail.
rm -rf $bindir
echo "Installing..."
mv "${app^}" $installdir
chown $app_uid:$app_uid -R $bindir
rm -rf "${app^}.*.tar.gz"
# Ensure we check for an update in case user installs older version or different branch
touch $datadir/update_required
chown $app_uid:$app_guid $datadir/update_required
echo "App Installed"
# Configure Autostart

# Remove any previous app .service
echo "Removing old service file"
rm -rf /etc/systemd/system/$app.service

# Create app .service with correct user startup
echo "Creating service file"
cat <<EOF | tee /etc/systemd/system/$app.service >/dev/null
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

# Start the App
echo "Service file created. Attempting to start the app"
systemctl -q daemon-reload
systemctl enable --now -q "$app"

# Finish Update/Installation
host=$(hostname -I)
ip_local=$(grep -oP '^\S*' <<<"$host")
echo ""
echo "Install complete"
echo "Browse to http://$ip_local:$app_port for the ${app^} GUI"
# Exit
exit 0
```

- Press <kbd>Ctrl</kbd>+<kbd>O</kbd> (save) then <kbd>Enter</kbd>
- Press <kbd>Ctrl</kbd>+<kbd>X</kbd> (exit) then <kbd>Enter</kbd>
- Then in your console type:

```shell
sudo bash RadarrInstall.sh
```

If you need to re-install run again:

```bash
bash RadarrInstall.sh
```

---

### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Radarr and install it into `/opt`
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
> \* You created the directory `/var/lib/radarr` and ensured the user `radarr` has read/write permissions for it for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
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

- Configure systemd so Radarr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/radarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Radarr` simply remove the `-data` argument. Note: that `$USER` is the User Radarr runs as and is defined below.
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

### Uninstall

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

# FreeBSD

The Radarr team only provides builds for BSD. Plugins and Ports are maintained and created by the BSD community.

Instructions for BSD installations are also maintained by the BSD community and anyone with a GitHub account may update the wiki as needed.

[Freshport Radarr Link](https://www.freshports.org/net-p2p/radarr/)

## Jail Setup

1. From the main screen select Jails

1. Click ADD

1. Click Advanced Jail Creation

1. Name (any name will work): Radarr

1. Jail Type: Default (Clone Jail)

1. Release: 12.2-Release (or newer)

1. Configure Basic Properties to your liking

1. Configure Jail Properties to your liking but add

- [x] allow_raw_sockets

> `allow_raw_sockets` is helpful for troubleshooting (e.g. ping, traceroute) but is not a requirement as long as the program does not use those or create raw sockets itself {.is-info}

- [x] allow_mlock

1. Configure Network Properties to your liking

1. Configure Custom Properties to your liking

1. Click Save

## Radarr Installation

Back on the jails list find your newly created jail for `radarr` and click "Shell"

To install Radarr

`pkg install radarr`

Don't close the shell out yet we still have a few more things!

## Configuring Radarr

Now that we have it installed a few more steps are required.

### Service Setup

Time to enable the service but before we do, a note:

The service file uses `chown` to make sure Radarr can update itself. This can break things like `pkg check -s` and `pkg remove` for Radarr when the built-in updater replaces files.

To enable the service:

`sysrc radarr_enable=TRUE`

If you do not want to use user/group `radarr` you will need to tell the service file what user/group it should be running under

`sysrc radarr_user="USER_YOU_WANT"`

`sysrc radarr_group="GROUP_YOU_WANT"`

`radarr` stores its data, config, logs, and PID files in `/usr/local/radarr` by default. The service file will create this and take ownership of it IF AND ONLY IF IT DOES NOT EXIST. If you want to store these files in a different place (e.g., a dataset mounted into the jail for easier snapshots) then you will need to change it using `sysrc`

`sysrc radarr_data_dir="DIR_YOU_WANT"`

Reminder: If you are using an existing location then you will manually need to either: change the ownership to the UID/GID `radarr` uses AND/OR add `radarr` to a GID that has write access.

Almost done, let's start the service:

`service radarr start`

If everything went according to plan then radarr should be up and running on the IP of the jail (port 7878)!

(You can now safely close the shell)

## Troubleshooting

- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail.

> The service script should now work around the lack of VNET and/or IP6 thus removing the requirement for VNET or ip6=inherit
{.is-info}

# Docker

The Radarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Radarr Docker image.

## Avoid Common Pitfalls

### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Radarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Movie.2018/`, but in the Radarr container that might be at `/downloads/My.Movie.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/movies` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Radarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Radarr web UI (Settings › Download Clients).

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Radarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Radarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Radarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/radarr](https://hotio.dev/containers/radarr/)
- [lscr.io/linuxserver/radarr](https://docs.linuxserver.io/images/docker-radarr)
{.links-list}

# Reverse Proxy Configuration

Sample config examples for configuring Radarr to be accessible from the outside world through a reverse proxy.

> These examples assumes the default port of `7878` and that you set a baseurl of `radarr`. It also assumes your web server i.e nginx and Radarr running on the same server accessible at `localhost` (127.0.0.1). If not, use the host IP address or hostname instead for the proxy pass directive.
{.is-info}

## NGINX

Add the following configuration to `nginx.conf` located in the root of your Nginx configuration. The code block should be added inside the `server context`. [Full example of a typical Nginx configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

```none
location /radarr {
  proxy_pass         http://127.0.0.1:7878/radarr;
  proxy_set_header   Host $host;
  proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header   X-Forwarded-Host $host;
  proxy_set_header   X-Forwarded-Proto $scheme;
  proxy_redirect     off;

  proxy_http_version 1.1;
  proxy_set_header   Upgrade $http_upgrade;
  proxy_set_header   Connection $http_connection;
}
```

A better way to organize your configuration files for Nginx would be to store the configuration for each site in a seperate file.
To achieve this it is required to modify `nginx.conf` and add `include subfolders-enabled/*.conf` in the `server` context. So it will look something like this.

```nginx
server {
  listen 80;
  server_name _;
  
  # more configuration
  
  include subfolders-enabled/*.conf
}
```

Adding this line will include all files that end with `.conf` to the Nginx configuration. Make a new directory called `subfolders-enabled` in the same folder as your `nginx.conf` file is located. In that folder create a file with a recognizable name that ends with .conf. Add the configuration from above from the file and restart or reload Nginx. You should be able to visit Radarr at `yourdomain.tld/radarr`. tld is short for [Top Level Domain](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)

### Subdomain

Alternatively you can use a subdomain for radarr. In this case you would visit `radarr.yourdomain.tld`. For this you would need to configure a `A record` or `CNAME record` in your DNS.
> Many free DNS providers do not support this {.is-warning}

By default Nginx includes the `sites-enabled` folder. You can check this in `nginx.conf`, if not you can add it using the [include directive](http://nginx.org/en/docs/ngx_core_module.html#include). And really important, it has to be inside the `http context`. Now create a config file inside the sites-enabled folder and enter the following configuration.

> For this configuration it is recommended to set baseurl to '' (empty). This configuration assumes you are using the default `7878` and Radarr is accessible on the localhost (127.0.0.1). For this configuration the subdomain `radarr` is chosen (line 5). {.is-info}

```nginx
server {
  listen      80;
  listen [::]:80;

  server_name radarr.*;

  location / {
    proxy_set_header   Host $host;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host $host;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;

    proxy_redirect     off;
    proxy_http_version 1.1;
    
    proxy_pass http://127.0.0.1:7878;
  }
}
```

Now restart Nginx and Radarr should be available at your selected subdomain.

## Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `radarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /radarr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:7878/radarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:7878/radarr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

Or for making an entire VirtualHost for Radarr:

```none
ProxyPass / http://127.0.0.1:7878/radarr/
ProxyPassReverse / http://127.0.0.1:7878/radarr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/radarr/api/`
- `/radarr/Content/`

# Multiple Instances

It is possible to run multiple instances of Radarr. This is typically done when one wants a 4K and 1080p copy of a movie.
Note that you can configure Radarr to use a second Radarr as a list. This is helpful if you wish to keep both in sync.

- [Windows Multiple Instances](#windows-multi)
- [Linux Multiple Instances](#linux-multi)
- [Docker Multiple Instances](#docker-multi)
{.links-list}

The following requirements should be noted:

- If non-docker, the same binaries (program files) should be used
- If non-docker, all instances *must* have a `-data=` or `/data=` argument passed
- If non-docker, different ports must be used
  - If docker, different external ports must be used
- Different download client categories must be used
- Different root folders must be used.
- If non-docker, disable automatic updates on all but 1 instance.

## Windows Multiple Instances

{#windows-multi}

This guide will show you how to run multiple instances of Radarr on Windows using only one base installation. This guide was put together using Windows 10; if you are using a previous version of Windows (7, 8, etc.) you may need to adjust some things. This guide also assumes that you have installed Radarr to the default directory, and your second instance of Radarr will be called Radarr-4K. Feel free to change things to fit your own installations, though.

### Service (Windows)

#### Prerequisites (Service)

- [You must have Radarr already installed](#windows)
- You must have [NSSM (Non-Sucking Service Manager](http://nssm.cc) installed. To install, download the latest release (2.24 at the time of writing) and copy either the 32-bit or 64-bit nssm.exe file to C:/windows/system32.
  - If you aren’t sure if you have a 32-bit or 64-bit system, check Settings => System => About => System type.

#### Configuring Radarr Service

1. Open a Command Prompt administrator window. (To run as an admin,
    right click on the Command Prompt icon and choose “Run as
    administrator.”)
1. If Radarr is running, stop the service by running `nssm stop Radarr`
    in Command Prompt.
1. Now we have to edit the existing Radarr instance to explicitly point
    to its data directory. The default command is as follows:
    `sc config Radarr binpath= "C:\ProgramData\Radarr\bin\Radarr.exe
    -data=C:\ProgramData\Radarr"`

This command tells the original instance of Radarr to explicitly use
`C:\ProgramData\Radarr` for its data directory. If you didn't use the
default Radarr install, or if your data folder is somewhere else, you
may have to change your paths here.

#### Creating Radarr-4K Service

1. Create a new folder where you’d like Radarr-4K to live. Most use a similar place such as
    `C:\ProgramData\Radarr-4K`
1. Back in Command Prompt, create the new Radarr-4K service using `nssm
    install Radarr-4K`. A popup window will open where you can type your
    parameters for the new instance. For this example, we will use the
    following:
      - Path: `C:\ProgramData\Radarr\bin\Radarr.exe`
      - Startup directory: `C:\ProgramData\Radarr\bin`
      - Arguments: `-data=C:\ProgramData\Radarr-4K`

> Note that **Arguments** points to the *new* folder created in step 1.
This is crucial, as it keeps all the data files from both instances in
separate locations. {.is-warning}

1. Click *Install service*. The window should close and the service
    will now be available to run.
1. Continue to [Configuring Radarr-4k](#windows-multi-config-second)

### Tray App (Windows)

#### Prerequisites (Tray App)

- [You must have Radarr already installed](#windows)
- Radarr must be configured with a `/data=` argument to allow multiple instances
- Navigate to the Startup Folder for the current user `%appdata%\Microsoft\Windows\Start Menu\Programs\Startup` and edit the existing shortcut if needed.

#### Creating Radarr-4K Tray App

- Right click and Create New Shortcut
- Path: `C:\ProgramData\Radarr\bin\Radarr.exe /data=C:\ProgramData\Radarr-4K`
- Give the shortcut a unique name such as `Radarr-4K` and finish the wizard.
- Double click the new shortcut to run and test.
- Continue to [Configuring Radarr-4k](#windows-multi-config-second)

### Configuring Radarr-4k {#windows-multi-config-second}

- Regardless of if you used the Service Method or the Tray App: Stop both services and both Apps
- Start Radarr-4k (Service or Tray App)
- Open up Radarr-4k and Navigate within the app to [Settings => General => Host](/radarr/settings/#host)
- Change `Port Number` from `7878` to a different port e.g. `7879` so Radarr and Radarr4k do not conflict
- You should now be able to start both apps
- Continue to [Dealing with Updates](#dealing-with-updates)

### Dealing with Updates

- Disable automatic updates in one of your instances
- If one Radarr instance is updated, both instances will shutdown and only the updated one will start again. To fix this, you will have to manually start the other instance, or you may want to look into using the below powershell script to address the problem.

#### Windows Port Checker and Restarter PowerShell Script

- When you use two Radarr instances and one of it is updating, it will kill all instances. Only the one which is updating will come back online.
- The below powershell script should be configured as a scheduled task.
- It checks the ports and if one is not online, it will (re-)start the scheduled task to launch Radarr.

1. Create a new File and name it RadarrInstancesChecker.ps1 with the below code.
1. Edit the script with your actual service names, IP, and ports.
1. [Create a scheduled task](https://www.thewindowsclub.com/schedule-task-in-windows-7-task-scheduler) to run the script on a repeating schedule.

- Security Options: Enable `Run with highest privileges`
  - Otherwise the script will be unable to manipulate services
- Trigger: `On Launch`
- Repeat task every: `5` or `10` minutes
- Action: `Start a Program`
- Program/script: `powershell`
- Argument: `-File D:\RadarrInstancesChecker.ps1`
  - Be sure to use the full path to your script's location

```powershell
################################################################################################
### RadarrInstancesChecker.ps1                                                               ###
################################################################################################
### Keeps multiple Radarr Instances up by checking the port                                  ###
### Please use Radarr´s Discord or Reddit for support!                                       ###
### https://wiki.servarr.com/radarr/installation#windows-multi                               ###
################################################################################################
### Version: 1.1                                                                             ###
### Updated: 2020-10-22                                                                      ###
### Author:  reloxx13                                                                        ###
################################################################################################



### SET YOUR CONFIGURATION HERE ###
# Set your host ip and port correctly and use your service or scheduledtask names!

# (string) The type how Radarr is starting
# "Service" (default) Service process is used
# "ScheduledTask" Task Scheduler is used
$startType = 'Service'

# (bool) Writes the log to C:\Users\YOURUSERNAME\log.txt when enabled
# $false (default)
# $true
$logToFile = $false


$instances = @(
    [pscustomobject]@{   # Instance 1
        Name = 'Radarr-V3'; # (string) Service or Task name (default: Radarr-V3)
        IP   = '192.168.178.12'; # (string) Server IP where Radarr runs (default: 192.168.178.12)
        Port = '7873'; # (string) Server Port where Radarr runs (default: 7873)
    }
    [pscustomobject]@{   # Instance 2
        Name = 'Radarr-4K'; # (string) Service or Task name (default: Radarr-4K)
        IP   = '192.168.178.12'; # (string) Server IP where Radarr runs (default: 192.168.178.12)
        Port = '7874'; # (string) Server Port where Radarr runs (default: 7874)
    }
    # If needed you can add more instances here... by uncommenting out the below lines
    # [pscustomobject]@{   # Instance 3
    # Name='Radarr-3D';    # (string) Service or Task name (default: Radarr-3D)
    # IP='192.168.178.12'; # (string) Server IP where Radarr runs (default: 192.168.178.12)
    # Port='7875';         # (string) Server Port where Radarr runs (default: 7875)
    # }
)


### DONT CHANGE ANYTHING BELOW THIS LINE ###


###
# This function will write to a log file or in console output
###
function Write-Log
{
    #Will write to C:\Users\YOURUSERNAME\log.txt
    
    Param(
        $Message,
        $Path = "$env:USERPROFILE\log.txt" 
    )

    function TS { Get-Date -Format 'hh:mm:ss' }
    
    #Console output
    Write-Output "[$(TS)]$Message"
    
    #File Output
    if ($logToFile)
    {
        "[$(TS)]$Message" | Tee-Object -FilePath $Path -Append | Write-Verbose
    }
}


Write-Log 'START ====================='


$instances | ForEach-Object {
    Write-Log "Check $($_.Name) $($_.IP):$($_.Port)"
    
    $PortOpen = ( Test-NetConnection $_.IP -Port $_.Port -WarningAction SilentlyContinue ).TcpTestSucceeded 
    
    if (!$PortOpen)
    {
        Write-Log "Port $($_.Port) is closed, restart $($startType) $($_.Name)!"

        if ($startType -eq 'Service')
        {
            Get-Service -Name $_.Name | Stop-Service
            Get-Service -Name $_.Name | Start-Service
        }
        elseif ($startType -eq 'ScheduledTask')
        {
            Get-ScheduledTask -TaskName $_.Name | Stop-ScheduledTask
            Get-ScheduledTask -TaskName $_.Name | Start-ScheduledTask
        }
        else
        {
            Write-Log '[ERROR] STARTTYPE UNKNOWN! USE Service or ScheduledTask !'
        }
    }
    else
    {
        Write-Log "Port $($_.Port) is open!"
    }
}

Write-Log 'END ====================='
```

## Linux Multiple Instances

{#linux-multi}

- [Swizzin Users](https://github.com/ComputerByte/radarr4k)
- Non-Swizzin Users
  - Ensure your first instance has the `-data=` argument passed.
  - Temporarily stop your first instance, so you can change the second instance's port `systemctl stop radarr`
  - Disable automatic updates on one of your Radarr Instances`

> Below is an example script to create a Radarr4K instance. The below systemd creation script will use a data directory of `/var/lib/radarr4k/`. Ensure the directory exists or modify it as needed.{.is-danger}

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

## Docker Multiple Instances

{#docker-multi}

- Simply spin up a second Docker container with a different name, ensuring the above requirements are met.
