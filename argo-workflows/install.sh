#!/bin/bash
echo
echo "It typically takes between 1m and 2m to get Argo Workflows ready."
echo
echo "Any problems? Visit the repo to open an issue: https://github.com/argoproj-labs/training-material"
echo

echo "1. Installing Argo Workflows..."

ARGO_WORKFLOWS_VERSION='v3.6.2'

kubectl create ns argo >/dev/null
kubectl config set-context --current --namespace=argo >/dev/null
kubectl apply -f https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/install.yaml >/dev/null
kubectl apply -f https://raw.githubusercontent.com/argoproj-labs/training-material/main/config/minio/minio.yaml >/dev/null
kubectl apply -f https://raw.githubusercontent.com/argoproj-labs/training-material/main/config/argo-workflows/canary-workflow.yaml >/dev/null
kubectl apply -f https://raw.githubusercontent.com/argoproj-labs/training-material/main/config/argo-workflows/patchpod.yaml >/dev/null
kubectl apply -f https://raw.githubusercontent.com/argoproj-labs/training-material/main/config/argo-workflows/workflows-controller-configmap.yaml >/dev/null
cat <<EOF | kubectl apply -f - >/dev/null
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: executor
rules:
  - apiGroups:
      - argoproj.io
    resources:
      - workflowtaskresults
    verbs:
      - create
      - patch
---
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
  name: argo
  namespace: argo
EOF

echo "2. Installing Argo CLI..."

curl -sLO https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo

echo "3. Starting Argo Server..."

if [ "${AUTHCLIENT:-0}" -eq 1 ]; then
	echo "Setting Argo Server to Client Auth..."
	kubectl patch deployment \
		argo-server \
		--namespace argo \
		--type='json' \
		-p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
            "server",
            "--auth-mode=client",
            "--secure=false"
    ]},
    {"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": "HTTP"},
    {"op": "add", "path": "/spec/template/spec/containers/0/env", "value": [
      { "name": "FIRST_TIME_USER_MODAL", "value": "false" },
      { "name": "FEEDBACK_MODAL", "value": "false" },
      { "name": "NEW_VERSION_MODAL", "value": "false" }
    ]}
    ]' >/dev/null

else
	echo "Setting Argo Server to Server Auth..."
	# To reduce confusion when following the courses, we suppress the modals.
	kubectl patch deployment \
		argo-server \
		--namespace argo \
		--type='json' \
		-p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
            "server",
            "--auth-mode=server",
            "--secure=false"
    ]},
    {"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": "HTTP"},
    {"op": "add", "path": "/spec/template/spec/containers/0/env", "value": [
      { "name": "FIRST_TIME_USER_MODAL", "value": "false" },
      { "name": "FEEDBACK_MODAL", "value": "false" },
      { "name": "NEW_VERSION_MODAL", "value": "false" }
    ]}
    ]' >/dev/null

	kubectl wait deploy/argo-server --for condition=Available --timeout 2m >/dev/null
fi

echo "4. Waiting for the Workflow Controller to be available..."
kubectl rollout restart deployment workflow-controller >/dev/null
kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m >/dev/null

echo
echo "Ready"
