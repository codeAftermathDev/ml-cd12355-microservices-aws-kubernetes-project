#!/usr/bin/env bash

set -e -x

kubectl apply -f ./pv.yaml
kubectl apply -f ./pvc.yaml

set +x # Suppress output for envsubst to avoid exposing the password in logs
echo "Deploying PostgreSQL database ..."
DB_PASSWORD=${PASSWORD} envsubst < ./postgresql-deployment.yaml | kubectl apply -f -

set -x

kubectl apply -f ./postgresql-service.yaml

sleep 10

kubectl get deployments
kubectl get services
kubectl get pods
