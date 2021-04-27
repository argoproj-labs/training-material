launch.sh

kubectl create ns argo
kubectl config set-context --current --namespace=argo
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml

curl -sLO https://github.com/argoproj/argo/releases/download/v3.0.2/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo
argo version

kubectl wait deploy --all --for condition=Available --timeout 2m

kubectl port-forward --address 0.0.0.0 svc/argo-server 2746:2746 > /dev/null &
