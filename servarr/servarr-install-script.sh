#!/bin/bash
### Description: Servarr .NET Debian install
### Originally written for Radarr by: DoctorArr - doctorarr@the-rowlands.co.uk on 2021-10-01 v1.0
### Version v1.1 2021-10-02 - Bakerboy448 (Made more generic and conformant)
### Version v1.1.1 2021-10-02 - DoctorArr (Spellcheck and boilerplate update)
### Version v2.0.0 2021-10-09 - Bakerboy448 (Refactored and ensured script is generic. Added more variables.)
### Version v2.0.1 2021-11-23 - brightghost (Fixed datadir step to use correct variables.)
### Version v3.0.0 2022-02-03 - Bakerboy448 (Rewrote script to prompt for user/group and made generic for all \*Arrs)
### Version v3.0.1 2022-02-05 - aeramor (typo fix line 179: 'chown "$app_uid":"$app_uid" -R "$bindir"' -> 'chown "$app_uid":"$app_guid" -R "$bindir"')
### Version v3.0.3 2022-02-06 - Bakerboy448 fixup ownership
### Version v3.0.3a Readarr to develop
### Version v3.0.4 2022-03-01 - Add sleep before checking service status
### Version v3.0.5 2022-04-03 - VP-EN (Added Whisparr)
### Version v3.0.6 2022-04-26 - Bakerboy448 - binaries to group
### Version v3.0.7 2023-01-05 - Bakerboy448 - Prowlarr to master
### Version v3.0.8 2023-04-20 - Bakerboy448 - Shellcheck fixes & remove prior tarballs
### Version v3.0.9 2023-04-28 - Bakerboy448 - fix tarball check
### Version v3.0.9a 2023-07-14 - DoctorArr - updated scriptversion and scriptdate and to see how this is going! It was still at v3.0.8.
### Version v3.0.10 2024-01-04 - Bakerboy448 - Misc updates and refactoring. Move to own script file.
### Version v3.0.11 2024-01-06 - StevieTV - Exit script when ran from installdir
### Version v3.0.12 2024-03-08 - fud18 - Added an option to install another app, added Sonarr & bazarr, added cleanup for downloaded installers, updated the menu options to have the first letter capitalized
### Additional Updates by: The Servarr Community

### Boilerplate Warning
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

scriptversion="3.0.12"
scriptdate="2024-03-08"

set -euo pipefail

echo "Running Servarr Install Script - Version [$scriptversion] as of [$scriptdate]"

# Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

