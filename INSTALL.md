
# Preperation

## k8s

Install `minikube` and fetch the binary of `helm`.

## minikube
```bash
minikube start --memory 8192 --cpus 4
minikube kubectl -- get pods -A
minikube addons enable metrics-server
minikube dashboard
```

## Prometheus stack
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-comm prometheus-community/kube-prometheus-stack
```


## spark-operator

Install the `spark-operator` from the GCP repository using `helm`:

```bash
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

```

```bash
helm install my-release spark-operator/spark-operator --namespace spark-operator --create-namespace --set webhook.enable=true --set sparkJobNamespace=default
```


```bash
minikube kubectl -- create serviceaccount spark --namespace=default
minikube kubectl -- create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default
```


## Prometheus <> JMX
```bash
minikube kubectl -- apply -f deploy/prometheus/spark.yaml
minikube kubectl -- apply -f deploy/prometheus/spark-service.yaml
minikube kubectl -- apply -f deploy/prometheus/servicemonitor-spark.yaml
```


# Submit a job

The currenct example uses a bare-basic `Dockerfile` to build a container image.
Feel free to update to match your needs but please don't forget to update the `image` field in the deployment file `deploy/spark/basic_pyspark_job.yaml`.

You may submit the spark job using the following command:

```bash
minikube kubectl -- apply -f deploy/spark/basic_pyspark_job.yaml
```
