---
title: multiple-instances
description: 
published: true
date: 2024-03-22T17:43:24.041Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:12:51.889Z
---

# Multiple Instances

It is possible to run multiple instances of Readarr. This is typically done when one wants a audiobook and ebook copy of a book.
Note that you can configure Readarr to use a second Readarr as a list. This is helpful if you wish to keep both in sync.

- [Windows Multiple Instances](#windows-multi)
- [Linux Multiple Instances](#linux-multi)
- [MacOS Multiple Instances](#macos-multi)
- [Docker Multiple Instances](#docker-multi)
{.links-list}

The following requirements should be noted:

- If non-docker, the same binaries (program files) should be used
- If non-docker, all instances *must* have a `-data=` or `/data=` argument passed
- If non-docker, different ports must be used
  - If docker, different external ports must be used
- Different download client categories must be used
- Different root folders must be used.
- If non-docker, disable automatic updates on all but 1 instance.

## Windows Multiple Instances

{#windows-multi}

This guide will show you how to run multiple instances of Readarr on Windows using only one base installation. This guide was put together using Windows 10; if you are using a previous version of Windows (7, 8, etc.) you may need to adjust some things. This guide also assumes that you have installed Readarr to the default directory, and your second instance of Readarr will be called Readarr-audiobooks. Feel free to change things to fit your own installations, though.

### Service (Windows)

#### Prerequisites (Service)

- [You must have Readarr already installed](#windows)
- You must have [NSSM (Non-Sucking Service Manager](http://nssm.cc) installed. To install, download the latest release (2.24 at the time of writing) and copy either the 32-bit or 64-bit nssm.exe file to C:/windows/system32.
  - If you aren’t sure if you have a 32-bit or 64-bit system, check Settings => System => About => System type.

#### Configuring Readarr Service

1. Open a Command Prompt administrator window. (To run as an admin,
    right click on the Command Prompt icon and choose “Run as
    administrator.”)
1. If Readarr is running, stop the service by running `nssm stop Readarr`
    in Command Prompt.
1. Now we have to edit the existing Readarr instance to explicitly point
    to its data directory. The default command is as follows:
    `sc config Readarr binpath= "C:\ProgramData\Readarr\bin\Readarr.exe
    -data=C:\ProgramData\Readarr"`

This command tells the original instance of Readarr to explicitly use
`C:\ProgramData\Readarr` for its data directory. If you didn't use the
default Readarr install, or if your data folder is somewhere else, you
may have to change your paths here.

#### Creating Readarr-audiobooks Service

1. Create a new folder where you’d like Readarr-audiobooks to live. Most use a similar place such as
    `C:\ProgramData\Readarr-audiobooks`
1. Back in Command Prompt, create the new Readarr-audiobooks service using `nssm
    install Readarr-audiobooks`. A popup window will open where you can type your
    parameters for the new instance. For this example, we will use the
    following:
      - Path: `C:\ProgramData\Readarr\bin\Readarr.exe`
      - Startup directory: `C:\ProgramData\Readarr\bin`
      - Arguments: `-data=C:\ProgramData\Readarr-audiobooks`

> Note that **Arguments** points to the *new* folder created in step 1.
This is crucial, as it keeps all the data files from both instances in
separate locations. {.is-warning}

1. Click *Install service*. The window should close and the service
    will now be available to run.
1. Continue to [Configuring Readarr-audiobooks](#windows-multi-config-second)

### Tray App (Windows)

#### Prerequisites (Tray App)

- [You must have Readarr already installed](#windows)
- Readarr must be configured with a `/data=` argument to allow multiple instances
- Navigate to the Startup Folder for the current user `%appdata%\Microsoft\Windows\Start Menu\Programs\Startup` and edit the existing shortcut if needed.

#### Creating Readarr-audiobooks Tray App

- Right click and Create New Shortcut
- Path: `C:\ProgramData\Readarr\bin\Readarr.exe /data=C:\ProgramData\Readarr-audiobooks`
- Give the shortcut a unique name such as `Readarr-audiobooks` and finish the wizard.
- Double click the new shortcut to run and test.
- Continue to [Configuring Readarr-audiobooks](#windows-multi-config-second)

### Configuring Readarr-audiobooks {#windows-multi-config-second}

- Regardless of if you used the Service Method or the Tray App: Stop both services and both Apps
- Start Readarr-audiobooks (Service or Tray App)
- Open up Readarr-audiobooks and Navigate within the app to [Settings => General => Host](/readarr/settings/#host)
- Change `Port Number` from `8787` to a different port e.g. `8879` so Readarr and Readarr-audiobooks do not conflict
- You should now be able to start both apps
- Continue to [Dealing with Updates](#dealing-with-updates)

### Dealing with Updates

- Disable automatic updates in one of your instances
- If one Readarr instance is updated, both instances will shutdown and only the updated one will start again. To fix this, you will have to manually start the other instance, or you may want to look into using the below powershell script to address the problem.

#### Windows Port Checker and Restarter PowerShell Script

{#win-portchecker}

- When you use two Readarr instances and one of it is updating, it will kill all instances. Only the one which is updating will come back online.
- The below powershell script should be configured as a scheduled task.
- It checks the ports and if one is not online, it will (re-)start the scheduled task to launch Readarr.

1. Create a new File and name it ReadarrInstancesChecker.ps1 with the below code.
1. Edit the script with your actual service names, IP, and ports.
1. [Create a scheduled task](https://www.thewindowsclub.com/schedule-task-in-windows-7-task-scheduler) to run the script on a repeating schedule.

- Security Options: Enable `Run with highest privileges`
  - Otherwise the script will be unable to manipulate services
- Trigger: `On Launch`
- Repeat task every: `5` or `10` minutes
- Action: `Start a Program`
- Program/script: `powershell`
- Argument: `-File D:\ReadarrInstancesChecker.ps1`
  - Be sure to use the full path to your script's location

```powershell
################################################################################################
### ReadarrInstancesChecker.ps1                                                               ###
################################################################################################
### Keeps multiple Readarr Instances up by checking the port                                  ###
### Please use Readarr´s Discord or Reddit for support!                                       ###
### https://wiki.servarr.com/readarr/installation#windows-multi                               ###
################################################################################################
### Version: 1.1                                                                             ###
### Updated: 2020-10-22                                                                      ###
### Author:  reloxx13                                                                        ###
################################################################################################



### SET YOUR CONFIGURATION HERE ###
# Set your host ip and port correctly and use your service or scheduledtask names!

# (string) The type how Readarr is starting
# "Service" (default) Service process is used
# "ScheduledTask" Task Scheduler is used
$startType = 'Service'

# (bool) Writes the log to C:\Users\YOURUSERNAME\log.txt when enabled
# $false (default)
# $true
$logToFile = $false


$instances = @(
    [pscustomobject]@{   # Instance 1
        Name = 'Readarr'; # (string) Service or Task name (default: Readarr)
        IP   = '192.168.178.12'; # (string) Server IP where Readarr runs (default: 192.168.178.12)
        Port = '8873'; # (string) Server Port where Readarr runs (default: 8873)
    }
    [pscustomobject]@{   # Instance 2
        Name = 'Readarr-audiobooks'; # (string) Service or Task name (default: Readarr-audiobooks)
        IP   = '192.168.178.12'; # (string) Server IP where Readarr runs (default: 192.168.178.12)
        Port = '8874'; # (string) Server Port where Readarr runs (default: 8874)
    }
    # If needed you can add more instances here... by uncommenting out the below lines
    # [pscustomobject]@{   # Instance 3
    # Name='Readarr-3D';    # (string) Service or Task name (default: Readarr-3D)
    # IP='192.168.178.12'; # (string) Server IP where Readarr runs (default: 192.168.178.12)
    # Port='8875';         # (string) Server Port where Readarr runs (default: 7875)
    # }
)


### DONT CHANGE ANYTHING BELOW THIS LINE ###


###
# This function will write to a log file or in console output
###
function Write-Log
{
    #Will write to C:\Users\YOURUSERNAME\log.txt
    
    Param(
        $Message,
        $Path = "$env:USERPROFILE\log.txt" 
    )

    function TS { Get-Date -Format 'hh:mm:ss' }
    
    #Console output
    Write-Output "[$(TS)]$Message"
    
    #File Output
    if ($logToFile)
    {
        "[$(TS)]$Message" | Tee-Object -FilePath $Path -Append | Write-Verbose
    }
}


Write-Log 'START ====================='


$instances | ForEach-Object {
    Write-Log "Check $($_.Name) $($_.IP):$($_.Port)"
    
    $PortOpen = ( Test-NetConnection $_.IP -Port $_.Port -WarningAction SilentlyContinue ).TcpTestSucceeded 
    
    if (!$PortOpen)
    {
        Write-Log "Port $($_.Port) is closed, restart $($startType) $($_.Name)!"

        if ($startType -eq 'Service')
        {
            Get-Service -Name $_.Name | Stop-Service
            Get-Service -Name $_.Name | Start-Service
        }
        elseif ($startType -eq 'ScheduledTask')
        {
            Get-ScheduledTask -TaskName $_.Name | Stop-ScheduledTask
            Get-ScheduledTask -TaskName $_.Name | Start-ScheduledTask
        }
        else
        {
            Write-Log '[ERROR] STARTTYPE UNKNOWN! USE Service or ScheduledTask !'
        }
    }
    else
    {
        Write-Log "Port $($_.Port) is open!"
    }
}

Write-Log 'END ====================='
```

## Linux Multiple Instances

{#linux-multi}

- [Swizzin Users](https://github.com/ComputerByte/readarr-audiobooks)
- Non-Swizzin Users
  - Ensure your first instance has the `-data=` argument passed.
  - Temporarily stop your first instance, so you can change the second instance's port `systemctl stop readarr`
  - Disable automatic updates on one of your Readarr Instances`

> Below is an example script to create a Readarr-audiobooks instance. The below systemd creation script will use a data directory of `/var/lib/readarr-audiobooks/`. Ensure the directory exists or modify it as needed.{.is-danger}

```shell
cat << EOF | sudo tee /etc/systemd/system/readarr-audiobooks.service > /dev/null
[Unit]
Description=Readarr-audiobooks Daemon
After=syslog.target network.target
[Service]
User=readarr
Group=media
Type=simple

ExecStart=/opt/Readarr/Readarr -nobrowser -data=/var/lib/readarr-audiobooks/
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

- Enable the Readarr-audiobooks service:

```shell
sudo systemctl enable --now -q readarr-audiobooks
```

## MacOS Multiple Instances

{#macos-multi}

This guide was made and tested with macOS 13 (Ventura), but should work on any version that Readarr supports.

### Prerequisites

- Must have the Readarr application installed in the `/Applications` folder
- If Readarr has already been used before, all the data will be lost. Move `~/.config/Readarr` to `~/.config/readarr-books` or `~/.config/readarr-audiobooks` to keep data.

### Creating Applications (easily start Readarr)

You will create two new applications: "Readarr Books" and "Readarr Audiobooks".

- Open the Automator app
- Select `New Document`, then `Application`
- Use the search box at the top left to look for `Run Shell Script`, then double-click on it
- In the box that opens, paste the following:

```shell
# Readarr Books
open -F -n -a Readarr --args -data="$HOME"/.config/readarr-books
```

- Save the application as `Readarr Books`
- Go to `File` > `Duplicate` in the menu bar
- Replace the contents of the script with the following:

```shell
# Readarr Audiobooks
open -F -n -a Readarr --args -data="$HOME"/.config/readarr-audiobooks
```

- Save the new application as `Readarr Audiobooks`
- View the applications in Finder, optionally change their icons to your liking (via the `Get Info` window).

### Configuring Instances

Now, you will be setting the ports and names for each instance.

- Pick a port number for each instance. For example, the default `8787` for e-books and `8789` for audiobooks.
- If one of the instances uses the default port number, launch the other one first. Otherwise, launch any one of them.
- Go to `Settings` > `General` in Readarr, and set the correct port.

> Optionally: Toggle advanced options and set `Instance Name` to your liking.
{.is-success}

- Launch the other instance and do the same.

### Updates

When you update one instance, the updater shuts both down and only restarts the one you updated. To work around this, a port checker periodic task will be created (adapted but slightly changed from the [Windows guide](#win-portchecker)).

- Disable auto updates in one of the instances, and make sure to never update it.
- Create a new file in a place you will remember, and name it `readarrportchecker.zsh`.
- Add the following content:

```shell
#!/bin/zsh

# First instance's *application name*
name0="Readarr Books"
# First instance's port number
port0=8787

# Second instance's *application name*
name1="Readarr Audiobooks"
# Second instance's port number
port1=8789

# Logging
LOGFILE="$HOME/.local/state/readarr.log"
test -d "$HOME/.local/state" || mkdir -p "$HOME/.local/state"

function checkport {
    lsof -i ":${1}" &>/dev/null
}

# One instance running means both should be
if checkport "${port0}" && ! checkport "${port1}"; then
  open -a "${name1}"
    echo "Opened ${name1}" >> "$LOGFILE"
elif checkport "${port1}" && ! checkport "${port0}"; then
  open -a "${name0}"
    echo "Opened ${name0}" >> "$LOGFILE"
fi
```

- Make the script executable:

```shell
chmod +x readarrportchecker.zsh
```

- Schedule the script to run periodically. Create a new file in `~/Library/LaunchAgents` named `local.readarr.portchecker.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>local.readarr.portchecker</string>
    <key>Program</key>
    <!-- Find the path by right clicking, then Option and copy -->
    <string>/path/to/readarrportchecker.zsh</string>
    <key>StartInterval</key>
    <!-- Periodic interval in seconds. 300 for five minutes,
         600 for ten minutes. -->
    <integer>300</integer>
  </dict>
</plist>
```

- Modify the file according to the comments
- Either re-login or manually load the file:

```shell
launchctl load ~/Library/LaunchAgents/local.readarr.portchecker.plist
```

> `TODO`: possibly integrate this into a custom script for the update process, or observe file change instead of running every 300 seconds.
{.is-info}

## Docker Multiple Instances

{#docker-multi}

- Simply spin up a second Docker container with a different name, ensuring the above requirements are met.
