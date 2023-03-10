# List all examples
`ls /root/examples`{{execute}}

# Run an example
`argo submit -n argo --watch /root/examples/coinflip.yaml`{{execute}}

## You may need to kubecl apply additional files to the cluster prior to running an example:
`kubectl apply -n argo -f /root/examples/workflow-template/templates.yaml`{{execute}}

# View the server UI
`kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &`{{execute}}

[click here to access the UI]({{TRAFFIC_HOST1_2746}})
