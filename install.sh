launch.sh
kubectl create ns argo
kubectl config set-context --current --namespace=argo
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml
kubectl scale deploy/minio --replicas 0
kubectl scale deploy/argo-server --replicas 0

curl -sLO https://github.com/argoproj/argo/releases/download/v3.0.2/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo
argo server > /dev/null &

kubectl wait deploy --all --for condition=Available --timeout 2m
