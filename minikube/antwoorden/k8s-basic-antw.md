```
minikube start
```

```
kubectl
```

```
kubectl get nodes
```

```
kubectl get pod
```

```
kubectl get svc
```    
   
```
kubectl create -h
```

---

> ``kubectl create deployment <naam> --image=<imagenaam van bvb dockerhub> [opties]``

```
kubectl create deployment nginx --image=nginx
```

```
kubectl get pod
```

```
kubectl get svc
```    

```
kubectl get replicaset
```

---


> ``kubectl logs <naam van pod>``

> ``kubectl exec -it <naam van de pod> -- bin/bash``

> ``kubectl delete deployment <naam>``


```
kubectl delete deployment nginx
```

```
kubectl create deployment mongo --image=mongo
```

```
kubectl logs mongo
```

> https://hub.docker.com/_/mongo/


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
> edit replicas -> change to 3

```
vim nginx-test.yaml
```
> ``replicas: 3``

```
kubectl edit deployment nginx-test
```