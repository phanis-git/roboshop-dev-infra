#!/bin/bash

# Hard coaded

# install ansible command below
# dnf install ansible -y

# ansible pull implementing
# ansible-pull -U <repository_url> -d <destination_directory>

# ansible-pull -U https://github.com/phanis-git/ansible-roboshop-roles-for-terraform-dev-infra.git -e component=mongodb main.yaml



# dynamically
component=$1
env=$2
dnf install ansible -y
# ansible-pull -U https://github.com/phanis-git/ansible-roboshop-roles-for-terraform-dev-infra.git -e component=$component main.yaml


REPO_URL=https://github.com/phanis-git/ansible-roboshop-roles-for-terraform-dev-infra.git

REPO_DIR=/opt/roboshop/ansible

ANSIBLE_DIR=ansible-roboshop-roles-for-terraform-dev-infra

mkdir -p $REPO_DIR
mkdir -p /var/log/roboshop/
touch ansible.log

cd $REPO_DIR

# check if ansible dir is already cloned or not
if [ -d $ANSIBLE_DIR ]; then
    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi

ansible-playbook -e component=$component -e environment=$env main.yaml