#!/bin/bash

# Default application name; override by setting APP_NAME environment variable
app="${APP_NAME:-}"

if [ -z "$app" ]; then
    echo "Please set the app name via the APP_NAME environment variable."
    exit 1
fi

# Extract paths from systemd service file
ExecStart=$(systemctl show -p ExecStart --value "$app.service")
bindir=$(echo "$ExecStart" | grep -oP '(?<=ExecStart=)/[^ ]+(?=/[^/ ]+ )' | head -1)
appdataenvname="${app^^}_DATA_DIR" # Convert app name to uppercase for environment variable
appdatadir=${!appdataenvname:-$(echo "$ExecStart" | grep -oP '(?<=-data=)[^ ]*')}

echo "Installation directory (bindir): $bindir"
echo "Data directory (appdatadir): $appdatadir"

# Inform user how to override data directory with an environment variable
echo "To override the data directory, set the $appdataenvname environment variable."

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
