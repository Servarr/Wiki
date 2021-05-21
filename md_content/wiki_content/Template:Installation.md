<noinclude> <templatedata> {

`   "params": {`  
`       "ARRNAME": {`  
`           "description": "Name of the ARR",`  
`           "example": "Radarr",`  
`           "type": "string",`  
`           "required": true,`  
`           "default": "Fake Radarr"`  
`       },`  
`       "RunArrCommandLinux": {`  
`           "description": "Command to Start & Run ARR Linux",`  
`           "example": "./opt/Radarr/Radarr -nobrowser -data=/home/radarr/.config/Radarr/",`  
`           "type": "string",`  
`           "required": true`  
`       },`  
`       "RunArrCommandOSX": {`  
`           "description": "Command to Start & Run ARR OSX",`  
`           "example": "./opt/Radarr/Radarr -nobrowser -data=/home/radarr/.config/Radarr/",`  
`           "type": "string",`  
`           "required": true`  
`       },`  
`       "ArrExecutableNameWin": {`  
`           "description": "Executable Name for Windows",`  
`           "example": "Radarr.exe",`  
`           "type": "string",`  
`           "required": true`  
`       },`  
`       "ArrDownloadLink": {`  
`           "description": "Link to the Arr Downloads",`  
`           "type": "url",`  
`           "required": true`  
`       },`  
`       "ArrLinuxAutoStart": {`  
`           "description": "Autostart file instructions",`  
`           "required": true`  
`       },`  
`       "ARRPORT": {`  
`           "description": "Port number for the ARR",`  
`           "example": "Radarr: 7878, Sonarr: 8989, Lidarr: 8686, Readarr: 8787",`  
`           "type": "number",`  
`           "default": "7878",`  
`           "required": true`  
`       },`  
`       "ARRNAME2": {`  
`           "description": "Used for lowercase ARR names, this is not a required field only used if needed",`  
`           "example": "radarr, sonarr, lidarr, readarr",`  
`           "type": "string"`  
`       }`  
`   },`  
`   "paramOrder": [`  
`       "ARRNAME",`  
`       "RunArrCommandLinux",`  
`       "RunArrCommandOSX",`  
`       "ArrExecutableNameWin",`  
`       "ArrDownloadLink",`  
`       "ArrLinuxAutoStart",`  
`       "ARRPORT",`  
`       "ARRNAME2"`  
`   ],`  
`   "description": "This template is expressly for the steps and processes of installing all the various ARR software on multiple different platforms"`

} </templatedata> </noinclude>

# Installing

## Windows

Please see the the  website for the Windows installer.

## OSX

