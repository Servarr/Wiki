# Synology

- [The SynoCommunity creates, supports,and maintains a Synology NAS Package](https://synocommunity.com/package/nzbdrone)

> The NAS package is poorly maintained and frequently out of date. If your NAS supports docker it is strongly recommended [to run docker](https://trash-guides.info/Hardlinks/How-to-setup-for/Synology/) instead. You will not be able to reinstall Sonarr without wiping your database manually due to the NAS package being out of date and not configured to update itself on startup. {.is-info}

- [SynoCommunity also creates, supports, and maintains the required Mono Package](https://synocommunity.com/package/mono)

## Synology Mono SSL Errors

> Due to a bug introduced by SynoCommunity's poorly maintained Mono package. Sonarr will fail to connect after updating Mono or after a fresh installation. This can be resolved by following the instructions on [SynoCommunity Bug Report #5051](https://github.com/SynoCommunity/spksrc/issues/5051#issuecomment-1009758625). Note that based on [this comment](https://github.com/SynoCommunity/spksrc/issues/5051#issuecomment-1153245799) DSM7 users have an extra step.
{.is-danger}

1. Within DSM, enable SSH service in *Control Panel => Terminal & SNMP* and click apply
1. Using [Terminal](https://support.apple.com/en-gb/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac) (MacOS) connect to the NAS using `ssh -l [admin username] [NAS address]` or using [Putty](https://www.putty.org/) (Windows) connect to the network address of your NAS
1. Enter the required admin password and press enter
1. Enter the appropriate command(s) for your DSM version noted below and press enter
1. Enter the required admin password and press enter. When complete you should see the line *Import process completed*
1. Disconnect the SSH session by typing `exit` and press enter
1. Within DSM, disable the SSH service in *Control Panel => Terminal & SNMP* and click apply
1. Once complete the errors in Sonarr should disappear on their own in a few minutes.

### Synology DSM6 Mono Fix Command

```shell
sudo /var/packages/mono/target/bin/cert-sync /etc/ssl/certs/ca-certificates.crt
```

### Synology DSM7 Mono Fix Command

```shell
sudo /volume1/@appstore/mono/bin/cert-sync /etc/ssl/certs/ca-certificates.crt
sudo chmod -R a+rX /usr/share/.mono
```