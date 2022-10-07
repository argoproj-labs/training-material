API endpoints take JSON rather than YAML as their payload, you can submit a workflow using `curl`:

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
{"metadata":{"name":"hello-world-mmbfs",...
```

We can wait for that workflow to complete by polling:

```bash
curl \
    http://localhost:2746/api/v1/workflows/argo/@latest \
    -H "Authorization: $ARGO_TOKEN"
```{{execute}}

You should see something like:

```bash
{"metadata":{"name":"hello-world-2j74f",...
```

## Exercise

Create a workflow template and then submit the workflow template using the API.