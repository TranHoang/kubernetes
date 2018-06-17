#!/usr/bin/env bash
APP_NAME="helloworld"

# Get the devops application folder path
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
APP_DEVOPS_FOLDER="$(dirname "$SCRIPTPATH")/devops/$APP_NAME"

kubectl create -f $APP_DEVOPS_FOLDER/deployment.yml --record
kubectl rollout status deployment/$APP_NAME-deployment
kubectl get deployments