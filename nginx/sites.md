# NGINX Exercises

> Add some websites and host them using NGINX.

> Use the following folderstructure
> * /sites/ 
>   * /sites/site1 
>       * /sites/site1/index.html 
>       * /sites/site1/home.html 
>   * /sites/site2 
>       * /sites/site2/index.html 
>       * /sites/site2/home.html 

# Exercise 1
> Remove the default file in ``site-enabled``, but do not delete the default file in `site-available`!

> Create a new configuration file in `sites-available`

**config**
````
server { 
  listen 80; 
  server_name site1.com www.site1.com; 
  location / { 
    root /sites/site1; 
  } 
} 
server { 
  listen 80; 
  server_name site2.com www.site2.com; 
  location / { 
    root /sites/site2; 
  } 
} 

````
> Two server blocks listening on port 80.
> One for site1, and one for site2.

> Create a symlink to the sites-enabled folder
````
sudo ln -s /etc/nginx/sites-available/config  /etc/nginx/sites-enabled/config 
````

> **Reflection**
> What is the result when surfing to 'localhost'
> * You should see the index page of site1

> Change the default port in the first server block to 81
````
server { 
  listen 80; 
  server_name site1.com www.site1.com; 
  location / { 
    root /sites/site1; 
  } 
}
````

> **Reflection**
> What is the result when surfing to 'localhost'
> * You should see the index page of site2


> **Reflection**
> Could you see the content of page 1?
> * Yes, if you surf to localhost on port 81 'curl localhost:81' you should see the index page of site1

> Change the default port in the first server block again to 80
````
server { 
  listen 80; 
  server_name site1.com www.site1.com; 
  location / { 
    root /sites/site1; 
  } 
}
````

> Notice NGINX will try to first match the listen directive, next the server_name directive. In our case none of the server block matches the server_name directive for 'localhost'.
So, NGINX will take the first server block listening on port 80. (in this example it will be site1)

> If we would like to see the index page of site2 by default we could specify the second server block as default_server.

> You can have only one default server per port.

````
server { 
  listen 80; 
  server_name site1.com www.site1.com; 
  location / { 
    root /sites/site1; 
  } 
} 
server { 
  listen 80 default_server; 
  server_name site2.com www.site2.com; 
  location / { 
    root /sites/site2; 
  } 
} 

````
> **Reflection**
> What is the result when surfing to 'localhost'
> * You should see the index page of site2


> **Reflection**
> What if we want no default page, but a 404 status instead for site2
> Change the server block for site2, modify the listen port and return a 404 status.

````
server {
  listen 80;
  server_name site1.com www.site1.com;
  location / {
    root /sites/site1;
  }
}
server {
  listen 81;
  server_name site2.com www.site2.com;
  return 404;
}
````

> * ``curl localhost:81``
> *  You should see '404 Not Found'


---

# Exercise 2

**Goal**
- When surfing to the root URL, you should see the home.html page of site1.

````
server { 
  listen 80; 
  server_name site1.com www.site1.com; 
  location / { 
    root /sites/site1;
    index home.html;
  } 
} 
server { 
  listen 80; 
  server_name site2.com www.site2.com; 
  location / { 
    root /sites/site2; 
  } 
} 
````

# Exercise 3
> Create a new folder 'shared' in 'sites'
> Download the nginx.png file, and copy and rename the file as nginx.PNG
````
cd /sites/
sudo mkdir shared
cd shared
sudo curl -LO http://nginx.org/nginx.png
sudo cp nginx.png nginx.PNG
````

- Site1 should show the index.html page by default
- Use 'locations' to specify where nginx should search for files based on the URI.

- Site 2 will listen on port 81
- Site 2 should be able to show PHP file 

> Create a php file that will display the php information (using ``phpinfo();``)
````
cd /sites/shared/
sudo echo '<?php phpinfo(); ?>' > info.php
````

- Show the content of info.php when surfing to ``localhost:81/informatie``

````
server {
  listen 80;
  server_name site1.com www.site1.com;
  location / {
    root /sites/site1;
    index index.html;
  }
}
server {
  listen 81 default_server;
  server_name site2.com www.site2.com;
  location / {
    root /sites/site2;
  }
  location = /informatie {
    alias /sites/shared/info.php;
  }
  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
  }
}
````

---

# Exercise 4

**config-2**
````
server {
  listen 80;

  root /sites/shared;
  index info.php;

  server_name localhost;

  location /site1 {
    root /sites;
    index home.html;
  }

  location = /informatie {
    alias /sites/shared/info.php;
  }

  location /site2 {
    root /sites;
    index index.html;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
  }

  location ~* \.(png)$ {
    root /sites/shared;
    expires 2d;
  }
}
````

```
sudo ln -s /etc/nginx/sites-available/config-2  /etc/nginx/sites-enabled/config-2 
```



---

1. Rewrite static page
Consider a scenario where you want to rewrite an URL for a page say https://example.com/nginx-tutorial to https://example.com/somePage.html. The rewrite directive to do the same is given in the following location block.

````
server {
          ...
          ...
          location = /nginx-tutorial 
          { 
            rewrite ^/nginx-tutorial?$ /somePage.html break; 
          }
          ...
          ...
}

````

Explanation:

The location directive location = /nginx-tutorial tells us that the location block will only match with an URL containing the exact prefix which is /nginx-tutorial.

The NGINX will look for the pattern ^/nginx-tutorial?$ in the requested URL.

To define the pattern, the characters ^,? and $ are used and have special meaning.

^ represents the beginning of the string to be matched.

$ represents the end of the string to be matched.

? represents non greedy modifier. Non greedy modifier will stop searching for pattern once a match have been found.

If the requested URI contains the above pattern then somePage.html will be used as a replacement.

Since the rewrite rule ends with a break, the rewriting also stops, but the rewritten request is not passed to another location.