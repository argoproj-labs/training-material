# List all examples
`ls /root/examples`{{execute}}

# Run an example
`argo submit -n argo --watch /root/examples/coinflip.yaml`{{execute}}

## You may need to kubecl apply additional files to the cluster prior to running an example:
`kubectl apply -n argo -f /root/examples/workflow-template/templates.yaml`{{execute}}

# View the server UI
`kubectl port-forward svc/argo-server -n argo 2746:2746`{{execute}}

[click here to access the UI]({{TRAFFIC_HOST1_2746}})
