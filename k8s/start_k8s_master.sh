#!/bin/bash
set -ex

hostnamectl set-hostname master


# 最好是公网ip
ip_str=`ifconfig eth0 | grep 'inet ' | awk '{print $2}'`
sudo kubeadm init \
  --apiserver-advertise-address=$ip_str \
  --image-repository registry.aliyuncs.com/google_containers \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16 \
  --ignore-preflight-errors=all

# 配置授权信息
# 所需的命令在init成功后也会有提示，主要是为了保存相关的配置信息在用户目录下，这样不用每次都输入相关的认证信息。
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#看看状态
kubectl get nodes
#下面这个就是我们的master
#NAME            STATUS     ROLES           AGE     VERSION
#vm-0-9-ubuntu   NotReady   control-plane   4m58s   v1.30.0
#如果想改名字可以用hostnamectl

sha256_str=`openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'`
#token 24小时过期
token_str=`kubeadm token create`
echo "使用以下命令让worker节点加入:"
echo "kubeadm join $ip_str:6443 --token $token_str \
      --discovery-token-ca-cert-hash sha256:$sha256_str"