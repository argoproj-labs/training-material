A container template is the most common type of template, let's look at a complete example:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: container-
spec:
  entrypoint: main
  templates:
  - name: main
    container:
      image: busybox
      command: [echo]
      args: ["hello world"]
```

Let's run the workflow:

`argo submit --serviceaccount argo-workflow --watch container-workflow.yaml`{{execute}}

Port-forward to the Argo Server pod...

`kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &`{{execute}}

<!-- markdown-link-check-disable-next-line -->
and [open the Argo Workflows UI]({{TRAFFIC_HOST1_2746}}/workflows/argo?limit=50). Then navigate to the workflow, you should see a single container running.

## Exercise

Edit the workflow to make it echo "howdy world".
