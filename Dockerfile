FROM tomcat:latest
 
RUN wget  http://10.0.7.107:8082/remote.php/webdav/iam/iam-rest.war --http-user=kevin --http-password=kevin -O iam-rest.war
RUN unzip iam-rest.war -d /usr/local/tomcat/webapps/iam/ 
