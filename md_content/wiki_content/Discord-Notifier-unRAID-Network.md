This write up is to add the ability for discordnotifier.com to monitor
your docker containers to know if they are running as well as to see if
your server is still accessible by the internet. This script will send a
ping on predetermined intervals, if discordnotifier does not receive a
signal w/in 15 minutes it will start pinging your discord channel every
15 minutes until a new single resets it.

In order for this to work you'll need to have python3 installed on your
server

  - First we need to install NerdPack to install python3
  - Navigate to the AppStore on your unRAID server, type in the search
    box NerdPack and install `NerdPack GUI`
  - Once NerdPack is installed you'll be able to access it through
    unRAID's settings package
  - Now that you're in NerdPack's settings type in the search box python
    (this is located under \*Name\*)
  - Select the toggle to install and click Apply (the toggle is located
    on the far right **On** or **Off**, select **On**)

Since unRAID loads everything up into memory and if we install any
extras needed for this to run it will only run for that one instance of
the server running, if you reboot your server you'll have to manually
reinstall any required packages

Now we need to install **Requirements**

  - If you do not already have **CA User Scripts** navigate to the
    unRAID's AppStore and install just the same as NerdPack
  - The options for </code>User Scripts</code> can be found under
    unRAID's settings page as well
  - Now we need to install requirements
      - Click on `Custom Scripts`
      - Click **Add New Script**
      - Give your script a name, Something like `Install Requirements
        for Discord-Notifier` works
      - Copy and paste this text into the new page

<!-- end list -->

    #!/bin/bash
    python3.9 -m pip install requests

  -   - Click Apply
      - Click run script
      - On the drop down box to the right select the option to have this
        script run on `At first array starts only`

Now lets install the actual python3 script that will communicate to
discordnotifier.com

  - Open `User Scripts` again
  - Select new script
      - Copy and paste the code found
        [here](https://discordnotifier.com/scripts/discordnotifier-network.py).
      - Now that you have the code you'll need to change the heading of
        the script.
          - When you load up a new script into User Scripts this will be
            automatically placed in the code block.`#!/bin/bash` You'll
            need to change this line to `#!/usr/bin/python3.9`
      - Edit the variables as needed to meet the requirements of your
        server
      - Click Apply
  - Now we need to run this script on a set schedule with chron
  - On the drop down box for schedule select Custom
      - Copy and paste the chron schedule below into the field provided

` */5 * * * *`

This will run the script every 5 minutes

  - Click run script to make sure everything is working properlly
