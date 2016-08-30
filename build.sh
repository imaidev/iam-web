#!/bin/bash

echo '>>> Get old container id'

CID=$(docker ps | grep "iam" | awk '{print $1}')
echo $CID

sudo docker build -t iam .

touch /dockerlogs/iam-build.log

docker build -t iam . | tee /dockerlogs/iam-build.log
RESULT=$(cat /dockerlogs/iam-build.log | tail -n 1)
if [["$RESULT" != *Successfully*]];then
  exit -1
fi
 
if [ "$CID" != "" ];then
  echo '>>> Stop and remove old container'
  docker stop $CID
  docker rm $CID
fi

echo '>>> Starting new container'
docker run -d -p 10040:8080 iam
