!! Edit the Nginx sites-enabled file to specify the location of phpmyadmin

> Add to /etc/nginx/sites-enabled:

      location /phpmyadmin {
                index index.php index.html;
                root /usr/share;
        }
ca
> Restart NGINX    

    sudo systemctl restart nginx


> Verify you can access phpmyadmin through the browser

    localhost/phpmyadmin