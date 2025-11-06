#!/bin/bash

# install ansible
dnf install ansible -y

# ansible pull
# ansible-pull -U <repository_url> -d <destination_directory>
ansible-pull -U https://github.com/phanis-git/ansible-roboshop-roles-for-terraform-dev-infra.git -e component=mongodb main.yaml