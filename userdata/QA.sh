#! /bin/bash
# change host name
hostnamectl set-hostname QA
# update cache and upgrade
yum update -y && yum upgrade -y
