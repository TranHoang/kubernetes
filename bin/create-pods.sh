#!/usr/bin/env bash
APP_NAME="helloworld"

# Get the devops helloworld folder path
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
APP_SRC_FOLDER="$(dirname "$SCRIPTPATH")/devops/$APP_NAME"

kubectl create -f $APP_SRC_FOLDER/$APP_NAME"_"pod.yml