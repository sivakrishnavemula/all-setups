#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc


#! /bin/bash
aws configure
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

aws s3api create-bucket --bucket siva.k8s.local --region us-east-1
aws s3api put-bucket-versioning --bucket cloudanddevopsbyraham0073456.k8s.local --region us-east-1 --versioning-configuration Status=Enabled
export KOPS_STATE_STORE=s3://sivakrishna.flm.k8s.local
kops create cluster --name siva.k8s.local --zones us-east-1a,us-east-1b --master-size t2.medium --master-count 1 --master-volume-size 30 --node-size t2.micro --node-count 2 --node-volume-size 25
kops update cluster --name siva.k8s.local --yes --admin


#Suggestions:
 #* validate cluster: kops validate cluster --wait 10m
 #* list nodes: kubectl get nodes --show-labels
 #* ssh to a control-plane node: ssh -i ~/.ssh/id_rsa ubuntu@
 #* the ubuntu user is specific to Ubuntu. If not using Ubuntu please use the appropriate user based on your OS.
 #* read about installing addons at: https://kops.sigs.k8s.io/addons.


