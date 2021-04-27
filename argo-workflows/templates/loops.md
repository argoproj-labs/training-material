## With Items

A DAG allows you to loop over a number of items using `withItems`:

```
      dag:
        tasks:
          - name: print-message
            template: whalesay
            arguments:
              parameters:
                - name: message
                  value: "{{item}}"
            withItems:
              - "hello world"
              - "goodbye world"
```

In this example, it will execute once for each of the listed items. We can see a **template tag** here. `{{item}}` will be replaced with "hello world" and "goodbye world". DAGs execute in parallel, so both tasks will be started at the same time.

`argo submit --watch with-items-workflow.yaml`{{execute}}

## With Sequence

You can also loop over a sequence of numbers using `withSequence`:

```
      dag:
        tasks:
          - name: print-message
            template: whalesay
            arguments:
              parameters:
                - name: message
                  value: "{{item}}"
            withSequence:
              count: 5
```

`argo submit --watch with-sequence-workflow.yaml`{{execute}}

The ability to run large parallel processing jobs is one of the key features or Argo Workflows.