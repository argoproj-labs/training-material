Let's look again at our eventsource configuration:
`cat /root/bootstrap/argo-events/minio-eventsource.yaml`{{execute}}.

We can see that it is observing the minio bucket `pipekit`. If we create a file in this bucket, we will trigger an event. We can later use this event to start a workflow.

