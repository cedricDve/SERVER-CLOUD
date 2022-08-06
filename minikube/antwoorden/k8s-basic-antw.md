```
vagrant up
```
```
vagrant ssh
```
---

```
ip a show eth1
```
> inet 192.168.0.48/24
---

```
minikube start
```

```
-- Output --
😄  minikube v1.26.1 on Ubuntu 20.04 (vbox/amd64)
✨  Using the docker driver based on existing profile

🧯  The requested memory allocation of 1983MiB does not leave room for system overhead (total system memory: 1983MiB). You may face stability issues.
💡  Suggestion: Start minikube with less memory allocated: 'minikube start --memory=1983mb'

👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔄  Restarting existing docker container for "minikube" ...
🐳  Preparing Kubernetes v1.24.3 on Docker 20.10.17 ...-
  ```

```
kubectl
```

```
kubectl get nodes
```

```
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   41h   v1.24.3
```

```
kubectl get pod
```

```
kubectl get svc
```    

```
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   41h
```
   
```
kubectl create -h
```

---

> ``kubectl create deployment <name> --image=<image-name> [options]``

> Create a deployment for NGINX
```
kubectl create deployment nginx --image=nginx
```

```
kubectl get pod
```
```
NAME                    READY   STATUS    RESTARTS      AGE
nginx-8f458dc5b-qg8c4   1/1     Running   1 (40h ago)   40h
```

```
kubectl get replicaset
```
```
NAME              DESIRED   CURRENT   READY   AGE
nginx-8f458dc5b   1         1         1       40h
```

---


> ``kubectl logs <pod-name>``

> ``kubectl exec -it <pod-name> -- bin/bash``

> ``kubectl delete deployment <deployment-name>``


> Delete deployment for NGINX
```
kubectl delete deployment nginx
```

> Create deployment for mongo
> https://hub.docker.com/_/mongo/

```
kubectl create deployment mongo --image=mongo
```

> This may take up to 30 sec

````
kubectl get pods --watch
````
* ``mongo-7fd695869b-kjwzn   0/1     ContainerCreating   0             3s``

* ``mongo-7fd695869b-kjwzn   1/1     Running             0             32s``

```
kubectl logs mongo-7fd695869b-kjwzn
```

---

> Create a deployment configuration file for NGINX

---

```
vim nginx-test.yaml
```

```YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-test # Hier kiezen we de naam van onze deployment
  labels:
    app: nginx
spec:
  replicas: 1      # We zeggen hoeveel keer deze zal moeten gerepliceerd worden
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.20 # We kiezen onze image
        ports:
        - containerPort: 8080 # We beslissen welke poorten onze containers nodig hebben
```        

```bash
kubectl apply -f nginx-test.yaml
```
> Edit the deployment: change the replicas to 3

```
kubectl edit deployment nginx-test
```
> ``replicas: 3``
> press ESC, and enter `:wq`

```
kubectl get deploy
```

---


> To Stop the VM
```
exit
```
```
vagrant halt
```