## Connect

### Radarr

<section begin=radarr_settings_connect_connections />

Connections are how you want Radarr to communicate with the outside world.

  - By pressing the `+` button you'll be presented with a new window which will allow you to configure many different endpoints
      - There are many different endpoints
          - [Boxcar](https://boxcar.io)
          - [Custom Scripts](Radarr_Tips_and_Tricks#Custom_Post_Processing_Scripts "wikilink") - This allows you to make a custom script for when a particular action happens this script will run
          - [Discord](https://discord.com) - By far one of the most common ways to push notifications of actions happening on your Radarr
          - [Notifiarr](https://notifiarr.com) - The brainchild of one of the Radarr developers allowing you to have beautiful discord notifications with very fine tuned control. Constantly being updated and a favorite amongst many of the Radarr team.
          - Email - Simply send yourself or somebody you want to annoy with email. [If you're using Gmail, you need to enable less secure apps.](https://support.google.com/accounts/answer/6010255?hl=en) If you're using Gmail and have 2-factor authentication enabled you need to [use an App Specific password.](https://support.google.com/accounts/answer/185833)
              - You can use a "pretty address" like `SomePrettyName <email@example.org>`
          - [Emby](https://emby.media)
          - [Gotify](https://gotify.net)
          - [Join](https://joaoapps.com/join/)
          - [Kodi](https://kodi.tv) - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.
              - By adding Kodi as a connection you can update Kodi's library when a new movie has been added to Radarr
          - [Plex Media Server](https://plex.tv) - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded movie is available
          - [Prowl](https://www.prowlapp.com)
          - [Pushbullet](https://www.pushbullet.com)
          - [Pushover](https://pushover.net)
          - [Sendgrid](https://sendgrid.com)
          - [Slack](https://slack.com)
          - [Synology Indexer](https://www.synology.com/en-global/knowledgebase/DSM/help/DSM/AdminCenter/application_indexservice_desc)
          - [Telegram](https://telegram.org)
          - [Trakt](https://trakt.tv/dashboard)
          - [Twitter](https://twitter.com)
              - Create a Twitter application (if you haven’t already) at <https://apps.twitter.com/>
              - Fill in the mandatory fields as well as the callback URL, set it to a publicly available URL (not localhost), it doesn’t need to exist, but it does need to be set, using <https://radarr.video/twitter> is sufficient.

<!-- end list -->

  - Connection Triggers
      - On Grab - Be notified when movies are available for download and has been sent to a download client
      - On Import - Be notified when movies are successfully imported
      - On Upgrade - Be notified when movies are upgraded to a better quality
      - On Rename - Be notified when movies are renamed
      - On Movie Delete - Be notified when movies are deleted
      - On Movie File Delete - Be notified when movie files files are deleted
      - On Movie File Delete For Upgrade - Be notified when movie files are deleted for upgrades
      - On Health Issue - Be notified on health check failures
      - Include Health Warnings - Be notified on health warnings in addition to errors.

<section end=radarr_settings_connect_connections />

### Sonarr

<section begin=sonarr_settings_connect_connections />

Connections are how you want Sonarr to communicate with the outside world.

  - By pressing the `+` button you'll be presented with a new window which will allow you to configure many different endpoints
      - There are many different endpoints
          - [Boxcar](https://boxcar.io)
          - [Custom Scripts](Sonarr_Tips_and_Tricks#Custom_Post_Processing_Scripts "wikilink") - This allows you to make a custom script for when a particular action happens this script will run
          - [Discord](https://discord.com) - By far one of the most common ways to push notifications of actions happening on your Sonarr
          - Email - Simply send yourself or somebody you want to annoy with email. [If you're using Gmail, you need to enable less secure apps.](https://support.google.com/accounts/answer/6010255?hl=en) If you're using Gmail and have 2-factor authentication enabled you need to [use an App Specific password.](https://support.google.com/accounts/answer/185833)
              - You can use a "pretty address" like `SomePrettyName <email@example.org`
          - [Emby](https://emby.media)
          - [Gotify](https://gotify.net)
          - [Join](https://joaoapps.com/join/)
          - [Kodi](https://kodi.tv) - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.
              - By adding Kodi as a connection you can update Kodi's library when a new episode has been added to Sonarr
          - [Plex Home Theater](https://plex.tv)
          - [Plex Media Center](https://plex.tv)
          - [Plex Media Server](https://plex.tv) - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded episode is available
          - [Prowl](https://www.prowlapp.com)
          - [Pushbullet](https://www.pushbullet.com)
          - [Pushover](https://pushover.net)
          - [Sendgrid](https://sendgrid.com)
          - [Slack](https://slack.com)
          - [Synology Indexer](https://www.synology.com/en-global/knowledgebase/DSM/help/DSM/AdminCenter/application_indexservice_desc)
          - [Telegram](https://telegram.org)
          - [Trakt](https://trakt.tv/dashboard)
          - [Twitter](https://twitter.com)

<!-- end list -->

  - Connection Triggers
      - On Grab - Be notified when episodes are available for download and has been sent to a download client
      - On Import - Be notified when episodes are successfully imported
      - On Upgrade - Be notified when episodes are upgraded to a better quality
      - On Rename - Be notified when episodes are renamed
      - On Series Delete - Be notified when series are deleted
      - On Episode File Delete - Be notified when episodes files are deleted
      - On Episode File Delete For Upgrade - Be notified when episode files are deleted for upgrades
      - On Health Issue - Be notified on health check failures
      - Include Health Warnings - Be notified on health warnings in addition to errors.

<section end=sonarr_settings_connect_connections />

### Lidarr

<section begin=lidarr_settings_connect_connections />

Connections are how you want Lidarr to communicate with the outside world.

  - By pressing the `+` button you'll be presented with a new window which will allow you to configure many different endpoints
      - There are many different endpoints
          - [Boxcar](https://boxcar.io)
          - Custom scripts - This allows you to make a custom script for when a particular action happens this script will run
          - [Discord](https://discord.com) - By far one of the most common ways to push notifications of actions happening on your Lidarr
          - [Notifiarr](https://notifiarr.com) - The brainchild of one of the Lidarr developers allowing you to have beautiful discord notifications with very fine tuned control. Constantly being updated and a favorite amongst many of the Lidarr team.
          - Email - Simply send yourself or somebody you want to annoy with email. [If you're using Gmail, you need to enable less secure apps.](https://support.google.com/accounts/answer/6010255?hl=en) If you're using Gmail and have 2-factor authentication enabled you need to [use an App Specific password.](https://support.google.com/accounts/answer/185833)
              - You can use a "pretty address" like `SomePrettyName <email@example.org`
          - [Emby](https://emby.media)
          - [Gotify](https://gotify.net)
          - [Join](https://joaoapps.com/join/)
          - [Kodi](https://kodi.tv) - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.
              - By adding Kodi as a connection you can update Kodi's library when a new movie has been added to Lidarr
          - [Plex Media Server](https://plex.tv) - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded movie is available
          - [Prowl](https://www.prowlapp.com)
          - [Pushbullet](https://www.pushbullet.com)
          - [Pushover](https://pushover.net)
          - [Sendgrid](https://sendgrid.com)
          - [Slack](https://slack.com)
          - [Subsonic](http://www.subsonic.org)
          - [Synology Indexer](https://www.synology.com/en-global/knowledgebase/DSM/help/DSM/AdminCenter/application_indexservice_desc)
          - [Telegram](https://telegram.org)
          - [Twitter](https://twitter.com)

<!-- end list -->

  - Connection Triggers
      - On Grab - Be notified when episodes are available for download and has been sent to a download client
      - On Import - Be notified when episodes are successfully imported
      - On Upgrade - Be notified when episodes are upgraded to a better quality
      - On Rename - Be notified when episodes are renamed
      - On Health Issue - Be notified on health check failures
      - Include Health Warnings - Be notified on health warnings in addition to errors.

<section end=lidarr_settings_connect_connections />

#### Readarr

<section begin=readarr_settings_connect_connections />

Connections are how you want Readarr to communicate with the outside world.

  - By pressing the `+` button you'll be presented with a new window which will allow you to configure many different endpoints
      - There are many different endpoints
          - [Boxcar](https://boxcar.io)
          - Custom scripts - This allows you to make a custom script for when a particular action happens this script will run
          - [Discord](https://discord.com) - By far one of the most common ways to push notifications of actions happening on your Lidarr
          - [Notifiarr](https://notifiarr.com) - The brainchild of one of the Lidarr developers allowing you to have beautiful discord notifications with very fine tuned control. Constantly being updated and a favorite amongst many of the Lidarr team.
          - Email - Simply send yourself or somebody you want to annoy with email. [If you're using Gmail, you need to enable less secure apps.](https://support.google.com/accounts/answer/6010255?hl=en) If you're using Gmail and have 2-factor authentication enabled you need to [use an App Specific password.](https://support.google.com/accounts/answer/185833)
              - You can use a "pretty address" like `SomePrettyName <email@example.org`
          - [Emby](https://emby.media)
          - [Gotify](https://gotify.net)
          - [Join](https://joaoapps.com/join/)
          - [Kodi](https://kodi.tv) - Kodi spawned from the love of media. It is an entertainment hub that brings all your digital media together into a beautiful and user friendly package. It is 100% free and open source, very customisable and runs on a wide variety of devices. It is supported by a dedicated team of volunteers and a huge community.
              - By adding Kodi as a connection you can update Kodi's library when a new movie has been added to Lidarr
          - [Plex Media Server](https://plex.tv) - The server for your self hosted Plex system, Enabling this is much like Kodi will allow you to push an update to your plex server notifying it that a new/upgraded movie is available
          - [Prowl](https://www.prowlapp.com)
          - [Pushbullet](https://www.pushbullet.com)
          - [Pushover](https://pushover.net)
          - [Sendgrid](https://sendgrid.com)
          - [Slack](https://slack.com)
          - [Subsonic](http://www.subsonic.org)
          - [Synology Indexer](https://www.synology.com/en-global/knowledgebase/DSM/help/DSM/AdminCenter/application_indexservice_desc)
          - [Telegram](https://telegram.org)
          - [Twitter](https://twitter.com)

<section end=readarr_settings_connect_connections />
