What other types of *work* templates are there?

A **container set** allows you to run multiple containers in a single pod. This is useful when you want the containers
to share a common workspace, or when you want to consolidate pod spin-up time into one step in your workflow.

A **data template** allows you get data from storage (e.g. S3). This is useful when each item of data represents an item
of work that needs doing.

A **resource template** allows you to create a Kubernetes resource and wait for it to meet a condition (e.g. successful)
. This is useful if you want to interoperate with another Kubernetes system, like AWS Spark EMR.

A **script template** allows you to run a script in a container. This is very similar to a container template, but when
you've added a script to it.

Every type of template that does work, does so by running a pod. You can use `kubectl` to view these pods:

`kubectl get pods -l workflows.argoproj.io/workflow`{{execute}}

You can identify workflow pods by the `workflows.argoproj.io/workflow` label.

You should see something like this:

```bash
NAME                 READY   STATUS      RESTARTS   AGE
container-m5664      0/2     Completed   0          5m21s
template-tag-kqpc6   0/2     Completed   0          4m6s
```

## Exercise

Use `kubectl describe` to describe a workflow pod. What interesting information is contained within the pod's labels
and annotations?
