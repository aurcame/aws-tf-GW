#! /bin/bash
hostnamectl set-hostname Ansible
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y epel-release-latest-7.noarch.rpm
yum update -y && yum upgrade -y
yum install -y git python python-devel python-pip openssl ansible tree mc

# add dns names fo Jenkins and Nexus
echo "127.0.0.1       devtools.jenkins" >> /etc/hosts
echo "127.0.0.1       devtools.nexus" >> /etc/hosts

cd /home/ec2-user/

# cloning Graduation work repository
git clone https://github.com/aurcame/GW-cicd.git

# change permitions to ec2-user
chown -R ec2-user:ec2-user GW-cicd/
cd GW-cicd

# cat /home/dell/.ssh/awskey_frankfurt > /home/ec2-user/.ssh/awskey_frankfurt
#chmod 0600 /home/ec2-user/.ssh/awskey_frankfurt

# run Ansible script for DevTools instance
#ansible-playbook devtools.yaml -v

# run Ansible script for CI and QA instances
#ansible-playbook qa_ci_docker.yml -v
