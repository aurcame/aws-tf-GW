#! /bin/bash
# change host name
hostnamectl set-hostname CI
# update cache and upgrade
yum update -y && yum upgrade -y
