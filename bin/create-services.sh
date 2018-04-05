#!/usr/bin/env bash
APP_NAME="helloworld"

# Get the devops helloworld folder path
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
APP_DEVOPS_FOLDER="$(dirname "$SCRIPTPATH")/devops/$APP_NAME"

kubectl create -f $APP_DEVOPS_FOLDER/$APP_NAME"_"service.yml
