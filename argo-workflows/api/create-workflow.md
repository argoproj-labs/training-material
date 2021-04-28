API endpoints take JSON rather than YAML as their payload

```bash
curl \
   http://localhost:2746/api/v1/workflows/argo \
  -H "Authorization: $ARGO_TOKEN" \
  -H 'Content-Type: application/json' \
  -d '{
  "workflow": {
    "metadata": {
      "generateName": "hello-world-"
    },
    "spec": {
      "templates": [
        {
          "name": "main",
          "container": {
            "image": "docker/whalesay",
            "command": [
              "cowsay"
            ],
            "args": [
              "hello world"
            ]
          }
        }
      ],
      "entrypoint": "main"
    }
  }
}'
```{{execute}}

You should see something like:

```bash
TODO
```

We can wait for that workflow to complete:

```bash
curl \
    http://localhost:2746/api/v1/workflows/argo/@latest \
    -H "Authorization: $ARGO_TOKEN" \
```{{execute}}

You should see something like:

```bash
TODO
```

## Exercise

Create a workflow template and then submit the workflow template using the API. You'll need grant the `jenkins` service
account the ability to read templates to do this.