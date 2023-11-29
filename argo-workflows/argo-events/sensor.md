We need to install a Sensor that is called by the EventSource. The Sensor is responsible for triggering the creation of a workflow when an event is received. Let's look at the Sensor configuration:

View our Sensor with `cat /root/minio-sensor.yaml`{{execute}}.

Deploy with `kubectl apply -n argo-events -f /root/minio-sensor.yaml`{{execute}}.

This ultimately creates a pod in our argo-events namespace that is responsible for triggering workflows when events are received.

Let's look again at our eventsource configuration:
`cat /root/minio-eventsource.yaml`{{execute}}.

We can see that it is set to observe the minio bucket called `argoproj`. If we create a file, or delete a file in this bucket, we will trigger an event.

Let's create a file in the minio bucket:
We need to port-forward the minio UI, log in and upload/delete a file from the argoproj bucket.

`kubectl -n argo port-forward --address 0.0.0.0 svc/minio 9001:9001 > /dev/null &`{{execute}}

<!-- markdown-link-check-disable-next-line -->
[Log in]({{TRAFFIC_HOST1_9001}}) with the username `argoproj` and the password `sup3rs3cr3tp4ssw0rd1`, and navigate to the argoproj bucket.

Upload a file.


Let's look at the sensor pod logs:

`kubectl -n argo-events logs -l sensor-name=minio`{{execute}}


We can see that... it failed. You'll see logs similar to:

```
{
   "level":"error",
   "ts":1685711961.5645943,
   "logger":"argo-events.sensor",
   "caller":"sensors/listener.go:356",
   "msg":"Failed to execute a trigger",
   "sensorName":"minio",
   "error":"failed to execute trigger, failed after retries: workflows.argoproj.io is forbidden: User \"system:serviceaccount:argo-events:default\" cannot create resource \"workflows\" in API group \"argoproj.io\" in the namespace \"argo\"",
   "triggerName":"minio-workflow-trigger",
   "triggeredBy":[
      "example-dep"
   ],
   "triggeredByEvents":[
      "37656535323431372d386530342d343639302d393434332d316336343039646138623631"
   ],
   "stacktrace":"github.com/argoproj/argo-events/sensors.(*SensorContext).triggerWithRateLimit\n\t/home/runner/work/argo-events/argo-events/sensors/listener.go:356"
}
```

It's not all doom and gloom. We can see that something *tried* to happen when we uploaded our file to minio. The Sensor tried to trigger a workflow, but it failed because the default service account does not have permission to create workflows. We need to grant the default service account permission to create workflows.
