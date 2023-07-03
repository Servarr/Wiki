# MacOS (OSX)

{#OSX}

> Readarr is not compatible with OSX versions < 10.15 (Catalina) due to .NET incompatibilities.
{.is-warning}

1. Download the [MacOS App](https://readarr.servarr.com/v1/update/develop/updatefile?os=osx&runtime=netcore&arch=x64&installer=true) or  the [MacOS M1 App](https://readarr.servarr.com/v1/update/develop/updatefile?os=osx&runtime=netcore&arch=arm64&installer=true) depending on your system
1. Open the archive and drag the Readarr icon to your Application folder.
1. Self-sign Readarr `codesign --force --deep -s - /Applications/Readarr.app && xattr -rd com.apple.quarantine`
1. Browse to <http://localhost:8787> to start using Readarr
