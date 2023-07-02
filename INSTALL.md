
# Preperation

## k8s

Install `minikube` and fetch the binary of `helm`.

## spark-operator

Install the `spark-operator` from the GCP repository using `helm`:

```bash
helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator
```

```bash
helm install my-release spark-operator/spark-operator --namespace spark-operator --create-namespace --set webhook.enable=true
```


```bash
minikube kubectl -- create serviceaccount spark
minikube kubectl -- create clusterrolebinding spark-role --clusterrole=edit --serviceaccount=default:spark --namespace=default
```

## minio

You may use the provided deployment file under `deploy/minio` or from `helm`.

```bash
minikube kubectl -- apply -f deploy/minio/pvc.yaml
minikube kubectl -- apply -f deploy/minio/deployment.yaml
minikube kubectl -- apply -f deploy/minio/service.yaml
```

# Submit a job

The currenct example uses a bare-basic `Dockerfile` to build a container image.
Feel free to update to match your needs but please don't forget to update the `image` field in the deployment file `deploy/spark/basic_pyspark_job.yaml`.

You may submit the spark job using the following command:

```bash
minikube kubectl -- apply -f deploy/spark/basic_pyspark_job.yaml
```
