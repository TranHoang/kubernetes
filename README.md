# Kubernetes Demo

## Setup vagrant

1. Pull the source code

```bash
git clone https://github.com/TranHoang/kubernetest.git
vagrant up
vagrant ssh
```

## Use kops to deploy a simple echoserver to AWS. Following these steps to create a micro cluster with one master and one node

1. Create S3 bucket

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