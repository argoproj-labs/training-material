You can find API docs in the user interface, try it now:

<!-- markdown-link-check-disable-next-line -->
[Open the API docs]({{TRAFFIC_HOST1_2746}}/apidocs)

You can use the API docs to send API requests, so it is really useful to test things out.

But you were asked for a password weren't you?

Use your `ARGO_TOKEN` as a password:

`echo $ARGO_TOKEN`{{execute}}

Copy the whole response, including `Bearer`, and paste it into the white box in the center of the Argo UI Login page where it says "client authentication".

Once you're logged in, you may need to click to open the API docs again:

<!-- markdown-link-check-disable-next-line -->
[Open the API docs]({{TRAFFIC_HOST1_2746}}/apidocs)

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
