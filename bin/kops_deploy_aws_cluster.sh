#!/bin/bash
echo "Deploy simple echoserver to cluster"
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port 8080
kubectl expose deployment hello-minikube --type=NodePort
kubectl get service
