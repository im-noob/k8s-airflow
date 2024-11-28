#ssh-keygen -t ed25519

# Updating repos
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget apt-transport-https git ca-certificates curl

# Add Docker's official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# installing Docker
sudo apt install -y  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

# installing k3s

curl -sfL https://get.k3s.io | sh -

kubectl get nodes

sudo ln -s /usr/local/bin/k3s /usr/local/bin/kubectl
kubectl version --client


sudo systemctl status k3s

# installing helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

echo 'export KUBECONFIG=~/.kube/config' >> ~/.bashrc
source ~/.bashrc
mkdir ~/.kube && sudo k3s kubectl config view --raw > "$KUBECONFIG" && chmod 600 "$KUBECONFIG"




# installing airflow


helm repo add apache-airflow https://airflow.apache.org
helm repo update

kubectl apply -f airflow-trigger-pvc.yaml -n airflow

kubectl create namespace airflow

helm install airflow apache-airflow/airflow --namespace airflow -f airflow-values.yaml --debug

kubectl get pods --namespace airflow

kubectl get all --namespace airflow