FROM spark:3.4.1-scala2.12-java11-python3-ubuntu

USER root

ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.11.0/jmx_prometheus_javaagent-0.11.0.jar /prometheus/
RUN chmod 644 /prometheus/jmx_prometheus_javaagent-0.11.0.jar


RUN pip install prometheus_client

RUN mkdir -p /etc/metrics/conf
COPY conf/metrics.properties /etc/metrics/conf
COPY conf/prometheus.yaml /etc/metrics/conf


WORKDIR /opt/project/
COPY src/basic_job.py /opt/project/

ENTRYPOINT ["/opt/entrypoint.sh"]
