
# Built the image
docker build -t custom-airflow:latest .


docker tag custom-airflow:latest aaravonly4you/custom-airflow:latest
docker push aaravonly4you/custom-airflow:latest

docker run -it aaravonly4you/custom-airflow:latest /bin/bash

pip list | grep 'fuzz'

# Delete old name space
helm uninstall airflow --namespace airflow

# Apply Configmap
kubectl apply -f airflow-requirements-configmap.yaml

# Create airflow namespace
helm install airflow apache-airflow/airflow --namespace airflow -f airflow-values.yaml  --debug

kubectl get pods -n airflow
kubectl exec -it airflow-webserver-667cd97789-tjtjk -n airflow -- /bin/bash
kubectl exec -it airflow-triggerer-0 -n airflow -- /bin/bash
kubectl logs -f airflow-webserver-667cd97789-tjtjk -n airflow
kubectl describe pod airflow-webserver-667cd97789-tjtjk -n airflow | grep airflow-requirements
docker run -it custom-airflow:latest /bin/bash
# Setup 
#mininkube
#alias kubectl="minikube kubectl --"
#export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

export KUBECONFIG=~/.kube/config

# to add files here 
mkdir ~/.kube 2> /dev/null
sudo k3s kubectl config view --raw > "$KUBECONFIG"
chmod 600 "$KUBECONFIG"


