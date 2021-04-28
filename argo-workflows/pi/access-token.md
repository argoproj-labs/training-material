If you want to automate tasks with the Argo Server API or CLI, you will need an **access token**. An access token is
just a Kubernetes service account token. So, to set up a service account for our automation, we need to create:

* A **role** with the permission we want to use.
* A **service account** for our automation user.
* A **role binding** to bind the role to the service account:

Create the role:

`kubectl create role jenkins --verb=list,update --resource=workflows.argoproj.io`{{execute}}

Create the service account:

`kubectl create sa jenkins`{{execute}}

Bind the service account to the role:

`kubectl create rolebinding jenkins --role=jenkins --serviceaccount=argo:jenkins`{{execute}}

Now we can get the token:

`SECRET=$(kubectl get sa jenkins -o=jsonpath='{.secrets[0].name}')`{{execute}}
`ARGO_TOKEN="Bearer $(kubectl get secret $SECRET) -o=jsonpath='{.data.token}' | base64 --decode)"`
{{execute}}

You should see:

```
TODO
```

`curl https://localhost:2746/api/v1/workflows/argo -H "Authorization: $ARGO_TOKEN"`{{execute}}

You should see something like:

```
TODO
```

You should also check you cannot do what you're not allowed:

`curl https://localhost:2746/api/v1/workflow-templates/argo -H "Authorization: $ARGO_TOKEN"`{{execute}}

You should see

```
TODO
```
