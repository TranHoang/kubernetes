#!/usr/bin/env bash

APP_NAME="helloworld"

# Get the src folder path
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
APP_SRC_FOLDER="$(dirname "$SCRIPTPATH")/src/$APP_NAME"

docker build -t tranhoang/$APP_NAME $APP_SRC_FOLDER
