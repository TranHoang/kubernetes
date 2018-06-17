#!/usr/bin/env bash

APP_NAME="helloworld"
tag_name=$1

# Get the src folder path
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
APP_SRC_FOLDER="$(dirname "$SCRIPTPATH")/src/$APP_NAME"

if [ -z "$tag_name" ]; then 
    echo "Tag image at latest";
    tag_name='latest'
else 
    echo "Tag image at $tag_name";
fi
docker build -t tranhoangnguyen/$APP_NAME:$tag_name $APP_SRC_FOLDER