while true; do
    echo "Select the application to install: "

    select app in Bazarr Lidarr Prowlarr Radarr Readarr Sonarr Whisparr Quit; do
        app_lowercase=$(echo "$app" | awk '{print tolower($0)}')
        echo $app
        case $app_lowercase in
        bazarr)
            app_port="6767"
            app_prereq="sudo cifs-utils python3 python3-dev python3-pip git unrar ffmpeg software-properties-common qemu-guest-agent python3-setuptools python3-lxml python3-numpy"
            app_umask="0002"
            branch="master"
            break
            ;;
        lidarr)
            app_port="8686"
            app_prereq="curl sqlite3 libchromaprint-tools mediainfo"
            app_umask="0002"
            branch="master"
            break
            ;;
        prowlarr)
            app_port="9696"
            app_prereq="curl sqlite3"
            app_umask="0002"
            branch="master"
            break
            ;;
        radarr)
            app_port="7878"
            app_prereq="curl sqlite3"
            app_umask="0002"
            branch="master"
            break
            ;;
        readarr)
            app_port="8787"
            app_prereq="curl sqlite3"
            app_umask="0002"
            branch="develop"
            break
            ;;
        sonarr)
            app="sonarr"
            app_port="8989"
            app_prereq="curl sqlite3 wget"
            app_umask="0002"
            branch="main"
            break
            ;;
        whisparr)
            app_port="6969"
            app_prereq="curl sqlite3"
            app_umask="0002"
            branch="nightly"
            break
            ;;
        quit)
            break
            ;;
        *)
            echo "Invalid option $REPLY"
            ;;
        esac
    done

    if [ "$app" = "Quit" ]; then
        echo "Exiting..."
        break
    fi

    # Constants
    ### Update these variables as required for your specific instance
    installdir="/opt" # {Update me if needed} Install Location
    bindir="${installdir}/${app^}" # Full Path to Install Location
    datadir="/var/lib/$app/" # {Update me if needed} AppData directory to use
    app_bin=${app^} # Binary Name of the app

    if [[ $app_lowercase != 'prowlarr' ]]; then
        echo "It is critical that the user and group you select to run ${app} as will have READ and WRITE access to your Media Library and Download Client Completed Folders"
    fi

    # This script should not be ran from installdir, otherwise later in the script the extracted files will be removed before they can be moved to installdir.
    if [ "$installdir" == "$(dirname -- "$(readlink -f -- "$0";)")" ] || [ "$bindir" == "$(dirname -- "$(readlink -f -- "$0";)")" ]; then
        echo "You should not run this script from the intended install directory. The script will exit. Please re-run it from another directory"
        exit
    fi

    # Prompt User
    read -r -p "What user should ${app} run as? (Default: servarr): " app_uid
    app_uid=$(echo "$app_uid" | tr -d ' ')
    app_uid=${app_uid:-servarr}
    # Prompt Group
    read -r -p "What group should ${app} run as? (Default: servarr): " app_guid
    app_guid=$(echo "$app_guid" | tr -d ' ')
    app_guid=${app_guid:-servarr}

    echo "${app} selected"
    echo "This will install [${app}] to [$bindir] and use [$datadir] for the AppData Directory"
    if [[ $app_lowercase != 'prowlarr' ]]; then
        echo "${app} will run as the user [$app_uid] and group [$app_guid]."
    else
        echo "${app} will run as the user [$app_uid] and group [$app_guid]. By continuing, you've confirmed that that user and group will have READ and WRITE access to your Media Library and Download Client Completed Download directories"
    fi
    # read -n 1 -r -s -p $'Press enter to continue or ctrl+c to exit...\n'

    # Create User / Group as needed
    if [ "$app_guid" != "$app_uid" ]; then
        if ! getent group "$app_guid" >/dev/null; then
            groupadd "$app_guid"
        fi
    fi
    if ! getent passwd "$app_uid" >/dev/null; then
        adduser --system --no-create-home --ingroup "$app_guid" "$app_uid"
        echo "Created and added User [$app_uid] to Group [$app_guid]"
    fi
    if ! getent group "$app_guid" | grep -qw "$app_uid"; then
        echo "User [$app_uid] did not exist in Group [$app_guid]"
        usermod -a -G "$app_guid" "$app_uid"
        echo "Added User [$app_uid] to Group [$app_guid]"
    fi

    # Stop the App if running
    if service --status-all | grep -Fq "$app"; then
        systemctl stop "$app"
        systemctl disable "$app".service
        echo "Stopped existing $app"
    fi

    # Install Bazarr-specific dependencies and clone the repository
    if [[ $app_lowercase == 'bazarr' ]]; then
        rm -rf /opt/bazarr
        # Install prerequisite packages
        apt update && apt install $app_prereq -y

        # Install additional Python packages
        pip3 install webrtcvad-wheels --break-system-packages
        pip3 install Pillow --break-system-packages

        # Clone Bazarr repository
        git clone https://github.com/morpheus65535/bazarr.git /opt/bazarr

        # Set ownership
        chown -R servarr:servarr /opt/bazarr

    elif [[ $app_lowercase == 'sonarr' ]]; then
        rm -rf /opt/sonarr
        apt update && apt install $app_prereq -y
        mkdir -p "$datadir"
        chown -R "$app_uid":"$app_guid" "$datadir"
        chmod 775 "$datadir"
        echo ""
        echo "Installing pre-requisite Packages"
        apt update && apt install $app_prereq
        echo ""
        ARCH=$(dpkg --print-architecture)
        dlbase="https://services.sonarr.tv/v1/download/$branch/latest?version=4&os=linux"
        case "$ARCH" in
        "amd64") DLURL="${dlbase}&arch=x64" ;;
        "armhf") DLURL="${dlbase}&arch=arm" ;;
        "arm64") DLURL="${dlbase}&arch=arm64" ;;
        *)
            echo "Arch not supported"
            exit 1
            ;;
        esac
        echo ""
        echo "Removing previous tarballs"
        rm -f "${app^}".*.tar.gz
        echo ""
        echo "Downloading..."
        wget --content-disposition "$DLURL"
        tar -xvzf "${app^}".*.tar.gz
        echo ""
        echo "Installation files downloaded and extracted"
        echo "Removing existing installation"
        rm -rf "$bindir"
        echo "Installing..."
        mv "${app^}" $installdir
        chown "$app_uid":"$app_guid" -R "$bindir"
        chmod 775 "$bindir"
        rm -rf "${app^}.*.tar.gz"
        touch "$datadir"/update_required
        chown "$app_uid":"$app_guid" "$datadir"/update_required
        echo "App Installed"
        echo "Removing old service file"
        echo /etc/systemd/system/"${app^}".service
        rm -rf /etc/systemd/system/"$app".service

        # Create app .service with correct user startup
        echo "Creating service file"
        cat <<EOF | tee /etc/systemd/system/"$app".service >/dev/null
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
    else
        # Create Appdata Directory
        # AppData
        mkdir -p "$datadir"
        chown -R "$app_uid":"$app_guid" "$datadir"
        chmod 775 "$datadir"
        echo "Directories created"
        # Download and install the App
        # prerequisite packages
        echo ""
        echo "Installing pre-requisite Packages"
        # shellcheck disable=SC2086
        apt update && apt install $app_prereq
        echo ""
        ARCH=$(dpkg --print-architecture)
        # get arch
        dlbase="https://$app.servarr.com/v1/update/$branch/updatefile?os=linux&runtime=netcore"
        case "$ARCH" in
        "amd64") DLURL="${dlbase}&arch=x64" ;;
        "armhf") DLURL="${dlbase}&arch=arm" ;;
        "arm64") DLURL="${dlbase}&arch=arm64" ;;
        *)
            echo "Arch not supported"
            exit 1
            ;;
        esac
        echo ""
        echo "Removing previous tarballs"
        # -f to Force so we do not fail if it doesn't exist
        rm -f "${app^}".*.tar.gz
        echo ""
        echo "Downloading..."
        wget --content-disposition "$DLURL"
        tar -xvzf "${app^}".*.tar.gz
        echo ""
        echo "Installation files downloaded and extracted"

        # remove existing installs
        echo "Removing existing installation"
        rm -rf "$bindir"
        echo "Installing..."
        mv "${app^}" $installdir
        chown "$app_uid":"$app_guid" -R "$bindir"
        chmod 775 "$bindir"
        rm -rf "${app^}.*.tar.gz"
        # Ensure we check for an update in case user installs older version or different branch
        touch "$datadir"/update_required
        chown "$app_uid":"$app_guid" "$datadir"/update_required
        echo "App Installed"
        # Configure Autostart

        # Remove any previous app .service
        echo "Removing old service file"
        rm -rf /etc/systemd/system/"$app".service
    fi

    # Create app .service with correct user startup
    echo "Creating service file"
    cat <<EOF | tee /etc/systemd/system/"$app".service >/dev/null
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

    STATUS="$(systemctl is-active "$app")"
    if [ "${STATUS}" = "active" ]; then
        echo "Browse to http://$ip_local:$app_port for the ${app} GUI"
    else
        echo "${app} failed to start"
    fi

    # Ask the user if they want to install another app
    read -p "Do you want to install another app? (yes/no): " install_another
    if [ "$install_another" != "yes" ]; then
        echo "Exiting..."
        break
    fi
done
