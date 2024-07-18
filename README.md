
# Preperation

## k8s

Install `minikube` and fetch the binary of `helm`.

## minikube
```bash
minikube start --memory 8192 --cpus 4
minikube kubectl -- get pods -A
minikube dashboard
```

## Prometheus stack
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus-comm prometheus-community/kube-prometheus-stack -f helms/prometheus.yaml
```

```bash
minikube kubectl -- get secret prometheus-comm-grafana -o json | jq '.data | map_values(@base64d)'
```

```bash
minikube kubectl -- port-forward -n default svc/prometheus-comm-grafana 9080:80
```



## spark-operator

Install the `spark-operator` from the helm chart repository:

```bash
helm repo add spark-operator https://kubeflow.github.io/spark-operator
helm install spark-operator spark-operator/spark-operator \
    --namespace spark-operator \
    --create-namespacec
```

```bash
minikube kubectl -- create serviceaccount spark --namespace=default
minikube kubectl -- create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default
```


## Prometheus ↔️ JMX
```bash
minikube kubectl -- apply -f deploy/prometheus/
```

## Pushgateway

```bash
minikube kubectl -- apply -f deploy/pushgateway/
```

# Submit a job

The currenct example uses a bare-basic `Dockerfile` to build a container image.
Feel free to update to match your needs but please don't forget to update the `image` field in the deployment file `deploy/spark/basic_pyspark_job.yaml`.

You may submit the spark job using the following command:

```bash
minikube kubectl -- apply -f deploy/spark/basic_pyspark_job.yaml
```

