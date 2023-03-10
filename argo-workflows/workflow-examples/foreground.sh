curl -s https://raw.githubusercontent.com/pipekit/argo-workflows-intro-course/master/argo-workflows/install.sh|sh

curl -sLO https://github.com/argoproj/argo-workflows/releases/download/v3.4.5/argo-linux-amd64.gz
gunzip argo-linux-amd64.gz
chmod +x argo-linux-amd64
mv ./argo-linux-amd64 /usr/local/bin/argo

git clone https://github.com/argoproj/argo-workflows.git
mv argo-workflows/examples/ .
rm -rf argo-workflows
