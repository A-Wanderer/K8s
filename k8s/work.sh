#!/bin/bash
set -ex

bash install_k8s.sh
cd sre
bash install_tool_on_gpu_worker.sh

echo "你还需要加入master"