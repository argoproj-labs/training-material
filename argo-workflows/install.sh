echo
echo "It typically takes between 1m and 2m to get Argo Workflows ready."
echo
echo "Any problems? Visit the repo to open an issue: https://github.com/pipekit/argo-workflows-intro-course/"
echo

echo "1. Installing Argo Workflows..."

kubectl create ns argo > /dev/null
kubectl config set-context --current --namespace=argo > /dev/null
kubectl apply -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.0/install.yaml > /dev/null
kubectl apply -f https://raw.githubusercontent.com/pipekit/argo-workflows-intro-course/master/config/argo-workflows/canary-workflow.yaml > /dev/null
kubectl apply -f https://raw.githubusercontent.com/pipekit/argo-workflows-intro-course/master/config/minio/minio-deploy.yaml  > /dev/null
kubectl apply -f https://raw.githubusercontent.com/pipekit/argo-workflows-intro-course/master/config/argo-workflows/workflows-controller-configmap.yaml > /dev/null
# kubectl scale deploy/workflow-controller --replicas 1 > /dev/null

echo "2. Installing Argo CLI..."

curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.4.0/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo

echo "3. Starting Argo Server..."

kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server",
  "--secure=false"
]},
{"op": "replace", "path": "/spec/template/spec/containers/0/readinessProbe/httpGet/scheme", "value": "HTTP"}
]' > /dev/null

kubectl wait deploy/argo-server --for condition=Available --timeout 2m > /dev/null

echo "4. Waiting for the Workflow Controller to be available..."
kubectl rollout restart deployment workflow-controller  > /dev/null
kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m > /dev/null

if [ "${MINIO:-0}" -eq 1 ]; then
  echo "5. Waiting for MinIO to be available..."

  kubectl scale deploy/minio --replicas 1 > /dev/null
  kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m > /dev/null
fi

## I don't really know what this is for (yet?)
if [ "${CANARY:-0}" -eq 1 ]; then
  echo "6. Waiting for canary workflow to be deleted..."
  kubectl wait workflow/canary --for delete--timeout 2m > /dev/null
fi

echo
echo "Ready"
