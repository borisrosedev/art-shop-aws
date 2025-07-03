#!/bin/bash
set -e
yum update -y
# Ansible needs Python3
yum install -y python3
systemctl enable sshd
systemctl start sshd
echo "READY_FOR_ANSIBLE" > /etc/motd