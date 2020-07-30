#! /bin/bash
# change host name
hostnamectl set-hostname Docker
# update cache and upgrade
yum update -y && yum upgrade -y
