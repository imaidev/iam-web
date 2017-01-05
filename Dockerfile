FROM tomcat:latest
 
RUN wget  http://10.0.7.107:8082/remote.php/webdav/iam/iam.war --http-user=kevin --http-password=kevin -O iam.war
RUN unzip iam.war -d /usr/local/tomcat/webapps/iam/ 
