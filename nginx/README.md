**NGINX FOLDER STRUCTURE**

> `/etc/nginx`

> Edit the ``sites-enabled`` file in ``/etc/nginx``

    !! ALLOW NGINX to USE PHP FILES !!


    location ~ \.php$ { 
		include snippets/fastcgi-php.conf; 
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
    }


> Test the NGINX configuration

    sudo nginx -t



> `/var/www/html`



**NGINX commands**

    ```bash
    sudo systemctl status nginx
    sudo systemctl reload nginx
    sudo nginx -s restart
    ```