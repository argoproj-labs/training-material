To run workflows, the easiest way is to use the Argo CLI, you can download it as follows:

    curl -sLO https://github.com/argoproj/argo/releases/download/v2.12.11/argo-linux-amd64.gz
    gunzip argo-linux-amd64.gz
    chmod +x argo-linux-amd64
    mv ./argo-linux-amd64 /usr/local/bin/argo{{execute}}

To check it is installed correctly:

`argo version`{{execute}}
