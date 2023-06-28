# Windows

Readarr is supported natively on Windows. Readarr can be installed on Windows as Windows Service or system tray application.
> Windows versions are limited for support to those currently supported by Microsoft, others may work but this is an unsupported configuration
{.is-warning}

A Windows Service runs even when the user is not logged in, but special care must be taken since Windows Services [cannot access network drives](https://learn.microsoft.com/en-us/windows/win32/services/services-and-redirected-drives) (X:\ mapped drives or \\\server\share UNC paths) without special configuration steps.

Additionally the Windows Service runs under the 'Local Service' account, by default this account **does not have permissions to access your user's home directory unless permissions have been assigned manually**. This is particularly relevant when using download clients that are configured to download to your home directory.

It's therefore advisable to install Readarr as a system tray application if the user can remain logged in. The option to do so is provided during the installer.

> You may have to run once "As Administrator" after installing if you get an access error -- such as Access to the path `C:\ProgramData\Readarr\config.xml` is denied -- or you use mapped network drives. This gives Readarr the permissions it needs. You should not need to run As Administrator every time.
{.is-warning}

> Warning: If you run Plex as a service via [PmsService](https://github.com/cjmurph/PmsService) you will either need to change PMsService's port from `8787` or you will need to modify the port Readarr runs on in the `config.xml` file.
{.is-info}

1. Download the latest version of Readarr for your architecture linked below.
1. Run the installer
1. Browse to <http://localhost:8787> to start using Readarr

- [Windows x64 Installer](https://readarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x64&installer=true)
- [Windows x32 Installer](https://readarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x86&installer=true)
{.links-list}

> It is possible to install Readarr manually using the [x64 .zip download](https://readarr.servarr.com/v1/update/develop/updatefile?os=windows&runtime=netcore&arch=x64). However in that case you must manually deal with dependencies, installation and permissions.
{.is-info}