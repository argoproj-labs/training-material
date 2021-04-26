You can view the user interface by running a port forward:

`kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 &`{{execute}}

To check this is working correctly, you can curl the info API:

`curl -kv https://localhost:2746/api/v1/info`{{execute}}

You should see `HTTP/1.1 200 OK`.

Argo Server listens on port 2746. Often the server will be installed behind a load balancer with TLS enabled. When this happens it will be available on port 443.

Open the "Argo Server" tab and you should see the user interface:

![UI](./assets/getting-started/ui.png)

Lets start a workflow from the user interface:

Click "Submit new workflow":

![UI](./assets/getting-started/submit-01.png)

Click "Edit using full workflow options".

![UI](./assets/getting-started/submit-02.png)

Click "Create". You should see the workflow running.

![UI](./assets/getting-started/running.png)

After about 30s, the icon should change from yellow to green:

![UI](./assets/getting-started/green.png)
