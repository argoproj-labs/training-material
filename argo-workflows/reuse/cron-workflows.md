A **cron workflow** is a workflow that runs on a cron schedule:

```
apiVersion: argoproj.io/v1alpha1
kind: CronWorkflow
metadata:
  name: hello-cron
spec:
  schedule: "* * * * *"
  workflowSpec:
    entrypoint: main
    templates:
      - name: main
        container:
          image: docker/whalesay
```

When it should be run is set in the `schedule` field, in the example every minute.

Lets created this cron workflow:

`argo cron create hello-cronworkflow.yaml`{{execute}}

You'll need to wait for up to a minute to see the workflow run.

## Exercise

Cron workflows can be submitted immediately from the CLI or the UI. Find out how.

