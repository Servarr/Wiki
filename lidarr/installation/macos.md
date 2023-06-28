# MacOS (OSX)

{#OSX}

> Lidarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://lidarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://lidarr.servarr.com/v1/update/master/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system
1. Open the archive and drag the Lidarr icon to your Application folder.
1. Self-sign Lidarr `codesign --force --deep -s - /Applications/Lidarr.app && xattr -rd com.apple.quarantine`
1. Browse to <http://localhost:8686> to start using Lidarr