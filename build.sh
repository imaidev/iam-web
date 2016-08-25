#!/bin/bash

echo '>>> Get old container id'

CID=$(docker ps | grep "iam-web" | awk '{print $1}')
echo $CID

docker build -t iam-web . | tee /dockerlogs/iam-web-build.log
RESULT=$(cat /dockerlogs/iam-web-build.log | tail -n 1)
#if [["$RESULT" != *Successfully*]];then
#  exit -1
#fi
 
if [ "$CID" != "" ];then
  echo '>>> Stopping old container'
  docker stop $CID
  docker rm $CID
fi

echo '>>> Starting new container'
docker run -d -p 10030:8080 iam-web
