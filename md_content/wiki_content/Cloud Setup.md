Rclone, Mergerfs, and Google Drive
----------------------------------

**Please note that this guide is maintained and developed by the
community and not the \*Arr Teams**

With many options for storing \'unlimited\' data in the cloud,
configuring your system to allow your Arr\'s and media serving apps to
access the data securely is possible. For this guide we will use [Google
Suite Unlimited Storage](https://gsuite.google.com/products/drive/) or a
similar [Rclone](https://rclone.org/) compatible storage service. We
will also use a utility called Mergerfs to help keep our uploads
organized.

Please note that this guide is for information only and you should only
store legally obtained media.

Please Note: To get \"unlimited\" storage with Google Drive, you require
an Enterprise Workspace Plan. It appears very likely that unlimited
storage is going away.

Application Overview
--------------------

Recommendations:

-   **Don\'t download into your Gdrive** - Download to a local disk and
    move the data later with Rclone
-   **Don\'t import to your Gdrive** - Set up a merged local cache disk
    and move the data later with Rclone
-   **Do all large writes locally**
-   **Move to cloud on a schedule** - Easily scriptable
-   **Absolutely do not write (large files) directly to the rclone
    mount**

To connect with your Gdrive, you will need to use three applications:

1.  Rclone - <https://rclone.org/install/>
2.  mergerfs - <https://github.com/trapexit/mergerfs>
3.  fuse -
    <https://manpages.ubuntu.com/manpages/eoan/man8/mount.fuse.8.html>

Once you have set up these applications, it is highly recommended to set
up a cron job to automatically move files from your local drive to the
cloud using Rclone. Animosity22 has [a terrific Github
page](https://github.com/animosity22/homescripts) with a sample script,
or [see the example
below.](Cloud_Setup#Nightly_Cloud_Upload_Example "wikilink")

### Rclone

Rclone\'s core purpose for the Arr\'s is to allow access to your data
depository that is located in Gdrive. Rclone will mount and serve your
file automatically, with your apps not knowing they are accessing data
in the cloud. More Rclone information can be found on [animosity22\'s
Github page.](https://github.com/animosity22/homescripts)

To install Rclone, run the following command:

    curl https://rclone.org/install.sh | sudo bash 

#### Setting up Rclone

Before we can run Rclone\'s config tool, we must create a Google API
Client ID for your system. The default Rclone config will use the Rclone
client ID, which is not recommended: Everyone should create a personal
client ID.

1.  Log into the Google API Console with your Google account. It
    doesn\'t matter what Google account you use. (It need not be the
    same account as the Google Drive you want to access)
    <https://console.developers.google.com/apis/dashboard>
2.  Select a project or create a new project.
3.  Under \"ENABLE APIS AND SERVICES\" search for \"Google Drive\", and
    `enable` the \"Google Drive API\". ![ENABLE APIS AND
    SERVICES](ENABLE_APIS_AND_SERVICES.png "fig:ENABLE APIS AND SERVICES")
4.  Click \"Credentials\" in the left-side panel, then \"Create
    Credentials\" in the upper right. ![Create New
    Credentials](Google_Drive_Credentials_Screenshot.png "fig:Create New Credentials")
5.  If you already configured an \"Oauth Consent Screen\", then skip to
    the next step; if not, click on \"CONFIGURE CONSENT SCREEN\" button
    (near the top right corner of the right panel), then select
    \"External\" and click on \"CREATE\"; on the next screen, enter an
    \"Application name\" (\"rclone\" is OK) then click on \"Save\" (all
    other data is optional). Click again on \"Credentials\" on the left
    panel to go back to the \"Credentials\" screen.
6.  Click on the \"+ CREATE CREDENTIALS\" button at the top of the
    screen, then select \"OAuth client ID\".
7.  Choose an application type of \"Desktop app\" if you using a Google
    account or \"Other\" if you using a GSuite account and click
    \"Create\". (the default name is fine)
8.  It will show you a client ID and client secret. Write or copy these
    values down. Use these values in rclone config to add a new remote
    or edit an existing remote.

Setup your Google Service Account (SA) file this allows it to not be
tied to a single user account.

1.  go to the Google Developer Console.
2.  go to \"IAM & admin\" -\> \"Service Accounts\".
3.  Use the \"Create Credentials\" button. Fill in \"Service account
    name\" with something that identifies your client. e.g. `mount`Leave
    \"Role\" Empty
4.  Tick \"Furnish a new private key\" - select \"Key type JSON\".
5.  Tick \"Enable G Suite Domain-wide Delegation\". These credentials
    are what rclone will use for authentication. If you ever need to
    remove access, press the \"Delete service account key\" button.

Allow API access to Google Drive

1.  go to admin console
2.  Go into \"Security\" (or use the search bar)
3.  Select \"Show more\" and then \"Advanced settings\"
4.  Select \"Manage API client access\" in the \"Authentication\"
    section
5.  In the \"Client Name\" field enter the service account\'s \"Client
    ID\" - this can be found in the Developer Console under \"IAM &
    Admin\" -\> \"Service Accounts\", then \"View Client ID\" for the
    newly created service account. It is a \~21 character numerical
    string.
6.  In the next field, \"One or More API Scopes\", enter
    <https://www.googleapis.com/auth/drive> to grant access to Google
    Drive specifically.

Now that you have the API access squared away, you can run the rclone
`config` utility to create your rclone.conf file.

`rclone config`

1.  `n` - New Remote
2.  `cloud` - Name of your new remote
3.  `13` - Google Drive
4.  `abunchofnumbersandletters.apps.googleusercontent.com` Enter your
    Google Application Client Id
5.  `yourgoogleapplicationclientsecret`Enter your Google Application
    Client Secret
6.  `1` - Full Access
7.  Leave Blank ID of the root folder
8.  Enter the path and filename to your Google Drive SA Json
9.  `n` - Do Not Use Auto Config
10. `y` - Use Team Drive
11. Review for Accuracy

You can now mount your newly created remote to access your cloud
storage:

` rclone mount --daemon --daemon-timeout=5m --allow-non-empty --buffer-size=128M --use-mmap --dir-cache-time=48h --cache-info-age=48h --vfs-cache-mode=full --vfs-cache-max-age=6h --log-file=~/.config/rclone/logs/rclone.log --log-level INFO cloud: /mnt/cloud`

When you executed `rclone config` above, it created a file `rclone.conf`
and placed it at `~/.config/rclone.conf`. If you intend to have your OS
auto-mount your new rclone mount using systemd, ensure this file is
accessible by the user you have in your .conf file.

#### Encrypting your Cloud Storage

If you followed the previous steps, you created an unencrypted Google
Drive mount. If you would like to encrypt your storage so that Google
can not scan your files, then follow these optional steps:

Start by running Rclone\'s config tool again, as you did previously:
`rclone config`

1.  `n` - New Remote
2.  `cloudcrypt` - Name of your new encrypted remote
3.  `crypt` - Encrypt/Decrypt a remote
4.  `cloud:crypt` - Remote to encrypt/decrypt, followed by a semicolon
    and a name indicating the function.
5.  `standard` - How to encrypt the filenames.
6.  `true` - Encrypt directory names

The next few questions will ask you to create two passwords, one for the
encryption and one for the salt. It is recommended to choose two
different passwords, and for the best protection, allow them to be
generated for you and document them somewhere safe.

Once the password section is finished, it should present you with the
new config, which should look similar to this:

` [cloudcrypt]`\
` type = crypt`\
` remote = cloud:crypt`\
` filename_encryption = standard`\
` directory_name_encryption = true`\
` password = **Encrypted PW1**`\
` password2 = **Encrypted PW2**`

Finally, make sure when you run rclone (either manually or via autostart
script), you mount `cloudcrypt` rather than calling `cloud`.

#### Rclone Linux Autostart using Systemd

Most modern Linux distributions have switched to systemd, which involves
a simple unit service file which gets enabled and started. It is
important to remember that in Linux, capitalization matters. `User`
account names and `Group` names are typically all lowercase, as are the
directory structures mapped to them as part of the home directory.

##### Preparing the Unit Service File

Several items may need to be changed to match your installation:

1.  `User` should match the service account that Rclone will run as.
2.  `Group` should match the service account group that Rclone will run
    as.

The unit service file should be named `Rclone.service` and the best
place for it is `/etc/systemd/system/`. Alternative locations like
`/usr/lib/systemd/system/` and `/lib/systemd/system/` may depend on the
distribution used.

This example unit assumes that the `User` and `Group` are both `plex`,
Rclone\'s executable is placed in `/usr/bin/`, your cloud storage is
being mounted to `/cloud`, and you have previously ran Rclone and set up
a config file, which is located at `~/.config/rclone/rclone.conf` Feel
free to remove the `# comment` lines, they are there for those who want
to know what those flags are doing and were taken from the rclone
documentation.

` [Unit]`\
` Description=Google Drive Encrypted (rclone)`\
` Wants=network-online.target`\
` After=network-online.target`\
` `\
` [Service]`\
` Type=notify`\
` ExecStart=/usr/bin/rclone mount cloud: /mnt/cloud \`\
` # Allow mounting over a non-empty directory (not Windows).`\
` --allow-non-empty \`\
` # In memory buffer size when reading files for each --transfer. (default 16M)`\
` --buffer-size=128M \`\
` # Use mmap allocator (see docs).`\
` --use-mmap \`\
` # Time to cache directory entries for. (default 5m0s)`\
` --dir-cache-time=48h \`\
` # How long to cache file structure information (directory listings, file size, times etc). (default 6h0m0s)`\
` --cache-info-age=48h \`\
` # Cache mode off|minimal|writes|full (default off)`\
` --vfs-cache-mode=full \`\
` # Max age of objects in the cache. (default 1h0m0s)`\
` --vfs-cache-max-age=6h \`\
` # Override the permission bits set by the filesystem.`\
` --umask 002 \`\
` # Location where rclone logs will be stored`\
` --log-file=~/.config/rclone/logs/rclone.log \`\
` # Logging level for rclone logs`\
` --log-level INFO \`\
` # Location where the rclone.conf file is located`\
` --config ~/.config/rclone/rclone.conf`\
` ExecStop=/bin/fusermount -uz /mnt/cloud`\
` Restart=on-abort`\
` User=plex`\
` KillMode=none`\
` RestartSec=5`\
` `\
` [Install]`\
` WantedBy=default.target`

##### Verify Directory Permissions

Ensure the `User` that will be running Rclone has access to both the
executable directory and data directory. Running the command
`ls -lad /directory/` will show the permissions for that folder. In the
example below, the user and group are both `plex`. Example:

`$ ls -lad /cloud`\
`drwxr-xr-x 6 plex plex 24576 Nov 28 21:30 /cloud`\
`$ ls -lad /home/plex/.config/rclone/`\
`drwxr-xr-x 6 plex plex 24576 Nov 28 21:30 /home/plex/.config/rclone/`

##### Enabling and starting the Unit Service File

Once you have created `Rclone.service`, you will want to enable the
service:

`sudo systemctl enable Rclone.service`

You are now ready to start Rclone. You can do so with the `start`
command:

`sudo systemctl start Rclone.service`

If you want to verify Rclone is running, you can run the `status`
command:

` $ sudo systemctl status rclone.service `\
` ● rclone.service - Google Drive Encrypted (rclone)`\
`      Loaded: loaded (/etc/systemd/system/rclone.service; enabled; vendor preset: enabled)`\
`      Active: active (running) since Sun 2020-11-15 16:28:26 MST; 2 weeks 4 days ago`\
`    Main PID: 2392484 (rclone)`\
`       Tasks: 31 (limit: 76935)`\
`      Memory: 21.9G`\
`      CGroup: /system.slice/rclone.service`\
`              └─2392484 /usr/bin/rclone mount cloud: /cloud --allow-non-empty --buffer-size=128M --use-mmap --dir-cache-time=48h >`\
` Nov 15 16:28:25 systemname systemd[1]: Starting Google Drive Encrypted (rclone)...`\
` Nov 15 16:28:26 systemname systemd[1]: Started Google Drive Encrypted (rclone).`

### Mergerfs

Mergerfs core purpose for the Arr\'s is to allow you to have a single
merged directory structure, based on two different directories. For
example, if you used rclone to mount a directory named `/mnt/cloud` and
you have a locally mounted directory named `/mnt/local`, `mergerfs`
would create a single merged directory of those two, which you could
call `/mnt/merge`. Your media server and Arrs would access `/mnt/merge`
and see the combination of local + cloud storage.

Example: You have the first 4 episodes of \'Popular TV Show\' located on
your cloud drive, and Sonarr just downloaded and imported episode 5. If
you looked in your cloud drive (/mnt/cloud), you would see:

` /mnt/cloud/TV Shows/Popular TV Show/S01E01.mkv`\
` /mnt/cloud/TV Shows/Popular TV Show/S01E02.mkv`\
` /mnt/cloud/TV Shows/Popular TV Show/S01E02.mkv`\
` /mnt/cloud/TV Shows/Popular TV Show/S01E04.mkv`

If you looked in your local storage (/local) you would see:

` /mnt/local/TV Shows/Popular TV Show/S01E05.mkv`

And if you looked in the merged directory thanks to mergerfs (/merge)
you would see:

` /mnt/merge/TV Shows/Popular TV Show/S01E01.mkv`\
` /mnt/merge/TV Shows/Popular TV Show/S01E02.mkv`\
` /mnt/merge/TV Shows/Popular TV Show/S01E02.mkv`\
` /mnt/merge/TV Shows/Popular TV Show/S01E04.mkv`\
` /mnt/merge/TV Shows/Popular TV Show/S01E05.mkv`

None of your applications know that these files have two different real
file paths. All new files would always be written to your local HD, then
you can use Rclone to sync them to the cloud later. When that sync is
completed, its invisible to your apps so you do not need to worry about
missing episodes or movies.

#### Setting up Mergerfs

Mergefs has a dependency on Fuse, so we will start by installing that:

` sudo apt install fuse`

Next, we must modify the `fuse.conf` file to enable the `allow_other`
funtion:

` sudo nano /etc/fuse.conf`

Modify the last line by removing the \# before `user_allow_other`. It
should look like this:

`  # Allow non-root users to specify the allow_other or allow_root mount options.`\
`  user_allow_other`

Now we can install Mergerfs. Go to the [Mergerfs github
page](https://github.com/trapexit/mergerfs/releases) and download the
newest release that matches your install.

    wget https://github.com/trapexit/mergerfs/releases/download/2.32.0/mergerfs_2.32.0.ubuntu-focal_amd64.deb

And then install it:

` dpkg -i mergefs*.deb`

To execute Mergerfs, run the following command. This assumes your local
storage is mounted at `/mnt/local`, your cloud storage is mounted at
`/mnt/cloud`, and your merged mount is `/mnt/merge`. *Note:* There are
no spaces in the variables passed to the `-o` flag, so it looks like a
giant run on list and should be a single line.

`  /usr/bin/mergerfs /mnt/local:/mnt/cloud /mnt/merge -o rw,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=auto-full,statfs_ignore=nc,func.getattr=newest,dropcacheonclose=true,nonempty`

Once you verify that everything is working, it is recommended to use an
autostart file configured to start after Rclone.

#### Mergerfs Linux Autostart using Systemd

Most modern Linux distributions have switched to systemd, which involves
a simple unit service file which gets enabled and started. It is
important to remember that in Linux, capitalization matters. `User`
account names and `Group` names are typically all lowercase, as are the
directory structures mapped to them as part of the home directory.

##### Preparing the Unit Service File

Several items may need to be changed to match your installation:

1.  `User` should match the service account that Mergerfs will run as.
2.  `Group` should match the service account group that Mergerfs will
    run as.

The unit service file should be named to match your merged folder name.
If you have followed along with this wiki, that name would be `merge` so
your service file would be named`merge.service`, and the best place for
it is `/etc/systemd/system/`. Alternative locations like
`/usr/lib/systemd/system/` and `/lib/systemd/system/` may depend on the
distribution used.

This example unit assumes that the `User` and `Group` are both `plex`,
Mergerfs\'s executable is placed in `/usr/local/bin/`, your local
storage is mounted at `/mnt/local`, your cloud storage is mounted at
`/mnt/cloud`, and your merged mount is `/mnt/merge`.

` [Unit]`\
` Description=Mergerfs Mount (merge)`\
` Requires=rclone.service`\
` After=rclone.service`\
` `\
` [Service]`\
` Type=forking`\
` ExecStart=/usr/bin/mergerfs /mnt/local:/mnt/cloud=NC /mnt/merge \`\
` -o rw,use_ino,allow_other,func.getattr=newest,category.action=all,category.create=ff,cache.files=auto-full,statfs_ignore=nc,func.getattr=newest,dropcacheonclose=true,nonempty`\
` KillMode=process`\
` Restart=on-failure`\
` User=plex`\
` Group=plex`\
` `\
` [Install]`\
` WantedBy=multi-user.target`

##### Verify Directory Permissions

Ensure the `User` that will be running Mergerfs has access to all data
directories. Running the command `ls -lad /directory/` will show the
permissions for that folder. In the example below, the user and group
are both `plex`. Example:

`$ ls -lad /mnt/cloud`\
`drwxr-xr-x 6 plex plex 24576 Nov 28 21:30 /mnt/cloud`\
`$ ls -lad /mnt/local`\
`drwxr-xr-x 6 plex plex 24576 Nov 28 21:30 /mnt/local`\
`$ ls -lad /mnt/merge`\
`drwxr-xr-x 6 plex plex 24576 Nov 28 21:30 /mnt/merge`

##### Enabling and starting the Unit Service File

Once you have created `merge.service`, you will want to enable the
service:

`sudo systemctl enable merge.service`

You are now ready to start Mergerfs. You can do so with the `start`
command:

`sudo systemctl start merge.service`

If you want to verify Mergerfs is running, you can run the `status`
command:

` $ sudo systemctl status merge.service `\
` ● merge.service - Mergerfs Mount (merge)`\
`      Loaded: loaded (/etc/systemd/system/merge.service; enabled; vendor preset: enabled)`\
`      Active: active (running) since Sun 2020-11-15 16:28:26 MST; 2 weeks 4 days ago`\
`    Main PID: 2392484 (mergerfs)`\
`       Tasks: 31 (limit: 76935)`\
`      Memory: 21.9G`\
`      CGroup: /system.slice/merge.service`\
`              └─2392484 /usr/local/bin/mergerfs /mnt/local:/mnt/cloud /mnt/merge -o rw,use_ino,allow_other,func.getattr=newest, >`\
` Nov 15 16:28:25 systemname systemd[1]: Starting Mergerfs Mount (merge)...`\
` Nov 15 16:28:26 systemname systemd[1]: Started Mergerfs Mount (merge).`

### Nightly Cloud Upload Example

Once Rclone and Mergefs are set up and configured, all data should be
written on your local disk first. You will want to sync this data to
your cloud drive then remove it to ensure your local disk does not run
out of space. Below is an example bash shell script you may want to use,
modeled on Animosity22\'s [upload\_cloud
script](https://github.com/animosity22/homescripts/blob/master/scripts/upload_cloud).

First start by creating your script.

` nano ~/.config/scripts/nightly_cloud_sync.sh`

Example Script:

``` {.bash}
  #!/bin/bash
  # Variables to verify match your installation
  # Rclone Config file
  RCLONE_CONFIG=/home/plex/.config/rclone/rclone.conf
  export RCLONE_CONFIG
  # User account that Rclone is running as
  RCLONE_USER_AGENT=plex
  export RCLONE_USER_AGENT
  # Local Mount - Ensure this is set to your local disk only.
  LOCAL=/local
  EXCLUDES=/home/plex/.config/scripts/excludes.log
  LOGFILE=/home/plex/.config/scripts/upload.log
  # Name of your Rclone Remote, likely cloud or cloudcrypt
  REMOTE=cloud
  # This will allow for 3 days for media analysis / intro generation. Feel free to reduce if needed.
  MOVEAGE=3d

  # Checks
  # Running Check
  if [[ $(pidof -x "$(basename "$0")" -o %PPID) ]]; then exit; fi
  # Exclude File Check
  if [[ ! -f $EXCLUDES ]] ; then
      echo 'Warning: No excludes.log file found at $EXCLUDES'
      exit 1
  fi
  # Local Disk Check
  if /bin/findmnt $LOCAL -o FSTYPE -n | grep fuse; then
          echo "Warning: $LOCAL is not a local disk!"
          exit 1
  fi
  # Rclone Move Command
  /usr/bin/rclone move $LOCAL $REMOTE: --log-file $LOGFILE -v --exclude-from $EXCLUDES --delete-empty-src-dirs --fast-list  --min-age $MOVEAGE
```

To add this file to your cron job list, edit your crontab. Ensure your
are logged in as the users you want the crontab to run as.

` crontab -e`

Add the following lines at the bottom of the folder.

` # Nightly Cloud Sync`\
` 12 3 * * * ~/.config/scripts/nightly_cloud_sync.sh`

Recommended Plex Server Changes
-------------------------------

### Increase the Default Cache Size of your Plex DB

With unlimited storage, some servers may run into database
locking/timeout issues. Increasing the default cache size could help
alleviate this.

1.  Stop Plex
2.  Locate your Plex DB. cd plex/Library/Application Support/Plex Media
    Server/Plug-in Support/Databases
3.  Run this command: `sqlite3 com.plexapp.plugins.library.db`
4.  The SQLLite prompt will open up. Type this next:
    `PRAGMA default_cache_size = 6000000;` and don\'t forget the
    trailing semicolon.
5.  There will be no confirmation that anything happened. Press CTRL + D
    to exit SqlLite.
6.  Start Plex.

### Increase the number of file watchers

Helps performance when you have a lot of files and directories in cloud
storage. [Source.](https://forums.plex.tv/t/linux-tips/276247/9) Edit
your `sysctl.conf` file:

` sudo nano /etc/sysctl.conf`

Add the following lines at the bottom:

` # Increase File Watchers for Plex`\
` fs.inotify.max_user_watches=262144`

You will need to restart your system for this change to take effect.
