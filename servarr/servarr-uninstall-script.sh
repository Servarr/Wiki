#!/bin/bash

### Version 0.0.2 - nostrusdominion - moved root check, added colors, improved reability, added check for what services are installed instead of just listing services, 1removed AppData confirmation it felt redundant, added confirmations for user and group removal, added a check for users in $group before deletion,

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

scriptversion="0.0.2"
scriptdate="2024-04-10"

set -euo pipefail

# Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo -e ${red}"Please run as root!"
    echo -e "Exiting script!"
    exit
fi

### Title Splash
echo -e ${brown}
echo -e "   #############################################################"
echo -e "   #                                                           #"
echo -e "   #   Welcome to the Servarr Community UNInstaller Script!    #"
echo -e "   #                                                           #"
echo -e "   #  This script is for any Debian distro based users         #"
echo -e "   #  who need a little help with just the press of a button.  #"
echo -e "   #  If you have not done so, exit the script and read the    #"
echo -e "   #  Boilerplate Warning just to CYA. Enjoy your new setup!   #"
echo -e "   #                                                           #"
echo -e "   #############################################################"
echo -e ${reset}

echo -e "Running Servarr Uninstall Script - Version ${brown}[$scriptversion]${reset} as of ${brown}[$scriptdate]${reset}"
echo ""

### FIND THE SERVICES

# Function to check if a service is running
service_is_running() {
    systemctl is-active --quiet "$1"
}

# Array of services
services=("lidarr" "prowlarr" "radarr" "readarr" "whisparr")

### Fake echo to let the user think the computer is searching

# Function to display the ellipsis
display_ellipsis() {
    local count=0
    local direction=1
    local max_count=3

    # Loop for 7 seconds
    for ((i = 0; i < 7; i++)); do
        # Print the ellipsis
        echo -ne "Scanning for running services"
        for ((j = 0; j < count; j++)); do
            echo -n "."
        done
        echo -ne "\r"

        # Increment or decrement the count based on direction
        count=$((count + direction))

        # Change direction if count reaches max or min
        if [ "$count" -eq "$max_count" ] || [ "$count" -eq 0 ]; then
            direction=$((direction * -1))
        fi

        sleep 1  # Wait for 1 second
    done
    echo ""  # Print a newline after the loop
}

display_ellipsis

# List of running services
running_services=()
for service in "${services[@]}"; do
    if service_is_running "$service"; then
        running_services+=("$service")
    fi
done

# Add "manual" and "quit" options
running_services+=("manual" "quit")

# Prompt user to select an option
echo ""
echo "Select an application:"
select app in "${running_services[@]}"; do
    case $app in
        manual)
            read -p "Enter the service to remove: " manual_app
            app="$manual_app"
            break
            ;;
        quit)
            exit 0
            ;;
        *)
            echo ""
            echo -e "You selected: ${brown}${app}${reset}"
            break
            ;;
    esac
done


# Extract paths and user/group from systemd service file
ExecStart=$(systemctl show -p ExecStart --value "$app.service")

if [ -z "$ExecStart" ]; then
    echo ""
    echo -e "${red}Error${reset}: Failed to find matching service name. Aborting."
    echo ""
    exit 1
fi

User=$(systemctl show -p User --value "$app.service")
Group=$(systemctl show -p Group --value "$app.service")
bindir=$(echo "$ExecStart" | awk -F ' ' '{ for(i=1; i<=NF; i++) { if ($i ~ /path=/) { split($i, path, "="); print path[2]; } } }')
appdatadir=$(echo "$ExecStart" | awk -F ' ' '{ for(i=1; i<=NF; i++) { if ($i ~ /-data=/) { split($i, data, "="); print data[2]; } } }')

# Output all relevant data
echo ""
echo -e "Installation directory: ${brown}$bindir${reset}"
echo ""
echo -e "AppData directory: ${brown}$appdatadir${reset}"
echo ""
echo -e "Service is running as User: ${brown}$User${reset}"
echo ""
echo -e "Service is running in Group: ${brown}$Group${reset}"

# User confirmation that uninstallation will continue
echo ""
read -r -p "Please type 'yes' to continue with uninstallation: " response
if [[ $response != "yes" && $response != "YES" ]]; then
    echo "Invalid response. Uninstallation canceled."
    echo "Exiting script!"
    exit 0
fi

# Proceed with uninstallation
echo ""
echo -e ${yellow}"Uninstallation in progress!"${reset}
sleep 1

# Stop and disable the service
echo ""
echo -e "Attempting to stop and disable services..."
sleep 2
systemctl stop "$app"  >/dev/null 2>&1
systemctl disable "$app.service"  >/dev/null 2>&1
echo ""
echo -e "${brown}[${app^}]${reset} service has been stopped and disabled."
sleep 2

# Remove the service file
rm -f /etc/systemd/system/"$app".service
systemctl daemon-reload
echo ""
echo -e ${yellow}"Service file removed from systemd."${reset}
sleep 2

# Prompt for data directory deletion
echo ""
read -p "Do you want to delete the data directory at '$appdatadir'? (y/N): " deldata
deluser=${deluser:-N}

if [[ $deldata =~ ^[Yy]$ ]]; then
    rm -rf "$appdatadir"
    echo ""
    echo -e ${yellow}"Data directory deleted."${reset}
    sleep 2
fi

# User confirmation remove $User
echo ""
read -p "Do you want to delete USER '$User'? (y/N): " deluser
deluser=${deluser:-N}

if [[ $deluser =~ ^[Yy]$ ]]; then
    sudo userdel $User
    echo ""
    echo "User '$User' has been removed from your system."
    sleep 2
else
    echo ""
    echo -e ${yellow}"User '$User' has not to be removed from your system."${reset}
    sleep 2
fi

# Check if there are users in the group
users_in_group=$(getent group "$Group" | cut -d: -f4)
if [ -n "$users_in_group" ]; then
    echo ""
    echo -e "There are still users in the group '$Group':" ${yellow}$users_in_group${reset}
    sleep 1
    echo ""
    echo -e "Group '$Group' ${red}CANNOT${reset} be removed until all users are removed from it."
    echo ""
    echo "If this user is no longer in use, then as root use 'userdel $users_in_group' to delete the user from your system."
    sleep 1
else
    echo ""
    read -p "Do you want to delete GROUP '$Group'? (y/N): " delgroup
    delgroup=${delgroup:-N}

    if [[ $delgroup =~ ^[Yy]$ ]]; then
        sudo groupdel "$Group"
        echo ""
        echo "Group '$Group' has been removed from your system."
    else
        echo ""
        echo "Group '$Group' will not be removed from your system."
    fi
fi

# Remove the application directory
rm -rf "$bindir"
echo ""
echo -e "${brown}${app^}${reset} installation directory removed from $bindir."
echo ""
echo -e "${brown}${app^}${reset} uninstallation has been completed."
echo ""
echo "Script is complete. Exiting NOW!"

exit
