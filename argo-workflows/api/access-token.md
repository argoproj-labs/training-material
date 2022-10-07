If you want to automate tasks with the Argo Server API or CLI, you will need an **access token**. An access token is
just a Kubernetes service account token. So, to set up a service account for our automation, we need to create:

* A **role** with the permission we want to use.
* A **service account** for our automation user.
* A **service account token** for our service account.
* A **role binding** to bind the role to the service account.

In our example, we want to create a role for Jenkins so it can create, get and list workflows:

Create the role:

`kubectl create role jenkins --verb=create,get,list --resource=workflows.argoproj.io --resource=workfloweventbindings --resource=workflowtemplates`{{execute}}

Create the service account:

`kubectl create sa jenkins`{{execute}}

Bind the service account to the role:

`kubectl create rolebinding jenkins --role=jenkins --serviceaccount=argo:jenkins`{{execute}}

Now we can create a token:

`ARGO_TOKEN="Bearer $(kubectl create token jenkins)"`{{execute}}

Print out the token:

`echo $ARGO_TOKEN`{{execute}}

You should see something like the following:

```
Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6...
```

To use the token, you add it as an `Authorization` header to your HTTP request:

`curl http://localhost:2746/api/v1/info -H "Authorization: $ARGO_TOKEN"`{{execute}}

You should see something like the following:

```
{"modals":{"feedback":true,"firstTimeUser":true,"newVersion":true}}...
```

Now you are ready to create an Argo Workflow using the API.
