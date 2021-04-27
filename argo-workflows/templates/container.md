A container templates is the most common type of template, lets look at a complete example:

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow                 
metadata:
  generateName: container-   
spec:
  entrypoint: main         
  templates:
  - name: main             
    container:
      image: docker/whalesay
      command: [cowsay]         
      args: ["hello world"]
```

Lets run the workflow:

`argo submit --watch container-workflow.yaml`{{execute}}

Open the Argo Server tab a navigate to the workflow, you should see a single container running.
