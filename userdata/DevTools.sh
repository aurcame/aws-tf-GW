#! /bin/bash
# change host name
hostnamectl set-hostname DevTools
# update cache and upgrade
yum update -y && apt-get update -y
