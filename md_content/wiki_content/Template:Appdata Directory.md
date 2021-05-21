<noinclude> <templatedata> {

`   "params": {`  
`       "ARRNAME": {`  
`           "description": "ARR Name",`  
`           "example": "Sonarr, Radarr, Lidarr, Readarr",`  
`           "type": "string",`  
`           "default": "Radarr"`  
`       },`  
`       "ARRNAME2": {`  
`           "description": "This variable is used to insert lowercase ARR names ",`  
`           "example": "radarr, sonarr, lidarr, or readarr",`  
`           "required": true`  
`       }`  
`   },`  
`   "description": "This template is designed to house all the locations for the ARR's application data directory"`

} </templatedata> </noinclude>

’s AppData folder contains the databases for logs and general app
information, log files and the config file that contains settings
required to start the web server. This path is listed on the System
Status page in , but if you are unable to access it, here are some
common locations for it:

### Windows

`C:\ProgramData\`

### Linux

Unless otherwise specified  will store it's application data in the home
folder of the user  is running under `/home/$USER/.config/`
(`~/.config/`)

`/var/lib/`

### OS X

`/Users/$USER/.config/` (`~/.config/`)

### Synology

`/usr/local/``/var/.config/`

`/volume1/@appstore/``/var/.config/`

### QNAP

`/share/MD0_DATA/homes/admin/.config/`

`/share/CACHEDEV1_DATA/``_CONFIG`

### Argument

{{\#lst::Appdata Directory Misc|\_appdata\_directory\_arguments}}
