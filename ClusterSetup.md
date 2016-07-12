# Apache Spark cluster set up

To understand different types of Spark Cluster, see the documentation here on <a href = 'http://spark.apache.org/docs/latest/cluster-overview.html' target='_blank'>Cluster Mode Overview</a>.

### Setting up a Stand Alone Spark cluster.

Official documentation can be found <a href="http://spark.apache.org/docs/latest/spark-standalone.html" target=_blank>here</a>.

Follow these steps:
1. On the master node, change directory to spark home, and run
        ./sbin/start-master.sh
   You can now view the web UI on `http://<node IP>:8080`. On this UI, you will see `spark://HOST:PORT` URL which can be used to connect to worker nodes, or to pass as an argument to `SparkContext`.
2. On the worker nodes, run
        ./sbin/start-slave.sh <master-spark-URL>
   Once you have started a worker, look at the master’s web UI (http://localhost:8080 by default). You should see the new node listed there, along with its number of CPUs and memory (minus one gigabyte left for the OS).


### launching an application on the cluster.
To launch applications on a cluster, see [Submitting Applications page](http://spark.apache.org/docs/latest/submitting-applications.html).
