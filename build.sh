#!/bin/bash

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
  docker stop $CID
  docker rm $CID
fi

#挂载jdbc.properties文件，动态配置数据源
docker run -d -p 10040:8080 -v /var/owncloud/data/kevin/files/iam/jdbc.properties:/usr/local/tomcat/webapps/iam/WEB-INF/classes/jdbc.properties -v /var/owncloud/data/kevin/files/iam/datasource.xml:/usr/local/tomcat/webapps/iam/WEB-INF/spring/datasource.xml iam

