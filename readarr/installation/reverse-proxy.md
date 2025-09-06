# Reverse Proxy Configuration (Retired)

# Announcement: Retirement of Readarr

We would like to announce that the [Readarr project](https://github.com/Readarr/Readarr) has been retired. This difficult decision was made due to a combination of factors: the project's metadata has become unusable, we no longer have the time to remake or repair it, and the community effort to transition to using Open Library as the source has stalled without much progress.

Third-party metadata mirrors exist, but as we're not involved with them at all, we cannot provide support for them. Use of them is entirely at your own risk. The most popular mirror appears to be [rreading-glasses](https://github.com/blampe/rreading-glasses).

Without anyone to take over Readarr development, we expect it to wither away, so we still encourage you to seek alternatives to Readarr.

## Key Points

- Effective Immediately: The retirement takes effect immediately. Please stay tuned for any possible further communications.
- Support Window: We will provide support during a brief transition period to help with troubleshooting non metadata related issues.
- Alternative Solutions: Users are encouraged to explore and adopt any other possible solutions as alternatives to Readarr.
- Opportunities for Revival: We are open to someone taking over and revitalizing the project. If you are interested, please get in touch.
- Gratitude: We extend our deepest gratitude to all the contributors and community members who supported Readarr over the years.

Thank you for being part of the Readarr journey. For any inquiries or assistance during this transition, please contact our team.

Sincerely,
The Servarr Team

Sample config examples for configuring Readarr to be accessible from the outside world through a reverse proxy.

> These examples assumes the default port of `8787` and that you set a baseurl of `readarr`. It also assumes your web server i.e nginx and Readarr running on the same server accessible at `localhost` (127.0.0.1). If not, use the host IP address or hostname instead for the proxy pass directive.
{.is-info}

## NGINX

Add the following configuration to `nginx.conf` located in the root of your Nginx configuration. The code block should be added inside the `server context`. [Full example of a typical Nginx configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/)

> If you're using a non-standard http/https server port, make sure your Host header also includes it, i.e.: `proxy_set_header Host $host:$server_port` or `proxy_set_header Host $http_host` {.is-warning}

```nginx
location ^~ /readarr {
    proxy_pass http://127.0.0.1:8787;
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
location ^~ /readarr/api {
    auth_basic off;
    proxy_pass http://127.0.0.1:8787;
}
```

A better way to organize your configuration files for Nginx would be to store the configuration for each site in a separate file.
To achieve this it is required to modify `nginx.conf` and add `include subfolders-enabled/*.conf` in the `server` context. So it will look something like this.

```nginx
server {
  listen 80;
  server_name _;

  # more configuration

  include subfolders-enabled/*.conf
}
```

Adding this line will include all files that end with `.conf` to the Nginx configuration. Make a new directory called `subfolders-enabled` in the same folder as your `nginx.conf` file is located. In that folder create a file with a recognizable name that ends with .conf. Add the configuration from above from the file and restart or reload Nginx. You should be able to visit Readarr at `yourdomain.tld/readarr`. tld is short for [Top Level Domain](https://en.wikipedia.org/wiki/List_of_Internet_top-level_domains)

### Subdomain

Alternatively you can use a subdomain for readarr. In this case you would visit `readarr.yourdomain.tld`. For this you would need to configure a `A record` or `CNAME record` in your DNS.
> Many free DNS providers do not support this {.is-warning}

By default Nginx includes the `sites-enabled` folder. You can check this in `nginx.conf`, if not you can add it using the [include directive](http://nginx.org/en/docs/ngx_core_module.html#include). And really important, it has to be inside the `http context`. Now create a config file inside the sites-enabled folder and enter the following configuration.

> For this configuration it is recommended to set baseurl to '' (empty). This configuration assumes you are using the default `8787` and Readarr is accessible on the localhost (127.0.0.1). For this configuration the subdomain `readarr` is chosen (line 5). {.is-info}

> If you're using a non-standard http/https server port, make sure your Host header also includes it, i.e.: `proxy_set_header Host $host:$server_port` or `proxy_set_header Host $http_host` {.is-warning}

```nginx
server {
  listen      80;
  listen [::]:80;

  server_name readarr.*;

  location / {
    proxy_set_header   Host $host;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Host $host;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_set_header   Upgrade $http_upgrade;
    proxy_set_header   Connection $http_connection;

    proxy_redirect     off;
    proxy_http_version 1.1;

    proxy_pass http://127.0.0.1:8787;
  }
}
```

Now restart Nginx and Readarr should be available at your selected subdomain.

## Apache

This should be added within an existing VirtualHost site. If you wish to use the root of a domain or subdomain, remove `readarr` from the `Location` block and simply use `/` as the location.

Note: Do not remove the baseurl from ProxyPass and ProxyPassReverse if you want to use `/` as the location.

```none
<Location /readarr>
  ProxyPreserveHost on
    ProxyPass http://127.0.0.1:8787/readarr connectiontimeout=5 timeout=300
    ProxyPassReverse http://127.0.0.1:8787/readarr
</Location>
```

`ProxyPreserveHost on` prevents apache2 from redirecting to localhost when using a reverse proxy.

Or for making an entire VirtualHost for Readarr:

```none
ProxyPass / http://127.0.0.1:8787/readarr/
ProxyPassReverse / http://127.0.0.1:8787/readarr/
```

If you implement any additional authentication through Apache, you should exclude the following paths:

- `/readarr/api/`
