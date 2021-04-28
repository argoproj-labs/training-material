**Workflow templates** (not to be confused with a template) allow you to create a library of code that can be reused.
They're similar to pipelines in Jenkins.

Workflow templatse have a different `kind` to a workflow, but are otherwise very similar:

```
apiVersion: argoproj.io/v1alpha1
kind: WorkflowTemplate
metadata:
  name: hello
spec:
  entrypoint: main
  templates:
    - name: main
      container:
        image: docker/whalesay
```

Lets created this workflow template:

`argo template create hello-workflowtemplate.yaml`{{execute}}

You can also manage templates using `kubectl`:

`kubectl apply -f hello-workflowtemplate.yaml`{{execute}}

This allows you to use GitOps to managed your templates.

To submit a template, you can use the UI or the CLI:

`argo submit --watch --from workflowtemplate/hello`{{execute}}

You should see:

```
STEP            TEMPLATE  PODNAME      DURATION  MESSAGE
 ✔ hello-c622t  main      hello-c622t  33s         
```

Lets take a look at the workflow you created:

`argo get @latest -o yaml`{{execute}}

Look for the workflow specification in the output:

```
spec:
  workflowTemplateRef:
    name: hello
```

Note how the specification of the workflow is actually a reference to the template.

## Exercise

* Use the user interface to submit a workflow template.
* Update the workflow template to add some parameters (e.g. to print a message). Use `argo submit --from` to submit it
  with different parameters. 