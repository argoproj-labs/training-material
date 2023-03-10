We will be using the community maintained argoproj Helm Charts. More information can be [found on GitHub](https://argoproj.github.io/argo-helm/).

Argo is normally installed into a namespace named `argo` so we will create that as part of our deployment.

This command installs the latest Argo Workflows Helm Chart. In production it would be sensible to pin the version of the chart to a specific version.
```
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argo argo/argo-workflows --namespace argo --create-namespace
```{{execute}}

## What was installed?

It will take about 1m for all deployments to become available. Let's look at what is installed while we wait.

The **Workflow Controller** is responsible for running workflows:

`kubectl -n argo get deploy argo-argo-workflows-workflow-controller`{{execute}}

And the **Argo Server** provides a user interface and API:

`kubectl -n argo get deploy argo-argo-workflows-server`{{execute}}

## Wait for everything to be ready

Before we proceed, let's wait (around 1 minute to 2 minutes) for our deployments to be available:

`kubectl -n argo wait deploy --all --for condition=Available --timeout 2m`{{execute}}
