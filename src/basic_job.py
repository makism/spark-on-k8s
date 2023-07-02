from pyspark.sql import SparkSession


if __name__ == "__main__":
    spark = SparkSession.builder.appName("PySpark-on-K8s").getOrCreate()

    sc = spark.sparkContext
    sc.setLogLevel("WARN")

    spark.stop()
