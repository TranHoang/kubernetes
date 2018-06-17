#!/usr/bin/env bash
APP_NAME="helloworld"
tag_name=$1

if [ -z "$tag_name" ]; then 
    echo "Tag image at latest";
    tag_name='latest'
else 
    echo "Tag image at $tag_name";
fi
docker push tranhoangnguyen/$APP_NAME:$tag_name