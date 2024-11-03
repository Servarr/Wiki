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
### Version v3.0.13 2024-11-03 - cyneric - added sonarr support and refactored script for readability and functionality
### Additional Updates by: The Servarr Community

### Boilerplate Warning
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Constants
readonly SCRIPT_VERSION="3.0.13"
readonly SCRIPT_DATE="2024-11-03"

# Colors
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly BROWN='\033[0;33m'
readonly RESET='\033[0m'

set -euo pipefail

# Check root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root!\nExiting script!${RESET}"
    exit 1
fi

# Title splash
echo -e ${BROWN}
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
echo -e ${RESET}

echo -e "\nRunning Servarr Install Script - Version ${BROWN}[$SCRIPT_VERSION]${RESET} as of ${BROWN}[$SCRIPT_DATE]${RESET}"

# App selection
declare -A APP_CONFIGS=(
    ["lidarr"]="8686|curl sqlite3 libchromaprint-tools mediainfo|0002|master"
    ["prowlarr"]="9696|curl sqlite3|0002|master"
    ["radarr"]="7878|curl sqlite3|0002|master"
    ["readarr"]="8787|curl sqlite3|0002|develop"
    ["whisparr"]="6969|curl sqlite3|0002|nightly"
    ["sonarr"]="8989|curl sqlite3|0002|main"
)

echo -e "\nSelect the application to install:\n"
select app in "${!APP_CONFIGS[@]}" quit; do
    if [[ $app == "quit" ]]; then
        exit 0
    elif [[ -n ${APP_CONFIGS[$app]:-} ]]; then
        IFS='|' read -r app_port app_prereq app_umask branch <<< "${APP_CONFIGS[$app]}"
        break
    else
        echo "Invalid option $REPLY"
    fi
done

# Installation paths
readonly INSTALL_DIR="/opt"
readonly BIN_DIR="${INSTALL_DIR}/${app^}"
readonly DATA_DIR="/var/lib/$app/"
readonly APP_BIN=${app^}

# Display warning for non-Prowlarr apps
if [[ $app != 'prowlarr' ]]; then
    echo -e "\n${RED}   WARNING! WARNING! WARNING!${RESET}\n"
    echo -e "   It is ${RED}CRITICAL${RESET} that the ${BROWN}User${RESET} and ${BROWN}Group${RESET} you select"
    echo -e "   to run ${BROWN}[${app^}]${RESET} will have both ${RED}READ${RESET} and ${RED}WRITE${RESET} access"
    echo -e "   to your Media Library and Download Client directories!${RESET}"
    sleep 5
fi

# Check install directory
if [[ "$INSTALL_DIR" == "$(dirname -- "$(readlink -f -- "$0")")" ]] || 
   [[ "$BIN_DIR" == "$(dirname -- "$(readlink -f -- "$0")")" ]]; then
    echo -e "\n${RED}Error!${RESET} You should not run this script from the intended install directory."
    echo "Please re-run it from another directory."
    echo "Exiting Script!"
    exit 1
fi

# Get user/group
read -r -p "What user should [${app^}] run as? (Default: $app): " app_uid
app_uid=$(echo "${app_uid:-$app}" | tr -d ' ')

read -r -p "What group should [${app^}] run as? (Default: media): " app_guid
app_guid=$(echo "${app_guid:-media}" | tr -d ' ')

# Display configuration
echo -e "\n${BROWN}[${app^}]${RESET} selected for installation."
echo -e "\n${BROWN}[${app^}]${RESET} will then be installed to ${BROWN}[$BIN_DIR]${RESET} and use ${BROWN}[$DATA_DIR]${RESET} for the AppData Directory."

if [[ $app == 'prowlarr' ]]; then
    echo -e "\n${BROWN}[${app^}]${RESET} will run as the user ${BROWN}[$app_uid]${RESET} and group ${BROWN}[$app_guid]${RESET}."
else
    echo -e "\n${BROWN}[${app^}]${RESET} will run as the user ${BROWN}[$app_uid]${RESET} and group ${BROWN}[$app_guid]${RESET}."
    echo -e "\n   By continuing, you've ${RED}CONFIRMED${RESET} that that ${BROWN}[$app_uid]${RESET} and ${BROWN}[$app_guid]${RESET}"
    echo -e "   will have both ${RED}READ${RESET} and ${RED}WRITE${RESET} access to all required directories.\n"
fi

# Confirm installation
read -r -p "Please type 'yes' to continue with the installation: " response
if [[ ${response,,} != "yes" ]]; then
    echo "Invalid response. Operation is canceled!"
    echo "Exiting script!"
    exit 0
fi

