FROM gcr.io/spark-operator/spark-py:v3.1.1

WORKDIR /opt/spark-jars/
COPY jmx_prometheus_javaagent-0.11.0.jar /opt/spark-jars/

WORKDIR /opt/prometheus
COPY metrics.properties /opt/prometheus/

WORKDIR /opt/project/
COPY src/basic_job.py /opt/project/
