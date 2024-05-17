#!/bin/bash
set -ex

# 提交任务
kubectl apply -f hello-job.yaml

# 你可以查看任务的状态
kubectl describe job hello

# kubectl logs job/hello
kubectl logs job/hello