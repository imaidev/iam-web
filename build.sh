#!/bin/bash
 
#1 创建构建日志文件
buildlog=/var/owncloud/data/kevin/files/iam/logs/build.log
touch $buildlog
 
#2 获取已经在运行的iam的container ID
CID=$(docker ps | grep "iam" | awk '{print $1}')
echo "正在运行的iam容器ID$CID" >> $buildlog

#3 构建image
docker build -t iam . | tee -a $buildlog
RESULT=$(cat $buildlog | tail -n 1)
if [["$RESULT" != *Successfully*]];then
#4 构建image失败，跳出脚本
  exit -1
fi

#5 停止并删除正在运行的iam container
if [ "$CID" != "" ];then
  echo '>>停止正在运行的iam容器' >> $buildlog
  docker stop $CID | tee -a $buildlog
  echo '>>删除正在运行的iam容器' >> $buildlog
  docker rm $CID | tee -a $buildlog
fi
 
#6 运行构建好的iam image
#挂载jdbc.properties文件，动态配置数据源
docker run -d -p 10040:8080 -v /var/owncloud/data/kevin/files/iam/jdbc.properties:/usr/local/tomcat/webapps/iam/WEB-INF/classes/jdbc.properties -v /var/owncloud/data/kevin/files/iam/datasource.xml:/usr/local/tomcat/webapps/iam/WEB-INF/spring/datasource.xml iam | tee -a $buildlog
