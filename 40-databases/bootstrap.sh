#!/bin/bash

# Hard coaded

# install ansible command below
# dnf install ansible -y

# ansible pull implementing
# ansible-pull -U <repository_url> -d <destination_directory>

# ansible-pull -U https://github.com/phanis-git/ansible-roboshop-roles-for-terraform-dev-infra.git -e component=mongodb main.yaml



# dynamically
component=$1
dnf install ansible -y
ansible-pull -U https://github.com/phanis-git/ansible-roboshop-roles-for-terraform-dev-infra.git -e component=$component main.yaml

