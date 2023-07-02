FROM gcr.io/spark-operator/spark-py:v3.1.1

WORKDIR /opt/project/

COPY src/basic_job.py /opt/project/
