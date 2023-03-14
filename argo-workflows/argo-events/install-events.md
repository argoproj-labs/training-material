Argo is normally installed into a namespace named `argo-events`, so lets create that:

`kubectl create ns argo-events`{{execute}}

Next, navigate to the [releases page](https://github.com/argoproj/argo-events/releases/latest) and find the release you wish to use (the latest full release is preferred).

Scroll down to the `Installation`{{}} section and execute the kubectl commands.

Below is an example of the install commands, ensure that you update the command to install the correct version number:

`kubectl apply -n argo-events -f https://github.com/argoproj/argo-events/releases/download/v1.7.6/install.yaml`{{execute}}

Argo Events also requires an eventbus to be created. This is a central point for all events to be sent to. The eventbus is created in the same namespace as the Argo Events controller.

There is an example available in the [argo events github repo](https://github.com/argoproj/argo-events/blob/stable/examples/eventbus/native.yaml). Execute the following command to create the eventbus:

`kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml`{{execute}}
