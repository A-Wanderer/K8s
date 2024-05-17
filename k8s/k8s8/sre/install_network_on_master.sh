#!/bin/bash
set -ex

# 如果报错The DaemonSet "kube-flannel-ds" is invalid: spec.selector:  Invalid value
# 就执行  kubectl delete daemonset kube-flannel-ds -n kube-flannel
kubectl apply -f kube-flannel.yml
kubectl get pods -n kube-system

sudo bash -c 'cat << EOF >> /etc/sysconfig/flannel
FLANNEL_OPTIONS="--iface=eth0"
EOF'

sudo bash -c 'cat << EOF > /etc/sysconfig/flannel-config
FLANNEL_NETWORK=10.244.0.0/16
FLANNEL_SUBNET=10.244.0.1/24
FLANNEL_MTU=1450
EOF'

# 允许master调度pod,生产环境下最好不要
# kubectl taint nodes --all node-role.kubernetes.io/control-plane