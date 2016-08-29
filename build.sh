#!/bin/bash

mkdir iam

cp Dockerfile_server iam/Dockerfile

cd iam

wget https://dev.imaicloud.com/files/comic/IAM-war/iam.war

sudo jar -xvf iam.war

echo 'dataSource.driverClassName=org.gjt.mm.mysql.Driver' > WEB-INF/classes/datasource.properties
echo 'dataSource.url=jdbc:mysql://10.0.7.107:3306/iam?useUnicode=true&characterEncoding=utf-8&useOldAliasMetadataBehavior=true&allowMultiQueries=true' >> WEB-INF/classes/datasource.properties
echo 'dataSource.username=root' >> WEB-INF/classes/datasource.properties
echo 'dataSource.password=root' >> WEB-INF/classes/datasource.properties

sudo docker build -t iam .

echo '>>> Get old container id'

CID=$(docker ps | grep "iam" | awk '{print $1}')
echo $CID

docker build -t iam . | tee /dockerlogs/iam-build.log
RESULT=$(cat /dockerlogs/iam-build.log | tail -n 1)
#if [["$RESULT" != *Successfully*]];then
#  exit -1
#fi
 
if [ "$CID" != "" ];then
  echo '>>> Stopping old container'
  docker stop $CID
  docker rm $CID
fi

echo '>>> Starting new container'
docker run -d -p 10040:8080 iam
