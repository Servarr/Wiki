# MacOS (OSX)

{#OSX}

> Radarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://radarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://radarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system
1. Open the archive and drag the Radarr icon to your Application folder.
1. Self-sign Radarr `codesign --force --deep -s - /Applications/Radarr.app && xattr -rd com.apple.quarantine`
1. Browse to <http://localhost:7878> to start using Radarr

> Radarr uses a bundled version of ffprobe for media file analysis and does not require ffprobe or ffmpeg to be installed on the system.  If Radarr says Ffprobe is not found this can typically be fixed with a reinstall.
{.is-info}