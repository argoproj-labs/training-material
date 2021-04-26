You can view the user interface by running a port forward:

`kubectl -n argo port-forward --address 0.0.0.0 deployment/argo-server 2746:2746 &`{{execute}}

To check this is working correctly, you can curl the info API:

`curl -v localhost:2746/api/v1/info`{{execute}}

You should see `HTTP/1.1 200 OK`.

Argo Server runs on port 2746, this is just a convention, because ports 80 and 8080 are often popular and therefore not available. Often the server will be installed behind a load balancer with TLS enabled. When this happens it will be available on port 443.

Open the "Argo Server" tab and you should see the user interface:

![UI](./assets/ui.png)

Lets start a workflow from the user interface:

1. Click the "Submit new workflow" button
2. Click the "Submit" button.

You should see the workflow running.

