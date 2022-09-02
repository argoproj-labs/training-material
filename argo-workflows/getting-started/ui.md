The argo-server (and thus the UI) defaults to client authentication, which requires clients to provide their Kubernetes bearer token in order to authenticate. For more information, refer to the [Argo Server Auth Mode documentation](https://argoproj.github.io/argo-workflows/argo-server-auth-mode/). We will switch the authentication mode to server so that we can bypass the UI login for now.

Additionally, Argo Server runs over https by default. This isn't compatible with killercoda, so we will disable https at the same time.

```
kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server",
  "--secure=false"
]},
{"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": "HTTP"}
]'
```{{execute}}

We need to wait for the Argo Server to redeploy:

`kubectl -n argo rollout status --watch --timeout=600s deployment/argo-server`{{execute}}

You can then view the user interface by running a port forward:

`kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &`{{execute}}

You can then use this link to access the UI:

[ACCESS ARGO WORKFLOWS UI]{{TRAFFIC_HOST1_2746}}

## Run a workflow

Open the "Argo Server" tab and you should see the user interface:

![UI](../assets/ui.png)

Lets start a workflow from the user interface:

Click "Submit new workflow":

![UI](../assets/submit-01.png)

Click "Edit using full workflow options". You should see something similar to this:

![UI](../assets/submit-02.png)

Paste this YAML into the editor:

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: hello-world-  
spec:
  entrypoint: main        
  templates:
  - name: main           
    container: 
      image: docker/whalesay  
```{{copy}}

Click "Create". You will see a diagram of the workflow. The yellow icon shows that it is pending, after a few seconds it'll turn blue to indicate it is running, and finally green to show that it has completed successfully:

![UI](../assets/running.png)

After about 30s, the icon will change to green:

![UI](../assets/green.png)

## Exercise

Take a few minutes to play around with the user interface. Find out how to:
 
* List workflows.
* View a workflow.
* Resubmit a completed workflow.
