# Kubernetes / Kops Demo

## Setup vagrant

1. Pull the source code

```bash
git clone https://github.com/TranHoang/kubernetes.git
vagrant up
vagrant ssh
```

## Use kops to deploy a simple echoserver to AWS

Following these steps to create a micro cluster with one master and one node on AWS

1. Config enviroment variable

```folder structure
kubernetes
└───bin
│   │   create_aws_cluster.sh
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

    Create a public hosted zones in [AWS Route 53](https://console.aws.amazon.com/route53/home?region=us-west-2#)

3. Config DNS in the domain panel
    Added NS Record with host name is the AWS Route 53 values. For example
    ![DNS](https://raw.githubusercontent.com/TranHoang/kubernetes/master/images/DNS.png)

4. Create 1 micro cluster

```bash
./bin/create_aws_cluster.sh
```

5. Wait for a few minutes then check the cluster is ready for deployment

```bash
kops validate cluster --state=s3://kops-state-b24b
```

6. Once the cluster is up, master and node are ready then run the scrips below to deploy a simple echoserver to AWS

```bash
kubectl run hello-minikube --image=gcr.io/google_containers/echoserver:1.4 --port 8080
kubectl expose deployment hello-minikube --type=NodePort
kubectl get service
```

## Create helloworld pod on minukube

1. Start minikube cluster

```bash
minikube start
```

2. Build the helloworld image

```bash
./bin/build_image.sh
./bin/push_image.sh
```

3. Create pod on minikube

```bash
./bin/create_pods.sh
```

4. Verify pod status

```bash
kubectl describe pod helloworld.example.com
```

5. There are 2 ways to expose the pod

5.1 Forward pod's port then we can access via localhost

```bash
kubectl port-forward helloworld.example.com 8081:3000
curl http://localhost:8081
```

5.2 Create a service

```bash
kubectl expose pod helloworld.example.com --type=NodePort --name helloworld-service
minikube service helloworld-service --url
```

## Create helloworld pod on AWS

1. Build the helloworld image

```bash
./bin/build_image.sh
./bin/push_image.sh
```

2. Create a cluster

```bash
./bin/create-aws-cluster.sh
```

3. Check cluster status

```bash
./bin/validate-cluster.sh
```

4. Once the cluster is up, master and node are ready then we deploy the helloworld application cluster

```bash
./bin/create-pods.sh
./bin/create-services.sh
```

5. Create an alias record set in hosted zones and select the load balancing service in the Alias Target dropdown.

![DNS](https://raw.githubusercontent.com/TranHoang/kubernetes/master/images/hosted-zone-alias-record-set.png)

6. Access the [http://helloworld.kubernetes.fullstack.ws](http://helloworld.kubernetes.fullstack.ws/)

## Deploy helloworld by k8s deployment

```bash
./bin/deploy.sh
kubectl expose deployment helloworld-deployment --type=NodePort
minikube service helloworld-deployment --url
```

## Reference Link

* [Kops deploy to AWS](https://github.com/kubernetes/kops/blob/master/docs/aws.md)
* [Kops deploy to AWS Tips and tricks](https://cloudonaut.io/6-tips-and-tricks-for-aws-command-line-ninjas/)

## Useful command

1. Attach to a process that is already running inside an existing container.

```bash
kubectl attach {POD_NAME} -c [CONTAINER_NAME]
```

2. Execute a shell in a container inside a pod

```bash
kubectl exec -it {POD_NAME} -c [CONTAINER_NAME] -- /bin/bash
```

3. Describe a service

```bash
kubectl describe {SERVICE_NAME}
```

4. Update an image for a specific container in a deployment

```bash
./bin/deploy-update-image.sh -c [CONTAINER_NAME] -i [Docker hub image uri]
```

Example
```
./bin/deploy-update-image.sh -c k8s-demo -i tranhoang/helloworld:2.0
```

## Tips:

1. Grant permission for vagrant ubuntu user to execute the docker. Execute the following command then re-ssh to the vagrant box

```bash
sudo usermod -a -G docker $USER
```
