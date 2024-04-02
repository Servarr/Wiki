#!/bin/bash

### Boilerplate Warning
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

scriptversion="0.0.1"
scriptdate="2024-04-01"

set -euo pipefail

echo "Running Servarr Uninstall Script - Version [$scriptversion] as of [$scriptdate]"

# Am I root?, need root!

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

#!/bin/bash

# Default application name; override by setting APP_NAME environment variable
app="${APP_NAME:-}"

if [ -z "$app" ]; then
    echo "Please set the app name via the APP_NAME environment variable."
    exit 1
fi

# Extract paths and user/group from systemd service file
ExecStart=$(systemctl show -p ExecStart --value "$app.service")
User=$(systemctl show -p User --value "$app.service")
Group=$(systemctl show -p Group --value "$app.service")
bindir=$(echo "$ExecStart" | grep -oP '(?<=ExecStart=)/[^ ]+(?=/[^/ ]+ )' | head -1)
appdataenvname="${app^^}_DATA_DIR" # Convert app name to uppercase for environment variable
appdatadir=${!appdataenvname:-$(echo "$ExecStart" | grep -oP '(?<=-data=)[^ ]*')}

echo "Installation directory (bindir): $bindir"
echo "Data directory (appdatadir): $appdatadir"
echo "Running as User: $User, Group: $Group"

# Inform user how to override data directory with an environment variable
echo "To override the data directory, set the $appdataenvname environment variable."

# Instructions for user and group removal
echo "To remove the user and/or group, use: sudo userdel $User; sudo groupdel $Group"

# Proceed with uninstallation as before
read -n 1 -r -s -p $'Press enter to continue or ctrl+c to exit...\n'

# Stop and disable the service
systemctl stop "$app"
systemctl disable "$app.service"
echo "${app^} service stopped and disabled."

# Remove the service file
rm -f /etc/systemd/system/"$app".service
systemctl daemon-reload
echo "Service file removed."

# Prompt for data directory deletion
read -p "Do you want to delete the data directory at $appdatadir? (y/N): " deldata
if [[ $deldata =~ ^[Yy]$ ]]; then
    rm -rf "$appdatadir"
    echo "Data directory deleted."
fi

# Remove the application directory
rm -rf "$bindir"
echo "${app^} installation directory removed."

echo "${app^} uninstallation completed."
