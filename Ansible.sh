#! /bin/bash
hostnamectl set-hostname Ansible
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y epel-release-latest-7.noarch.rpm
yum update -y && yum upgrade -y
yum install -y git python python-devel python-pip openssl ansible
cd ~

# cloning Graduation work repository
git clone https://github.com/aurcame/GW-cicd.git

# run Ansible script for DEvTools instance
GW-cicd/playbooks/ansible-playbook devtools.yaml -v

# run Ansible script for CI and QA instances
GW-cicd/playbooks/ansible-playbook qa_ci_docker.yml -v
