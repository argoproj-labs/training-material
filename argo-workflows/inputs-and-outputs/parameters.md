One type of input or output is a **parameter**. Unlike artifacts, these are plain string values, and are useful for most
simple cases.

## Input Parameters

Let's have a look at an example:

```
    - name: main
      inputs:
        parameters:
          - name: message
      container:
        image: docker/whalesay
        command: [ cowsay ]
        args: [ "{{inputs.parameters.message}}" ]
```

This template declares that it has one input parameter named "message".

See the complete workflow:

`cat input-parameters-workflow.yaml`{{execute}}

See how the workflow itself has arguments?

Run it:

`argo submit --watch input-parameters-workflow.yaml`{{execute}}

You should see:

```
STEP                       TEMPLATE  PODNAME                 DURATION  MESSAGE
 ✔ input-parameters-mvtcw  main      input-parameters-mvtcw  8s          
```

If a workflow has parameters, you can change the parameters using `-p` using the CLI:

`argo submit --watch input-parameters-workflow.yaml -p message='Welcome to Argo!'`{{execute}}

You should see:

```
STEP                       TEMPLATE  PODNAME                 DURATION  MESSAGE
 ✔ input-parameters-lwkdx  main      input-parameters-lwkdx  5s          
```

Let's check the output in the logs:

`argo logs @latest`{{execute}}

You should see:

```
 ______________
< Welcome to Argo! >
 --------------
    \
     \
      \     
                    ##        .            
              ## ## ##       ==            
           ## ## ## ##      ===            
       /""""""""""""""""___/ ===        
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
       \______ o          __/            
        \    \        __/             
          \____\______/   
```

## Output Parameters

Output parameters can be from a few places, but typically the most versatile is from a file. In this example, the
container creates a file with a message in it:

```
  - name: whalesay
    container:
      image: docker/whalesay
      command: [sh, -c]
      args: ["echo -n hello world > /tmp/hello_world.txt"]
    outputs:
      parameters:
      - name: hello-param		
        valueFrom:
          path: /tmp/hello_world.txt
```

In a DAG template and steps template, you can reference the output from one task, as the input to another
task using a **template tag**:

```
      dag:
        tasks:
          - name: generate-parameter
            template: whalesay
          - name: consume-parameter
            template: print-message
            dependencies:
              - generate-parameter
            arguments:
              parameters:
                - name: message
                  value: "{{tasks.generate-parameter.outputs.parameters.hello-param}}"
```

See the complete workflow:

`cat parameters-workflow.yaml`{{execute}}

Run it:

`argo submit --watch parameters-workflow.yaml`{{execute}}

You should see:

```
STEP                     TEMPLATE       PODNAME                      DURATION  MESSAGE
 ✔ parameters-vjvwg      main                                                    
 ├─✔ generate-parameter  whalesay       parameters-vjvwg-4019940555  43s         
 └─✔ consume-parameter   print-message  parameters-vjvwg-1497618270  8s          
```

Learn more about parameters in the Argo Workflows [documentation](https://argoproj.github.io/argo-workflows/workflow-inputs/).
