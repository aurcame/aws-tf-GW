#! /bin/bash
hostnamectl set-hostname Ansible
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y epel-release-latest-7.noarch.rpm
yum update -y && yum upgrade -y
yum install -y git python python-devel python-pip openssl ansible tree mc

cd /home/ec2-user/

# cloning Graduation work repository
git clone https://github.com/aurcame/GW-cicd.git
cd GW-cicd/playbooks/

# run Ansible script for DevTools instance
ansible-playbook devtools.yaml -v

# run Ansible script for CI and QA instances
ansible-playbook qa_ci_docker.yml -v
