#!/bin/bash

# dynamically
component=$1
env=$2
dnf install ansible -y

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

ansible-playbook -e component=$component -e env=$env main.yaml