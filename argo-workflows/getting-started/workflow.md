A workflow is defined as a **Kubernetes resource**. Each workflow consists of one or more templates, one of which is defined as the entrypoint. Each template can be one of several types, in this example we have one template that is a container.

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: hello-world-  
spec:
  entrypoint: main # the first template to run in the workflows        
  templates:
  - name: main           
    container: # this is a container template
      image: docker/whalesay # this image prints "hello world" to the console 
```

There are several other types of template, and we'll come to more of them soon.

Because a workflow in just a Kuberenetes resource, you can use `kubectl` with them:

`kubectl -n argo get workflows`{{execute}}

You should see `No resources found in argo namespace.`