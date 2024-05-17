#!/bin/bash
set -ex

#我们用的containerd作为默认运行时，所以修改containerd的部分
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-yum-or-dnf
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo

sudo yum install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=containerd --set-as-default
sudo systemctl restart containerd