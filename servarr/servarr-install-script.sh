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
### Version v3.0.12 2024-04-09 - nostrus-dominion - moved root check, added title splash, added colors, attempted to improve readability, check for installed prerequisites before bothering apt, supressed tarball extraction, added some sleep timers.
### Additional Updates by: The Servarr Community

### Boilerplate Warning
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### Colors
green='\033[0;32m'
yellow='\033[1;33m'
red='\033[0;31m'
brown='\033[0;33m'
reset='\033[0m' # No Color

scriptversion="3.0.12"
scriptdate="2024-04-10" # change this later

set -euo pipefail

### Am I root?, need root! GROOT!

if [ "$EUID" -ne 0 ]; then
    echo -e ${red}"Please run as root!"
    echo -e "Exiting script!"
    exit
fi

### Title Splash
echo -e ${brown}
echo -e "#############################################################"
echo -e "#                                                           #"
echo -e "#   Welcome to the Servarr Community Installation Script!   #"
echo -e "#                                                           #"
echo -e "#  This script is for any Debian-based distro users         #"
echo -e "#  who need a little help with just the press of a button.  #"
echo -e "#  If you have not done so, exit the script and read the    #"
echo -e "#  Boilerplate Warning just to CYA. Enjoy your new setup!   #"
echo -e "#                                                           #"
echo -e "#############################################################"
echo -e ${reset}

echo "Running Servarr Install Script - Version ${brown}[$scriptversion]${reset} as of ${brown}[$scriptdate]${reset}"
echo ""
echo "Select the application to install: "
echo ""
select app in lidarr prowlarr radarr readarr whisparr quit; do

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
        branch="master"           # {Update me if needed} branch to install
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
        branch="develop"          # {Update me if needed} branch to install
        break
        ;;
    whisparr)
        app_port="6969"           # Default App Port; Modify config.xml after install if needed
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
echo ""

### CONSTANTS
### Update these variables as required for your specific instance
installdir="/opt"              # {Update me if needed} Install Location
bindir="${installdir}/${app^}" # Full Path to Install Location
datadir="/var/lib/$app/"       # {Update me if needed} AppData directory to use
app_bin=${app^}                # Binary Name of the app

if [[ $app != 'prowlarr' ]]; then
    echo -e ${red}"   WARNING! WARNING! WARNING!"${reset}
    echo ""
    echo -e "   It is ${red}CRITICAL${reset} that the ${brown}User${reset} and ${brown}Group${reset} you select"
    echo -e "   to run ${brown}[${app^}]${reset} will have both ${red}READ${reset} and ${red}WRITE${reset} access"
    echo -e "   to your Media Library and Download Client directories!"${reset}
    sleep 5
fi

# This script should not be ran from installdir, otherwise later in the script the extracted files will be removed before they can be moved to installdir.
if [ "$installdir" == "$(dirname -- "$( readlink -f -- "$0"; )")" ] || [ "$bindir" == "$(dirname -- "$( readlink -f -- "$0"; )")" ]; then
    echo ""
    echo -e "${red}Error!${reset} You should not run this script from the intended install directory."
    echo "Please re-run it from another directory."
    echo "Exiting Script!"
    exit
fi

# Prompt User
echo ""
read -r -p "What user should [${app^}] run as? (Default: $app): " app_uid
app_uid=$(echo "$app_uid" | tr -d ' ')
app_uid=${app_uid:-$app}
# Prompt Group
echo ""
read -r -p "What group should [${app^}] run as? (Default: media): " app_guid
app_guid=$(echo "$app_guid" | tr -d ' ')
app_guid=${app_guid:-media}

echo ""
echo -e "${brown}[${app^}]${reset} selected for installation."
echo ""
echo -e "${brown}[${app^}]${reset} will then be installed to ${brown}[$bindir]${reset} and use ${brown}[$datadir]${reset} for the AppData Directory."
if [[ $app == 'prowlarr' ]]; then
    echo ""
    echo -e "${brown}[${app^}]${reset} will run as the user ${brown}[$app_uid]${reset} and group ${brown}[$app_guid]${reset}."
else
    echo ""
    echo -e "${brown}[${app^}]${reset} will run as the user ${brown}[$app_uid]${reset} and group ${brown}[$app_guid]${reset}."
    echo ""
    echo -e "   By continuing, you've ${red}CONFIRMED${reset} that that ${brown}[$app_uid]${reset} and ${brown}[$app_guid]${reset}"
    echo -e "   will have both ${red}READ${reset} and ${red}WRITE${reset} access to all required directories."
    echo ""
fi

# User confirmation that installation will continue
echo ""
read -r -p "Please type 'yes' to continue with the installation: " response
if [[ $response != "yes" && $response != "YES" ]]; then
    echo "Invalid response. Operation is canceled!"
    echo "Exiting script!"
    exit 0
fi

# Create User / Group as needed
if [ "$app_guid" != "$app_uid" ]; then
    if ! getent group "$app_guid" >/dev/null; then
        groupadd "$app_guid"
    fi
