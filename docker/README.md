
# Docker

[Get Docker](https://docs.docker.com/get-docker/)

[Docker Getting Started](https://docs.docker.com/get-started/)

[Docker Hub](https://hub.docker.com/)

---

# Docker commands


````
docker run <name-image>
````

````
docker stop <container-name-OR-container-id>
````
````
docker rm <container-name-OR-container-id>
````
---

````
docker run -d <name-image>
````
````
docker attach <container-name-OR-container-id>
````
---
````
docker ps
````

````
docker ps -a
````

````
docker inspect <container-name-OR-container-id>
````
---

````
docker exec <container-name-OR-container-id> <command>
````

````
docker exec <container-name-OR-container-id> cat /etc/hosts
````

````
docker exec -it <container-name-OR-container-id> /bin/bash
````

---

````
docker pull <name-image>
````

````
docker images
````
````
docker rmi <name-image>
````

# Docker Mapping

When running a Docker container, the container will have an internal IP address and port assigned.
Meaning the container will be accessible only from the Docker Host (the Host where the Docker containers are running).

To make the container (application) accessible you can configure port mapping.
> `-p <external-port>:<internal-port>`

## Example to demonstrate to working of Docker port mapping

> Create a Docker container for NGINX available at port 8080 and a Docker container for Apache (ubuntu/apache2) available at port 8888.

> You should be able to browse to localhost:8080 and localhost:8888 to interact with both web applications (nginx and apache2).


> NGINX
````
docker run -d --name nginx -p 8080:80 nginx
docker ps
docker logs nginx
````
> Verify you can access NGINX
````
curl localhost:8080
````
> Output
````
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
````



> Apache2
````
docker run -d --name apache -p 8888:80 ubuntu/apache2
docker ps
docker logs apache
````
> Verify you can access apache
````
curl localhost:8888
````


Without volumes, your container have no data persistence. Meaning that when a container is deleted, all the data will be deleted as well. 

To have data persistence you can use what is called ``volumes``.

> Mapping files (volumes)

> `-v <local-dir>:<remote-dir>`


## Example to demonstrate to working of Docker volumes

Let's create an HTML file on our local VM and map that file into the Docker containers we created before (nginx and apache).

Therefore, stop and remove both containers.
````
docker stop nginx && docker stop apache
docker rm nginx && docker rm apache
````

1. Create a test html file 'index.html'

    ````
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TEST</title>
    </head>
    <body>
        <h1> WELCOME </h1>
        
    </body>
    </html>
    ````

2. Create the Docker containers again and map the file to the directory used by nginx and apache to host files.

    ````
    docker run -d --name nginx -v /home/k8s/index.html:/usr/share/nginx/html/index.html -p 8080:80 nginx
    ````
    ````
    docker run -d --name apache -v /home/k8s/index.html:/var/www/html/index.html -p 8888:80 ubuntu/apache2
    ````

3. Verify you can access apache

    ````
    curl localhost:8080
    curl localhost:8888
    ````


# Network Options
By default when you create a Docker container, the container will be set in bridged mode. Meaning the Docker container will have an IP address assigned in the `172.x.x.x` network. This IP address is internally used for communication between Docker containers on your Docker Host.

> Use ``docker inspect`` to get the IP address used by a Docker container.



> MySQL

````
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw mysql
````

````
docker inspect mysql 
"IPAddress": "172.17.0.2"
````

````
docker run --name phpmyadmin -d --link mysql:db -p 8080:80 phpmyadmin
````

````
docker inspect phpmyadmin 
"IPAddress": "172.17.0.3"
````


> Verify, try to log in to phpmyadmin 
``http://<ip-vm>:8080/`` 