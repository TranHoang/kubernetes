#!/usr/bin/env bash

# Get the src folder path
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
ROOT_FOLDER="$(dirname "$SCRIPTPATH")"

if aws iam get-user --user-name kops --output text | grep kops1; then
    echo 'Found'
else
    aws iam create-group --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRoute53FullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/IAMFullAccess --group-name kops
    aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name kops

    aws iam create-user --user-name kops

    aws iam add-user-to-group --user-name kops --group-name kops

    aws iam create-access-key --user-name kops
fi


if aws s3api list-buckets --query "Buckets[].Name" --output text | grep kops-state-b24; then
    echo "$S3_BUCKET_NAME has been created."
else
    echo "Create S3 bucket $S3_BUCKET_NAME to manage the cluster state"
    aws s3api create-bucket \
    --bucket $S3_BUCKET_NAME \
    --region $AWS_AVAILABE_ZONE_NAME
fi
    

echo "Create 1 cluster with 1 micro master and 1 micro node"
kops create cluster \
--name=$CLUSTER_NAME \
--state=s3://$S3_BUCKET_NAME \
--zones=$AWS_AVAILABE_ZONE_NAME \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--dns-zone=$CLUSTER_NAME \
--ssh-public-key=$ROOT_FOLDER/env/aws_rsa.pub

kops update cluster $CLUSTER_NAME --yes --state=s3://$S3_BUCKET_NAME


