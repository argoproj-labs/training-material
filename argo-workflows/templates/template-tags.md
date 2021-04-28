**Template tags** (also knows as **template variables**) are a way for you substitute data into you workflow at runtime. Template tags are delimited by `{{`
and `}}` and will be replaced when the template is executed.

What tags are available to use depends on the template type, and there are a number of global ones you can use, such as `{{workflow.name}}`, which is replaced by the workflow's name:

```
    - name: main
      container:
        image: docker/whalesay
        command: [ cowsay ]
        args: [ "hello {{workflow.name}}" ]
```

Look at the full example:

`cat template-tag-workflow.yaml`{{execute}}

Submit this workflow:

`argo submit --watch template-tag-workflow.yaml`{{execute}}

You can see the output by running

`argo logs @latest`{{execute}}

You should see something like:

```
 __________________________ 
< hello template-tag-kqpc6 >
 -------------------------- 
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

There are many more different tags, you can [read more about template tags in the docs](https://argoproj.github.io/argo-workflows/variables/).

## Exercise

Change the workflow to echo the date the workflow was created. 