FROM tomcat7-jre8:latest

RUN yum install wget -y
RUN wget https://dev.imaicloud.com/files/comic/IAM-war/iam.war
ADD iam.war -d /tomcat/webapps//

