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

echo "Create 1 cluster with 1 micro master and 1 micro node"
kops create cluster \
--name=kubernetes.fullstack.ws \
--state=s3://kops-state-b24b \
--zones=ap-southeast-1a \
--node-count=1 \
--node-size=t2.micro \
--master-size=t2.micro \
--dns-zone=kubernetes.fullstack.ws \
--ssh-public-key=./aws_rsa.pub

kops update cluster kubernetes.fullstack.ws --yes --state=s3://kops-state-b24b


