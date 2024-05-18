#!/bin/bash
set -ex

yum install git
git clone https://github.com/shikanon/kubeflow-manifests.git
cd kubeflow-manifests
python3 install.py
kubectl get pod -n kubeflow
