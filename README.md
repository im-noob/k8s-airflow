
# Built the image
docker build -t custom-airflow:latest .


docker tag custom-airflow:latest aaravonly4you/custom-airflow:latest
docker push aaravonly4you/custom-airflow:latest

docker run -it --entrypoint /bin/bash aaravonly4you/custom-airflow:latest

pip list | grep 'fuzz'

# Delete old name space

    helm uninstall airflow --namespace airflow
    kubectl delete pvc --all --all-namespaces
    kubectl delete pv --all
    kubectl apply -f airflow-shared-data-pvc.yaml -n airflow
    kubectl apply -f airflow-trigger-pvc.yaml -n airflow
    helm install airflow apache-airflow/airflow -n airflow -f airflow-values.yaml  --debug
    kubectl get pvc -n airflow
    kubectl get pv -n airflow


kubectl apply -f airflow-requirements-configmap.yaml

# Create airflow namespace
helm install airflow apache-airflow/airflow -n airflow -f airflow-values.yaml  --debug --timeout 10m
helm install airflow airflow-stable/airflow -f values 

helm upgrade --install airflow apache-airflow/airflow -n airflow -f airflow-values.yaml  --debug

kubectl apply -f trigger-pvc.yaml -n airflow
kubectl delete pvc triggerer-data-pvc -n airflow

* kubectl describe pod airflow-triggerer-66c699b9c7-bjkc9 --namespace airflow
* kubectl get pods -n airflow
* kubectl exec -it airflow-redis-0 -n airflow -- /bin/bash
* kubectl exec -it airflow-scheduler-69867d8f7b-d4kzj -n airflow -- /bin/bash
* kubectl exec -it airflow-triggerer-0 -n airflow -- /bin/bash
* kubectl logs -f airflow-scheduler-667f478d7d-9g29j -n airflow
* kubectl describe pod airflow-webserver-667cd97789-tjtjk -n airflow | grep airflow-requirements
* docker run -it custom-airflow:latest /bin/bash
kubectl exec -it airflow-scheduler-667f478d7d-9g29j -c git-sync -n airflow -- /bin/bash

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
    
# Deleting Everything

    kubectl delete all --all --all-namespaces
    kubectl delete pvc --all --all-namespaces
    kubectl delete pv --all

# uninstall k3s
sudo systemctl stop k3s
/usr/local/bin/k3s-uninstall.sh
sudo rm -rf /etc/rancher/k3s
sudo rm -rf /var/lib/rancher/k3s
sudo rm -rf /var/lib/k3s
sudo rm -rf /var/log/k3s
sudo rm -rf /etc/k3s
sudo rm -rf ~/.kube
sudo rm -rf /etc/cni
sudo rm -rf /var/lib/cni
sudo rm /usr/local/bin/helm
rm -rf ~/.helm
rm -rf ~/.kube/helm


# Add key to secret

    kubectl create secret generic git-ssh-key --from-file=ssh-privatekey=/home/aarav/.ssh/id_ed25519 -n airflow
    kubectl logs airflow-triggerer-5884d69c4b-hf4r5 -c git-sync-init --namespace airflow
    kubectl exec -it airflow-triggerer-6b64b9b664-rlfg6 -c git-sync-init --namespace airflow -- /bin/sh
    kubectl describe secret git-ssh-key --namespace airflow
    kubectl get secret git-ssh-key --namespace airflow -o jsonpath="{.data.ssh-privatekey}" | base64 --decode

    kubectl apply -f airflow-ssh-secret.yaml --namespace airflow


# dags:
#   gitSync:
#     enabled: true
#     repo: git@bitbucket.org:amriteshonly4u/k8s-airflow.git # Bitbucket repo using SSH
#     branch: master                                         # Specify the branch
#     depth: 1                                               # Fetch only the latest commit
#     revision: HEAD                                         # Use the latest revision
#     subPath: dags                                          # Sync only the 'dags' folder
#     sshKeySecret: git-ssh-key                              # SSH key for authentication
#     sshKnownHosts: true
#     sshKnownHostsConfig: |
#       bitbucket.org ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIazEu89wgQZ4bqs3d63QSMzYVa0MuJ2e2gKTKqu+UUO


docker rm -f git-sync-test
docker run -it --name git-sync-test \
    -u 0 \
  -e GIT_SYNC_REPO=git@bitbucket.org:amriteshonly4u/k8s-airflow.git \
  -e GIT_SYNC_BRANCH=master \
  -e GIT_SYNC_REV=HEAD \
  -e GIT_SYNC_DEPTH=1 \
  -e GIT_SYNC_MAX_SYNC_FAILURES=3000 \
  -e GIT_SYNC_SSH=true \
  -e GIT_SYNC_SSH_KEY_FILE=/tmp/ssh-privatekey \
  -e GIT_SYNC_KNOWN_HOSTS=false \
  -e GIT_SYNC_PERIOD=5s \
  -v /home/aarav/.ssh/id_ed25519:/tmp/ssh-privatekey:ro \
  registry.k8s.io/git-sync/git-sync:v4.3.0 /bin/bash


dag = DAG('hello_world', description='Hello World DAG',
          schedule_interval='0 12 * * *',
          start_date=datetime(2022, 8, 24), catchup=False)

hello_operator = PythonOperator(task_id='hello_task', python_callable=print_hello, dag=dag)

hello_operator

# Localhost ansible

[local]
localhost ansible_connection=local

