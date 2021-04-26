Firstly, we need to wait about 30s for Kubernetes to be available:

`until kubectl cluster-info; do sleep 3s; done`{{execute}}

When it is ready, you will see:

    Kubernetes master is running at https://172.17.0.55:6443

Argo is normally installed into a namespace named `argo`, so create that

`kubectl create ns argo`{{execute}}

Next, you can apply a quick-start manifest:

`kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/v2.12.10/manifests/quick-start-minimal.yaml`{{execute}}

It will take about 1m for all components to become available. In the meantime, so lets look at what is installed.

The workflow controller is responsible for running workflows. 

`kubectl -n argo get deploy workflow-controller`{{execute}}

Users typically want to process and store data in a workflow, for the quick start we use MinIO, which is similar to Amazon S3:

`kubectl -n argo get pod minio {{execute}}

Finally, the Argo Server provides a user interface and API;

`kubectl -n argo get deploy argo-server`{{execute}}

You can view the user interface by running a port forward 2746:

`kubectl -n argo port-forward --address 0.0.0.0 deployment/argo-server 2746:2746 &`{{execute}}

To check this is working correctly, you can curl the info API:

`curl -v localhost:2746/api/v1/info`{{execute}}

You should see `HTTP/1.1 200 OK`.

Argo Server runs on port 2746, this is just a convention, because ports 80 and 8080 are often popular and therefore not available. Often the server will be installed behind a load balancer with TLS enabled. When this happens it will be available on port 443. 

Open the "Argo Server" tab and you should see the user interface.


