1. Installeer minikube

1. Start minikube
    ```
    minikube start
    ```
1. Check dat je kubectl kan gebruiken
    ```
    kubectl
    ```
1. Gebruik kubectl om de nodes op te vragen 

    ```
    kubectl get nodes
    ```
    > Naast de nodes kunnen we ook andere dingen zoals pods en services opvragen 
    
    ```
    kubectl get pod
    ```
    ```
    kubectl get svc
    ```    
   
    > We zien dat er momenteel nog geen pods bestaan en dat enkel de default service beschikbaar is.

1. Gebruik `kubectl create -h` om de helpfile op te vragen en meer details te verkrijgen over het aanmaken van nieuwe elementen in onze cluster. 
    ```
    kubectl create -h
    ```
    > We zien echter dat er hier geen optie voor pod terug te vinden is. Dit is omdat een pod eigenlijk niet als afzonderlijk element binnen een cluster zal bestaan, maar meestal enkel deel zal uitmaken van een **deployment**.

    > Als we een nieuwe deployment willen creëren zullen we dit als volgt kunnen doen: `kubectl create deployment <naam> --image=<imagenaam van bvb dockerhub> [opties] `

1. Maak een nieuwe **nginx deployment** aan met de naam "nginx-test", controleer nadien of deze effectief is aangemaakt met het "kubectl get" commando

    > Status van Pods:
    * 0/1 READY 
    * "ContainerCreating"
    
1. Kijk het aantal replicasets na

    ```
    kubectl get replicaset
    ```
    
    >Dankzij een extra abstractielaag (control-manager) zal Kubernetes zelf weten dat er momenteel één exemplaar van onze pod moet zijn. 

    > De huidige abstractielagen van onze cluster is als volgt:
    * Deployment zal managen..
        * Replicaset, die zal managen..
            * Onze Pods, die een abstractie is van een container (bvb Docker container)

    > Alles "onder" de deployment zal automatisch door k8s worden beheerd


## Deployment aanpassen / wijzigen

Als we onze pods willen aanpassen kan dit door het commando:
`kubectl edit deployment <naam van deployment>`

> Dit zal de configfile van de deployment openen (die automatisch is gegenereerd aan de hand van onze opties). 

1. Momenteel hebben we geen versienummer meegegeven aan onze nginx deployment, maar eigenlijk zouden we graag expliciet versie 1.20.1 gebruiken omdat onze fictieve applicatie issues heeft met de latest release, pas de image van onze nginx-test deployment aan naar "nginx:1.20.1".
    * Bewaar deze wijziging en kijk pods en de replicasets na:
        * `kubectl get pod`
        * `kubectl get replicaset`


1. Maak nog een nieuwe deployment aan die de "mongo" image gaat gebruiken, noem deze "mongo-test"


1. Kubectl commando's

    * Vraag de logs van onze nieuwe mongo pod op met ``kubectl logs <naam van pod>``
    * Net zoals bij Docker is het ook hier mogelijk om rechtstreeks een container te gaan controllen, dit is voornamelijk nuttig als je niet zeker bent of iets correct werkt en moet gaan debuggen. We kunnen dit doen met: ``kubectl exec -it <naam van de pod> -- bin/bash``.

    * Als we een deployment terug willen verwijderen kunnen we gebruik maken van ``kubectl delete deployment <naam>``.

1. Verwijder de nginx deployment die we eerder hebben aangemaakt


---

# Introductie Deployments - YAML (configuratie) files

> Om deze introductie af te ronden gaan we nog kort even naar deployment-files kijken. Tot nutoe hebben we deployments via de command-line aangemaakt, maar we hebben nog geen opties moeten toevoegen. 

Gelukkig kunnen we aan de hand van YAML files configuratie-files aanmaken voor k8s. 

1. Maak een nieuwe file aan en noem deze nginx-test.yaml en paste er de volgende inhoud in:

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
1. Eens we deze file hebben aangemaakt kunnen we dit effectief toepassen door ``kubectl apply -f <filename>.yaml`` uit te voeren

    ```bash
    kubectl apply -fnginx-test.yaml
    ```
1. *Stel dat we meer dan 1 pod willen voorzien voor deze deployment kunnen we onze .yaml file updaten en de apply opnieuw uitvoeren.* Verander de replicacount van onze nginx deployment naar 3 en controleer of de pods en deployment zijn geupdate.

> ``replicas: 3``
> ``kubectl edit deployment nginx-test``