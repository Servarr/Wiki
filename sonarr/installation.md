---
title: Sonarr Installation
description: 
published: true
date: 2022-03-06T22:17:55.296Z
tags: sonarr
editor: markdown
dateCreated: 2021-07-10T16:07:37.425Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Windows](#windows)
- [MacOS (OSX)](#macos-osx)
- [Linux](#linux)
- [FreeBSD](#freebsd)
  - [Jail Setup Using TrueNAS GUI](#jail-setup-using-truenas-gui)
  - [Sonarr Installation](#sonarr-installation)
  - [Configuring Sonarr](#configuring-sonarr)
    - [Service Setup](#service-setup)
  - [Troubleshooting](#troubleshooting)
- [Synology](#synology)
  - [Synology Mono SSL Errors](#synology-mono-ssl-errors)
- [Docker](#docker)
  - [Avoid Common Pitfalls](#avoid-common-pitfalls)
    - [Volumes and Paths](#volumes-and-paths)
    - [Ownership and Permissions](#ownership-and-permissions)
  - [Install Sonarr](#install-sonarr)
- [Reverse Proxy Configuration](#reverse-proxy-configuration)
  - [NGINX](#nginx)
    - [Subdomain](#subdomain)
  - [Apache](#apache)
- [Multiple Instances](#multiple-instances)
  - [Windows Multiple Instances](#windows-multiple-instances)
    - [Service (Windows)](#service-windows)
      - [Prerequisites (Service)](#prerequisites-service)
      - [Configuring Sonarr Service](#configuring-sonarr-service)
      - [Creating Sonarr-4K Service](#creating-sonarr-4k-service)
    - [Tray App (Windows)](#tray-app-windows)
      - [Prerequisites (Tray App)](#prerequisites-tray-app)
      - [Creating Sonarr-4K Tray App](#creating-sonarr-4k-tray-app)
    - [Configuring Sonarr-4k {#windows-multi-config-second}](#configuring-sonarr-4k-windows-multi-config-second)
    - [Dealing with Updates](#dealing-with-updates)
      - [Windows Port Checker and Restarter PowerShell Script](#windows-port-checker-and-restarter-powershell-script)
  - [Linux Multiple Instances](#linux-multiple-instances)
  - [Docker Multiple Instances](#docker-multiple-instances)

# Windows

Sonarr is supported natively on Windows. Sonarr can be installed on Windows as Windows Service or system tray application.

> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services cannot access network drives (X:\ mapped drives or \\\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Sonarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You will likely have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Sonarr\config.xml` is denied -- or you use mapped network drives. This gives Sonarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Sonarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:8989> to start using Sonarr

- [Windows x32 Installer](https://services.sonarr.tv/v1/download/main/latest?version=3&os=windows&installer=true)
{.links-list}

> It is possible to install Sonarr manually using the [x32 .zip download](https://services.sonarr.tv/v1/download/main/latest?version=3&os=windows). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

# MacOS (OSX)

{#OSX}

> Sonarr will eventually be no longer compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://services.sonarr.tv/v1/download/main/latest?version=3&os=macos&installer=true)
1. Open the archive and drag the Sonarr icon to your Application folder.
1. Self-sign Sonarr `codesign --force --deep -s - Sonarr.app`
1. Browse to <http://localhost:8989> to start using Sonarr

# Linux

- [Please see the website for instructions](https://sonarr.tv/#downloads-v3-linux)
- Put together the instructions should be:
  - [Add the Mono Repository](https://www.mono-project.com/download/stable/#download-lin-ubuntu)
  - [Add the MediaInfo Repository](/lidarr/installation)
  - [Install Sonarr](https://sonarr.tv/#downloads-v3-linux)
- For Ubuntu 20.04 this will *likely* look like

```bash
# Add Mono Repo (20.04)
sudo apt install gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
# Get MediaInfo
wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-19_all.deb && sudo dpkg -i repo-mediaarea_1.0-19_all.deb
# Add the Sonarr Repo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8
echo "deb https://apt.sonarr.tv/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/sonarr.list
# Apt Update
sudo apt update
# Install Sonarr
sudo apt install sonarr
```

- A common issue experienced by users after installing is related to SSL Certificate Validation issues. This can be resolved by syncing mono's certs

```bash
sudo cert-sync /etc/ssl/certs/ca-certificates.crt
```

# FreeBSD

The Sonarr team only provides builds for FreeBSD. Plugins and Ports are maintained and created by the FreeBSD community.

Instructions for FreeBSD installations are also maintained by the FreeBSD community and anyone with a GitHub account may update the wiki as needed.

[Freshports Sonarr Link](https://www.freshports.org/net-p2p/sonarr/)

## Jail Setup Using TrueNAS GUI

1. From the main screen select Jails

1. Click ADD

1. Click Advanced Jail Creation

1. Name (any name will work): Sonarr

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

## Sonarr Installation

Back on the jails list find your newly created jail for `sonarr` and click "Shell"

To install Sonarr

> \* Ensure your pkg repo is configured to get packages from `/latest` and not `/quarterly`
> \* Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
>   \* If that does not exist, copy over `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

```shell
pkg install sonarr
```

Don't close the shell out yet we still have a few more things!

## Configuring Sonarr

Now that we have it installed a few more steps are required.

### Service Setup

Time to enable the service but before we do, a note:

The updater is disabled by default. The `pkg-message` gives instructions on how to enable the updater but keep in mind: this can break things like `pkg check -s` and `pkg remove` for Sonarr when the built-in updater replaces files.

To enable the service:

```shell
sysrc sonarr_enable=TRUE
```

If you do not want to use user/group `sonarr` you will need to tell the service file what user/group it should be running under

```shell
sysrc sonarr_user="USER_YOU_WANT"
```

```shell
sysrc sonarr_group="GROUP_YOU_WANT"
```

`sonarr` stores its data, config, logs, and PID files in `/usr/local/sonarr` by default. The service file will create this and take ownership of it IF AND ONLY IF IT DOES NOT EXIST. If you want to store these files in a different place (e.g., a dataset mounted into the jail for easier snapshots) then you will need to change it using `sysrc`

```shell
sysrc sonarr_data_dir="DIR_YOU_WANT"
```

Reminder: If you are using an existing location then you will manually need to either: change the ownership to the UID/GID `sonarr` uses AND/OR add `sonarr` to a GID that has write access.

Almost done, let's start the service:

```shell
service sonarr start
```

If everything went according to plan then sonarr should be up and running on the IP of the jail (port 8989)!

You can now safely close the shell

## Troubleshooting

- The service appears to be running but the UI is not loading or the page is timing out
  - Double check that `allow_mlock` is enabled in the jail
  
- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail, ip6=inherit, or ip6=new

> The service script should now work around the lack of VNET and/or IP6 thus removing the requirement for VNET or ip6=inherit
{.is-info}

- SSL or other Certificate issues (i.e. `unable to verify SSL certificate`)
  - See [this TrueNAS forum post as you'll need to update and sync mono's certs](https://www.truenas.com/community/threads/sonarr-radarr-probably-other-arr-jails-unable-to-verify-ssl-certificates-after-latest-update.96008/)

# Synology

- [The SynoCommunity creates, supports,and maintains a Synology NAS Package](https://synocommunity.com/package/nzbdrone)

> The NAS package is poorly maintained and frequently out of date. If your NAS supports docker it is strongly recommended [to run docker](https://trash-guides.info/Hardlinks/How-to-setup-for/Synology/) instead. You will not be able to reinstall Sonarr without wiping your database manually due to the NAS package being out of date and not configured to update itself on startup. {.is-info}

- [SynoCommunity also creates, supports, and maintains the required Mono Package](https://synocommunity.com/package/mono)

## Synology Mono SSL Errors

> Due to a bug introduced by SynoCommunity's poorly maintained Mono package. Sonarr will fail to connect after updating Mono or after a fresh installation.  This can be resolved by following the instructions on [this SynoCommunity Bug Report](https://github.com/SynoCommunity/spksrc/issues/5051#issuecomment-1009758625)
{.is-danger}

1. Within DSM, enable SSH service in *Control Panel => Terminal & SNMP* and click apply
1. Using [Terminal](https://support.apple.com/en-gb/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac) (MacOS) connect to the NAS using `ssh -l [admin username] [NAS address]` or using [Putty](https://www.putty.org/) (Windows) connect to the network address of your NAS
1. Enter the required admin password and press enter
1. Enter the following command noted below and press enter
  - DSM6 `sudo /var/packages/mono/target/bin/cert-sync /etc/ssl/certs/ca-certificates.crt`
  - DSM7 `sudo /volume1/@appstore/mono/bin/cert-sync /etc/ssl/certs/ca-certificates.crt`
1. Enter the required admin password and press enter. When complete you should see the line *Import process completed*
1. Disconnect the SSH session by typing `exit` and press enter
1. Within DSM, disable the SSH service in *Control Panel => Terminal & SNMP* and click apply
1. Once complete the errors in Sonarr should disappear on their own in a few minutes.

# Docker

The Sonarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

These instructions provide generic guidance that should apply to any Sonarr Docker image.

## Avoid Common Pitfalls

### Volumes and Paths

There are two common problems with Docker volumes: Paths that differ between the Sonarr and download client container and paths that prevent fast moves and hard links.

The first is a problem because the download client will report a download's path as `/torrents/My.Series.2018/`, but in the Sonarr container that might be at `/downloads/My.Series.2018/`. The second is a performance issue and causes problems for seeding torrents. Both problems can be solved with well planned, consistent paths.

Most Docker images suggest paths like `/tv` and `/downloads`. This causes slow moves and doesn't allow hard links because they are considered two different file systems inside the container. Some also recommend paths for the download client container that are different from the Sonarr container, like /torrents.

The best solution is to use a single, common volume inside the containers, such as /data. Your Series would be in `/data/Series`, torrents in `/data/downloads/torrents` and/or usenet downloads in `/data/downloads/usenet`.

If this advice is not followed, you may have to configure a Remote Path Mapping in the Sonarr web UI (Settings › Download Clients).

### Ownership and Permissions

Permissions and ownership of files is one of the most common problems for Sonarr users, both inside and outside Docker. Most images have environment variables that can be used to override the default user, group and umask, you should decide this before setting up all of your containers. The recommendation is to use a common group for all related containers so that each container can use the shared group permissions to read and write files on the mounted volumes.
Keep in mind that Sonarr will need read and write to the download folders as well as the final folders.

> For a more detailed explanation of these issues, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Sonarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

- [hotio/sonarr](https://hotio.dev/containers/sonarr/)
- [lscr.io/linuxserver/sonarr](https://docs.linuxserver.io/images/docker-sonarr)
{.links-list}

# Reverse Proxy Configuration

Sample config examples for configuring Sonarr to be accessible from the outside world through a reverse proxy.

> These examples assumes the default port of `8989` and that you set a baseurl of `sonarr`. It also assumes your web server i.e nginx and Sonarr running on the same server accessible at `localhost` (127.0.0.1). If not, use the host IP address or hostname instead for the proxy pass directive.
{.is-info}

## NGINX

Add the following configuration to `nginx.conf` located in the root of your Nginx configuration. The code block should be added inside the `server context`. [Full example of a typical Nginx configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

```nginx
location /sonarr {
  proxy_pass         http://127.0.0.1:8989/sonarr;
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

Adding this line will include all files that end with `.conf` to the Nginx configuration. Make a new directory called `subfolders-enabled` in the same folder as your `nginx.conf` file is located. In that folder create a file with a recognizable name that ends with .conf. Add the configuration from above from the file and restart or reload Nginx. You should be able to visit Sonarr at `yourdomain.tld/sonarr`. tld is short for [Top Level Domain](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)

### Subdomain

Alternatively you can use a subdomain for sonarr. In this case you would visit `sonarr.yourdomain.tld`. For this you would need to configure a `A record` or `CNAME record` in your DNS.
> Many free DNS providers do not support this {.is-warning}

By default Nginx includes the `sites-enabled` folder. You can check this in `nginx.conf`, if not you can add it using the [include directive](http://nginx.org/en/docs/ngx_core_module.html#include). And really important, it has to be inside the `http context`. Now create a config file inside the sites-enabled folder and enter the following configuration.

> For this configuration it is recommended to set baseurl to '' (empty). This configuration assumes you are using the default `8989` and Sonarr is accessible on the localhost (127.0.0.1). For this configuration the subdomain `sonarr` is chosen (line 5). {.is-info}

```nginx
server {
  listen      80;
  listen [::]:80;

  server_name sonarr.*;

  location / {
    proxy_set_header   Host $host;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host $host;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;

    proxy_redirect     off;
    proxy_http_version 1.1;
    
    proxy_pass http://127.0.0.1:8989;
  }
}
```

Now restart Nginx and Sonarr should be available at your selected subdomain.

## Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `sonarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /sonarr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:8989/sonarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:8989/sonarr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

Or for making an entire VirtualHost for Sonarr:

```none
ProxyPass / http://127.0.0.1:8989/sonarr/
ProxyPassReverse / http://127.0.0.1:8989/sonarr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/sonarr/api/`
- `/sonarr/Content/`

# Multiple Instances

It is possible to run multiple instances of Sonarr. This is typically done when one wants a 4K and 1080p copy of a movie.
Note that you can configure Sonarr to use a second Sonarr as a list. This is helpful if you wish to keep both in sync.

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

This guide will show you how to run multiple instances of Sonarr on Windows using only one base installation. This guide was put together using Windows 10; if you are using a previous version of Windows (7, 8, etc.) you may need to adjust some things. This guide also assumes that you have installed Sonarr to the default directory, and your second instance of Sonarr will be called Sonarr-4K. Feel free to change things to fit your own installations, though.

### Service (Windows)

#### Prerequisites (Service)

- [You must have Sonarr already installed](#windows)
- You must have [NSSM (Non-Sucking Service Manager](http://nssm.cc) installed. To install, download the latest release (2.24 at the time of writing) and copy either the 32-bit or 64-bit nssm.exe file to C:/windows/system32.
  - If you aren’t sure if you have a 32-bit or 64-bit system, check Settings => System => About => System type.

#### Configuring Sonarr Service

1. Open a Command Prompt administrator window. (To run as an admin,
    right click on the Command Prompt icon and choose “Run as
    administrator.”)
1. If Sonarr is running, stop the service by running `nssm stop Sonarr`
    in Command Prompt.
1. Now we have to edit the existing Sonarr instance to explicitly point
    to its data directory. The default command is as follows:
    `sc config Sonarr binpath= "C:\ProgramData\Sonarr\bin\Sonarr.exe
    -data=C:\ProgramData\Sonarr"`

This command tells the original instance of Sonarr to explicitly use
`C:\ProgramData\Sonarr` for its data directory. If you didn't use the
default Sonarr install, or if your data folder is somewhere else, you
may have to change your paths here.

#### Creating Sonarr-4K Service

1. Create a new folder where you’d like Sonarr-4K to live. Most use a similar place such as
    `C:\ProgramData\Sonarr-4K`
1. Back in Command Prompt, create the new Sonarr-4K service using `nssm
    install Sonarr-4K`. A popup window will open where you can type your
    parameters for the new instance. For this example, we will use the
    following:
      - Path: `C:\ProgramData\Sonarr\bin\Sonarr.exe`
      - Startup directory: `C:\ProgramData\Sonarr\bin`
      - Arguments: `-data=C:\ProgramData\Sonarr-4K`

> Note that **Arguments** points to the *new* folder created in step 1.
This is crucial, as it keeps all the data files from both instances in
separate locations. {.is-warning}

1. Click *Install service*. The window should close and the service
    will now be available to run.
1. Continue to [Configuring Sonarr-4k](#windows-multi-config-second)

### Tray App (Windows)

#### Prerequisites (Tray App)

- [You must have Sonarr already installed](#windows)
- Sonarr must be configured with a `/data=` argument to allow multiple instances
- Navigate to the Startup Folder for the current user `%appdata%\Microsoft\Windows\Start Menu\Programs\Startup` and edit the existing shortcut if needed.

#### Creating Sonarr-4K Tray App

- Right click and Create New Shortcut
- Path: `C:\ProgramData\Sonarr\bin\Sonarr.exe /data=C:\ProgramData\Sonarr-4K`
- Give the shortcut a unique name such as `Sonarr-4K` and finish the wizard.
- Double click the new shortcut to run and test.
- Continue to [Configuring Sonarr-4k](#windows-multi-config-second)

### Configuring Sonarr-4k {#windows-multi-config-second}

- Regardless of if you used the Service Method or the Tray App: Stop both services and both Apps
- Start Sonarr-4k (Service or Tray App)
- Open up Sonarr-4k and Navigate within the app to [Settings => General => Host](/sonarr/settings/#host)
- Change `Port Number` from `8989` to a different port e.g. `7879` so Sonarr and Sonarr4k do not conflict
- You should now be able to start both apps
- Continue to [Dealing with Updates](#dealing-with-updates)

### Dealing with Updates

- Disable automatic updates in one of your instances
- If one Sonarr instance is updated, both instances will shutdown and only the updated one will start again. To fix this, you will have to manually start the other instance, or you may want to look into using the below powershell script to address the problem.

#### Windows Port Checker and Restarter PowerShell Script

- When you use two Sonarr instances and one of it is updating, it will kill all instances. Only the one which is updating will come back online.
- The below powershell script should be configured as a scheduled task.
- It checks the ports and if one is not online, it will (re-)start the scheduled task to launch Sonarr.

1. Create a new File and name it SonarrInstancesChecker.ps1 with the below code.
1. Edit the script with your actual service names, IP, and ports.
1. [Create a scheduled task](https://www.thewindowsclub.com/schedule-task-in-windows-7-task-scheduler) to run the script on a repeating schedule.

- Security Options: Enable `Run with highest privileges`
  - Otherwise the script will be unable to manipulate services
- Trigger: `On Launch`
- Repeat task every: `5` or `10` minutes
- Action: `Start a Program`
- Program/script: `powershell`
- Argument: `-File D:\SonarrInstancesChecker.ps1`
  - Be sure to use the full path to your script's location

```powershell
################################################################################################
### SonarrInstancesChecker.ps1                                                               ###
################################################################################################
### Keeps multiple Sonarr Instances up by checking the port                                  ###
### Please use Sonarr´s Discord or Reddit for support!                                       ###
### https://wiki.servarr.com/sonarr/installation#windows-multi                               ###
################################################################################################
### Version: 1.1                                                                             ###
### Updated: 2020-10-22                                                                      ###
### Author:  reloxx13                                                                        ###
################################################################################################



### SET YOUR CONFIGURATION HERE ###
# Set your host ip and port correctly and use your service or scheduledtask names!

# (string) The type how Sonarr is starting
# "Service" (default) Service process is used
# "ScheduledTask" Task Scheduler is used
$startType = 'Service'

# (bool) Writes the log to C:\Users\YOURUSERNAME\log.txt when enabled
# $false (default)
# $true
$logToFile = $false


$instances = @(
    [pscustomobject]@{   # Instance 1
        Name = 'Sonarr-V3'; # (string) Service or Task name (default: Sonarr-V3)
        IP   = '192.168.178.12'; # (string) Server IP where Sonarr runs (default: 192.168.178.12)
        Port = '7873'; # (string) Server Port where Sonarr runs (default: 7873)
    }
    [pscustomobject]@{   # Instance 2
        Name = 'Sonarr-4K'; # (string) Service or Task name (default: Sonarr-4K)
        IP   = '192.168.178.12'; # (string) Server IP where Sonarr runs (default: 192.168.178.12)
        Port = '7874'; # (string) Server Port where Sonarr runs (default: 7874)
    }
    # If needed you can add more instances here... by uncommenting out the below lines
    # [pscustomobject]@{   # Instance 3
    # Name='Sonarr-3D';    # (string) Service or Task name (default: Sonarr-3D)
    # IP='192.168.178.12'; # (string) Server IP where Sonarr runs (default: 192.168.178.12)
    # Port='7875';         # (string) Server Port where Sonarr runs (default: 7875)
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

- [Swizzin Users](https://github.com/ComputerByte/sonarr4k)
- Non-Swizzin Users
  - Ensure your first instance has the `-data=` argument passed.
  - Temporarily stop your first instance, so you can change the second instance's port `systemctl stop sonarr`
  - Disable automatic updates on one of your Sonarr Instances`

> Below is an example script to create a Sonarr4K instance. The below systemd creation script will use a data directory of `/var/lib/sonarr4k/`. Ensure the directory exists or modify it as needed.{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/sonarr4k.service > /dev/null
[Unit]
Description=Sonarr4k Daemon
After=syslog.target network.target
[Service]
User=sonarr
Group=media
Type=simple

ExecStart=mono --debug /usr/lib/sonarr/bin/Sonarr.exe -nobrowser -data=/var/lib/sonarr4k/
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

- Enable the Sonarr4k service:

```shell
sudo systemctl enable --now -q sonarr4k
```

## Docker Multiple Instances

{#docker-multi}

- Simply spin up a second Docker container with a different name, ensuring the above requirements are met.
