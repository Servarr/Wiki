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

> You may have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Prowlarr\config.xml` is denied -- or you use mapped network drives. This gives Prowlarr the permissions it needs. You should not need to run As Administrator every time.
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

### Debian/Ubuntu
  
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

- Ensure ownership of the binary directory.

> This assumes you have created the user and will run as the user `prowlarr` and group `prowlarr`. You may change this to fit your usecase.
{.is-danger}

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
Restart=always
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

## Docker

### Install Prowlarr

The Prowlarr team does not offer an official Docker image. However, a number of third parties have created and maintain their own.

> For a more detailed explanation of docker and suggested practices, see [The Best Docker Setup and Docker Guide](/docker-guide) wiki article.
{.is-info}

To install and use these Docker images, you will need to keep the above in mind while following their documentation. There are many ways to manage Docker images and containers too, so installation and maintenance of them will depend on the route you choose.

> Temporarily, you will need to use the `:nightly` or `:develop` tags with docker images, as there is no `master` branch.
{.is-warning}

- [hotio/prowlarr](https://hotio.dev/containers/prowlarr/)
- [linuxserver/prowlarr](https://github.com/linuxserver/docker-prowlarr/tree/develop)
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

This should be added within an existing VirtualHost site.

As a sub directory such as mydomain.com/prowlarr

```none
<Location /prowlarr>
    ProxyPass http://127.0.0.1:9696/prowlarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:9696/prowlarr
</Location>
```

Or for making an entire VirtualHost for Prowlarr:

```none
ProxyPass / http://127.0.0.1:9696/prowlarr/
ProxyPassReverse / http://127.0.0.1:9696/prowlarr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/prowlarr/api/`
- `/prowlarr/Content/`
