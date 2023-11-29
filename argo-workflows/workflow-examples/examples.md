The examples are pulled directly from the official [argoproj/argo-workflows](https://github.com/argoproj/argo-workflows/issues) repository. This means it is possible for an example to be broken. If you find an example that doesn't work, and you have tested outside of Killercoda, please open an issue on the official repository.

If an example works outside of Killercoda, but not in the course, please open an issue [on the course repository](https://github.com/argoproj-labs/training-material/issues).

# List all examples
`ls /root/examples`{{execute}}

# Run an example
`argo submit -n argo --watch /root/examples/coinflip.yaml`{{execute}}

## You may need to `kubectl apply` additional files to the cluster prior to running an example:
`kubectl apply -n argo -f /root/examples/workflow-template/templates.yaml`{{execute}}

# View the server UI
`kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &`{{execute}}

<!-- markdown-link-check-disable-next-line -->
[click here to access the UI]({{TRAFFIC_HOST1_2746}})
