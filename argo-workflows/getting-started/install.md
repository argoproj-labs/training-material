Firstly, wait for Kubernetes to be ready.

Argo is normally installed into a namespace named `argo`, so lets create that:

`kubectl create ns argo`{{execute}}

Next, navigate to the [releases page](https://github.com/argoproj/argo-workflows/releases/latest) and find the release you wish to use (the latest full release is preferred).

Scroll down to the `Controller and Server`{{}} section and execute the kubectl commands.

Below is an example of the install commands, ensure that you update the command to install the correct version number:

`kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.5.7/install.yaml`{{execute}}

## What was installed?

It will take about 1m for all deployments to become available. Let's look at what is installed while we wait.

The **Workflow Controller** is responsible for running workflows:

`kubectl -n argo get deploy workflow-controller`{{execute}}

And the **Argo Server** provides a user interface and API:

`kubectl -n argo get deploy argo-server`{{execute}}

## Wait for everything to be ready

Before we proceed, let's wait (around 1 minute to 2 minutes) for our deployments to be available:

`kubectl -n argo wait deploy --all --for condition=Available --timeout 2m`{{execute}}
