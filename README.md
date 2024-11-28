
# Built the image
docker build -t custom-airflow:latest .


docker tag custom-airflow:latest aaravonly4you/custom-airflow:latest
docker push aaravonly4you/custom-airflow:latest

docker run -it aaravonly4you/custom-airflow:latest /bin/bash

pip list | grep 'fuzz'

# Delete old name space
helm uninstall airflow --namespace airflow

<!-- # Apply Configmap
kubectl apply -f airflow-requirements-configmap.yaml -->

# Create airflow namespace
helm install airflow apache-airflow/airflow -n airflow -f airflow-values.yaml  --debug
helm install airflow airflow-stable/airflow -f values 

helm upgrade --install airflow apache-airflow/airflow -n airflow -f airflow-values.yaml  --debug

kubectl apply -f trigger-pvc.yaml -n airflow
kubectl delete pvc triggerer-data-pvc -n airflow

* kubectl get pods -n airflow
* kubectl exec -it airflow-redis-0 -n airflow -- /bin/bash
* kubectl exec -it airflow-scheduler-69867d8f7b-d4kzj -n airflow -- /bin/bash
* kubectl exec -it airflow-triggerer-0 -n airflow -- /bin/bash
* kubectl logs -f airflow-webserver-667cd97789-tjtjk -n airflow
* kubectl describe pod airflow-webserver-667cd97789-tjtjk -n airflow | grep airflow-requirements
* docker run -it custom-airflow:latest /bin/bash

# Setup 
#mininkube
#alias kubectl="minikube kubectl --"
#export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

export KUBECONFIG=~/.kube/config

# to add files here 

    mkdir ~/.kube 2> /dev/null
    sudo k3s kubectl config view --raw > "$KUBECONFIG"
    chmod 600 "$KUBECONFIG"


# Creating job

    kubectl delete job airflow-install-dependencies -n airflow
    kubectl apply -f airflow-install-requirements-job.yaml
    kubectl logs job/airflow-install-dependencies -n airflow
    