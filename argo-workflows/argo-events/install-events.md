Argo Events is normally installed into a namespace named `argo-events`, so let's create that:

`kubectl create ns argo-events`{{execute}}

Next, navigate to the [releases page](https://github.com/argoproj/argo-events/releases/latest) and find the release you wish to use (the latest full release is preferred).

Scroll down to the `Installation`{{}} section and execute the kubectl commands.

Below is an example of the install command, ensure that you update the command to install the correct version number:

`kubectl apply -n argo-events -f https://github.com/argoproj/argo-events/releases/download/v1.9.9/install.yaml`{{execute}}

Argo Events also requires an eventbus to be created. This is a central point for all events to be sent to. The eventbus is created in the same namespace as the Argo Events controller.

There is an example available in the [argo events github repo](https://github.com/argoproj/argo-events/blob/stable/examples/eventbus/native.yaml). Execute the following command to create the eventbus:

`kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml`{{execute}}

We want Argo Events to trigger a workflow when a file is added to minio. In order to achieve this, we will add [a minio eventsource](https://argoproj.github.io/argo-events/eventsources/setup/minio/) which will listen for minio events.

The eventsource will require minio credentials. We will provide these in the form of a secret.
View the secret with `cat /root/minio-secret.yaml`{{execute}}.

Deploy the secret with `kubectl apply -n argo-events -f /root/minio-secret.yaml`{{execute}}.

Now we can deploy our eventsource:
View our eventsource with `cat /root/minio-eventsource.yaml`{{execute}}.

Deploy the eventsource with `kubectl apply -n argo-events -f /root/minio-eventsource.yaml`{{execute}}.


## What was installed?
It may take about 1m for all deployments to become available. Let's look at what is installed while we wait.

The **Events Controller-Manager**:
`kubectl -n argo-events get deploy controller-manager`{{execute}}

An eventbus statefulset:
`kubectl -n argo-events get statefulsets eventbus-default-stan`{{execute}}

A minio eventsource pod:
`kubectl -n argo-events get pod -l eventsource-name=minio`{{execute}}
