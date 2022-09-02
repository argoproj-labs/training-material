#!/bin/bash

kubectl -n argo get deploy workflow-controller
kubectl -n argo get deploy argo-server