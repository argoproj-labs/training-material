launch.sh

echo
echo "It typically between 1m and 2m to get Argo Workflows ready."
echo
echo "Any problems? Raise an issue: https://github.com/alexec/katacoda-scenarios/issues/new"
echo

echo "1. Installing Argo Workflows..."

kubectl create ns argo > /dev/null
kubectl config set-context --current --namespace=argo > /dev/null
kubectl apply -f https://raw.githubusercontent.com/alexec/katacoda-scenarios/master/config/argo-workflows.yaml > /dev/null
kubectl scale deploy/workflow-controller --replicas 1 > /dev/null

echo "2. Installing Argo CLI..."

curl -sLO https://github.com/argoproj/argo/releases/download/v3.0.2/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo

echo "3. Starting Argo Server..."

argo server --namespaced --auth-mode=server --secure=false > server.log 2>&1 &

echo "4. Waiting for the Workflow Controller to be available..."

kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m > /dev/null

if [ "${MINIO:-0}" -eq 1 ]; then
  echo "5. Waiting for MinIO to be available..."

  kubectl scale deploy/minio --replicas 1 > /dev/null
  kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m > /dev/null
fi

echo
echo "Ready"
