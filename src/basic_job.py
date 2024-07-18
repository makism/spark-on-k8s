from pyspark.sql import SparkSession

if __name__ == "__main__":
    spark = SparkSession.builder.appName("PySpark-on-K8s").getOrCreate()

    sc = spark.sparkContext
    sc.setLogLevel("WARN")

    from prometheus_client import CollectorRegistry, Counter, push_to_gateway

    registry = CollectorRegistry()
    g = Counter(
        "spark_custom_metric_TEST", "Description of custom metric", registry=registry
    )

    def update_metrics(value):
        g.inc(1)
        # Push metrics to Prometheus Pushgateway if needed
        push_to_gateway(
            "my-prometheus-pushgateway:9091",
            job="spark",
            registry=registry,
            # "my-prometheus-pushgateway.default.svc.cluster.local:9091", job="spark", registry=registry
        )

    update_metrics(1)

    spark.stop()
