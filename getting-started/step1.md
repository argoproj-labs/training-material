Argo is normally installed into a namespace named `argo`, so create that

`kubectl create ns argo`{{execute}}

Next, you can apply a quick-start manifest:

`kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml`{{execute}}

It will take about 1m for all components to become available. In the meantime, so lets look at what is installed.

The workflow controller is responsible for running workflows. 

`kubectl -n argo get deploy workflow-controller`{{execute}}

Users typically want to process and store data in a workflow, for the quick start we use MinIO, which is similar to Amazon S3:

`kubectl -n argo get pod minio`{{execute}}

Finally, the Argo Server provides a user interface and API;

`kubectl -n argo get deploy argo-server`{{execute}}

Before we proceed, wait for all the deployments to be available:

`kubectl -n argo wait deploy --all --for condition=Available`{{execute}}

