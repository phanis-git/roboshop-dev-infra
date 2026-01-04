#!/bin/bash

growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform


cd /home/ec2-user
git clone https://github.com/phanis-git/roboshop-dev-infra.git
chown ec2-user:ec2-user -R roboshop-dev-infra

cd roboshop-dev-infra/40-databases
terraform init
terraform apply -auto-approve





# # newcode

# # --- Expand home partition ---
# growpart /dev/nvme0n1 4
# lvextend -L +30G /dev/mapper/RootVG-homeVol
# xfs_growfs /home

# # --- Install Terraform ---
# sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
# sudo yum -y install terraform

# # --- Clone repo as ec2-user (important!) ---
# cd /home/ec2-user
# sudo -u ec2-user git clone https://github.com/phanis-git/roboshop-dev-infra.git

# # --- Fix ownership (extra safety) ---
# sudo chown -R ec2-user:ec2-user /home/ec2-user/roboshop-dev-infra

# # --- Run Terraform as ec2-user ---
# sudo -u ec2-user bash -c '
# cd /home/ec2-user/roboshop-dev-infra/40-databases
# terraform init
# terraform apply -auto-approve
# '
