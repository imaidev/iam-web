#!/bin/bash

echo '>>> Get old container id'

CID=$(sudo docker ps | grep "iam" | awk '{print $1}')
echo $CID

sudo touch /dockerlogs/iam-build.log

sudo docker build -t iam . | tee /dockerlogs/iam-build.log

RESULT=$(cat /dockerlogs/iam-build.log | tail -n 1)
if [["$RESULT" != *Successfully*]];then
  exit -1
fi
 
if [ "$CID" != "" ];then
  echo '>>> Stop and remove old container'
  sudo docker stop $CID
  sudo docker rm $CID
fi

echo '>>> Starting new container'
sudo docker run -d -p 10040:8080 iam
