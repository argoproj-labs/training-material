# Get files
wget https://raw.githubusercontent.com/tico24/argo-workflows-intro-course/master/config/argo-events/minio-eventsource.yaml
wget https://raw.githubusercontent.com/tico24/argo-workflows-intro-course/master/config/argo-events/minio-secret.yaml
wget https://raw.githubusercontent.com/tico24/argo-workflows-intro-course/master/config/argo-events/minio-sensor.yaml
wget https://raw.githubusercontent.com/tico24/argo-workflows-intro-course/master/config/argo-events/sa.yaml

# Install the minio client
curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o /root/mc

chmod +x /root/mc
export PATH=$PATH:/root/

# # Minio
# kubectl create namespace minio
# #kubectl apply -f https://raw.githubusercontent.com/pipekit/argo-workflows-intro-course/master/config/minio-events/ -n minio
# kubectl apply -f https://raw.githubusercontent.com/tico24/argo-workflows-intro-course/master/config/minio-events/ -n minio
