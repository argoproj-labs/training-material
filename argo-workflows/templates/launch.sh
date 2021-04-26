until kubectl cluster-info; do sleep 3s; done

kubectl create ns argo
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml

curl -sLO https://github.com/argoproj/argo/releases/download/v3.0.2/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo
argo version

kubectl -n argo wait deploy --all --for condition=Available --timeout 2m
argo submit -n argo --watch https://raw.githubusercontent.com/argoproj/argo-workflows/master/examples/hello-world.yaml

kubectl -n argo port-forward --address 0.0.0.0 svc/argo-server 2746:2746 &
curl -kv https://localhost:2746/api/v1/info
