The ability to run large parallel processing jobs is one of the key features or Argo Workflows.  Lets have a look at using loops to do this.

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

You should see something like:

```
STEP                                 TEMPLATE  PODNAME                      DURATION  MESSAGE
 ✔ with-items-4qzg9                  main                                               
 ├─✔ print-message(0:hello world)    whalesay  with-items-4qzg9-465751898   7s          
 └─✔ print-message(1:goodbye world)  whalesay  with-items-4qzg9-2410280706  5s          
```

Notice how the two items ran at the same time.

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

As usual, run it:

`argo submit --watch with-sequence-workflow.yaml`{{execute}}

```
STEP                     TEMPLATE  PODNAME                         DURATION  MESSAGE
 ✔ with-sequence-8nrp5   main                                                  
 ├─✔ print-message(0:0)  whalesay  with-sequence-8nrp5-3678575801  9s          
 ├─✔ print-message(1:1)  whalesay  with-sequence-8nrp5-1828425621  7s          
 ├─✔ print-message(2:2)  whalesay  with-sequence-8nrp5-1644772305  13s         
 ├─✔ print-message(3:3)  whalesay  with-sequence-8nrp5-3766794981  15s         
 └─✔ print-message(4:4)  whalesay  with-sequence-8nrp5-361941985   11s         
```

See how 5 pods were run at the same time, and that their names have the item value in them, zero-indexed 

## Exercise

Change the **with sequence** to print the numbers 10 to 20. 