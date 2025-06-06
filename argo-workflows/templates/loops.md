The ability to run large parallel processing jobs is one of the key features of Argo Workflows.
Let's have a look at using loops to do this.

## withItems

A DAG allows you to loop over a number of items using `withItems`:

```yaml
      dag:
        tasks:
          - name: print-message
            template: echo
            arguments:
              parameters:
                - name: message
                  value: "{{item}}"
            withItems:
              - "hello world"
              - "goodbye world"
```

In this example, it will execute once for each of the listed items. We can see a **template tag** here. `{{item}}` will be replaced with "hello world" and "goodbye world". DAGs execute in parallel, so both tasks will be started at the same time.

`argo submit --serviceaccount argo-workflow --watch with-items-workflow.yaml`{{execute}}

You should see something like:

```bash
STEP                                 TEMPLATE  PODNAME                      DURATION  MESSAGE
 ✔ with-items-4qzg9                  main
 ├─✔ print-message(0:hello world)    echo  with-items-4qzg9-465751898   7s
 └─✔ print-message(1:goodbye world)  echo  with-items-4qzg9-2410280706  5s
```

Notice how the two items ran at the same time.

## withSequence

You can also loop over a sequence of numbers using `withSequence`:

```yaml
      dag:
        tasks:
          - name: print-message
            template: echo
            arguments:
              parameters:
                - name: message
                  value: "{{item}}"
            withSequence:
              count: 5
```

As usual, run it:

`argo submit --serviceaccount argo-workflow --watch with-sequence-workflow.yaml`{{execute}}

```bash
STEP                     TEMPLATE  PODNAME                         DURATION  MESSAGE
 ✔ with-sequence-8nrp5   main
 ├─✔ print-message(0:0)  echo  with-sequence-8nrp5-3678575801  9s
 ├─✔ print-message(1:1)  echo  with-sequence-8nrp5-1828425621  7s
 ├─✔ print-message(2:2)  echo  with-sequence-8nrp5-1644772305  13s
 ├─✔ print-message(3:3)  echo  with-sequence-8nrp5-3766794981  15s
 └─✔ print-message(4:4)  echo  with-sequence-8nrp5-361941985   11s
```

See how 5 pods were run at the same time, and that their names have the item value in them, zero-indexed?

## Exercise

Change the **withSequence** to print the numbers 10 to 20.
