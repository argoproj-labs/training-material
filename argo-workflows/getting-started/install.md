Firstly, wait for Kubernetes to be ready.

Argo is normally installed into a namespace named `argo`, so lets create that:

`kubectl create ns argo`{{execute}}

Next, apply the quick-start manifest:

`kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml`{{execute}}

## What was installed?

It will take about 1m for all deployments to become available. Let's look at what is installed while we wait.

The **Workflow Controller** is responsible for running workflows:

`kubectl -n argo get deploy workflow-controller`{{execute}}

Users typically want to process and store data in a workflow, for the quick start we use MinIO, which is similar to Amazon S3:

`kubectl -n argo get deploy minio`{{execute}}

Finally, the **Argo Server** provides a user interface and API:

`kubectl -n argo get deploy argo-server`{{execute}}

## Wait for everything to be ready

Before we proceed, let's wait (around 1 minute to 2 minutes) for our deployments to be available:

`kubectl -n argo wait deploy --all --for condition=Available --timeout 2m`{{execute}}
