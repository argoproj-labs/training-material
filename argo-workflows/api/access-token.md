If you want to automate tasks with the Argo Server API or CLI, you will need an **access token**. An access token is
just a Kubernetes service account token. So, to set up a service account for our automation, we need to create:

* A **role** with the permission we want to use.
* A **service account** for our automation user.
* A **role binding** to bind the role to the service account:

In our example, we want to create a role for Jenkins to use that can create, get and list workflows:

Create the role:

`kubectl create role jenkins --verb=create,get,list --resource=workflows.argoproj.io`{{execute}}

Create the service account:

`kubectl create sa jenkins`{{execute}}

Bind the service account to the role:

`kubectl create rolebinding jenkins --role=jenkins --serviceaccount=argo:jenkins`{{execute}}

Now we can get the name of the secret:

`SECRET=$(kubectl get sa jenkins -o=jsonpath='{.secrets[0].name}')`{{execute}}

Then we can get the secret and base-64 encode it:

`ARGO_TOKEN="Bearer $(kubectl get secret $SECRET -o=jsonpath='{.data.token}' | base64 --decode)"`{{execute}}

Print out the token:

`echo $ARGO_TOKEN`{{execute}}

You should something like :

```
Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6...
```

To use the token, you add it as an `Authorization` header to you HTTP request:

`curl http://localhost:2746/api/v1/info -H "Authorization: $ARGO_TOKEN"`{{execute}}

You should see something like:

```
{"managedNamespace":"argo"...
```
