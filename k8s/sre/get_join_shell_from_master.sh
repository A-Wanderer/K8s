#!/bin/bash
set -ex

ip_str=$1
sha256_str=`openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | \
   openssl dgst -sha256 -hex | sed 's/^.* //'`
#token 24小时过期
token_str=`kubeadm token create`
echo "使用以下命令让worker节点加入:"
echo "kubeadm join $ip_str:6443 --token $token_str \
      --discovery-token-ca-cert-hash sha256:$sha256_str"
