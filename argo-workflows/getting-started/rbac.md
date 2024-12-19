All pods in a workflow run with the service account specified in `workflow.spec.serviceAccountName`, or if omitted, the default service account of the workflow's namespace. The amount of access which a workflow needs is dependent on what the workflow needs to do. For example, if your workflow needs to deploy a resource, then the workflow's service account will require 'create' privileges on that resource.

We do not recommend using the default service account in production. It is a shared account so may have permissions added to it you do not want. Instead, create a service account only for your workflow. So let's create a service account named `argo-workflow` in the `argo` namespace.

```bash
kubectl create serviceaccount argo-workflow -n argo
```{{execute}}

Then we create a clusterRole that allows the Argo workflow executor to create and patch workflow task results (the minimum require permissions for a successful workflow execution). Workflow Task Results are used to manage the progress of a workflow throughout its lifecycle.

```bash
cat <<EOF | kubectl apply -f - >/dev/null
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: workflow-executor-rbac
rules:
  - apiGroups:
      - argoproj.io
    resources:
      - workflowtaskresults
    verbs:
      - create
      - patch
EOF
```{{execute}}

Then we'll bind this clusterRole to the Argo service account. If you want namespace-level isolation, you can create a namespace-level role and role binding instead.

```bash
cat <<EOF | kubectl apply -f - >/dev/null
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: argo-executor-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: executor
subjects:
- kind: ServiceAccount
  name: argo-workflow
  namespace: argo
EOF
```{{execute}}

In the next step, we will use this service account in our workflow.
