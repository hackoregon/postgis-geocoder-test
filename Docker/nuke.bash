#! /bin/bash

docker kill `docker ps -aq`
docker rm `docker ps -aq`
docker rmi `docker images -aq`
