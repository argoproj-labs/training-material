Firstly, we need to wait for Kubernetes to be available:

    until kubectl cluster-info; do sleep 5s; done
    {{execute}}

Argo is normally installed into a namespace named `argo`, so create that

```
kubectl create ns argo
```{{execute}}

Next, you can apply a quick-start manifest:

```
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/v2.12.10/manifests/quick-start-minimal.yaml
```{{execute}}

It can take a few minutes for each component to become available, so lets look at what is installed.

The workflow controller is responsible for running workflows. 

```
kubectl -n argo get deploy workflow-controller
```{{execute}}

Users typically want to process and store data in a workflow, for the quick start we use MinIO, which is similar to Amazon S3:

```
kubectl -n argo get pod minio
```{{execute}}

Finally, the Argo Server provides a user interface and API;

```
kubectl -n argo get deploy argo-server
```{{execute}}

You can view the Argo Server by forwarding it port 2746:

```
kubectl -n argo port-forward deployment/argo-server 2747:2746
```{{execute}}
