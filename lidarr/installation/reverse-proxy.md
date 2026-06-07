---
title: Lidarr Reverse Proxy
description: 
published: true
date: 2026-06-07T00:00:00.000Z
tags: 
editor: markdown
dateCreated: 2023-07-03T20:10:58.279Z
---

## Reverse Proxy Configuration

Sample config examples for configuring Lidarr to be accessible through a reverse proxy.

> These examples assume the default port of `8686` and a baseurl of `lidarr`. They also assume your web server (nginx) and Lidarr run on the same server, accessible at `localhost`. If not, use the host IP address or a FQDN for the proxy pass.
{.is-info}

## NGINX

Add the following configuration to `nginx.conf` in the root of your Nginx configuration. Place the code block inside the `server` context. [Full example of a typical Nginx configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

> If you're using a non-standard http/https server port, make sure your Host header also includes it, for example: `proxy_set_header Host $host:$server_port` or `proxy_set_header Host $http_host`
{.is-warning}

```nginx
location ^~ /lidarr {
    proxy_pass http://127.0.0.1:8686;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_redirect off;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;
}
# Allow the API External Access via NGINX
location ^~ /lidarr/api {
    auth_basic off;
    proxy_pass http://127.0.0.1:8686;
}
```

To organize your Nginx configuration, store each site's config in a separate file. Add `include subfolders-enabled/*.conf` in the `server` context of `nginx.conf`:

```nginx
server {
  listen 80;
  server_name _;

  # more configuration

  include subfolders-enabled/*.conf
}
```

Create a `subfolders-enabled` directory next to your `nginx.conf`, add a `.conf` file with the configuration above, then restart or reload Nginx. Lidarr should be available at `yourdomain.tld/lidarr`.

### Subdomain

To use a subdomain instead, visit `lidarr.yourdomain.tld`. Configure an `A record` or `CNAME record` in your DNS.

> Many free DNS providers don't support this.
{.is-warning}

Nginx includes the `sites-enabled` folder by default. Check `nginx.conf` and add it via the [include directive](http://nginx.org/en/docs/ngx_core_module.html#include) if it's missing — it must be inside the `http` context. Create a config file in `sites-enabled` with the following:

> For subdomain configuration, set baseurl to `''` (empty). This assumes the default port `8686` and Lidarr on localhost (127.0.0.1). Line 5 sets the subdomain to `lidarr`.
{.is-info}

> If you're using a non-standard http/https server port, make sure your Host header also includes it, for example: `proxy_set_header Host $host:$server_port` or `proxy_set_header Host $http_host`
{.is-warning}

```nginx
server {
  listen      80;
  listen [::]:80;
  server_name lidarr.*;
  location / {
    proxy_set_header   Host $host;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host $host;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;
    proxy_redirect     off;
    proxy_http_version 1.1;

    proxy_pass http://127.0.0.1:8686;
  }
}
```

Restart Nginx and Lidarr should be available at your selected subdomain.

## Apache

Add this within an existing VirtualHost site. To use the root of a domain or subdomain, remove `lidarr` from the `Location` block and use `/` as the location.

> Don't remove the baseurl from ProxyPass and ProxyPassReverse if you use `/` as the location.
{.is-warning}

```none
<Location /lidarr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:8686/lidarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:8686/lidarr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

For a full VirtualHost for Lidarr:

```none
ProxyPass / http://127.0.0.1:8686/lidarr/
ProxyPassReverse / http://127.0.0.1:8686/lidarr/
```

If you add authentication through Apache, exclude the following paths:

- `/lidarr/api/`
