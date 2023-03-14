git clone https://github.com/pipekit/large-workflow-example.git --depth 1 -q
mv large-workflow-example/bootstrap/ . > /dev/null
rm -rf large-workflow-example > /dev/null

kubectl create namespace minio
kubectl apply -f bootstrap/minio/ -n minio


# Install the minio client
apt install -y mc
