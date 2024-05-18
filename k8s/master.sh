#!/bin/bash
set -ex

bash install_k8s.sh
bash start_k8s_master.sh
cd sre
bash install_network_on_master.sh
echo "还需要等worker加入后执行："
echo "cd k8s-gpu && bash install_operator_on_master.sh"
echo "cd ../tf && bash install_tf_operator.sh"
echo "cd ../dashboard && bash submit_on_master.sh"