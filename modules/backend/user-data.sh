#!/bin/bash
set -e
yum update -y
yum install -y python3
systemctl enable sshd
systemctl start sshd
