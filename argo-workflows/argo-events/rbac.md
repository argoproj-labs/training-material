Kubernetes RBAC is a deep subject. Further reading can be found in the [Kubernetes Documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/).

Our sensor is running using the default Service Account in the argo-events namespace. This service account does not have permission to create workflows in the argo namespace. We therefore need to give it permission to do so.

You may choose to create a completely new Service Account for this purpose. For brevity, we will just grant the default Service Account permission to create workflows. We do this using a ClusterRole, and a ClusterRoleBinding to bind the role to the Serviceaccount.

View this: `cat /root/sa.yaml`{{execute}}.

Deploy this with `kubectl apply -n argo-events -f /root/sa.yaml`{{execute}}.


Now we can attempt to re-trigger our workflow. We can do this by deleting the file we uploaded to minio. This will trigger a delete event, which will trigger our workflow.

In case you need to, port-forward the minio UI. Then log in and delete a file from the argoproj bucket.

[Go back to Minio]({{TRAFFIC_HOST1_9001}}) and delete the previously uploaded file.


Let's look at the sensor pod logs again.

`kubectl -n argo-events logs -l sensor-name=minio`{{execute}}

This time, the event successfully triggered our workflow:

```
{
   "level":"info",
   "ts":1685713173.4561043,
   "logger":"argo-events.sensor",
   "caller":"sensors/listener.go:417",
   "msg":"Successfully processed trigger 'minio-workflow-trigger'",
   "sensorName":"minio",
   "triggerName":"minio-workflow-trigger",
   "triggerType":"Kubernetes",
   "triggeredBy":[
      "example-dep"
   ],
   "triggeredByEvents":[
      "35313437336561662d633034302d346266632d613966302d613134383966313834383230"
   ]
}
```

We can see that the workflow was triggered, and that it completed successfully. It also contains the name of our file. In our case, we called it 'foo':

`argo logs -n argo @latest`{{execute}}
