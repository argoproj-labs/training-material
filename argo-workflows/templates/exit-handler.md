If you need to perform a task after something has is finished, you can use an exit handle. Exit handlers are specified
using `onExit`:

```
      dag:
        tasks:
          - name: a
            template: whalesay
            onExit: tidy-up
```

They just state the name of the template that should be run on-exit.

Lets look at a complete example:

`cat exit-handler-workflow.yaml`{{execute}}

Run it:

`argo submit --watch exit-handler-workflow.yaml`{{execute}}

You should see:

```
TODO
```

Note how the exit handler task ran last.

## Exercise

An exit handle can be run at the end of a template, or at the end of a workflow. Change the example to run one at the
end of the workflow.