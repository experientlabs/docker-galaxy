# Linux Container: Debian on Docker
This directory contains a slim debian linux container built for the purpose of practicing linux commands.

https://github.com/SoftInstigate/serverless-docker

![Painting_ debian.png](..%2Fresources%2FPainting_%20debian.png)


### To build the docker image from docker file:
Go to the `linux-container` directory and fire the `docker build` command as given below:
```
docker build -t debian-slim-with-sam .
```
### To Run the docker Container:
Fire the `docker run` command as given below
```
docker run -d -it --rm debian-slim-with-sam
```

```
hostfolder="$(pwd)"
dockerfolder="/home/sam/app"
docker run -d --rm -it \
    -p 4040:4040 -v ${hostfolder}/app:${dockerfolder} \ 
    docker-spark-single-node:latest
```
Here:
- `-d` refers to detached mode.
- `-it` refers to interactive and tty (shell).
- `--rm` refers to remove the container after it exits. 

```
docker run -d --rm -it -v ${pwd}/app:"/home/sam/app" debian-slim-with-sam

```