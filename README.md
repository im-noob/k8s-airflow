helm uninstall airflow --namespace airflow && helm install airflow apache-airflow/airflow --namespace airflow -f airflow-values.yaml  --debug

kubectl apply -f airflow-requirements-configmap.yaml
