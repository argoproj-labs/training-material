We need to install a Sensor that is called by the EventSource. The Sensor is responsible for triggering the creation of a workflow when an event is received. Let's look at the Sensor configuration:

View our Sensor with `cat /root/bootstrap/argo-events/minio-sensor.yaml`{{execute}}.

Deploy with `kubectl apply -n argo-events -f /root/bootstrap/argo-events/minio-sensor.yaml`{{execute}}.




Let's look again at our eventsource configuration:
`cat /root/bootstrap/argo-events/minio-eventsource.yaml`{{execute}}.

We can see that it is observing the minio bucket `pipekit`. If we create a file in this bucket, we will trigger an event. We can later use this event to start a workflow.

The [minio client](https://min.io/docs/minio/linux/reference/minio-mc.html) has been pre-installed for you in order to make submitting a file to minio easier. Let's use it to create a file in the `pipekit` bucket:

```
touch test
./mc cp test s3:/pipekit
```{{execute}}
