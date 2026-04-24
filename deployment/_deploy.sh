#!/usr/bin/env bash

set -e -x

kubectl apply -f ./configmap.yaml
kubectl apply -f ./coworking.yaml

sleep 30

kubectl get deployments
kubectl get services
kubectl get pods
