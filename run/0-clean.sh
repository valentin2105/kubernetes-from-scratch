#!/bin/bash

sudo pkill containerd
sudo pkill etcd

rm -rf certs/
rm -rf etcd-data/
sudo rm -rf /var/lib/kubelet/
sudo rm -f /usr/bin/runc
sudo rm -f /usr/local/bin/kubectl
./cilium uninstall
sed -i '/kubectl completion bash/d' ~/.bashrc
