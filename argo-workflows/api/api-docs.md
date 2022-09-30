You can find API docs in the user interface, try it now:

[Open the API docs](https://[[HOST_SUBDOMAIN]]-2746-[[KATACODA_HOST]].environments.katacoda.com/apidocs)

You can use the API docs to send API requests, so it is really useful to test things out.

But you were asked for a password weren't you?

You can use your `ARGO_TOKEN` as a password.

`echo $ARGO_TOKEN`{{execute}}

## Exercise

Open the API docs and find an endpoint to create workflow templates. Create a workflow template and then submit it.

## More API documentation
Visit the Argo Workflows documentation for more information:
- [Argo Workflows API](https://argoproj.github.io/argo-workflows/rest-api/)
- [Access Tokens](https://argoproj.github.io/argo-workflows/access-token/)
- [API examples](https://argoproj.github.io/argo-workflows/rest-examples/)
- [API reference (Swagger docs)](https://argoproj.github.io/argo-workflows/swagger/)
- [Client libraries for Python, Golang, and Java](https://argoproj.github.io/argo-workflows/client-libraries/)
- [Argo Server](https://argoproj.github.io/argo-workflows/argo-server/)
