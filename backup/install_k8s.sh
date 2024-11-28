sudo apt update && sudo apt upgrade -y
sudo apt install -y apt-transport-https ca-certificates curl

sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

sudo apt install -y containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


kubeadm version
kubectl version --client


sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml


#sudo kubeadm join <master-node-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
#sudo kubeadm join 192.168.0.19:6443 --token pr2tb9.nwu8ehbfpz6qf9ld --discovery-token-ca-cert-hash sha256:90df15b2b5185f5d38bbe272717fcb065c3579999f99aef7fd45ed105a58a82b 

kubectl get nodes
kubectl get pods --all-namespaces