# Create user/group
if [[ "$app_guid" != "$app_uid" ]] && ! getent group "$app_guid" >/dev/null; then
    groupadd "$app_guid"
fi

if ! getent passwd "$app_uid" >/dev/null; then
    adduser --system --no-create-home --ingroup "$app_guid" "$app_uid"
    echo -e "\nCreated User ${YELLOW}$app_uid${RESET}"
    echo -e "\nCreated Group ${YELLOW}$app_guid${RESET}."
    sleep 3
fi

if ! getent group "$app_guid" | grep -qw "$app_uid"; then
    echo -e "\nUser ${YELLOW}$app_uid${RESET} did not exist in Group ${YELLOW}$app_guid${RESET}."
    usermod -a -G "$app_guid" "$app_uid"
    echo -e "\nAdded User ${YELLOW}$app_uid${RESET} to Group ${YELLOW}$app_guid${RESET}."
    sleep 3
fi

# Stop existing service
if service --status-all | grep -Fq "$app"; then
    systemctl disable --now "$app".service
    echo "Stopped existing $app."
fi

# Create directories
mkdir -p "$DATA_DIR"
chown -R "$app_uid":"$app_guid" "$DATA_DIR"
chmod 775 "$DATA_DIR"
echo -e "\nDirectories ${YELLOW}$BIN_DIR${RESET} and ${YELLOW}$DATA_DIR${RESET} created!"

# Check prerequisites
echo -e "\n${YELLOW}Checking Pre-Requisite Packages...${RESET}"
sleep 3

missing_packages=()
for pkg in $app_prereq; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        missing_packages+=("$pkg")
    fi
done

if (( ${#missing_packages[@]} == 0 )); then
    echo -e "\n${GREEN}All prerequisite packages are already installed!${RESET}"
else
    echo -e "\nInstalling missing prerequisite packages: ${BROWN}${missing_packages[*]}${RESET}"
    apt-get update && apt-get install -y "${missing_packages[@]}"
fi

# Download and install
echo -e "\n${YELLOW}Checking architecture...${RESET}"
readonly ARCH=$(dpkg --print-architecture)

if [[ $app == 'sonarr' ]]; then
    dlbase="https://services.sonarr.tv/v1/download/$branch/latest?version=4&os=linux"
else
    dlbase="https://$app.servarr.com/v1/update/$branch/updatefile?os=linux&runtime=netcore"
fi

case "$ARCH" in
    "amd64") DLURL="${dlbase}&arch=x64" ;;
    "armhf") DLURL="${dlbase}&arch=arm" ;;
    "arm64") DLURL="${dlbase}&arch=arm64" ;;
    *)
        echo -e "${RED}Architecture $ARCH is not supported!\nExiting installer script!${RESET}"
        exit 1
        ;;
esac

echo -e "${YELLOW}Removing old tarballs...${RESET}"
rm -f "${app^}".*.tar.gz

echo -e "\n${YELLOW}Downloading and extracting...${RESET}"
wget --content-disposition "$DLURL"
tar -xf "${app^}".*.tar.gz

echo -e "\n${YELLOW}Installing...${RESET}"
rm -rf "$BIN_DIR"
mv "${app^}" "$INSTALL_DIR"
chown -R "$app_uid":"$app_guid" "$BIN_DIR"
chmod 775 "$BIN_DIR"

touch "$DATA_DIR/update_required"
chown "$app_uid":"$app_guid" "$DATA_DIR/update_required"

rm -f "${app^}".*.tar.gz

echo -e "\nSuccessfully installed ${BROWN}[${app^}]${RESET}!"

# Create service file
echo -e "\nConfiguring service..."
cat > "/etc/systemd/system/$app.service" << EOF
[Unit]
Description=${app^} Daemon
After=syslog.target network.target

[Service]
User=$app_uid
Group=$app_guid
UMask=$app_umask
Type=simple
ExecStart=$BIN_DIR/$APP_BIN -nobrowser -data=$DATA_DIR
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Start service
echo -e "\n${BROWN}[${app^}]${RESET} is starting..."
systemctl daemon-reload
systemctl enable --now "$app"

# Wait for service
while ! systemctl is-active --quiet "$app"; do
    sleep 1
done

# Final status
readonly IP_LOCAL=$(hostname -I | awk '{print $1}')
echo -e "\nChecking connection at http://$IP_LOCAL:$app_port..."
sleep 3

if systemctl is-active --quiet "$app"; then
    echo -e "\nSuccessful connection!"
    echo -e "\nBrowse to ${GREEN}http://$IP_LOCAL:$app_port${RESET} for the GUI."
else
    echo -e "\n${RED}${app^} failed to start.${RESET}"
    echo -e "\nPlease try again."
fi

exit 0
