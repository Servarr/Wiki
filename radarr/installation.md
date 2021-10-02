---
title: Radarr Installation
description: 
published: true
date: 2021-10-02T02:40:06.122Z
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

> You may have to run once "As Administrator" after installing in tray mode, if you get an access error -- such as Access to the path `C:\ProgramData\Radarr\config.xml` is denied -- or you use mapped network drives. This gives Radarr the permissions it needs. You should not need to run As Administrator every time.
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

### Debian / Ubuntu / Raspian

#### Easy Install for x64 and a tweak for arm

For the  Debian / Ubuntu / Raspian beginners there isn't an apt-get package yet. If you want to go hands on follow the 'Debian / Ubuntu / Raspian Hands on Install' steps below.

If you want an easy life follow this for a base Debian / Ubuntu / Raspian install:
For other CPUs change arch= in the wget line to:

- ARM and armh use ``arch=arm``
- ARM64 use ``arch=arm64``

###### Easy Install
- Ensure you have [set a static IP Address](https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/) , it's Optional but will make your life easier.
- SSH into your Debian / Ubuntu / Raspian box as root (yes root more below), Windows users try mRemoteNG so you can save you're connections.
- Type: 
```
nano RadarrInstall.sh
```
- Copy and paste (Assuming most of you are in an GUI OS such as Windows or MacOS (OSX)): Windows user pasting could be as simple as right clicking.
```shell
#!/bin/bash
#### Description: Radarr 3.2+ (.NET Core) Debian install
#### Directory struture similar to Sonarr
#### Written by: DoctorArr - doctorarr@the-rowlands.co.uk on 10-2021 v1.0

## Am I root, need root

if [ "$EUID" -ne 0 ]
	then echo "Please run as root. See https://askubuntu.com/questions/167847/how-to-run-bash-script-as-root-with-no-password for help."
	exit
fi

## Const

RADARR_UID="radarr"
BRANCH="master"

## Create radarr user and group if they don't exist

PASSCHK=$(grep -c ":$RADARR_UID:" /etc/passwd)
if [ $PASSCHK -ge 1 ]
	then
	echo "UID: $RADARR_UID seems to exist skipping creation, ensure user $RADARR_UID and group $RADARR_UID are setup."
else
	echo "UID: $RADARR_UID and group with disabled password."
	adduser --disabled-password --gecos "" $RADARR_UID
fi

## Stop Radarr if running

if service --status-all | grep -Fq 'radarr'; then    
	systemctl stop radarr   
	sytemctl disable  radarr.service
fi

## Create directories like Sonarr and change owner

	## config
	mkdir -p /var/lib/radarr/
	chown radarr:radarr -R /var/lib/radarr/
	
	## bin
	mkdir -p /usr/lib/radarr
	chown radarr:radarr -R /var/lib/radarr/
	
## Download and install Radarr

	## prerequisite packages:
	apt install curl mediainfo sqlite3
	cd /usr/lib/radarr
	rm -rf bin
	rm -rf Radarr
	wget --content-disposition "http://radarr.servarr.com/v1/update/$BRANCH/updatefile?os=linux&runtime=netcore&arch=x64"
	tar -xvzf Radarr*.linux-core-x64.tar.gz
	chown radarr:radarr -R /usr/lib/radarr/Radarr
	mv Radarr bin
	rm -rf Radarr*.linux-core-x64.tar.gz

##Configure Auot-start

	#Remove any previous radarr.service
		rm -rf /etc/systemd/system/radarr.service
	
	##Create radarr.service with correct user startup
	
cat << EOF | tee /etc/systemd/system/radarr.service > /dev/null
[Unit]
Description=Radarr Daemon
After=syslog.target network.target
[Service]
User=radarr
Group=radarr
UMask=0002
Type=simple
ExecStart=/usr/lib/radarr/bin/Radarr -nobrowser -data=/var/lib/radarr/
TimeoutStopSec=20
KillMode=process
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

##Start Radarr

	systemctl -q daemon-reload
	systemctl enable --now -q radarr
	systemctl start radarr.service

## Finish update

		HOST=$(hostname -I)
        IP_LOCAL=$(grep -oP '^\S*' <<< $HOST)
		echo ""
		echo "Install complete"
        echo "Browse to http://$IP_LOCAL:7878 for the Radarr GUI"

	
```
- Press Ctrl O (save)<enter>
- Press Ctrl X (exit)<enter>
- Type:
```shell
bash Rada <tab>
```
which should auto complete the input to:
```
bash RadarrInstall.sh
```
- Browse to http://<your_ip>:7878 for the Radarr GUI- 
- Configure Radarr and make a backup.

If you need to re-install run again:

```
bash RadarrInstall.sh
```
###### Root

If you can't run the [install as root follow these instructions](https://askubuntu.com/questions/167847/how-to-run-bash-script-as-root-with-no-password).
  
#### Debian Hands on Install

You'll need to install the binaries using the below commands.

> The steps below will download Radarr and install it into `/opt`.
> Radarr will run under the user `radarr` and group `media`
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
sudo mv Radarr/ /opt
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
Restart=always
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
- [linuxserver/radarr](https://docs.linuxserver.io/images/docker-radarr)
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
Restart=always
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

- Simply spin up a second Docker container with a different name, ensuring the above requirments are met.
