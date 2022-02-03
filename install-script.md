---
title: *Arr Installation Script
description: Common Installation Script for the *Arr Suite of Applications
published: true
date: 2022-02-03T15:29:55.659Z
tags: radarr, lidarr, readarr, prowlarr, installation
editor: markdown
dateCreated: 2022-02-03T15:12:29.483Z
---

# \*Arr Installation Script

> This will install the selected application to /opt. It will run application as the user and group you configure.
> For Lidarr/Radarr/Readarr - you should use a common group that is the same that your download client runs as and media server runs as to ensure ownership and permissions are sane and all files are accessible.
{.is-info}

Please be aware of the following common mistake around permissions.

> Two things to keep in mind are that Lidarr/Radarr/Readarr require read and write access to your download client's download directory and whatever folder you'll configure as your root (library or media) folder.
> Ideally each app is running as its own user and common group of `media` with permissions of `775` and `664` which is a UMask of `002`
> \* Your download clients and media server run as and are a part of the group you input
> \* Your paths used by your download clients and media server are accessible (read/write) to the group you input
{.is-warning}

Be aware of the following:

> This will remove any existing Installations; please ensure you have a backup of your settings using Backup from within the app (System => Backup). The script won't delete your settings (application data), but be safe. {.is-danger}

- (Optional) Ensure you have [set a static IP Address](https://www.cyberciti.biz/faq/add-configure-set-up-static-ip-address-on-debianlinux/), it'll will make your life easier.
- SSH into your Debian (Raspbian / Raspberry Pi OS) / Ubuntu box and become or login as root.

> SSH in using Putty, mRemoteNG, or any other SSH tool. Note that most tools support saving your connection.{.is-info}

- Once SSHed in type the below to create the installation script in your current directory

```bash
nano ArrInstall.sh
```

- Copy (top right corner of the script) and Paste into your SSH console
  - If you are in an GUI OS such as Windows or MacOS (OSX): pasting could be as simple as 'right clicking' in your ssh client.

```bash
#!/bin/bash
### Description: \*Arr .NET Debian install
### Originally written for Radarr by: DoctorArr - doctorarr@the-rowlands.co.uk on 2021-10-01 v1.0
### Version v1.1 2021-10-02 - Bakerboy448 (Made more generic and conformant)
### Version v1.1.1 2021-10-02 - DoctorArr (Spellcheck and boilerplate update)
### Version v2.0.0 2021-10-09 - Bakerboy448 (Refactored and ensured script is generic. Added more variables.)
### Version v2.0.1 2021-11-23 - brightghost (Fixed datadir step to use correct variables.)
### Version v3.0.0 2022-02-03 - Bakerboy448 (Rewrote script to prompt for user/group and made generic for all \*Arrs)
### Additional Updates by: The \*Arr Community

### Boilerplate Warning
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

scriptversion="3.0.0"
scriptdate="2021-02-03"

set -euo pipefail

echo "Running \*Arr Install Script - Version [$scriptversion] as of [$scriptdate]"

# Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

echo "Select the application to install: "

select app in lidarr prowlarr radarr readarr quit; do

    case $app in
    lidarr)
        app_port="8686"                                          # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3 libchromaprint-tools mediainfo" # Required packages
        app_umask="0002"                                         # UMask the Service will run as
        branch="master"                                          # {Update me if needed} branch to install
        break
        ;;
    prowlarr)
        app_port="9696"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="develop"          # {Update me if needed} branch to install
        break
        ;;
    radarr)
        app_port="7878"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="master"           # {Update me if needed} branch to install
        break
        ;;
    readarr)
        app_port="8787"           # Default App Port; Modify config.xml after install if needed
        app_prereq="curl sqlite3" # Required packages
        app_umask="0002"          # UMask the Service will run as
        branch="nightly"          # {Update me if needed} branch to install
        break
        ;;
    quit)
        exit 0
        ;;
    *)
        echo "Invalid option $REPLY"
        ;;
    esac
done

# Constants
### Update these variables as required for your specific instance
installdir="/opt"              # {Update me if needed} Install Location
bindir="${installdir}/${app^}" # Full Path to Install Location
datadir="/var/lib/$app/"       # {Update me if needed} AppData directory to use
app_bin=${app^}                # Binary Name of the app

if [[ $app != 'prowlarr' ]]; then
    echo "It is critical that the user and group you select to run ${app^} as will have READ and WRITE access to your Media Library and Download Client Completed Folders"
fi

# Prompt User
read -r -p "What user should ${app^} run as? (Default: $app): " app_uid
app_uid=$(echo "$app_uid" | tr -d ' ')
app_uid=${app_uid:-$app}
# Prompt Group
if [[ $app == 'prowlarr' ]]; then
    app_guid="prowlarr"
else
    read -r -p "What group should ${app^} run as? (Default: media): " app_guid
    app_guid=$(echo "$app_guid" | tr -d ' ')
    app_guid=${app_guid:-media}
fi

echo "${app^} selected"
echo "This will install [${app^}] to [$bindir] and use [$datadir] for the AppData Directory"
if [[ $app == 'prowlarr' ]]; then
    echo "${app^} will run as the user [$app_uid] and group [$app_guid]."
else
    echo "${app^} will run as the user [$app_uid] and group [$app_guid]. By continuing, you've confirmed that that user and group will have READ and WRITE access to your Media Library and Download Client Completed Download directories"
fi
echo "Continue with the installation [Yes/No]?"
select yn in "Yes" "No"; do
    case $yn in
    Yes) break;;
    No) exit 0 ;;
    esac
done

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
if [[ $app != 'prowlarr' ]]; then
    if ! getent group "$app_guid" | grep -qw "${app_uid}"; then
        echo "User [$app_uid] did not exist in Group [$app_guid]"
        usermod -a -G "$app_guid" "$app_uid"
        echo "Added User [$app_uid] to Group [$app_guid]"
    else
        echo "User [$app_uid] already exists in Group [$app_guid]"
    fi
fi

# Stop the App if running

if service --status-all | grep -Fq "$app"; then
    systemctl stop $app
    systemctl disable $app.service
fi

# Create Appdata Directory

# AppData
mkdir -p "$datadir"
chown -R "$app_uid":"$app_guid" "$datadir"
chmod 775 "$datadir"

# Download and install the App

# prerequisite packages
# shellcheck disable=SC2086
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
chown "$app_uid":"$app_uid" -R "$bindir"
rm -rf "${app^}.*.tar.gz"
# Ensure we check for an update in case user installs older version or different branch
touch "$datadir"/update_required
chown "$app_uid":"$app_guid" "$datadir"/update_required
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
STATUS="$(systemctl is-active $app)"
if [ "${STATUS}" = "active" ]; then
    echo "Browse to http://$ip_local:$app_port for the ${app^} GUI"
else
    echo "${app^} failed to start"
fi

# Exit
exit 0

```

- Press <kbd>Ctrl</kbd>+<kbd>O</kbd> (save) then <kbd>Enter</kbd>
- Press <kbd>Ctrl</kbd>+<kbd>X</kbd> (exit) then <kbd>Enter</kbd>
- Then in your console type and follow the prompts

```shell
sudo bash ArrInstall.sh
```
