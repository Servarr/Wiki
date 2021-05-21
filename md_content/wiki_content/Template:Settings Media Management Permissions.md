<noinclude> <templatedata> {

`   "params": {`  
`       "ARRNAME": {`  
`           "description": "ARR Name",`  
`           "type": "string",`  
`           "required": true,`  
`           "example": "Radarr, Sonarr, Lidarr, Readarr",`  
`           "default": "``"`  
`       }`  
`   }`

} </templatedata> </noinclude>

  - *Set Permissions* - This will allow  to set the given file
    permission when a given file is imported or renamed
  - *chmod folder* - This is the permission level that  will set for a
    given file on import or rename (more information
    [HERE](https://en.wikipedia.org/wiki/Chmod#Octal_modes))
      - The drop down box has a preset list of very commonly used
        permissions that can be used. However, you can manually enter a
        folder octal if you wish.
  - *chmod Group* - This only works if the user running  is the owner of
    the file. It's better to ensure the download client uses the same
    group as .
