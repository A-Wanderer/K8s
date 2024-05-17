#!/bin/bash
set -ex

kubectl apply -f nvidia-device-plugin.yml
#  kubectl  get pod -n kube-system  | grep nvidia-device-plugin
#  kubectl describe pod nvidia-device-plugin-daemonset-lv9j6  -n kube-system