fi
if ! getent passwd "$app_uid" >/dev/null; then
    adduser --system --no-create-home --ingroup "$app_guid" "$app_uid"
    echo ""
    echo -e "Created User ${yellow}$app_uid${reset}"
    echo ""
    echo -e "Created Group ${yellow}$app_guid${reset}."
    sleep 3
fi
if ! getent group "$app_guid" | grep -qw "$app_uid"; then
    echo ""
    echo -e "User ${yellow}$app_uid${reset} did not exist in Group ${yellow}$app_guid${reset}."
    usermod -a -G "$app_guid" "$app_uid"
    echo ""
    echo -e "Added User ${yellow}$app_uid${reset} to Group ${yellow}$app_guid${reset}."
    sleep 3
fi

# Stop the App if running
if service --status-all | grep -Fq "$app"; then
    systemctl stop "$app"
    systemctl disable "$app".service
    echo "Stopped existing $app."
fi

# Create Appdata Directories
mkdir -p "$datadir"
chown -R "$app_uid":"$app_guid" "$datadir"
chmod 775 "$datadir"
echo ""
echo -e "Directories ${yellow}$bindir${reset} and ${yellow}$datadir${reset} created!"

# Download and install the App

# Check if prerequisite packages are already installed and install them if needed
echo ""
echo -e ${yellow}"Checking Pre-Requisite Packages..."${reset}
sleep 3

missing_packages=()
for pkg in $app_prereq; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        missing_packages+=("$pkg")
    fi
done

if [ ${#missing_packages[@]} -eq 0 ]; then
    echo ""
    echo -e ${green}"All prerequisite packages are already installed!"${reset}
else
    echo ""
    echo -e "Installing missing prerequisite packages: ${brown}${missing_packages[*]}${reset}"
    # Install missing prerequisite packages
    apt update && apt install "${missing_packages[@]}"
fi

# check if architecture is correct
echo ""
ARCH=$(dpkg --print-architecture)
# get arch
dlbase="https://$app.servarr.com/v1/update/$branch/updatefile?os=linux&runtime=netcore"
case "$ARCH" in
"amd64") DLURL="${dlbase}&arch=x64" ;;
"armhf") DLURL="${dlbase}&arch=arm" ;;
"arm64") DLURL="${dlbase}&arch=arm64" ;;
*)
    echo -e ${red}"Your arch is not supported!"
    echo -e "Exiting installer script!"${reset}
    exit 1
    ;;
esac

echo -e ${yellow}"Removing tarballs..."${reset}
sleep 3
# -f to Force so we do not fail if it doesn't exist
rm -f "${app^}".*.tar.gz
echo ""
echo -e ${yellow}"Downloading required files..."${reset}
echo ""
wget --content-disposition "$DLURL"
echo ""
echo -e ${yellow}"Download complete!"${reset}
echo ""
echo -e ${yellow}"Extracting tarball!"${reset}
tar -xvzf "${app^}".*.tar.gz >/dev/null 2>&1
echo ""
echo -e ${yellow}"Installation files downloaded and extracted!"${reset}

# remove existing installs
echo ""
echo -e "Removing existing installation files from ${brown}[$bindir]"${reset}
rm -rf "$bindir"
sleep 2
echo ""
echo -e "Attempting to install ${brown}[${app^}]${reset}..."
sleep 2
mv "${app^}" $installdir
chown "$app_uid":"$app_guid" -R "$bindir"
chmod 775 "$bindir"
# Ensure we check for an update in case user installs older version or different branch
touch "$datadir"/update_required
chown "$app_uid":"$app_guid" "$datadir"/update_required
echo ""
echo -e "Successfully installed ${brown}[${app^}]${reset}!!"
rm -rf "${app^}.*.tar.gz"
sleep 2

# Configure Autostart

# Remove any previous app .service
echo ""
echo "Removing old service file..."
rm -rf /etc/systemd/system/"$app".service
sleep 2

# Create app .service with correct user startup
echo ""
echo "Creating new service file..."
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
sleep 2

# Start the App
echo ""
echo -e "New service file created!"
echo ""
echo -e "${brown}[${app^}]${reset} is attempting to start, this may take a few seconds..."
systemctl -q daemon-reload
systemctl enable --now -q "$app"
sleep 3

# Check if the service is up and running
echo ""
echo "Checking if the service is up and running..."

# Loop to wait until the service is active
while ! systemctl is-active --quiet "$app"; do
    sleep 1
done

echo ""
echo -e "${brown}[${app^}]${reset} installation and service start up is complete!"

# Finish Installation
host=$(hostname -I)
ip_local=$(grep -oP '^\S*' <<<"$host")
echo ""
echo -e "Attempting to check for a connection at http://$ip_local:$app_port..."
sleep 3
STATUS="$(systemctl is-active "$app")"
if [ "${STATUS}" = "active" ]; then
    echo ""
    echo "Successful connection!"
    echo ""
    echo -e "Browse to ${green}http://$ip_local:$app_port${reset} for the GUI."
    echo ""
    echo "Script complete! Exiting now!"
    echo ""
else
    echo ""
    echo -e ${red}"${app^} failed to start."${reset}
    echo ""
    echo "Please try again. Exiting script."
    echo
fi

# Exit
exit 0
