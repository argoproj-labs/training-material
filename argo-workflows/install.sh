launch.sh

echo ">>> Installing Argo Workflows"

kubectl create ns argo
kubectl config set-context --current --namespace=argo
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml > /dev/null
kubectl scale deploy/minio --replicas 0
kubectl scale deploy/argo-server --replicas 0

echo ">>> Installing Argo CLI"

curl -sLO https://github.com/argoproj/argo/releases/download/v3.0.2/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo

echo ">>> Starting Argo Server"

argo server --managed-namespace --auth-mode=server --secure=false > server.log 2>&1 &

echo ">>> Waiting for the Workflow Controller to be available"

kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m
kubectl scale deploy/minio --replicas 1

echo ">>> Ready"