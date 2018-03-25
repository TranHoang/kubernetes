# Kubernetes Demo

## Setup vagrant

1. Pull the source code

```bash
git clone https://github.com/TranHoang/kubernetest.git
vagrant up
vagrant ssh
```

## Use kops to deploy a simple echoserver to AWS. Following these steps to create a micro cluster with one master and one node

1. Config enviroment variable

```folder structure
kubernetes
└───bin
│   │   kops_create_aws_cluster.sh
│   │   kops_deploy_aws_cluster.sh
└───env
│   │   aws_rsa.pub
│   │   aws.env
│   │   cluster.env
│   README.md
│   setup.sh
|   Vagrantfile
```

* aws_rsa.pub     kops use public key to create the cluster on AWS
* aws.env         AWS enviroment variable

    ```env
    AWS_ACCESS_KEY_ID="AWS Access key id goes here."
    AWS_SECRET_ACCESS_KEY="AWS secret access key goes here."
    S3_BUCKET_NAME="kops use this bucketname to store the cluster state."
    AWS_AVAILABE_ZONE_NAME="AWS region availability-zones. Example: ap-southeast-1a."
    ```
* cluster.env     AWS enviroment variable

    ```env
    CLUSTER_NAME="kops need a cluster name to deploy. It's also a domain name."
    ```

2. Config AWS Route 53

3. Config DNS in the domain panel

4. Create 1 micro cluster

```bash
cd /kubernetes/bin
chmod +x kops_create_aws_cluster.sh
./kops_create_aws_cluster.sh
```

5. Wait for a few minutes then check the cluster is ready for deployment

```bash
kops validate cluster --state=s3://kops-state-b24b
```

6. Once the cluster is up, master and node are ready then run the scrips below to deploy a simple echoserver to AWS

```bash
cd /kubernetes/bin
chmod +x kops_deploy_aws_cluster.sh
./kops_deploy_aws_cluster.sh
```

## Reference Link

* [Kops deploy to AWS](https://github.com/kubernetes/kops/blob/master/docs/aws.md)
* [Kops deploy to AWS Tips and tricks](https://cloudonaut.io/6-tips-and-tricks-for-aws-command-line-ninjas/)