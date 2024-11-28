sudo kubeadm reset -f

kubectl delete --all namespaces


sudo rm -rf /etc/cni/net.d
sudo rm -rf /var/lib/etcd
sudo rm -rf /var/etcd
sudo rm -rf ~/.kube
sudo rm -rf /var/lib/kubelet
sudo rm -rf /var/lib/dockershim
sudo rm -rf /etc/kubernetes
sudo rm -rf /var/run/kubernetes
sudo rm -rf /var/lib/cni


ip link delete cni0
ip link delete flannel.1

sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube* -y
sudo apt-get autoremove -y


sudo apt-get purge docker-ce docker-ce-cli containerd.io -y
sudo apt-get autoremove -y

sudo reboot
