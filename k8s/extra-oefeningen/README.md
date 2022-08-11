
# Kubernetes
> create new folder, and store the config files (YAML) inside

* MariaDB  > https://hub.docker.com/_/mariadb (Links to an external site
* phpMyAdmin

---

* 2 deployments/pods
* 1 ConfigMap
* 1 Secret

> Internal Service for MariaDB (ClusterIP)

> External Service for phpMyAdmin (LoadBalancer)

* 2 Replicas for phpMyAdmin -  Available port 8080

* Use lynx to verify you can access phpMyAdmin

---

## MariaDB

>https://hub.docker.com/_/mariadb

> Docker image: mariadb

> Default port: 3606

> Environment variable: 
> * MARIADB_ROOT_PASSWORD

## phpMyAdmin

>https://hub.docker.com/_/phpmyadmin

> Docker image: phpmyadmin

> Default port: 8080

> Environment variable: 
>* MYSQL_ROOT_PASSWORD
>* PMA_HOST 
>* PMA_PORT


---

````
kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml
kubectl apply -f mariadb.yaml 
kubectl apply -f pma.yaml 
````

````
NAME                             READY   STATUS    RESTARTS   AGE
pod/mariadb-65cf9bfcd8-6l7s9     1/1     Running   0          49m
pod/phpmyadmin-cbfcbc9cf-49nvr   1/1     Running   0          25m

NAME                              TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/external-svc-phpmyadmin   LoadBalancer   10.108.173.46    <pending>     8080:31426/TCP   40m
service/kubernetes                ClusterIP      10.96.0.1        <none>        443/TCP          160d
service/svc-mariadb               ClusterIP      10.104.186.253   <none>        3306/TCP         49m

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mariadb      1/1     1            1           49m
deployment.apps/phpmyadmin   1/1     1            1           25m

NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/mariadb-65cf9bfcd8     1         1         1       49m
replicaset.apps/phpmyadmin-cbfcbc9cf   1         1         1       25m
````


> Verify
```
kubectl port-forward phpmyadmin-xxx 8080:80
curl localhost:8080
```