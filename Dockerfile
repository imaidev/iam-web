FROM tomcat7-jre8:latest

ADD iam-front/ /tomcat/webapps/iam-web/

ADD iam-rest /tomcat/webapps/iam-web/
