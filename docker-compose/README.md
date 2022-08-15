# Docker Compose


[Docker Hub](https://hub.docker.com/)

[Getting Started with Docker Compose](https://docs.docker.com/get-started/08_using_compose/)

Docker Compose is a tool developed to help you define and share multi-container applications.
It gives you the ability to spin up your containers, using a single command, defined in your YAML configuration file.


# Install Docker Compose
[Install Docker Compose](https://docs.docker.com/compose/install/)

````
sudo apt-get install docker-compose -y
docker-compose
docker-compose version
````

# Getting started with Docker Compose

1. Create a compose file

    > When running ``docker-compose up``, by default docker-compose will use the compose (YAML) file named ``docker-compose.yaml``.
    > Use the `-f` flag to specify a YAML configuration file. ``docker-compose -f <file-name> up``


    > Create a new file called ``docker-compose.yaml``
    ````
    vim docker-compose.yaml
    ````
1. Define the service entry and the image for the container
    > You can chose the name for the service, in this example the name for the service is `app`.
    Notice: the name will automatically become a network alias.

    ````YAML
    version: "3.7"
    services:
        app:
        image: <image-name>
    ````    

2. You could specify some commands that need to be executed, for example command: sh -c "apt-get update"

3. Define the ports for the service
    `<external-port>:<internal-port>`


    ````YAML
    version: "3.7"
    services:
        app:
        image: <image-name>
        command: <some command>
        ports:
            - 8080:8080
    ````  

4. Specify the wokring directory and the volume mapping.


    ````YAML
    version: "3.7"
    services:
        app:
        image: <image-name>
        command: <some command>
        ports:
            - 8080:8080
        working_dir: /app
        volumes:
            - ./:/app
            # Mount the current work directory into the app directory in the container
    ````  

5. (optional) Define environment variable

    ````YAML
    version: "3.7"
    services:
        app:
        image: <image-name>
        command: <some command>
        ports:
            - 8080:8080
        working_dir: /app
        volumes:
            - ./:/app
            # Mount the current work directory into the app directory in the container
        environment:
            <NAME_ENV_VAR_1>: <value>
            <NAME_ENV_VAR_2>: <value>
    ````  


6. Run the application
    ````
    docker-compose up -d
    ````



---

Example MySQL and PMA


`````YAML
version: "3.7"

services:

  mysql:
    container_name: mysql
    image: mysql # for a specific version use `mysql:<version-number>`
    volumes:
      - mysql-volume:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw

  phpmyadmin:
    image: phpmyadmin
    container_name: pma
    ports:
      - 8080:8080
    links:
      - mysql
    environment:
      PMA_HOST: mysql

    restart: always

volumes:
  mysql-volume:
`````


