 # Kube proxy
````
ssh -L 12345:localhost:8001 k8s@192.168.0.44
````

````
kubectl proxy
````

````
http://localhost:12345/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/workloads?namespace=k8s-demo
````


# Port Forwarding 
kubectl port-forward  <name-pod> 8080:80