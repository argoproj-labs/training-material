The Argo Server provides the API. This is secured using Kubernetes service accounts.

All endpoints can be found under `http://localhost:2746/api/v1` URL and typically require an access token.

Typically, it is good to be able to check you can access it first. This can be done using the info endpoint:

`curl http://localhost:2746/api/v1/info`{{execute}}

You should see something like:

```
controlplane $ curl http://localhost:2746/api/v1/info
{"managedNamespace":"argo",...
```

