A workflow is defined as a **Kubernetes resource**. Each workflow consists of one or more templates, one of which is
defined as the entrypoint. Each template can be one of several types, in this example we have one template that is a
container.

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  name: hello
spec:
  entrypoint: main # the first template to run in the workflows
  templates:
  - name: main
    container: # this is a container template
      image: docker/whalesay # this image prints "hello world" to the console
      command: ["cowsay"]
```

There are several other types of templates, and we'll come to more of them soon.

Because a workflow is just a Kubernetes resource, you can use `kubectl` with them.

Create a workflow:

`kubectl -n argo create -f hello-workflow.yaml`{{execute}}

Then you can wait for it to complete (around 1m):

`kubectl -n argo wait workflows/hello --for condition=Completed --timeout 2m`{{execute}}
