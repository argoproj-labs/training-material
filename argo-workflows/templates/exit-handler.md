If you need to perform a task after something has finished, you can use an exit handler. Exit handlers are specified
using `onExit`:

```
      dag:
        tasks:
          - name: a
            template: whalesay
            onExit: tidy-up
```

They just state the name of the template that should be run on-exit.

Let's look at a complete example:

`cat exit-handler-workflow.yaml`{{execute}}

Run it:

`argo submit --watch exit-handler-workflow.yaml`{{execute}}

You should see:

```
STEP                   TEMPLATE  PODNAME                        DURATION  MESSAGE
 ✔ exit-handler-plvg7  main
 ├─✔ a                 whalesay  exit-handler-plvg7-1651124468  5s
 └─✔ a.onExit          tidy-up   exit-handler-plvg7-3635807335  6s
```

Note how the exit handler task ran last.

## Exercise

An exit handler can be run at the end of a template, or at the end of a workflow. Change the example to run one at the
end of the workflow.

Learn more about [exit handlers](https://argoproj.github.io/argo-workflows/walk-through/exit-handlers/), as well as their close cousin, [lifecycle hooks](https://argoproj.github.io/argo-workflows/lifecyclehook/), in the Argo Workflows documentation.
