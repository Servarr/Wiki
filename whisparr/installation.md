---
title: Whisparr Installation
description: 
published: true
date: 2022-04-30T22:08:45.818Z
tags: 
editor: markdown
dateCreated: 2022-04-03T03:49:24.491Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Windows](#windows)
- [MacOS (OSX)](#macos-osx)
- [Linux](#linux)
  - [Debian / Ubuntu](#debian--ubuntu)
    - [Easy Install](#easy-install)
    - [Debian / Ubuntu Hands on Install](#debian-ubuntu-hands-on-install)
    - [Uninstall](#uninstall)
- [FreeBSD](#freebsd)
  - [Jail Setup Using TrueNAS GUI](#jail-setup-using-truenas-gui)
  - [Whisparr Installation](#whisparr-installation)
  - [Configuring Whisparr](#configuring-whisparr)
    - [Service Setup](#service-setup)
  - [Troubleshooting](#troubleshooting)
- [Docker](#docker)
  - [Avoid Common Pitfalls](#avoid-common-pitfalls)
    - [Volumes and Paths](#volumes-and-paths)
    - [Ownership and Permissions](#ownership-and-permissions)
  - [Install Whisparr](#install-whisparr)
- [Reverse Proxy Configuration](#reverse-proxy-configuration)
  - [NGINX](#nginx)
    - [Subdomain](#subdomain)
  - [Apache](#apache)
- [Multiple Instances](#multiple-instances)
  - [Windows Multiple Instances](#windows-multiple-instances)
    - [Service (Windows)](#service-windows)
      - [Prerequisites (Service)](#prerequisites-service)
      - [Configuring Whisparr Service](#configuring-whisparr-service)
      - [Creating Whisparr-4K Service](#creating-whisparr-4k-service)
    - [Tray App (Windows)](#tray-app-windows)
      - [Prerequisites (Tray App)](#prerequisites-tray-app)
      - [Creating Whisparr-4K Tray App](#creating-whisparr-4k-tray-app)
    - [Configuring Whisparr-4k](#configuring-whisparr-4k-windows-multi-config-second)
    - [Dealing with Updates](#dealing-with-updates)
      - [Windows Port Checker and Restarter PowerShell Script](#windows-port-checker-and-restarter-powershell-script)
  - [Linux Multiple Instances](#linux-multiple-instances)
  - [Docker Multiple Instances](#docker-multiple-instances)

# Windows

Whisparr is supported natively on Windows. Whisparr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Whisparr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing if you get an access error -- such as Access to the path `C:\ProgramData\Whisparr\config.xml` is denied -- or you use mapped network drives. This gives Whisparr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Whisparr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:6969> to start using Whisparr

- [Windows x64 Installer](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Whisparr manually using the [x64 .zip download](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

# MacOS (OSX)

{#OSX}

> Whisparr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://whisparr.servarr.com/v1/update/nightly/updatefile?os=osx&runtime=netcore&arch=x64&installer=true)
1. Open the archive and drag the Whisparr icon to your Application folder.
1. Self-sign Whisparr `codesign --force --deep -s - Whisparr.app`
1. Browse to <http://localhost:6969> to start using Whisparr

# Linux

## Debian / Ubuntu

> Note: Raspberry Pi OS and Raspbian are both flavors of Debian {.is-info}

### Easy Install

For the Debian / Ubuntu / Raspbian beginners there isn't an Apt Repository or Deb package.

If you want an easy life, follow this community provided and maintained `Easy Install` script for a base Debian (Raspbian / Raspberry Pi OS) / Ubuntu install.

**For the official installation instructions that are 'Hands on' follow the [Debian / Ubuntu Hands on Install](#debian-ubuntu-hands-on-install) steps further below.**

[Please see the \*Arr Community Installation Script](/install-script)

### Debian / Ubuntu Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Whisparr and install it into `/opt`
> Whisparr will run under the user `whisparr` and group `media`; `media` is the commonly suggested group to run the \*Arrs, download clients, and media server under.
> Whisparr's configuration files will be stored in `/var/lib/whisparr`
{.is-warning}

- Ensure you have the required prerequisite packages:

```shell
sudo apt install curl sqlite3
```

> Warning: Ignoring the below prerequisites will result in a failed installation and non-functional application. {.is-warning}

> **Installation Prerequisites**
> The below instructions are based on the following prerequisites. Change the instructions as needed to suit your specific needs if necessary.
> \* The user `whisparr` is created
> \* The user `whisparr` is part of the group `media`
> \* Your download clients and media server run as and are a part of the group `media`
> \* Your paths used by your download clients and media server are accessible (read/write) to the group `media`
> \* You created the directory `/var/lib/whisparr` and ensured the user `whisparr` has read/write permissions for it for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
    - ARM64 use `arch=arm64`

```shell
wget --content-disposition 'http://whisparr.servarr.com/v1/update/nightly/updatefile?os=linux&runtime=netcore&arch=x64'
```

- Uncompress the files:

```shell
tar -xvzf Whisparr*.linux*.tar.gz
```

- Move the files to `/opt/`

```shell
sudo mv Whisparr /opt/
```

> Note: This assumes you will run as the user `whisparr` and group `media`. You may change this to fit your usecase. It's important to choose these correctly to avoid permission issues with your media files. We suggest you keep at least the group name identical between your download client(s) and Whisparr.
{.is-danger}

- Ensure ownership of the binary directory.

```shell
sudo chown whisparr:whisparr -R /opt/Whisparr
```

- Configure systemd so Whisparr can autostart at boot.

> The below systemd creation script will use a data directory of `/var/lib/whisparr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Whisparr` simply remove the `-data` argument. Note: that `$USER` is the User Whisparr runs as and is defined below.
{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/whisparr.service > /dev/null
[Unit]
Description=Whisparr Daemon
After=syslog.target network.target
[Service]
User=whisparr
Group=media
Type=simple

ExecStart=/opt/Whisparr/Whisparr -nobrowser -data=/var/lib/whisparr/
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

- Enable the Whisparr service:

```shell
sudo systemctl enable --now -q whisparr
```

- (Optional) Remove the tarball:

```shell
rm Whisparr*.linux*.tar.gz
```

Typically to access the Whisparr web GUI browse to `http://{Your server IP Address}:6969`

If Whisparr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u whisparr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop whisparr
sudo rm -rf /opt/Whisparr
sudo rm -rf /var/lib/whisparr
sudo rm -rf /etc/systemd/system/whisparr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop whisparr
sudo rm -rf /opt/Whisparr
sudo rm -rf /etc/systemd/system/whisparr.service
sudo systemctl -q daemon-reload
```

# FreeBSD

The Whisparr team only provides builds for FreeBSD. Plugins and Ports are maintained and created by the FreeBSD community.

Instructions for FreeBSD installations are also maintained by the FreeBSD community and anyone with a GitHub account may update the wiki as needed.

> Currently the BSD Community does not have any package or port available
{.is-danger}

[Freshports Whisparr Link](https://www.freshports.org/net-p2p/whisparr/)

## Jail Setup Using TrueNAS GUI

1. From the main screen select Jails

1. Click ADD

1. Click Advanced Jail Creation

1. Name (any name will work): Whisparr

1. Jail Type: Default (Clone Jail)

1. Release: 12.2-Release (or newer)

1. Configure Basic Properties to your liking

1. Configure Jail Properties to your liking but add

- [x] allow_mlock

- [x] allow_raw_sockets

> `allow_raw_sockets` is helpful for troubleshooting (e.g. ping, traceroute) but is not a requirement. {.is-info}

1. Configure Network Properties to your liking

1. Configure Custom Properties to your liking

1. Click Save

1. After the jail is created it will start automatically. One more property is required to be set in order for Whisparr to see the storage space of your mounted media locations. Open a root shell on the server and enter these commands:

```shell
iocage stop <jailname>
iocage set enforce_statfs=1 <jailname>
iocage start <jailname>
```

## Whisparr Installation

Back on the jails list find your newly created jail for `whisparr` and click `Shell`

To install Whisparr

> \* Ensure your pkg repo is configured to get packages from `/latest` and not `/quarterly`
> \* Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
> \* If that does not exist, copy over `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

> Currently the BSD Community does not have any package or port available
{.is-danger}

```shell
pkg install whisparr
```

Don't close the shell out yet we still have a few more things!

## Configuring Whisparr

Now that we have it installed a few more steps are required.

### Service Setup

Time to enable the service but before we do, a note:

The updater is disabled by default. The `pkg-message` gives instructions on how to enable the updater but keep in mind: this can break things like `pkg check -s` and `pkg remove` for Whisparr when the built-in updater replaces files.

To enable the service:

```shell
sysrc whisparr_enable=TRUE
```

If you do not want to use user/group `whisparr` you will need to tell the service file what user/group it should be running under

```shell
sysrc whisparr_user="USER_YOU_WANT"
```

```shell
sysrc whisparr_group="GROUP_YOU_WANT"
```

`whisparr` stores its data, config, logs, and PID files in `/usr/local/whisparr` by default. The service file will create this and take ownership of it IF AND ONLY IF IT DOES NOT EXIST. If you want to store these files in a different place (e.g., a dataset mounted into the jail for easier snapshots) then you will need to change it using `sysrc`

```shell
sysrc whisparr_data_dir="DIR_YOU_WANT"
```

Reminder: If you are using an existing location then you will manually need to either: change the ownership to the UID/GID `whisparr` uses AND/OR add `whisparr` to a GID that has write access.

Almost done, let's start the service:

```shell
service whisparr start
```

If everything went according to plan then whisparr should be up and running on the IP of the jail (port 6969)!

You can now safely close the shell

## Troubleshooting

- The service appears to be running but the UI is not loading or the page is timing out
  - Double check that `allow_mlock` is enabled in the jail

- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail, ip6=inherit, or ip6=new

> The service script should now work around the lack of VNET and/or IP6 thus removing the requirement for VNET or ip6=inherit
{.is-info}

# Docker

The Whisparr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Whisparr Docker image.

## Avoid Common Pitfalls

### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Whisparr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Movie.2018/`, but in the Whisparr container that might be at `/downloads/My.Movie.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/movies` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Whisparr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Movies would be in `/data/Movies`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Whisparr web UI (Settings › Download Clients).

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Whisparr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Whisparr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Whisparr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the :nightly ~~or :develop~~ tags with docker images, as there is no master nor develop branch. [See this FAQ entey for the meaning of the branches](/whisparr/faq#how-do-i-update-whisparr)
{.is-whisparr}

- [hotio/whisparr](https://hotio.dev/containers/whisparr/)
{.links-list}

# Reverse Proxy Configuration

Sample config examples for configuring Whisparr to be accessible from the outside world through a reverse proxy.

> These examples assumes the default port of `6969` and that you set a baseurl of `whisparr`. It also assumes your web server i.e nginx and Whisparr running on the same server accessible at `localhost` (127.0.0.1). If not, use the host IP address or hostname instead for the proxy pass directive.
{.is-info}

## NGINX

Add the following configuration to `nginx.conf` located in the root of your Nginx configuration. The code block should be added inside the `server context`. [Full example of a typical Nginx configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

> If you're using a non-standard http/https server port, make sure your Host header also includes it, i.e.: `proxy_set_header Host $host:$server_port` {.is-warning}

```nginx
location /whisparr {
    proxy_pass http://127.0.0.1:6969;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;
}
# Allow the API External Access via NGINX
location ~ /whisparr/api {
    auth_request off;
    proxy_pass http://127.0.0.1:6969;
}
```

A better way to organize your configuration files for Nginx would be to store the configuration for each site in a separate file.
To achieve this it is required to modify `nginx.conf` and add `include subfolders-enabled/*.conf` in the `server` context. So it will look something like this.

```nginx
server {
  listen 80;
  server_name _;

  # more configuration

  include subfolders-enabled/*.conf
}
```

Adding this line will include all files that end with `.conf` to the Nginx configuration. Make a new directory called `subfolders-enabled` in the same folder as your `nginx.conf` file is located. In that folder create a file with a recognizable name that ends with .conf. Add the configuration from above from the file and restart or reload Nginx. You should be able to visit Whisparr at `yourdomain.tld/whisparr`. tld is short for [Top Level Domain](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)

### Subdomain

Alternatively you can use a subdomain for whisparr. In this case you would visit `whisparr.yourdomain.tld`. For this you would need to configure a `A record` or `CNAME record` in your DNS.
> Many free DNS providers do not support this {.is-warning}

By default Nginx includes the `sites-enabled` folder. You can check this in `nginx.conf`, if not you can add it using the [include directive](http://nginx.org/en/docs/ngx_core_module.html#include). And really important, it has to be inside the `http context`. Now create a config file inside the sites-enabled folder and enter the following configuration.

> For this configuration it is recommended to set baseurl to '' (empty). This configuration assumes you are using the default `6969` and Whisparr is accessible on the localhost (127.0.0.1). For this configuration the subdomain `whisparr` is chosen (line 5). {.is-info}

> If you're using a non-standard http/https server port, make sure your Host header also includes it, i.e.: `proxy_set_header Host $host:$server_port` {.is-warning}

```nginx
server {
  listen      80;
  listen [::]:80;

  server_name whisparr.*;

  location / {
    proxy_set_header   Host $host;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host $host;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;

    proxy_redirect     off;
    proxy_http_version 1.1;

    proxy_pass http://127.0.0.1:6969;
  }
}
```

Now restart Nginx and Whisparr should be available at your selected subdomain.

## Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `whisparr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /whisparr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:6969/whisparr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:6969/whisparr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

Or for making an entire VirtualHost for Whisparr:

```none
ProxyPass / http://127.0.0.1:6969/whisparr/
ProxyPassReverse / http://127.0.0.1:6969/whisparr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/whisparr/api/`

# Multiple Instances

It is possible to run multiple instances of Whisparr. This is typically done when one wants a 4K and 1080p copy of a movie. Note that you can (and probably should) [review TRaSH's guide and configure Whisparr to use a second Whisparr as a list](https://trash-guides.info/Whisparr/Tips/Sync-2-whisparr-sonarr/). This is helpful if you wish to keep both in sync.

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

This guide will show you how to run multiple instances of Whisparr on Windows using only one base installation. This guide was put together using Windows 10; if you are using a previous version of Windows (7, 8, etc.) you may need to adjust some things. This guide also assumes that you have installed Whisparr to the default directory, and your second instance of Whisparr will be called Whisparr-4K. Feel free to change things to fit your own installations, though.

### Service (Windows)

#### Prerequisites (Service)

- [You must have Whisparr already installed](#windows)
- You must have [NSSM (Non-Sucking Service Manager](http://nssm.cc) installed. To install, download the latest release (2.24 at the time of writing) and copy either the 32-bit or 64-bit nssm.exe file to C:/windows/system32.
  - If you aren’t sure if you have a 32-bit or 64-bit system, check Settings => System => About => System type.

#### Configuring Whisparr Service

1. Open a Command Prompt administrator window. (To run as an admin,
    right click on the Command Prompt icon and choose “Run as
    administrator.”)
1. If Whisparr is running, stop the service by running `nssm stop Whisparr`
    in Command Prompt.
1. Now we have to edit the existing Whisparr instance to explicitly point
    to its data directory. The default command is as follows:
    `sc config Whisparr binpath= "C:\ProgramData\Whisparr\bin\Whisparr.exe
    -data=C:\ProgramData\Whisparr"`

This command tells the original instance of Whisparr to explicitly use
`C:\ProgramData\Whisparr` for its data directory. If you didn't use the
default Whisparr install, or if your data folder is somewhere else, you
may have to change your paths here.

#### Creating Whisparr-4K Service

1. Create a new folder where you’d like Whisparr-4K to live. Most use a similar place such as
    `C:\ProgramData\Whisparr-4K`
1. Back in Command Prompt, create the new Whisparr-4K service using `nssm
    install Whisparr-4K`. A popup window will open where you can type your
    parameters for the new instance. For this example, we will use the
    following:
      - Path: `C:\ProgramData\Whisparr\bin\Whisparr.exe`
      - Startup directory: `C:\ProgramData\Whisparr\bin`
      - Arguments: `-data=C:\ProgramData\Whisparr-4K`
      - Exit Actions Tab
        - Restart: Restart Application
        - Delay: 120000 ms
        (2 minutes, can be longer if update fails to complete in time)

> Note that **Arguments** points to the *new* folder created in step 1.
This is crucial, as it keeps all the data files from both instances in
separate locations. {.is-warning}

1. Click *Install service*. The window should close and the service
    will now be available to run.
1. Continue to [Configuring Whisparr-4k](#windows-multi-config-second)

### Tray App (Windows)

#### Prerequisites (Tray App)

- [You must have Whisparr already installed](#windows)
- Whisparr must be configured with a `/data=` argument to allow multiple instances
- Navigate to the Startup Folder for the current user `%appdata%\Microsoft\Windows\Start Menu\Programs\Startup` and edit the existing shortcut if needed.

#### Creating Whisparr-4K Tray App

- Right click and Create New Shortcut
- Path: `C:\ProgramData\Whisparr\bin\Whisparr.exe /data=C:\ProgramData\Whisparr-4K`
- Give the shortcut a unique name such as `Whisparr-4K` and finish the wizard.
- Double click the new shortcut to run and test.
- Continue to [Configuring Whisparr-4k](#windows-multi-config-second)

### Configuring Whisparr-4k {#windows-multi-config-second}

- Regardless of if you used the Service Method or the Tray App: Stop both services and both Apps
- Start Whisparr-4k (Service or Tray App)
- Open up Whisparr-4k and Navigate within the app to [Settings => General => Host](/whisparr/settings/#host)
- Change `Port Number` from `6969` to a different port e.g. `6970` so Whisparr and Whisparr4k do not conflict
- You should now be able to start both apps
- Continue to [Dealing with Updates](#dealing-with-updates)

### Dealing with Updates

- Disable automatic updates in one of your instances
  - In config.xml change update branch to `<Branch>nonexistent</Branch>`
- If one Whisparr instance is updated, both instances will shutdown and only the updated one will start again. To fix this, you will have to manually start the other instance, or you may want to look into using the below powershell script to address the problem.

> Configuring the [NSSM Exit Action](#creating-whisparr-4k-service) correctly should allow Whisparr to update and restart multiple instances with no additional scripts.
If the restart delay is not configured by default it will restart the instance immediately.
This can prevent updates from being applied and can result in the following error `Whisparr was restarted prematurely by external process.`
{.is-info}

#### Windows Port Checker and Restarter PowerShell Script

- When you use two Whisparr instances and one of it is updating, it will kill all instances. Only the one which is updating will come back online.
- The below powershell script should be configured as a scheduled task.
- It checks the ports and if one is not online, it will (re-)start the scheduled task to launch Whisparr.

1. Create a new File and name it WhisparrInstancesChecker.ps1 with the below code.
1. Edit the script with your actual service names, IP, and ports.
1. [Create a scheduled task](https://www.thewindowsclub.com/schedule-task-in-windows-7-task-scheduler) to run the script on a repeating schedule.

- Security Options: Enable `Run with highest privileges`
  - Otherwise the script will be unable to manipulate services
- Trigger: `On Launch`
- Repeat task every: `5` or `10` minutes
- Action: `Start a Program`
- Program/script: `powershell`
- Argument: `-File D:\WhisparrInstancesChecker.ps1`
  - Be sure to use the full path to your script's location

```powershell
################################################################################################
### WhisparrInstancesChecker.ps1                                                               ###
################################################################################################
### Keeps multiple Whisparr Instances up by checking the port                                  ###
### Please use Whisparr´s Discord or Reddit for support!                                       ###
### https://wiki.servarr.com/whisparr/installation#windows-multi                               ###
################################################################################################
### Version: 1.1                                                                             ###
### Updated: 2020-10-22                                                                      ###
### Author:  reloxx13                                                                        ###
################################################################################################



### SET YOUR CONFIGURATION HERE ###
# Set your host ip and port correctly and use your service or scheduledtask names!

# (string) The type how Whisparr is starting
# "Service" (default) Service process is used
# "ScheduledTask" Task Scheduler is used
$startType = 'Service'

# (bool) Writes the log to C:\Users\YOURUSERNAME\log.txt when enabled
# $false (default)
# $true
$logToFile = $false


$instances = @(
    [pscustomobject]@{   # Instance 1
        Name = 'Whisparr-V3'; # (string) Service or Task name (default: Whisparr-V3)
        IP   = '192.168.178.12'; # (string) Server IP where Whisparr runs (default: 192.168.178.12)
        Port = '7873'; # (string) Server Port where Whisparr runs (default: 7873)
    }
    [pscustomobject]@{   # Instance 2
        Name = 'Whisparr-4K'; # (string) Service or Task name (default: Whisparr-4K)
        IP   = '192.168.178.12'; # (string) Server IP where Whisparr runs (default: 192.168.178.12)
        Port = '7874'; # (string) Server Port where Whisparr runs (default: 7874)
    }
    # If needed you can add more instances here... by uncommenting out the below lines
    # [pscustomobject]@{   # Instance 3
    # Name='Whisparr-3D';    # (string) Service or Task name (default: Whisparr-3D)
    # IP='192.168.178.12'; # (string) Server IP where Whisparr runs (default: 192.168.178.12)
    # Port='7875';         # (string) Server Port where Whisparr runs (default: 7875)
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

- [Swizzin Users](https://github.com/ComputerByte/whisparr4k)
- Non-Swizzin Users
  - Ensure your first instance has the `-data=` argument passed.
  - Temporarily stop your first instance, so you can change the second instance's port `systemctl stop whisparr`
  - Disable automatic updates on one of your Whisparr Instances`

> Below is an example script to create a Whisparr4K instance. The below systemd creation script will use a data directory of `/var/lib/whisparr4k/`. Ensure the directory exists or modify it as needed.{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/whisparr4k.service > /dev/null
[Unit]
Description=Whisparr4k Daemon
After=syslog.target network.target
[Service]
User=whisparr
Group=media
Type=simple

ExecStart=/opt/Whisparr/Whisparr -nobrowser -data=/var/lib/whisparr4k/
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

- Enable the Whisparr4k service:

```shell
sudo systemctl enable --now -q whisparr4k
```

## Docker Multiple Instances

{#docker-multi}

- Simply spin up a second Docker container with a different name, ensuring the above requirements are met.
