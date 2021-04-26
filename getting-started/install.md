Firstly, wait for Kubernetes to be ready:

`until kubectl cluster-info; do sleep 3s; done`{{execute}}

Argo is normally installed into a namespace named `argo`, so lets create that:

`kubectl create ns argo`{{execute}}

Next, apply the quick-start manifest:

`kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml`{{execute}}

## What was installed?

It will take about 1m for all deployments to become available. In the meantime, so lets look at what is installed while we wait.

The workflow controller is responsible for running workflows. 

`kubectl -n argo get deploy workflow-controller`{{execute}}

Users typically want to process and store data in a workflow, for the quick start we use MinIO, which is similar to Amazon S3:

`kubectl -n argo get deploy minio`{{execute}}

Finally, the Argo Server provides a user interface and API;

`kubectl -n argo get deploy argo-server`{{execute}}

## Wait for everything to be ready

Before we proceed, let wait (around 1m) for our deployments to be available:

`kubectl -n argo wait deploy --all --for condition=Available`{{execute}}