{{\#lst::Installation Misc|\_osx\_installation}}

## Linux

{{\#lst::Installation Misc|\_linux\_installation}}

### Auto Start Using Systemd

Most modern Linux distributions have switched to systemd, which involves
a simple unit service file which gets enabled and started. It is
important to remember that in Linux, capitalization matters. `User`
account names and `Group` names are typically all lowercase, as are the
directory structures mapped to them as part of the home directory.

#### Preparing the Unit Service File

Several items may need to be changed to match your installation:

1.  `User` should match the service account that  will run as.
2.  `Group` should match the service account group that  will run as.
3.  `ExecStart` has several items that should match your installation
    `/opt/``/`
    1.  Executable Path Default location is `/opt/``/`, but you may need
        to update if you installed  elsewhere.
    2.  Data Directory Default location is
        `-data=/home/$USER/.config/``/`, but you may need to update if
        you want to keep your database and settings elsewhere.

The unit service file should be named `.service` and the best place for
it is `/etc/systemd/system/`. Alternative locations like
`/usr/lib/systemd/system/` and `/lib/systemd/system/` may depend on the
distribution used.

This example unit assumes that the `User` and `Group` are both , 's
executable is placed in `/opt/``/`. Please update the data path to where
you want the database, logs, and other metadata stored.

{{\#lst::Installation Misc|\_installation\_unit\_service\_file}}

#### Verify Directory Permissions

Ensure the `User` that will be running  has access to both the
executable directory and data directory. Running the command `ls -lad
/directory/` will show the permissions for that folder. Example:

`$ ls -lad /opt/`  
`drwxr-xr-x 6 `` `` 24576 Nov 28 21:30 /opt/``/`  
`$ ls -lad /home/$User/.config/``/`  
`drwxr-xr-x 6 `` `` 24576 Nov 28 21:30 /home/$User/.config/``/`

#### Enabling and starting the Unit Service File

Once you have created `.service`, you will want to enable the service:

`sudo systemctl enable ``.service`

You are now ready to start . You can do so with the `start` command:

`sudo systemctl start ``.service`

If you want to verify  is running, you can run the `status` command:

` $ sudo systemctl status ``.service`  
`● ``.service - ``Service`  
`   Loaded: loaded (/usr/lib/systemd/system/``.service; enabled; vendor preset: disabled)`  
`   Active: active (running) since Tue 2017-03-07 10:23:44 PST; 5min ago`  
` Main PID: 19978 (``)`  
`    Tasks: 16 (limit: 4915)`  
`   Memory: 114.6M`  
`      CPU: 9.331s`  
`   CGroup: /system.slice/``.service`  
`           └─19978 /opt/``/`` -nobrowser -data=/path/to/data/.config/``/`  
`Mar 07 10:23:44 apollo systemd[1]: Started `` Service.`

### NGINX Reverse Proxy

A reverse proxy allows you to set up  so you can access it from the web
without using the port number. Rather than mydomain.com: you would use
mydomain.com/ instead.

It is assumed you have NGINX installed.

Create a text file named .conf and place it in your default NGINX App
directory, typically `/etc/nginx/conf.d/apps`

1.   Reverse Proxy
2.  Be sure to set your Base-URL in 

`   location /`` {`  
`           proxy_pass `<http://127.0.0.1>`:``/``;`  
`           proxy_set_header X-Real-IP $remote_addr;`  
`           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;`  
`           proxy_set_header X-Forwarded-Proto $scheme;`  
`           proxy_http_version 1.1;`  
`           proxy_no_cache $cookie_session;`  
`           proxy_set_header Upgrade $http_upgrade;`  
`           proxy_set_header Connection $http_connection;`  
`           # Allow the `` API`  
`           location /``/api { auth_request off;`  
`                   proxy_pass `<http://127.0.0.1>`:``/``/api;`  
`           }`  
`   }`

Please note: It is important to ensure that the line `proxy_set_header
Connection $http_connection;` is accurate. The NGINX documentation
recommends setting this to `Upgrade` rather than `$http_connection;` but
this will NOT work.

Once you have saved the file, test your NGINX config:

` sudo nginx -t`

Which should show this:

` nginx: the configuration file /etc/nginx/nginx.conf syntax is ok`  
` nginx: configuration file /etc/nginx/nginx.conf test is successful`

Now you can have NGINX reload it's configuration to use the new file:

` sudo nginx -s reload`

Finally, make sure you add your URL Base to . This should match what you
have next to the word Location in the .conf file, with the leading
slash, likely this: `/` The URL base can be set here:
<https://wiki.servarr.com/>\_Settings\#Host

## Docker

[Please refer to TRaSH's
Guide.](https://trash-guides.info/Misc/how-to-set-up-hardlinks-and-atomic-moves/#description)

## Docker on unRAID

  - Installation of  is quite simple when it comes to unRAID as they
    have made installing Docker containers a breeze.

<!-- end list -->

1.  Simply head on over to the community applications store on the top
    bar of your browser.  

![Communitty Applications](unraid-install1.png
"Communitty Applications")

<li>

In the search field type in   

</li>

<li>

Select which docker image you would like to install. There are several
to choose from  

</li>

` `![`Installation``   ``Options`]({{{ARRNAME}}}-unraid-install.png
"Installation Options")  
` `

<li>

Depending on which container you go with will determine the steps in
which you take. Some containers come preloaded with volumes mapped
already. This is really up to your liking how you would like your
container volumes to be laid out. It is highly recommended to follow the
guide listed [here](Docker_Guide "wikilink") for your volume mapping  

</li>

Depending on which container you select you may recieve a pop up asking
you to **Choose A Branch To Install** when in doubt go with the `Default
:latest` branch

<li>

Once you have selected which container you are going to go with, you
will need to either create the volumes for  to be able to use or simply
use the pre-filled ones. (Highly recommended to remove the pre-filled
and use your own, to remove the pre-filled ones).  

</li>

To remove the pre-filled paths simply select the toggle in the upper
right from **Basic** to **Advanced** view then scroll down to the
pre-filled path and click **Remove**

![Toggle Advanced](unraid-install3.png "Toggle Advanced")

1.  To create new volumes simply select the `Add another Path, Port,
    Variable, Label or Device` text at the bottom above the **Apply**
    button.  
2.  Once the new window appears you will want to use the drop down box
    next to **Config Type:** and make sure that it is set to **Path**.  
3.  From here you will want to fill out all pertinent information:  

<!-- end list -->

1.  **Name:** The name of this path, this can be any unique name more
    like a note to know what this path is for.  
2.  **Container Path:** This will be the path that  will see inside the
    container `/data` is a favorite  
3.  **Host Path:** This is the path to the host (unRAID) machine, This
    will be `/mnt/user/`<Your User Share>  

**NOTE** If you follow the [Docker Guide](Docker_Guide "wikilink") you
will only need one Volume path to be made as all information that  will
need will be in one share `/mnt/user/data`

<li>

The last three items **Default Value:**, **Access Mode"**, and
**Description:** Can be left alone.  

</li>

<li>

Click **ADD**  

</li>

![Add New Path](unraid-install4.png "Add New Path")

</ol>

<li>

Last thing to check is to make sure Host Port for  is filled in with ,
*UNLESS* This port causes any conflicts with any other container. If it
does please choose a different port that is not in use.  

</li>

<li>

Click **APPLY**  

</li>

</ol>

<li>

Now the 's container is being downloaded, once complete simply click the
**OK** button at the bottom of the new pop up window  

</li>

<li>

Click **DOCKER** on the top row of your browser.  

</li>

<li>

Now all you will need to do is simply left click on your newly created
container and select **WebUI**.  

</li>

` `![`Select``   ``WebUI`](unraid-install2.png "Select WebUI")  
` `

<li>

Now a new browser tab should show up with  running in all its glory.  

</li>

</ol>
