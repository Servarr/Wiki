Lets start off with setting up DiscordNotifier on your Plex server.

First we are going to need a Docker container that has Python installed
already.

Hotio's container works perfectly as that is what I used so this writeup
will consist of things that work for that container. I cannot say if
there are any others out there that this will work on you'll have to
figure that out on your own.

If you do not have Hotio's container installed head over to the unRAID
app store. From there type in Plex look for the container built by Hotio
Now when you click the download button you'll be asked if you want to
install the release or autoscan version of his container. I'm sure
either will work but I chose the release version as I did not need the
autoscan function.

From here you'll have several things to input into your new container

`Name: If you want to change the name of the container go right ahead. I kept mines as Plex`  
`Network Type: Change this to host. This will make the container's IP address the same as the host machines.`  
`Port: number: this should be left alone unless it conflicts with any other application`  
`Host: Path for /config: This should also be left as is as your application data should be going to a cache drive of somesorts.`  
`Host: Path for /transcode: This is where you you want Plex to be doing its transcoding. `  
`This requires quite a bit of I/O to for this to happen with constant read/writes.`  
`There are many discussion on how to set up a proper transcoding directory.`

<table>
<thead>
<tr class="header">
<th><p>Thank you TRaSH for finding this information and sharing</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>So it turns out that by default Linux only allocates a max of 50% of total system RAM to any ram directories (ie. <code>/tmp</code> <code>/dev/shm</code> etc.). So to be able to use more than 50% of my system RAM in a writable directory I did the following:</p></td>
</tr>
<tr class="even">
<td><p>I added this to my Go file create a ramdisk that can use up to 75% of my system RAM:</p></td>
</tr>
<tr class="odd">
<td><p># Create ramdisk paths</p>
<p><code> mkdir -p /tmp/ramdisk &amp;&amp; mount -t tmpfs -o size=96g tmpfs /tmp/ramdisk</code><br />
<code> mkdir -p /tmp/ramdisk/plex</code><br />
<code> mkdir -p /tmp/ramdisk/nzbget</code><br />
<code> mkdir -p /tmp/ramdisk/emby</code></p></td>
</tr>
<tr class="even">
<td><p>I updated all my docker template paths that are writing to RAM (plex, emby, and nzbget) with the new paths.</p></td>
</tr>
<tr class="odd">
<td><p>I added this to my SMB Extras config to be able to quickly and easily view my ramdisk directories from Windows file explorer:</p></td>
</tr>
<tr class="even">
<td><p>RamDisk</p>
<p><code>   path=/tmp/ramdisk</code><br />
<code>     valid users = iamspartacus</code><br />
<code>     write list = iamspartacus</code></p></td>
</tr>
</tbody>
</table>

However based upon a write up on
[ServerBuilds.net](https://forums.serverbuilds.net/t/guide-plex-transcoding-and-ram-disks/625)
`I went ahead and put /dev/shm/`

  - Plex Claim: Simply copy and paste `plex.tv/claim` into your browser,
    when prompted to log into your Plex account. You'll be given a code
    to pass back to the container. Copy and paste that back into the
    container field
  - ADVERTISE\_IP: Set this to <http://>`<your server's IP
    address>:32400`
  - ALLOWED\_NETWORKS: Set this to your subnet ip adress. Since my
    subnet is `192.168.1.X` I set this as `192.168.1.0/24` the `0/24`
    simply states that all IP addresses on the 192.168.1.1 to
    192.168.1.244 are allowed to connect even when Plex's authentication
    servers are down.
  - Plex Pass: Select if you have the paid plex pass from Plex.tv

<!-- end list -->

  - From here we need to add the media directory now, Hotio does not put
    any preconfigured directories for your media.
  - Click `Add Another Path, Port, Variable, Label or Device`

` Name: Media`  
` Container Path: <-- this will be the directory that is inside the container that your media will be in.`  
` I go with /data`  
` Host Path: <-- This is where your media is actually stored on your server mines at /mnt/user/media/`  
` Click Add`

  - Click Apply, this will start the container in order to build all the
    required directories.
  - Now click on your newly created container then select stop.

<!-- end list -->

  - Now that thats all out of the way, lets go ahead and set up
    discord-notifier

<!-- end list -->

  - Download the python package
    [here](https://discordnotifier.com/scripts/discordnotifier-plex.zip).

<!-- end list -->

  - Extact the contents to someplace you'll remember.

<!-- end list -->

  - Open discordnotifier\_p3.py with a good text editor Windows =
    [notepad++](https://notepad-plus-plus.org) Mac =
    [Brackets](http://brackets.io)
  - Edit the discordnotifier\_p3.py file:

` 'api':'API KEY', # discordnotifier.com api key`  
`   'account_map':'email@mail.com,
Name', # for shared plex servers, you can map an email to a name.`  
`   'plex_host':'`<IP Address>`', <-- The url to your plex machine`  
`   'plex_port':'32400', <-- this is the default port set in the container`  
`   'plex_token':'Plex Token', # `[`finding``   ``an`` 
 ``authentication`` 
 ``token`](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/)  
`   'listen_host':'<IPADDRESS', # should be same host as plex_host`  
`   'listen_port':'32402 <-- leave this alone`  
`   'cpu_samples':'5', <-- Leave this alone`

  - Save the file
  - Now open a new file w/in notepad++ or Brackets
  - Copy this into your text editor:

` #!/usr/bin/with-contenv bash`  
` umask "${UMASK}"`  
` exec s6-setuidgid hotio python3 /config/scripts/discord-notifier/discordnotifier_p3.py`

  - Save this as something you'll remember (I recommend your desktop),
    this is how we are going to call the python script from inside the
    Docker container.

`   You'll want to make sure it has a *.sh extension. I named mine call.sh`

  - Inside unRAID's appdata (`/mnt/user/appdata`) navigate to plex then
    make a new folder named \*scripts\*
  - Drop the contents of discordnotifier-plex into that folder and
    rename the folder to discord-notifier
  - Drop call.sh (or what ever you named your bash script as) into the
    /scripts directory you created
  - So inside your scripts folder you'll have a folder named
    discord-notifier and a file named call.sh
  - Now back to the unRAID UI.
  - Navigate back to your plex Docker we made earlier and click on it
    then click edit.
  - All the way down at the bottom click `Add another Path, Port,
    Variable, Label or Device`
  - A new pop-up opens up to make a new path make sure Path is selected
    in the drop down box at the top

` Name: Script`  
` Container Path: /etc/services.d/notifier/run`  
` Host Path: /mnt/user/appdata/plex/scripts/call.sh`  
` Default Value: <-- Leave blank`  
` Access Mode: Read/Write`  
` Description: <-- Leave blank`

  - Click Add
  - Click Apply
  - Once plex is up and running click on the container and open up the
    `WebUI` navigate to Settings \> Webhooks from here click `Add
    Webhook`
  - Here you'll add <http://>`<Your server's ip address>:32402`

From here play a movie and make sure it all works.
