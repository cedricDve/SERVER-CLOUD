> Install MySQL

    
    apt-get install mysql-server    
    sudo mysql_secure_installation 

    - VALIDATE PASSWORD installation? N
    - Remove anonymous users? Y
    - Disallow root login remotely? N
    - Remove test database and access to it? N
    - Reload privilege tables now? Y

> Connect to MySQL server

    sudo mysql


> Change root password

    ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY
'Student1'

> Apply changes using FLUSH PRIVILEGES. When we grant some privileges for a user, running the command flush privileges 
will reloads the grant tables in the mysql database enabling the changes to take effect without reloading or restarting mysql service.

    FLUSH PRIVILEGES

> Log in to MySQL server using root user.

    sudo mysql -u root -p

    (password = Student1)