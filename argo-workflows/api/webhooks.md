To keep things simple, we used the `api/v1/workflows` endpoint to create workflows, but there's one endpoint that is specifically designed to
create workflows via an api: `api/v1/events`. You should use this for most cases (including Jenkins):

1. It only allows you to create workflows from a `WorkflowTemplate`, so is more secure.
1. It allows you to parse the HTTP payload and use it as parameters.
1. It allows you to integrate with other systems without you having to change those systems.
1. Webhooks also support GitHub and GitLab, so you can trigger workflow from git actions.

To use this, you need to create a `WorkflowTemplate` and a **workflow event binding**.:

A **workflow event binding** consists of:

* An **event selector** that matches events
* A reference to a `WorkflowTemplate` using `workflowTemplateRef`
* Optional parameters


Example:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: WorkflowEventBinding
metadata:
  name: hello
spec:
  event:
    selector: payload.message != ""
  submit:
    workflowTemplateRef:
      name: hello
    arguments:
      parameters:
        - name: message
          valueFrom:
            event: payload.message
```

In the above example, if the event contained a message, then we'll submit the workflow template and the workflow will
echo the message.

Create the `WorkflowTemplates`:

`kubectl apply -f hello-workflowtemplate.yaml`{{execute}}

Create the workflow event binding:

`kubectl apply -f hello-workfloweventbinding.yaml`{{execute}}

Try it out:

`curl http://localhost:2746/api/v1/events/argo/- -H "Authorization: $ARGO_TOKEN" -d '{"message": "hello events"}'`{{execute}}

You will not get a response - this is processed asynchronously.

Allow about 5 seconds for the workflow to start and then check the logs:

`argo logs @latest`{{execute}}

You should see something like the following:

```bash
hello-u7mnk: hello events
```

[Learn more about webhooks](https://argoproj.github.io/argo-workflows/events/) in the Argo Workflows docs.

## Exercise

Update the workflow event binding to add annotations to created workflows.
Hint: read the docs linked above.
