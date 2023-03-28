#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install tmux curl golang-cfssl -y

K8S_VERSION=1.26.3
ETCD_VERSION=3.5.7
CONTAINERD_VERSION=1.7.0
RUNC_VERSION=1.1.4
ARCH=amd64

# YOLO
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

curl -L https://dl.k8s.io/v${K8S_VERSION}/kubernetes-server-linux-${ARCH}.tar.gz -o kubernetes-server-linux-${ARCH}.tar.gz
tar -zxf kubernetes-server-linux-${ARCH}.tar.gz
for BINARY in kubectl kube-apiserver kube-scheduler kube-controller-manager kubelet kube-proxy;
do
  mv kubernetes/server/bin/${BINARY} .
done
rm kubernetes-server-linux-${ARCH}.tar.gz
rm -rf kubernetes

curl -L https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-${ARCH}.tar.gz | 
  tar --strip-components=1 --wildcards -zx '*/etcd' '*/etcdctl'

mkdir etcd-data
chmod 700 etcd-data

wget https://github.com/containerd/containerd/releases/download/v${CONTAINERD_VERSION}/containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz
tar --strip-components=1 --wildcards -zx '*/ctr' '*/containerd' '*/containerd-shim-runc-v2' -f containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz
rm containerd-${CONTAINERD_VERSION}-linux-${ARCH}.tar.gz

curl https://github.com/opencontainers/runc/releases/download/v${RUNC_VERSION}/runc.${ARCH} -L -o runc
chmod +x runc
sudo mv runc /usr/bin/

sudo mv kubectl /usr/local/bin