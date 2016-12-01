FROM tomcat:latest

RUN wget  http://10.0.7.107:8082/remote.php/webdav/iam/iam-rest-maven-1.0.war?downloadStartSecret=sy7fhxt1vkr5yd0zdfb027qfr --http-user=kevin --http-password=kevin -O iam-rest-maven-1.0.war
RUN unzip iam-rest-maven-1.0.war -d /usr/local/tomcat/webapps/iam/ 

