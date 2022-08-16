> Goal: Deploy a MySQL and phpMyAdmin application in Kubernetes

[MySQL - Docker Hub ](https://hub.docker.com/_/mysql)
> MYSQL_ROOT_PASSWORD


[phpMyadmin - Docker Hub ](https://hub.docker.com/_/phpmyadmin)


Create two deployments, one configMap and a secret.

1. ``secret.yaml`` - Secret: Mysql Password for root user
1. ``mysql.yaml`` - MySQL Deployment and Internal Service
1. ``cm.yaml`` - ConfigMap: Mysql database_url used by PMA
1. ``pma.yaml`` - phpMyAdmin Deployment and External Service

---

````
kubectl apply -f secret.yaml

kubectl get secret

kubectl apply -f mysql.yaml 

kubectl get svc
kubectl get pods

kubectl apply -f cm.yaml 
kubectl get cm

kubectl -f pma.yaml apply

kubectl get svc
kubectl get pods

minikube service external-svc-phpmyadmin

kubectl port-forward phpmyadmin-5cc55f98d7-j6jqz 8080:80

curl localhost:8080
````

# Ingress
