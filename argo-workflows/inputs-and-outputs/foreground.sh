curl -s https://raw.githubusercontent.com/alexec/katacoda-scenarios/master/argo-workflows/install.sh|sh

echo "5. Waiting for MinIO to be available..."

kubectl wait deploy/workflow-controller --for condition=Available --timeout 2m > /dev/null