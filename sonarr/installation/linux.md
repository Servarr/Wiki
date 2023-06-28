# Linux

- [Please see the website for instructions](https://sonarr.tv/#downloads-v3-linux)
- Put together the instructions should be:
  - [Add the Mono Repository](https://www.mono-project.com/download/stable/#download-lin-ubuntu)
  - [Add the MediaInfo Repository](https://mediaarea.net/en/Repos)
  - [Install Sonarr](https://sonarr.tv/#downloads-v3-linux)
- For Ubuntu 20.04 this will *likely* look like

```bash
# Add Mono Repo (20.04)
sudo apt install gnupg ca-certificates
sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
# Get MediaInfo
wget https://mediaarea.net/repo/deb/repo-mediaarea_1.0-19_all.deb && sudo dpkg -i repo-mediaarea_1.0-19_all.deb
# Add the Sonarr Repo
sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/sonarr-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 2009837CBFFD68F45BC180471F4F90DE2A9B4BF8
echo "deb [signed-by=/usr/share/keyrings/sonarr-keyring.gpg] https://apt.sonarr.tv/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/sonarr.list

# Apt Update
sudo apt update
# Install Sonarr
sudo apt install sonarr
```

## Mono SSL Issues

- A common issue experienced by users after installing is related to SSL Certificate Validation issues. This can be resolved by syncing mono's certs

```bash
sudo cert-sync /etc/ssl/certs/ca-certificates.crt
```