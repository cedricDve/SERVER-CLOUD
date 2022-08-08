````
ufw app list
````

````
sudo ufw status
````

````
sudo ufw enable
````

> Examples
    ````
    sudo ufw allow ssh
    sudo ufw allow 22/tcp
    ````


> Verify: Exampl: check that port 22 is open
    ```
    sudo ss -tulpn | grep :22
    ```