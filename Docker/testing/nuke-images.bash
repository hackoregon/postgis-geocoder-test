#! /bin/bash

echo "Deleting all local images!!"
docker rmi `docker images -aq`
