# Kubernetes Config Files

> Maak een folder aan waar alle YAML-bestanden (configuratie files) worden opgeslagen.

Maak een mongoDB database aan, die je zal hosten en beheren met behulp van mongoExpres.

* De mongoDB mag niet bereikbaar zijn van buitenaf (enkel binnenin de cluster). Maak een internal service aan die je koppelt aan de deployment voor mongoDB.

* mongoExpress moet wel bereikbaar zijn via poort 30000, dus we gebruiken daar een external service. 

* 2 deployments/pods
* 2 services
* 1 ConfigMap
* 1 Secret


---

Kijk na dat enkel de k8s service aan het draaien is:

````
kubectl get all
````


---

1. Create Deployment for mongo
    > Check DockerHub https://hub.docker.com/_/mongo/
    
    > Default port used by mongo is **27017**

    > Add the following config for the image to create environment variables:

    ````YAML
    env:
    - name: MONGO_INITDB_ROOT_USERNAME
      value: 
    - name: MONGO_INITDB_ROOT_PASSWORD
      value: 
    ````

    > At this point, let the values blanc. (we'll create a secret for mongo as well as a configmap)


    ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: mongodb
        labels:
            app: mongo     
    spec:
        replicas: 3
        selector:
            matchLabels:
                app: mongo
        template:
            metadata:
                labels:
                    app: mongo
            spec:
                containers:
                - name: mongo
                  image: mongo # to specify a version use `<imagename>:x.yy`
                  env:
                  - name: MONGO_INITDB_ROOT_USERNAME
                    value:
                  - name: MONGO_INITDB_ROOT_PASSWORD
                    value:
                  ports:
                  - containerPort: 27017 # Default port used by mongo
    ```

1. Create Secret for mongo

    > We'll create a Secret for mongoDB and link the Secret to the Deployment for mongoDB.

    > Create a configuration file to create a Secret for mongoDB

    ```
    vim mongo-service.yaml
    ```

    ```YAML
    apiVersion: v1
    kind: Secret
    metadata:
        name: mongodb-secret # Secret name
    type: Opaque # CA type
    data: # Key-value pair: chose the key-name and give a base64 string as value
        mongo-root-username: aGVsbG8td29ybGQ= # base64 string (hello-world)
        mongo-root-password: aGVsbG8td29ybGQ= # base64 string (hello-world)
    ```

    > To create a base64 string use the following command:
    ```bash
    echo -n '<your-string>' | base64
    ```

    ! IMPORTANT

    > First, create the Secret, then link the deployment to the Secret a apply the Deployment.


    > Create the Secret (apply)
    ```
    kubectl -f mongo-service.yaml apply
    ```

    > secret/mongodb-secret created

    > Verify
    ```bash
    kubectl get secret
    ```
    ```
    NAME             TYPE     DATA   AGE
    mongodb-secret   Opaque   2      52s
    ```

1. Link the Secret to the Deployment for mongo

    > Edit the mongo-deploy.yaml configuration file.
    ````bash
    vim mongo-deploy.yaml
    ````
    ```YAML
    env:
    - name: MONGO_INITDB_ROOT_USERNAME
      valueFrom:
        secretKeyRef:
            name: mongodb-secret
            key: mongo-root-username
    - name: MONGO_INITDB_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
            name: mongodb-secret
            key: mongo-root-password        
    ```

1. Apply deployment for mongo

    ```bash
    kubectl -f mongo-deploy.yaml apply
    ```
    
1. Create Internal Service for mongo

    > Add a config file to create a service for the mongo deployment.
    > Internal Service is a Service of type ClusterIP.
    It is the default Service inside Kubernetes, therefore, you don't need to specify the type (type: ClusterIP).

    ````bash
    vim svc-mongodb.yaml
    ````

    ````YAML
    apiVersion: v1
    kind: Service # Internal Service ~~ type: ClusterIP
    metadata:
        name: svc-mongodb # Name Service
    spec:
        selector:
            app: mongo # Name Pod 
    ports:
    - protocol: TCP
      port: 27017 # Service Port
      targetPort: 27017 # Container Port        
    ```` 

1. Apply the Service for mongo
    ````bash
    kubectl -f svc-mongodb.yaml apply
    ````

    > Verify
    ````bash
    kubectl get svc
    ````
    ````
    NAME          TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
    kubernetes    ClusterIP   10.96.0.1      <none>        443/TCP    42h
    svc-mongodb   ClusterIP   10.96.49.150   <none>        8081/TCP   3m15s
    ````

1. Deployment for mongoExpress
    > Check the containerport : https://hub.docker.com/_/mongo-express
    **ContainerPort: 8081**
    > Create 3 environment variables
    * username
    * password
    * database host
    > We'll use the previous Secret (created for mongo).
    > We'll use a ConfigMap for the database host, for now, let the value blanc.

    ```
    ```

1. Create ConfigMap for mongoExpress

    > Same logic as for the SecretMap
    
    ```bash
    vim cm-mongoExpress.yaml
    ```

    ````YAML
    apiVersion: v1
    kind: ConfigMap
    metadata:
        name: mongo-express-cm
    data:
        mongo-server: svc-mongodb   # Link to Service name
    ````
    > Link the ConfigMap to the deployment using `configMapKeyRef`

    ```bash
    kubectl -f cm-mongoExpress.yaml apply
    ```

    ```bash
    kubectl get cm
    ```
1. Edit Deployment for mongoExpress (link to ConfigMap)

````YAML
apiVersion: apps/v1
kind: Deployment
metadata:
    name: mongodb
    labels:
        app: mongo     
spec:
    replicas: 3
    selector:
        matchLabels:
            app: mongo
    template:
        metadata:
            labels:
                app: mongo
        spec:
            containers:
            - name: mongo
              image: mongo # To specify a version use `<imagename>:x.yy`
              env:
              - name: MONGO_INITDB_ROOT_USERNAME
                valueFrom:
                  secretKeyRef:
                    name: mongodb-secret
                    key: mongo-root-username
              - name: MONGO_INITDB_ROOT_PASSWORD
                valueFrom:
                  secretKeyRef:
                    name: mongodb-secret
                    key: mongo-root-password 
              ports:
              - containerPort: 27017 # Default port used by mongo

````    
    

1. External Service

````YAML
apiVersion: v1
kind: Service
metadata:
  name: mongo-express-service
spec:
  selector:
    app: mongo-express
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 8081
      targetPort: 8081 
````