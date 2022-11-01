---
title: Prowlarr Installation
description: 
published: true
date: 2022-11-01T00:03:10.282Z
tags: prowlarr
editor: markdown
dateCreated: 2021-05-24T05:07:51.882Z
---

# Table of Contents

- [Table of Contents](#table-of-contents)
- [Windows](#windows)
- [MacOS (OSX)](#macos-osx)
- [Linux](#linux)
  - [Debian / Ubuntu](#debian-ubuntu)
    - [Easy Install](#easy-install)
    - [Debian / Ubuntu Hands on Install](#debian-ubuntu-hands-on-install)
    - [Uninstall](#uninstall)
- [FreeBSD](#freebsd)
  - [Jail Setup Using TrueNAS GUI](#jail-setup-using-truenas-gui)
  - [Prowlarr Installation](#prowlarr-installation)
  - [Configuring Prowlarr](#configuring-prowlarr)
    - [Service Setup](#service-setup)
  - [Troubleshooting](#troubleshooting)
- [Docker](#docker)
  - [Install Prowlarr](#install-prowlarr)
- [Reverse Proxy Configuration](#reverse-proxy-configuration)
  - [NGINX](#nginx)
    - [Subdomain](#subdomain)
  - [Apache](#apache)
    - [Using SSL on the reverse proxy](#using-ssl-on-the-reverse-proxy)

# Windows

Prowlarr is supported natively on Windows. Prowlarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in.
Otherwise, a system tray application can be used if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing if you get an access error such as Access to the path `C:\ProgramData\Prowlarr\config.xml` is denied -- or you use mapped network drives. This gives Prowlarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

1. Download the latest version of Prowlarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:9696> to start using Prowlarr

- [Windows x64 Installer](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Prowlarr manually using the [x64 .zip download](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}

> If you use [Certify The Web](https://docs.certifytheweb.com/docs/backgroundservice/) for LetsEncrypt certificate management for IIS and are installing Prowlarr on the same machine, port `9696` is used by the background service. You will need to either change the listening port of Prowlarr in your `config.xml` to something else or change the port of the Certify The Web background service.
{.is-info}

# MacOS (OSX)

{#OSX}
  
> Prowlarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://prowlarr.servarr.com/v1/update/develop/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system
1. Open the archive and drag the Prowlarr icon to your Application folder.
1. Self-sign Prowlarr `codesign --force --deep -s - Prowlarr.app`
1. Browse to <http://localhost:9696> to start using Prowlarr

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
> \* You created the directory `/var/lib/prowlarr` and ensured the user `prowlarr` has read/write permissions for it
{.is-danger}

> By continuing below, you acknowledge that you have read and met the above requirements. {.is-warning}

- Download the correct binaries for your architecture.
  - You can determine your architecture with `dpkg --print-architecture`
    - AMD64 use `arch=x64`
    - ARM, armf, and armh use `arch=arm`
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

> The below systemd creation script will use a data directory of `/var/lib/prowlarr`. Ensure it exists or modify it as needed. For the default data directory of `/home/$USER/.config/Prowlarr` simply remove the `-data` argument. Note: that `$USER` is the User Prowlarr runs as and is defined below.
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

Typically to access the Prowlarr web GUI browse to `http://{Your server IP Address}:9696`

If Prowlarr did not appear to start, then check the status of the service:

```shell
sudo journalctl --since today -u prowlarr
```

---

### Uninstall

To uninstall and purge:
> Warning: This will destroy your application data. {.is-danger}

```bash
sudo systemctl stop prowlarr
sudo rm -rf /opt/Prowlarr
sudo rm -rf /var/lib/prowlarr
sudo rm -rf /etc/systemd/system/prowlarr.service
sudo systemctl -q daemon-reload
```

To uninstall and keep your application data:

```bash
sudo systemctl stop prowlarr
sudo rm -rf /opt/Prowlarr
sudo rm -rf /etc/systemd/system/prowlarr.service
sudo systemctl -q daemon-reload
```

# FreeBSD

The Prowlarr team only provides builds for FreeBSD. Plugins and Ports are maintained and created by the FreeBSD community.

Instructions for FreeBSD installations are also maintained by the FreeBSD community and anyone with a GitHub account may update the wiki as needed.

[Freshports Prowlarr Link](https://www.freshports.org/net-p2p/prowlarr/)

## Jail Setup Using TrueNAS GUI

1. From the main screen select Jails

1. Click ADD

1. Click Advanced Jail Creation

1. Name (any name will work): Prowlarr

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

## Prowlarr Installation

Back on the jails list find your newly created jail for `prowlarr` and click "Shell"

To install Prowlarr

> \* Ensure your pkg repo is configured to get packages from `/latest` and not `/quarterly`
> \* Check `/usr/local/etc/pkg/repos/FreeBSD.conf`
> \* If that does not exist, copy over `/etc/pkg/FreeBSD.conf` to that location, open it, and replace `quarterly` with `latest`
{.is-warning}

```shell
pkg install prowlarr
```

Don't close the shell out yet we still have a few more things!

## Configuring Prowlarr

Now that we have it installed a few more steps are required.

### Service Setup

Time to enable the service but before we do, a note:

The updater is disabled by default. The `pkg-message` gives instructions on how to enable the updater but keep in mind: this can break things like `pkg check -s` and `pkg remove` for prowlarr when the built-in updater replaces files.

To enable the service:

```shell
sysrc prowlarr_enable=TRUE
```

If you do not want to use user/group `prowlarr` you will need to tell the service file what user/group it should be running under

```shell
sysrc prowlarr_user="USER_YOU_WANT"
```

```shell
sysrc prowlarr_group="GROUP_YOU_WANT"
```

`prowlarr` stores its data, config, logs, and PID files in `/usr/local/prowlarr` by default. The service file will create this and take ownership of it IF AND ONLY IF IT DOES NOT EXIST. If you want to store these files in a different place (e.g., a dataset mounted into the jail for easier snapshots) then you will need to change it using `sysrc`

```shell
sysrc prowlarr_data_dir="DIR_YOU_WANT"
```

Reminder: If you are using an existing location then you will manually need to either: change the ownership to the UID/GID `prowlarr` uses AND/OR add `prowlarr` to a GID that has write access.

Almost done, let's start the service:

```shell
service prowlarr start
```

If everything went according to plan then prowlarr should be up and running on the IP of the jail (port 9696)!

You can now safely close the shell

## Troubleshooting

- The service appears to be running but the UI is not loading or the page is timing out
  - Double check that `allow_mlock` is enabled in the jail
  
- `System.NET.Sockets.SocketException (43): Protocol not supported`
  - Make sure you have `VNET` turned on for your jail, ip6=inherit, or ip6=new

> The service script should now work around the lack of VNET and/or IP6 thus removing the requirement for VNET or ip6=inherit
{.is-info}

# Docker

The Prowlarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

> For a more detailed explanation of docker and suggested practices, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

## Install Prowlarr

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the `:nightly` or `:develop` tags with docker images, as there is no `master` branch. [See this FAQ entey for the meaning of the branches](/prowlarr/faq#how-do-i-update-prowlarr)
{.is-warning}

- [hotio/prowlarr](https://hotio.dev/containers/prowlarr/)
- [lscr.io/linuxserver/prowlarr](https://github.com/linuxserver/docker-prowlarr)
{.links-list}

# Reverse Proxy Configuration

Sample config examples for configuring Prowlarr to be accessible through a reverse proxy.

> These examples assumes the default port of `9696` and that you set a baseurl of `prowlarr`. It also assumes your web server i.e nginx and Prowlarr running on the same server accessible at `localhost`. If not, use the host IP address or a FQDN instead.
{.is-info}

## NGINX

Add the following configuration to `nginx.conf` located in the root of your Nginx configuration. The code block should be added inside the `server context`. [Full example of a typical Nginx configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

> If you're using a non-standard http/https server port, make sure your Host header also includes it, i.e.: `proxy_set_header Host $host:$server_port` {.is-warning}

```nginx
location ~ /prowlarr {
    proxy_pass http://127.0.0.1:9696;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;
}
# Allow the API/Indexer External Access via NGINX
location ^~ /prowlarr(/[0-9]+)?/api {
    auth_basic off;
    proxy_pass http://127.0.0.1:9696;
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

Adding this line will include all files that end with `.conf` to the Nginx configuration. Make a new directory called `subfolders-enabled` in the same folder as your `nginx.conf` file is located. In that folder create a file with a recognizable name that ends with .conf. Add the configuration from above from the file and restart or reload Nginx. You should be able to visit Radarr at `yourdomain.tld/radarr`. tld is short for [Top Level Domain](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)

### Subdomain

Alternatively you can use a subdomain for radarr. In this case you would visit `radarr.yourdomain.tld`. For this you would need to configure a `A record` or `CNAME record` in your DNS.
> Many free DNS providers do not support this {.is-warning}
By default Nginx includes the `sites-enabled` folder. You can check this in `nginx.conf`, if not you can add it using the [include directive](http://nginx.org/en/docs/ngx_core_module.html#include). And really important, it has to be inside the `http context`. Now create a config file inside the sites-enabled folder and enter the following configuration.
> For this configuration it is recommended to set baseurl to '' (empty). This configuration assumes you are using the default `7878` and Radarr is accessible on the localhost (127.0.0.1). For this configuration the subdomain `radarr` is chosen (line 5).
{.is-info}
> If you're using a non-standard http/https server port, make sure your Host header also includes it, i.e.: `proxy_set_header Host $host:$server_port`
{.is-warning}

```nginx
server {
  listen      80;
  listen [::]:80;
  server_name prowlarr.*;
  location / {
    proxy_set_header   Host $host;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host $host;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;
    proxy_redirect     off;
    proxy_http_version 1.1;
    
    proxy_pass http://127.0.0.1:9696;
  }
}
```

Now restart Nginx and Prowlarr should be available at your selected subdomain.

## Apache

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

### Using SSL on the reverse proxy

If the reverse proxy does SSL termination (i.e. the URL to access the reverse proxy is using the `https://` protocol), then you need to tell Prowlarr that it should use `https://` for its API responses by setting the `X-Forwarded-Proto` correctly. The common way is to add the following lines under the `ProxyPassReverse` configuration:

```none
RequestHeader set "X-Forwarded-Proto" expr=%{REQUEST_SCHEME}
RequestHeader set "X-Forwarded-SSL" expr=%{HTTPS}
```

Note that this configuration requires enabling the `mod_header` Apache module, which is often not enabled by default.
