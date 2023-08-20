# Kafka in Docker


In order to download the kafka zip/archive, we are using a separate shell script file and calling it from Dockerfile 
in this example. This is different from spark docker file where we download the archive  

This line below pokes apache url to get `preferred path info` and then downloads jar from preferred path info. 
```
url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/kafka/${KAFKA_VERSION}/${FILENAME}&as_json=1" | jq -r '"\(.preferred)\(.path_info)"')
```



### Building and Running container using Docker Commands

To build the container, run below command:
```
docker build -t experient-labs/kafka .

```

The docker run command in start-kafka-shell script mounts docker.sock file. Explore more about it.
```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -e HOST_IP=$1 -e ZK=$2 -i -t experient-labs/kafka /bin/bash
```





REFERENCE
https://github.com/confluentinc/kafka-images
https://github.com/bitnami/containers/tree/main/bitnami/kafka
