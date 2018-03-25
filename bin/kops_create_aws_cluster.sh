#!/bin/bash
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


echo "Create S3 bucket"
aws s3api create-bucket \
    --bucket $S3_BUCKET_NAME \
    --region us-east-1

echo "Create 1 cluster with 1 micro master and 1 micro node"
kops create cluster \
--name=$CLUSTER_NAME \
--state=$S3_BUCKET_NAME \
--zones=$AWS_AVAILABE_ZONE_NAME \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--dns-zone=$CLUSTER_NAME \
--ssh-public-key=./aws_rsa.pub

kops update cluster $CLUSTER_NAME --yes --state=$S3_BUCKET_NAME


