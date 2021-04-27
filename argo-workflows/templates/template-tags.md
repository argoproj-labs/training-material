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


[Read more about template tags](https://argoproj.github.io/argo-workflows/variables/)