A **DAG template** is a common type of *orchestration* template.
Let's look at a complete example:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: dag-
spec:
  entrypoint: main
  templates:
    - name: main
      dag:
        tasks:
          - name: a
            template: echo
          - name: b
            template: echo
            dependencies:
              - a
    - name: echo
      container:
        image: busybox
        command: [ echo ]
        args: [ "hello world" ]

```

In this example, we have two templates:

* The "main" template is our new DAG.
* The "echo" template is the same template as in the container example.

The DAG has two tasks: "a" and "b". Both run the "echo" template, but as "b" depends on "a", it won't start until "
a" has completed successfully.

Let's run the workflow:

`argo submit --serviceaccount argo-workflow --watch dag-workflow.yaml`{{execute}}

You should see something like:

```bash
STEP          TEMPLATE  PODNAME              DURATION  MESSAGE
 ✔ dag-shxn5  main
 ├─✔ a        echo       dag-shxn5-289972251  6s
 └─✔ b        echo       dag-shxn5-306749870  6s
```

Did you see how `b` did not start until `a` had completed?

Open the Argo Server tab and navigate to the workflow, you should see two containers.

## Exercise

Add a new task named "c" to the DAG. Make it depend on both "a" and "b".
Go to the UI and view your updated workflow graph.
