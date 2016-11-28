FROM tomcat:latest

RUN wget -C=off http://10.0.7.107:8082/remote.php/webdav/iam/iam-rest.war?downloadStartSecret=sy7fhxt1vkr5yd0zdfb027qfr --http-user=kevin --http-password=kevin -O iam-rest.war
RUN unzip iam-rest.war -d /usr/local/tomcat/webapps/iam-rest/ 

