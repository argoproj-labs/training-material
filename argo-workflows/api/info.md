The Argo Server provides the API. This is secured using Kubernetes service accounts.

All endpoints can be found under `http://localhost:2746/api/v1` URL and typically require an **access token**.

To access this via Killercoda, we need to port-forward the argo-server pod:

`kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &`{{execute}}

Note: Killercoda currently has issues port-forwarding. You may need to wait a few minutes for Killercoda to complete the port-forward.

Typically, it is good to be able to check you can access the API before using it. This can be done using the `info` endpoint:

`curl http://localhost:2746/api/v1/info`{{execute}}

You should see something like this if it is successful:

```bash
{"code":16,"message":"token not valid. see https://argo-workflows.readthedocs.io/en/latest/faq/"}
```

If it fails, then you'll see something like this:
```bash
curl: (7) Failed to connect to localhost port 2746: Connection refused
```

Note: If see a failure message, it is likely a Killercoda issue. You should try re-submitting the `kubectl -n argo port-forward` command listed above, and then repeat the steps to confirm your port-forward was successful before moving to the next section.

To connect, we need to set-up an **access token**.
