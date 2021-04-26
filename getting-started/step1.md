Argo is normally installed into a namespace named `argo`, so create that

```
kubectl create ns argo
```

Next, you can apply a quick-start manifest:

```
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-minimal.yaml
```

It can take a few minutes to pull the images, so you can wait until this is complete by watching the pods:

```
kubectl get pod --watch
```