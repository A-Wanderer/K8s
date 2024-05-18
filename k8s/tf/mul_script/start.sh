#!/bin/bash
set -ex
current_script="$0"
# 获取当前脚本的绝对路径
absolute_path="$(cd "$(dirname "$current_script")" && pwd)"

pip3 install tensorflow
python3 $absolute_path/test.py