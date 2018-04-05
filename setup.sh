# Install docker
sudo apt-get install docker.io --yes

#Install python-pip
sudo apt-get install software-properties-common
sudo apt-add-repository universe
sudo apt-get update
sudo apt-get install python-pip --yes

echo "Install awscli"
sudo pip install awscli

# Install Kops
wget https://github.com/kubernetes/kops/releases/download/1.8.1/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# Set up Kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo mv kubectl /usr/local/bin/
sudo chmod +x /usr/local/bin/kubectl

# Load AWS enviroment variable
set -o allexport; source /k8s/env/aws.env; source /k8s/env/cluster.env; set +

# Alow ubuntu user can run docker command
sudo usermod -a -G docker $USER