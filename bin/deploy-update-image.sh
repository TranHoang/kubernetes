#!/usr/bin/env bash

usage="$(basename "$0") update an image for a deployment

Options:
    -h  show this help text
    -c  container name which defined in the deployment yml
    -i  docker image uri

Examples:
    # Use tranhoang/helloworld:2.0 for k8s-demo deployment
    $(basename "$0") -c k8s-demo -i tranhoangnguyen/helloworld:2.0"

# Read container and image name
while getopts ":hc:i:" opt; do
  case $opt in
    h) echo "$usage"
        exit
        ;;
    c) container_name="$OPTARG"
        ;;
    i) img_name="$OPTARG"
        ;;
    \?) echo "Invalid option -$OPTARG" >&2
        ;;
  esac
done
shift $((OPTIND-1))

if [[ $container_name ]] && [[ $img_name ]]; then
    APP_NAME="helloworld"
    # Get the devops folder path
    SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
    APP_DEVOPS_FOLDER="$(dirname "$SCRIPTPATH")/devops/$APP_NAME"
    kubectl set image deployment/$APP_NAME-deployment $container_name=$img_name --record
    kubectl rollout status deployment/$APP_NAME-deployment
else
    echo "Container name and image name are not provided. Please run with -h options to display help."
fi
