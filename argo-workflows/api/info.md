The Argo Server provides the API. This is secured using Kubernetes service accounts.

All endpoints can be found under `http://localhost:2746/api/v1` URL and typically require an access token.

Typically, it is good to be able to check you can access it first. This can be done using the info endpoint:

`curl http://localhost:2746/api/v1/info`{{execute}}

You should see something like:

```
controlplane $ curl http://localhost:2746/api/v1/info
{"managedNamespace":"argo","links":[{"name":"Workflow Link","scope":"workflow","url":"http://logging-facility?namespace=${metadata.namespace}\u0026workflowName=${metadata.name}\u0026startedAt=${status.startedAt}\u0026finishedAt=${status.finishedAt}"},{"name":"Pod Link","scope":"pod","url":"http://logging-facility?namespace=${metadata.namespace}\u0026podName=${metadata.name}\u0026startedAt=${status.startedAt}\u0026finishedAt=${status.finishedAt}"},{"name":"Pod Logs Link","scope":"pod-logs","url":"http://logging-facility?namespace=${metadata.namespace}\u0026podName=${metadata.name}\u0026startedAt=${status.startedAt}\u0026finishedAt=${status.finishedAt}"},{"name":"Event Source Logs Link","scope":"event-source-logs","url":"http://logging-facility?namespace=${metadata.namespace}\u0026podName=${metadata.name}\u0026startedAt=${status.startedAt}\u0026finishedAt=${status.finishedAt}"},{"name":"Sensor Logs Link","scope":"sensor-logs","url":"http://logging-facility?namespace=${metadata.namespace}\u0026podName=${metadata.name}\u0026startedAt=${status.startedAt}\u0026finishedAt=${status.finishedAt}"}]}
```

