#!/bin/bash

figlet MASTER

echo "[TASK 2] Start master"
kubeadm init --ignore-preflight-errors all --pod-network-cidr=10.244.0.0/16 --token-ttl 0

echo "[TASK 3] Install Calico"
 kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml 


echo "[TASK 4] Display PODS"
kubectl get pods --all-namespaces


echo "[TASK 5] Install kubeconfig"
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[TASK 6] Install Dashboard"
kubectl apply -f kubernetes-dashboard.yaml
kubectl apply -f kubernetes-dashboard-rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "[TASK 7] Display All Services"
kubectl get services -n kube-system 


figlet NFS
apt-get install -y nfs-kernel-server
apt-get install -y nfs-common

mkdir -p /mnt/storage
cat >>/etc/hosts<<EOF
/mnt/storage *(rw,sync,no_root_squash,no_subtree_check)
EOF
systemctl restart nfs-kernel-server
exportfs -a
