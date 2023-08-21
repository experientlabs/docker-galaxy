


### Build Image using Dockerfile
To build the Docker image, navigate to the directory containing the Dockerfile and run the following command:

```docker build -t my-docker-image .```


Once the image is built, you can run a container based on this image using the following command:

```docker run -it my-docker-image```


### Build Image using docker-compose
To start the container using docker-compose, navigate to the directory containing the docker-compose.yml file and run the following command:

```
docker-compose up
```
This will build the image (if it hasn't been built already) and start a container based on the configuration specified in docker-compose.yml. You should see the output of the container in your console.

If you make any changes to the Dockerfile or source code, you can run docker-compose up --build to rebuild the image and start the container with the updated code.

```
docker-compose up --build
```