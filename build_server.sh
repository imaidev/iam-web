#!/bin/bash

mkdir iam

copy Dockerfile_server iam/Dockerfile

cd iam

wget https://dev.imaicloud.com/files/comic/IAM-war/iam.war

sudo docker build -t iam .
