# NGINX commands

```bash
sudo systemctl status nginx

sudo systemctl reload nginx
sudo nginx -s reload
```

# NGINX FOLDER STRUCTURE

````
# Files in '/etc/nginx/'

conf.d          koi-utf     modules-available  proxy_params     sites-enabled  win-utf
fastcgi.conf    koi-win     modules-enabled    scgi_params      snippets
fastcgi_params  mime.types  nginx.conf         sites-available  uwsgi_params
````

> Nginx config file `/etc/nginx/nginx.conf`
> * Notice in the http block:

````
include /etc/nginx/conf.d/*.conf;
include /etc/nginx/sites-enabled/*;
````

> Additional config files `/etc/nginx/conf.d/*.conf`


> ``sites-enabled`` and ``sites-enabled`` in `/etc/nginx/`


### Sites-enabled 

````
lrwxrwxrwx 1 root root   34 Aug  8 14:57 default -> /etc/nginx/sites-available/default
````
The default file is a symbolic link to the default file stored in the sites-available folder.

### Sites-available 

````
-rw-r--r-- 1 root root 2527 Aug  8 15:13 default
````

### Nginx 'default' config file

````
## Nginx.
# https://www.nginx.com/resources/wiki/start/

# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.

# Default server configuration
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        # Add index.php to the list if you are using PHP
        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }

        # pass PHP scripts to FastCGI server
        #
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
        #
        #       # With php-fpm (or other unix sockets):
                fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
        #       # With php-cgi (or other tcp sockets):
        #       fastcgi_pass 127.0.0.1:9000;
        }
        location /phpmyadmin {
                index index.php index.html;
                root /usr/share;
        }
}
````

# Logs

Access logs and error logs are stored in ``/var/log/nginx/`

````
access_log /var/log/nginx/access.log;
error_log /var/log/nginx/error.log;
````

# Allow NGINX to use PHP

> Edit the ``default`` config file in ``/etc/nginx/sites-availble``

    !! ALLOW NGINX to USE PHP FILES !!


    location ~ \.php$ { 
		include snippets/fastcgi-php.conf; 
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
    }


> Test the NGINX configuration

    sudo nginx -t

````
curl localhost
````

> The default NGINX index.html file is stored in `/usr/share/nginx/html/`


# Virtual Host configuration 

> Move the file into sites-available and  symlink that to sites-enabled/ to enable it.
````
server {
       listen 80;
       listen [::]:80;

       server_name example.com;

       root /var/www/example.com;
       index index.html;

       location / {
               try_files $uri $uri/ =404;
       }
}
````

