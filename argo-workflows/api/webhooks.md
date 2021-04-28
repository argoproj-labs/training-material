We've use the `api/v1/workflows` endpoint to create workflows, but there's one endpoint who is specifically designed to
support creation of workflows via an api: `api/v1/events`. You should prefer this for most cases (including Jenkins):

1. It only allows you to create workflows from workflow templates, so is more secure.
1. It allows you to parse the HTTP payload and use it as parameters.
1. It allows you to integrate with other systems without you having to change those systems.
1. Webhooks also have support Github and Gitlab, so you can trigger workflow from a code commit.

To use this, you need to create a workflow template and a **workflow event binding**.:

A **workflow event binding** consists of:

* An **event selector** that matches events.
* A reference to a workflow template.
* Optional parameters.

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

Create the workflow template:

`kubect apply -f hellow-workflowtemplate.yaml`{{execute}}

Create the workflow event binding:

`kubect apply -f hellow-workfloweventbinding.yaml`{{execute}}

Try it out:

`curl http://localhost:2746/api/v1/events/argo/- -H "Authorization: $ARGO_TOKEN" -d '{"message": "hello events"}'`
{{execute}}

Check the logs:

`argo logs @latest`{{execute}}

[Learn more about webhooks](https://argoproj.github.io/argo-workflows/events/)

## Exercise

Update the workflow event binding to add annotations to created workflows. Hint: read the docs linked above. 