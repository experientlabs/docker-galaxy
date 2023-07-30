#!/bin/bash

docker build --no-cache . -t experient_labs/deb_linux_container
docker tag experient_labs/deb_linux_container:latest softinstigate/deb_linux_container:latest