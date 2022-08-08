# Install Linux Software

> Ubuntu VM Provisioning

*Create a Virtual Machine using Vagrant and VirtualBox*

Install
1. Nginx
1. MySQL Server
1. PHP
1. phpMyAdmin
1. Docker and minikube


---

1. NGINX
   > Verify nginx is installed and running
   ```
   sudo systemctl status nginx
   ```
   > Verify you can access NGINX
   ```
   curl <ip-vm>
   ```
   > If you got permissions denied, verify the firewall 

   ```
   sudo ufw app list
   ```
   > Allow port 80 on the Firewall
   ```
   sudo ufw allow 80
   ```

   > Verify the /etc/nginx and /var/www/html folders.

   ```
   ls /etc/nginx
   ```
   
   ```
   ls /var/www/html
   ```

1. MySQL Server

    > Connect to MySQL Server
    ```
    sudo mysql
    ```
    > Edit password of root user
    ```SQL
    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY
    'Student1';
    ```
    
    > Apply the changes using `flush privileges`
    ```SQL
    FLUSH PRIVILEGES;
    ```

    > Connect to MySQL Server with root user
    ```bash
    sudo mysql -u root -p
    
    >> Password is Student1
    ```

1. PHP

    > Verify PHP information
    ```
    php -v
    php -i
    ```

    > !! Edit the NGINX sites-enabled file to specify the location of phpmyadmin.
    > Add to /etc/nginx/sites-enabled/default
    ````
    cd /etc/nginx/sites-enabled
    ````
    ````
    sudo vim default
    ````
    ```
    location ~ \.php$ { 
		include snippets/fastcgi-php.conf; 
		fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
    }
    ```
    > Test NGINX config
    ```
    sudo nginx -t
    ```



1. phpMyAdmin

    > Install phpMyAdmin
    ```
    sudo apt install phpmyadmin -y
    ```

    > Symbolic link from /usr/share/phpmyadmin to /var/www/html 
    ```
      sudo ln -s /usr/share/phpmyadmin /var/www/html
    ```

    > !! Edit the Nginx sites-enabled file to specify the location of phpmyadmin.
    > Add to /etc/nginx/sites-enabled/default
    ```
    location /phpmyadmin {
                index index.php index.html;
                root /usr/share;
        }
    ```

    > Restart NGINX    
    ```bash
    sudo systemctl restart nginx
    ```

    > Verify you can access phpmyadmin through the browser

    ```bash
    curl localhost/phpmyadmin
    ```
